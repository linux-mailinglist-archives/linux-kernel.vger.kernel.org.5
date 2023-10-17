Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29E967CB7E8
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 03:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbjJQBSo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Oct 2023 21:18:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232096AbjJQBSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Oct 2023 21:18:42 -0400
Received: from mail-ot1-x331.google.com (mail-ot1-x331.google.com [IPv6:2607:f8b0:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9717CA2
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:18:41 -0700 (PDT)
Received: by mail-ot1-x331.google.com with SMTP id 46e09a7af769-6c4c594c0eeso3509723a34.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Oct 2023 18:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697505521; x=1698110321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8E2y54OTGlC4SszPQLmvr7ApnpGiyusAG53urqiJELY=;
        b=kMBcuqKynKKuLmAtvC1tF38zG1aD+steiWji/p7L5tduX+na25iP+vv2I9L9RArLhd
         bAfiGGI78B4Gmv0onPqU/Ho6g5BR0aJTNVdKYYuoNAepxBMmzExz9zp1d5tPLRLuG10P
         6iGyvpFcz1zMJM9oSGaRBgW+gA4IPXmhXlLv6Nv7LIEKBrDXRV8oI0mvIZ92rd8LjwuS
         mLR/DLJMcFjoHOXhLHGaHopJ3E6K8xA1H4+k+tH6QTHNmEzt7xyIKPuUHw4lhAIwth3A
         ULt50qi7b6Aq4VOXrVJ7HTinQx2h/A8aRnOr+q78lfK1fZt1ekqcYgH8rs2x9D5OxIiQ
         /vzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697505521; x=1698110321;
        h=content-transfer-encoding:mime-version:reply-to:message-id:date
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8E2y54OTGlC4SszPQLmvr7ApnpGiyusAG53urqiJELY=;
        b=FIOo1rYu/t7cfz9zp+JrTqu+Lsh6+H4Sk7bOkyLzor9aiYi/HUTlygHpljFx7OlVFG
         RqoIah37BzptrfHuHgNa2dXj+TgvzuMEhFZlwQLYEP9VrZniRo/JGfixpAcEy93p/vjI
         r/Y7R9dW+bxUBaJlkxL7WG34p9f0AerH4NhjjwTdMHmJezaZmpqUXL7RNnPWkyYBfeZI
         7n4hKQcugjW7r5Uo7oYAPYKZpzZCjnpSsrvPYBagy+m8SQ6SwukWL1c8ZeJhxbFkgatL
         9Z257dMKgeYvgA/MgQAneCl2mJtU5pLrZV51Tjq62fwMPHyyhb20HS3FW0ew83gv1CWK
         t8xQ==
X-Gm-Message-State: AOJu0Yz0qHAfkGHfhjOTpY2h5OT/Kjn5QoFHmlOycm+Cjta9YSz3tes7
        hlhF13/JzVXss7DgDjszEAv5ibJcQmLBk69O
X-Google-Smtp-Source: AGHT+IH6NELBiIY7B0GJ4SFGNnXeKXcRCm9FRmr4KcEHGyr1Vn29uHDiZ6a7F8PJs3exhbdJrhL7zA==
X-Received: by 2002:a05:6830:1e72:b0:6c4:e81f:59b8 with SMTP id m18-20020a0568301e7200b006c4e81f59b8mr851723otr.22.1697505520861;
        Mon, 16 Oct 2023 18:18:40 -0700 (PDT)
Received: from KASONG-MB2.tencent.com ([103.7.29.31])
        by smtp.gmail.com with ESMTPSA id y15-20020aa79aef000000b006926506de1csm191839pfp.28.2023.10.16.18.18.38
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 16 Oct 2023 18:18:40 -0700 (PDT)
From:   Kairui Song <ryncsn@gmail.com>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Huang, Ying" <ying.huang@intel.com>, linux-kernel@vger.kernel.org,
        Kairui Song <kasong@tencent.com>
Subject: [PATCH] mm/swap: avoid a xa load for swapout path
Date:   Tue, 17 Oct 2023 09:17:28 +0800
Message-ID: <20231017011728.37508-1-ryncsn@gmail.com>
X-Mailer: git-send-email 2.42.0
Reply-To: Kairui Song <kasong@tencent.com>
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

From: Kairui Song <kasong@tencent.com>

A variable is never used for swapout path (shadowp is NULL) and compiler
is unable to optimize out the unneeded load since it's a function call.

Signed-off-by: Kairui Song <kasong@tencent.com>
---
 mm/swap_state.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/mm/swap_state.c b/mm/swap_state.c
index b3b14bd0dd64..ab79ffb71736 100644
--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -109,9 +109,9 @@ int add_to_swap_cache(struct folio *folio, swp_entry_t entry,
 			goto unlock;
 		for (i = 0; i < nr; i++) {
 			VM_BUG_ON_FOLIO(xas.xa_index != idx + i, folio);
-			old = xas_load(&xas);
-			if (xa_is_value(old)) {
-				if (shadowp)
+			if (shadowp) {
+				old = xas_load(&xas);
+				if (xa_is_value(old))
 					*shadowp = old;
 			}
 			xas_store(&xas, folio);
-- 
2.42.0

