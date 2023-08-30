Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C2078DF70
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240698AbjH3TTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244479AbjH3NM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 09:12:27 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC8D6124
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:12:24 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso52238245e9.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 06:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693401143; x=1694005943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=FgomQyLam1pIey5brFHSaZTmerTALfXgB2Hgo7DBElI=;
        b=ThH5PbvjZdt9pkz1zrh9CDChRp1TN+NDNciz2G326DfCd6OHra16++L+tjU/ieo1h/
         shXUwqI83OJsTetgd1dRJ6Mzso6J5EyFF2RlkCRrzq8uglSjpcFBIfPBGL9I69D5iejY
         Hv+91ba+O4FBA0wtoeWQOT56f2ZR2EqSlofBiQ3Ftqn53NnUSUw64awD31P+uYEcMwTP
         /EuAiBA7h+/ekONH3BdhtSIUyzAuzv8puYZM7eTFThSr5eTDMciGBsxeECo+PuXDiy6Z
         6jaUvUnzGZuh4Sz1OjvSMrMs/jxWAM+xiN2BlasOka0lxrGWXbtaPCLT4YGqSifyjFo9
         yHTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693401143; x=1694005943;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FgomQyLam1pIey5brFHSaZTmerTALfXgB2Hgo7DBElI=;
        b=RqW8oSQm3XpvUsihmQCSOiGrtF8Egzcrar2NwyJcfUsuNrGo81Uv3r4E7AMfvhGduq
         gBEm2tg5vvnqY1xE5N7dBNJp4z6cy/1nrzCrBdFwtyR+W9oj3OpQwh6TG3X6yxZixkvt
         ku7djlQ85vBgropauz8x1P95EHoLMaHDhUUjLMBS9rApbJjpY0L+CVYws0gvsYnBMHfK
         yyv0ucPWk9JZwmgm1vJIX8IKM5MpGhcuoLJINWpBu6USFvPH2mS3YXOEMWQGZTenGBVf
         GaTGKIzZO/JT3VYfbQBXqs/yVCZEPnd23NokuZxbHR7O5OkkhtVR+pUudmkbUKDMmHW7
         Q4Jg==
X-Gm-Message-State: AOJu0Yx75SH1Z1aneLCFB/hx1w1Ff7rMelnYPFemAPMfaqu2rvfE38dk
        KWzCEoPo9ZjZ7xBq5hhD4xIY6mlO6XzPmf4Nrb2wug==
X-Google-Smtp-Source: AGHT+IFKRQ55efvgwFVHid8AoMaipSIvadcZ3mX+O6GBYABSgAoL7r/ZRLxnTQ0MQCqfGchHkjynRw==
X-Received: by 2002:a7b:cbc7:0:b0:3fb:e643:1225 with SMTP id n7-20020a7bcbc7000000b003fbe6431225mr2059361wmi.13.1693401142717;
        Wed, 30 Aug 2023 06:12:22 -0700 (PDT)
Received: from localhost.localdomain ([146.70.126.167])
        by smtp.gmail.com with ESMTPSA id c26-20020a05600c0ada00b00401c944b7adsm2245790wmr.26.2023.08.30.06.12.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Aug 2023 06:12:22 -0700 (PDT)
From:   Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, Chen Lifu <chenlifu@huawei.com>
Subject: [PATCH] arch: x86: Fixes Documentation warning
Date:   Wed, 30 Aug 2023 15:12:09 +0200
Message-ID: <20230830131211.88226-1-vincenzopalazzodev@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit files the following warnings

arch/x86/kernel/i8259.c:235: warning: This comment starts with '/**', but isn't a kernel-doc comment. Refer Documentation/doc-guide/kernel-doc.rst
 * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
  CC      arch/x86/kernel/irqinit.o

Signed-off-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
---
 arch/x86/kernel/i8259.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/x86/kernel/i8259.c b/arch/x86/kernel/i8259.c
index 4d8aff05a509..30a55207c000 100644
--- a/arch/x86/kernel/i8259.c
+++ b/arch/x86/kernel/i8259.c
@@ -231,9 +231,7 @@ struct irq_chip i8259A_chip = {
 };
 
 static char irq_trigger[2];
-/**
- * ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ
- */
+/* ELCR registers (0x4d0, 0x4d1) control edge/level of IRQ */
 static void restore_ELCR(char *trigger)
 {
 	outb(trigger[0], PIC_ELCR1);
-- 
2.42.0

