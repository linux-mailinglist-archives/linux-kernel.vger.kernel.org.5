Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AB90773001
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 21:57:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbjHGT5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 15:57:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230081AbjHGT5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 15:57:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E51E79;
        Mon,  7 Aug 2023 12:57:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 21C35621C9;
        Mon,  7 Aug 2023 19:57:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C532C433C9;
        Mon,  7 Aug 2023 19:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691438254;
        bh=/KLEIKyjwsEPet8u+Ub8P/T6C7w6xQVG2e6RPBprgdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=NCyVp4lX53GndUAhAq3bayNffYV3a5z5Mg3Pf9DwLB6eYTcioBQdmOSuCJTDSXWIC
         I/ZD+o3DBUE5LPn+uL1ZJbjt6LjIqQ0Q2usKo3T1Emr7dWVikuYQZLPfXf6OH4dOhW
         2tZzRp7W1xPBnzVGpvtlkBxLe+wwUFXoS3X56+uNxzqj9kC+Wk6yIltmbBAC8MnghC
         RuCYzRxI9alHOi7De6BIcuZdW9zhRSBjb1pMvKykonDXMau7QitF7ohyW3Nj3u6sBH
         lYrEFx7p3ad0+SPI+C+Uc44Pm/TAsIAxOXefaJVwOn9R6rEFK3hptGn+20SkoVx0cv
         eiWqO101zHEvg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id EBB46404DF; Mon,  7 Aug 2023 16:57:31 -0300 (-03)
Date:   Mon, 7 Aug 2023 16:57:31 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Andi Kleen <ak@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Claire Jensen <cjense@google.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] perf stat: Don't display zero tool counts
Message-ID: <ZNFMqzSAfno/+BcV@kernel.org>
References: <20230801205452.3380578-1-irogers@google.com>
 <ZMwUI/YtEHsO3Cc8@kernel.org>
 <ZNEFt3w/wNCvdawF@tassilo>
 <ZNFJatDztFNS90d3@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNFJatDztFNS90d3@kernel.org>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 07, 2023 at 04:43:38PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Mon, Aug 07, 2023 at 07:54:47AM -0700, Andi Kleen escreveu:
> > On Thu, Aug 03, 2023 at 05:54:59PM -0300, Arnaldo Carvalho de Melo wrote:
> > > Em Tue, Aug 01, 2023 at 01:54:52PM -0700, Ian Rogers escreveu:
> > > > Skip zero counts for tool events.
> > > > 
> > > > Reported-by: Andi Kleen <ak@linux.intel.com>
> > > 
> > > Andi,
> > > 
> > > 	Have you tested this? Can we please have your Tested-by?
> > 
> > I thought I had sent it earlier?
> > 
> > Tested-by: Andi Kleen <ak@linux.intel.com>
> 
> Yeah, you did it, sorry, somehow I didn't notice.
> 
> Applying.

Would be good to have the original link with your report and to figure
out the cset that introduced the problem, so that we could have a Fixes
tag to help justifying getting this into 6.5.

- Arnaldo
