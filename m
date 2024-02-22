Return-Path: <linux-kernel+bounces-77342-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D6386040D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 21:54:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7EDEFB27C5D
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 20:54:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A662571752;
	Thu, 22 Feb 2024 20:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N22bPVM+"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4EC6E5E3;
	Thu, 22 Feb 2024 20:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708635252; cv=none; b=At4TuvJ9uOZhbAUvfHuqs/sWtL+GqTzBfE2dO1XvdCsIvjozom0Z+fbrCtJwtwCeH+2//tp6Pgtxl7YiiLLdE0lGru9hrDQ7mVvkK8TZxbweRfN8J/Sagp0vjrPBR/Jj+C8MyUcSiFWRvAoV7f8e2jw4sLobFGfuv2On4Scr47I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708635252; c=relaxed/simple;
	bh=0F2DEWJKK5N2NFCavl6kJAKd82nDyEZqhWVCf1w/iUQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=H19//2b/XMC+f8/Sqho9B/Yuugfc9PLyiZ4BsU0f9t9TERECMTX5Pbtnd6uYxli4tjSKrn2tHmwp/xsglPfeauET5YAAo6HeOl8gEhZwDhtNk4BI9CYqzdjWNdBfCxQLGSTdGUhwciLo3XPmpr2qE558MNxRItwOvv8TKiijUpI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N22bPVM+; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-41276a43dc3so1313365e9.0;
        Thu, 22 Feb 2024 12:54:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708635249; x=1709240049; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0qkBgH6sMnGdyvHu5M045vbpyOXVfVY2aQr4d/ePlk=;
        b=N22bPVM+9qLhS1YSJTeyQhVY2c7mEnSPdFzwCJMk+yixbrNL/3ExHXzy3DMDKBOJrV
         aqmT9ffiSWH9YPSNF/3bFV1DUEB/a5VsjEw4RnoefdBRIM3bDxBxaW79GnacdQPTtprS
         uVmuxrhwIrpN7ZKexvQp9amdTI6VuZwPXPJqfIHaQ59HftUkgKO8SC74AfGVeeupMQYL
         jIME0RmaaJBRwS/XbyjYCmJYIdLfvvhP9mYopHvUrGIoSqpC3XCcqo/sGstzZwUEVEiY
         5R9KbA8UTdtWn+1KTb8V6VK6X+F8y6kCmLxk+27qGBxdv3ZQ95lJllZx1KOrNoI8RFPX
         +jIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708635249; x=1709240049;
        h=content-transfer-encoding:in-reply-to:references:to:from:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=i0qkBgH6sMnGdyvHu5M045vbpyOXVfVY2aQr4d/ePlk=;
        b=DWDQbqqEQrrobdXG42xqiRWODv+nsU1IBtwwqd79aC0kQX2DR0NRwPwJ49sp57SHAu
         Mi92PKepRViaeKrSHuzaTkJF/FbmNGhOGhLeA0xLSL9A5JSzKYFWM0giaQEG1MX5IT6d
         IQ4mP/ksyE4lPzL+mEibIf53p71/zGtwD1eDr9EyidYsEKqDnAbsY61Gp7e/cRghZYi3
         Gp2f3IDl4QsrKaatKK9st/+0JyYQQHpVjiyvlzvTDQLVCTGB+yAAv8O2fGe8AuUTzobO
         y6HoWGHOF6inaxMei2fPlzh12GZ7u1F5o7O890pfNG9ZxGbabDgWM2pxrJqPkPhOecbo
         eGGg==
X-Forwarded-Encrypted: i=1; AJvYcCXF9tKUxIIZ/nv4hCo+9++P7/JeBh3vwM/RsTgoZUQjlERQW6y+yBkO8NcUGNkg+NR+1JqELK9ohyq5bHBH6WxVo6F+ocb4/EIGx1kaAzoCOJKtrA2sz07W+A67BA8SVtpX59oE
X-Gm-Message-State: AOJu0Yzyne2Q9z96idsMKBXnimfNdzw8p8TOGhHOh0BHfSQ0VL4vXIGW
	NQizEajIRGpXCO3ZExcOtgGBnB2a1eOk8SsUfasx80i4Auxq0+tC629/jTTw
X-Google-Smtp-Source: AGHT+IHol3Xx0+cHHCU4aFeclZ+ObkUo6KMG8G8mdSWj/yo4AsTHuxzGZ7SrN2o1r6jpzrCcSmZVNQ==
X-Received: by 2002:a05:600c:4711:b0:412:6b21:dad9 with SMTP id v17-20020a05600c471100b004126b21dad9mr9156387wmo.25.1708635249050;
        Thu, 22 Feb 2024 12:54:09 -0800 (PST)
Received: from debian ([146.70.204.204])
        by smtp.gmail.com with ESMTPSA id w16-20020a05600c475000b004128c73beffsm2653073wmo.34.2024.02.22.12.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Feb 2024 12:54:08 -0800 (PST)
Message-ID: <79a8ba83-86bf-4c22-845c-8f285c2d1396@gmail.com>
Date: Thu, 22 Feb 2024 21:53:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: [PATCH net-next 2/2] net: geneve: enable local address bind for
 geneve sockets
From: Richard Gobert <richardbgobert@gmail.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, idosch@nvidia.com, razor@blackwall.org,
 amcohen@nvidia.com, petrm@nvidia.com, jbenc@redhat.com, b.galvani@gmail.com,
 bpoirier@nvidia.com, gavinl@nvidia.com, martin.lau@kernel.org,
 daniel@iogearbox.net, herbert@gondor.apana.org.au, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
In-Reply-To: <df300a49-7811-4126-a56a-a77100c8841b@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

This patch adds support for binding to a local address in geneve sockets.
It achieves this by adding a geneve_addr union to represent local address
to bind to, and copying it to udp_port_cfg in geneve_create_sock.

Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 drivers/net/geneve.c               | 58 +++++++++++++++++++++++++++---
 include/net/geneve.h               |  6 ++++
 include/uapi/linux/if_link.h       |  2 ++
 tools/include/uapi/linux/if_link.h |  2 ++
 4 files changed, 63 insertions(+), 5 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 32c51c244153..d0b4cb0e7c51 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -57,6 +57,7 @@ struct geneve_config {
 	bool			ttl_inherit;
 	enum ifla_geneve_df	df;
 	bool			inner_proto_inherit;
+	union geneve_addr saddr;
 };
 
 /* Pseudo network device */
@@ -451,7 +452,8 @@ static int geneve_udp_encap_err_lookup(struct sock *sk, struct sk_buff *skb)
 }
 
 static struct socket *geneve_create_sock(struct net *net, bool ipv6,
-					 __be16 port, bool ipv6_rx_csum)
+					 __be16 port, bool ipv6_rx_csum,
+					 union geneve_addr *local_addr)
 {
 	struct socket *sock;
 	struct udp_port_cfg udp_conf;
@@ -463,9 +465,15 @@ static struct socket *geneve_create_sock(struct net *net, bool ipv6,
 		udp_conf.family = AF_INET6;
 		udp_conf.ipv6_v6only = 1;
 		udp_conf.use_udp6_rx_checksums = ipv6_rx_csum;
+		memcpy(&udp_conf.local_ip6,
+		       &local_addr->sin6.sin6_addr,
+		       sizeof(local_addr->sin6.sin6_addr));
 	} else {
 		udp_conf.family = AF_INET;
 		udp_conf.local_ip.s_addr = htonl(INADDR_ANY);
+		memcpy(&udp_conf.local_ip,
+		       &local_addr->sin.sin_addr,
+		       sizeof(local_addr->sin.sin_addr));
 	}
 
 	udp_conf.local_udp_port = port;
@@ -572,7 +580,8 @@ static int geneve_gro_complete(struct sock *sk, struct sk_buff *skb,
 
 /* Create new listen socket if needed */
 static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
-						bool ipv6, bool ipv6_rx_csum)
+						bool ipv6, bool ipv6_rx_csum,
+						union geneve_addr *local_addr)
 {
 	struct geneve_net *gn = net_generic(net, geneve_net_id);
 	struct geneve_sock *gs;
@@ -584,7 +593,7 @@ static struct geneve_sock *geneve_socket_create(struct net *net, __be16 port,
 	if (!gs)
 		return ERR_PTR(-ENOMEM);
 
-	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum);
+	sock = geneve_create_sock(net, ipv6, port, ipv6_rx_csum, local_addr);
 	if (IS_ERR(sock)) {
 		kfree(gs);
 		return ERR_CAST(sock);
@@ -672,7 +681,8 @@ static int geneve_sock_add(struct geneve_dev *geneve, bool ipv6)
 	}
 
 	gs = geneve_socket_create(net, geneve->cfg.info.key.tp_dst, ipv6,
-				  geneve->cfg.use_udp6_rx_checksums);
+				  geneve->cfg.use_udp6_rx_checksums,
+				  &geneve->cfg.saddr);
 	if (IS_ERR(gs))
 		return PTR_ERR(gs);
 
@@ -1203,7 +1213,7 @@ static void geneve_setup(struct net_device *dev)
 }
 
 static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
-	[IFLA_GENEVE_UNSPEC]		= { .strict_start_type = IFLA_GENEVE_INNER_PROTO_INHERIT },
+	[IFLA_GENEVE_UNSPEC]		= { .strict_start_type = IFLA_GENEVE_LOCAL6 },
 	[IFLA_GENEVE_ID]		= { .type = NLA_U32 },
 	[IFLA_GENEVE_REMOTE]		= { .len = sizeof_field(struct iphdr, daddr) },
 	[IFLA_GENEVE_REMOTE6]		= { .len = sizeof(struct in6_addr) },
@@ -1218,6 +1228,8 @@ static const struct nla_policy geneve_policy[IFLA_GENEVE_MAX + 1] = {
 	[IFLA_GENEVE_TTL_INHERIT]	= { .type = NLA_U8 },
 	[IFLA_GENEVE_DF]		= { .type = NLA_U8 },
 	[IFLA_GENEVE_INNER_PROTO_INHERIT]	= { .type = NLA_FLAG },
+	[IFLA_GENEVE_LOCAL]	= { .len = sizeof_field(struct iphdr, saddr) },
+	[IFLA_GENEVE_LOCAL6]	= { .len = sizeof(struct in6_addr) },
 };
 
 static int geneve_validate(struct nlattr *tb[], struct nlattr *data[],
@@ -1544,6 +1556,31 @@ static int geneve_nl2info(struct nlattr *tb[], struct nlattr *data[],
 		cfg->inner_proto_inherit = true;
 	}
 
+	if (data[IFLA_GENEVE_LOCAL]) {
+		if (changelink && cfg->saddr.sa.sa_family != AF_INET) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		cfg->saddr.sin.sin_addr.s_addr = nla_get_in_addr(data[IFLA_GENEVE_LOCAL]);
+		cfg->saddr.sa.sa_family = AF_INET;
+	}
+
+	if (data[IFLA_GENEVE_LOCAL6]) {
+		if (!IS_ENABLED(CONFIG_IPV6)) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6], "IPv6 support not enabled in the kernel");
+			return -EPFNOSUPPORT;
+		}
+
+		if (changelink && cfg->saddr.sa.sa_family != AF_INET6) {
+			NL_SET_ERR_MSG_ATTR(extack, tb[IFLA_GENEVE_LOCAL6], "New local address family does not match old");
+			return -EOPNOTSUPP;
+		}
+
+		cfg->saddr.sin6.sin6_addr = nla_get_in6_addr(data[IFLA_VXLAN_LOCAL6]);
+		cfg->saddr.sa.sa_family = AF_INET6;
+	}
+
 	return 0;
 change_notsup:
 	NL_SET_ERR_MSG_ATTR(extack, data[attrtype],
@@ -1724,6 +1761,7 @@ static size_t geneve_get_size(const struct net_device *dev)
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_UDP_ZERO_CSUM6_RX */
 		nla_total_size(sizeof(__u8)) + /* IFLA_GENEVE_TTL_INHERIT */
 		nla_total_size(0) +	 /* IFLA_GENEVE_INNER_PROTO_INHERIT */
+		nla_total_size(sizeof(struct in6_addr)) + /* IFLA_GENEVE_LOCAL{6} */
 		0;
 }
 
@@ -1745,6 +1783,11 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		if (nla_put_in_addr(skb, IFLA_GENEVE_REMOTE,
 				    info->key.u.ipv4.dst))
 			goto nla_put_failure;
+
+		if (nla_put_in_addr(skb, IFLA_GENEVE_LOCAL,
+				    info->key.u.ipv4.src))
+			goto nla_put_failure;
+
 		if (nla_put_u8(skb, IFLA_GENEVE_UDP_CSUM,
 			       !!(info->key.tun_flags & TUNNEL_CSUM)))
 			goto nla_put_failure;
@@ -1754,6 +1797,11 @@ static int geneve_fill_info(struct sk_buff *skb, const struct net_device *dev)
 		if (nla_put_in6_addr(skb, IFLA_GENEVE_REMOTE6,
 				     &info->key.u.ipv6.dst))
 			goto nla_put_failure;
+
+		if (nla_put_in6_addr(skb, IFLA_GENEVE_LOCAL6,
+				     &info->key.u.ipv6.src))
+			goto nla_put_failure;
+
 		if (nla_put_u8(skb, IFLA_GENEVE_UDP_ZERO_CSUM6_TX,
 			       !(info->key.tun_flags & TUNNEL_CSUM)))
 			goto nla_put_failure;
diff --git a/include/net/geneve.h b/include/net/geneve.h
index 5c96827a487e..8dcd7fff2c0f 100644
--- a/include/net/geneve.h
+++ b/include/net/geneve.h
@@ -68,6 +68,12 @@ static inline bool netif_is_geneve(const struct net_device *dev)
 	       !strcmp(dev->rtnl_link_ops->kind, "geneve");
 }
 
+union geneve_addr {
+	struct sockaddr_in sin;
+	struct sockaddr_in6 sin6;
+	struct sockaddr sa;
+};
+
 #ifdef CONFIG_INET
 struct net_device *geneve_dev_create_fb(struct net *net, const char *name,
 					u8 name_assign_type, u16 dst_port);
diff --git a/include/uapi/linux/if_link.h b/include/uapi/linux/if_link.h
index ab9bcff96e4d..e4a0cdea734b 100644
--- a/include/uapi/linux/if_link.h
+++ b/include/uapi/linux/if_link.h
@@ -1419,6 +1419,8 @@ enum {
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
diff --git a/tools/include/uapi/linux/if_link.h b/tools/include/uapi/linux/if_link.h
index a0aa05a28cf2..438bd867ec38 100644
--- a/tools/include/uapi/linux/if_link.h
+++ b/tools/include/uapi/linux/if_link.h
@@ -888,6 +888,8 @@ enum {
 	IFLA_GENEVE_TTL_INHERIT,
 	IFLA_GENEVE_DF,
 	IFLA_GENEVE_INNER_PROTO_INHERIT,
+	IFLA_GENEVE_LOCAL,
+	IFLA_GENEVE_LOCAL6,
 	__IFLA_GENEVE_MAX
 };
 #define IFLA_GENEVE_MAX	(__IFLA_GENEVE_MAX - 1)
-- 
2.36.1

