Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E229E7C7258
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Oct 2023 18:21:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379511AbjJLQVQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Oct 2023 12:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344060AbjJLQVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Oct 2023 12:21:11 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F73DA9;
        Thu, 12 Oct 2023 09:21:10 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-503397ee920so1503425e87.1;
        Thu, 12 Oct 2023 09:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1697127668; x=1697732468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3SPN7XBgYtAbtWzOHt/0rYEE5hOBz9Hk2ZUOg0QfyB0=;
        b=TNKw66xFB7Gmzg3kLfSQCIKjkEZRmAxFb1/RiyohVI3cY8qHEzndaJBsOkvlhpPkOu
         WOSwTcLhQKwol4UZ+k9mxK3JzBnf3sEk13GfhO9Gpa09iKtetrceM2DjPrat+/wAgpVo
         Bw2OM4xNcHmLGNTp/HOPChEUEf6fMawZ1ALZQBWTPSuX+TxZOLUuIpCQuzah0fHQn/dq
         jdpsksDVqrEXLccCQbfi9+qxnN3ehb6dddmH1RD8OZeAXGsW4pgSeTE3JQzPY87DEW8o
         V35E4MV2yyqsmKIXc1CNZgmUU6NK8XFvFFt1ijMItlxyvOUmbLepvtVv8KS3cGeKTOet
         6jyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697127668; x=1697732468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3SPN7XBgYtAbtWzOHt/0rYEE5hOBz9Hk2ZUOg0QfyB0=;
        b=ESgYAgQSU//Y9Xzo3ggqBgoDQ/7NKFpJSs+mzG7K1negl02ANf7EQX5i+xlpcnpKAI
         uHEmj89U+Jmzeqjc65Z3hiKFXAZ3LjKLoCr6de0wTRBc6zfrFp2kLy/YF2r/j+gf1/nK
         gCVBWTGbngKkq57WhGQoPyiDCRJkLMSyOgK4lNATBMGAJmvn+DVvHBlAmlexM/vsAf5C
         WZ7GghnQYrzUaFLL8rZvGnQn1Gm2n9r7tqfF5DOGs4Q1YxjoYNTT1UqZsux5LanBZ/qr
         iL7NGLLAFqwMJ2JAvYzRnuUmOuqXGmh69HonKX/V/IxIEFfrHGAFOfT+/lw/q7uICsRs
         049A==
X-Gm-Message-State: AOJu0YzchpT3Gz9EofEanaiONAKH5b5O8yf6OrJwm+u9iuZrUazjUWVM
        CWckAnOc6aflpvRh601t0D8=
X-Google-Smtp-Source: AGHT+IGJcGDV8jEbS1mMXyuVP2qOdoVGHW96/rwCFFkIKzmLucR5M69QbrDpBKtWgQ0ScTKfd89XZg==
X-Received: by 2002:a05:6512:5ca:b0:4fa:5e76:7ad4 with SMTP id o10-20020a05651205ca00b004fa5e767ad4mr17671439lfo.10.1697127667970;
        Thu, 12 Oct 2023 09:21:07 -0700 (PDT)
Received: from hp-power-15.localdomain (78-62-135-63.static.zebra.lt. [78.62.135.63])
        by smtp.gmail.com with ESMTPSA id br34-20020a056512402200b005068e7a2e7dsm2557470lfb.77.2023.10.12.09.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Oct 2023 09:21:07 -0700 (PDT)
From:   Siarhei Volkau <lis8215@gmail.com>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Siarhei Volkau <lis8215@gmail.com>
Cc:     Paul Cercueil <paul@crapouillou.net>
Subject: [PATCH] MIPS: Take in account load hazards for HI/LO restoring
Date:   Thu, 12 Oct 2023 19:20:27 +0300
Message-ID: <20231012162027.3411684-1-lis8215@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS CPUs usually have 1 to 4 cycles load hazards, thus doing load
and right after move to HI/LO will usually stall the pipeline for
significant amount of time. Let's take it into account and separate
loads and mthi/lo in instruction sequence.

The patch uses t6 and t7 registers as temporaries in addition to t8.

The patch tries to deal with SmartMIPS, but I know little about and
haven't tested it.

Signed-off-by: Siarhei Volkau <lis8215@gmail.com>
---
 arch/mips/include/asm/stackframe.h | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/stackframe.h b/arch/mips/include/asm/stackframe.h
index a8705aef47e1..3821d91b00fd 100644
--- a/arch/mips/include/asm/stackframe.h
+++ b/arch/mips/include/asm/stackframe.h
@@ -308,17 +308,11 @@
 		jal	octeon_mult_restore
 #endif
 #ifdef CONFIG_CPU_HAS_SMARTMIPS
-		LONG_L	$24, PT_ACX(sp)
-		mtlhx	$24
-		LONG_L	$24, PT_HI(sp)
-		mtlhx	$24
-		LONG_L	$24, PT_LO(sp)
-		mtlhx	$24
-#elif !defined(CONFIG_CPU_MIPSR6)
+		LONG_L	$14, PT_ACX(sp)
+#endif
+#if defined(CONFIG_CPU_HAS_SMARTMIPS) || !defined(CONFIG_CPU_MIPSR6)
 		LONG_L	$24, PT_LO(sp)
-		mtlo	$24
-		LONG_L	$24, PT_HI(sp)
-		mthi	$24
+		LONG_L	$15, PT_HI(sp)
 #endif
 #ifdef CONFIG_32BIT
 		cfi_ld	$8, PT_R8, \docfi
@@ -327,6 +321,14 @@
 		cfi_ld	$10, PT_R10, \docfi
 		cfi_ld	$11, PT_R11, \docfi
 		cfi_ld	$12, PT_R12, \docfi
+#ifdef CONFIG_CPU_HAS_SMARTMIPS
+		mtlhx	$14
+		mtlhx	$15
+		mtlhx	$24
+#elif !defined(CONFIG_CPU_MIPSR6)
+		mtlo	$24
+		mthi	$15
+#endif
 		cfi_ld	$13, PT_R13, \docfi
 		cfi_ld	$14, PT_R14, \docfi
 		cfi_ld	$15, PT_R15, \docfi
-- 
2.41.0

