Return-Path: <linux-kernel+bounces-25709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8138C82D4DF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 09:07:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 322E5281A2A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D2B5C98;
	Mon, 15 Jan 2024 08:07:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="GtoD99W/"
Received: from m12.mail.163.com (m12.mail.163.com [220.181.12.196])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25DEF523E;
	Mon, 15 Jan 2024 08:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=6x0i2
	OanomF9vsvQJWNEaBqZTF2xF6GLaqqodnh9+BU=; b=GtoD99W/3rN2eXK42ZagL
	HtYOWKso+r4YIc5YiGO2k4qwHnDTjNXWtySWUEAKTTsqiI+FTf7NkrKYAKx5YxH/
	A4V/ArYXqlm2JoBqgUT79/RLwoiKIlViicD/QgMvpGhPvTOFu2C6AtOGEvig/pRF
	HeWnt3GAvyF1Go6bnj8Q5A=
Received: from localhost.localdomain (unknown [111.202.47.2])
	by zwqz-smtp-mta-g3-3 (Coremail) with SMTP id _____wDXPzkE5KRl9ludBA--.33852S2;
	Mon, 15 Jan 2024 15:51:32 +0800 (CST)
From: wangkeqi <wangkeqi_chris@163.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	fengwei.yin@intel.com,
	wangkeqi <wangkeqiwang@didiglobal.com>
Subject: [PATCH] connector: Change the judgment conditions for clearing proc_event_num_listeners
Date: Mon, 15 Jan 2024 15:51:20 +0800
Message-Id: <20240115075120.186143-1-wangkeqi_chris@163.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wDXPzkE5KRl9ludBA--.33852S2
X-Coremail-Antispam: 1Uf129KBjvJXoW7KF13tFW3Cw4kJrW5Ar4fXwb_yoW5JrWDpF
	WqvFZYvF4kGF1fuw1DJ3W29F13Z34kWF1UCrWxK34DurZxGrykAF48tFs2vF9xA3sYkr12
	qwnFgFW3uFs8C3DanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x07jYeHDUUUUU=
X-CM-SenderInfo: 5zdqwy5htlsupkul2qqrwthudrp/1tbiQAdm3GVOBCkrCQAAsZ

From: wangkeqi <wangkeqiwang@didiglobal.com>

It is inaccurate to judge whether proc_event_num_listeners is
cleared by cn_netlink_send_mult returning -ESRCH.
In the case of stress-ng netlink-proc, -ESRCH will always be returned,
because netlink_broadcast_filtered will return -ESRCH,
which may cause stress-ng netlink-proc performance degradation.
Therefore, the judgment condition is modified to whether
there is a listener.

Signed-off-by: wangkeqi <wangkeqiwang@didiglobal.com>
---
 drivers/connector/cn_proc.c   | 6 ++++--
 drivers/connector/connector.c | 6 ++++++
 include/linux/connector.h     | 1 +
 3 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/connector/cn_proc.c b/drivers/connector/cn_proc.c
index 3d5e6d705..b09f74ed3 100644
--- a/drivers/connector/cn_proc.c
+++ b/drivers/connector/cn_proc.c
@@ -108,8 +108,10 @@ static inline void send_msg(struct cn_msg *msg)
 		filter_data[1] = 0;
 	}
 
-	if (cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
-			     cn_filter, (void *)filter_data) == -ESRCH)
+	if (netlink_has_listeners(get_cdev_nls(), CN_IDX_PROC))
+		cn_netlink_send_mult(msg, msg->len, 0, CN_IDX_PROC, GFP_NOWAIT,
+			     cn_filter, (void *)filter_data);
+	else
 		atomic_set(&proc_event_num_listeners, 0);
 
 	local_unlock(&local_event.lock);
diff --git a/drivers/connector/connector.c b/drivers/connector/connector.c
index 7f7b94f61..1b2cd410e 100644
--- a/drivers/connector/connector.c
+++ b/drivers/connector/connector.c
@@ -129,6 +129,12 @@ int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 __group,
 }
 EXPORT_SYMBOL_GPL(cn_netlink_send);
 
+struct sock *get_cdev_nls(void)
+{
+	return cdev.nls;
+}
+EXPORT_SYMBOL_GPL(get_cdev_nls);
+
 /*
  * Callback helper - queues work and setup destructor for given data.
  */
diff --git a/include/linux/connector.h b/include/linux/connector.h
index cec2d99ae..255466aea 100644
--- a/include/linux/connector.h
+++ b/include/linux/connector.h
@@ -127,6 +127,7 @@ int cn_netlink_send_mult(struct cn_msg *msg, u16 len, u32 portid,
  */
 int cn_netlink_send(struct cn_msg *msg, u32 portid, u32 group, gfp_t gfp_mask);
 
+struct sock *get_cdev_nls(void);
 int cn_queue_add_callback(struct cn_queue_dev *dev, const char *name,
 			  const struct cb_id *id,
 			  void (*callback)(struct cn_msg *, struct netlink_skb_parms *));
-- 
2.27.0


