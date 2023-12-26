Return-Path: <linux-kernel+bounces-11382-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BFEE81E567
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 07:09:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDEE328291E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 06:09:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB69F4BAAF;
	Tue, 26 Dec 2023 06:08:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="ODUQi5Br"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m15.mail.163.com (m15.mail.163.com [45.254.50.220])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 580E84BA80;
	Tue, 26 Dec 2023 06:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=chNQa
	qyjmqQSTbtOWxsw9RHKFvBwS7P46pvgdz+FY1w=; b=ODUQi5BresLvK49W10rFw
	aNe4hGmb6fNeneTVS8PDTKK1piRdY99Y4TR2LJELnRMVcxQzhrpryax+OD+tvA6h
	SESO93eeTlOJiUV/9mzUGCrIVTVk7GtAIC4lpCvjTNSMN/AwHuPimZbDLo8EV2d2
	inTfJTzMWTSJtts6zPqNFA=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g0-0 (Coremail) with SMTP id _____wD3HzDTbYplT_rKGg--.60729S2;
	Tue, 26 Dec 2023 14:08:20 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: hci_sync: fix hogp device suspend bug
Date: Tue, 26 Dec 2023 14:08:18 +0800
Message-Id: <20231226060818.2446327-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3HzDTbYplT_rKGg--.60729S2
X-Coremail-Antispam: 1Uf129KBjvdXoW7Xw13CF1rKFWfCr45uF4UJwb_yoWDZwbE93
	ZFyay29w1UGrWxZw4qyr4kCr4xZw4rWF4kur93Z34jgF98Wr18GryDXF90kr1xWa95Arsx
	Ar15WFWSqrW8GjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7IUeNVy3UUUUU==
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisBhSuGV4HA0B-gAAsx

From: Clancy Shang <clancy.shang@quectel.com>

when Bluetooth enters suspend, and disconnects everything with the
disconnect reason code of 0x15, the hogp device could not into sleep
and continued advertising. when use the disconnect reason code of 0x13,
the hogp device going into sleep succeeded.

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 net/bluetooth/hci_sync.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d85a7091a116..16b5420c32d0 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -5927,7 +5927,7 @@ int hci_suspend_sync(struct hci_dev *hdev)
 
 	if (hci_conn_count(hdev)) {
 		/* Soft disconnect everything (power off) */
-		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_POWER_OFF);
+		err = hci_disconnect_all_sync(hdev, HCI_ERROR_REMOTE_USER_TERM);
 		if (err) {
 			/* Set state to BT_RUNNING so resume doesn't notify */
 			hdev->suspend_state = BT_RUNNING;
-- 
2.25.1


