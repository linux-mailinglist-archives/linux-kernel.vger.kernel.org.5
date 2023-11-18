Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B42277F00BE
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Nov 2023 16:54:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233058AbjKRPym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Nov 2023 10:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbjKRPxf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Nov 2023 10:53:35 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27F821FF3;
        Sat, 18 Nov 2023 07:51:54 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-da3b4b7c6bdso2917083276.2;
        Sat, 18 Nov 2023 07:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700322712; x=1700927512; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FRJAi9fqLnpZBQBfWveY0fRnarAyBBO44GyImL+GpQw=;
        b=IT8+IBr/GjwsHiuzp7JbGVGoUMD6y1ZMGmXhJaeFaN9TrOcyttSLuKo4qdu1SmXbcG
         VgMptIT0UAnXXPkr+htmJdWc8gttbfZJkgEawCYNoL3m1PmHFpTdb/1VYtDUa07e+tWc
         YjIfSHyIXopdgUYFRwTlxcaaOtQKI762QKvW8zdhLUU+jOHItUV2D9HlB/xKYgi2d27J
         Tx+DKwf0B/ilLwI6vSXqzgjVkD61+aQRmW9T+9xlfrfdXzy9qxHVkFY/cat075drS2di
         /foAu1lF96mWe7J41kM2yRloUptbCXY6fjPpShM53bkrQJ+krv3IFOWamSUUxClDXG39
         4i5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700322712; x=1700927512;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FRJAi9fqLnpZBQBfWveY0fRnarAyBBO44GyImL+GpQw=;
        b=mDBnc/xl3/t16XUHfApkuAktgGMjkyxeKEp9vBN0+hxNFXHTqEHzokNr9YK+VsAsKF
         FTOEo88in//BEuOU0B3wE8a0L9+6hYJj6TTNznIDk6yy2RaI95MssBIIKBq3Pd0NqI2z
         wDmH0xpka0HJQ8tgr3kdtTHoi8X0k4U4itbl1aEUWeTU4MKfRPQx3L6BrlEsMVUilQOE
         aw9m9jzk/Ciy6b3vDILc+FOIFiXzC2zN4SUIe+v+grOfQSWlrcugQQI22Xikx7qyYfVd
         L+leu3AqRb6r2KsJ0iU0Hv0PYJOwZQ/KjYo7Cnn9/kSZ+yzld/NPLvH/drU8h4DrTGA+
         KPSQ==
X-Gm-Message-State: AOJu0Yy+Fkdbs3cozq22sc2AkHohJpbMBiASZs2x7WLhVxu9P0cdIjUm
        8J08UJJ4YcruDo/4vry5oWqTLuzICP1NQ/lp
X-Google-Smtp-Source: AGHT+IElJ0U3CjFZG+s3NnFjnzuVmrFeyc2e4WM5oO3xxPOV5mRPbrBHmRloD2DElouQFvaTAENskA==
X-Received: by 2002:a05:6902:212:b0:d9a:d7a5:e445 with SMTP id j18-20020a056902021200b00d9ad7a5e445mr2342423ybs.49.1700322711961;
        Sat, 18 Nov 2023 07:51:51 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:48a9:bd4c:868d:dc97])
        by smtp.gmail.com with ESMTPSA id e62-20020a25a3c4000000b00da10d9e96cesm1006690ybi.35.2023.11.18.07.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Nov 2023 07:51:51 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Karsten Graul <kgraul@linux.ibm.com>,
        Wenjia Zhang <wenjia@linux.ibm.com>,
        Jan Karcher <jaka@linux.ibm.com>,
        "D. Wythe" <alibuda@linux.alibaba.com>,
        Tony Lu <tonylu@linux.alibaba.com>,
        Wen Gu <guwen@linux.alibaba.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>
Subject: [PATCH 29/34] net: smc: fix opencoded find_and_set_bit() in smc_wr_tx_get_free_slot_index()
Date:   Sat, 18 Nov 2023 07:51:00 -0800
Message-Id: <20231118155105.25678-30-yury.norov@gmail.com>
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

The function opencodes find_and_set_bit() with a for_each() loop. Fix
it, and make the whole function a simple almost one-liner.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 net/smc/smc_wr.c | 10 +++-------
 1 file changed, 3 insertions(+), 7 deletions(-)

diff --git a/net/smc/smc_wr.c b/net/smc/smc_wr.c
index 0021065a600a..b6f0cfc52788 100644
--- a/net/smc/smc_wr.c
+++ b/net/smc/smc_wr.c
@@ -170,15 +170,11 @@ void smc_wr_tx_cq_handler(struct ib_cq *ib_cq, void *cq_context)
 
 static inline int smc_wr_tx_get_free_slot_index(struct smc_link *link, u32 *idx)
 {
-	*idx = link->wr_tx_cnt;
 	if (!smc_link_sendable(link))
 		return -ENOLINK;
-	for_each_clear_bit(*idx, link->wr_tx_mask, link->wr_tx_cnt) {
-		if (!test_and_set_bit(*idx, link->wr_tx_mask))
-			return 0;
-	}
-	*idx = link->wr_tx_cnt;
-	return -EBUSY;
+
+	*idx = find_and_set_bit(link->wr_tx_mask, link->wr_tx_cnt);
+	return *idx < link->wr_tx_cnt ? 0 : -EBUSY;
 }
 
 /**
-- 
2.39.2

