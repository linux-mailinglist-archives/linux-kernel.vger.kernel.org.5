Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56DEC7BF5D5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:29:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442747AbjJJI3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:29:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442800AbjJJI2x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:28:53 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B03AC9;
        Tue, 10 Oct 2023 01:28:49 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 50F2A40E0187;
        Tue, 10 Oct 2023 08:28:47 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id jobyFDhhothj; Tue, 10 Oct 2023 08:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1696926525; bh=DYiV+Ej1tarfC6A9PK5bqkKaTuLXYHPLvB0ukzNjf98=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jRcQuJtnZglx2Sk9NaC7dZV11XzZ+MKNLUjw7z8fux0RAqVLiZOA8P1TyCQg0UGwH
         6/ShC1fHFmE+DFJZHe/8vei5LJCqvMSwQLssAp14S9lybecyjvxRO0C4xplzru86pi
         oXwbPWx0OugsqkoXze0bGjyn+hvDn0jjNNO0Q5EzxU/HXGrC24z905gR0v+Crj1YfR
         TFV9VbEcT2LaO/n/UeJTF2xGuTnVQ+KSxpT3j/pLZvjBsgxy4d/0VBBNT9k3W60C4M
         BGtstg7ypXHCj9rv49L5aTUQyIXGDta0aUcvmWBc01llmM9YoElgvJsOsF7yU+QdTF
         PK8fznCwexHjwbyEpkExR6/FTZa7JTKkEY1bzjDy7AZEW2nLzFfK/l/1+ZOT229Nks
         VEqwHIgPfyxeZ9zdGqfZRR3F7jsRanGs0gVYhg50xwAd0fetdeSY3NPqaIBZmS+WJY
         5vO87kJD58QRSzphSPhTCdDJgLXbi+tnhiMJtklsXHnhQI2VN+CADaChpakGVF4n1y
         bHF2sBOjTfaKcq1zOpUfFd022cL4nRxA5XUhIcqEh2FTBIbkYqfi5ygQvtt6DCqgr4
         2FpmPjFCYOdyVswOpKwdqegokRlo0PgQHdChCyE1N6jI1R5zBiT/byu5oB03hbL7OV
         HmOVC0x6r2tnLBVVsv2MNv5U=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 11AC540E01AD;
        Tue, 10 Oct 2023 08:28:37 +0000 (UTC)
Date:   Tue, 10 Oct 2023 10:28:36 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     x86@kernel.org, linux-edac@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        tony.luck@intel.com, naoya.horiguchi@nec.com,
        Youquan Song <youquan.song@intel.com>
Subject: Re: [PATCH RESEND v2] x86/mce: Set PG_hwpoison page flag to avoid
 the capture kernel panic
Message-ID: <20231010082836.GDZSULNGto0cPRPU26@fat_crate.local>
References: <20230914030539.1622477-1-zhiquan1.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230914030539.1622477-1-zhiquan1.li@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 11:05:39AM +0800, Zhiquan Li wrote:
> Kdump can exclude the HWPosion page to avoid touch the error page
> again, the prerequisite is the PG_hwpoison page flag is set.
> However, for some MCE fatal error cases, there is no opportunity
> to queue a task for calling memory_failure(), as a result,
> the capture kernel touches the error page again and panics.
> 
> Add function mce_set_page_hwpoison_now() which marks a page as
> HWPoison before kernel panic() for MCE error, so that the dump
> program can check and skip the error page and prevent the capture
> kernel panic.

This commit message should explain the full scenario, like you did in
your other reply.

Also explain how the poison flag is consumed by the kdump kernel and put
that in the comment below.

> [Tony: Changed TestSetPageHWPoison() to SetPageHWPoison()]
> 
> Co-developed-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Youquan Song <youquan.song@intel.com>
> Signed-off-by: Zhiquan Li <zhiquan1.li@intel.com>
> Signed-off-by: Tony Luck <tony.luck@intel.com>

What does Tony's SOB mean here?

If I read it correctly, it is him sending this patch now. But you're
sending it so you folks need to read up on SOB chains.

> Reviewed-by: Naoya Horiguchi <naoya.horiguchi@nec.com>
> 
> ---
> V2 RESEND notes:
> - No changes on this, just rebasing as v6.6-rc1 is out.
> - Added the tag from Naoya.
>   Link: https://lore.kernel.org/all/20230719211625.298785-1-tony.luck@intel.com/#t
> 
> Changes since V1:
> - Revised the commit message as per Naoya's suggestion.
> - Replaced "TODO" comment in code with comments based on mailing list
>   discussion on the lack of value in covering other page types.
>   Link: https://lore.kernel.org/all/20230127015030.30074-1-tony.luck@intel.com/
> ---
>  arch/x86/kernel/cpu/mce/core.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mce/core.c b/arch/x86/kernel/cpu/mce/core.c
> index 6f35f724cc14..2725698268f3 100644
> --- a/arch/x86/kernel/cpu/mce/core.c
> +++ b/arch/x86/kernel/cpu/mce/core.c
> @@ -156,6 +156,22 @@ void mce_unregister_decode_chain(struct notifier_block *nb)
>  }
>  EXPORT_SYMBOL_GPL(mce_unregister_decode_chain);
>  
> +/*
> + * Kdump can exclude the HWPosion page to avoid touch the error page again,
> + * the prerequisite is the PG_hwpoison page flag is set. However, for some
> + * MCE fatal error cases, there are no opportunity to queue a task
> + * for calling memory_failure(), as a result, the capture kernel panics.
> + * This function marks the page as HWPoison before kernel panic() for MCE.
> + */
> +static void mce_set_page_hwpoison_now(unsigned long pfn)
> +{
> +	struct page *p;
> +
> +	p = pfn_to_online_page(pfn);
> +	if (p)
> +		SetPageHWPoison(p);
> +}

there's no need for that function - just put everything...

> +
>  static void __print_mce(struct mce *m)
>  {
>  	pr_emerg(HW_ERR "CPU %d: Machine Check%s: %Lx Bank %d: %016Lx\n",
> @@ -286,6 +302,8 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>  	if (!fake_panic) {
>  		if (panic_timeout == 0)
>  			panic_timeout = mca_cfg.panic_timeout;
> +		if (final && (final->status & MCI_STATUS_ADDRV))
> +			mce_set_page_hwpoison_now(final->addr >> PAGE_SHIFT);

... here, along with the comment.

>  		panic(msg);
>  	} else
>  		pr_emerg(HW_ERR "Fake kernel panic: %s\n", msg);
> -- 

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
