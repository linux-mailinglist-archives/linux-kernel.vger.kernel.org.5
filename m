Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824E77F04FC
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Nov 2023 10:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229703AbjKSJZv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 04:25:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229668AbjKSJZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 04:25:49 -0500
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EA0811D
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:25:46 -0800 (PST)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-3b2ea7cca04so2365231b6e.2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 01:25:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1700385946; x=1700990746; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FD0yKcX7kb1gSGQ8bjxMh0bsMglpu98y3UOeL+swq7s=;
        b=UpJnNI1gUBRN5wInuTBJwDa0M3BX3ItfR9/62g7jCoGn1Au4zpDw1NCriO4KISsfyd
         XLaOHrHqZ+xfI8MV60hF/1suplUD/D2ZoxVuL1QUDXfvHgLdm+SwCgTd5kcJKLxkmx5g
         XgKpkdG5BmSdsuPqBaaWT+DaBIzR7T80pbn+cNaPIMc19qzzZ1N0MgJlKkazmRuFfveY
         aFfyngqgmHoed7TyFOGj8n3RheNeLIz1sp98RyG+lEd9JC2oB1EowvsU0H8z+P1OOgqe
         PKhFcgWv9/3auf8Dyh3I7p0HzemFogneF+/jJgMM3VB4Zc6xNjA0l0Mtj0yDc/2oGFg6
         tm2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700385946; x=1700990746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FD0yKcX7kb1gSGQ8bjxMh0bsMglpu98y3UOeL+swq7s=;
        b=fCg5CJsWxraF6HMWj85lv/j4uPhdvTE+fG4lN4M1qdejQlW1TtHY/v3WIcDhR2ZlxG
         0JipgMk160KvhJjBpEmmO6OsqXVtl16aIJHpcmvHtjlAhYifnb41oZbifY7AeQedmTjc
         WLf+NSmLJ8+1fHv/9URhdB7KrCUqtiPs7gHr6oZBfDg1Uvu85Fgb5n5eDilgcH7qxjqd
         wfb5VeYxVdZSzqB4bEs3M2BycBcDmZqBlHXJI39/VPViGBWCJVtc/r06cWY6I9Y+mN/z
         Rk40JpWwxvdCleiL/HlYq8+dTIzGak29uQPdrHfTDhXKvaS1uZa2/RpN824R+4DRPWiP
         eN8Q==
X-Gm-Message-State: AOJu0Yy/ghX++5MmgQBedcR+481dIWtbAmmTG1gxJLQrSCtkFTTGHpLp
        TOImaUldnNgJWFPmj1KWgaknKg==
X-Google-Smtp-Source: AGHT+IFO3PUO8cjn+I99JfAVxnBNNpjCqvobLaIcZMSfHpc3ahoKwFZ3EOdta2OymcCDqTlB/F73Cg==
X-Received: by 2002:a05:6808:f02:b0:3ae:3bd:d3d2 with SMTP id m2-20020a0568080f0200b003ae03bdd3d2mr6355804oiw.10.1700385945893;
        Sun, 19 Nov 2023 01:25:45 -0800 (PST)
Received: from ubuntu-hf2.default.svc.cluster.local ([101.127.248.173])
        by smtp.gmail.com with ESMTPSA id d8-20020a170903230800b001cc0e3a29a8sm4060770plh.89.2023.11.19.01.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Nov 2023 01:25:45 -0800 (PST)
From:   Haifeng Xu <haifeng.xu@shopee.com>
To:     edumazet@google.com
Cc:     andy@greyhouse.net, davem@davemloft.net, j.vosburgh@gmail.com,
        kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Haifeng Xu <haifeng.xu@shopee.com>
Subject: [PATCH v3 1/2] bonding: export devnet_rename_sem
Date:   Sun, 19 Nov 2023 09:25:29 +0000
Message-Id: <20231119092530.13071-1-haifeng.xu@shopee.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
References: <CANn89iKsirkSvxK4L9KQqD7Q7r0MaxOx71VBk73RCi8b1NkiZw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch exports devnet_rename_sem variable, so it can be accessed in the
bonding modulde, not only being limited in net/core/dev.c.

Signed-off-by: Haifeng Xu <haifeng.xu@shopee.com>
Suggested-by: Eric Dumazet <edumazet@google.com>
---
 include/net/bonding.h | 3 +++
 net/core/dev.c        | 3 ++-
 2 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/include/net/bonding.h b/include/net/bonding.h
index 5b8b1b644a2d..6c16d778b615 100644
--- a/include/net/bonding.h
+++ b/include/net/bonding.h
@@ -780,6 +780,9 @@ extern const struct sysfs_ops slave_sysfs_ops;
 /* exported from bond_3ad.c */
 extern const u8 lacpdu_mcast_addr[];
 
+/* exported from net/core/dev.c */
+extern struct rw_semaphore devnet_rename_sem;
+
 static inline netdev_tx_t bond_tx_drop(struct net_device *dev, struct sk_buff *skb)
 {
 	dev_core_stats_tx_dropped_inc(dev);
diff --git a/net/core/dev.c b/net/core/dev.c
index af53f6d838ce..fdafab617227 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -197,7 +197,8 @@ static DEFINE_SPINLOCK(napi_hash_lock);
 static unsigned int napi_gen_id = NR_CPUS;
 static DEFINE_READ_MOSTLY_HASHTABLE(napi_hash, 8);
 
-static DECLARE_RWSEM(devnet_rename_sem);
+DECLARE_RWSEM(devnet_rename_sem);
+EXPORT_SYMBOL(devnet_rename_sem);
 
 static inline void dev_base_seq_inc(struct net *net)
 {
-- 
2.25.1

