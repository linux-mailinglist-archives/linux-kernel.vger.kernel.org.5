Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 961F7809E75
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 09:41:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233267AbjLHIlW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 03:41:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbjLHIlT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 03:41:19 -0500
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EDAC10FC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 00:41:26 -0800 (PST)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-77f368b3334so84385485a.2
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 00:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702024885; x=1702629685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JllfCZ5QWb670w+A1HFO6uCIu5jBxIFAgbWt4nHdmO8=;
        b=UjOrt/IwLWf6t0hecklsNpAdxrO8YzGWsCWsLWv8FMpn3HmtQmQfEfQdf9isDdZ1Zf
         vH2cHQXl4GnxlGU4N5+/MsTobn5z9T5RDgfHQOIVTxrqDhe6ivvHyHOToM2JTrgKF5fM
         6sIiNvBq1bisqOLuyTEsgNX5FPTSyibFcnlrEb2DuPa9rwVvZOGeT7NFNwQiVnWv7UD1
         //pJavbA7MAbtcfzwRrpHAdn/LPRTMWyhMjXp5GCDsaZJv4YPGdC4bGEvBsd4HcTdN+m
         PDGKPSP1twJCsYYWQATyv9b0pXH2jS8cKRet9ufSnZxhg0uLyAjlfpNn/JYHAP5eehZ0
         7UcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702024885; x=1702629685;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JllfCZ5QWb670w+A1HFO6uCIu5jBxIFAgbWt4nHdmO8=;
        b=sUx0sZoRU1Lf+g2qewQAuG/arAvLd4uQTU6Z7FDllTHD+enuTONjb80YKJTl23rvCF
         +Kzg87LzY9chTi4nDS4BdPh3hIWY1qH+8nvD44eSRLewuutD4/wnKoXI6cOl2W3uLTRn
         QLdFaU6bKcrPo09XlXTGdKIld5eYwtF84YioAkFe3AgoHNEkRab0FomHKscFswQejRx1
         t0cj/3Csj4jFZ13THJb9tE9v4TRT+y1H21A18lIpLBTgtuWwW+M9uA0D8RR6hDkYaPcF
         y7TXcNl346glqWZtenhmqpRsm3cM1fYreMKnSqycpyTa1wHHgJrfR3s2JlC8sF4XQZr/
         6Hyg==
X-Gm-Message-State: AOJu0YynVd+P6xZnhL/LSoMlCRdVMbEIODW/3BF2rlKtofkAd4ZFiBQT
        OM4NY9mk9X8tCx8efiN9J/0=
X-Google-Smtp-Source: AGHT+IH1zPeyAxQmIiGO5daKAoxiCfEtMbXJAk86rPGMKT/S/6V8ZKZL7iAmmi1tbl8+b32GQGfvKA==
X-Received: by 2002:a05:620a:8016:b0:77f:2f6a:361c with SMTP id ee22-20020a05620a801600b0077f2f6a361cmr2777331qkb.40.1702024885228;
        Fri, 08 Dec 2023 00:41:25 -0800 (PST)
Received: from pek-lpggp6.wrs.com (unknown-105-121.windriver.com. [147.11.105.121])
        by smtp.gmail.com with ESMTPSA id rq11-20020a05620a674b00b0077f1645282csm546013qkn.22.2023.12.08.00.41.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 00:41:24 -0800 (PST)
From:   Kevin Hao <haokexin@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] fork: Remove redundant TASK_UNINTERRUPTIBLE
Date:   Fri,  8 Dec 2023 16:41:15 +0800
Message-Id: <20231208084115.1973285-1-haokexin@gmail.com>
X-Mailer: git-send-email 2.39.2
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

TASK_KILLABLE already includes TASK_UNINTERRUPTIBLE, so there is no
need to add a separate TASK_UNINTERRUPTIBLE.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
 kernel/fork.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/fork.c b/kernel/fork.c
index c78e65757eb5..3ea454e1b0b0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1580,7 +1580,7 @@ static void complete_vfork_done(struct task_struct *tsk)
 static int wait_for_vfork_done(struct task_struct *child,
 				struct completion *vfork)
 {
-	unsigned int state = TASK_UNINTERRUPTIBLE|TASK_KILLABLE|TASK_FREEZABLE;
+	unsigned int state = TASK_KILLABLE|TASK_FREEZABLE;
 	int killed;
 
 	cgroup_enter_frozen();
-- 
2.39.2

