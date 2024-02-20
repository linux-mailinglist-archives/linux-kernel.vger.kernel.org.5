Return-Path: <linux-kernel+bounces-73612-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288885C51E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:45:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D07C1285AFB
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2415114AD33;
	Tue, 20 Feb 2024 19:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b="op7LIGff"
Received: from serv108.segi.ulg.ac.be (serv108.segi.ulg.ac.be [139.165.32.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C84E06A8D5;
	Tue, 20 Feb 2024 19:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=139.165.32.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458307; cv=none; b=WcEqywyleOnz5QOtnHR5QQmri8L/p5trpnN1ViItaViv+H907FNYxfRvH6P6FJWXyKj9GLzysoRrWvmEQWF2DlHXR+hYVTABrfwVgK6YMH4sPcJbW858yO1uYHPh5cbvC8j7cWj2BSN2oqpoZtW0j6a9NNYPEDxQZGjBJMSZ7JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458307; c=relaxed/simple;
	bh=7bBKkv3ANKvq+h/O/HsveYbjpCdZKvN4hdxoLc3o95A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EKnMEIdnJtOmuYKlbdM/QjBUvuYJ8BCkJ9OZMxCuYB4hKR3jq+iEmvV902/H+CZwgbrYXkdh9KUAb1THsqxq92BCxA7KjwASkiKteYNW0VRC+URcIwZJaPz+JAxU+qP73vhCN8PQRvOL0goaDCJxKJd3kLno+1CxPQVQyBuLyp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be; spf=pass smtp.mailfrom=uliege.be; dkim=pass (2048-bit key) header.d=uliege.be header.i=@uliege.be header.b=op7LIGff; arc=none smtp.client-ip=139.165.32.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uliege.be
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uliege.be
Received: from localhost.localdomain (125.179-65-87.adsl-dyn.isp.belgacom.be [87.65.179.125])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by serv108.segi.ulg.ac.be (Postfix) with ESMTPSA id 98525200BE66;
	Tue, 20 Feb 2024 20:44:57 +0100 (CET)
DKIM-Filter: OpenDKIM Filter v2.11.0 serv108.segi.ulg.ac.be 98525200BE66
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=uliege.be;
	s=ulg20190529; t=1708458297;
	bh=EQKW8IR6daFC9rmvP/2gxPZD4UEOkx+/5Gcd40M3yCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=op7LIGffgaU+ndVFn3l4hM9W4GhbB6ncfjdYzRQb8bjz34H86k3ojyTd3yDnjwQWY
	 Zd3fxjI66ANzF2EdLXYAWIqrnHstZDwf06upmtZnmkJ/i7kXQrNE06tUxAvCQQLqh3
	 DMvJCgc+0pJ7u/UDipJeH1qEz8m2COD3Px2CRPRG64YM6VBq9usSFy1xbUqWu8TscX
	 OAAPC0MJAN4nHtgeWyZLod58uS4R1azrL4Z6+ooIUmjeAGYuMIbjA8xYBelcIsp1Ht
	 jlsp2Vcu/k2U7kWYxoOrgfNn+P7sHh2ghU7fsyAzCIKRoZZQlfU5LYRqKYq5YC8jU1
	 hnEpw1ycQqsIw==
From: Justin Iurman <justin.iurman@uliege.be>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	dsahern@kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	justin.iurman@uliege.be
Subject: [PATCH net-next 2/3] ioam6: multicast event
Date: Tue, 20 Feb 2024 20:44:43 +0100
Message-Id: <20240220194444.36127-3-justin.iurman@uliege.be>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240220194444.36127-1-justin.iurman@uliege.be>
References: <20240220194444.36127-1-justin.iurman@uliege.be>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a multicast group to the ioam6 generic netlink family and provide
ioam6_event() to send an ioam6 event to the multicast group.

Signed-off-by: Justin Iurman <justin.iurman@uliege.be>
---
 include/net/ioam6.h |  4 +++
 net/ipv6/ioam6.c    | 61 +++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 65 insertions(+)

diff --git a/include/net/ioam6.h b/include/net/ioam6.h
index 781d2d8b2f29..2cbbee6e806a 100644
--- a/include/net/ioam6.h
+++ b/include/net/ioam6.h
@@ -12,6 +12,7 @@
 #include <linux/net.h>
 #include <linux/ipv6.h>
 #include <linux/ioam6.h>
+#include <linux/ioam6_genl.h>
 #include <linux/rhashtable-types.h>
 
 struct ioam6_namespace {
@@ -65,4 +66,7 @@ void ioam6_exit(void);
 int ioam6_iptunnel_init(void);
 void ioam6_iptunnel_exit(void);
 
+void ioam6_event(enum ioam6_event_type type, struct net *net, gfp_t gfp,
+		 void *opt, unsigned int opt_len);
+
 #endif /* _NET_IOAM6_H */
diff --git a/net/ipv6/ioam6.c b/net/ipv6/ioam6.c
index 571f0e4d9cf3..d06a406658f6 100644
--- a/net/ipv6/ioam6.c
+++ b/net/ipv6/ioam6.c
@@ -612,6 +612,65 @@ static const struct genl_ops ioam6_genl_ops[] = {
 	},
 };
 
+#define IOAM6_GENL_EV_GRP_OFFSET 0
+
+static const struct genl_multicast_group ioam6_mcgrps[] = {
+	[IOAM6_GENL_EV_GRP_OFFSET] = { .name = IOAM6_GENL_EV_GRP_NAME,
+				       .flags = GENL_MCAST_CAP_NET_ADMIN },
+};
+
+static int ioam6_event_put_trace(struct sk_buff *skb,
+				 struct ioam6_trace_hdr *trace,
+				 unsigned int trace_len)
+{
+	if (nla_put_u16(skb, IOAM6_EVENT_ATTR_TRACE_NAMESPACE,
+			be16_to_cpu(trace->namespace_id)) ||
+	    nla_put_u8(skb, IOAM6_EVENT_ATTR_TRACE_NODELEN, trace->nodelen) ||
+	    nla_put_u32(skb, IOAM6_EVENT_ATTR_TRACE_TYPE,
+			be32_to_cpu(trace->type_be32)) ||
+	    nla_put(skb, IOAM6_EVENT_ATTR_TRACE_DATA,
+		    trace_len - sizeof(struct ioam6_trace_hdr) - trace->remlen*4,
+		    trace->data + trace->remlen*4))
+		return 1;
+
+	return 0;
+}
+
+void ioam6_event(enum ioam6_event_type type, struct net *net, gfp_t gfp,
+		 void *opt, unsigned int opt_len)
+{
+	struct nlmsghdr *nlh;
+	struct sk_buff *skb;
+
+	if (!genl_has_listeners(&ioam6_genl_family, net,
+				IOAM6_GENL_EV_GRP_OFFSET))
+		return;
+
+	skb = nlmsg_new(NLMSG_DEFAULT_SIZE, gfp);
+	if (!skb)
+		return;
+
+	nlh = genlmsg_put(skb, 0, 0, &ioam6_genl_family, 0, type);
+	if (!nlh)
+		goto nla_put_failure;
+
+	switch (type) {
+	case IOAM6_EVENT_TRACE:
+		if (ioam6_event_put_trace(skb, (struct ioam6_trace_hdr *)opt,
+					  opt_len))
+			goto nla_put_failure;
+		break;
+	}
+
+	genlmsg_end(skb, nlh);
+	genlmsg_multicast_netns(&ioam6_genl_family, net, skb, 0,
+				IOAM6_GENL_EV_GRP_OFFSET, gfp);
+	return;
+
+nla_put_failure:
+	nlmsg_free(skb);
+}
+
 static struct genl_family ioam6_genl_family __ro_after_init = {
 	.name		= IOAM6_GENL_NAME,
 	.version	= IOAM6_GENL_VERSION,
@@ -620,6 +679,8 @@ static struct genl_family ioam6_genl_family __ro_after_init = {
 	.ops		= ioam6_genl_ops,
 	.n_ops		= ARRAY_SIZE(ioam6_genl_ops),
 	.resv_start_op	= IOAM6_CMD_NS_SET_SCHEMA + 1,
+	.mcgrps		= ioam6_mcgrps,
+	.n_mcgrps	= ARRAY_SIZE(ioam6_mcgrps),
 	.module		= THIS_MODULE,
 };
 
-- 
2.34.1


