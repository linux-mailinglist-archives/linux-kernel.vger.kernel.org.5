Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8A417D16E1
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 22:22:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230264AbjJTUWg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 16:22:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230117AbjJTUWe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 16:22:34 -0400
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5301FD63
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 13:22:32 -0700 (PDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 39B9F40E0193;
        Fri, 20 Oct 2023 20:22:29 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
        header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
        by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id EcV4Ofp_9DwU; Fri, 20 Oct 2023 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
        t=1697833347; bh=bQIeUlnI+1Vpkuoi3K6di3lGq2uGWPayBk6/l1Il/3c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=D42Mpj/4s3W+q0i7frQ3c2rZOzgKshR8/MXVQ4Hg/SZrHgj+TOVNy00KDlFWmS/mG
         8REaggIILI1/mPx4BlGtlCy6b+7t5/DoIVYKRAjadJ15ta1Cztm+7jAukBQXpi/DnW
         oU2SZ0sdllRELa3gYmmONerbH4SiXa7TvFcx6EHg9AGiEoH5pF8IjltqfNhk8p+rFX
         /H0A/BPgORtlN8ckxbiap84xenveUKYzm80UQa2npGl2UII33Fn1Brh6yoegwbkpKs
         gYREXyChX4NWR7XXY+U5x0XIJcU/ci+yMjmNbhfw3zWfRR5Z+oam/pMyFP8TJpjmEH
         x7OIT1D6rn76A7Y7UKJDnaSDXiVtDQXdF9Mpc4O2Gm6zuJWa5HCMP5hE3M1QD3jn4s
         XQfdjNafmmHlJeHYNQc+nd3Nr2Q4Z/HohxofxJcISO1IXnPSgv9/SYcutFlSSKuApC
         LHVT7G0GrYlHBYhIcm0QKLX0hZKxe73+S//xZ/bmoXk7tj9I4lm7SQXHrbd7tZt53g
         6kaynTMTSpFsHWWmx/++urmNs8bN5qz1I9RZlupYJ4xkbqCNtVGkmK789LSmjeiHQ+
         xXEwAMQXvlldZJZxoxfdbpwEjJiGHXxzn2m4/Kjh6HhiyUgR+yDRulKDXQWW63NPFi
         mKE41mf2vj0TTvI5l2G5gc7Y=
Received: from zn.tnic (pd95304da.dip0.t-ipconnect.de [217.83.4.218])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
        (No client certificate requested)
        by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 308C740E0196;
        Fri, 20 Oct 2023 20:22:03 +0000 (UTC)
Date:   Fri, 20 Oct 2023 22:21:58 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Dexuan Cui <decui@microsoft.com>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        KY Srinivasan <kys@microsoft.com>,
        Haiyang Zhang <haiyangz@microsoft.com>,
        "wei.liu@kernel.org" <wei.liu@kernel.org>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "x86@kernel.org" <x86@kernel.org>, "hpa@zytor.com" <hpa@zytor.com>,
        "luto@kernel.org" <luto@kernel.org>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "stefan.bader@canonical.com" <stefan.bader@canonical.com>,
        Tim Gardner <tim.gardner@canonical.com>,
        "roxana.nicolescu@canonical.com" <roxana.nicolescu@canonical.com>,
        "cascardo@canonical.com" <cascardo@canonical.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "jgross@suse.com" <jgross@suse.com>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "sashal@kernel.org" <sashal@kernel.org>,
        "matija.glavinic-pecotic.ext@nokia.com" 
        <matija.glavinic-pecotic.ext@nokia.com>,
        "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86/mm: Print the encryption features correctly when a
 paravisor is present
Message-ID: <20231020202158.GHZTLhZpmes+uiHOE2@fat_crate.local>
References: <20231019062030.3206-1-decui@microsoft.com>
 <00ff2f75-e780-4e2d-bcc9-f441f5ef879c@intel.com>
 <SA1PR21MB13352433C4D72AE19F1FF56EBFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
 <5245c0df-130c-443d-896b-01887875382b@intel.com>
 <SA1PR21MB1335B68B21B1F37ECC6D77F0BFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1335B68B21B1F37ECC6D77F0BFDBA@SA1PR21MB1335.namprd21.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 20, 2023 at 08:00:13PM +0000, Dexuan Cui wrote:
> Currently arch/x86/mm/mem_encrypt.c: print_mem_encrypt_feature_info()
> prints an incorrect and confusing message 
> "Memory Encryption Features active: AMD SEV".
> when an Intel TDX VM with a paravisor runs on Hyper-V.
> 
> So I think a kernel patch is needed.

So I'm trying to parse this:

"Hyper-V provides two modes for running a TDX/SNP VM:

1) In TD Partitioning mode (TDX) or vTOM mode (SNP) with a paravisor;
2) In "fully enlightened" mode with the normal TDX shared bit or SNP C-bit
   control over page encryption, and no paravisor."

and it all sounds like word salad to me.

The fact that you've managed to advertize a salad of CPUID bits to the
guest to lead to such confusing statement, sounds like a major insanity.

> the native TDX/SNP CPUID capability is hidden from the VM

Why do you wonder then that it detects wrong?! You're hiding it!

> but cc_platform_has(CC_ATTR_MEM_ENCRYPT) and
> cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT) are true;

I guess you need to go to talk to Michael:

812b0597fb40 ("x86/hyperv: Change vTOM handling to use standard coco mechanisms")

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
