Return-Path: <linux-kernel+bounces-24058-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7E082B62F
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 21:46:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9AC31F2578C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 20:46:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2B358116;
	Thu, 11 Jan 2024 20:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VSoOycpo"
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F326C5810C
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 20:46:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705005973; x=1736541973;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=T2rvntaxntUFoByN0BT0fZMFdWSF0JFiW3RrtTg9eZA=;
  b=VSoOycpoYHgPQb3lBhFZpIp11tZCSC+jT72ZUKm292NpHRNWpTYgTNQ/
   5LhWBs88PZlqnVCcAMxi2vphd0bmUHewk0sAj1XB/azGiQu1rKyb1Qb5Q
   WkRiE404upLYKpchyKnI+8Xz/1KIoBKdrGbMEiwJEVhZjU826S8ITQBgS
   WmBt/a23iAiwBXxfmMNzr5KuJq309HADf2+4KX/Hx5+uHd5EejBv6IDnz
   OzzeSsVSD4v8kKdlcjA575jGFG1bKhgD71k0r+PwG53cTGm/6mB/XF177
   PEXNRogw0jya52OfYJ2PQ2wnqMTjRxT9qxkoa2RcCKmw/tdYoGy8QCoEP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10950"; a="465370237"
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="465370237"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 12:46:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,187,1695711600"; 
   d="scan'208";a="24769986"
Received: from unknown (HELO [10.125.177.125]) ([10.125.177.125])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jan 2024 12:46:12 -0800
Message-ID: <6926ef5e-e2fd-42b0-b7de-11a06ac1f81b@linux.intel.com>
Date: Thu, 11 Jan 2024 12:46:11 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv2] x86/mm: Fix memory encryption features advertisement
Content-Language: en-US
From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>
Cc: x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org, Dexuan Cui <decui@microsoft.com>,
 Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
References: <20240111111224.25289-1-kirill.shutemov@linux.intel.com>
 <1a3661d5-3539-4443-88da-003dea920188@linux.intel.com>
In-Reply-To: <1a3661d5-3539-4443-88da-003dea920188@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/11/2024 6:19 AM, Kuppuswamy Sathyanarayanan wrote:
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
> 
> IMO, since there is already a debug message for type identification, we
> can remove this part. 
> 
>>
>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>> Cc: Dexuan Cui <decui@microsoft.com>
>> Cc: Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
>> ---

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

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

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer

