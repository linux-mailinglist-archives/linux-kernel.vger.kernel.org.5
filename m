Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DFD7657C0
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:34:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjG0Pe0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:34:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231799AbjG0PeW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:34:22 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700D426A8;
        Thu, 27 Jul 2023 08:34:21 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3fdfd4c749dso6776085e9.3;
        Thu, 27 Jul 2023 08:34:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690472060; x=1691076860;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dj+mM5KXpQqCCdCwg7vn+GdZ5wm15kON6FaHozgs714=;
        b=hAQvKhK091T0tUaIvXPYoWFzlb6eor6LUdeIJ4WWQAwzdDrg+ltlDU91aqOBZWT4zh
         zl4x9uFxX97u2PBDQ1XaOi1RF6lnGejCIlWmijkD0/Oqze666acioz5aqQTi73wrbnjQ
         cULmQjVLqZ85oVM/d0f3rdyvryFi/YAPWzRGQi1QTDcCzmlp+JnKCBZfLKaYkRjZiwFa
         F4oaJWKETp+g7d+4aDAzQAtsttaEbY9KmMVlwFheq7/iKQrac/aphxsyTx/8knvRPaDB
         MnU5c6W4W8gqhpLwFkdEVh9nRF5IB8qjS2j9E79PD2hTzn/XOJpupjuK0jy6cuj2DLFQ
         fzHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690472060; x=1691076860;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dj+mM5KXpQqCCdCwg7vn+GdZ5wm15kON6FaHozgs714=;
        b=IuS7zDdJYcnhpQ0rtuho+5U6d6IWrdrslwepuKgdlRA99ZjwLFeURQkhI03MvtXQ7y
         7lDS2jdzkBo3jm0AYHvvaz5gk7nGe79zk1eCkTDgIp332HXE2Z3KcvWcgz5s9RT8l4MK
         v0EC9wBFpZaBWyXifQwLl1vgrJEUNJJr4Cv74N7TdG19kzwfekPG2qWky4AHRr6L4qN+
         akR9Mjo91mslNIUvncrGzLpBng7edrooi7p2NA5Otqh6+EQWgHQ8WqVoO1efQzK0VyjK
         mVYGQ7kV2T6VyLkGOAcJulfVgypKof2GSHZRS5tiTxPkZGDR0XWtvgItPFAxn/4pXbep
         08Nw==
X-Gm-Message-State: ABy/qLZb+mzGQt0r21VVkmz1xTBG0OcWnSdkdE5gjATDJt9jdY5CkH9N
        M9qmjTqu9mtaAYP/nGQJ75A=
X-Google-Smtp-Source: APBJJlFy/wMBqU0Gg/y2CXR24xy2zzDL9gqjAOotNeqP9fu8MXSMh18TU9oB8j63QvuUy2a6Ioo3TA==
X-Received: by 2002:a7b:cc86:0:b0:3fb:e356:b60d with SMTP id p6-20020a7bcc86000000b003fbe356b60dmr2068046wma.38.1690472059635;
        Thu, 27 Jul 2023 08:34:19 -0700 (PDT)
Received: from debian ([89.238.191.199])
        by smtp.gmail.com with ESMTPSA id 1-20020a05600c248100b003fbb5142c4bsm5026343wms.18.2023.07.27.08.34.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jul 2023 08:34:19 -0700 (PDT)
Date:   Thu, 27 Jul 2023 17:33:56 +0200
From:   Richard Gobert <richardbgobert@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, willemdebruijn.kernel@gmail.com,
        dsahern@kernel.org, tom@herbertland.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, gal@nvidia.com
Subject: [PATCH v3 1/1] net: gro: fix misuse of CB in udp socket lookup
Message-ID: <20230727153353.GA32089@debian>
References: <20230727152503.GA32010@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727152503.GA32010@debian>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch fixes a misuse of IP{6}CB(skb) in GRO, while calling to
`udp6_lib_lookup2` when handling udp tunnels. `udp6_lib_lookup2` fetch the
device from CB. The fix changes it to fetch the device from `skb->dev`.
l3mdev case requires special attention since it has a master and a slave
device.

Fixes: a6024562ffd7 ("udp: Add GRO functions to UDP socket")
Reported-by: Gal Pressman <gal@nvidia.com>
Signed-off-by: Richard Gobert <richardbgobert@gmail.com>
---
 include/net/gro.h      | 43 ++++++++++++++++++++++++++++++++++++++++++
 net/ipv4/udp.c         |  8 ++++++--
 net/ipv4/udp_offload.c |  7 +++++--
 net/ipv6/udp.c         |  8 ++++++--
 net/ipv6/udp_offload.c |  7 +++++--
 5 files changed, 65 insertions(+), 8 deletions(-)

diff --git a/include/net/gro.h b/include/net/gro.h
index 75efa6fb8441..88644b3ca660 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -452,6 +452,49 @@ static inline void gro_normal_one(struct napi_struct *napi, struct sk_buff *skb,
 		gro_normal_list(napi);
 }
 
+/* This function is the alternative of 'inet_iif' and 'inet_sdif'
+ * functions in case we can not rely on fields of IPCB.
+ *
+ * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
+ * The caller must hold the RCU read lock.
+ */
+static inline void inet_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	*iif = inet_iif(skb) ?: skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
+/* This function is the alternative of 'inet6_iif' and 'inet6_sdif'
+ * functions in case we can not rely on fields of IP6CB.
+ *
+ * The caller must verify skb_valid_dst(skb) is false and skb->dev is initialized.
+ * The caller must hold the RCU read lock.
+ */
+static inline void inet6_get_iif_sdif(const struct sk_buff *skb, int *iif, int *sdif)
+{
+	/* using skb->dev->ifindex because skb_dst(skb) is not initialized */
+	*iif = skb->dev->ifindex;
+	*sdif = 0;
+
+#if IS_ENABLED(CONFIG_NET_L3_MASTER_DEV)
+	if (netif_is_l3_slave(skb->dev)) {
+		struct net_device *master = netdev_master_upper_dev_get_rcu(skb->dev);
+
+		*sdif = *iif;
+		*iif = master ? master->ifindex : 0;
+	}
+#endif
+}
+
 extern struct list_head offload_base;
 
 #endif /* _NET_IPV6_GRO_H */
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index 8c3ebd95f5b9..1ee9e56dc79a 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -114,6 +114,7 @@
 #include <net/sock_reuseport.h>
 #include <net/addrconf.h>
 #include <net/udp_tunnel.h>
+#include <net/gro.h>
 #if IS_ENABLED(CONFIG_IPV6)
 #include <net/ipv6_stubs.h>
 #endif
@@ -555,10 +556,13 @@ struct sock *udp4_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const struct iphdr *iph = ip_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 /* Must be called under rcu_read_lock().
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index 75aa4de5b731..d734f11e13cc 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -603,10 +603,13 @@ static struct sock *udp4_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct iphdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp4_lib_lookup(net, iph->saddr, sport,
-				 iph->daddr, dport, inet_iif(skb),
-				 inet_sdif(skb), net->ipv4.udp_table, NULL);
+				 iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index b7c972aa09a7..e5da5d1cb215 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -51,6 +51,7 @@
 #include <net/inet6_hashtables.h>
 #include <net/busy_poll.h>
 #include <net/sock_reuseport.h>
+#include <net/gro.h>
 
 #include <linux/proc_fs.h>
 #include <linux/seq_file.h>
@@ -300,10 +301,13 @@ struct sock *udp6_lib_lookup_skb(const struct sk_buff *skb,
 {
 	const struct ipv6hdr *iph = ipv6_hdr(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 /* Must be called under rcu_read_lock().
diff --git a/net/ipv6/udp_offload.c b/net/ipv6/udp_offload.c
index ad3b8726873e..31f12bd5d0fe 100644
--- a/net/ipv6/udp_offload.c
+++ b/net/ipv6/udp_offload.c
@@ -119,10 +119,13 @@ static struct sock *udp6_gro_lookup_skb(struct sk_buff *skb, __be16 sport,
 {
 	const struct ipv6hdr *iph = skb_gro_network_header(skb);
 	struct net *net = dev_net(skb->dev);
+	int iif, sdif;
+
+	inet6_get_iif_sdif(skb, &iif, &sdif);
 
 	return __udp6_lib_lookup(net, &iph->saddr, sport,
-				 &iph->daddr, dport, inet6_iif(skb),
-				 inet6_sdif(skb), net->ipv4.udp_table, NULL);
+				 &iph->daddr, dport, iif,
+				 sdif, net->ipv4.udp_table, NULL);
 }
 
 INDIRECT_CALLABLE_SCOPE
-- 
2.36.1

