Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0F762FA5
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 10:23:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233133AbjGZIWz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 04:22:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbjGZIWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 04:22:11 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9844C13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:02 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b9c434fe75so5317097a34.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jul 2023 01:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1690359001; x=1690963801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBWhUMSjOCubXY+PC9p9DMz2fuhl5l7G2DCnpXKXi44=;
        b=RXB/luIXuwGwXY6rqH5frdTWpd6w9LTeUKn410+nFpUsNaJ23LLavNegSawCjRQMgP
         olOEFVPrbE0jXarH32neIg973IiVObAB37RV1Je7V6W6onAegs08yBYLMxWW4j27U03B
         hRTru99Vp9e2P5P7I1yZCu3hCHl6eDVSN3p1/mQN5OYlpRyyeZZmDVUBbwGJZaY20H4v
         +Q7yDQfwWSqQdd6nsa9TBmh2ADavZejwsPqQ3zGHYBIy3WOGxQ8Wc0Mt+U6dEDUIIa22
         6tz1eEu1O31YEPOltcFul+d3p84JJlOgzZQar6fOQqG8Qibwy5TwOeiRi3r4Mzrf/Aam
         nPTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690359001; x=1690963801;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CBWhUMSjOCubXY+PC9p9DMz2fuhl5l7G2DCnpXKXi44=;
        b=bfVoGm7k8Cpk1pXl1ecNlOjAsPts8ptA9pNKiw6TfHPYoUPh9Q16EDe4m7kJEyzlCo
         rktko8wfJjPQ4BsadNqPOxSEtwCzUB6mWyT3Auo1q8nsCpv8dRwY4PWxCXoJkuu08ZDo
         djdqTOU1SmBzYWJvui+jfO5nza8mGSHZD46iEqHhXx+IUc8s5KWMCUqS71YaUXVMumlL
         a8+zPHgjJa+p5deX62i7A54bnyu2JwIwHW9D4zrr2HmnLoUSrqTFTVaXSpZUPhJSve5N
         I2IfAS0MAi0r0tVlhs61ChsfVwtTLW8Ju+/yPazm5GkbEdukRDEtyW2sl5Fog3+nMBvr
         UfsA==
X-Gm-Message-State: ABy/qLYA39rEC1VVVfMWouznzgAmX0gOTFxI/6fbHxhwMjXRgbe/RxQ1
        lZyAiI89o/6jEVs/E1KIU+Zwag==
X-Google-Smtp-Source: APBJJlHPh1Z40rOPA8hPV6aBOaHB64sfPxEqqnj6neuzGgAVDkJcfp/eL+6OtW5OBvbdU9FuJRRJcQ==
X-Received: by 2002:a05:6830:1e39:b0:6b9:ae94:c664 with SMTP id t25-20020a0568301e3900b006b9ae94c664mr1651229otr.13.1690359001292;
        Wed, 26 Jul 2023 01:10:01 -0700 (PDT)
Received: from GL4FX4PXWL.bytedance.net ([203.208.167.147])
        by smtp.gmail.com with ESMTPSA id gc17-20020a17090b311100b002680b2d2ab6sm756540pjb.19.2023.07.26.01.09.55
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 26 Jul 2023 01:10:00 -0700 (PDT)
From:   Peng Zhang <zhangpeng.00@bytedance.com>
To:     Liam.Howlett@oracle.com, corbet@lwn.net, akpm@linux-foundation.org,
        willy@infradead.org, brauner@kernel.org, surenb@google.com,
        michael.christie@oracle.com, peterz@infradead.org,
        mathieu.desnoyers@efficios.com, npiggin@gmail.com, avagin@gmail.com
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Peng Zhang <zhangpeng.00@bytedance.com>
Subject: [PATCH 02/11] maple_tree: Validate MAPLE_ENODE and ma_nonleaf_data_end()
Date:   Wed, 26 Jul 2023 16:09:07 +0800
Message-Id: <20230726080916.17454-3-zhangpeng.00@bytedance.com>
X-Mailer: git-send-email 2.37.0 (Apple Git-136)
In-Reply-To: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
References: <20230726080916.17454-1-zhangpeng.00@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Updated mt_validate() to validate MAPLE_ENODE and ma_nonleaf_data_end().

Signed-off-by: Peng Zhang <zhangpeng.00@bytedance.com>
---
 lib/maple_tree.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 98e4fdf6f4b9..e0e9a87bdb43 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -7130,6 +7130,11 @@ static void mas_validate_child_slot(struct ma_state *mas)
 			MT_BUG_ON(mas->tree, 1);
 		}
 
+		if (!slot_is_mte((unsigned long)child)) {
+			pr_err("Slot is not mte %p[%u]\n", mas_mn(mas), i);
+			MT_BUG_ON(mas->tree, 1);
+		}
+
 		if (mte_parent_slot(child) != i) {
 			pr_err("Slot error at %p[%u]: child %p has pslot %u\n",
 			       mas_mn(mas), i, mte_to_node(child),
@@ -7200,6 +7205,13 @@ static void mas_validate_limits(struct ma_state *mas)
 		MT_BUG_ON(mas->tree, 1);
 	}
 
+	if (!mte_is_leaf(mas->node) &&
+	    mas_data_end(mas) != mte_nonleaf_data_end(mas->tree, mas->node)) {
+		pr_err("node:%p mas_data_end() != mte_nonleaf_data_end()\n",
+		       mas_mn(mas));
+		MT_BUG_ON(mas->tree, 1);
+	}
+
 	for (i += 1; i < mt_slots[type]; i++) {
 		void *entry = mas_slot(mas, slots, i);
 
-- 
2.20.1

