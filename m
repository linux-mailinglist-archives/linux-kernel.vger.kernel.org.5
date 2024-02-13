Return-Path: <linux-kernel+bounces-63033-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F3A85298C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 08:04:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 798081C233A6
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 07:04:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 092CA168D8;
	Tue, 13 Feb 2024 07:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="aouEfcPz"
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E058914296;
	Tue, 13 Feb 2024 07:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.147.86
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707807871; cv=none; b=V2jqXxfS7iqedeTWahsZqceOnA6avBdoLHdUgLtYfFCQk76aVLwqv3Uy2XyFPC9plBa1+o6tC7Lbcm8xPcvosMLqb6jeYBpg3759XA+lOEHz77lmcYjC7L4dDAhDdQI4fBC/jLGi1m+o158EmXrlRZ861XPRO7t8GQ1oed1DQVs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707807871; c=relaxed/simple;
	bh=E+QR563gX4hLxvs7YXfuwIMnx6zZm7FGrlrZu5sSaCk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNLpQ6gCPGCBrfpxUqaqUuN4ccPVLiOS4xEMfMyopMwfS9ycwAaeYt+Lv6hsddK62dksu0BskkDpvEtTLu2wQAphFWKNkL527nxNzdZu89Ok1IhNh3Pqbp2Et0+dVxkwapMbxbFzhdZmePi3PcLZkR/RKNdoFLrOv9L8T7CUw6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=aouEfcPz; arc=none smtp.client-ip=148.163.147.86
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
	by mx0a-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41D5J2pv006063;
	Tue, 13 Feb 2024 07:04:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pps0720;
 bh=ZGCUbwQrOfaJeluWHwCgQ75rPKumNutfMnfqnj/tllA=;
 b=aouEfcPzk3/G9SabiCcwa7lmww9jKr2+aBjuFx9VoNIwoWw6ym2aBWOA9NaGP1tkRsUD
 yIRxNU1+JOxPZF9to2XSxcsRmrDeoc3V06GSKSRS2HwGrUq/9IRznwRzNuwmOWNBWiTq
 COS7Ah8cNcJLpj2xijwZ0+2yNp3/Y0lBhTyx/+UwpB1oB79J79iA1YQZmC92jrW1Jz41
 yt5teGS8JcAdVRHs4QfHwCOWynSMwK5uV5sOwIODjT4hMkuBHQp49ztYo4c7ujmdtE+O
 0FkZ8cbavE8GgPYb+Tavxnjrmx/6ef6MvYJ9ApXRdMwGdQ7z1kYv+0r086y3buXMQnAz mQ== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3w7vf0538d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 07:04:09 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CE28C1378D;
	Tue, 13 Feb 2024 07:03:58 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id 9425F80AD9F;
	Tue, 13 Feb 2024 07:03:57 +0000 (UTC)
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH] watchdog/hpwdt: Support Suspend and Resume
Date: Tue, 13 Feb 2024 00:02:03 -0700
Message-ID: <20240213070203.489846-1-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: RuPWc8ZjGihonCsa0ZSqFaSOSvqLDwP1
X-Proofpoint-GUID: RuPWc8ZjGihonCsa0ZSqFaSOSvqLDwP1
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_03,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 impostorscore=0 phishscore=0 bulkscore=0 adultscore=0 priorityscore=1501
 mlxscore=0 clxscore=1011 mlxlogscore=765 spamscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130053

Add call backs to support suspend and resume.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 138dc8d8ca3d..6565cfaa8e57 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -378,11 +378,38 @@ static void hpwdt_exit(struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
+static int hpwdt_suspend(struct device *dev)
+{
+	dev_dbg(dev, "Suspend watchdog\n");
+
+	if (watchdog_active(&hpwdt_dev))
+		hpwdt_stop();
+
+	return 0;
+}
+
+static int hpwdt_resume(struct device *dev)
+{
+	dev_dbg(dev, "Resume watchdog\n");
+
+	if (watchdog_active(&hpwdt_dev))
+		hpwdt_start(&hpwdt_dev);
+
+	return 0;
+}
+
+static DEFINE_SIMPLE_DEV_PM_OPS(hpwdt_pm_ops, hpwdt_suspend, hpwdt_resume);
+
 static struct pci_driver hpwdt_driver = {
 	.name = "hpwdt",
 	.id_table = hpwdt_devices,
 	.probe = hpwdt_init_one,
 	.remove = hpwdt_exit,
+
+	.driver = {
+		.name = "hpwdt",
+		.pm = &hpwdt_pm_ops,
+	}
 };
 
 MODULE_AUTHOR("Tom Mingarelli");
-- 
2.43.0


