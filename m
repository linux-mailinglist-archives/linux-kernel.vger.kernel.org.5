Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F286793EA9
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 16:22:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbjIFOXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 10:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjIFOW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 10:22:59 -0400
X-Greylist: delayed 1059 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Sep 2023 07:22:30 PDT
Received: from nc1.cschramm.eu (nc1.cschramm.eu [IPv6:2a03:4000:48:83:4479:b8ff:fef1:2c03])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAB101985
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=cschramm.eu
        ; s=20160910; h=Subject:Content-Transfer-Encoding:Content-Type:In-Reply-To:
        From:References:Cc:To:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe
        :List-Post:List-Owner:List-Archive;
        bh=UvzrRU4aI7jB0kZh31bHpMZkLIz4PAmUbS0QK2KbTAc=; b=uJYLGCIXGlmilGRmmWNFbmnhzr
        1HVIJIGBVVSIiN5MJEaEJ1Fk5Kg+rNqh9G6lO0v5A0g2z5b4Di9qJdX0OHvx96STV0xAp2ABNR4zW
        ZVS03V73cidA+c/rAtEOxmIuP0ma9iLWZKvM5ef7q2Jl2wHcwMQ+n1ZahAmFBJ0hgL/U=;
Received: from [2001:a61:2768:4a01:e992:1369:1720:9bd7]
        by nc1.cschramm.eu with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.94.2)
        (envelope-from <linux@cschramm.eu>)
        id 1qdt8n-00Ao54-U2; Wed, 06 Sep 2023 16:04:30 +0200
Message-ID: <101c3910-a164-4b4c-9474-8743dc6d1199@cschramm.eu>
Date:   Wed, 6 Sep 2023 16:04:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To:     Tom Lendacky <thomas.lendacky@amd.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Michael Roth <michael.roth@amd.com>,
        Joerg Roedel <jroedel@suse.de>,
        Dionna Glaze <dionnaglaze@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
References: <20230606142637.5171-1-kirill.shutemov@linux.intel.com>
 <cover.1686063086.git.thomas.lendacky@amd.com>
 <a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com>
From:   Christopher Schramm <linux@cschramm.eu>
In-Reply-To: <a52fa69f460fd1876d70074b20ad68210dfc31dd.1686063086.git.thomas.lendacky@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:a61:2768:4a01:e992:1369:1720:9bd7
X-SA-Exim-Mail-From: linux@cschramm.eu
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
Subject: Re: [PATCH v9 5/6] x86/sev: Add SNP-specific unaccepted memory
 support
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on nc1.cschramm.eu)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 5c72067c06d4..b9c451f75d5e 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -1543,11 +1543,13 @@ config X86_MEM_ENCRYPT
>   config AMD_MEM_ENCRYPT
>   	bool "AMD Secure Memory Encryption (SME) support"
>   	depends on X86_64 && CPU_SUP_AMD
> +	depends on EFI_STUB
>   	select DMA_COHERENT_POOL
>   	select ARCH_USE_MEMREMAP_PROT
>   	select INSTRUCTION_DECODER
>   	select ARCH_HAS_CC_PLATFORM
>   	select X86_MEM_ENCRYPT
> +	select UNACCEPTED_MEMORY
>   	help
>   	  Say yes to enable support for the encryption of system memory.
>   	  This requires an AMD processor that supports Secure Memory

Unfortunately this makes AMD_MEM_ENCRYPT depend on EFI just to 
unconditionally enable UNACCEPTED_MEMORY. It seems like an easy target 
to make that optional, e.g. with a separate configuration item:

---
config AMD_UNACCEPTED_MEMORY
        def_bool y
        depends on AMD_MEM_ENCRYPT && EFI_STUB
        select UNACCEPTED_MEMORY
---

Using that we can successfully build and run SNP VMs without UEFI/OVMF 
(which we already did with earlier Linux versions).

 From a quick look at

   [PATCHv14 9/9] x86/tdx: Add unaccepted memory support

it actually seems very similar for INTEL_TDX_GUEST.

Ideally UNACCEPTED_MEMORY would not assume EFI either, but the 
implementation actually clearly does.
