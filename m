Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0957F667E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 19:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjKWSje (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 13:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjKWSjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 13:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710E7F9
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 10:39:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1700764779;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=MZcj6fHanb3mUK8r75E4vy8tt1GEMX0UQXL1edeKG8c=;
        b=YcFm3tLtm8F8FMn/3D0peiyjFuEQkmTJ8iaADR7CkhdGbskyKpjHRVz1y+sFW5uAPGleor
        xtWu7RmtKN4qxKXglhN98XyfMAQoDV1ep3oMG50j4h+qLyIg5PJJayCj5v3v0IEJ/tZSro
        3Q0UXuQyT3K8m1N69GSP+fUkv+LDdR0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-37-cTUNmn_TOK-r0VEDioyo3w-1; Thu, 23 Nov 2023 13:39:36 -0500
X-MC-Unique: cTUNmn_TOK-r0VEDioyo3w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DB341185A782;
        Thu, 23 Nov 2023 18:39:35 +0000 (UTC)
Received: from mpattric.remote.csb (unknown [10.22.33.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 40B7C5028;
        Thu, 23 Nov 2023 18:39:35 +0000 (UTC)
From:   Mike Pattrick <mkp@redhat.com>
To:     netdev@vger.kernel.org
Cc:     willemdebruijn.kernel@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        linux-kernel@vger.kernel.org, Mike Pattrick <mkp@redhat.com>
Subject: [PATCH net-next] packet: Account for VLAN_HLEN in csum_start when virtio_net_hdr is enabled
Date:   Thu, 23 Nov 2023 13:38:35 -0500
Message-Id: <20231123183835.635210-1-mkp@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Af_packet provides checksum offload offsets to usermode applications
through struct virtio_net_hdr when PACKET_VNET_HDR is enabled on the
socket. For skbuffs with a vlan being sent to a SOCK_RAW socket,
af_packet will include the link level header and so csum_start needs
to be adjusted accordingly.

Fixes: fd3a88625844 ("net: in virtio_net_hdr only add VLAN_HLEN to csum_start if payload holds vlan")
Signed-off-by: Mike Pattrick <mkp@redhat.com>
---
 net/packet/af_packet.c | 36 ++++++++++++++++++++++++++----------
 1 file changed, 26 insertions(+), 10 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index a84e00b5904b..f6b602ffe383 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -2092,15 +2092,23 @@ static unsigned int run_filter(struct sk_buff *skb,
 }
 
 static int packet_rcv_vnet(struct msghdr *msg, const struct sk_buff *skb,
-			   size_t *len, int vnet_hdr_sz)
+			   size_t *len, int vnet_hdr_sz,
+			   const struct sock *sk)
 {
 	struct virtio_net_hdr_mrg_rxbuf vnet_hdr = { .num_buffers = 0 };
+	int vlan_hlen;
 
 	if (*len < vnet_hdr_sz)
 		return -EINVAL;
 	*len -= vnet_hdr_sz;
 
-	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr, vio_le(), true, 0))
+	if (sk->sk_type == SOCK_RAW && skb_vlan_tag_present(skb))
+		vlan_hlen = VLAN_HLEN;
+	else
+		vlan_hlen = 0;
+
+	if (virtio_net_hdr_from_skb(skb, (struct virtio_net_hdr *)&vnet_hdr,
+				    vio_le(), true, vlan_hlen))
 		return -EINVAL;
 
 	return memcpy_to_msg(msg, (void *)&vnet_hdr, vnet_hdr_sz);
@@ -2368,13 +2376,21 @@ static int tpacket_rcv(struct sk_buff *skb, struct net_device *dev,
 		__set_bit(slot_id, po->rx_ring.rx_owner_map);
 	}
 
-	if (vnet_hdr_sz &&
-	    virtio_net_hdr_from_skb(skb, h.raw + macoff -
-				    sizeof(struct virtio_net_hdr),
-				    vio_le(), true, 0)) {
-		if (po->tp_version == TPACKET_V3)
-			prb_clear_blk_fill_status(&po->rx_ring);
-		goto drop_n_account;
+	if (vnet_hdr_sz) {
+		int vlan_hlen;
+
+		if (sk->sk_type == SOCK_RAW && skb_vlan_tag_present(skb))
+			vlan_hlen = VLAN_HLEN;
+		else
+			vlan_hlen = 0;
+
+		if (virtio_net_hdr_from_skb(skb, h.raw + macoff -
+					    sizeof(struct virtio_net_hdr),
+					    vio_le(), true, vlan_hlen)) {
+			if (po->tp_version == TPACKET_V3)
+				prb_clear_blk_fill_status(&po->rx_ring);
+			goto drop_n_account;
+		}
 	}
 
 	if (po->tp_version <= TPACKET_V2) {
@@ -3464,7 +3480,7 @@ static int packet_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	packet_rcv_try_clear_pressure(pkt_sk(sk));
 
 	if (vnet_hdr_len) {
-		err = packet_rcv_vnet(msg, skb, &len, vnet_hdr_len);
+		err = packet_rcv_vnet(msg, skb, &len, vnet_hdr_len, sk);
 		if (err)
 			goto out_free;
 	}
-- 
2.40.1

