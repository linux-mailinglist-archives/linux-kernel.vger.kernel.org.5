Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28C3880E1B8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345817AbjLLC3P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345792AbjLLC2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:45 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8326A135;
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-5df49931b4eso28081517b3.0;
        Mon, 11 Dec 2023 18:28:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348110; x=1702952910; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xXHhxsG3/UhGgqamsfrlyZxDKNFN6ooaZwOKCcSTfsQ=;
        b=jp2Nz9P49zWcrnTotdEWzMcMYlaNUW3Iqrj1F4Lr1niQgy2JKLY9kFqZzAultqMUBr
         ZHokKXNSda1Q3xriJREOyA+qW3LPfwA2OE5TZoxSvnaoeuE8aR6wqXpqAQI6RxmkTvAF
         pYqiaCGXQ29IIBsZ8uxxkFeR0pvbrN4YxbS7sHUvnIWuk6w6Rq3cqijp9lBLvJsBVLiZ
         aa5qTtj+pIPkA0w0c6OmhTaqanANwIlM3O2gH2xh/GpEyxBSsvTZAjfu0B+4jQbaiwc+
         t4WwcLk3ZKsIHV4pZnlQLuvb63G1o2ULmxkIizGDNA0zTJ1hH3TowJs4XewqcPHKNjFp
         ChzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348110; x=1702952910;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xXHhxsG3/UhGgqamsfrlyZxDKNFN6ooaZwOKCcSTfsQ=;
        b=xIfUdLzkmGrnaYCvmOS/23hjKA4tqcA1DJ2OTdrgTRs+LrL2Jxr7pISgJAbaHulsHt
         kn7gsSXKlwwNAb94Fpk6SznMIQbctlMYsVrXOpBpNhjuzZO9PNr3s9qpbiY1yvmfVXwW
         /F2KT0JV5PI5fQMLVXcF95MdXO4FHn7j67kpgPL8OsrMR7CaNTaQ5G2pZ6Uwn6hui4wZ
         VqAj1E5uMdUUr6yAK3B0V/VSWx4KSYJ8XgSzG1uk4ZP8+0HRmZ/JIjPKgpBD4Z5buzTW
         7AABXKwPN4m1o7FEEuIl/7ldFY3LCScptH5Ahk3YLIYljwGlYzgGUFsA916hYmNue8ib
         siTw==
X-Gm-Message-State: AOJu0YxE4uyH4ODJqaMG/IgDQCjH4fagOZpxS02HeEoDJ0qja259LjR2
        uQcUpJq27oz9vPuMViMOO+x16KfAgb+hrA==
X-Google-Smtp-Source: AGHT+IEhd3bdmNrEQft62JVx4q4yoIhcniOB2WhrpWCIonS9sKp3c3BAImI4DTarVU93O6a3waqqkQ==
X-Received: by 2002:a05:690c:4505:b0:5e1:9f39:b084 with SMTP id gt5-20020a05690c450500b005e19f39b084mr762715ywb.2.1702348110591;
        Mon, 11 Dec 2023 18:28:30 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id j72-20020a81924b000000b005d716572128sm3471268ywg.17.2023.12.11.18.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:30 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
        Jack Wang <jinpu.wang@ionos.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Leon Romanovsky <leon@kernel.org>, linux-rdma@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>, Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 25/35] RDMA/rtrs: optimize __rtrs_get_permit() by using find_and_set_bit_lock()
Date:   Mon, 11 Dec 2023 18:27:39 -0800
Message-Id: <20231212022749.625238-26-yury.norov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231212022749.625238-1-yury.norov@gmail.com>
References: <20231212022749.625238-1-yury.norov@gmail.com>
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

The function opencodes find_and_set_bit_lock() with a while-loop polling
on test_and_set_bit_lock(). Use the dedicated function instead.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 drivers/infiniband/ulp/rtrs/rtrs-clt.c | 15 +++------------
 1 file changed, 3 insertions(+), 12 deletions(-)

diff --git a/drivers/infiniband/ulp/rtrs/rtrs-clt.c b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
index 7f3167ce2972..9f1c612df392 100644
--- a/drivers/infiniband/ulp/rtrs/rtrs-clt.c
+++ b/drivers/infiniband/ulp/rtrs/rtrs-clt.c
@@ -72,18 +72,9 @@ __rtrs_get_permit(struct rtrs_clt_sess *clt, enum rtrs_clt_con_type con_type)
 	struct rtrs_permit *permit;
 	int bit;
 
-	/*
-	 * Adapted from null_blk get_tag(). Callers from different cpus may
-	 * grab the same bit, since find_first_zero_bit is not atomic.
-	 * But then the test_and_set_bit_lock will fail for all the
-	 * callers but one, so that they will loop again.
-	 * This way an explicit spinlock is not required.
-	 */
-	do {
-		bit = find_first_zero_bit(clt->permits_map, max_depth);
-		if (bit >= max_depth)
-			return NULL;
-	} while (test_and_set_bit_lock(bit, clt->permits_map));
+	bit = find_and_set_bit_lock(clt->permits_map, max_depth);
+	if (bit >= max_depth)
+		return NULL;
 
 	permit = get_permit(clt, bit);
 	WARN_ON(permit->mem_id != bit);
-- 
2.40.1

