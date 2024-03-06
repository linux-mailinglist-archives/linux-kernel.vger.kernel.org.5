Return-Path: <linux-kernel+bounces-94039-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E59348738EE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 15:24:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A19B2284421
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 14:24:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 358651339A6;
	Wed,  6 Mar 2024 14:24:09 +0000 (UTC)
Received: from mail.aperture-lab.de (mail.aperture-lab.de [116.203.183.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662F130ACE;
	Wed,  6 Mar 2024 14:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.183.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709735048; cv=none; b=Guk2MgXcmU7ZtFHIJTQ/mWqjyYbSEzXY3Uh0N5UVSn7Fc1m7f4pIFa0l5s7TbLFIrjdypI7AuzIFcPZfuZ5vXHobwkqJfZ2w6GiJqKYuX1BoHy7OfrlD1uINMUXhcG9du4LKdj5cTAf+MB+bfW+XQtE3oBl8A8JFOh6K/i4vNxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709735048; c=relaxed/simple;
	bh=qJ4gjt253xxum5utg91XBCGmUOduxiyObpAmLwXzzHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=BTrZxFeRlaLEvdly3bgBGFv20KFzYmVNF/w90hdQ7PZnZFOp65brtGc8hxfngHEaq3tV3fqwkrJScmk0xaZtkzQj0vwLfu8RaHo//cXXe8gddJIF/mNI/kMwmMrvYPVbS1s0C6toNl9E5H6O7jLCbuWt74+PYskbX7sfDcYz4TE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue; spf=pass smtp.mailfrom=c0d3.blue; arc=none smtp.client-ip=116.203.183.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=c0d3.blue
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=c0d3.blue
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id CC7DA419A4;
	Wed,  6 Mar 2024 15:18:26 +0100 (CET)
From: =?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
To: netfilter-devel@vger.kernel.org
Cc: coreteam@netfilter.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Jozsef Kadlecsik <kadlec@netfilter.org>,
	Florian Westphal <fw@strlen.de>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Dietmar Maurer <dietmar@proxmox.com>,
	Thomas Lamprecht <t.lamprecht@proxmox.com>,
	Wolfgang Bumiller <w.bumiller@proxmox.com>,
	Alexandre Derumier <aderumier@odiso.com>,
	=?UTF-8?q?Linus=20L=C3=BCssing?= <linus.luessing@c0d3.blue>
Subject: [PATCH net] netfilter: conntrack: fix ct-state for ICMPv6 Multicast Router Discovery
Date: Wed,  6 Mar 2024 15:18:04 +0100
Message-ID: <20240306141805.17679-1-linus.luessing@c0d3.blue>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

So far Multicast Router Advertisements and Multicast Router
Solicitations from the Multicast Router Discovery protocol (RFC4286)
would be marked as INVALID for IPv6, even if they are in fact intact
and adhering to RFC4286.

This broke MRA reception and by that multicast reception on
IPv6 multicast routers in a Proxmox managed setup, where Proxmox
would install a rule like "-m conntrack --ctstate INVALID -j DROP"
at the top of the FORWARD chain with br-nf-call-ip6tables enabled
by default.

Similar to as it's done for MLDv1, MLDv2 and IPv6 Neighbor Discovery
already, fix this issue by excluding MRD from connection tracking
handling as MRD always uses predefined multicast destinations
for its messages, too. This changes the ct-state for ICMPv6 MRD messages
from INVALID to UNTRACKED.

This issue was found and fixed with the help of the mrdisc tool
(https://github.com/troglobit/mrdisc).

Signed-off-by: Linus Lüssing <linus.luessing@c0d3.blue>
---
 include/uapi/linux/icmpv6.h               | 1 +
 net/netfilter/nf_conntrack_proto_icmpv6.c | 4 +++-
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/include/uapi/linux/icmpv6.h b/include/uapi/linux/icmpv6.h
index ecaece3af38d..4eaab89e2856 100644
--- a/include/uapi/linux/icmpv6.h
+++ b/include/uapi/linux/icmpv6.h
@@ -112,6 +112,7 @@ struct icmp6hdr {
 #define ICMPV6_MOBILE_PREFIX_ADV	147
 
 #define ICMPV6_MRDISC_ADV		151
+#define ICMPV6_MRDISC_SOL		152
 
 #define ICMPV6_MSG_MAX          255
 
diff --git a/net/netfilter/nf_conntrack_proto_icmpv6.c b/net/netfilter/nf_conntrack_proto_icmpv6.c
index 1020d67600a9..327b8059025d 100644
--- a/net/netfilter/nf_conntrack_proto_icmpv6.c
+++ b/net/netfilter/nf_conntrack_proto_icmpv6.c
@@ -62,7 +62,9 @@ static const u_int8_t noct_valid_new[] = {
 	[NDISC_ROUTER_ADVERTISEMENT - 130] = 1,
 	[NDISC_NEIGHBOUR_SOLICITATION - 130] = 1,
 	[NDISC_NEIGHBOUR_ADVERTISEMENT - 130] = 1,
-	[ICMPV6_MLD2_REPORT - 130] = 1
+	[ICMPV6_MLD2_REPORT - 130] = 1,
+	[ICMPV6_MRDISC_ADV - 130] = 1,
+	[ICMPV6_MRDISC_SOL - 130] = 1
 };
 
 bool nf_conntrack_invert_icmpv6_tuple(struct nf_conntrack_tuple *tuple,
-- 
2.43.0


