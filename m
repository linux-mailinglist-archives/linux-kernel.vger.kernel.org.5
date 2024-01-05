Return-Path: <linux-kernel+bounces-17442-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9DF6A824D4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 03:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E32EA285660
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 02:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4271D4428;
	Fri,  5 Jan 2024 02:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="jvpN7Cfe"
X-Original-To: linux-kernel@vger.kernel.org
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.215])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECBA42113;
	Fri,  5 Jan 2024 02:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=R3eE9
	rNt+y7Qg78dWmtNHFDBWNey1yaJMNeWausqG00=; b=jvpN7CfeZD+lnKHO7rNZd
	R6lNIwMz4SCzoaCSnEXyxAFEFQrGmZGiUNDe18LggjkE8DC0N+e9K3Us+BMp2ec2
	XfvgRmdc/srZwwnKUAeWaJabE8vXugwWfhL1Nvgzmh47Y63w4eSdU/KPzIuAzaoR
	u2jUW1OzjzLu53uLBVkfz0=
Received: from WH-D-007635B.QUECTEL.COM (unknown [223.76.229.213])
	by zwqz-smtp-mta-g5-0 (Coremail) with SMTP id _____wD3P+bbb5dl+sU1AQ--.18223S2;
	Fri, 05 Jan 2024 10:56:27 +0800 (CST)
From: clancy_shang@163.com
To: marcel@holtmann.org,
	johan.hedberg@gmail.com,
	luiz.dentz@gmail.com
Cc: linux-bluetooth@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zhongjun.yu@quectel.com,
	Clancy Shang <clancy.shang@quectel.com>
Subject: [PATCH] Bluetooth: hci_sync: Fix BLE devices were unable to disable the wakeup function
Date: Fri,  5 Jan 2024 10:56:25 +0800
Message-Id: <20240105025625.125895-1-clancy_shang@163.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3P+bbb5dl+sU1AQ--.18223S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7uF17Cw4DKr45CF4DWF1Dtrb_yoW8Jw4fp3
	yY93ZaqF4DJr1Sk347ta18GF95CF4kWrW7KFW0kr4Y9anIqr48Aa1DCryaqa15ArZ5uF43
	ZF10qF95Cry5GrJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jRYL9UUUUU=
X-CM-SenderInfo: xfod0ux1bvxtlqj6il2tof0z/1tbisB1cuGV4HNfAnwAAsA

From: Clancy Shang <clancy.shang@quectel.com>

when BLE master enter suspend,  it does not delete the peripheral that
in acceptlist. so if disable the wakeup function, the BLE master scans with
basic filter next time, the peripheral can be scanned which is unexpected

Signed-off-by: Clancy Shang <clancy.shang@quectel.com>
---
 net/bluetooth/hci_sync.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index d85a7091a116..abc7f614da5f 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -2533,6 +2533,7 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 	struct bdaddr_list *b, *t;
 	u8 num_entries = 0;
 	bool pend_conn, pend_report;
+	struct hci_conn_params *conn_params;
 	u8 filter_policy;
 	size_t i, n;
 	int err;
@@ -2585,6 +2586,15 @@ static u8 hci_update_accept_list_sync(struct hci_dev *hdev)
 			continue;
 		}
 
+		conn_params = hci_conn_params_lookup(hdev, &b->bdaddr, b->bdaddr_type);
+		/* During suspend, only wakeable devices can be in acceptlist */
+		if (conn_params && hdev->suspended &&
+		    !(conn_params->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)) {
+			hci_le_del_accept_list_sync(hdev, &b->bdaddr,
+						    b->bdaddr_type);
+			continue;
+		}
+
 		num_entries++;
 	}
 
-- 
2.25.1


