Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 754308079A9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 21:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379489AbjLFUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 15:43:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230326AbjLFUnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 15:43:45 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF1D698;
        Wed,  6 Dec 2023 12:43:51 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 12D1D40E00C6;
        Wed,  6 Dec 2023 20:43:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id m30YgIGcggVv; Wed,  6 Dec 2023 20:43:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701895427; bh=j+6bz83E2E5dhWoENXiIOXBWe60E3WSbl+pDFm9fzsk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LM4o/RoKTlfqVTgEMpR9zOTLNvLJSmCPkEQiJwkww8JbI83wwN5V1leOR33s2LgB0
         IU5UQFrwXGoLHoJ8/+d+j12OSsYdb3l1KUbbsF/NEjw+ltB6CZA6PSR5j2nAhbjn1i
         2iVk2ROUEoSSBFksKlMqB58zTz18ZxfJkzzgHKw62hNfTLJdpoX4z3CKmJ2D5s8tae
         LZz2McpBMV/ZlwUp9cVWZCHsc58tozR9Kyk/klayj60ydKVjVCbifDiCL/F8U65UQi
         4QxoJ5pKprtxf+6vPkIMceEb5HzuEGJYlVfNwZXw0XLOcJi0B/bAgPl9/AGg8d+Bog
         wTb1Qf7l4fR/J+U00gEoJhy/X+3cpef8CGimOKNh/cJAQbSaVL/z4HtcMGZa7qejQx
         eC0a9M+U8BsqnQu+6FPBop4xtCBDBuTt1qse4X9kYLHj2Iqk5tzPVjuW5EHoCf3sDF
         EJV0X72LClA8Hm4Zj9XdLr+xnrJoCAfObfBSsZnu7Nrhw/JYIkn8W4XMgTSEjzg7UM
         keG9P4keiRiFWlaA3QLnQlLwdz/0W05YiwTyynjqX1YbucPuiqrTDz4TulS/xxBS0J
         Za98XTVjJWzRDVLVrZAa53J8/kiAXZQZ9WjMslOeyclszZw2YjSll9AeqHMSKrVHWG
         z0QlPr2KYAJDJyHGCcJhlq0s=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 952EE40E00A9;
        Wed,  6 Dec 2023 20:43:07 +0000 (UTC)
Date:   Wed, 6 Dec 2023 21:42:55 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     Michael Roth <michael.roth@amd.com>
Cc:     kvm@vger.kernel.org, linux-coco@lists.linux.dev,
        linux-mm@kvack.org, linux-crypto@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        jroedel@suse.de, thomas.lendacky@amd.com, hpa@zytor.com,
        ardb@kernel.org, pbonzini@redhat.com, seanjc@google.com,
        vkuznets@redhat.com, jmattson@google.com, luto@kernel.org,
        dave.hansen@linux.intel.com, slp@redhat.com, pgonda@google.com,
        peterz@infradead.org, srinivas.pandruvada@linux.intel.com,
        rientjes@google.com, dovmurik@linux.ibm.com, tobin@ibm.com,
        vbabka@suse.cz, kirill@shutemov.name, ak@linux.intel.com,
        tony.luck@intel.com, marcorr@google.com,
        sathyanarayanan.kuppuswamy@linux.intel.com, alpergun@google.com,
        jarkko@kernel.org, ashish.kalra@amd.com, nikunj.dadhania@amd.com,
        pankaj.gupta@amd.com, liam.merwick@oracle.com, zhi.a.wang@intel.com
Subject: Re: [PATCH v10 16/50] x86/sev: Introduce snp leaked pages list
Message-ID: <20231206204255.GEZXDcz9yfyMiyYQ1H@fat_crate.local>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-17-michael.roth@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231016132819.1002933-17-michael.roth@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:27:45AM -0500, Michael Roth wrote:
> +	spin_lock(&snp_leaked_pages_list_lock);
> +	while (npages--) {
> +		/*
> +		 * Reuse the page's buddy list for chaining into the leaked
> +		 * pages list. This page should not be on a free list currently
> +		 * and is also unsafe to be added to a free list.
> +		 */
> +		list_add_tail(&page->buddy_list, &snp_leaked_pages_list);
> +		sev_dump_rmpentry(pfn);
> +		pfn++;
> +	}
> +	spin_unlock(&snp_leaked_pages_list_lock);
> +	atomic_long_inc(&snp_nr_leaked_pages);

How is this supposed to count?

You're leaking @npages as the function's parameter but are incrementing
snp_nr_leaked_pages only once?

Just make it a bog-normal unsigned long and increment it inside the
locked section.

Or do at the beginning of the function:

	atomic_long_add(npages, &snp_nr_leaked_pages);

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
