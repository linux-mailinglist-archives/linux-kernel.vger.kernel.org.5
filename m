Return-Path: <linux-kernel+bounces-161388-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDB1D8B4B69
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 12:56:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA0F1F219AF
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 10:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38BC864CE6;
	Sun, 28 Apr 2024 10:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="c81C5Mxl"
Received: from mx0b-0016f401.pphosted.com (mx0b-0016f401.pphosted.com [67.231.156.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0FBD626A0;
	Sun, 28 Apr 2024 10:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.156.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714301635; cv=none; b=Mx9iM8WlWt/g04jLxfH209ZuY42Y0IQPwdZWXLBhlI63G1lZRHOZ77nrDfgFZtpzlPNLAPzoNt1xiKzKqO3qq21nHcNa8sTJiIBcW52j9Zyuk984wSnnXGgORBbAbu9duHdRZq08eaiB3/tNlFxi28+pIMXFYI13gazIu3Ih95E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714301635; c=relaxed/simple;
	bh=bEQDIvb0GX7PNxv5OTNyjmTtzJTqPF6lrxLVhlQ89K8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hIqTqpYaK5/8wanBf6Gss7mr4rsuNg6C1SBA1jfDgbmS0UFFVmk+xeAl+W1gLRPwKj8m5iNbryQx7ZmverTUmhPTxmN118Taz+mJ96H8psMNZiMI4kWQerpKGv9QnZyds1NjEs18uG2HaXRZ+UNx3ThSeFOSpvMiZbDT+B+mfpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=c81C5Mxl; arc=none smtp.client-ip=67.231.156.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
	by mx0b-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43SAlckx030113;
	Sun, 28 Apr 2024 03:53:46 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-type; s=pfpt0220; bh=bO/1ZDIglOjAIAKFFju6S
	agamL7V1hX2h9PacG5/tus=; b=c81C5MxlSK9L+OZ0oZL+2k9paUEO2YmH694yD
	sGPS3QLY7GX6U2YusG7myr60piOL+O4BCbAakXYR3BGideg+KaBCpXarn9zkygvi
	dfcMGYn4L5sEWKbjT/HkmeTS7m10yM+F/mMO9jh6m4VZBtsD+SCB9tU4Nuwflf5w
	DY69lI/7GyORpMb6pIHOOqTKH761yHPgpS/NFLtUtCa3oxgliuGYSWc/2PgJhaSx
	dbF9E7hQy6xRRDtevUn4xhEdcwRniLH/j+bKfQZOE961vlDWC2yVD1OCGkc/vWwY
	2bTkCldsHJwoiZtvBTedu97VRP1wF0w90U9lQ7yIBygYZoMsw==
Received: from dc6wp-exch02.marvell.com ([4.21.29.225])
	by mx0b-0016f401.pphosted.com (PPS) with ESMTPS id 3xs0vfspsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 28 Apr 2024 03:53:45 -0700 (PDT)
Received: from DC6WP-EXCH02.marvell.com (10.76.176.209) by
 DC6WP-EXCH02.marvell.com (10.76.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sun, 28 Apr 2024 03:53:45 -0700
Received: from maili.marvell.com (10.69.176.80) by DC6WP-EXCH02.marvell.com
 (10.76.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Sun, 28 Apr 2024 03:53:45 -0700
Received: from hyd1soter3.marvell.com (unknown [10.29.37.12])
	by maili.marvell.com (Postfix) with ESMTP id D7F4C5B6949;
	Sun, 28 Apr 2024 03:53:41 -0700 (PDT)
From: Geetha sowjanya <gakula@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <kuba@kernel.org>, <davem@davemloft.net>, <pabeni@redhat.com>,
        <edumazet@google.com>, <sgoutham@marvell.com>, <gakula@marvell.com>,
        <sbhatta@marvell.com>, <hkelam@marvell.com>
Subject: [net-next PATCH v3 8/9] octeontx2-pf: Configure VF mtu via representor
Date: Sun, 28 Apr 2024 16:23:11 +0530
Message-ID: <20240428105312.9731-9-gakula@marvell.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20240428105312.9731-1-gakula@marvell.com>
References: <20240428105312.9731-1-gakula@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: 0SOhHShee8ok5N7KxWqfiv6mHUN9iamr
X-Proofpoint-GUID: 0SOhHShee8ok5N7KxWqfiv6mHUN9iamr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-28_07,2024-04-26_02,2023-05-22_02

Add support to manage the mtu configuration for VF through representor.
On update of representor mtu a mbox notification is send
to VF to update its mtu.

Signed-off-by: Sai Krishna <saikrishnag@marvell.com>
Signed-off-by: Geetha sowjanya <gakula@marvell.com>
---
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c    |  5 +++++
 .../net/ethernet/marvell/octeontx2/nic/rep.c    | 17 +++++++++++++++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
index faf6e1716efe..301ecb2b6a24 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_pf.c
@@ -854,6 +854,11 @@ static int otx2_mbox_up_handler_rep_event_up_notify(struct otx2_nic *pf,
 {
 	struct net_device *netdev = pf->netdev;
 
+	if (info->event == RVU_EVENT_MTU_CHANGE) {
+		netdev->mtu = info->evt_data.mtu;
+		return 0;
+	}
+
 	if (info->event == RVU_EVENT_PORT_STATE) {
 		if (info->evt_data.port_state) {
 			pf->flags |= OTX2_FLAG_PORT_UP;
diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
index ae5e9b245791..c5b64253ecd8 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/rep.c
@@ -79,6 +79,22 @@ int rvu_event_up_notify(struct otx2_nic *pf, struct rep_event *info)
 	return 0;
 }
 
+static int rvu_rep_change_mtu(struct net_device *dev, int new_mtu)
+{
+	struct rep_dev *rep = netdev_priv(dev);
+	struct otx2_nic *priv = rep->mdev;
+	struct rep_event evt = {0};
+
+	netdev_info(dev, "Changing MTU from %d to %d\n",
+		    dev->mtu, new_mtu);
+	dev->mtu = new_mtu;
+
+	evt.evt_data.mtu = new_mtu;
+	evt.pcifunc = rep->pcifunc;
+	rvu_rep_notify_pfvf(priv, RVU_EVENT_MTU_CHANGE, &evt);
+	return 0;
+}
+
 static void rvu_rep_get_stats(struct work_struct *work)
 {
 	struct delayed_work *del_work = to_delayed_work(work);
@@ -225,6 +241,7 @@ static const struct net_device_ops rvu_rep_netdev_ops = {
 	.ndo_stop		= rvu_rep_stop,
 	.ndo_start_xmit		= rvu_rep_xmit,
 	.ndo_get_stats64	= rvu_rep_get_stats64,
+	.ndo_change_mtu		= rvu_rep_change_mtu,
 };
 
 static int rvu_rep_napi_init(struct otx2_nic *priv, struct netlink_ext_ack *extack)
-- 
2.25.1


