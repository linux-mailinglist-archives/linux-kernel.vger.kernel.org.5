Return-Path: <linux-kernel+bounces-65589-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B03AE854F20
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 17:51:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2CFE1C29134
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 16:51:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E4E60BBA;
	Wed, 14 Feb 2024 16:51:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b="K6yR/XmM"
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B64CB60B82;
	Wed, 14 Feb 2024 16:51:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.143.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707929464; cv=none; b=Pl3wISyN+aJKDyIkWiyYKZxAxrck3XjjWt/NN02/D0ZrJPNwd2qyz2qxBhx42+O0LEheWe40qFphqfplaTyytO3K+TbxLlrgHiwJcrn/vs9etGDreMk6V/WsUFSAkBiPk84ZXdkjXf6Eqev8kTD1pkXoqzz+ODY+SgdZWgYQFc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707929464; c=relaxed/simple;
	bh=7c/2k+DP/jX8b7hwRgJMRjMXKnwQ37+q3s+m74p7ssg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mxsVgU9ZPzcLBymWGoD/8M4sLa5RBRCE3iK8vztAoM1BvQjeQ4/7c0sJej6P34zrfT7MU6MX3bjLFrWygj2Q8XN5LiNqSarS7COEehl0vwiGkwoqJmYuFKLODuz/qsIob5YE7iJ+EMv6Ko6eXPRvLuUbEAHYv5jBNLCQ9YHLliY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com; spf=pass smtp.mailfrom=hpe.com; dkim=pass (2048-bit key) header.d=hpe.com header.i=@hpe.com header.b=K6yR/XmM; arc=none smtp.client-ip=148.163.143.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=hpe.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=hpe.com
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
	by mx0b-002e3701.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41EGhQ0F015745;
	Wed, 14 Feb 2024 16:50:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pps0720;
 bh=G0H3Ukg4sOEmcUSwLhLyPtT8HbW50emICiCcGmN4ZT0=;
 b=K6yR/XmMrkX2+i/CQNojUZ/l4OjvN932lexEGi8G0Y/2vOJhHVLGpcyjzKk0pqmPM7Vl
 uF823K9sQveWxWmCPCfc1mFadZGhzmVYY3EOxpQbqBteN44i+bprx7nLrV4aTToskE+N
 qyeJDyGILB+q0HojmIEC8bVwyf/abhkwZW+zT9JmcuHRUQOcI9cQhbE3z4O9czXU0zfT
 u+xfdbI0217oClx3+r6Fi25WjigQBZ/dndAZ9Eo8dumKjDv08ol0J/WFrU6pqAGQrOWk
 sEnk/kx9KOjVdn6xGJWOegleY5+XoMt64h7rfyatwRl2Qm6pExtIEX3dCWYIECqTRoeK cw== 
Received: from p1lg14878.it.hpe.com ([16.230.97.204])
	by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3w919u02kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 Feb 2024 16:50:46 +0000
Received: from p1lg14886.dc01.its.hpecorp.net (unknown [10.119.18.237])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by p1lg14878.it.hpe.com (Postfix) with ESMTPS id CC8BA2D870;
	Wed, 14 Feb 2024 16:49:55 +0000 (UTC)
Received: from anatevka.americas.hpqcorp.net (unknown [16.231.227.36])
	by p1lg14886.dc01.its.hpecorp.net (Postfix) with ESMTP id E3401805AE3;
	Wed, 14 Feb 2024 16:49:47 +0000 (UTC)
From: Jerry Hoemann <jerry.hoemann@hpe.com>
To: linux@roeck-us.net
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jerry Hoemann <jerry.hoemann@hpe.com>
Subject: [PATCH v2 1/1] watchdog/hpwdt: Support Suspend and Resume
Date: Wed, 14 Feb 2024 09:49:40 -0700
Message-ID: <20240214164941.630775-2-jerry.hoemann@hpe.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240214164941.630775-1-jerry.hoemann@hpe.com>
References: <20240214164941.630775-1-jerry.hoemann@hpe.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: mBZqTb82VOkFUPfuDfW_9BFt8X35y5Az
X-Proofpoint-ORIG-GUID: mBZqTb82VOkFUPfuDfW_9BFt8X35y5Az
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-14_09,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 spamscore=0 priorityscore=1501 adultscore=0 suspectscore=0 clxscore=1015
 mlxlogscore=944 impostorscore=0 mlxscore=0 lowpriorityscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402140131

Add call backs to support suspend and resume.

Signed-off-by: Jerry Hoemann <jerry.hoemann@hpe.com>
---
 drivers/watchdog/hpwdt.c | 25 +++++++++++++++++++++++++
 1 file changed, 25 insertions(+)

diff --git a/drivers/watchdog/hpwdt.c b/drivers/watchdog/hpwdt.c
index 138dc8d8ca3d..ae30e394d176 100644
--- a/drivers/watchdog/hpwdt.c
+++ b/drivers/watchdog/hpwdt.c
@@ -378,11 +378,36 @@ static void hpwdt_exit(struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
+static int hpwdt_suspend(struct device *dev)
+{
+	if (watchdog_active(&hpwdt_dev))
+		hpwdt_stop();
+
+	return 0;
+}
+
+static int hpwdt_resume(struct device *dev)
+{
+	if (watchdog_active(&hpwdt_dev))
+		hpwdt_start(&hpwdt_dev);
+
+	return 0;
+}
+
+static const struct dev_pm_ops hpwdt_pm_ops = {
+	LATE_SYSTEM_SLEEP_PM_OPS(hpwdt_suspend, hpwdt_resume)
+};
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


