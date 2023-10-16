Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 428E37CA3A6
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 11:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232723AbjJPJMH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 05:12:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232459AbjJPJMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 05:12:01 -0400
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F307AB;
        Mon, 16 Oct 2023 02:12:00 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 619DB40E01AE;
        Mon, 16 Oct 2023 09:11:58 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id c1HIwxF4hm63; Mon, 16 Oct 2023 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697447516; bh=B/5m2LDGcJTLYhvP21qZnYB0nurPkDZJJTeElvG5iiA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=SggXxx+Js+dTFs2SJY+q5yeyjzTu6Henv1moBdNVvKPIa4BuQrncYJehG7C9kPCzG
         v4/lRnjulZQ4fjnYjGrFKXqSixtW4tqehsUq9mAyHt8FV2C6MPgORdD+m7YIAL93C9
         m5wAvybG07b0OeXNYgsbV4b+JJJtpgYn8cBth8H3MlRrK+d9WHUlGn41ShtgPvlNhR
         6/e4uqcCUkkU9qTn9kaXG4zYxOBByyWZ+6HLSBHHZ7ADnf9/K9R6xIua9oxXZcuOGt
         tC6vaqjTlqejpWmZ/rN+f84m1zmy16xwCsgnmeu/oOjfgpLFUKyF2dsgdPRZQlqiK5
         QnktOPWshxIkFj/YN8NLm57BGITI1NRqORasOGWdtdf1uKYSK5FQnq0OCY2IDSbI/H
         ga70CNt6w00dTlIF25PpHioYNqE1zZzkUAOzAREVyFH5wjdslcn+DaUjTfn30LWRi5
         UnCZmm6f5LA/2LMrnGo6dHn4oC53x85rtmtVKe57m9gqFyeFhIqfMxJRy4D13O7iii
         jYItTzxEUVKNKSy6GGgnIkIwbzdmfLudt/6RwMHiQ0FuhNlHEaG8lRCzIJ703lLDBX
         0rsArmihDTN9CSXkRumLiyKgTcM/qmRz0YmmSZk+oYhlSUp+S9/g1AgvuK3eqzzWbl
         1QpKB9ZHEqOHQJkjcji8jdSI=
Received: from zn.tnic (pd953036a.dip0.t-ipconnect.de [217.83.3.106])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 802E740E014B;
        Mon, 16 Oct 2023 09:11:48 +0000 (UTC)
Date:   Mon, 16 Oct 2023 11:11:43 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Zhiquan Li <zhiquan1.li@intel.com>
Cc:     "Luck, Tony" <tony.luck@intel.com>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-edac@vger.kernel.org" <linux-edac@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "patches@lists.linux.dev" <patches@lists.linux.dev>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "naoya.horiguchi@nec.com" <naoya.horiguchi@nec.com>
Subject: Re: [PATCH v3] x86/mce: Set PG_hwpoison page flag to avoid the
 capture kernel panic
Message-ID: <20231016091143.GCZSz+T1xFf5tCFi2w@fat_crate.local>
References: <20231014051754.3759099-1-zhiquan1.li@intel.com>
 <SJ1PR11MB6083A23BB89F4EE0F44B2794FCD1A@SJ1PR11MB6083.namprd11.prod.outlook.com>
 <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <233e17ac-0ae5-4392-a5e4-ab811a155805@intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 14, 2023 at 05:34:12PM +0800, Zhiquan Li wrote:
> Memory errors don't happen very often, especially the severity is fatal.
> However, in large-scale scenarios, such as data centers, it might still
> happen.  For some MCE fatal error cases, the kernel might call
> mce_panic() to terminate the production kernel directly, thus there is
> no opportunity to queue a task for calling memory_failure() which will
> try to make the kernel survive via memory failure handling.

You can't "make the kernel survive" if the error has been deemed
critical. That's mce_severity()'s job. If it grades the error's severity
wrongly and memory_failure() should run after all, then this is
a different story.

> @@ -286,6 +287,17 @@ static noinstr void mce_panic(const char *msg, struct mce *final, char *exp)
>  	if (!fake_panic) {
>  		if (panic_timeout == 0)
>  			panic_timeout = mca_cfg.panic_timeout;

This whole thing...

> +		/*
> +		 * Kdump can exclude the HWPoison page to avoid touching the error
> +		 * page again, the prerequisite is that the PG_hwpoison page flag is
> +		 * set.  However, for some MCE fatal error cases, there is no
> +		 * opportunity to queue a task for calling memory_failure(), and as a
> +		 * result, the capture kernel panics.  So mark the page as HWPoison
> +		 * before kernel panic() for MCE.
> +		 */
> +		p = pfn_to_online_page(final->addr >> PAGE_SHIFT);
> +		if (final && (final->status & MCI_STATUS_ADDRV) && p)
> +			SetPageHWPoison(p);

... needs to be inside:

	if (kexec_crash_loaded() {
		...
	}

otherwise it'll be useless work on the panic path.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
