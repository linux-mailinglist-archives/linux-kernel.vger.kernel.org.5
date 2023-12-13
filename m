Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F324C810D76
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 10:31:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233035AbjLMJbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 04:31:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbjLMJa5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 04:30:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C08D9A4
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 01:31:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A085C433C7;
        Wed, 13 Dec 2023 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702459862;
        bh=RfT+HyZlBrFmrD9bF0uzysYjggRfcTVD2hDTBx97azQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=E+wSfpP+zXKQ1yX2JYdqVSWuPTx0qd83yS2kmrP/IlJIgD78K/z2Ql/lwdae3v3R1
         ANOwICCDCkP14EWxNEMcdRHHFGNt2NasGhU2nxWvIs184l7dGJdWBE6motxv2GV15R
         7fezrUJ13hLW/mEsxZ2rmiAYLzzTn0tC1Rb3jcEchJ0VDo/nTmExiVRKQG5sFM0FSD
         shMkpIwI/TqhcfCoPpPpAoRdlBvh07Qba4HtanZgRKGLZvsC8bvDQWtTukwSPx9KaV
         nN0LO2eT9QV4VXANsvkt1Z+ylVZ8m4BXIo2F5ryFwpHzdN2sw19F9P+vJ4bi35q5Kc
         HbSglkY/HywmQ==
Date:   Wed, 13 Dec 2023 09:30:57 +0000
From:   Will Deacon <will@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>, james.clark@arm.com
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the arm-perf tree
Message-ID: <20231213093057.GA31075@willie-the-truck>
References: <20231213100931.12d9d85e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231213100931.12d9d85e@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen, [+James]

On Wed, Dec 13, 2023 at 10:09:31AM +1100, Stephen Rothwell wrote:
> After merging the arm-perf tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
> 
> In file included from drivers/perf/arm_dmc620_pmu.c:26:
> include/linux/perf/arm_pmu.h:15:10: fatal error: asm/cputype.h: No such file or directory
>    15 | #include <asm/cputype.h>
>       |          ^~~~~~~~~~~~~~~

Damn, I tested with allnoconfig, defconfig and allmodconfig before I pushed,
but only for ARCH=arm64. Thanks for reporting this.

> I can't easily tell what caused this - possibly commit
> 
>   a5f4ca68f348 ("perf/arm_dmc620: Remove duplicate format attribute #defines")
> 
> I have used the arm-perf and arm64 trees from next-20231212 for today
> (since the arm64 tree merged the arm-perf tree).

That looks likely. I'll try reverting it and see if it resolves the problem
locally.

Cheers,

Will
