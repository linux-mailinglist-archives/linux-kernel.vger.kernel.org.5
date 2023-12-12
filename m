Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 788F180E1B6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 03:29:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345831AbjLLC3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 21:29:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345788AbjLLC2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 21:28:45 -0500
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9629112A;
        Mon, 11 Dec 2023 18:28:30 -0800 (PST)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5e196c128fcso7854147b3.1;
        Mon, 11 Dec 2023 18:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702348109; x=1702952909; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2naZtSkEf1NcPMGJshyYFtrlJjtShUpPX2HAHwMhtPE=;
        b=Ci6rj3LeDWNP6MoXDX8OdHwssAKHiA07o9+ThUiV9mRJ2ptrlnOOvizX9gFhIu5cM0
         BogueEGjBDU4xlPVfPPKRbK5h0cvkhDRK8IWomtbF5rowcNrfsS+53wBecVaOEGwzwmX
         kGMOejEn2+CZXJqClQarnt9x/5TVta8PhiSgaHJGwOgAL6vLbbR3Rwjyps3rgFlQrGCu
         mBGOJEt6tNHfq9ZTT2CLkk73UwEPSa+JZq/KeVKuom0sIHaI63W5QRgsyeZB7mlzS1Wc
         bc4+a3gOzURBNi0r0qZb2qNbeDvLo+cnAajXF9ea0LOOyKEA7G4raEBBKvkDYxHIeq12
         mfcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702348109; x=1702952909;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2naZtSkEf1NcPMGJshyYFtrlJjtShUpPX2HAHwMhtPE=;
        b=Ev5hvb5GpU8kqSMlxq35m5Fz1ACYLooq5a+f89dvp8yob7iProO9NHqfWK7yMuBT/u
         s6NWw3JxHV4+LbZY6oik2TCaw9z4JcXKtoWTSTBj7Zez+rALE1+Y8UM+tWqLi9H9bXrJ
         VD5hFxRSqF8HBjje2Ql9IYO6CuFKvVj8AtRyaz4dcSZOs7fhn4DUtaBjHxSr33R3k1i6
         nU5UHMFbyTGa4AOaEkn/GLFESPsHpxTy8sVOMOgGB15cZ6XSCgBjVhzw8Gj5WUOfHeL2
         otdXLkMu/hDpwrEye3UcQ6X6HG1w4/TFIwLPT9v+Rerme4v/3BI/Lfh1LOCncpZTUViI
         6Xrg==
X-Gm-Message-State: AOJu0Yxj2QX7SBeEPaEMFrzdtGTlpnU0Lkq4n+vqISyeIsxjD/6V+GCq
        siyEaZ3vcbq+ELYqgDDg9lpRS//J0EThpg==
X-Google-Smtp-Source: AGHT+IHxxYi9tsUL3fhwiqrbBOybum3KQvBSBOcOUXQ+8eJIB4u5yqmLd2thUDPc/A7M1pqGLGdE4w==
X-Received: by 2002:a81:8395:0:b0:5ca:4db5:6962 with SMTP id t143-20020a818395000000b005ca4db56962mr4232765ywf.46.1702348109282;
        Mon, 11 Dec 2023 18:28:29 -0800 (PST)
Received: from localhost ([2601:344:8301:57f0:38aa:1c88:df05:9b73])
        by smtp.gmail.com with ESMTPSA id u13-20020a81a50d000000b005cc8b377fe9sm3395826ywg.121.2023.12.11.18.28.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 18:28:28 -0800 (PST)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        Ming Lei <ming.lei@redhat.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        Nitesh Shetty <nj.shetty@samsung.com>,
        Akinobu Mita <akinobu.mita@gmail.com>,
        Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
        Yury Norov <yury.norov@gmail.com>, linux-block@vger.kernel.org
Cc:     Jan Kara <jack@suse.cz>,
        Mirsad Todorovac <mirsad.todorovac@alu.unizg.hr>,
        Matthew Wilcox <willy@infradead.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Maxim Kuvyrkov <maxim.kuvyrkov@linaro.org>,
        Alexey Klimov <klimov.linux@gmail.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Sergey Shtylyov <s.shtylyov@omp.ru>
Subject: [PATCH v3 24/35] block: null_blk: replace get_tag() with a generic find_and_set_bit_lock()
Date:   Mon, 11 Dec 2023 18:27:38 -0800
Message-Id: <20231212022749.625238-25-yury.norov@gmail.com>
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

get_tag() opencodes find_and_set_bit(). Simplify the code by getting
rid of it.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
Reviewed-by: Chengming Zhou <zhouchengming@bytedance.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/null_blk/main.c | 41 +++++++++++------------------------
 1 file changed, 13 insertions(+), 28 deletions(-)

diff --git a/drivers/block/null_blk/main.c b/drivers/block/null_blk/main.c
index 3021d58ca51c..671dbb9ab928 100644
--- a/drivers/block/null_blk/main.c
+++ b/drivers/block/null_blk/main.c
@@ -760,19 +760,6 @@ static void put_tag(struct nullb_queue *nq, unsigned int tag)
 		wake_up(&nq->wait);
 }
 
-static unsigned int get_tag(struct nullb_queue *nq)
-{
-	unsigned int tag;
-
-	do {
-		tag = find_first_zero_bit(nq->tag_map, nq->queue_depth);
-		if (tag >= nq->queue_depth)
-			return -1U;
-	} while (test_and_set_bit_lock(tag, nq->tag_map));
-
-	return tag;
-}
-
 static void free_cmd(struct nullb_cmd *cmd)
 {
 	put_tag(cmd->nq, cmd->tag);
@@ -782,24 +769,22 @@ static enum hrtimer_restart null_cmd_timer_expired(struct hrtimer *timer);
 
 static struct nullb_cmd *__alloc_cmd(struct nullb_queue *nq)
 {
+	unsigned int tag = find_and_set_bit_lock(nq->tag_map, nq->queue_depth);
 	struct nullb_cmd *cmd;
-	unsigned int tag;
-
-	tag = get_tag(nq);
-	if (tag != -1U) {
-		cmd = &nq->cmds[tag];
-		cmd->tag = tag;
-		cmd->error = BLK_STS_OK;
-		cmd->nq = nq;
-		if (nq->dev->irqmode == NULL_IRQ_TIMER) {
-			hrtimer_init(&cmd->timer, CLOCK_MONOTONIC,
-				     HRTIMER_MODE_REL);
-			cmd->timer.function = null_cmd_timer_expired;
-		}
-		return cmd;
+
+	if (tag >= nq->queue_depth)
+		return NULL;
+
+	cmd = &nq->cmds[tag];
+	cmd->tag = tag;
+	cmd->error = BLK_STS_OK;
+	cmd->nq = nq;
+	if (nq->dev->irqmode == NULL_IRQ_TIMER) {
+		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+		cmd->timer.function = null_cmd_timer_expired;
 	}
 
-	return NULL;
+	return cmd;
 }
 
 static struct nullb_cmd *alloc_cmd(struct nullb_queue *nq, struct bio *bio)
-- 
2.40.1

