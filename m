Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 265BF805E5E
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 20:10:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231219AbjLETKC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 14:10:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjLETJ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 14:09:59 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881B3194;
        Tue,  5 Dec 2023 11:10:01 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-6ce4d4c5ea2so2095548b3a.0;
        Tue, 05 Dec 2023 11:10:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701803401; x=1702408201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LPvsreD7SHt4olmNelnu/glf+fhgjLiYFThCak4nyVI=;
        b=Hhn7edkoFmTEiS3+su/j/RRiFeVA9otf8tmzu6jhc75nIjt/f4/yDJtvIr1uDpjQmD
         QDxDynTskK5OLmTTQqxKSj6HwUlZx8AK8mMvMgPXEBUKpcoGwTXKE9UfZDw7BWlNyR9H
         qITgRwSJQKZlUpRaP567Wtq7pBrVO2ERNT+Lu3JUQb03+tU8+4qA10d4J6PdMUAEaAGJ
         E+pRrJNTJKsapNyH+skD5fRK7l0nwdiF+bV9hh/rC6rY82eEWbCZF4I7uqz/HB2kUk9r
         296unvcjwWGAhvpG5W2JnDWo0U46iPXcxOe8aZ7wB8SG7IulbGNAB49T52CVLnsx/uF6
         zW9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701803401; x=1702408201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LPvsreD7SHt4olmNelnu/glf+fhgjLiYFThCak4nyVI=;
        b=xPA6i2dTsrVGOYPrUqZoin5K26HS2RzzqxgF4zspfzY2+q+sVdjmKP9b7iYbcD7Zsq
         SNOUlclGkcUXhEJUMgs9zNDRP308euLwDHvSNnbZiwdfO7OpnmkXbSsHGKOWiLoGyJNZ
         zXpmHOU6Z91bRfUxuIftV4osshC4OvDm2A0SKFsng0RRWqQBrv/BBy5Y21k2CIq3u7y3
         83oBPYjEF+yHyETgkXgvgGnSu/U+PvBwd/tkHKhdkon4/1r35LvLrgRq6RJ14/IHmJT6
         I7Hp0UifN6H3f8XRlW9AYQsCSEFdcSFAwqIlA6Y9sI7YpG4JVrQ9I6YzhnWoeqLCi5Rn
         oRKQ==
X-Gm-Message-State: AOJu0YzpTwxbqRcdZ5E4Fd8rxpKDTH0NUHwJj1NGMCqUvTDVSVn1p0nT
        HbfeVL1QNZLwjaHUeM/Ena4=
X-Google-Smtp-Source: AGHT+IEDq+Ez0h9sWD3yvp/dBLNWpF1VLCTMHXfh4bbVjAmC2l7HwMujCksKsd5K58RuIsXkbKQ4bQ==
X-Received: by 2002:a05:6a21:19d:b0:18c:570d:c5b4 with SMTP id le29-20020a056a21019d00b0018c570dc5b4mr26991876pzb.35.1701803400827;
        Tue, 05 Dec 2023 11:10:00 -0800 (PST)
Received: from localhost.localdomain ([114.249.31.17])
        by smtp.gmail.com with ESMTPSA id v18-20020a63f212000000b005ab281d0777sm9624568pgh.20.2023.12.05.11.09.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 11:10:00 -0800 (PST)
From:   YangXin <yx.0xffff@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: remove ___neigh_lookup_noref().
Date:   Wed,  6 Dec 2023 03:09:51 +0800
Message-Id: <20231205190951.67-1-yx.0xffff@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key_eq() and hash() are functions of struct neigh_table, so we just need to call tbl->key_eq() and tbl->hash(), instead of passing them in as parameters. 

And if those two parameters were removed,  ___neigh_lookup_noref() would be pointless, so I replaced ___neigh_lookup_noref() with __neigh_lookup_noref().

Signed-off-by: YangXin <yx.0xffff@gmail.com>
---
Last time I comitted this patch, Mr Dumazet said "this might defeat inlining.".
So I compiled kernel on my computer with defconfig, made sure that this patch would not lead __neigh_lookup_noref() fail to inline.

My enviroment:
Debian12
gcc version:
gcc (Debian 12.2.0-14) 12.2.0

 include/net/arp.h       |  2 +-
 include/net/ndisc.h     |  5 ++---
 include/net/neighbour.h | 22 +++++-----------------
 3 files changed, 8 insertions(+), 21 deletions(-)

diff --git a/include/net/arp.h b/include/net/arp.h
index e8747e0713c7..e274c7fc5020 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -24,7 +24,7 @@ static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev
 	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
 		key = INADDR_ANY;
 
-	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn, &key, dev);
+	return __neigh_lookup_noref(&arp_tbl, &key, dev);
 }
 #else
 static inline
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 9bbdf6eaa942..8e0ba9a87e4d 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -380,15 +380,14 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 
 static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
 {
-	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
+	return __neigh_lookup_noref(&nd_tbl, pkey, dev);
 }
 
 static inline
 struct neighbour *__ipv6_neigh_lookup_noref_stub(struct net_device *dev,
 						 const void *pkey)
 {
-	return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128,
-				     ndisc_hashfn, pkey, dev);
+	return __neigh_lookup_noref(ipv6_stub->nd_tbl, pkey, dev);
 }
 
 static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0d28172193fa..434c9e7c7ea7 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -290,37 +290,25 @@ static inline bool neigh_key_eq128(const struct neighbour *n, const void *pkey)
 		(n32[2] ^ p32[2]) | (n32[3] ^ p32[3])) == 0;
 }
 
-static inline struct neighbour *___neigh_lookup_noref(
-	struct neigh_table *tbl,
-	bool (*key_eq)(const struct neighbour *n, const void *pkey),
-	__u32 (*hash)(const void *pkey,
-		      const struct net_device *dev,
-		      __u32 *hash_rnd),
-	const void *pkey,
-	struct net_device *dev)
+static inline struct neighbour *__neigh_lookup_noref(struct neigh_table *tbl,
+						     const void *pkey,
+						     struct net_device *dev)
 {
 	struct neigh_hash_table *nht = rcu_dereference(tbl->nht);
 	struct neighbour *n;
 	u32 hash_val;
 
-	hash_val = hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
+	hash_val = tbl->hash(pkey, dev, nht->hash_rnd) >> (32 - nht->hash_shift);
 	for (n = rcu_dereference(nht->hash_buckets[hash_val]);
 	     n != NULL;
 	     n = rcu_dereference(n->next)) {
-		if (n->dev == dev && key_eq(n, pkey))
+		if (n->dev == dev && tbl->key_eq(n, pkey))
 			return n;
 	}
 
 	return NULL;
 }
 
-static inline struct neighbour *__neigh_lookup_noref(struct neigh_table *tbl,
-						     const void *pkey,
-						     struct net_device *dev)
-{
-	return ___neigh_lookup_noref(tbl, tbl->key_eq, tbl->hash, pkey, dev);
-}
-
 static inline void neigh_confirm(struct neighbour *n)
 {
 	if (n) {
-- 
2.33.0

