Return-Path: <linux-kernel+bounces-33699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 109FE836E83
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 18:55:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBDD6B238B6
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 17:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F3A573178;
	Mon, 22 Jan 2024 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K3Eb+61L"
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D490156466;
	Mon, 22 Jan 2024 16:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705941159; cv=none; b=oYF4dMTunNypb9xw0aqUaab0OAFvC/lV87i4OteXmcg86+jvwC7TEWf+xdaXRvmtwJ09830yrMAJ3ZxGHtU+ddHwPK7C2bmGMkaBDM1xm1zw3Psm7PYwsSaY1jcNkh4s44ZDFvshQahHQC/k/xBlGoPqQQB9PMyKjQc96hXnCMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705941159; c=relaxed/simple;
	bh=q+mUZdd5s8JkPZLmLiPG2KxVKoVyZ0JMYzMnTmOTZpg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uqlpjjk47vWFtZsiWFMtgHg+QrQfR6FKv/02lhkHw7pHbiTCEd8q6laU26lpCbKey7c9Fk+QmfhVUA6wR0Q5VfUbEiDiyBotfHFNaq8j0D6dEtiQCyTTgKP82Fygfm5AJsgd7emnSdt688vjx9je3wIR3Uq82gAaDy3R9SSQciI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K3Eb+61L; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705941157; x=1737477157;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=q+mUZdd5s8JkPZLmLiPG2KxVKoVyZ0JMYzMnTmOTZpg=;
  b=K3Eb+61LaZegyaW2uufEbcNjXf+CJUCN/5rUJupydkEC48/qOLVcVYTz
   q0p6tcA4vChfRiK8T4rfCCs9in1CdHUNnZRna6QYljkA2V6EKGCvF1oro
   p6oVMhaNTgMWHBEKeQTlvU2JamKuKk3Ny7hjKbKWhJEZCkH2CHt+Oz9YZ
   +JP/Fpwd3e4cX3/bXBQwPnfJDD43w4zod6ygvbdju+BP6yZZAZD1QTPGO
   yjTOVA2nz3TmCsH7XtpRZOLLfiSOAsPkUBB7T9k+otBGqPKiR3HyMj6l9
   EE/ILmD9J3VMv3qEsSr53urcFl3P4yJDvxpqF+o/NYBia5nNR34qD9dmn
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="432413277"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="432413277"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:32:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="855989740"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="855989740"
Received: from yongwool-mobl3.amr.corp.intel.com (HELO [10.209.52.151]) ([10.209.52.151])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 08:32:23 -0800
Message-ID: <ff370e42-f48b-4c62-9b44-9d4031cd78b0@intel.com>
Date: Mon, 22 Jan 2024 08:32:22 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 7/7] x86/vmware: Add TDX hypercall support
Content-Language: en-US
To: Alexey Makhalov <alexey.makhalov@broadcom.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux.dev, bp@alien8.de,
 hpa@zytor.com, dave.hansen@linux.intel.com, mingo@redhat.com,
 tglx@linutronix.de
Cc: x86@kernel.org, netdev@vger.kernel.org, richardcochran@gmail.com,
 linux-input@vger.kernel.org, dmitry.torokhov@gmail.com, zackr@vmware.com,
 linux-graphics-maintainer@vmware.com, pv-drivers@vmware.com,
 namit@vmware.com, timothym@vmware.com, akaher@vmware.com, jsipek@vmware.com,
 dri-devel@lists.freedesktop.org, daniel@ffwll.ch, airlied@gmail.com,
 tzimmermann@suse.de, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 horms@kernel.org, kirill.shutemov@linux.intel.com
References: <20240109084052.58661-1-amakhalov@vmware.com>
 <20240109084052.58661-8-amakhalov@vmware.com>
From: Dave Hansen <dave.hansen@intel.com>
Autocrypt: addr=dave.hansen@intel.com; keydata=
 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
In-Reply-To: <20240109084052.58661-8-amakhalov@vmware.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/9/24 00:40, Alexey Makhalov wrote:
> +#ifdef CONFIG_INTEL_TDX_GUEST
> +unsigned long vmware_tdx_hypercall(unsigned long cmd,
> +				   struct tdx_module_args *args)
> +{
> +	if (!hypervisor_is_type(X86_HYPER_VMWARE))
> +		return ULONG_MAX;
> +
> +	if (cmd & ~VMWARE_CMD_MASK) {
> +		pr_warn_once("Out of range command %lx\n", cmd);
> +		return ULONG_MAX;
> +	}
> +
> +	args->r10 = VMWARE_TDX_VENDOR_LEAF;
> +	args->r11 = VMWARE_TDX_HCALL_FUNC;
> +	args->r12 = VMWARE_HYPERVISOR_MAGIC;
> +	args->r13 = cmd;
> +	args->r15 = 0; /* CPL */
> +
> +	__tdx_hypercall(args);
> +
> +	return args->r12;
> +}
> +EXPORT_SYMBOL_GPL(vmware_tdx_hypercall);
> +#endif

This is the kind of wrapper that I was hoping for.  Thanks.

Acked-by: Dave Hansen <dave.hansen@linux.intel.com>


