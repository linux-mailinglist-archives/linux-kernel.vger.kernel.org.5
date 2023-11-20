Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 204CD7F0C8B
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232013AbjKTHKH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231997AbjKTHKF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:10:05 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F188E3
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:02 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1ce95f96edcso8391175ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700464201; x=1701069001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w9+DAd0kh6Tp0D5lzI/a0yHeYFuqsn6U0+a+XQf0dsw=;
        b=BY+4TiLPFASyKbgIbtsCrhuE9GKt9XaJ4XOMxxvucaRaIcFCCDk93+PXAjrAUFVVEw
         njJPugZ2qtKr0U2tMwMBfXoME2/kckA22L3PvTUsvUF2zxfrZuT3fOvr8mqo/56KXCmN
         QlZwxbE7o5ZTyVsHNMl2oroQ05irfROypkvksI1jT0m4D9C0de5rXimc2Dzaq1THXy4H
         kofUDr+qBzC7aaa74Rtf7Z5aO9hAMWioYBnw2AFPSZOdw3HISNwXSjN7ayHDlYmmOIM/
         6VW+JSYMGnwQwXYO1SqeLqSyuLYVpv6yI/9Ig9pqP6ed9osI32eXn20cIhFBrg0vmpoT
         wDLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464201; x=1701069001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w9+DAd0kh6Tp0D5lzI/a0yHeYFuqsn6U0+a+XQf0dsw=;
        b=rH31eCvzXxUETDQz7Bu9y1sBJXDCzPn2R7RjPiV8FoDQGbWuvvP+n56zMBamx/BkxI
         RnIt6WxXy1SVdJuHbSmPlCDmPcsQl9TQCmqQEPTn2ZDbyNkjkI4rnw5bC/bQhz3wnJyu
         75ODW/N39yQHA73Wo7/SIq3ZNrGQnHeRfoti1HJCREG0k75hcz0pH/9IkQojtCsEL3d7
         Gn6zz3q/cengG/Pi1s3VKGTARREZrIpzX44FtKbk/eo7ozd7gnj6fsazwFw9LpRmlkL3
         5cWcgwcMGWpqYjONIy44wxjg7ZB5Zs77GoNkjIzqvNJ5rig2I1zdAm5zZ/Kc2rOpdy2m
         WHWQ==
X-Gm-Message-State: AOJu0YyAThS46AQYMnQrpgvhtil6+p1w2+5xlilZB/D5n2j/xNZOlAUU
        GSqxSTkf3G4eAnGyAzfICMzeig==
X-Google-Smtp-Source: AGHT+IGNvUs250aFwRwvpMkhOgmdzOmS2EHci8LS5ZEc+jeuyEGmhe+PjdF04JneUJX4CWCT5jVIdw==
X-Received: by 2002:a17:902:ec82:b0:1cc:5549:aabd with SMTP id x2-20020a170902ec8200b001cc5549aabdmr5176361plg.8.1700464201587;
        Sun, 19 Nov 2023 23:10:01 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001ce67fab3a2sm3698143plg.261.2023.11.19.23.09.58
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 23:10:01 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, dan.carpenter@linaro.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 3/5] maple_tree: Remove an unused parameter for ma_meta_end()
Date:   Mon, 20 Nov 2023 15:09:35 +0800
Message-Id: <20231120070937.35481-4-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
References: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
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

The parameter maple_type is not used, so remove it.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index cc928b5f753d..3d894f849e57 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -930,10 +930,8 @@ static inline unsigned char ma_meta_end(struct maple_node *mn,
 /*
  * ma_meta_gap() - Get the largest gap location of a node from the metadata
  * @mn: The maple node
- * @mt: The maple node type
  */
-static inline unsigned char ma_meta_gap(struct maple_node *mn,
-					enum maple_type mt)
+static inline unsigned char ma_meta_gap(struct maple_node *mn)
 {
 	return mn->ma64.meta.gap;
 }
@@ -1587,7 +1585,7 @@ static inline unsigned long mas_max_gap(struct ma_state *mas)
 
 	node = mas_mn(mas);
 	MAS_BUG_ON(mas, mt != maple_arange_64);
-	offset = ma_meta_gap(node, mt);
+	offset = ma_meta_gap(node);
 	gaps = ma_gaps(node, mt);
 	return gaps[offset];
 }
@@ -1618,7 +1616,7 @@ static inline void mas_parent_gap(struct ma_state *mas, unsigned char offset,
 
 ascend:
 	MAS_BUG_ON(mas, pmt != maple_arange_64);
-	meta_offset = ma_meta_gap(pnode, pmt);
+	meta_offset = ma_meta_gap(pnode);
 	meta_gap = pgaps[meta_offset];
 
 	pgaps[offset] = new;
@@ -7252,7 +7250,7 @@ static void mas_validate_gaps(struct ma_state *mas)
 counted:
 	if (mt == maple_arange_64) {
 		MT_BUG_ON(mas->tree, !gaps);
-		offset = ma_meta_gap(node, mt);
+		offset = ma_meta_gap(node);
 		if (offset > i) {
 			pr_err("gap offset %p[%u] is invalid\n", node, offset);
 			MT_BUG_ON(mas->tree, 1);
-- 
2.20.1

