Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92AB078B777
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 20:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233158AbjH1Sob (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 14:44:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjH1SoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 14:44:11 -0400
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC453B0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:09 -0700 (PDT)
Received: by mail-oi1-x236.google.com with SMTP id 5614622812f47-3a85c5854deso2729443b6e.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 11:44:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693248248; x=1693853048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FplpJ0L1Cq8kvgNUXqiEcC7mn8MGISXoZpv2LNEhVNE=;
        b=h6EDvUKvuWejmDg99fRjBjUEH/qunGXcHME78wbCR1Gd+mkDGTdoSY+d2N+sR6qjF+
         wYO5rDkOPGj7TgB/Q4slKLQeEiqhfzq8qVjXvy5RIHd/Rq4POP1Xr3fZvf7ZznTtN8ev
         wxy3hfsZesm9Fxf05AuBSdqobFG1q1bN7AF4eGkb5oVf2U6h1hkRhLh48EBEse+Vs5Yu
         BneIpKJCGjXfDBXEDUafhBuid5ZoD7BF+hV70g+OM/EjeP/HVhOtV6vr75PvHCYquZE4
         NckgRs01jycoNN+j7Umz6lxHqxSBeuxTTs8d4OgzdBNP7a2Bq//PzU00pxs8ffqcKvBY
         zFQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693248248; x=1693853048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FplpJ0L1Cq8kvgNUXqiEcC7mn8MGISXoZpv2LNEhVNE=;
        b=eDsadepfSU1+SoT+d+YZFw1XCzhLOBgyh5gZCb8VrV6BtTtPOUn1ot2pQUQZk9WCb/
         kSix3JOhD9dwD4OgH08Aqnc4eVzKrm+E8ICRfYRQA6w+GaIvuzknqztly8hMApu8WlAX
         IeE1WXWVwiqGztlV7eC26luyAO8Df4JOoJ13bp7NkA4H6i2ApIsKh112gzdH/1kg3Kkh
         hqbW2n9etGf/kOqUpoy3R93lvfINorenTY+NMdI3oVs/TnFvtm8SoAaPLuNpaYmOOvZ1
         X/AbFhPImchJcQ/B+U+Wd0JoJxDJov3TgsytBVIwJ3S5j1tva0AX8IH9td5QpqBMSbyY
         bkgQ==
X-Gm-Message-State: AOJu0YzcEvEz5agQAtxnS8kpO2rnbDRtsL6fW8f1RzW3/sZ2NMrPgf7P
        Pm+WCGhFirbzt6AiKIwKB2RL+sWqPQY=
X-Google-Smtp-Source: AGHT+IEc12Sb51t2ikk7rn8SmMMeW5zZ1FvoL1/UoKx8dCxm2HMcoYk3C3K/NxcfEZFA913lskPYsw==
X-Received: by 2002:a05:6808:d46:b0:3a8:8ea9:62de with SMTP id w6-20020a0568080d4600b003a88ea962demr12349285oik.39.1693248248606;
        Mon, 28 Aug 2023 11:44:08 -0700 (PDT)
Received: from localhost ([2600:6c5e:2a00:5805:e348:56d4:5da8:636d])
        by smtp.gmail.com with ESMTPSA id n29-20020a0568080a1d00b003a782e88fd9sm3648806oij.58.2023.08.28.11.44.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Aug 2023 11:44:08 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 08/12] bitmap: optiimze bitmap_bitremap()
Date:   Mon, 28 Aug 2023 11:43:48 -0700
Message-Id: <20230828184353.5145-9-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230828184353.5145-1-yury.norov@gmail.com>
References: <20230828184353.5145-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When 'new' map is empty, we can skip remapping entirely and return
the old bit.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/bitmap.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/lib/bitmap.c b/lib/bitmap.c
index 9ecdc74cb6b4..2e8deeb8bf99 100644
--- a/lib/bitmap.c
+++ b/lib/bitmap.c
@@ -1017,12 +1017,17 @@ EXPORT_SYMBOL(__bitmap_remap);
 int __bitmap_bitremap(int oldbit, const unsigned long *old,
 				const unsigned long *new, int bits)
 {
-	int w = bitmap_weight(new, bits);
-	int n = bitmap_pos_to_ord(old, oldbit, bits);
-	if (n < 0 || w == 0)
+	int w, n;
+
+	w = bitmap_weight(new, bits);
+	if (w == 0)
+		return oldbit;
+
+	n = bitmap_pos_to_ord(old, oldbit, bits);
+	if (n < 0)
 		return oldbit;
-	else
-		return find_nth_bit(new, bits, n % w);
+
+	return find_nth_bit(new, bits, n % w);
 }
 EXPORT_SYMBOL(__bitmap_bitremap);
 
-- 
2.39.2

