Return-Path: <linux-kernel+bounces-20524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E9D828022
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 09:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A28661C245FE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 08:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA8013AE3;
	Tue,  9 Jan 2024 08:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="FSe3mU1j"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BAD729410;
	Tue,  9 Jan 2024 08:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.helo=mx0b-0016f401.pphosted.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 40967CDR025033;
	Tue, 9 Jan 2024 00:10:51 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=zLW6cbF3
	JrGJxn4kgxx++71eFi2X1lzPoT/sA8ETBds=; b=FSe3mU1jXa3hVoPn3TkaDHdP
	mAZjocthhQ/fmdAcGRFGv0ALDzSAZ/gVDCnFm9cTLsx6bi0DMgF4WTtO7qtN4NAF
	bL4+6yv8hWdLV/YdmQeZAHpAtINF3kstafclrkCD+z1a22/yAYURf5h6og8yq7Fw
	pxIzOWO7dj0sgqt/SejXs7KMuOeux+DGRPdeqd1czJ19Tuoo4oEWHF2uG/ZnfR8g
	LWSHTsNzZFipAzb08+uDBHQU4sOrJLm6dltKUNmgFN8RT5u2HGzlnsYpzqFGuW4e
	vfS2MxzL7vXJEMDLX8uOWnERWoqWUfCVDRymPi1QcHYSaIWpitKi18UXKBmmBg==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3vgptf2hgc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Tue, 09 Jan 2024 00:10:50 -0800 (PST)
Received: from DC5-EXCH01.marvell.com (10.69.176.38) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Tue, 9 Jan
 2024 00:10:48 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Tue, 9 Jan 2024 00:10:48 -0800
Received: from dc3lp-swdev041.marvell.com (dc3lp-swdev041.marvell.com [10.6.60.191])
	by maili.marvell.com (Postfix) with ESMTP id 482ED3F70B4;
	Tue,  9 Jan 2024 00:10:46 -0800 (PST)
From: Elad Nachman <enachman@marvell.com>
To: <gregkh@linuxfoundation.org>,
        rowland.harvard.edu@mx0b-0016f401.pphosted.com, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <devicetree@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC: <enachman@marvell.com>
Subject: [PATCH v3 0/2] usb: host: Add ac5 to EHCI Orion
Date: Tue, 9 Jan 2024 10:10:42 +0200
Message-ID: <20240109081044.10515-1-enachman@marvell.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: zqmC9T8YyQFuydgE9YVdS51K4jIKgMvo
X-Proofpoint-GUID: zqmC9T8YyQFuydgE9YVdS51K4jIKgMvo
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

v3:
   1) Combine dt bindings and driver pathces into a single patchset.

v2:
   1) Fix compiler warning

Elad Nachman (2):
  dt-bindings: usb: Add Marvell ac5
  usb: host: Add ac5 to EHCI Orion

 .../devicetree/bindings/usb/generic-ehci.yaml |  1 +
 drivers/usb/host/ehci-orion.c                 | 19 +++++++++++++++----
 2 files changed, 16 insertions(+), 4 deletions(-)

-- 
2.25.1

