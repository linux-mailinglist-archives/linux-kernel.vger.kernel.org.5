Return-Path: <linux-kernel+bounces-25523-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B323882D1CB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 18:45:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20D0281CB5
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Jan 2024 17:45:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E76D4FC03;
	Sun, 14 Jan 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="J9/m3Vr/"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1379810782;
	Sun, 14 Jan 2024 17:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40EGuBSX008520;
	Sun, 14 Jan 2024 09:22:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=+NApP6qT
	mQ4AKodWmINcS/F2b3kbziXPhqKbPOpqufA=; b=J9/m3Vr/kHwDosxPBaBXVSrz
	YxCRatocmk66TCpS6VMyTaQGRlQLrCOmSRQ3Qwng+SOoNcKH3qLjIRebXM8tYvTj
	YkLWX/1Yu1pJuhs+5hkpUHpaFPptUkKZfVxL0XVor8jadt92ZmzWmMs7583OQmXY
	sllK9/gRx3EABA0dTlMfsSzXMzxQgv8X8GWFd5PZI199q2MHkeBZgr+IGwhTpKpJ
	KnBilmb8glqVha2ENwzxybLp2oBWc2wZTKa04X/ZteJ+GPonQH3iUeexcxLb3ca7
	0SyqDyJ7MkIhUPHo5TxyMYfq0uUY30SHhCj+QYrIYy4C3yj00pG0dXob7b08XA==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vktwkafqs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Sun, 14 Jan 2024 09:22:00 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 14 Jan
 2024 09:21:58 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Sun, 14 Jan 2024 09:21:58 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id CF52F5E6871;
	Sun, 14 Jan 2024 09:21:55 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <gregkh@linuxfoundation.org>,
        rowland.harvard.edu@mx0b-0016f401.pphosted.com, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v4 0/2] usb: host: Add ac5 to EHCI Orion
Date: Sun, 14 Jan 2024 19:21:52 +0200
Message-ID: <20240114172154.2622275-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: cakscuFG5GXdvM3VVGX6_amy6PrBMR7C
X-Proofpoint-GUID: cakscuFG5GXdvM3VVGX6_amy6PrBMR7C
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Elad Nachman <enachman@marvell.com>

Add support for ac5 to the EHCI Orion platform driver.
The ac5 SOC has DDR starting at offset 0x2_0000_0000,
Hence it requires a larger than 32-bit DMA mask to operate.
Move the dma mask to be pointed by the OF match data, and
use that match data when initializng the DMA mask.
Add dt bindings compatible string to identify the AC5 SOC,
so the driver will know when to apply this different dma mask.

v4:
   1) Fix kernel test robot error (missing null entry in dt
      compatibility array)

v3:
   1) Combine dt bindings and driver pathces into a single patchset.

v2:
   1) Fix compiler warning

Elad Nachman (2):
  dt-bindings: usb: Add Marvell ac5
  usb: host: Add ac5 to EHCI Orion

 .../devicetree/bindings/usb/generic-ehci.yaml  |  1 +
 drivers/usb/host/ehci-orion.c                  | 18 +++++++++++++++---
 2 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.25.1

