Return-Path: <linux-kernel+bounces-117854-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F32A88B080
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 20:53:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C9F31C3E3C0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A740D29CE7;
	Mon, 25 Mar 2024 19:53:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="QH8Yw//Y"
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F142C1F95E;
	Mon, 25 Mar 2024 19:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711396408; cv=none; b=GBYKSA0gvAFREq47Ch9VzD0BQK8lmpYBQ8k+LhOIEjLovdVDv236xpwbIF/UD/FxadbFdYBTPRVIgC2X9mE1RFOn9ITdj6BITOOXkbRM6VL0bywfxuDP3rboX4HoSvnEy68rH8IwbUECtlGUOshxCC+7Rc9lxaZZkSWpxKEqcWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711396408; c=relaxed/simple;
	bh=q1usJ8QHSuHNaxle/+mq18GQ0GoIN9fVwo0LxtaUAiY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=I5luqnxEhjrjCwDSLdUOvGXgkSeAPkIz/MhM7PPUsKfC+uE28t2s+LtWPg5ZcLeA6LUp9XtPQOCgvDgNWRkQ/LkL0vAvnBjak0Wor2Z1bhH4tcBJMzlhpoVKEMB7C0SDawgrbEQ9vgQOG2l8U4YguDRMMOGwaiIKdTHO7h5ZBHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=QH8Yw//Y; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711396407; x=1742932407;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Go4UW8g/eSRArcR0sYsp9T6DHVfri7II0K0Xak1x5y0=;
  b=QH8Yw//YNk74XPwyPk+AwlEXoLKdoFroFF19VBpjmDD0tElroH3PAO8W
   jmao6Ai5TGbd/AjDLZ8p+d4OByfWAQsrDm/QNq1HVrbkYcmzWfXJ1cjoX
   XltYALh7oRSz/Usbfpcwft7rpJWQUUFgfYDZaOQSccLlShrst0soRd5PU
   4=;
X-IronPort-AV: E=Sophos;i="6.07,154,1708387200"; 
   d="scan'208";a="390412224"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 19:53:24 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.10.100:11373]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.4.153:2525] with esmtp (Farcaster)
 id db789414-5269-494e-a3db-5e6085d2ae6a; Mon, 25 Mar 2024 19:53:23 +0000 (UTC)
X-Farcaster-Flow-ID: db789414-5269-494e-a3db-5e6085d2ae6a
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:22 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 19:53:17 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v3 0/4] virt: vmgenid: Add devicetree bindings support
Date: Mon, 25 Mar 2024 19:53:02 +0000
Message-ID: <20240325195306.13133-1-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
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
 - https://learn.microsoft.com/en-us/windows/win32/hyperv_v2/virtual-machine-generation-identifier

*Reason for this change*:
Chosing ACPI or devicetree is an intrinsic part of an hypervisor design.
Without going into details of why a hypervisor would chose DT over ACPI,
we would like to highlight that the hypervisors that have chose devicetree
and now want to make use of the vmgenid functionality cannot do so today
because vmgenid is an ACPI only device.
This forces these hypervisors to change their design which could have
undesirable impacts on their use-cases, test-scenarios etc.

The point of vmgenid is to provide a mechanism to discover a GUID when
the execution state of a virtual machine changes and the simplest
way to do it is pass a memory location and an interrupt via devicetree.
It would complicate things unnecessarily if instead of using devicetree,
we try to implement a new protocol or modify other protocols to somehow
provide the same functionility.

We believe that adding a devicetree binding for vmgenid is a simpler,
better alternative to provide the same functionality and will allow
such hypervisors as mentioned above to continue using devicetree.

Addtional notes:
While adding the devicetree support we considered re-using existing
structures/code to avoid duplication code and reduce maintenance; so,
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
  DT_SCHEMA_FILES=Documentation/devicetree/bindings/vmgenid/vmgenid.yaml
```
and the patches were verified with:
`scripts/checkpatch.pl --strict v1-000*`.

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


Sudan Landge (4):
  virt: vmgenid: rearrange code to make review easier
  virt: vmgenid: change implementation to use a platform driver
  dt-bindings: rng: Add vmgenid support
  virt: vmgenid: add support for devicetree bindings

 .../devicetree/bindings/rng/vmgenid.yaml      |  58 ++++++
 MAINTAINERS                                   |   1 +
 drivers/virt/Kconfig                          |   1 -
 drivers/virt/vmgenid.c                        | 194 ++++++++++++++----
 4 files changed, 217 insertions(+), 37 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml


base-commit: 8e938e39866920ddc266898e6ae1fffc5c8f51aa
-- 
2.40.1



