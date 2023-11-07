Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64A4C7E49D0
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 21:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234720AbjKGU2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 15:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234215AbjKGU2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 15:28:51 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 209BB10D0;
        Tue,  7 Nov 2023 12:28:49 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 0A09740E0192;
        Tue,  7 Nov 2023 20:28:46 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id UaF3s4xZRiN9; Tue,  7 Nov 2023 20:28:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1699388923; bh=D1AOnodvSAeHKdK51GuEmjvSdMbLjI6XL/dvvveTUuc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UF8gBcsqmQg7yr0n+/mI3nYpyr0kPLOu1iGxkvrKz8xCx8puKxZfvs2hkj4DPvwST
         Y2sbrNyYowiT2thhcpZMMgO9QPGF65dWCoZ2yqfjI1dFz1R0OHiOSCv4eJRombMmUm
         YGb6L3QVAW4OzJDbP0H4jrYmfzts8R34+u3hSh/dBomrsZL2h+ViOGdCNDIxzkAV/r
         8TTwo+TGmxAdtisAd4v6QOsJSYp/OCS/8cCCHIcCxc40q2e6pkl8JBQFMRqMvYLZyi
         xDBkBIuR1t/6RX+QNJh0pDFjmT4rnkpex/HeXO/qly0M2xa7yc8i/3SLM4p+gazB2A
         /9jTJ85EsIJSP0COuBp4hhO6ilsfYihP9gfgyZNFYQ50Lj7YY3PMqSUiy0HSxG1uZf
         lc1O+T9WXKMK1N3WIfmUh/18NYkZSiW2ho1EZT6nA7GQps01r6EgW7UWuIVmlnqy3U
         7305R90fOPj6+JfVUJu/yOGPzfSHf6YhYA7onfM86bjI5G7M38HZMTaccXkHvYhZTQ
         OOISofDfzua+NUwykAoQ11MNYMGuWqZw5yHh6gG7OKXEyLlJ9rbXL0I9ADVTKW/bqj
         EtmuUjN4550UzGt8d7oLIt8RAhwdn1kh2aaKgs2LW8yLp2OuQvABTD7pGeHTazZtt6
         ATn+Zb67pytmJ8V4ka6ju3O4=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 8645940E0176;
        Tue,  7 Nov 2023 20:28:02 +0000 (UTC)
Date:   Tue, 7 Nov 2023 21:27:57 +0100
From:   Borislav Petkov <bp@alien8.de>
To:     "Kalra, Ashish" <ashish.kalra@amd.com>
Cc:     Michael Roth <michael.roth@amd.com>, kvm@vger.kernel.org,
        linux-coco@lists.linux.dev, linux-mm@kvack.org,
        linux-crypto@vger.kernel.org, x86@kernel.org,
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
        jarkko@kernel.org, nikunj.dadhania@amd.com, pankaj.gupta@amd.com,
        liam.merwick@oracle.com, zhi.a.wang@intel.com,
        Brijesh Singh <brijesh.singh@amd.com>
Subject: Re: [PATCH v10 06/50] x86/sev: Add the host SEV-SNP initialization
 support
Message-ID: <20231107202757.GEZUqdzYyzVBHTBhZX@fat_crate.local>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-7-michael.roth@amd.com>
 <20231107163142.GAZUpmbt/i3himIf+E@fat_crate.local>
 <4a2016d6-dc1f-ff68-9827-0b72b7c8eac2@amd.com>
 <20231107191931.GCZUqNwxP8JcSbjZ0/@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231107191931.GCZUqNwxP8JcSbjZ0/@fat_crate.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 08:19:31PM +0100, Borislav Petkov wrote:
> Arch code does not call drivers - arch code sets up the arch and
> provides facilities which the drivers use.

IOW (just an example diff):

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 1c9924de607a..00cdbc844961 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -3290,6 +3290,7 @@ static int __init state_next(void)
 		break;
 	case IOMMU_ENABLED:
 		register_syscore_ops(&amd_iommu_syscore_ops);
+		amd_iommu_snp_enable();
 		ret = amd_iommu_init_pci();
 		init_state = ret ? IOMMU_INIT_ERROR : IOMMU_PCI_INIT;
 		break;
@@ -3814,16 +3815,6 @@ int amd_iommu_snp_enable(void)
 		return -EINVAL;
 	}
 
-	/*
-	 * Prevent enabling SNP after IOMMU_ENABLED state because this process
-	 * affect how IOMMU driver sets up data structures and configures
-	 * IOMMU hardware.
-	 */
-	if (init_state > IOMMU_ENABLED) {
-		pr_err("SNP: Too late to enable SNP for IOMMU.\n");
-		return -EINVAL;
-	}
-
 	amd_iommu_snp_en = check_feature_on_all_iommus(FEATURE_SNP);
 	if (!amd_iommu_snp_en)
 		return -EINVAL;

and now you only need to line up snp_rmptable_init() after IOMMU init
instead of having it be a fs_initcall which happens right after
pci_subsys_init() so that PCI is there but at the right time when iommu
init state is at IOMMU_ENABLED but no later because then it is too late.

And there you need to test amd_iommu_snp_en which is already exported
anyway.

Ok?

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
