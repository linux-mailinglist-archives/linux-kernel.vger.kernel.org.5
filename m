Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71F677F0C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 08:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232035AbjKTHKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 02:10:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbjKTHKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 02:10:14 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56CABBC
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:09 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id 98e67ed59e1d1-28398d6c9f3so2439543a91.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 23:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1700464209; x=1701069009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+DYEnQ+jfZcUuq4nlzb+NkHPQ+JKHORa1x2uG9sVgs=;
        b=NZFXLqYCWva3LUJ2NbXLcOWmUWd3w78fY4SiRo1FnbetqeSEJwNhUql+okYxf07aKb
         a0JDRgUQAzZH5zGts7Kcv2j16K/BRwkVBxj9DjDoyirNvex7/y9dfeSCAgVrk6eB6pOY
         j04FltSNADeiAbsjGTsLSu3jXpn4fn3DtGG9NqGq/b5vNNXUZ0f75UFPbzA/uU9eaiiV
         pouFgA63CBjOvVzb31qyS0MqL1rgTrNeFfd5vBbeNOnMoMuHTLEIOMzF6ApETZG2dQvt
         4sv7g3hkah8462gpRqg8XbTtlIaDmvkvLWNzENjDp9fACuLF63JexmwA5PUGs3gSidmq
         x5RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700464209; x=1701069009;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G+DYEnQ+jfZcUuq4nlzb+NkHPQ+JKHORa1x2uG9sVgs=;
        b=cbkEq9jEqQKUAiaRSxm6ofdvAjmX0NskhPn/yQW/Vm70o1gplkYz0KuAmi/nFDSK+l
         Wruw69S6IoxVNoZSJqzNsvBQopCkTw2CZ5v5f6dShjdGMH2bqI3t0lXfLyTPOWwyUKno
         t+VvKM8JW0e4Qbd50HtBUNjb2rIBduAQS5B17EKLzMmLpSvIqBrnOTfw4s/R/Hb501LD
         ULOLX/RtbuacWy9G6uV8X1AoAocrwBLjTFGvJQy6ajb92avR2ejqm93EtVLY5Wp+nFp5
         x+niPwQ19UfvKDm/iW8IlmaMB/HHsouyVjo9ERIep2JH/mEhWgchJF94gjJunQY/lIXD
         LsuA==
X-Gm-Message-State: AOJu0YxTuUDqoLiBEUrloxQU0BpvNbWwhdS4K3rRc1ZzQfS+R8vVE1eU
        K1apkqxjvhmBsIihY/+9OHkE3g==
X-Google-Smtp-Source: AGHT+IF83+lkbrauzNf5VU39sKkm3EJmrNtdZZs24FDn4zfpE+cr9/s7OrmNO9P9Edg8qWo55ZF4Bg==
X-Received: by 2002:a17:90b:224a:b0:280:4829:52d6 with SMTP id hk10-20020a17090b224a00b00280482952d6mr6485131pjb.29.1700464208748;
        Sun, 19 Nov 2023 23:10:08 -0800 (PST)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.146])
        by smtp.gmail.com with ESMTPSA id d4-20020a170902cec400b001ce67fab3a2sm3698143plg.261.2023.11.19.23.10.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Nov 2023 23:10:08 -0800 (PST)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, dan.carpenter@linaro.org,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        maple-tree@lists.infradead.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH v2 5/5] maple_tree: Simplify mas_leaf_set_meta()
Date:   Mon, 20 Nov 2023 15:09:37 +0800
Message-Id: <20231120070937.35481-6-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-145)
In-Reply-To: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
References: <20231120070937.35481-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now it seems that the incoming 'end' is already pointing to the last item,
so we can simplify this function, considering only whether the last slot is
being used. This has passed the maple tree test suite.

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
Reviewed-by: Liam R. Howlett <Liam.Howlett@oracle.com>
---
 lib/maple_tree.c | 22 ++++------------------
 1 file changed, 4 insertions(+), 18 deletions(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index bf64d080b376..89f8d2160277 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -1964,27 +1964,13 @@ static inline void mas_mab_cp(struct ma_state *mas, unsigned char mas_start,
 
 /*
  * mas_leaf_set_meta() - Set the metadata of a leaf if possible.
- * @mas: The maple state
  * @node: The maple node
- * @pivots: pointer to the maple node pivots
  * @mt: The maple type
- * @end: The assumed end
- *
- * Note, end may be incremented within this function but not modified at the
- * source.  This is fine since the metadata is the last thing to be stored in a
- * node during a write.
+ * @end: The node end
  */
-static inline void mas_leaf_set_meta(struct ma_state *mas,
-		struct maple_node *node, unsigned long *pivots,
+static inline void mas_leaf_set_meta(struct maple_node *node,
 		enum maple_type mt, unsigned char end)
 {
-	/* There is no room for metadata already */
-	if (mt_pivots[mt] <= end)
-		return;
-
-	if (pivots[end] && pivots[end] < mas->max)
-		end++;
-
 	if (end < mt_slots[mt] - 1)
 		ma_set_meta(node, mt, 0, end);
 }
@@ -2041,7 +2027,7 @@ static inline void mab_mas_cp(struct maple_big_node *b_node,
 
 		ma_set_meta(node, mt, offset, end);
 	} else {
-		mas_leaf_set_meta(mas, node, pivots, mt, end);
+		mas_leaf_set_meta(node, mt, end);
 	}
 }
 
@@ -3962,7 +3948,7 @@ static inline bool mas_wr_node_store(struct ma_wr_state *wr_mas,
 		dst_pivots[new_end] = mas->max;
 
 done:
-	mas_leaf_set_meta(mas, newnode, dst_pivots, maple_leaf_64, new_end);
+	mas_leaf_set_meta(newnode, maple_leaf_64, new_end);
 	if (in_rcu) {
 		struct maple_enode *old_enode = mas->node;
 
-- 
2.20.1

