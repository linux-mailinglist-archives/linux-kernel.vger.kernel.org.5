Return-Path: <linux-kernel+bounces-23776-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8715182B184
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 16:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C28C1F22492
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 323A44F1FE;
	Thu, 11 Jan 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="d9pUtNpm"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FAA74EB45
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 15:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: from [192.168.1.210] (181-28-144-85.ftth.glasoperator.nl [85.144.28.181])
	by linux.microsoft.com (Postfix) with ESMTPSA id A6F8420B3CC1;
	Thu, 11 Jan 2024 07:14:46 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A6F8420B3CC1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1704986089;
	bh=pgqO97BKIOnbScawTDJ1tuVF8f+8OGImDL62MOlRvq0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=d9pUtNpmuoaI9O+TRWUiqwctGBspkfBhPjCcPK9kmDBiEtbimKz6GQxaXMW+i6V9A
	 wKdxues79caHK1R61nEHWi3J9qAVq1Lx7LfDbWkVQfKxHyi1srYYGN/WT0dObO6J6A
	 +FjHHbGjnMcyU8VuMQJe7KOk52ZWT5pcZj4LTru0=
Message-ID: <ca14057d-ebdb-4e2d-97b8-5289bada7fe8@linux.microsoft.com>
Date: Thu, 11 Jan 2024 16:14:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Content-Language: en-US
To: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>
References: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
 <1a3661d5-3539-4443-88da-003dea920188@linux.intel.com>
From: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
In-Reply-To: <1a3661d5-3539-4443-88da-003dea920188@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/01/2024 15:19, Kuppuswamy Sathyanarayanan wrote:
> 
> 
> On 1/11/2024 3:12 AM, Kirill A. Shutemov wrote:
>> When memory encryption is enabled, the kernel prints the encryption
>> flavor that the system supports.
>>
>> The check assumes that everything is AMD SME/SEV if it doesn't have
>> the TDX CPU feature set.
>>
>> Hyper-V vTOM sets cc_vendor to CC_VENDOR_INTEL when it runs as L2 guest
>> on top of TDX, but not X86_FEATURE_TDX_GUEST. Hyper-V only needs memory
>> encryption enabled for I/O without the rest of CoCo enabling.
>>
>> To avoid confusion, check the cc_vendor directly.
>>
>> Possible alternative is to completely removing the print statement.
>> For a regular TDX guest, the kernel already prints a message indicating
>> that it is booting on TDX. Similarly, AMD and Hyper-V can also display
>> a message during their enumeration process.
> 
> With this change, will it print "Intel TDX" for Hyper-V?

Yes, I just tested on AMD and Intel and the print is accurate now. Thanks.

Reviewed-by: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>

> 
> IMO, since there is already a debug message for type identification, we
> can remove this part. 
> 

If that's the only way to get a fix merged then so be it, but I appreciate having
the possibility of greping for a single prefix for either vendor that the current
code provides.

>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> ---
>>  arch/x86/mm/mem_encrypt.c | 56 +++++++++++++++++++++------------------
>>  1 file changed, 30 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
>> index c290c55b632b..d035bce3a2b0 100644
>> --- a/arch/x86/mm/mem_encrypt.c
>> +++ b/arch/x86/mm/mem_encrypt.c
>> @@ -42,38 +42,42 @@ bool force_dma_unencrypted(struct device *dev)
>>  
>>  static void print_mem_encrypt_feature_info(void)
>>  {
>> -	pr_info("Memory Encryption Features active:");
>> +	pr_info("Memory Encryption Features active: ");
>>  
>> -	if (cpu_feature_enabled(X86_FEATURE_TDX_GUEST)) {
>> -		pr_cont(" Intel TDX\n");
>> -		return;
>> -	}
>> +	switch (cc_vendor) {
>> +	case CC_VENDOR_INTEL:
>> +		pr_cont("Intel TDX\n");
>> +		break;
>> +	case CC_VENDOR_AMD:
>> +		pr_cont("AMD");
>>  
>> -	pr_cont(" AMD");
>> -
>> -	/* Secure Memory Encryption */
>> -	if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>> +		/* Secure Memory Encryption */
>> +		if (cc_platform_has(CC_ATTR_HOST_MEM_ENCRYPT)) {
>>  		/*
>>  		 * SME is mutually exclusive with any of the SEV
>>  		 * features below.
>> -		 */
>> -		pr_cont(" SME\n");
>> -		return;
>> +		*/
>> +			pr_cont(" SME\n");
>> +			return;
>> +		}
>> +
>> +		/* Secure Encrypted Virtualization */
>> +		if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> +			pr_cont(" SEV");
>> +
>> +		/* Encrypted Register State */
>> +		if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
>> +			pr_cont(" SEV-ES");
>> +
>> +		/* Secure Nested Paging */
>> +		if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> +			pr_cont(" SEV-SNP");
>> +
>> +		pr_cont("\n");
>> +		break;
>> +	default:
>> +		pr_cont("Unknown\n");
>>  	}
>> -
>> -	/* Secure Encrypted Virtualization */
>> -	if (cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT))
>> -		pr_cont(" SEV");
>> -
>> -	/* Encrypted Register State */
>> -	if (cc_platform_has(CC_ATTR_GUEST_STATE_ENCRYPT))
>> -		pr_cont(" SEV-ES");
>> -
>> -	/* Secure Nested Paging */
>> -	if (cc_platform_has(CC_ATTR_GUEST_SEV_SNP))
>> -		pr_cont(" SEV-SNP");
>> -
>> -	pr_cont("\n");
>>  }
>>  
>>  /* Architecture __weak replacement functions */
>

