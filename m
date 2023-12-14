Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7929812BA7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:28:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235644AbjLNJ2k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:28:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235514AbjLNJ2T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:28:19 -0500
Received: from mx1.sberdevices.ru (mx1.sberdevices.ru [37.18.73.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BBC4116;
        Thu, 14 Dec 2023 01:28:24 -0800 (PST)
Received: from p-infra-ksmg-sc-msk01 (localhost [127.0.0.1])
        by mx1.sberdevices.ru (Postfix) with ESMTP id 120C710006D;
        Thu, 14 Dec 2023 12:28:23 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.sberdevices.ru 120C710006D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=salutedevices.com;
        s=mail; t=1702546103;
        bh=+tp8IO8X5FsyMQs9mLpURDSkiHT527vDQ0ICXt+bxsY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type:From;
        b=WsleU7MILXST9GK4wlDYa6gQ81p+ETYO+36my6UbD9j+onj6EZ+srX479ata6eZhy
         9k3HArL6rWfEekZvIfH32TRNZd88dGG2E4Cr0RPi5mcqA7Iv4uU8TtK+MHZAY9dX6y
         u1cTcUFVKU3gQxD6fUa2bus4NnMZhpolytd4etOJiPI9undlq/C0xka8kbj+46u2/1
         2TeNBmv0TjzINpZXQc/X/kCMncdmm+ulcDsrvYEbG1/HQfjDWyL5I662dQkAnq6v9O
         No3zlnj8QSI7J1dlSkMr8rg8IHOsNm+touRXFzNE+zPLiNv7x2s1AS0nW4XAwanwxj
         HYLY12De0tuzA==
Received: from smtp.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.sberdevices.ru (Postfix) with ESMTPS;
        Thu, 14 Dec 2023 12:28:22 +0300 (MSK)
Received: from localhost.localdomain (100.64.160.123) by
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Thu, 14 Dec 2023 12:28:22 +0300
From:   Arseniy Krasnov <avkrasnov@salutedevices.com>
To:     Stefan Hajnoczi <stefanha@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Bobby Eshleman <bobby.eshleman@bytedance.com>
CC:     <kvm@vger.kernel.org>, <virtualization@lists.linux-foundation.org>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, <oxffffaa@gmail.com>,
        <avkrasnov@salutedevices.com>
Subject: [PATCH net-next v9 2/4] virtio/vsock: send credit update during setting SO_RCVLOWAT
Date:   Thu, 14 Dec 2023 12:19:45 +0300
Message-ID: <20231214091947.395892-3-avkrasnov@salutedevices.com>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20231214091947.395892-1-avkrasnov@salutedevices.com>
References: <20231214091947.395892-1-avkrasnov@salutedevices.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m02.sberdevices.ru (172.16.192.103) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 10
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Lua-Profiles: 182105 [Dec 14 2023]
X-KSMG-AntiSpam-Version: 6.1.0.3
X-KSMG-AntiSpam-Envelope-From: avkrasnov@salutedevices.com
X-KSMG-AntiSpam-Rate: 0
X-KSMG-AntiSpam-Status: not_detected
X-KSMG-AntiSpam-Method: none
X-KSMG-AntiSpam-Auth: dkim=none
X-KSMG-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a, {Tracking_from_domain_doesnt_match_to}, d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;smtp.sberdevices.ru:5.0.1,7.1.1;100.64.160.123:7.1.2;salutedevices.com:7.1.1;127.0.0.199:7.1.2, FromAlignment: s, ApMailHostAddress: 100.64.160.123
X-MS-Exchange-Organization-SCL: -1
X-KSMG-AntiSpam-Interceptor-Info: scan successful
X-KSMG-AntiPhishing: Clean
X-KSMG-LinksScanning: Clean
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 2.0.1.6960, bases: 2023/12/14 08:33:00 #22688916
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Send credit update message when SO_RCVLOWAT is updated and it is bigger
than number of bytes in rx queue. It is needed, because 'poll()' will
wait until number of bytes in rx queue will be not smaller than
SO_RCVLOWAT, so kick sender to send more data. Otherwise mutual hungup
for tx/rx is possible: sender waits for free space and receiver is
waiting data in 'poll()'.

Fixes: b89d882dc9fc ("vsock/virtio: reduce credit update messages")
Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Michael S. Tsirkin <mst@redhat.com>
---
 Changelog:
 v1 -> v2:
  * Update commit message by removing 'This patch adds XXX' manner.
  * Do not initialize 'send_update' variable - set it directly during
    first usage.
 v3 -> v4:
  * Fit comment in 'virtio_transport_notify_set_rcvlowat()' to 80 chars.
 v4 -> v5:
  * Do not change callbacks order in transport structures.
 v5 -> v6:
  * Reorder callbacks in transport structures.
  * Do to send credit update when 'fwd_cnt' == 'last_fwd_cnt'.
 v8 -> v9:
  * Add 'Fixes' tag.

 drivers/vhost/vsock.c                   |  1 +
 include/linux/virtio_vsock.h            |  1 +
 net/vmw_vsock/virtio_transport.c        |  1 +
 net/vmw_vsock/virtio_transport_common.c | 30 +++++++++++++++++++++++++
 net/vmw_vsock/vsock_loopback.c          |  1 +
 5 files changed, 34 insertions(+)

diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
index f75731396b7e..ec20ecff85c7 100644
--- a/drivers/vhost/vsock.c
+++ b/drivers/vhost/vsock.c
@@ -449,6 +449,7 @@ static struct virtio_transport vhost_transport = {
 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.read_skb = virtio_transport_read_skb,
 	},
diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
index ebb3ce63d64d..c82089dee0c8 100644
--- a/include/linux/virtio_vsock.h
+++ b/include/linux/virtio_vsock.h
@@ -256,4 +256,5 @@ void virtio_transport_put_credit(struct virtio_vsock_sock *vvs, u32 credit);
 void virtio_transport_deliver_tap_pkt(struct sk_buff *skb);
 int virtio_transport_purge_skbs(void *vsk, struct sk_buff_head *list);
 int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t read_actor);
+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val);
 #endif /* _LINUX_VIRTIO_VSOCK_H */
diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
index af5bab1acee1..f495b9e5186b 100644
--- a/net/vmw_vsock/virtio_transport.c
+++ b/net/vmw_vsock/virtio_transport.c
@@ -537,6 +537,7 @@ static struct virtio_transport virtio_transport = {
 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.read_skb = virtio_transport_read_skb,
 	},
diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index 7eabe5219ef7..9d2305fdc65c 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -1690,6 +1690,36 @@ int virtio_transport_read_skb(struct vsock_sock *vsk, skb_read_actor_t recv_acto
 }
 EXPORT_SYMBOL_GPL(virtio_transport_read_skb);
 
+int virtio_transport_notify_set_rcvlowat(struct vsock_sock *vsk, int val)
+{
+	struct virtio_vsock_sock *vvs = vsk->trans;
+	bool send_update;
+
+	spin_lock_bh(&vvs->rx_lock);
+
+	/* If number of available bytes is less than new SO_RCVLOWAT value,
+	 * kick sender to send more data, because sender may sleep in its
+	 * 'send()' syscall waiting for enough space at our side. Also
+	 * don't send credit update when peer already knows actual value -
+	 * such transmission will be useless.
+	 */
+	send_update = (vvs->rx_bytes < val) &&
+		      (vvs->fwd_cnt != vvs->last_fwd_cnt);
+
+	spin_unlock_bh(&vvs->rx_lock);
+
+	if (send_update) {
+		int err;
+
+		err = virtio_transport_send_credit_update(vsk);
+		if (err < 0)
+			return err;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(virtio_transport_notify_set_rcvlowat);
+
 MODULE_LICENSE("GPL v2");
 MODULE_AUTHOR("Asias He");
 MODULE_DESCRIPTION("common code for virtio vsock");
diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
index 048640167411..6dea6119f5b2 100644
--- a/net/vmw_vsock/vsock_loopback.c
+++ b/net/vmw_vsock/vsock_loopback.c
@@ -96,6 +96,7 @@ static struct virtio_transport loopback_transport = {
 		.notify_send_pre_enqueue  = virtio_transport_notify_send_pre_enqueue,
 		.notify_send_post_enqueue = virtio_transport_notify_send_post_enqueue,
 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
+		.notify_set_rcvlowat      = virtio_transport_notify_set_rcvlowat,
 
 		.read_skb = virtio_transport_read_skb,
 	},
-- 
2.25.1

