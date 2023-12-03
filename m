Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F235B8026F8
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Dec 2023 20:35:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbjLCTfG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 14:35:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234207AbjLCTe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 14:34:29 -0500
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F5552116;
        Sun,  3 Dec 2023 11:34:05 -0800 (PST)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-db8892a5f96so778827276.2;
        Sun, 03 Dec 2023 11:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701632044; x=1702236844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tow+85T+lc+N5QthCRRY7+xksWqAIO8q8vX1kWlFmwA=;
        b=S8FjXbL+Om07tTWypyRabwgvKQMEr/uxqw3jaqPqfXxvRJasTDSmpGGHFPSbFMiH7V
         fQBZphDsUWDU+5IQ+a3DtQZcV/UoXX3rXrwSX8HK7A9Dw3nI3VSzBFWivQnH+IzJ3bCn
         G1CNIAO5gsQ18SvVo34/e1L8lumlzYAS9IlobGLPi2LyRKl21lGv/GrpxiOxNSyNfZVA
         uJ/7ec2UYYzfA63vLqDjcmqw2+j7Rj2ZKH/JiwCjExh+QYnEZTV6Wx6//6qA6tmjxS5K
         A8y10wN1cHbYX4fH+IUMPMylobCEZN9swQ6tnKTf70i0d6tNaIS3y1mAJPFv/X5z5euj
         W25w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701632044; x=1702236844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tow+85T+lc+N5QthCRRY7+xksWqAIO8q8vX1kWlFmwA=;
        b=lpyO5K6jHutrCWknsNUU2o3mO1Qh5WInAUtBlxFo+BQPcPJVKRqGgA6FYvBnaaOcaK
         FJN2FDUzN/TgcUr6U4864xmSV7b+ablM2J1XqNeaRWgpp2HCkkNHxeN7dZPZdqMWUzSz
         MtkTMKdMKRZfvwkt7ESQJj3op7Fw+aRkh62lF1nlvoZyngMfy+GlBni2IYfY3iQJpXzy
         4IYXHM3VWmF6N7a6f81o9UmKPLhLPJPbteswMtsdi5xiqsLelTsXYv569gOe5hlh7DC7
         C22vDXomC9ZwdudOtUkI53Ubw0MbqfL2UDDdhHkM9noo5xdi5WFGFtn3VS0+VuJ33x6W
         B2zQ==
X-Gm-Message-State: AOJu0Yy1Y/q/wyLQb+Mte8EoOI8GQlh9194IAqoww4XDtOYiZioNuayx
        /fzQAr15VTjx50Nr77cDLOrlKBnchBt+9A==
X-Google-Smtp-Source: AGHT+IFdVY+nDvHApuybbKRgPwqo30yRyljr/trWB68rXRo3Ez+hOUZ7Bb+kBQ88sAzhLkZwEbNRpQ==
X-Received: by 2002:a25:457:0:b0:db7:dacf:6205 with SMTP id 84-20020a250457000000b00db7dacf6205mr1739115ybe.87.1701632044112;
        Sun, 03 Dec 2023 11:34:04 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:cb98:c3e:57c:8191])
        by smtp.gmail.com with ESMTPSA id bt13-20020a056902136d00b00d72176bdc5csm1759016ybb.40.2023.12.03.11.34.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 11:34:03 -0800 (PST)
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
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Alexandra Winter <wintera@linux.ibm.com>
Subject: [PATCH v2 31/35] net: smc: use find_and_set_bit() in smc_wr_tx_get_free_slot_index()
Date:   Sun,  3 Dec 2023 11:33:03 -0800
Message-Id: <20231203193307.542794-30-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231203193307.542794-1-yury.norov@gmail.com>
References: <20231203192422.539300-1-yury.norov@gmail.com>
 <20231203193307.542794-1-yury.norov@gmail.com>
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

The function opencodes find_and_set_bit() with a for_each() loop. Use
it, and make the whole function a simple almost one-liner.

While here, drop explicit initialization of *idx, because it's already
initialized by the caller in case of ENOLINK, or set properly with
->wr_tx_mask, if nothing is found, in case of EBUSY.

CC: Tony Lu <tonylu@linux.alibaba.com>
CC: Alexandra Winter <wintera@linux.ibm.com>
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
2.40.1

