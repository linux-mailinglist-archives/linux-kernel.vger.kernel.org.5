Return-Path: <linux-kernel+bounces-137446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE1889E24A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 640281F22A87
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73B1315699A;
	Tue,  9 Apr 2024 18:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="DLp0awBf"
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03B8D156673;
	Tue,  9 Apr 2024 18:12:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712686345; cv=none; b=PMaxrIJaCq4GNiONACGXjb96gg4fWd6TtyNAYYBzOwkKmlHTAUFhQlp8u98wOXzEOO+6tyQ2tdRIgFMIkzoX3uvpCIHn9N+ZHa5OwcwHazJ6h0+wLI/YfxHhQofWgpdrENBpuCx5xlbkeb14KUZpbIZO65yTpINx8j0MkjYhhJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712686345; c=relaxed/simple;
	bh=thxxt4zRIMmtKrX1Zq6SbymytnrxT37KGosR84E5MuI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MfGgy5TqHredP8ft9FhgYGWHQUXJe7bn8hGsVxoUc4rQ5VaYxEGt6mRQOALmXmBO6dBcp5pu8E8hmDEOV/WVpa8whybF/fFvUxBd999y0ze/0v6KHXUrfR0eUtA/QrahZLxHoXKNvlXdGgJgHCsFbwFuD7Vhy44NhiSBanM0Z5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=DLp0awBf; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712686344; x=1744222344;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CiSkwG2jh+RHXxMnTYckZv1UIdBtz87JB37Fxc/Kq2c=;
  b=DLp0awBfYVAQhnaPzCImwxH9EJac3ZokG2ou/IpRJ+X94J/hhdkAbsqJ
   TwFcnSd0G6llZVCN5ZgF3Wqft2YhEYH67m7889szcvsgvqVuzvjQhql2e
   sr3BP5pFgmtGK5pLyR7fec2ZXB2GTqHwOECsEKWs24y6vKIDzWpFEZbVR
   U=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="410314341"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 18:12:17 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.43.254:49032]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.194:2525] with esmtp (Farcaster)
 id 8c7cf490-05a2-4daf-a4b3-eb0cc4051ea5; Tue, 9 Apr 2024 18:12:15 +0000 (UTC)
X-Farcaster-Flow-ID: 8c7cf490-05a2-4daf-a4b3-eb0cc4051ea5
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:12:15 +0000
Received: from bcd074994f7f.amazon.com (10.95.97.144) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 18:12:10 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v4 0/5] virt: vmgenid: Add devicetree bindings support
Date: Tue, 9 Apr 2024 19:11:49 +0100
Message-ID: <20240409181154.9962-1-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D033UWA002.ant.amazon.com (10.13.139.10) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

This small series of patches aims to add devicetree bindings support for
the Virtual Machine Generation ID (vmgenid).

Virtual Machine Generation ID was introduced in commit af6b54e2b5ba
("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
ACPI only device.

VMGenID specification http://go.microsoft.com/fwlink/?LinkId=260709 defines
a mechanism for the BIOS/hypervisors to communicate to the virtual machine
that it is executed with a different configuration (e.g. snapshot execution
or creation from a template).
The guest operating system can use the notification for various purposes
such as re-initializing its random number generator etc.

More references to vmgenid specs:
 - https://www.qemu.org/docs/master/specs/vmgenid.html
 - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/
 virtual-machine-generation-identifier

*Reason for this change*:
Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
Without going into details of why a hypervisor would choose DT over ACPI,
we would like to highlight that the hypervisors that have chosen devicetree
and now want to make use of the vmgenid functionality cannot do so today
because vmgenid is an ACPI only device.
This forces these hypervisors to change their design which could have
undesirable impacts on their use-cases, test-scenarios etc.

vmgenid exposes to the guest a 16-byte cryptographically random number,
the value of which changes every time it starts executing from a new
configuration (snapshot, backup, etc.). During initialization, the device
exposes to the guest the address of the generation ID and
an interrupt number, which the device will use to notify the guest when
the generation ID changes.
These attributes can be trivially communicated via device tree bindings.

We believe that adding a devicetree binding for vmgenid is a simpler
alternative way to expose the device to the guest than forcing the
hypervisors to implement ACPI.

Addtional notes:
While adding the devicetree support we considered re-using existing
structures/code to avoid duplicating code and reduce maintenance; so,
we used the same driver to be configured either by ACPI or by DT.
This also meant reimplementing the existing vmgenid ACPI bus driver as a
platform driver and making it discoverable using `driver.of_match_table`
and `driver.acpi_match_table`.

There is no user impact or change in vmgenid functionality when used
with ACPI. We verified ACPI support of these patches on X86 and DT
support on ARM using Firecracker hypervisor
https://github.com/firecracker-microvm/firecracker.

To check schema and syntax errors, the bindings file is verified with:
```
  make dt_binding_check \
  DT_SCHEMA_FILES=\
  Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml
```
and the patches were verified with:
`scripts/checkpatch.pl --strict v4-000*`.

Changelog with respect to version 3:
- Changed the compatible string from "virtual,vmgenctr" to
  "microsoft,vmgenid" as per review comments.
- Renamed vmgenid.yaml to follow DT file naming convention.
- Updated the description of properties and example in vmgenid yaml file.
- Addressed the review comments to remove all ifdefs in vmgenid.c with one
  exception which still needs to be under CONFIG_ACPI.
- reformated the code with clang-format.
- Tested code with W=1, Sparse, Smatch and Coccinelle tools.

Changelog with respect to version 2:
- As per review comments, used platform apis instead of "of_*" APIs,
  removed unnecessary #include and used IF_ENABLED instead of ifdef.
- Added more info for vmgenid buffer address and corrected the formatting.
- Replaced the compatible string from "linux,*" to "virtual,*" because,
  the device does not have a vendor.

Changelog with respect to version 1:
- Moved vmgenid.yaml bindings to the more related "rng" folder.
- Removed `vmgenid_remove` to since it is unrelated to the
  current goal of the patch.
- Updated the cover letter and bindings commit
  "[PATCH v2 3/4] dt-bindings: rng: Add vmgenid support" to
  provide more information on vmgenid.
- Compiled with and without CONFIG_OF/CONFIG_ACPI and fixed
  compilers errors/warnings.


Sudan Landge (5):
  virt: vmgenid: rearrange code to make review easier
  virt: vmgenid: change implementation to use a platform driver
  virt: vmgenid: enable driver regardless of ACPI config
  dt-bindings: rng: Add vmgenid support
  virt: vmgenid: add support for devicetree bindings

 .../bindings/rng/microsoft,vmgenid.yaml       |  49 +++++
 MAINTAINERS                                   |   1 +
 drivers/virt/Kconfig                          |   1 -
 drivers/virt/vmgenid.c                        | 168 ++++++++++++++----
 4 files changed, 180 insertions(+), 39 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/microsoft,vmgenid.yaml


base-commit: 20cb38a7af88dc40095da7c2c9094da3873fea23
-- 
2.34.1


