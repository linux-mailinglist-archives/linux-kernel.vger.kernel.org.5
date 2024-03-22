Return-Path: <linux-kernel+bounces-111977-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC936887390
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 20:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33026B22657
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 19:06:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C48276F1A;
	Fri, 22 Mar 2024 19:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cKqi9Wug"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661893EA6F
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 19:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711134377; cv=none; b=cmo1+lBp1VZCNK3LnQQvikx47dWRscNSYj/p2/7RiBP9XawYjXdmokJzGPfeymEeHntG+CBirqigXeDpz8o+FtdqqC/i5zETpmUZu1AvuqEhk/4yZzk9ndDl/0rT/B09lueW+Uv7rJhwGOSD6Pm/n53mu5tOfnXHq1y22nOfuBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711134377; c=relaxed/simple;
	bh=G8IGxwSbCA7VtBX8XkVa1ambOdnemi9fnCfUORqa5dI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XU0Uw3P22rUiUgohrZF6s9lnaP3KSbZiMlCbecFmm15DXCaeuedYOAmxut5+RVyYO261h0eyo3ULy5B3AlfM1GWTAwLnZscnyZcgKYboDEj+FMhtnF1RIeeWHQjx4DV20EuT8PPKRjRLGma1eynwGhLa3igZb/6zDh45D2IMITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cKqi9Wug; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711134374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bYv+g1I7ptnV6etPECbKRE2B/hEhZ4xk0E1ZHt/7Sok=;
	b=cKqi9WugA5z+pTC1coQeI24eWnC7pjnpFAL/CMDqn2poK7/ZyPAm2skDZH6T/roxCn2dXC
	KXl9ZUOtmzbthDrHrlM/3Yxmn7IAKajJuVExUgwN9Yriyj0BGJYYveA+1LaMs+YXPssonF
	BjpbSSgsyeqizdQKY8+k30JI5h8G9xQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-gBjFs-OwO1uIF-FNgKwg-Q-1; Fri,
 22 Mar 2024 15:06:12 -0400
X-MC-Unique: gBjFs-OwO1uIF-FNgKwg-Q-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 214A7280480F;
	Fri, 22 Mar 2024 19:06:12 +0000 (UTC)
Received: from RHTPC1VM0NT.redhat.com (unknown [10.22.33.162])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 55FDA492BC6;
	Fri, 22 Mar 2024 19:06:11 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: Pravin B Shelar <pshelar@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	dev@openvswitch.org,
	linux-kernel@vger.kernel.org,
	Numan Siddique <nusiddiq@redhat.com>
Subject: [PATCH net] openvswitch: Set the skbuff pkt_type for proper pmtud support.
Date: Fri, 22 Mar 2024 15:06:03 -0400
Message-ID: <20240322190603.251831-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Open vSwitch is originally intended to switch at layer 2, only dealing with
Ethernet frames.  With the introduction of l3 tunnels support, it crossed
into the realm of needing to care a bit about some routing details when
making forwarding decisions.  If an oversized packet would need to be
fragmented during this forwarding decision, there is a chance for pmtu
to get involved and generate a routing exception.  This is gated by the
skbuff->pkt_type field.

When a flow is already loaded into the openvswitch module this field is
set up and transitioned properly as a packet moves from one port to
another.  In the case that a packet execute is invoked after a flow is
newly installed this field is not properly initialized.  This causes the
pmtud mechanism to omit sending the required exception messages across
the tunnel boundary and a second attempt needs to be made to make sure
that the routing exception is properly setup.  To fix this, we set the
outgoing packet's pkt_type to PACKET_OUTGOING, since it can only get
to the openvswitch module via a port device or packet command.

This issue is periodically encountered in complex setups, such as large
openshift deployments, where multiple sets of tunnel traversal occurs.
A way to recreate this is with the ovn-heater project that can setup
a networking environment which mimics such large deployments.  In that
environment, without this patch, we can see:

  ./ovn_cluster.sh start
  podman exec ovn-chassis-1 ip r a 170.168.0.5/32 dev eth1 mtu 1200
  podman exec ovn-chassis-1 ip netns exec sw01p1  ip r flush cache
  podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=2 Frag needed and DF set (mtu = 1142)

  --- 21.0.0.3 ping statistics ---
  2 packets transmitted, 0 received, +1 errors, 100% packet loss, time 1017ms

Using tcpdump, we can also see the expected ICMP FRAG_NEEDED message is not
sent into the server.

With this patch, setting the pkt_type, we see the following:

  podman exec ovn-chassis-1 ip netns exec sw01p1 ping 21.0.0.3 -M do -s 1300 -c2
  PING 21.0.0.3 (21.0.0.3) 1300(1328) bytes of data.
  From 21.0.0.3 icmp_seq=1 Frag needed and DF set (mtu = 1222)
  ping: local error: message too long, mtu=1222

  --- 21.0.0.3 ping statistics ---
  2 packets transmitted, 0 received, +2 errors, 100% packet loss, time 1061ms

In this case, the first ping request receives the FRAG_NEEDED message and
a local routing exception is created.

Reported-at: https://issues.redhat.com/browse/FDP-164
Fixes: 58264848a5a7 ("openvswitch: Add vxlan tunneling support.")
Signed-off-by: Aaron Conole <aconole@redhat.com>
---
NOTE: An alternate approach would be to add a netlink attribute to preserve
      pkt_type across the kernel->user boundary, but that does require some
      userspace cooperation.

 net/openvswitch/actions.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/openvswitch/actions.c b/net/openvswitch/actions.c
index 6fcd7e2ca81fe..952c6292100d0 100644
--- a/net/openvswitch/actions.c
+++ b/net/openvswitch/actions.c
@@ -936,6 +936,8 @@ static void do_output(struct datapath *dp, struct sk_buff *skb, int out_port,
 				pskb_trim(skb, ovs_mac_header_len(key));
 		}
 
+		skb->pkt_type = PACKET_OUTGOING;
+
 		if (likely(!mru ||
 		           (skb->len <= mru + vport->dev->hard_header_len))) {
 			ovs_vport_send(vport, skb, ovs_key_mac_proto(key));
-- 
2.41.0


