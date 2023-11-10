Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2A817E7F5B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:53:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjKJRwz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKJRwi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:52:38 -0500
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1903A6FBF;
        Fri, 10 Nov 2023 04:27:15 -0800 (PST)
Received: from [192.168.2.41] (77-166-152-30.fixed.kpn.net [77.166.152.30])
        by linux.microsoft.com (Postfix) with ESMTPSA id 25A5820B74C0;
        Fri, 10 Nov 2023 04:27:09 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 25A5820B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1699619233;
        bh=aAFVWtwiu6x+35A7o2OY0KDyWLYfSVIZY373tBGp+R0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KdRWVtydl5Y/3Ld1JNd2X+ewHpODShTJ/3KaMPk3gG8u/wcL3wxL56IkvYdweleeN
         TVh6NMQP8+oamyWEE/r42lY++rzNN2XSROA5OsQcbSXmM1xl5sxU/TQl+L+fEJP/zC
         HLxiMvPLA7qdxgckLx2NGrV43iKnrc7PmZFreMnQ=
Message-ID: <6feecf9e-10cb-441f-97a4-65c98e130f7a@linux.microsoft.com>
Date:   Fri, 10 Nov 2023 13:27:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] x86/mm: Check cc_vendor when printing memory encryption
 info
Content-Language: en-US
To:     kirill.shutemov@linux.intel.com
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
        linux-kernel@vger.kernel.org,
        Michael Kelley <mhklinux@outlook.com>,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org
References: <1699546489-4606-1-git-send-email-jpiotrowski@linux.microsoft.com>
 <16ea75a9-8c94-4665-ae04-32d08aa4ebb2@intel.com>
 <58abbc79-64d4-41f9-9fd2-1de7826fbbf6@linux.microsoft.com>
 <ee9de366-6027-495a-98d9-b8b0cd866bf2@intel.com>
 <df95817a-4859-443a-9ac2-b09f102aff30@linux.microsoft.com>
 <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
From:   Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <20231110120601.3mbemh6djdazyzgb@box.shutemov.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-17.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/11/2023 13:06, kirill.shutemov@linux.intel.com wrote:
> On Thu, Nov 09, 2023 at 07:41:33PM +0100, Jeremi Piotrowski wrote:
>> It's not disregard, the way the kernel behaves in this case is correct except
>> for the error in reporting CPU vendor. Users care about seeing the correct
>> information in dmesg.
> 
> I think it is wrong place to advertise CoCo features. It better fits into
> Intel/AMD-specific code that knows better what it is running on. Inferring
> it from generic code has been proved problematic as you showed.
> 

Let's not make this into a bigger issue than it is. There is a check that does
not cover all cases, and needs to be changed into a different check that covers
all cases. I'd wouldn't call that problematic.

I would be open to moving the function to arch/x86/coco/core.c or providing a
mechanism for cpu/paravisor-specific code to do the reporting (which is what
Dexuan originally proposed [1]).

[1]: https://lore.kernel.org/lkml/20231019062030.3206-1-decui@microsoft.com/

> Maybe just remove incorrect info and that's it?
> 

I disagree, other users and I find the print very useful to see which coco
platform the kernel is running on and which confidential computing features
the kernel detected. I'm willing to fix the code to report correct info.

> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
> index c290c55b632b..f573a97c0524 100644
> --- a/arch/x86/mm/mem_encrypt.c
> +++ b/arch/x86/mm/mem_encrypt.c
> @@ -40,42 +40,6 @@ bool force_dma_unencrypted(struct device *dev)
>  	return false;
>  }
>  
> -static void print_mem_encrypt_feature_info(void)
> -{
> -	pr_info("Memory Encryption Features active:");
> -
> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
> -		pr_cont(" Intel TDX\n");
> -		return;
> -	}
> -
> -	pr_cont(" AMD");
> -
> -	/* Secure Memory Encryption */
> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
> -		/*
> -		 * SME is mutually exclusive with any of the SEV
> -		 * features below.
> -		 */
> -		pr_cont(" SME\n");
> -		return;
> -	}
> -
> -	/* Secure Encrypted Virtualization */
> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
> -		pr_cont(" SEV");
> -
> -	/* Encrypted Register State */
> -	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
> -		pr_cont(" SEV-ES");
> -
> -	/* Secure Nested Paging */
> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
> -		pr_cont(" SEV-SNP");
> -
> -	pr_cont("\n");
> -}
> -
>  /* Architecture __weak replacement functions */
>  void __init mem_encrypt_init(void)
>  {
> @@ -85,7 +49,7 @@ void __init mem_encrypt_init(void)
>  	/* Call into SWIOTLB to update the SWIOTLB DMA buffers */
>  	swiotlb_update_mem_attributes();
>  
> -	print_mem_encrypt_feature_info();
> +	pr_info("Memory Encryption is active\n");
>  }
>  
>  void __init mem_encrypt_setup_arch(void)

