Return-Path: <linux-kernel+bounces-52505-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3803C849918
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 12:43:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5CEA91C21AFF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 11:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0991AACE;
	Mon,  5 Feb 2024 11:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="G/ZcNpkz"
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D00918E0E;
	Mon,  5 Feb 2024 11:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.23.248
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707133375; cv=none; b=ZpYb9fXBwXn624SveXcMS5x7u/ky6YUI2Vmg5EYkTvKPj1vTyA8iFKY4Z4BVww61n73HFQH1hrcPM1gXpAClQk8MlwUl/hdH4TidBABz+rP2Y2cyh8KHSG8xbEZzupfu8bZQULWKCMkZTV1qh1ERsQk/1KoeIasm2zHNH0WbZZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707133375; c=relaxed/simple;
	bh=6s43kMGZiFeue14Qmd45XyvCrRq/cBRwlW/jGhTvluE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=fAA4qDUCu128BpCEKn/TZlsUhNXJfZhbdaCcYAYgRLa1eC9X+vZI7EgFPFL1p6dV6pPWK5+OlQqMf7AqzLF3ls+ll+h/F6/FiYjXC3aqdLWGgIRAsb1oMjJsg84IauJYgnF1FFUqt7iEQLbmBKaYw8wKyuX7Ry9LWkIIzMpY0T4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=G/ZcNpkz; arc=none smtp.client-ip=198.47.23.248
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0266.itg.ti.com ([10.180.67.225])
	by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 415Bgfdw011224;
	Mon, 5 Feb 2024 05:42:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1707133361;
	bh=uST3jK2WI/DTrtPhr9cCrI+PLMnSfDLKgoIV0RlUZa0=;
	h=From:To:CC:Subject:Date;
	b=G/ZcNpkzcdTXWvM5vyt5jo+17Kx5wQnSo+ZcuC9VQAQZoTMqDOhVdz4YoQFdtSj9/
	 gYTFfcEpL2QUNGX+5CX9z84tgeBH8BPOkXuNOP/k3RlFCMnddRjM6PEK4Sb0kab2Jr
	 4cXaTQUrdo/p7G5yaHpLAfWxefJ80o+trMlHkkqM=
Received: from DLEE114.ent.ti.com (dlee114.ent.ti.com [157.170.170.25])
	by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 415BgfQn069657
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Mon, 5 Feb 2024 05:42:41 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 5
 Feb 2024 05:42:40 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 5 Feb 2024 05:42:40 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 415Bgej3095143;
	Mon, 5 Feb 2024 05:42:40 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <mchehab@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <laurent.pinchart@ideasonboard.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>, <andrzej.p@collabora.com>,
        <nicolas@ndufresne.ca>
Subject: [PATCH v4 0/3] Add V4L2 M2M Driver for E5010 JPEG Encoder
Date: Mon, 5 Feb 2024 17:12:36 +0530
Message-ID: <20240205114239.924697-1-devarsht@ti.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180

This adds support for V4L2 M2M based driver for E5010 JPEG Encoder
which is a stateful JPEG encoder from Imagination technologies
and is present in TI AM62A SoC.

v4l2-compliance test :
Link: https://gist.github.com/devarsht/867b1d646bca3f3877edb1f3638aae31

E5010 JPEG Encoder Manual tests :

Performance:
Link: https://gist.github.com/devarsht/63d835093195181866ae9a85de880d3c

Functionality:
Link: https://gist.github.com/devarsht/253e485e86661a3051e711f97ec3c5ac

Compression Quality:
Link: https://gist.github.com/devarsht/e16d8b73c8107ac78cc77ad79fd6299f

Multi Instance:
Link: https://gist.github.com/devarsht/58af9ccf822963d2bf8f0c2f4481438a

Link to previous series:
https://lore.kernel.org/all/20230816152210.4080779-1-devarsht@ti.com/

Diff w.r.t previous series (git range-diff) :
https://gist.github.com/devarsht/22a744d999080de6e813bcfb5a596272

Devarsh Thakkar (3):
  media: dt-bindings: Add Imagination E5010 JPEG Encoder
  media: jpeg: Add reference quantization and huffman tables
  media: imagination: Add E5010 JPEG Encoder driver

 .../bindings/media/img,e5010-jpeg-enc.yaml    |   75 +
 MAINTAINERS                                   |    7 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/imagination/Kconfig    |   12 +
 drivers/media/platform/imagination/Makefile   |    3 +
 .../platform/imagination/e5010-core-regs.h    |  585 +++++++
 .../platform/imagination/e5010-jpeg-enc-hw.c  |  267 +++
 .../platform/imagination/e5010-jpeg-enc-hw.h  |   42 +
 .../platform/imagination/e5010-jpeg-enc.c     | 1552 +++++++++++++++++
 .../platform/imagination/e5010-jpeg-enc.h     |  169 ++
 .../platform/imagination/e5010-mmu-regs.h     |  311 ++++
 include/media/jpeg.h                          |    4 +
 include/media/jpeg_enc_reftables.h            |  112 ++
 14 files changed, 3141 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
 create mode 100644 drivers/media/platform/imagination/Kconfig
 create mode 100644 drivers/media/platform/imagination/Makefile
 create mode 100644 drivers/media/platform/imagination/e5010-core-regs.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.h
 create mode 100644 drivers/media/platform/imagination/e5010-mmu-regs.h
 create mode 100644 include/media/jpeg_enc_reftables.h

---
Changelog:
V1->V2: 
No change (sending dt-binding and driver together)

V2->V3:
- Add DONOTMERGE patches for dts and defconfig
- Update driver with below changes :
  - Correct license headers
  - Use more generic name core instead of jasper for base registers
  - Add Comment for forward declarations
  - Simplify quantization table calculations
  - Use v4l2_apply_frmsize_constraints for updating framesize and remove
    unrequired functions
  - Place TODO at top of file and in commit message too
  - Use dev_err_probe helper in probe function
  - Fix return value checking for failure scenarios in probe function
  - Use v4l2_err/info/warn helpers instead of dev_err/info/warn helpers
  - Fix unexpected indentation
  - Correct commit message
- Update dt-bindings with below changes :
  - Add vendor specific compatible 
  - Fix commit title and message
  - Update reg names
  - Update clocks to 1
  - Fix dts example with proper naming

V3->V4:
- Use ti-specific compatible ti,am62a-jpeg-enc as secondary one in
  dt-binding
- Remove clock-names as only single clock in dt-binding
- Fix issue with default params setting
- Correct v4l2 error prints
- Simplify register write functions with single statement return values
- Remove unrequired error checks from get_queue()
- Drop explicit device_caps setting as it is already taken care by v4l2
  core
- Remove unrequired multiplanar checks and memset from s_fmt, g_fmt callback functions
- Fix try_fmt callback to not update the queues
- Remove unrequired contiguous format attribute from queue_init
- Use dynamic allocation for video_device and remove unrequired
  assignments in probe()
- Remove unrequired checks from queue_setup function
- Return queued buffers back if start_streaming fails
- Use ARRAY_SIZE in place of hard-coding
- Use huffman and quantization tables from reference header file
-- 
2.34.1


