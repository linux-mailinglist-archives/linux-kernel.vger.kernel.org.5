Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22EA4750DB2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 18:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233350AbjGLQLy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 12:11:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233313AbjGLQLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 12:11:45 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD6BD2682;
        Wed, 12 Jul 2023 09:11:26 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fc03aa6e04so51872215e9.2;
        Wed, 12 Jul 2023 09:11:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689178284; x=1691770284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D7rjo35UIzSXVZvg5cEHUOQSz9DEtkcx5oJGhm9KZwE=;
        b=lBNLMn7HVT8fTNlN4An+bJtVBswDAUOa+cgwnrKi7ykcJCX4En1Vy4pmGfR8Bnf9Qb
         eP/M7ygOZ72MEAT2ysEpCWi13UuWK3yM8CAhCAWdQd8fUk48TW47yapFzgThguOOuBae
         qjt6+Oa5WWn2exNaaQq2tVaSusLJFmlsCl2y1wGKIgWkKoEgwzn4vWNMlbEw7h0YiZ8t
         PBGszpP+JcGSgMyS8LXUqMWSU3r/6OlW0wcCfxgTOOM/HKD4o2FsSsp/YsiCxf+vs5xF
         xRBvczKu3zfy5g4QsNz9WFeSTcOXb32UWnZ3gRXtI6NhrgvzdHXaF26YCdXMNqMBWB6n
         J6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689178284; x=1691770284;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D7rjo35UIzSXVZvg5cEHUOQSz9DEtkcx5oJGhm9KZwE=;
        b=SGY1Jb6pck4qUIvxfp8qOqfKtb+QWB3QvUosZmL7VhLOWm1OGMx4pxpVqqmFE0goRR
         /WwfpvHfw4jaqUALSsiH+phlWGmNHppFu15+S3+snOGWHr7DE1TRuqXbNtXT4ROfsCEM
         8oeFcnuIUNo0QufQP5ydzIp35b4EtA7iDCE5WGQZUdXkg4ENxFmLS4U4xXdt5Nm/vLSW
         LFMJH/vC5cjEAVgTT5ZccXzxer+YQ8UyTmfOxJ527u9N5wDAFDD9ko3xUi6ZH67VbReQ
         Tv7aTiNM2BIahQ78SXlDFW+XUhLXBQZ9468vP6rL9WLudO1v0SGLLrlY4xWjX96RG9lK
         u+zQ==
X-Gm-Message-State: ABy/qLaRRtQ4TBaf7wPreaJ/c9WbndUi4XERN/V+vIaTuBGgWt9txpEG
        7E5SJBauLrzVxB68+hom1uc=
X-Google-Smtp-Source: APBJJlGRxOLC0PmFRbKVGnXl+kzSvEqYTfgQtUH9mpCaZI0BkH2j9sJDz1UI9UGbu7ZsPDru7YhrDA==
X-Received: by 2002:a5d:5603:0:b0:314:37e7:efb4 with SMTP id l3-20020a5d5603000000b0031437e7efb4mr15099694wrv.11.1689178284496;
        Wed, 12 Jul 2023 09:11:24 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id f17-20020adffcd1000000b003140fff4f75sm5460604wrs.17.2023.07.12.09.11.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jul 2023 09:11:23 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Helge Deller <deller@gmx.de>, linux-fbdev@vger.kernel.org,
        dri-devel@lists.freedesktop.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH][next][V2] video: fbdev: kyro: make some const read-only arrays static and reduce type size
Date:   Wed, 12 Jul 2023 17:11:23 +0100
Message-Id: <20230712161123.465713-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

Don't populate the const read-only arrays on the stack but instead
make them static const. Use smaller types to use less storage for
the arrays.  Also makes the object code a little smaller.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---

V2: Use smaller int types, kudos to Helge Deller for suggesting this

---
 drivers/video/fbdev/kyro/STG4000InitDevice.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/video/fbdev/kyro/STG4000InitDevice.c b/drivers/video/fbdev/kyro/STG4000InitDevice.c
index edfa0a04854d..79886a246638 100644
--- a/drivers/video/fbdev/kyro/STG4000InitDevice.c
+++ b/drivers/video/fbdev/kyro/STG4000InitDevice.c
@@ -83,11 +83,11 @@ volatile u32 i,count=0; \
 static u32 InitSDRAMRegisters(volatile STG4000REG __iomem *pSTGReg,
 			      u32 dwSubSysID, u32 dwRevID)
 {
-	u32 adwSDRAMArgCfg0[] = { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
-	u32 adwSDRAMCfg1[] = { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };
-	u32 adwSDRAMCfg2[] = { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, 0xa7d2 };
-	u32 adwSDRAMRsh[] = { 36, 39, 40 };
-	u32 adwChipSpeed[] = { 110, 120, 125 };
+	static const u8 adwSDRAMArgCfg0[] = { 0xa0, 0x80, 0xa0, 0xa0, 0xa0 };
+	static const u16 adwSDRAMCfg1[] = { 0x8732, 0x8732, 0xa732, 0xa732, 0x8732 };
+	static const u16 adwSDRAMCfg2[] = { 0x87d2, 0x87d2, 0xa7d2, 0x87d2, 0xa7d2 };
+	static const u8 adwSDRAMRsh[] = { 36, 39, 40 };
+	static const u8 adwChipSpeed[] = { 110, 120, 125 };
 	u32 dwMemTypeIdx;
 	u32 dwChipSpeedIdx;
 
-- 
2.39.2

