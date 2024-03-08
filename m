Return-Path: <linux-kernel+bounces-96962-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 107E78763D6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F8F01C210F4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 11:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0EA5A56743;
	Fri,  8 Mar 2024 11:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="O/Id0pPJ"
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D72C355E67;
	Fri,  8 Mar 2024 11:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709899056; cv=none; b=mexZ3/LiHtvHSU9myQvsZaA07VCIMLBIMQ4wUJdKBZS4zGxe8YO+DgeH/V5CvbseK+SRv8CuIF0ph+Cq4FpuQGHhKXxZniw9LTbwPa/sNrUqdJXHRpnvESsNhjg8rA2hOXGD6+xdR78SEra/zb98A27RRmH1M2NtMJmv1kFVukw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709899056; c=relaxed/simple;
	bh=DzlNhTdtaAPy9EN5c8XbLQyzGsKEJ42CHwm+9COqjpI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PECQLDtRhLD+BD1mVspFkF8mYzOek2TtWxqCZTqSbmQQodqKd2aWgGGUmKGJ6I07I6sZeh38zOdXExTyHNqsLqnXJ1czkeL9UXyevYtdtWkwjGW0Ras7CsEQmqSgvjX1NYN6r/xtDn1CQvTnN+aY8lV06cwM/rYGZuZHJ+9oL64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=O/Id0pPJ; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 428AQPZV000972;
	Fri, 8 Mar 2024 03:57:28 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:mime-version:content-type; s=
	pfpt0220; bh=csPbFyhLfxTSJpj883qo9hObBQB7Y+/gUU7b/QaiEf4=; b=O/I
	d0pPJ3EmDZ8SPw43qHL5l+0GMAZFwVXgvZHgrRei5jrwnadRui55tr5Ui9HcYnNn
	yaOe2/k5oYYk2OhVEBhtHLO0F6ii7ILbVW8CZ63ghbDwiD3ps4j1AQlCtC4QBJjA
	U1p9zp6qLV9VXPgF9kJLpCdecyH/f7qPM9S1z5iQmUodcsoHmF3zmyFWmsrv8d2l
	/BK99C7JGrjgfIX8MoBJCqh+LSrM3jLwRD2p7YsqnBs0n653rgPHRY35ouuqkLCf
	3yiNPay8ulam/82w2fKhd3fk1vkEJNa+uN9VRQiAhmgho1L3n1KV++YW+up97AS3
	9EdprAvqF89nI2+L5/w==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3wr0x0071u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 03:57:27 -0800 (PST)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.12; Fri, 8 Mar 2024 03:57:26 -0800
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1258.12 via Frontend
 Transport; Fri, 8 Mar 2024 03:57:26 -0800
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id 7B4BD5B6928;
	Fri,  8 Mar 2024 03:57:23 -0800 (PST)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net PATCH] octeontx2-pf: Do not use HW TSO when gso_size < 16bytes
Date: Fri, 8 Mar 2024 17:27:22 +0530
Message-ID: <20240308115722.14671-1-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-GUID: Frwh1QSJLHuf3asZq6_AMxAcMf1xhOLE
X-Proofpoint-ORIG-GUID: Frwh1QSJLHuf3asZq6_AMxAcMf1xhOLE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02

Hardware doesn't support packet segmentation when segment size
is < 16 bytes. Hence add an additional check and use SW 
segmentation in such case.

Fixes: 86d7476078b8 ("octeontx2-pf: TCP segmentation offload support").
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
index f828d32737af..2ac56abb3a0e 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_txrx.c
@@ -967,6 +967,13 @@ static bool is_hw_tso_supported(struct otx2_nic *pfvf,
 {
 	int payload_len, last_seg_size;
 
+	/* Due to hw issue segment size less than 16 bytes
+	 * are not supported. Hence do not offload such TSO
+	 * segments.
+	 */
+	if (skb_shinfo(skb)->gso_size < 16)
+		return false;
+
 	if (test_bit(HW_TSO, &pfvf->hw.cap_flag))
 		return true;
 
-- 
2.25.1


