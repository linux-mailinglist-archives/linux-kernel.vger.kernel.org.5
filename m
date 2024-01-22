Return-Path: <linux-kernel+bounces-33194-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 584238365DF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 15:53:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0CA00281787
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 14:53:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F363D574;
	Mon, 22 Jan 2024 14:53:49 +0000 (UTC)
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 249E83CF45
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 14:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.14.17.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705935229; cv=none; b=V9sceJBiulHIOksTlcc9HxT9cWj/ny+lYnbAP7XYUJ94jweEaAvqIhYC3TPhJzJeu/0XX0smzvv1CALDUdfkvt52H75CHBd2MZ/vZ2kqHFBdczaTbzQcBiNYLJ5uw6x4Y74+90Sczvh0LfqFRBbem+BB9NusCWH6iVoUmMqQSHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705935229; c=relaxed/simple;
	bh=DJ7/RrpeA0Yew/X0+eJI2TzQgnjpIpDMQYJRlwg56Mw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SppimSVb5dfH2ijadbUSZbmfbdch33MtvgN+32isbiJXCpAQs44O4QTwAAhIXD7u8FzADV27fwuvfdC8r7lgV24wwYIuU0lU5YGCvlzVnb5zJhcgRLJ80gEJdwe+mb+YMvCdG6uM+QD018AP/vi9V4gaFdS5jXi1V5UtTvHPtKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de; spf=pass smtp.mailfrom=molgen.mpg.de; arc=none smtp.client-ip=141.14.17.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=molgen.mpg.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=molgen.mpg.de
Received: from [141.14.220.34] (g34.guest.molgen.mpg.de [141.14.220.34])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: pmenzel)
	by mx.molgen.mpg.de (Postfix) with ESMTPSA id A007B61E646EB;
	Mon, 22 Jan 2024 15:53:06 +0100 (CET)
Message-ID: <24bf9a11-6abd-4ccf-9ca1-3cf75c45d374@molgen.mpg.de>
Date: Mon, 22 Jan 2024 15:53:06 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in
 kdump mode
Content-Language: en-US
To: Baolu Lu <baolu.lu@linux.intel.com>
Cc: =?UTF-8?B?SsO2cmcgUsO2ZGVs?= <joro@8bytes.org>,
 Will Deacon <will@kernel.org>, iommu@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <5517f76a-94ad-452c-bae6-34ecc0ec4831@molgen.mpg.de>
 <433452d0-589a-49c8-8044-dcc93d5be90a@linux.intel.com>
From: Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <433452d0-589a-49c8-8044-dcc93d5be90a@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Dear Baolu,


Than you for your reply.


Am 22.01.24 um 13:38 schrieb Baolu Lu:
> On 2024/1/19 22:45, Paul Menzel wrote:
>>
>> On a Dell PowerEdge T640, Linux 5.9 and 6.6.12 warn about kdump:
>>
>>      [    2.728445] DMAR-IR: IRQ remapping was enabled on dmar6 but we are not in kdump mode
>>      [    2.736544] DMAR-IR: IRQ remapping was enabled on dmar5 but we are not in kdump mode
>>      [    2.744620] DMAR-IR: IRQ remapping was enabled on dmar4 but we are not in kdump mode
>>      [    2.752695] DMAR-IR: IRQ remapping was enabled on dmar3 but we are not in kdump mode
>>      [    2.760774] DMAR-IR: IRQ remapping was enabled on dmar2 but we are not in kdump mode
>>      [    2.768847] DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
>>      [    2.776922] DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
>>      [    2.784999] DMAR-IR: IRQ remapping was enabled on dmar7 but we are not in kdump mode
>>
>> Looking through the logs, this only happens when using kexec to 
>> restart the system.
> 
> The code that warned this is,
> 
>   599         if (ir_pre_enabled(iommu)) {
>   600                 if (!is_kdump_kernel()) {
>   601                         pr_warn("IRQ remapping was enabled on %s but we are not in kdump mode\n",
>   602                                 iommu->name);
>   603                         clear_ir_pre_enabled(iommu);
>   604                         iommu_disable_irq_remapping(iommu);
>   605                 }
> 
> The VT-d interrupt remapping is enabled during boot, but this is not a
> kdump kernel.
> 
> Do you mind checking whether the disable interrupt remapping callback
> was called during kexec reboot?
> 
> 1121 struct irq_remap_ops intel_irq_remap_ops = {
> 1122         .prepare                = intel_prepare_irq_remapping,
> 1123         .enable                 = intel_enable_irq_remapping,
> 1124         .disable                = disable_irq_remapping,
> 1125         .reenable               = reenable_irq_remapping,
> 1126         .enable_faulting        = enable_drhd_fault_handling,
> 1127 };

Is there a way to check this without rebuilding the Linux kernel?

Do you have access to server hardware and are able to test kexec?


Kind regards,

Paul

