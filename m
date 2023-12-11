Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69DA080C86B
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 12:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234658AbjLKLqt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 06:46:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234729AbjLKLqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 06:46:44 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4351FE4
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 03:46:51 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DC84C433C8;
        Mon, 11 Dec 2023 11:46:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702295210;
        bh=zok5xX1OP1JBLwsks2rLDSP5o/dPlt9Lm7Y9BmkQ62A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=FiUP88yS3tXlhk0c6uic6GYAqPRUcdiOZXIxG5NviwR4WPsfbfbMNCID1WZrbmUBu
         Hw6w25nX8M+90iRumlsy28NYhfnur0gRbhZ3s+2YpVc4yBqPS/sXcBuzVpzKlbnBJk
         +vm4d7cPgNGWlYPpufsiZQSN2RSC6l85eSZEi9Ky/SzwvhGdhaQQWiIA60smARCyBO
         JKw1guoblFXi58hVzWP0n3bhpNQPjXMGDGRSuNh/l5MRQ51UAD842SrrCUy8x6uZ8u
         qr4ACm81qJipMkLCLS0byuFnDFak92M7zAdEFBZfk49IHLQgIjm3ASwBoOTqIct+NZ
         5GGBsIFYhOp8A==
Date:   Mon, 11 Dec 2023 11:46:42 +0000
From:   Will Deacon <will@kernel.org>
To:     Mihai Carabas <mihai.carabas@oracle.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvm@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        catalin.marinas@arm.com, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, x86@kernel.org, hpa@zytor.com, pbonzini@redhat.com,
        wanpengli@tencent.com, vkuznets@redhat.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, akpm@linux-foundation.org,
        pmladek@suse.com, peterz@infradead.org, dianders@chromium.org,
        npiggin@gmail.com, rick.p.edgecombe@intel.com,
        joao.m.martins@oracle.com, juerg.haefliger@canonical.com,
        mic@digikod.net, arnd@arndb.de, ankur.a.arora@oracle.com
Subject: Re: [PATCH 7/7] cpuidle/poll_state: replace cpu_relax with
 smp_cond_load_relaxed
Message-ID: <20231211114642.GB24899@willie-the-truck>
References: <1700488898-12431-1-git-send-email-mihai.carabas@oracle.com>
 <1700488898-12431-8-git-send-email-mihai.carabas@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1700488898-12431-8-git-send-email-mihai.carabas@oracle.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 04:01:38PM +0200, Mihai Carabas wrote:
> cpu_relax on ARM64 does a simple "yield". Thus we replace it with
> smp_cond_load_relaxed which basically does a "wfe".
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Mihai Carabas <mihai.carabas@oracle.com>
> ---
>  drivers/cpuidle/poll_state.c | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/cpuidle/poll_state.c b/drivers/cpuidle/poll_state.c
> index 9b6d90a72601..440cd713e39a 100644
> --- a/drivers/cpuidle/poll_state.c
> +++ b/drivers/cpuidle/poll_state.c
> @@ -26,12 +26,16 @@ static int __cpuidle poll_idle(struct cpuidle_device *dev,
>  
>  		limit = cpuidle_poll_time(drv, dev);
>  
> -		while (!need_resched()) {
> -			cpu_relax();
> -			if (loop_count++ < POLL_IDLE_RELAX_COUNT)
> -				continue;
> -
> +		for (;;) {
>  			loop_count = 0;
> +
> +			smp_cond_load_relaxed(&current_thread_info()->flags,
> +					      (VAL & _TIF_NEED_RESCHED) ||
> +					      (loop_count++ >= POLL_IDLE_RELAX_COUNT));
> +
> +			if (loop_count < POLL_IDLE_RELAX_COUNT)
> +				break;
> +
>  			if (local_clock_noinstr() - time_start > limit) {
>  				dev->poll_time_limit = true;
>  				break;

Doesn't this make ARCH_HAS_CPU_RELAX a complete misnomer?

Will
