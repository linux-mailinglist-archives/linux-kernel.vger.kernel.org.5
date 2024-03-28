Return-Path: <linux-kernel+bounces-122850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E60F88FE62
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 12:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 279AA296742
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 11:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D2B7E58F;
	Thu, 28 Mar 2024 11:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="IWdW9T4Y"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6187A52F6F;
	Thu, 28 Mar 2024 11:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711626768; cv=none; b=HRuFfa9oRR8rDf2IRwfj8S3B/1joPwwEIim+OkDg3yANhuzLioU3wV5nwIQHc6kLKowfLQQb/siUl7jMg4l+GTvY1Ps7IoT54zYisc18BbdVQMjAOlaI4wZUIq9scK4sDsTOuN/Iv1eHZQoISf7xR+vc1aSxm5Pedg+13iHTKM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711626768; c=relaxed/simple;
	bh=Tp87Cu7DYRbh9aPPPaiVsOQfzBOnon6nxNVzKwzCOGg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjpBYJe5hCOFZoQPRpjTw6GZeSSyKDsVuGr58CtMcW1n56VWRh0roBFiimqQnCiPkrKvxpvDG/KarUddqa3uqoNiZGeJTozXhlq2ImET5PY+C6iaZgfYUnsyud+O92InXGOyzwfSvRvnyAFMFBaIF0hX6TNRK/M23BCRwwDaNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=IWdW9T4Y; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42SAiRoi023191;
	Thu, 28 Mar 2024 04:52:44 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=ugiikGmj
	wNIiiP1OC5uxti03vl6L743nV0wP4w4tDIw=; b=IWdW9T4YcOgrwMwrdN800pXm
	pEVCxKJDbTYWeYNjGG6j5cxNiqxIbbtYmP20BcMXntTaSPmh7zz8jUzFuBMphvQt
	wYjqukbViQh5QBg+cRaON6BMvb8roW8Re8kHoENXK2q2sCz8Xlh9IBFlX8HMPgfY
	dp49raXYypQntxTtqREMsqFdMjbGBhS2pQI2HJ5rg7ktvLWtDgqT9Oom3uQLzmOc
	4YiQepy7UC2WR2Ip/H1kTkgj9uGwCF3itj3Km0WP53kFY5S6M9Krlp95eXmKyBf8
	Boy3ystTbUzV9bBK9QBpCi/FgovljotL9OQ2Jcbk1kNhD4pVRMidvgiuaG3xVA==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3x572c8axe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Mar 2024 04:52:44 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Thu, 28 Mar 2024 04:52:43 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Thu, 28 Mar 2024 04:52:43 -0700
Received: from localhost.localdomain (unknown [10.110.150.170])
	by maili.marvell.com (Postfix) with ESMTP id B43973F708A;
	Thu, 28 Mar 2024 04:52:42 -0700 (PDT)
From: Witold Sadowski <wsadowski@marvell.com>
To: <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <broonie@kernel.org>
CC: Witold Sadowski <wsadowski@marvell.com>
Subject: [PATCH] mtd: spi-nor: macronix: Add support for mx25um51245g
Date: Thu, 28 Mar 2024 04:52:25 -0700
Message-ID: <20240328115225.1783-1-wsadowski@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: 62PCkdvDPtmKO1VF7FubaGENo9wK2KsR
X-Proofpoint-ORIG-GUID: 62PCkdvDPtmKO1VF7FubaGENo9wK2KsR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-28_11,2024-03-27_01,2023-05-22_02

The Macronix mx25um51245g is a 1.8V, 512Mbit (64MB) device that
supports x1, or x8 operation.

Tested on Marvell Octeon SoC hardware with a Cadence xSPI controller.

Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
---
 drivers/mtd/spi-nor/macronix.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/mtd/spi-nor/macronix.c b/drivers/mtd/spi-nor/macronix.c
index ea6be95e75a5..f5fbdb7912e0 100644
--- a/drivers/mtd/spi-nor/macronix.c
+++ b/drivers/mtd/spi-nor/macronix.c
@@ -182,6 +182,12 @@ static const struct flash_info macronix_nor_parts[] = {
 		.name = "mx25l3255e",
 		.size = SZ_4M,
 		.no_sfdp_flags = SECT_4K,
+	}, {
+                .id = SNOR_ID(0xc2, 0x80, 0x3a),
+                .name = "mx25um51245g",
+                .size = SZ_64M,
+                .no_sfdp_flags = SECT_4K,
+                .fixup_flags = SPI_NOR_4B_OPCODES,
 	}
 };
 
-- 
2.17.1


