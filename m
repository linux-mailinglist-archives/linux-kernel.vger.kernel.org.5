Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D73E79B91A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378726AbjIKWgu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:36:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235345AbjIKI1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 04:27:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246E4FB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:27:31 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1bd9b4f8e0eso26484305ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 01:27:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694420850; x=1695025650; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ex0ifdiIlLUyDJYX4AiACl56tngQcIliDLvNik7wRDk=;
        b=FPAubZ5eAW5wdlDAkRhDcSoo+RXKetG0dDgg3LLpFTdXvRnwPgTaV6ZIHtLedA2Qy7
         aEzaapv8VTp0UgWeCQAdkReAD5NFeXvIZBazi61pq5sAUEGby7rO2RrZL0UNMUFu/goR
         avvzFiCtPukJ31enEGllewMdhRibA918++a81gUqwGk5ViioEnhiUlT8K5UCHc9SvKVR
         EwTx4hm83r0ShK2ujtu9ZZ4wadGYYYPjZyPaZQM4t3c4Jb4AkGvoqAlzqI+co/3jwEMi
         toqqlOt5f2H2zo0VdkV3lzBd3/kWCFa0cHa1z7dtMg2r2wvw1XcojFvx0mEkI+CWR0NF
         zFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694420850; x=1695025650;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ex0ifdiIlLUyDJYX4AiACl56tngQcIliDLvNik7wRDk=;
        b=UD0d4C1g9O3Ujnho0ReX0Fbr74rTnaLw+gxJN1+4dKo7oEhTG9/FSwQNSpsjhgiXRv
         HMXANQ25luJxPJGYF9KQ458SkR6ihNT12k58ZhlrTGY6lEgcHwKFo7+DRwCn4OV1hZBd
         rX9wV54ZJM/YKSB5MhuBP4ONYLxkVkgNCodbEmmpCvcCM7GMQ+tBJlHMN9NFqCpug4Il
         cJHcoAMlKofUoQ1OO//HnTuEhxc/jOq0AOWHR1wVvp/3FvyvfKmwb6pIWdLURTaQ3zxJ
         A7LeoRrTR0ybeWR+/ZV7nMDsOHUpcQoqh/GbBGo8my17QwLqGDKgJlVxOeBik4yb14Fj
         RXHQ==
X-Gm-Message-State: AOJu0YzPhpYtKUUgnc243XF/j//XaPB3GM9PO6ynSNrBum5qFJjGbZXQ
        VjiLwS7g2K1x78l4lU0wT6g=
X-Google-Smtp-Source: AGHT+IERuUMCD7CesULLvcI9MmGqQ5ToI2zNW+u3g1Ukr05GViXTn91EtVpdS2CxSojPAxdXI5iVGw==
X-Received: by 2002:a17:903:54d:b0:1b8:28f6:20e6 with SMTP id jo13-20020a170903054d00b001b828f620e6mr6045668plb.34.1694420850513;
        Mon, 11 Sep 2023 01:27:30 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id 21-20020a170902c25500b001c1ef9d2215sm5786842plg.270.2023.09.11.01.27.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 01:27:30 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     tj@kernel.org, jiangshanlai@gmail.com, qiang.zhang1211@gmail.com
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] workqueue: Fix missed pwq_release_worker creation in wq_cpu_intensive_thresh_init()
Date:   Mon, 11 Sep 2023 16:27:22 +0800
Message-Id: <20230911082722.453-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, if the wq_cpu_intensive_thresh_us is set to specific
value, will cause the wq_cpu_intensive_thresh_init() early exit
and missed creation of pwq_release_worker. this commit therefore
create the pwq_release_worker in advance before checking the
wq_cpu_intensive_thresh_us.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/workqueue.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index c85825e17df8..fd3988583c8b 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -6605,13 +6605,13 @@ static void __init wq_cpu_intensive_thresh_init(void)
 	unsigned long thresh;
 	unsigned long bogo;
 
+	pwq_release_worker = kthread_create_worker(0, "pool_workqueue_release");
+	BUG_ON(IS_ERR(pwq_release_worker));
+
 	/* if the user set it to a specific value, keep it */
 	if (wq_cpu_intensive_thresh_us != ULONG_MAX)
 		return;
 
-	pwq_release_worker = kthread_create_worker(0, "pool_workqueue_release");
-	BUG_ON(IS_ERR(pwq_release_worker));
-
 	/*
 	 * The default of 10ms is derived from the fact that most modern (as of
 	 * 2023) processors can do a lot in 10ms and that it's just below what
-- 
2.17.1

