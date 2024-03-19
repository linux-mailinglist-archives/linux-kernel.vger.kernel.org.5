Return-Path: <linux-kernel+bounces-107652-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F1FF87FFA6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 15:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 14F1B1F249B8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 14:33:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C0F2200BF;
	Tue, 19 Mar 2024 14:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="n4FfMuZW"
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A9746BF;
	Tue, 19 Mar 2024 14:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710858797; cv=none; b=EijuFsBTyGND5n8O4se67FtB9J9A6/rmLI08c8lcEGeBMhbni4KT8/+nM48vgEnEgKfzJCt25RIooQM1Tlk7cOyE0jVVQ96WxsBLdcyzQdMsWB4OQ74G6ujRC5MWGvoyz+WF7o5HZzcdCRxRE1ntNxXOe5Q0JadDws7dRh60WSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710858797; c=relaxed/simple;
	bh=YR9u0M+uAknRosLbOW4CUsSV41e8LH2Ktv9Ou+XCzac=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=KZKEhZA3SOXBGXKVUJ/3pY1TQsBzZfKxyJStQv6lGocBZ2zbvz1U+Xnz/uLyZ+2h6DAwnuzDCDJeN+cPOeJNPyKW3Wj16MQguzVPGdCa21H4p0+7IoJGAbUy/kudLwVGP33jzw7jNMO+I7QNYtsvi8iOl5Ypn33UT844FS57crs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.uk; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=n4FfMuZW; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.uk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1710858796; x=1742394796;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7chCwmjvcKwdRDMg/KUnuBlj1+hgueNS7eq72Sg7bgc=;
  b=n4FfMuZWUPSg6EQNL/alRBNTWIz1fcXK/bBPsgY1xTpPB8n8Cbf7JBds
   0lAqhyYF3gdt8gyTtUlleDqw4kzgOLlCriKUyPZKLhketbrbKMWyhMgN8
   hSAD1JSiAhTq9HQia8m1PiU+gqOecOdglS4ujej9TrrMMQATNJgD38NoT
   I=;
X-IronPort-AV: E=Sophos;i="6.07,137,1708387200"; 
   d="scan'208";a="281151282"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Mar 2024 14:33:11 +0000
Received: from EX19MTAEUB001.ant.amazon.com [10.0.43.254:57997]
 by smtpin.naws.eu-west-1.prod.farcaster.email.amazon.dev [10.0.44.205:2525] with esmtp (Farcaster)
 id 95b839fb-0be7-4cdc-8180-c37e26cdca51; Tue, 19 Mar 2024 14:33:08 +0000 (UTC)
X-Farcaster-Flow-ID: 95b839fb-0be7-4cdc-8180-c37e26cdca51
Received: from EX19D036EUC002.ant.amazon.com (10.252.61.191) by
 EX19MTAEUB001.ant.amazon.com (10.252.51.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:08 +0000
Received: from bcd074994f7f.amazon.com (10.106.83.11) by
 EX19D036EUC002.ant.amazon.com (10.252.61.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 19 Mar 2024 14:33:03 +0000
From: Sudan Landge <sudanl@amazon.com>
To: <tytso@mit.edu>, <Jason@zx2c4.com>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<sudanl@amazon.com>, <sathyanarayanan.kuppuswamy@linux.intel.com>,
	<thomas.lendacky@amd.com>, <dan.j.williams@intel.com>,
	<devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <graf@amazon.de>, <dwmw@amazon.co.uk>, <bchalios@amazon.es>,
	<xmarcalx@amazon.co.uk>
Subject: [PATCH v1 0/4] virt: vmgenid: Add devicetree bindings support
Date: Tue, 19 Mar 2024 14:32:49 +0000
Message-ID: <20240319143253.22317-1-sudanl@amazon.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWA004.ant.amazon.com (10.13.139.76) To
 EX19D036EUC002.ant.amazon.com (10.252.61.191)

This small series of patches aims to add devicetree bindings support for
the Virtual Machine Generation ID (vmgenid) driver.

Virtual Machine Generation ID driver was introduced in commit af6b54e2b5ba
("virt: vmgenid: notify RNG of VM fork and supply generation ID") as an
ACPI only device.
We would like to extend vmgenid to support devicetree bindings because:
1. A device should not be defined as an ACPI or DT only device.
2. Technically there's no issue with adding devicetree support to vmgenid.
3. This would allow Hypervisors to use vmgenid without the need to
   enable ACPI. This is important for hypervisors that want to
   keep things minimalistic and enable ACPI only when they have
   no other alternative.

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


Sudan Landge (4):
  virt: vmgenid: rearrange code to make review easier
  virt: vmgenid: change implementation to use a platform driver
  dt-bindings: Add bindings for vmgenid
  virt: vmgenid: add support for devicetree bindings

 .../devicetree/bindings/vmgenid/vmgenid.yaml  |  57 +++++
 MAINTAINERS                                   |   1 +
 drivers/virt/Kconfig                          |   2 +-
 drivers/virt/vmgenid.c                        | 197 ++++++++++++++----
 4 files changed, 221 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/vmgenid/vmgenid.yaml

-- 
2.40.1


