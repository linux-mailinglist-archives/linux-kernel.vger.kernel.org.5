Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57B8D7BD52E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 10:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234435AbjJII0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 04:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234431AbjJII0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 04:26:19 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 848B2B6;
        Mon,  9 Oct 2023 01:26:18 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533c5d10dc7so7345409a12.3;
        Mon, 09 Oct 2023 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696839977; x=1697444777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=owZcEmAsFdnN8HKDvbp9Goa51e2ivCQAo3bw3SJCz0I=;
        b=iaR+4tJ0aTLMAb2Q3pCq53cY4VSkV0xmjR/4hp4U9CSxXJu95E7khnBnEddGEJDeb0
         SmbEzA4jfaIkiSfJkIWGV36AS6U3m+OLNNONUpVc4skw5HGUKpAwtJB05YoD0zmYwynZ
         pQ01ljk6aKpYDs8Jf718H1cEd0CeSz/od6mQE5tIlubBi4P9OPJL72uBgXmM18OQAix/
         r6YtpjJrINO7/9+9OJXy30/iFDAY/WkZEm3bm/7RENx1skztwOds5Zu/GMO3clVaowbh
         OKNDmBquIm/fQOsHuDS3Fya/ZUAaV3uGnqvJsczliSfiJIG9vfot3mNyVe01DUDZcS0k
         XUqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696839977; x=1697444777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=owZcEmAsFdnN8HKDvbp9Goa51e2ivCQAo3bw3SJCz0I=;
        b=wmttCGXYY+DkNk0kQSLvHjbE0HWkVm4qj4WMy+NnCJz/6vGtugCeOtH1KN2d1omJAm
         D60b+CVBsuteMhbHOGwsW4SuAeewxW9sraDB1cts16cOL973+4L4fYEounHZ/CMEy4fS
         9UPTGydY9PvCtbnyv2Pncr0zrate/K7rdDIrOqerj9/ZtUt0AnzhNKwPAcgqRL6LlOco
         qqJgcphI1LHDG4R40pMnHkppOhunZZBev4kxhGx2b0CVzOlxGfSqjQ0pXNU/oZ8f6iIZ
         iplarwjPzS7+kvVPoQA/9IpHA5zOvxF/LI6B9LoGMgPR9aweVVcjieo83SmGvH/Zd7KN
         ok4Q==
X-Gm-Message-State: AOJu0Ywdtr2qowBDTASot2l/jtHKpJIDzLErt0tS0+RNIbxtoy6xmhql
        H6b4gRAe7xhOL1UnKr1D6EL6hc8dmm4=
X-Google-Smtp-Source: AGHT+IHPgo2UaEnqpB7MU1D11ZGnLn8MHmAsbVr1gfJ6Y+aIuhETe25/EiAThILS6QVpbC9HUpnxYg==
X-Received: by 2002:aa7:d415:0:b0:522:1d30:efce with SMTP id z21-20020aa7d415000000b005221d30efcemr12933263edq.22.1696839976943;
        Mon, 09 Oct 2023 01:26:16 -0700 (PDT)
Received: from tp.home.arpa (host-79-24-102-58.retail.telecomitalia.it. [79.24.102.58])
        by smtp.gmail.com with ESMTPSA id p22-20020a05640210d600b00530a9488623sm5844810edu.46.2023.10.09.01.26.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Oct 2023 01:26:16 -0700 (PDT)
From:   Beniamino Galvani <b.galvani@gmail.com>
To:     netdev@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        David Ahern <dsahern@kernel.org>,
        Guillaume Nault <gnault@redhat.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH net-next 5/7] geneve: add dsfield helper function
Date:   Mon,  9 Oct 2023 10:20:57 +0200
Message-Id: <20231009082059.2500217-6-b.galvani@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231009082059.2500217-1-b.galvani@gmail.com>
References: <20231009082059.2500217-1-b.galvani@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a helper function to compute the tos/dsfield. In this way, we can
factor out some duplicate code. Also, the helper will be called from
more places in the next commit.

Suggested-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: Beniamino Galvani <b.galvani@gmail.com>
---
 drivers/net/geneve.c | 29 ++++++++++++++++++-----------
 1 file changed, 18 insertions(+), 11 deletions(-)

diff --git a/drivers/net/geneve.c b/drivers/net/geneve.c
index 78f9d588f712..572c3e36b209 100644
--- a/drivers/net/geneve.c
+++ b/drivers/net/geneve.c
@@ -784,6 +784,22 @@ static int geneve_build_skb(struct dst_entry *dst, struct sk_buff *skb,
 	return err;
 }
 
+static u8 geneve_get_dsfield(struct sk_buff *skb, struct net_device *dev,
+			     const struct ip_tunnel_info *info,
+			     bool *use_cache)
+{
+	struct geneve_dev *geneve = netdev_priv(dev);
+	u8 dsfield;
+
+	dsfield = info->key.tos;
+	if (dsfield == 1 && !geneve->cfg.collect_md) {
+		dsfield = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
+		*use_cache = false;
+	}
+
+	return dsfield;
+}
+
 static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 				       struct net_device *dev,
 				       struct geneve_sock *gs4,
@@ -810,11 +826,7 @@ static struct rtable *geneve_get_v4_rt(struct sk_buff *skb,
 	fl4->fl4_sport = sport;
 	fl4->flowi4_flags = info->key.flow_flags;
 
-	tos = info->key.tos;
-	if ((tos == 1) && !geneve->cfg.collect_md) {
-		tos = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
-		use_cache = false;
-	}
+	tos = geneve_get_dsfield(skb, dev, info, &use_cache);
 	fl4->flowi4_tos = RT_TOS(tos);
 	if (full_tos)
 		*full_tos = tos;
@@ -865,12 +877,7 @@ static struct dst_entry *geneve_get_v6_dst(struct sk_buff *skb,
 	fl6->fl6_dport = dport;
 	fl6->fl6_sport = sport;
 
-	prio = info->key.tos;
-	if ((prio == 1) && !geneve->cfg.collect_md) {
-		prio = ip_tunnel_get_dsfield(ip_hdr(skb), skb);
-		use_cache = false;
-	}
-
+	prio = geneve_get_dsfield(skb, dev, info, &use_cache);
 	fl6->flowlabel = ip6_make_flowinfo(prio, info->key.label);
 	dst_cache = (struct dst_cache *)&info->dst_cache;
 	if (use_cache) {
-- 
2.40.1

