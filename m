Return-Path: <linux-kernel+bounces-85165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0258186B15C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 15:12:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC8C21F25C76
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 14:12:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00B2015A491;
	Wed, 28 Feb 2024 14:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="yUr0DzH/"
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E3F1159575;
	Wed, 28 Feb 2024 14:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709129522; cv=none; b=mAmsxY9Qf82Sue5xJnjcdWNR/nZf19K9MN8UJ+ffIy2UfwVjo756b7jSc9rm72r1EFmbjeE1MbFYMuKCNAj+0A3++GQeREeQCjtq12HMtlIUVaXZw1zLnH6kfKb2kTHGpJKyD6AjuzS5BxAzjSiy9aOzBzQRnXt06NRNE4ghZMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709129522; c=relaxed/simple;
	bh=kRwKT2nXdupHrKIrXRnblKe07oe3mgSb8bWO/XnoAsU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dfJFyt6ZHmXkOC0MlDumm+EDIDlkxae4zhNOrPTcB5PwRN99f2hqGtE6J8RDF9+g5uNhRMhbWRio1aMV0z8MTVgwGzBDeBsOb38ewfMpz2rHCL7+pgBchX99ho+J6ArXalbx60tOuS8FDREJWmQ+kti48PEjdn/cUxRt4GLuB1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=yUr0DzH/; arc=none smtp.client-ip=198.47.19.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from lelv0265.itg.ti.com ([10.180.67.224])
	by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41SEBgOX100500;
	Wed, 28 Feb 2024 08:11:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1709129502;
	bh=3Qx3A+xXX4e1MRd4G68RT1Q+bW1auQBLREmBAiZjk/E=;
	h=From:To:CC:Subject:Date;
	b=yUr0DzH/8KxOrWY3aRupsZ/UoxQxkRig1AHSfHemKamhnbr8XYMmF4xvn5HLxEOkj
	 UJ4/tFXHwaZBNDUTX8s8EEFLebQeHvXGSiJkL78u5kIIy8cTwWOyBPmTjGx6ZZ9Vhx
	 pRtr34t1QmCDFZqud22ogdAYlL6CEiVJt6WQ+WLY=
Received: from DFLE112.ent.ti.com (dfle112.ent.ti.com [10.64.6.33])
	by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41SEBgYC004703
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Wed, 28 Feb 2024 08:11:42 -0600
Received: from DFLE105.ent.ti.com (10.64.6.26) by DFLE112.ent.ti.com
 (10.64.6.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 28
 Feb 2024 08:11:41 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 28 Feb 2024 08:11:41 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41SEBegS123204;
	Wed, 28 Feb 2024 08:11:41 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <benjamin.gaignard@collabora.com>, <sebastian.fricke@collabora.com>
CC: <laurent.pinchart@ideasonboard.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>, <andrzej.p@collabora.com>,
        <nicolas@ndufresne.ca>, <afd@ti.com>, <milkfafa@gmail.com>
Subject: [PATCH v6 0/3] Add V4L2 M2M Driver for E5010 JPEG Encoder
Date: Wed, 28 Feb 2024 19:41:37 +0530
Message-ID: <20240228141140.3530612-1-devarsht@ti.com>
X-Mailer: git-send-email 2.39.1
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
Link: https://gist.github.com/devarsht/39c1197742cc858c38860e8cab61666d

E5010 JPEG Encoder Manual tests :

Performance:
Link: https://gist.github.com/devarsht/2f9b30f28768d9f6e338fc5b7c1d1758

Functionality:
Link: https://gist.github.com/devarsht/f12743405b285f47a0ce9b0f9681acd3

Compression Quality:
Link: https://gist.github.com/devarsht/8fd9edbdbfda7b2f2fe464b17484ceaf

Multi Instance:
Link: https://gist.github.com/devarsht/dfcc17e85569bc05c62b069af82a289d

Devarsh Thakkar (3):
  media: dt-bindings: Add Imagination E5010 JPEG Encoder
  media: jpeg: Add reference quantization and huffman tables
  media: imagination: Add E5010 JPEG Encoder driver

---
Link to previous version of this series:
V2: https://lore.kernel.org/all/20230727112546.2201995-1-devarsht@ti.com/
V3: https://lore.kernel.org/all/20230816152210.4080779-1-devarsht@ti.com/
V4: https://lore.kernel.org/all/20240205114239.924697-1-devarsht@ti.com/

V3->V4 Range diff :
https://gist.github.com/devarsht/22a744d999080de6e813bcfb5a596272

V4->V5 Range diff :
https://gist.github.com/devarsht/298790af819f299a0a05fec89371097b

V5->V6 Range diff :
https://gist.github.com/devarsht/c89180ac2b0d2814614f2b59d0705c19

 .../bindings/media/img,e5010-jpeg-enc.yaml    |   75 +
 MAINTAINERS                                   |    7 +
 drivers/media/platform/Kconfig                |    1 +
 drivers/media/platform/Makefile               |    1 +
 drivers/media/platform/imagination/Kconfig    |   12 +
 drivers/media/platform/imagination/Makefile   |    3 +
 .../platform/imagination/e5010-core-regs.h    |  585 +++++++
 .../platform/imagination/e5010-jpeg-enc-hw.c  |  267 +++
 .../platform/imagination/e5010-jpeg-enc-hw.h  |   42 +
 .../platform/imagination/e5010-jpeg-enc.c     | 1553 +++++++++++++++++
 .../platform/imagination/e5010-jpeg-enc.h     |  169 ++
 .../platform/imagination/e5010-mmu-regs.h     |  311 ++++
 include/media/jpeg-enc-reftables.h            |  112 ++
 include/media/jpeg.h                          |    4 +
 14 files changed, 3142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/media/img,e5010-jpeg-enc.yaml
 create mode 100644 drivers/media/platform/imagination/Kconfig
 create mode 100644 drivers/media/platform/imagination/Makefile
 create mode 100644 drivers/media/platform/imagination/e5010-core-regs.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc-hw.h
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.c
 create mode 100644 drivers/media/platform/imagination/e5010-jpeg-enc.h
 create mode 100644 drivers/media/platform/imagination/e5010-mmu-regs.h
 create mode 100644 include/media/jpeg-enc-reftables.h

-- 
2.39.1


