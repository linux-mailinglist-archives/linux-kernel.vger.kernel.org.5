Return-Path: <linux-kernel+bounces-125123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 555D189205A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 16:25:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1008E289809
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0DA051C52;
	Fri, 29 Mar 2024 15:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZJKtspY0"
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96E602562E
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711725703; cv=none; b=oyA6Il1qbPsFv7uCrk4/Pr6TnyL2kl2+0j2wLweMqkYCCW3VZNoig5F1V78Hxl0k96TZg3COlN3UeHz7M05QcAkRAg2RXlAOsofLZxaBzH0v+xlf82TV5FH6UgnoSlUqO3cv3k6XndZ8HWZAfcX+9d5YdsM9F7f3LUgY0NUO9Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711725703; c=relaxed/simple;
	bh=xIhz1fc0gd8bUoWk1Yba/XGwSpCgbpumuPmPXecDCog=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=vAl3DJidDHkQB+U4yKFlg60kafpCihyOBtOgFrZVtYEaLnuwKqYGXaccWJ9QIRRkG5QDP2ZQFtgEGqeDP/cW81xUJJUkJKBWPjCrh+/nudnqENBDfDKUyrMDyqA4s3CwJanx8EtzugUUOuRVFFAQNZfGdsaSaeATJE9eJkZ5UhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZJKtspY0; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711725702; x=1743261702;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=xIhz1fc0gd8bUoWk1Yba/XGwSpCgbpumuPmPXecDCog=;
  b=ZJKtspY0jsFuTnIcc6aqcoRMvX4hnpNMkAHa5QnXVSPxFrU2xUe//mUN
   hPzYbvxgu2NUyV4XP5JArSs4yuSM0ERKdwcEyprikmgz0swbmV9wz4mS+
   XIjqWkYXyC9zekGb4Vd1YEgKQRg20DtwbovEfwHUBn+v2GEC2+APKRcdi
   G5M7AzgQr0tZoa6ty6lgxXeE5mDCm/JM8m/n8aMFIJs/yU74dOpgJcjjr
   AJJj7vsVCKNbSuyQhu0ytbdvf1eYFV4Yc7C+W3lCCwTsdvtcWVFwus49l
   LzBsCvWV9PHcLziiOrO2G4JjCJv157ckdYjL9RIwcycHttjXxZiQoWhm9
   Q==;
X-CSE-ConnectionGUID: zXcaCzcLQSaw+aqEoGUcUg==
X-CSE-MsgGUID: a84RurfVTjOLC2+EqkxsTg==
X-IronPort-AV: E=McAfee;i="6600,9927,11028"; a="17472611"
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17472611"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:21:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,165,1708416000"; 
   d="scan'208";a="17636665"
Received: from xiaoyaol-hp-g830.ccr.corp.intel.com (HELO [10.124.224.7]) ([10.124.224.7])
  by orviesa008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2024 08:21:36 -0700
Message-ID: <b94c81ef-50f2-4e66-9533-461791777d10@intel.com>
Date: Fri, 29 Mar 2024 23:21:32 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv9 05/17] x86/kexec: Keep CR4.MCE set during kexec for TDX
 guest
To: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 x86@kernel.org
Cc: "Rafael J. Wysocki" <rafael@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>,
 Adrian Hunter <adrian.hunter@intel.com>,
 Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 Elena Reshetova <elena.reshetova@intel.com>,
 Jun Nakajima <jun.nakajima@intel.com>,
 Rick Edgecombe <rick.p.edgecombe@intel.com>,
 Tom Lendacky <thomas.lendacky@amd.com>, "Kalra, Ashish"
 <ashish.kalra@amd.com>, Sean Christopherson <seanjc@google.com>,
 "Huang, Kai" <kai.huang@intel.com>, Baoquan He <bhe@redhat.com>,
 kexec@lists.infradead.org, linux-coco@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240325103911.2651793-1-kirill.shutemov@linux.intel.com>
 <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
Content-Language: en-US
From: Xiaoyao Li <xiaoyao.li@intel.com>
In-Reply-To: <20240325103911.2651793-6-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/25/2024 6:38 PM, Kirill A. Shutemov wrote:
> TDX guests are not allowed to clear CR4.MCE. Attempt to clear it leads
> to #VE.

Will we consider making it more safe and compatible for future to guard 
against X86_FEATURE_MCE as well?

If in the future, MCE becomes configurable for TD guest, then CR4.MCE 
might not be fixed1.

> Use alternatives to keep the flag during kexec for TDX guests.
> 
> The change doesn't affect non-TDX-guest environments.
> 
> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kai Huang <kai.huang@intel.com>
> Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
> ---
>   arch/x86/kernel/relocate_kernel_64.S | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/x86/kernel/relocate_kernel_64.S b/arch/x86/kernel/relocate_kernel_64.S
> index 56cab1bb25f5..e144bcf60cbe 100644
> --- a/arch/x86/kernel/relocate_kernel_64.S
> +++ b/arch/x86/kernel/relocate_kernel_64.S
> @@ -5,6 +5,8 @@
>    */
>   
>   #include <linux/linkage.h>
> +#include <linux/stringify.h>
> +#include <asm/alternative.h>
>   #include <asm/page_types.h>
>   #include <asm/kexec.h>
>   #include <asm/processor-flags.h>
> @@ -145,12 +147,15 @@ SYM_CODE_START_LOCAL_NOALIGN(identity_mapped)
>   	 * Set cr4 to a known state:
>   	 *  - physical address extension enabled
>   	 *  - 5-level paging, if it was enabled before
> +	 *  - Machine check exception on TDX guest. Clearing MCE is not allowed
> +	 *    in TDX guests.
>   	 */
>   	movl	$X86_CR4_PAE, %eax
>   	testq	$X86_CR4_LA57, %r13
>   	jz	1f
>   	orl	$X86_CR4_LA57, %eax
>   1:
> +	ALTERNATIVE "", __stringify(orl $X86_CR4_MCE, %eax), X86_FEATURE_TDX_GUEST
>   	movq	%rax, %cr4
>   
>   	jmp 1f


