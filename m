Return-Path: <linux-kernel+bounces-33028-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 533B983639F
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 13:46:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31693B2AF12
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 12:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D82D13A8C4;
	Mon, 22 Jan 2024 12:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RtsW2b7i"
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD98C38FA4
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 12:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705927127; cv=none; b=OzBU0PkFRP44RdETIcfaGzGVhtjbJ2Zt1AXMjlpTdlZRPzLPOhoXgMKEe2m0Bne+AXveHeI9vbIk9WB+6TYrjHjwlJUUHRMBpf6+CznB09sf6HT+GYhs+ReROSzkvNiYGflyy3Tx4hjgdy4xGf4YP4ET8jxOeMRhF8camyXvaOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705927127; c=relaxed/simple;
	bh=1YNIMXrGxJfYG0BglCiTV04XPyBS2plrnZryvDSVcWM=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=CPVYeG5HdAXNbNLL2rVoTkDroZWCiIbJHHYDfLYe2NL1saMcWlgFa8HEdcuFLA56p1BA2TJfFjz7jhmRqcarlcUHGTOKd7P6eUKv782xEZm/w5r7OejgSuy0wJuWNnqRskLmgN7c5Sp3v/2b/Ydaeo/UWhfg8fCjQ2RW7e8quHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RtsW2b7i; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705927126; x=1737463126;
  h=message-id:date:mime-version:cc:subject:to:references:
   from:in-reply-to:content-transfer-encoding;
  bh=1YNIMXrGxJfYG0BglCiTV04XPyBS2plrnZryvDSVcWM=;
  b=RtsW2b7iTvGmXg1jqxlhM/MJrgEMp+8E86CuyFECuT0sj22Zg7mSBVur
   ED5UqsRXyoj2yxbvBqU+0583lCXwpPSOhnBPFBRgUbjNQfZuulFxVwuFi
   ZxdSw9X+zIpEFVvZgKggRzN/CPXnUTMFlPMgP0GocpgKIdziCBtlOTEvq
   RPmolDGAuo4WUwRUeFl5S3tvtUIGBxRect8+zrNe3+7H1+X6e7sht69Se
   LjwLtT0cs/9v886mjLThgQx/ZuWWBefzMAXX7jM7rQdzy1Fc6O7+hgCYF
   7KhB7Zjq5WpkEdqG+zJA9H33upxs7pOaej4D20INqjYnmvsOYtFNuHs01
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="90369"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="90369"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:38:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10960"; a="904845272"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="904845272"
Received: from blu2-mobl.ccr.corp.intel.com (HELO [10.249.173.139]) ([10.249.173.139])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 04:38:43 -0800
Message-ID: <433452d0-589a-49c8-8044-dcc93d5be90a@linux.intel.com>
Date: Mon, 22 Jan 2024 20:38:41 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: baolu.lu@linux.intel.com, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
Subject: Re: DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in
 kdump mode
To: Paul Menzel <pmenzel@molgen.mpg.de>, =?UTF-8?B?SsO2cmcgUsO2ZGVs?=
 <joro@8bytes.org>, Will Deacon <will@kernel.org>
References: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>
Content-Language: en-US
From: Baolu Lu <baolu.lu@linux.intel.com>
In-Reply-To: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 2024/1/19 22:45, Paul Menzel wrote:
> 
> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
> 
>      [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 but we 
> are not in kdump mode
>      [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 but we 
> are not in kdump mode
>      [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 but we 
> are not in kdump mode
>      [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 but we 
> are not in kdump mode
>      [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 but we 
> are not in kdump mode
>      [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 but we 
> are not in kdump mode
>      [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 but we 
> are not in kdump mode
>      [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 but we 
> are not in kdump mode
> 
> Looking through the logs, this only happens when using kexec to restart 
> the system.

The code that warned this is,

  599         if (ir_pre_enabled(iommu)) {
  600                 if (!is_kdump_kernel()) {
  601                         pr_warn("IRQ remapping was enabled on %s 
but we are not in kdump mode\n",
  602                                 iommu->name);
  603                         clear_ir_pre_enabled(iommu);
  604                         iommu_disable_irq_remapping(iommu);
  605                 }

The VT-d interrupt remapping is enabled during boot, but this is not a
kdump kernel.

Do you mind checking whether the disable interrupt remapping callback
was called during kexec reboot?

1121 struct irq_remap_ops intel_irq_remap_ops = {
1122         .prepare                = intel_prepare_irq_remapping,
1123         .enable                 = intel_enable_irq_remapping,
1124         .disable                = disable_irq_remapping,
1125         .reenable               = reenable_irq_remapping,
1126         .enable_faulting        = enable_drhd_fault_handling,
1127 };

Best regards,
baolu

