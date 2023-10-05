Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 225BB7BAF6D
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 01:58:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbjJEX6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 19:58:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjJEX6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 19:58:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0DBFA6
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 16:58:04 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E2C433C7;
        Thu,  5 Oct 2023 23:58:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696550284;
        bh=kBlVLaA21krd9feQ7wMSdSFAFLcQzCQ+AKkA/TdNdOU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ct7ocAOfWjlG6DCIpWt/ePGaFZd8HFmxofkP1LHqTGGa4RTbxQUXIqtescLvY4T+7
         RLIAp4R01fJhrNLnFOCb95kUfktCpCDK7XMXYHOGWV4qdlZh7a+79yCcmmvb22UMPn
         ryuyGiXDeovIincXVKzd5GA+1Bz0AVcSo957y1l54tqn6eKf/52pcrcphesdMPC8fb
         +xw2rZJ5cpMu3Od59YywJQ2eoBdeu3y7/oxL1//OlgN67lZAbIhELH8QO7ZszTN1UQ
         ojjtIq43ssJ56SVJNWFnDBDw2/dzW7FIr0g/R7wK6NWNPr1GcgV58pIyDixr4s+ZbU
         Be5x4NKX0k2wA==
Date:   Thu, 5 Oct 2023 16:58:02 -0700
From:   Josh Poimboeuf <jpoimboe@kernel.org>
To:     Aaron Plattner <aplattner@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 0/2] Fix objtool error reporting and handling of very
 long symbol names
Message-ID: <20231005235802.iura4jotkvpswrwa@treble>
References: <cover.1696355111.git.aplattner@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <cover.1696355111.git.aplattner@nvidia.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 05:08:17PM -0700, Aaron Plattner wrote:
> Two patches in this series:
> 
> First, when objtool encounters an error, it carefully propagates the return
> code all the way up to main(), which proceeds to ignore it and return 0 no
> matter what. This can cause problems with objtool to be missed because the
> overall build succeeds. This appears to be a regression in commit
> b51277eb9775c, which dropped a call to exit(ret) when a subcommand fails.
> 
> Fix that by returning the status code from main().

Note most objtool errors are currently ignored anyway, due to check()
unconditionally returning 0.  But as the patch mentions, it will indeed
fix early errors.

> Second, very long symbol names with .cold variants cause objtool to fail.
> This is due to using a small max length, which in turn is due to allocating
> on the stack. However, there is not actually a requirement to allocate on
> the stack in this (user space) code path, and in fact, the code is cleaner
> with this fix: MAX_NAME_LEN is gone and the ugly manual NULL termination
> is also removed.

One benefit of the stack array is that reusing it is more performant
than doing a bunch of allocations.  But this is only for cold symbols,
so the slowdown should (hopefully) be negligible.

I'll run it through some testing.  Thanks!

-- 
Josh
