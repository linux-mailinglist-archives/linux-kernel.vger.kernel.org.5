Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C72C2803DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:00:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231325AbjLDS7v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 13:59:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230479AbjLDS7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 13:59:49 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB27018B;
        Mon,  4 Dec 2023 10:59:53 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1d05e4a94c3so28679195ad.1;
        Mon, 04 Dec 2023 10:59:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701716393; x=1702321193; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=i0uA/nAdSSBYvQqKLBJS5Tfk1ptkGTgs0pXfTwS+FGw=;
        b=MIZRZglnYXjaD4mcLZINKrh1N1Jy0wOS/Lb+A2v5lF30wMQMsrxdBsBs1aVUkklEkG
         6zk//CJhhZuwrrn3duuKjAAMBHQTmeJJv7rm9mnhBFB5MhsRxVNKYDd0wZHD6JMOl8ON
         PvYnPp+SmukUdOfjSKawlZfxfBei6dwA2zR1J1Taus4nk76gxp4AN6BNfl6fXJPWmOQ+
         vvck3Hey8wEkb5mkVcXZkzWztZmzUd+J+RpYR7PZ7zKK8D33djHzSb1J5LF6lADkI39r
         EHkQIVwdr6t1jJ8al7GGb007AvK0/kwO4VjHQ9irrH7HmolYbiJahkyw4qSSHSSLDjcp
         wXxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701716393; x=1702321193;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=i0uA/nAdSSBYvQqKLBJS5Tfk1ptkGTgs0pXfTwS+FGw=;
        b=VPD9mpCXohMyQwsxL88ztlABUYelebSdKvZiHJ0vnNZsA2QVeZlIfRv1LKvmJAJG7q
         OLXuklsBXjpvNfVVpszcuPf8PyYRKOcJpGcT34y/ASZluqwfBn6N0V4pZOwrUCMoLorc
         Z7EUxF2OMTtJZ44romFAmOgkflL+RWNDqDCrI70mCEQmjhQTgIyC+2AiFA7h0uJD3T7m
         U9UytSck2jRDjghhiZK4y64qy17hq0dwnvuRmAnA5vGgodX99NKDnvfQFhwgx6BCR4Bq
         BWC2qddAQD0ncUZf+95Uj0VPOG0hFc0ofx5Zn1NYsSSxAq0R41iT1yVbj9ba/CzGC7ry
         Fa2Q==
X-Gm-Message-State: AOJu0YwVjNp/kFiH1zCsWrBfrNSVLg3yaV/tMctqbe2GAHRLBI6qu9ps
        U2AU0TZFjaTwWtKeGHeoTKk=
X-Google-Smtp-Source: AGHT+IE/omQMvivvItWqXPsnr3Ir+lPsN14y4ptnomN55g3nPajVrILJABoWThW3wTyieg3DXzT/qg==
X-Received: by 2002:a17:902:b7cc:b0:1cf:cf34:d504 with SMTP id v12-20020a170902b7cc00b001cfcf34d504mr4386270plz.36.1701716393258;
        Mon, 04 Dec 2023 10:59:53 -0800 (PST)
Received: from localhost.localdomain ([114.249.31.17])
        by smtp.gmail.com with ESMTPSA id jg9-20020a17090326c900b001cfc6838e30sm4474901plb.308.2023.12.04.10.59.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Dec 2023 10:59:52 -0800 (PST)
From:   YangXin <yx.0xffff@gmail.com>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] net: ___neigh_lookup_noref(): remove redundant parameters
Date:   Tue,  5 Dec 2023 02:59:43 +0800
Message-Id: <20231204185943.68-1-yx.0xffff@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

key_eq() and hash() are functions of struct neigh_table, so we just need to call tbl->key_eq() and tbl->hash(), instead of passing them in as parameters.

Signed-off-by: YangXin <yx.0xffff@gmail.com>

diff --git a/include/net/arp.h b/include/net/arp.h
index e8747e0713c7..c3a329f759af 100644
--- a/include/net/arp.h
+++ b/include/net/arp.h
@@ -24,7 +24,7 @@ static inline struct neighbour *__ipv4_neigh_lookup_noref(struct net_device *dev
 	if (dev->flags & (IFF_LOOPBACK | IFF_POINTOPOINT))
 		key = INADDR_ANY;
 
-	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, arp_hashfn, &key, dev);
+	return ___neigh_lookup_noref(&arp_tbl, neigh_key_eq32, &key, dev);
 }
 #else
 static inline
diff --git a/include/net/ndisc.h b/include/net/ndisc.h
index 9bbdf6eaa942..023fb7ebb63c 100644
--- a/include/net/ndisc.h
+++ b/include/net/ndisc.h
@@ -380,15 +380,14 @@ static inline u32 ndisc_hashfn(const void *pkey, const struct net_device *dev, _
 
 static inline struct neighbour *__ipv6_neigh_lookup_noref(struct net_device *dev, const void *pkey)
 {
-	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, ndisc_hashfn, pkey, dev);
+	return ___neigh_lookup_noref(&nd_tbl, neigh_key_eq128, pkey, dev);
 }
 
 static inline
 struct neighbour *__ipv6_neigh_lookup_noref_stub(struct net_device *dev,
 						 const void *pkey)
 {
-	return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128,
-				     ndisc_hashfn, pkey, dev);
+	return ___neigh_lookup_noref(ipv6_stub->nd_tbl, neigh_key_eq128, pkey, dev);
 }
 
 static inline struct neighbour *__ipv6_neigh_lookup(struct net_device *dev, const void *pkey)
diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index 0d28172193fa..e21dbfc612b4 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -292,10 +292,6 @@ static inline bool neigh_key_eq128(const struct neighbour *n, const void *pkey)
 
 static inline struct neighbour *___neigh_lookup_noref(
 	struct neigh_table *tbl,
-	bool (*key_eq)(const struct neighbour *n, const void *pkey),
-	__u32 (*hash)(const void *pkey,
-		      const struct net_device *dev,
-		      __u32 *hash_rnd),
 	const void *pkey,
 	struct net_device *dev)
 {
@@ -303,11 +299,11 @@ static inline struct neighbour *___neigh_lookup_noref(
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
 
@@ -318,7 +314,7 @@ static inline struct neighbour *__neigh_lookup_noref(struct neigh_table *tbl,
 						     const void *pkey,
 						     struct net_device *dev)
 {
-	return ___neigh_lookup_noref(tbl, tbl->key_eq, tbl->hash, pkey, dev);
+	return ___neigh_lookup_noref(tbl, pkey, dev);
 }
 
 static inline void neigh_confirm(struct neighbour *n)
-- 
2.33.0

