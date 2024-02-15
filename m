Return-Path: <linux-kernel+bounces-67011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 14F298564BE
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:47:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CA5432817B0
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF8F13174A;
	Thu, 15 Feb 2024 13:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="Ic7rX9oz"
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C03512BEAC;
	Thu, 15 Feb 2024 13:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.47.19.142
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004815; cv=none; b=YgMj9MYl5JutiIn1mF6asYmwBVug2XUHzkA0Ccy9DQmlh/zMC22TRsKuEz1iHqf672PP/fMQl/5hIsU3QQodMFrjYZzw+H5fo5qCuCuz1JeMI1XGXDWm6bVtloJcX36r1XGDsW1cIhRMrGA+5pXBhKCk49pcxHwxCimfGgYqdgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004815; c=relaxed/simple;
	bh=Jvck5V28EeMAtRRr4cd5+UtQYuoylrWAgA/9ubHgaTY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=vC/YuBmBxQW+MHj29tdze434d+fmLRJP5JYxUsMod9aKHLhECboYGYdDu1KtlVqTEv5TF4Urx3S+xFCD8wwViFFY3fH8gucaKEhzgcKzNxegBfyV4jWLZnp4TXo7g3/f8G2h3LVkHUE7UYK4Bidyo3lWLWp0R24YcLpsgcFT0SY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com; spf=pass smtp.mailfrom=ti.com; dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b=Ic7rX9oz; arc=none smtp.client-ip=198.47.19.142
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ti.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ti.com
Received: from fllv0035.itg.ti.com ([10.64.41.0])
	by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 41FDkgtI007299;
	Thu, 15 Feb 2024 07:46:42 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
	s=ti-com-17Q1; t=1708004802;
	bh=sWYu0ow55pn/SH9vLWnXPNSZ+oQPaMa/h4E6Dx21FkI=;
	h=From:To:CC:Subject:Date;
	b=Ic7rX9oz50azm9a5+FWIJxZAK9Jd+NVgXQPAeQQPJr1rrm39T3jJjnT3jUaa0d/at
	 k5IpI7rii1gmgISxLFOwCWJLV9WZ4RGTpx6qcj2tKe/cvcxNl2cTqHeCBL8OERXGb3
	 xjUKXRC5zRI2OcYHHSeBxFlAwIJvg0mIOvOnQoi0=
Received: from DFLE106.ent.ti.com (dfle106.ent.ti.com [10.64.6.27])
	by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 41FDkgOA106764
	(version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
	Thu, 15 Feb 2024 07:46:42 -0600
Received: from DFLE101.ent.ti.com (10.64.6.22) by DFLE106.ent.ti.com
 (10.64.6.27) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Feb 2024 07:46:42 -0600
Received: from lelvsmtp6.itg.ti.com (10.180.75.249) by DFLE101.ent.ti.com
 (10.64.6.22) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Feb 2024 07:46:42 -0600
Received: from localhost (ti.dhcp.ti.com [172.24.227.95] (may be forged))
	by lelvsmtp6.itg.ti.com (8.15.2/8.15.2) with ESMTP id 41FDkf4d052724;
	Thu, 15 Feb 2024 07:46:42 -0600
From: Devarsh Thakkar <devarsht@ti.com>
To: <mchehab@kernel.org>, <robh@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <hverkuil-cisco@xs4all.nl>, <linux-media@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <laurent.pinchart@ideasonboard.com>, <praneeth@ti.com>, <nm@ti.com>,
        <vigneshr@ti.com>, <a-bhatia1@ti.com>, <j-luthra@ti.com>,
        <b-brnich@ti.com>, <detheridge@ti.com>, <p-mantena@ti.com>,
        <vijayp@ti.com>, <devarsht@ti.com>, <andrzej.p@collabora.com>,
        <nicolas@ndufresne.ca>, <benjamin.gaignard@collabora.com>,
        <afd@ti.com>
Subject: [PATCH v5 0/3] Add V4L2 M2M Driver for E5010 JPEG Encoder
Date: Thu, 15 Feb 2024 19:16:38 +0530
Message-ID: <20240215134641.3381478-1-devarsht@ti.com>
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
Link: https://gist.github.com/devarsht/7ad3d344e11e2c17befbf16bc079f817

E5010 JPEG Encoder Manual tests :

Performance:
Link: https://gist.github.com/devarsht/02397fa4ecee5104898cba67ff08dd4f

Functionality:
Link: https://gist.github.com/devarsht/b2c4f537d7b0f822dd4da28ffdd970c0

Compression Quality:
Link: https://gist.github.com/devarsht/ef14fb216c9b5c484a712c94fffeb26b

Multi Instance:
Link: https://gist.github.com/devarsht/0e4949e72d55d0f608f7a28de5e2a4f9

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
 include/media/jpeg-enc-reftables.h            |  112 ++
 include/media/jpeg.h                          |    4 +
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
 create mode 100644 include/media/jpeg-enc-reftables.h

-- 
2.34.1


