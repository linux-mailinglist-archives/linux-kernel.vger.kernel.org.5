Return-Path: <linux-kernel+bounces-17524-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55CB5824ED6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 07:54:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E68F2B22D70
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 06:54:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A05B2134A2;
	Fri,  5 Jan 2024 06:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="C235nB2A"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57E1612F;
	Fri,  5 Jan 2024 06:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4052qJe1025139;
	Thu, 4 Jan 2024 22:54:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=pfpt0220; bh=FXXZmgEd
	rQ5Dl7tnuNrdMEihuFNy4KvIdoE9yJfOVZo=; b=C235nB2AH39f3VOJVviBfdED
	ODuxTwzw1gNSHIu4s4NuwVKaDxXJByX0Iz54JnoKkKZLovEajcppCGObRCPBBkrl
	KStZ0T1UKrCKx8q3gZ3Rn88Fwb+9op6evRXEwOy8CBJEQ5dQDcXLjqcB/keK/b5+
	4lI7IGDDL5HHPIGPaXSsRJCPJ8IUyFfn8Z0hZDK+X3TmJPlhOn4VJOkclBePW5cF
	Jg24Ozeu6Pt/rKATPdcOfq0czOkCRQzVVRI6hvfk8YPlfy9pINHGC/mcN1J5JL3m
	s7KH08QeJbuwu6cQgeT4kKJGS6KuCTSE4Kt2IeKcpha0xSIQUw/R+N3L45dR5A==
Received: from dc5-exch01.marvell.com ([199.233.59.181])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3ve9c7gjf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
	Thu, 04 Jan 2024 22:54:33 -0800 (PST)
Received: from DC5-EXCH02.marvell.com (10.69.176.39) by DC5-EXCH01.marvell.com
 (10.69.176.38) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Thu, 4 Jan
 2024 22:54:32 -0800
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH02.marvell.com
 (10.69.176.39) with Microsoft SMTP Server id 15.0.1497.48 via Frontend
 Transport; Thu, 4 Jan 2024 22:54:32 -0800
Received: from #hyd1583.marvell.com (unknown [10.29.37.44])
	by maili.marvell.com (Postfix) with ESMTP id 33DF53F704F;
	Thu,  4 Jan 2024 22:54:28 -0800 (PST)
From: Naveen Mamindlapalli <naveenm@marvell.com>
To: <davem@davemloft.net>, <kuba@kernel.org>, <edumazet@google.com>,
        <pabeni@redhat.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <sgoutham@marvell.com>
CC: Nithin Dabilpuram <ndabilpuram@marvell.com>,
        Naveen Mamindlapalli
	<naveenm@marvell.com>
Subject: [net PATCH] octeontx2-af: CN10KB: Fix FIFO length calculation for RPM2
Date: Fri, 5 Jan 2024 12:24:23 +0530
Message-ID: <20240105065423.714-1-naveenm@marvell.com>
X-Mailer: git-send-email 2.39.0.198.ga38d39a4c5
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: SRHvoCpTTMVVOuN7hwSmeMr49WRl_np9
X-Proofpoint-ORIG-GUID: SRHvoCpTTMVVOuN7hwSmeMr49WRl_np9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-09_02,2023-12-07_01,2023-05-22_02

From: Nithin Dabilpuram <ndabilpuram@marvell.com>

RPM0 and RPM1 on the CN10KB SoC have 8 LMACs each, whereas RPM2
has only 4 LMACs. Similarly, the RPM0 and RPM1 have 256KB FIFO,
whereas RPM2 has 128KB FIFO. This patch fixes an issue with
improper TX credit programming for the RPM2 link.

Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
Signed-off-by: Naveen Mamindlapalli <naveenm@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/af/rpm.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
index 4728ba34b0e3..76218f1cb459 100644
--- a/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
+++ b/drivers/net/ethernet/marvell/octeontx2/af/rpm.c
@@ -506,6 +506,7 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
 	rpm_t *rpm = rpmd;
 	u8 num_lmacs;
 	u32 fifo_len;
+	u16 max_lmac;
 
 	lmac_info = rpm_read(rpm, 0, RPM2_CMRX_RX_LMACS);
 	/* LMACs are divided into two groups and each group
@@ -513,7 +514,11 @@ u32 rpm2_get_lmac_fifo_len(void *rpmd, int lmac_id)
 	 * Group0 lmac_id range {0..3}
 	 * Group1 lmac_id range {4..7}
 	 */
-	fifo_len = rpm->mac_ops->fifo_len / 2;
+	max_lmac = (rpm_read(rpm, 0, CGX_CONST) >> 24) & 0xFF;
+	if (max_lmac > 4)
+		fifo_len = rpm->mac_ops->fifo_len / 2;
+	else
+		fifo_len = rpm->mac_ops->fifo_len;
 
 	if (lmac_id < 4) {
 		num_lmacs = hweight8(lmac_info & 0xF);
-- 
2.39.0.198.ga38d39a4c5


