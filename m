Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 142F6786A5A
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 10:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbjHXImg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 04:42:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235444AbjHXImR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 04:42:17 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1601727;
        Thu, 24 Aug 2023 01:42:16 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so4902865ad.0;
        Thu, 24 Aug 2023 01:42:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692866535; x=1693471335;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MZW4K+Cn+SXlhogHR/A6HeXM5kEvI/OHjyj47UoaxmE=;
        b=sgtCVZIWEtnaOo4eOhwY11PpHNqik88C9UasICytmNlR3WEJV/KaqMV8EgVAUCZd6+
         LRrvd6n3ku66aOz/dSd3Sa9OSKr+XvPtnQ+dP4yE9wsE9/+EIVZ1jMojjWwtDL93WsQ8
         inYemJbJKMhADFOPWeNj9Hr5fhOuaKsaa0mAIGdQfhPOCSpHB4p1WjiYM+M5Z8sLtKGV
         pClk5YJHd1aOoZTR3TdhFAfvpY3/LVQudHKG0VIGMSOYjpmxj+BXk6P/Fupna6RurPxM
         ZQpyXXxzMeIRalzwV+acXewlXlhG921CUNa/1SW9Uhok0bkt/05XaPeeOUCdDquBHuQq
         i9qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692866535; x=1693471335;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MZW4K+Cn+SXlhogHR/A6HeXM5kEvI/OHjyj47UoaxmE=;
        b=A78pjbZEdbtjmzPZK0c+HxgGXH66Gx6yin2Fikvqf3J3L0MaymS4nHhHXWgrJlFptC
         mHQlerPlxMSzvADF5V00Q1TlqQg6E2JO2rmCEiKngIoGR4iwr6dmjQBl+D9GZr59rsNF
         YII5Y/sq99cwUxNrsuKRA5w7mmMx9pB1ga9OFnRfZavcMJyZhqeBWPeghn9bq8XoCVlv
         0wd8oTmNs1klInHLEAHZX6qUIgnDy4UE24ZYilamGr+PdUfcOE2Y8kl5uwlzutUprI4U
         dbD1kzEms33TV1/dXqUsOS2Js+7dy9esoxGbxCvbkPzChE2w77XqACO8yyYeb3nq5B8r
         dZ1A==
X-Gm-Message-State: AOJu0YzIiIw0aM5ft5G5BGGiCvedpX4jCp/lM0LIATDyDK8i5mR6KEX/
        tGcXiotwExf30gwLvh/ACgA=
X-Google-Smtp-Source: AGHT+IFRUPVHXpJIwydNFdm20M4RZt6uBv2PNN/uGKndM8AjSd837AO6nVnB8UQbd7G5jkUPNjBPRQ==
X-Received: by 2002:a17:903:1109:b0:1b0:3ab6:5140 with SMTP id n9-20020a170903110900b001b03ab65140mr23217888plh.4.1692866535519;
        Thu, 24 Aug 2023 01:42:15 -0700 (PDT)
Received: from MSCND1355B05.fareast.nevint.com ([183.242.39.186])
        by smtp.gmail.com with ESMTPSA id b15-20020a170902d50f00b001bbab888ba0sm12270452plg.138.2023.08.24.01.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Aug 2023 01:42:15 -0700 (PDT)
From:   Zqiang <qiang.zhang1211@gmail.com>
To:     paulmck@kernel.org, joel@joelfernandes.org
Cc:     qiang.zhang1211@gmail.com, linux-kernel@vger.kernel.org,
        rcu@vger.kernel.org
Subject: [PATCH] rcutorture: Traverse possible cpu to set maxcpu in rcu_nocb_toggle()
Date:   Thu, 24 Aug 2023 16:42:06 +0800
Message-Id: <20230824084206.22844-1-qiang.zhang1211@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently, the maxcpu is set by traversing online CPUs, however, if
the rcutorture.onoff_holdoff is set zero and onoff_interval is set
non-zero, and the some CPUs with larger cpuid has been offline before
setting maxcpu, for these CPUs, even if they are online again, also
cannot be offload or deoffload.

This commit therefore use for_each_possible_cpu() instead of
for_each_online_cpu() in rcu_nocb_toggle().

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>
---
 kernel/rcu/rcutorture.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index a58372bdf0c1..b75d0fe558ce 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2131,7 +2131,7 @@ static int rcu_nocb_toggle(void *arg)
 	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
 	while (!rcu_inkernel_boot_has_ended())
 		schedule_timeout_interruptible(HZ / 10);
-	for_each_online_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
 	if (toggle_interval > ULONG_MAX)
-- 
2.17.1

