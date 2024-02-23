Return-Path: <linux-kernel+bounces-78720-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F2B78617C5
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:25:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5513F28561E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:25:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD4EE86151;
	Fri, 23 Feb 2024 16:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b="IwexxEu3"
Received: from mx0a-00128a01.pphosted.com (mx0a-00128a01.pphosted.com [148.163.135.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 880AE84A43;
	Fri, 23 Feb 2024 16:22:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.135.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705354; cv=none; b=athxGLLFAGL79F7NxS4Tb2Tsvj3cJu/Xmf92DzHdNAM5BwLmBUXYWp1lbD9BB+p6jEFSJHhIglodkZ0niG/COCKqW/oDETOfT8AySsRZ+ivivDeylRMSWnZQ8OgBqiPkEINsVtbSHGYYG1Vrvr4870pEQUAjM95oWKIAwbGDshc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705354; c=relaxed/simple;
	bh=/vLgQrFwJEPLauOCnRVsxD4IFLYVgo2gFjfrUtYt3oY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WGiugGguFtZ233GDUOas1OVvMiQ4vgRS7obPPIK9QfxI8SzktuhzI1T5YA5Pm74+N3hwTGRvNxyc2+k2otaJNVzsJnE4PjxFli8UXHAbe4LvaVEOHjKY2pgYt/71jMv54LCFBqS7kVi4V1a+z9fZx5kO8OF16sSVsCkHP6qKBXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com; spf=pass smtp.mailfrom=analog.com; dkim=pass (2048-bit key) header.d=analog.com header.i=@analog.com header.b=IwexxEu3; arc=none smtp.client-ip=148.163.135.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=analog.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=analog.com
Received: from pps.filterd (m0167089.ppops.net [127.0.0.1])
	by mx0a-00128a01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NEqwng014764;
	Fri, 23 Feb 2024 11:22:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=analog.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=DKIM; bh=oFUn0e6fWFYT
	CZbbrqZsUmODUYxqH0R9/qbP33pHpJw=; b=IwexxEu3LRbgWPzY0f3yxng1DYCy
	y1Wk1NANUQjyyc9op0L9aQEXkH5jSdkxQqy1rhgASuvUuBsR22vEsXH+Yxoh7KY0
	ShjKpwPT2oX99DjbiXxp+IROvEaZMqOYvDSU+1bGZAYCpvWHvqOU+m+gfTPifu/x
	DKCmQTWPWY42XtpPg+TMBLdLHY+MOaWuSog4cpQ4AryAWZPkj47ceAD6NAUvrnXg
	/i1FIpjrkr51VTS7zr6gtpSVQij8QDgSYB0Y7svAxzFL8OPQ9rcppBHaBNWwFj2i
	DF1FOgXX7nMkRry763uv55jU9h1I/9+umsKJmefcD6dScPnncLCznzCbBg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21pf9xk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:22:10 -0500 (EST)
Received: from m0167089.ppops.net (m0167089.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.24/8.17.1.24) with ESMTP id 41NGKI3f017473;
	Fri, 23 Feb 2024 11:22:09 -0500
Received: from nwd2mta3.analog.com ([137.71.173.56])
	by mx0a-00128a01.pphosted.com (PPS) with ESMTPS id 3wd21pf9xf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 11:22:09 -0500 (EST)
Received: from ASHBMBX8.ad.analog.com (ASHBMBX8.ad.analog.com [10.64.17.5])
	by nwd2mta3.analog.com (8.14.7/8.14.7) with ESMTP id 41NGM80a054843
	(version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
	Fri, 23 Feb 2024 11:22:08 -0500
Received: from ASHBCASHYB4.ad.analog.com (10.64.17.132) by
 ASHBMBX8.ad.analog.com (10.64.17.5) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 11:22:07 -0500
Received: from ASHBMBX8.ad.analog.com (10.64.17.5) by
 ASHBCASHYB4.ad.analog.com (10.64.17.132) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.14; Fri, 23 Feb 2024 11:22:07 -0500
Received: from zeus.spd.analog.com (10.66.68.11) by ashbmbx8.ad.analog.com
 (10.64.17.5) with Microsoft SMTP Server id 15.2.986.14 via Frontend
 Transport; Fri, 23 Feb 2024 11:22:07 -0500
Received: from debian.ad.analog.com ([10.48.65.188])
	by zeus.spd.analog.com (8.15.1/8.15.1) with ESMTP id 41NGLkd8017870;
	Fri, 23 Feb 2024 11:21:50 -0500
From: Ciprian Regus <ciprian.regus@analog.com>
To: <linux-kernel@vger.kernel.org>
CC: Ciprian Regus <ciprian.regus@analog.com>, Nuno Sa <nuno.sa@analog.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, "Simon
 Horman" <horms@kernel.org>,
        Michal Simek <michal.simek@amd.com>, Mark Brown
	<broonie@kernel.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "Amit Kumar
 Mahapatra" <amit.kumar-mahapatra@amd.com>,
        Dell Jin
	<dell.jin.code@outlook.com>, <netdev@vger.kernel.org>
Subject: [net-next v2] net: ethernet: adi: adin1110: Reduce the MDIO_TRDONE poll interval
Date: Fri, 23 Feb 2024 18:21:27 +0200
Message-ID: <20240223162129.154114-1-ciprian.regus@analog.com>
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
X-Proofpoint-GUID: 63px5bI0bZY2T_lLrSo_BQ0u28-f8xiP
X-Proofpoint-ORIG-GUID: 5Y42PkLbr5XPh30Fp7Yl_JyYdeiND7n0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-23_02,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 suspectscore=0 malwarescore=0 mlxlogscore=791 priorityscore=1501
 impostorscore=0 clxscore=1011 lowpriorityscore=0 bulkscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230119

In order to do a clause 22 access to the PHY registers of the ADIN1110,
we have to write the MDIO frame to the ADIN1110_MDIOACC register, and
then poll the MDIO_TRDONE bit (for a 1) in the same register. The
device will set this bit to 1 once the internal MDIO transaction is
done. In practice, this bit takes ~50 - 60 us to be set.

The first attempt to poll the bit is right after the ADIN1110_MDIOACC
register is written, so it will always be read as 0. The next check will
only be done after 10 ms, which will result in the MDIO transactions
taking a long time to complete. Reduce this polling interval to 100 us.
Since this interval is short enough, switch the poll function to
readx_poll_timeout_atomic() instead.

Reviewed-by: Nuno Sa <nuno.sa@analog.com>
Signed-off-by: Ciprian Regus <ciprian.regus@analog.com>
---
Changelog v1 -> v2:
- switch readx_poll_timeout() to readx_poll_timeout_atomic()

 drivers/net/ethernet/adi/adin1110.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/adi/adin1110.c b/drivers/net/ethernet/adi/adin1110.c
index d7c274af6d4d..8b4ef5121308 100644
--- a/drivers/net/ethernet/adi/adin1110.c
+++ b/drivers/net/ethernet/adi/adin1110.c
@@ -466,4 +466,5 @@ static int adin1110_mdio_read(struct mii_bus *bus, int phy_id, int reg)
 	 */
-	ret = readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
-				 (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
+	ret = readx_poll_timeout_atomic(adin1110_read_mdio_acc, priv, val,
+					(val & ADIN1110_MDIO_TRDONE),
+					100, 30000);
 	if (ret < 0)
@@ -497,4 +498,5 @@ static int adin1110_mdio_write(struct mii_bus *bus, int phy_id,
 
-	return readx_poll_timeout(adin1110_read_mdio_acc, priv, val,
-				  (val & ADIN1110_MDIO_TRDONE), 10000, 30000);
+	return readx_poll_timeout_atomic(adin1110_read_mdio_acc, priv, val,
+					 (val & ADIN1110_MDIO_TRDONE),
+					 100, 30000);
 }
-- 
2.39.2


