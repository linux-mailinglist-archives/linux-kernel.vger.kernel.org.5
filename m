Return-Path: <linux-kernel+bounces-68454-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E028857A68
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:38:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F33D11F234A0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:38:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1819E524A7;
	Fri, 16 Feb 2024 10:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="zLGiLBps"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C57975024B;
	Fri, 16 Feb 2024 10:37:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708079876; cv=none; b=tOMUib/PqSVjhINvGd5s/oMbJKu+5TbMyD0huJ8L46jAU3RlWPwLoy6whnMFoUn51IsZF/FsOq3KfbdiGnK0Tuys4feK023vG9Fp9DY1q6FvqAkYbtMr+kGocS4eS9bD44tw1BWOykVSRQTJJeWnrMm2ZxyAbyk6oSV6ojSaEbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708079876; c=relaxed/simple;
	bh=7w5jv6QBk2/9lvLC8JIUUMdOq38VCmIKWqk57My91PY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NAIb1TEMOwDtxPYQwB5RlLdGqvL0EIv3scvOmnhQq2GdneuRdAZ0mpZuildADrUod2xVwrOGPZSw17nLdQMwYsD3c0bf8JkkM94K4ntkuwKOKZi/Gcosz7O5lKarsr7TXBUfJPTMXM+6PxhEtEhhaCYKwP4C8hpMcCwak2wl1Po=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=zLGiLBps; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41G8fACY027604;
	Fri, 16 Feb 2024 05:37:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=B9bLeUCJqfKS
	KnaFxbVP0cIjyGkssCt+mEyA8pb9+8c=; b=zLGiLBpswe9EbCqe+UAuMKtQeRyl
	IQXpaXEzUHB+g/fWVw/tdJGIZSKH/nT0xGseUGOpjtY3Uru0sVyJ9fgNDvlrvhaG
	ZyofzOpn1Q3Tof/1e5HyEAWrbKA2mVGXiXqxo7UXdwcjDwnxWZraWU939+2NKWkU
	oVIXbZwRSKPSzNRiGBa/V41/LrHbG8nRwTRgVkD/wgCDWbRFElxN06eKvzlD62DQ
	myooyP7vLdgG8vLWCR7rpWFw+KxRVSpwuVSR6mEo9KupmQkgQOXrGZ/yw6OmcYLQ
	ul/tVkverWVJ++vpaj2aBraMbdF35h9T5wX1tU1KBensItt5eWfZ7n0gRA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w92gcgj6n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 05:37:38 -0500 (EST)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 41GAbc6u025252;
	Fri, 16 Feb 2024 05:37:38 -0500
Received: from nwd2mta4.analog.com ([137.71.173.58])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3w92gcgj6k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 05:37:38 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta4.analog.com (8.14.7/8.14.7) with ESMTP id 41GAbbdV011414
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 16 Feb 2024 05:37:37 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 Feb 2024 05:37:36 -0500
Received: from ASHBMBX9.ad.analog.com (10.64.17.10) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 16 Feb 2024 05:37:36 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx9.ad.analog.com
 (10.64.17.10) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 16 Feb 2024 05:37:36 -0500
Received: from debian.ad.analog.com ([10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41GAbG9P004173;
	Fri, 16 Feb 2024 05:37:19 -0500
From: Ciprian Regus <ciprian.regus@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: Ciprian Regus <ciprian.regus@analog.com>,
        "David S. Miller"
	<davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski
	<kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>,
        Dell Jin <dell.jin.code@outlook.com>,
        "Amit Kumar
 Mahapatra" <amit.kumar-mahapatra@amd.com>,
        Yang Yingliang
	<yangyingliang@huawei.com>, <netdev@vger.kernel.org>
Subject: [net-next] net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE poll interval
Date: Fri, 16 Feb 2024 12:36:32 +0200
Message-ID: <20240216103636.1231815-1-ciprian.regus@analog.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ADIRuleOP-NewSCL: Rule Triggered
X-Proofpoint-GUID: m7CAQch-jsXTH0TAdM9zbKcBG5odpx97
X-Proofpoint-ORIG-GUID: 3bZ3h3fFse4KJ4_pUxIIwv7L30dHJ7wo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_08,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1011 priorityscore=1501 phishscore=0 spamscore=0 adultscore=0
 impostorscore=0 malwarescore=0 mlxlogscore=521 bulkscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2401310000 definitions=main-2402160086

In order to do a clause 22 access to the PHY registers of the ADIN1110,
we have to write the MDIO frame to the ADIN1110_MDIOACC register, and
then poll the MDIO_TRDONE bit (for a 1) in the same register. The
device will set this bit to 1 once the internal MDIO transaction is
done. In practice, this bit takes ~50 - 60 us to be set.

The first attempt to poll the bit is right after the ADIN1110_MDIOACC
register is written, so it will always be read as 0. The next check will
only be done after 10 ms, which will result in the MDIO transactions
taking a long time to complete. Reduce this polling interval to 100 us.

Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
 drivers/net/ethernet/adi/adin1110.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index d7c274af6d4d..6fca19e6ae67 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -467,3 +467,3 @@ static int adin1110_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	ret = readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
-				 (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
+				 (val & ADIN1110_MDIO_TRDONE), 100, 30000);
 	if (ret < 0)
@@ -498,3 +498,3 @@ static int adin1110_mdio_write(struct mii_bus *bus, int phy_id,
 	return readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
-				  (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
+				  (val & ADIN1110_MDIO_TRDONE), 100, 30000);
 }
-- 
2.39.2


