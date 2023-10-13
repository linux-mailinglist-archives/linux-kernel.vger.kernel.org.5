Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BAF7C8040
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 10:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230048AbjJMI34 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 04:29:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229743AbjJMI3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 04:29:55 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D15C691
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 01:29:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48BDBC433C7;
        Fri, 13 Oct 2023 08:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697185794;
        bh=RCn/bkiCVsdxFqN8EjpHIVfmHAlxke4AlEd/Z7mt+MU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=M0nO/G62fEhy5kL1LcgE5ZegjIur7dh6UnMx0rqg4uSXGkBWdf8ZydHR8tlteJ7FH
         eKy7b/zcPeI0xFDzX3AiQcunNQyhqmhNyGMCTEccudLsWA1/XEEZUhETqszFgpooa+
         LBbHR+i0Gu6uvETA5Tg7hRga8k1Q2S5Ru9IGofnGEJQl+lDppf5WuM5zg6IXvnGLcb
         Su26kpnZrJtmOYeF6meohRKKM5mn0L+aPnGFuvIj7DRgWu+04jHIgPnPxjh8luh6jf
         L8l+Y5Xkv/OmrP+y/tZjSePtweRcPTa8gPbMToqw89FbNKWpMQ6vHWbK3e4L/NXeec
         pUTh31BmNwwMQ==
Date:   Fri, 13 Oct 2023 09:29:48 +0100
From:   Will Deacon <will@kernel.org>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, catalin.marinas@arm.com,
        mark.rutland@arm.com, maz@kernel.org, anshuman.khandual@arm.com,
        krisman@suse.de, broonie@kernel.org, james.morse@arm.com,
        ionela.voinescu@arm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: cpufeature: Display the set of cores with a
 feature
Message-ID: <20231013082948.GA13431@willie-the-truck>
References: <20231013013016.197102-1-jeremy.linton@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013013016.197102-1-jeremy.linton@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 12, 2023 at 08:30:16PM -0500, Jeremy Linton wrote:
> The AMU feature can be enabled on a subset of the cores in a system.
> Because of that, it prints a message for each core as it is detected.
> This becomes tedious when there are hundreds of cores. Instead, for
> CPU features which can be enabled on a subset of the present cores,
> lets wait until update_cpu_capabilities() and print the subset of cores
> the feature was enabled on.
> 
> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
> ---
>  arch/arm64/include/asm/cpufeature.h |  2 ++
>  arch/arm64/kernel/cpufeature.c      | 16 +++++++++++++---
>  2 files changed, 15 insertions(+), 3 deletions(-)

That's pretty neat. Are there any other caps we could switch over to this
new mechanism as well? We have a weird bodge, for example, in has_hw_dbm()
to print a "detected: ..." message and I wonder whether following the
example of the AMU would be better?

Will
