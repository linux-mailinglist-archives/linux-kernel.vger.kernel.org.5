Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B40A7F009B
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:52:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230502AbjKRPwn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:52:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230477AbjKRPw0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:52:26 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 113DC1705;
        Sat, 18 Nov 2023 07:51:27 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-d9a6399cf78so2391158276.0;
        Sat, 18 Nov 2023 07:51:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322685; x=1700927485; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SrDABjtie/YsTla3oR4TwoLfOAKA91LiKhvoQvuKuZ0=;
        b=kjjbNi9ampdDnKd3zsNfGlvyotuVRpTMFasdFcBZSuASyM7r0SZeuKIg9iXIWqr8FF
         kjOdeEnby6zw0bWAlnZeK+skpxFk85DrayPy1N70H/xesbLTMqO/cn0HhhSTtDimrejm
         H/JeiPxktiKXqn6UlFFbLVSHdaHRR6dXUihHu4dxoBs4R9vmxmuGsttGGeK1+C7cSA22
         pRsbuKiu/ODwIABAgL8cdZ3lG6FNG/xGU2YkhYSzPWMuEMEtGj+sifZQLuxtu7ZoGfqa
         B2HBINkWNoP0tPrucZmrIqDwEy8VVsCYaSc2RxtZHecJ89/q0L+b1jqP9CNsURLKrleq
         aDMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322685; x=1700927485;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SrDABjtie/YsTla3oR4TwoLfOAKA91LiKhvoQvuKuZ0=;
        b=M/9I8S0aHZDkNfUL/rmE3xhIxYSoDkIjbp3AX4ebud0xx2rYzDPD2E4QRcoCa6uR48
         v7xzuS0yrngL5b/U1vDgtnaV4Avz/xXB8C/8VvTjzhhluiLrpeHIyh8NgD7pP2o4hzIR
         plVkIeSlyhiGL2b0VGO+UVrjjjp59oW4c4MVP9V6VWaJrAgJY0s3XK7xrB37PsCkeEun
         X5nUtLYbARaDVb1DNKalCZj2Pw9RxoMQpEdJW9fopEAWB7pjII78830l6QXK/aNe7M1z
         jaodA1eHQDOwSpbUpSRe4hDy0HLdT6SgpprQCH7omBhBWW7EGxY5pi8/q49AhTgmubwp
         k7/A==
X-Gm-Message-State: AOJu0Yzu6LjgcBVP+RUuzpN6J3C1+4CQcrSwvI2bmfUl0r3mtDpjXP42
        5blB62JtLVKnJpTf+1RpGAUM6FgobsTPdmMR
X-Google-Smtp-Source: AGHT+IFTfzteXdMOCngH4g6ThBL8jMLQtAxdwFQMPhz1ymRIf3wQ4UJX7I6T1IJmIedN4upY2EbAuQ==
X-Received: by 2002:a25:ad4f:0:b0:daf:7702:fd60 with SMTP id l15-20020a25ad4f000000b00daf7702fd60mr1666269ybe.1.1700322684938;
        Sat, 18 Nov 2023 07:51:24 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id e14-20020a25d30e000000b00d9cd730e4d0sm1000457ybf.26.2023.11.18.07.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:24 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Kalle Valo <kvalo@kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>,
        ath10k@lists.infradead.org, linux-wireless@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 10/34] ath10k: optimize ath10k_snoc_napi_poll() by using find_bit()
Date:   Sat, 18 Nov 2023 07:50:41 -0800
Message-Id: <20231118155105.25678-11-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231118155105.25678-1-yury.norov@gmail.com>
References: <20231118155105.25678-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ath10k_snoc_napi_poll() traverses pending_ce_irqs bitmap bit by bit.
We can do it faster by using for_each_test_and_clear_bit() iterator.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/net/wireless/ath/ath10k/snoc.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/ath/ath10k/snoc.c b/drivers/net/wireless/ath/ath10k/snoc.c
index 2c39bad7ebfb..a1db5a973780 100644
--- a/drivers/net/wireless/ath/ath10k/snoc.c
+++ b/drivers/net/wireless/ath/ath10k/snoc.c
@@ -1237,11 +1237,10 @@ static int ath10k_snoc_napi_poll(struct napi_struct *ctx, int budget)
 		return done;
 	}
 
-	for (ce_id = 0; ce_id < CE_COUNT; ce_id++)
-		if (test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs)) {
-			ath10k_ce_per_engine_service(ar, ce_id);
-			ath10k_ce_enable_interrupt(ar, ce_id);
-		}
+	for_each_test_and_clear_bit(ce_id, ar_snoc->pending_ce_irqs, CE_COUNT) {
+		ath10k_ce_per_engine_service(ar, ce_id);
+		ath10k_ce_enable_interrupt(ar, ce_id);
+	}
 
 	done = ath10k_htt_txrx_compl_task(ar, budget);
 
-- 
2.39.2

