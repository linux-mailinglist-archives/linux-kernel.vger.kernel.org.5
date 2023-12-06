Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C82C807616
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 18:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442711AbjLFRI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 12:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442709AbjLFRIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 12:08:54 -0500
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0359D49;
        Wed,  6 Dec 2023 09:09:00 -0800 (PST)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 24CE240E00A9;
        Wed,  6 Dec 2023 17:08:57 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id qdonn0T6sgYY; Wed,  6 Dec 2023 17:08:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1701882535; bh=syJatMfK/wH2rJw1E1uKygfYLBS1W+elXK6C2NFu5ds=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=L+CvLHi1a5PAX62soPMbGVI44U6yqhBLPfTKNkYp3/FonMG+LKYAqAMyqrYN7jdtT
         QFXOsWJdCbLgIJ8lehQbowXcnj8V4liULEGGxY6D4Inp1hc4UFfzlBLLYYfJzq2Cer
         HJTwGxPhojM0nzuIa+KUoVSJ9P5JUePBa2CkxtPeIeyZUdQQ2WzLjNr9vpKU3bdWAz
         TbEmie9zVaDlG26chSYXlva1dgXV8kUQ1R5NxayD2RIQvrUTgc4mc/OoFEvlX8ogox
         Z2OgaFgkce1qyc5jjp7GRipYRUnQALLerVuk+lZSPCu5J9ONvQHy8wgJ1+Z513GcPv
         6xNiUCJfVJOiPjN53uKix3mLWUoUPMsyI4iEuoAoOXihc4wljCe417moCxA2FbQQJS
         JGVwl6ynujmrA/cokaxTliAh4AMklvxaiTK44lx106HduGwuMckNBBmxrL4R5cx9Sd
         6bXuGRDHgK1Oj1xDnR6Hva0/xE94dyLvKHjI4Kxt3ovhh/8Dw89+o75ZASNDHWLCuf
         XtkxafdarAvul3b2GiuXDUczTS8RXFbwVAVbzXHDcx6MWQK+J8rdDOjwMV4AuQSGLf
         WSa7fw61hqHYydNHN3kR9shGLQ6KRFKMKErvjn/61SFoV5OdDE4535LkGFqCrirq33
         D3lukmtcsGspP570eeinh8O0=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B238A40E00C6;
        Wed,  6 Dec 2023 17:08:13 +0000 (UTC)
Date:   Wed, 6 Dec 2023 18:08:07 +0100
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
        Brijesh Singh <brijesh.singh@amd.com>,
        Jarkko Sakkinen <jarkko@profian.com>
Subject: Re: [PATCH v10 14/50] crypto: ccp: Add support to initialize the
 AMD-SP for SEV-SNP
Message-ID: <20231206170807.GBZXCqd0z8uu2rlhpn@fat_crate.local>
References: <20231016132819.1002933-1-michael.roth@amd.com>
 <20231016132819.1002933-15-michael.roth@amd.com>
 <20231127095937.GLZWRoiaqGlJMX54Xb@fat_crate.local>
 <d5242390-8904-7ec5-d8a1-9e3fb8f6423c@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <d5242390-8904-7ec5-d8a1-9e3fb8f6423c@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 08:13:52PM -0600, Kalra, Ashish wrote:
> It surely seems hard to follow up, so i am anyway going to clean it up by:
> 
> Adding the "probe" parameter to sev_platform_init() where the parameter
> being true indicates that we only want to do SNP initialization on probe,
> the same parameter will get passed on to
> __sev_platform_init_locked().

That's exactly what you should *not* do - the probe parameter controls
whether

	if (psp_init_on_probe)
		__sev_platform_init_locked(error);

and so on should get executed or not.

If it is unclear, lemme know and I'll do a diff to show you what I mean.
	
> > > +	/* Prepare for first SNP guest launch after INIT */
> > > +	wbinvd_on_all_cpus();
> > 
> > Why is that WBINVD needed?
> 
> As the comment above mentions, WBINVD + DF_FLUSH is needed before the first
> guest launch.

Lemme see if I get this straight. The correct order is:

	WBINVD
	SNP_INIT_*
	WBINVD
	DF_FLUSH

If so, do a comment which goes like this:

	/*
	 * The order of commands to execute before the first guest
	 * launch is the following:
	 *
	 * bla...
	 */


> In the latest code base, _sev_snp_shutdown_locked() is called from
> __sev_firmware_shutdown().

Then carve that function out only when needed - do not do changes
preemptively. This is not helping during review.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
