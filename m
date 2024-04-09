Return-Path: <linux-kernel+bounces-137442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B6E89E232
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:09:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 543A51C21F75
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:09:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3486E15698F;
	Tue,  9 Apr 2024 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b="A5RPqkmx"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B786156654;
	Tue,  9 Apr 2024 18:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686144; cv=none; b=JCJlb6cWdIGf5J3cDfmoSkGDWeHVVOe0ZRaAoj0b24NmmJVrxZYF1L6xD4w+FVxq83cbbB3TeZKBLDTvRh9OaXzFbTEipyC3Ye/ad0WmHTfEsBTmDB2UYUWswdELcO0M3yfx8f+cwXJUUPFHQOmACZ3b+jDrnoBdQv+Nw4CJEsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686144; c=relaxed/simple;
	bh=+Q/xe7QnEzn9MjGrM5tNgUQ+yK/3YTW1NzW8iBLHM3A=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Go97k2gVdUwdbZ7pideV+iHLQMLpxuNVdwgCCAwWFCpDagtiGUyHLna07lw4rhfQiAg2N/fKBE59ss/iPkoR15Lnmjc2K4ZLKvYss13IfUXfoJPrxM7VJwr93s6exGMhvbhpkXRdgMo4qsakAPM2D7A01xHOwHz5p1k0SN1saYQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.co.uk header.i=@amazon.co.uk header.b=A5RPqkmx; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.co.uk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.co.uk; i=@amazon.co.uk; q=dns/txt;
  s=amazon201209; t=1712686142; x=1744222142;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=rBBGVVbWyG53Bo0BvWtj1B8Zl74l3cqMo25WQ4bR+gY=;
  b=A5RPqkmx+fB3YfTqDAj/xf4fBTeWrt8Nr3brQRzgxenXMrWw4Dy86w6G
   r4Gb3TXNPeYt0hYR4TA0FbOiNtNA3GG63CRypPUPciYW6pZtXKezTBovm
   xdCIYN98VQoaM2vyGjLvI1lgmYSjtaR3nfWWvGuyNmWxmAQCg1UaAAbeq
   Y=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="79878578"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:09:00 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.17.79:19349]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.37.241:2525] with esmtp (Farcaster)
 id f9279dda-5448-4f1c-a4d9-bd484090a88f; Tue, 9 Apr 2024 18:08:59 +0000 (UTC)
X-Farcaster-Flow-ID: f9279dda-5448-4f1c-a4d9-bd484090a88f
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:08:59 +0000
Received: from [10.95.97.144] (10.95.97.144) by EX19D036EUC002.ant.amazon.com
 (10.252.61.191) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.28; Tue, 9 Apr
 2024 18:08:54 +0000
Message-ID: <2ecfc189-92fd-4575-a9e4-c8a5cf2923fa@amazon.co.uk>
Date: Tue, 9 Apr 2024 19:08:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] virt: vmgenid: Add devicetree bindings support
Content-Language: en-US
To: Sudan Landge <sudanl@amazon.com>, <tytso@mit.edu>, <Jason@zx2c4.com>,
	<robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
	<conor+dt@kernel.org>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
References: <20240409170137.79197-1-sudanl@amazon.com>
From: "Landge, Sudan" <sudanl@amazon.co.uk>
In-Reply-To: <20240409170137.79197-1-sudanl@amazon.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: EX19D032UWB001.ant.amazon.com (10.13.139.152) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)



On 09/04/2024 18:01, Sudan Landge wrote:
> This small series of patches aims to add devicetree bindings support for
> the Virtual Machine Generation ID (vmgenid).
> 
> Virtual Machine Generation ID was introduced in commit af6b54e2b5ba
> ("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
> ACPI only device.
> 
> VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
> a mechanism for the BIOS/hypervisors to communicate to the virtual machine
> that it is executed with a different configuration (e.g. snapshot execution
> or creation from a template).
> The guest operating system can use the notification for various purposes
> such as re-initializing its random number generator etc.
> 
> More references to vmgenid specs:
>   - https://www.qemu.org/docs/master/specs/vmgenid.html
>   - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/
>   virtual-machine-generation-identifier
> 
> *Reason for this change*:
> Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
> Without going into details of why a hypervisor would choose DT over ACPI,
> we would like to highlight that the hypervisors that have chosen devicetree
> and now want to make use of the vmgenid functionality cannot do so today
> because vmgenid is an ACPI only device.
> This forces these hypervisors to change their design which could have
> undesirable impacts on their use-cases, test-scenarios etc.
> 
> vmgenid exposes to the guest a 16-byte cryptographically random number,
> the value of which changes every time it starts executing from a new
> configuration (snapshot, backup, etc.). During initialization, the device
> exposes to the guest the address of the generation ID and
> an interrupt number, which the device will use to notify the guest when
> the generation ID changes.
> These attributes can be trivially communicated via device tree bindings.
> 
> We believe that adding a devicetree binding for vmgenid is a simpler
> alternative way to expose the device to the guest than forcing the
> hypervisors to implement ACPI.
> 
> Addtional notes:
> While adding the devicetree support we considered re-using existing
> structures/code to avoid duplicating code and reduce maintenance; so,
> we used the same driver to be configured either by ACPI or by DT.
> This also meant reimplementing the existing vmgenid ACPI bus driver as a
> platform driver and making it discoverable using `driver.of_match_table`
> and `driver.acpi_match_table`.
> 
> There is no user impact or change in vmgenid functionality when used
> with ACPI. We verified ACPI support of these patches on X86 and DT
> support on ARM using Firecracker hypervisor
> https://github.com/firecracker-microvm/firecracker.
> 
> To check schema and syntax errors, the bindings file is verified with:
> ```
>    make dt_binding_check \
>    DT_SCHEMA_FILES=\
>    Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> ```
> and the patches were verified with:
> `scripts/checkpatch.pl --strict v4-000*`.
> 
> Changelog with respect to version 3:
> - Changed the compatible string from "virtual,vmgenctr" to
>    "microsoft,vmgenid" as per review comments.
> - Renamed vmgenid.yaml to follow DT file naming convention.
> - Updated the description of properties and example in vmgenid yaml file.
> - Addressed the review comments to remove all ifdefs in vmgenid.c with one
>    exception which still needs to be under CONFIG_ACPI.
> - reformated the code with clang-format.
> - Tested code with W=1, Sparse, Smatch and Coccinelle tools.
> 
> Changelog with respect to version 2:
> - As per review comments, used platform apis instead of "of_*" APIs,
>    removed unnecessary #include and used IF_ENABLED instead of ifdef.
> - Added more info for vmgenid buffer address and corrected the formatting.
> - Replaced the compatible string from "linux,*" to "virtual,*" because,
>    the device does not have a vendor.
> 
> Changelog with respect to version 1:
> - Moved vmgenid.yaml bindings to the more related "rng" folder.
> - Removed `vmgenid_remove` to since it is unrelated to the
>    current goal of the patch.
> - Updated the cover letter and bindings commit
>    "[PATCH v2 3/4] dt-bindings: rng: Add vmgenid support" to
>    provide more information on vmgenid.
> - Compiled with and without CONFIG_OF/CONFIG_ACPI and fixed
>    compilers errors/warnings.
> 
> 
> Sudan Landge (5):
>    virt: vmgenid: rearrange code to make review easier
>    virt: vmgenid: change implementation to use a platform driver
>    virt: vmgenid: enable driver regardless of ACPI config
>    dt-bindings: rng: Add vmgenid support
>    virt: vmgenid: add support for devicetree bindings
> 
>   .../bindings/rng/microsoft,vmgenid.yaml       |  49 +++++
>   MAINTAINERS                                   |   1 +
>   drivers/virt/Kconfig                          |   1 -
>   drivers/virt/vmgenid.c                        | 168 ++++++++++++++----
>   4 files changed, 180 insertions(+), 39 deletions(-)
>   create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
> 
> 
> base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23

Due to a mail server error the last patch of this series, "Re: [PATCH v4 
5/5] virt: vmgenid: add support for devicetree bindings", got sent 
separately. Apologies for this. I will resend the patches to correct 
this issue so, I request reviewers to please ignore this patch.

