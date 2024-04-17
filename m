Return-Path: <linux-kernel+bounces-148341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 023658A812B
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 12:41:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E5101F21525
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 10:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08F9813C684;
	Wed, 17 Apr 2024 10:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b="W11dvrCg"
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C68A139CEF;
	Wed, 17 Apr 2024 10:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713350502; cv=none; b=k/ybmQduCFmUVQlAlNfb3oE2oUjWgx6fjFMVDu0B3Y8IdDH49VWqMuwyeMwxIZje8Y98/nMRfAYw4QDkxszSnlseHuqmgVxJ8fUMcavCjm1GRRqZcR3sKfQKbZ2XV5jUNTgfAiFD9GNhdYPQ3WoYgyibGA4limVd1VQSGNRo44g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713350502; c=relaxed/simple;
	bh=Ic/7R3rdHrRAyOiQ9P3AxBCXW/J0+L5EOw6s4b91pwY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VcqAwEyMh0S3YIqXlgCZw639LDvKebm91Vlni7608EqXSUu4qXUq1QxelaZfRtMVm2lzeiLjqlgM3/dfp0lg/bgpxSLaS9TOtCHsJy4HmA+WGozOWY5QIGlOl/NIv+3Bny2Ka/4rfF+hgCtEpPRDnhyYGeqFdZXcYSmN5q5fhpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es; spf=pass smtp.mailfrom=amazon.es; dkim=pass (1024-bit key) header.d=amazon.es header.i=@amazon.es header.b=W11dvrCg; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.es
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.es
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1713350501; x=1744886501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=WbN+BlO16zXwRrb8HPGHeU4CvyJDye5MA3gIuv1x+KA=;
  b=W11dvrCgEvGE/7BtffHHvcEFg820cYejyZIvFV3W2V3pZnhxaoDXiAEG
   Nboa3BFlRcp3xFSDTAmw/aTF3/jSNSEButJhxe4Tf6xR6z+5KbaezaHa9
   5YbpGBUWsSgfFb0ujVzoS/NmU1ZiKfDNLq9wlEpIz0ACaDXcjb6dBRd0+
   U=;
X-IronPort-AV: E=Sophos;i="6.07,209,1708387200"; 
   d="scan'208";a="627060427"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Apr 2024 10:41:38 +0000
Received: from EX19MTAEUA001.ant.amazon.com [10.0.43.254:30723]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.17.11:2525] with esmtp (Farcaster)
 id d81501cb-6f6a-4368-8395-4dfb7d7a90b3; Wed, 17 Apr 2024 10:41:36 +0000 (UTC)
X-Farcaster-Flow-ID: d81501cb-6f6a-4368-8395-4dfb7d7a90b3
Received: from EX19D037EUB003.ant.amazon.com (10.252.61.119) by
 EX19MTAEUA001.ant.amazon.com (10.252.50.192) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:41:34 +0000
Received: from f4d4887fdcfb.ant.amazon.com (10.106.83.20) by
 EX19D037EUB003.ant.amazon.com (10.252.61.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Wed, 17 Apr 2024 10:41:29 +0000
From: Babis Chalios <bchalios@amazon.es>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <olivia@selenic.com>,
	<herbert@gondor.apana.org.au>, <robh@kernel.org>, <krzk+dt@kernel.org>,
	<conor+dt@kernel.org>, <linux-crypto@vger.kernel.org>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sudanl@amazon.com>, <bchalios@amazon.es>, <graf@amazon.de>,
	<xmarcalx@amazon.co.uk>, <dwmw@amazon.co.uk>, Alexander Graf
	<graf@amazon.com>
Subject: [PATCH v6 0/5] virt: vmgenid: Add devicetree bindings support
Date: Wed, 17 Apr 2024 12:40:41 +0200
Message-ID: <20240417104046.27253-1-bchalios@amazon.es>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA003.ant.amazon.com (10.13.139.105) To
 EX19D037EUB003.ant.amazon.com (10.252.61.119)

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
`scripts/checkpatch.pl --strict v6-000*`.

Changelog with respect to version 5:
- Added myself as an author and in SoB of the patches. Kept Sudan
  as a co-author.

Changelog with respect to version 4:
- Removed __maybe_unused attribute from vmgenid_of_irq_handler since it
  is always compiled in (used by vmgenid_add_of).

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

Babis Chalios (5):
  virt: vmgenid: re-arrange code to make review easier
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

Reviewed-by: Alexander Graf <graf@amazon.com>

-- 
2.40.1


