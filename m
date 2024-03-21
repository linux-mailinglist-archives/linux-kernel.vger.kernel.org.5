Return-Path: <linux-kernel+bounces-109601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F0F8A881B49
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 03:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9135AB22268
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 02:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F124E5CB5;
	Thu, 21 Mar 2024 02:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="R+0B1VjN"
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C01877;
	Thu, 21 Mar 2024 02:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710989482; cv=none; b=jxyyEmIWN9BJiXBAXaHpSBs4l3eSM/rk27rG2elWo5ZN4n0yK7aARu9qwqa66tU0iNGpjPX1hEgv3TQSxzU6EvFPZoP1g7mtMYWryaCxHLEPxSscQBdkUAy+Mm5fJGnLE6vOxqDCiOwJTL/r3ZY02kNLRYIbUVBilAFEKJDnyuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710989482; c=relaxed/simple;
	bh=UkaKNP/Yhok+8Dk9yuAn6gQNijSE+esjTeI0rYkJC/Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DRhQRtyu1XPKb1ZoSuG0g0W24leHyamjybf62K6ewPls9iVTCa4J1QbIaOE3xrRgKy/Dixe93tzL+RUYmw6QXDS9AS77MgsAYg/zv/HnDK7R+CmMNP+S+EbHv2RX4hFxwbDR74LYMPhKgUki6s7xChyGZls6A1MjycZKeDAuqrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=R+0B1VjN; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710989480; x=1742525480;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aK+mBYOeuvNnlpvnK9xFKFMLFZ99a08ThnoYjo6ECAM=;
  b=R+0B1VjNYDtaSxf/HO+O0iXf0UZaFTpD4MwDlvGvAQm8HL7fc39Y6nbe
   ZjiRMg+szDXr8WXUoiUx6YqYeqdiSTbe800Ci0Ma7g1k+S1e8pVYSn6KD
   Ig9356nebjazMs5T/QE9qVGvcm+gC0oY2g17fJusFa5dJ+jnIJbmJH7ZY
   0=;
X-IronPort-AV: E=Sophos;i="6.07,141,1708387200"; 
   d="scan'208";a="394817777"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Mar 2024 02:51:18 +0000
Received: from EX19MTAEUC001.ant.amazon.com [10.0.17.79:51099]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.23.112:2525] with esmtp (Farcaster)
 id d1488962-2002-42b2-9e7f-8f3520408f03; Thu, 21 Mar 2024 02:51:17 +0000 (UTC)
X-Farcaster-Flow-ID: d1488962-2002-42b2-9e7f-8f3520408f03
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUC001.ant.amazon.com (10.252.51.155) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:16 +0000
Received: from bcd074994f7f.amazon.com (10.106.82.23) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Thu, 21 Mar 2024 02:51:12 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v2 0/4] virt: vmgenid: Add devicetree bindings support
Date: Thu, 21 Mar 2024 02:51:01 +0000
Message-ID: <20240321025105.53210-1-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D043UWA002.ant.amazon.com (10.13.139.53) To
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

 .../devicetree/bindings/rng/vmgenid.yaml      |  57 +++++
 MAINTAINERS                                   |   1 +
 drivers/virt/Kconfig                          |   2 +-
 drivers/virt/vmgenid.c                        | 215 +++++++++++++++---
 4 files changed, 237 insertions(+), 38 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rng/vmgenid.yaml


base-commit: a4145ce1e7bc247fd6f2846e8699473448717b37
-- 
2.40.1


