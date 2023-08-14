Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 458DA77B285
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:32:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjHNHb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:31:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjHNHbr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:31:47 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4DF618F;
        Mon, 14 Aug 2023 00:31:46 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fe457ec6e7so6318650e87.3;
        Mon, 14 Aug 2023 00:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691998305; x=1692603105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ixpphlS+lzvOkktfW5pGEx4frnWlNln3Xa4giRpZV6I=;
        b=ClJhCCmZUVe7TpvcdR5MllqvVL++z6CitaMZq7e3IlNYQrcgNvITZTmOsJ6Bgn1o1V
         QFikyoG3wJB02RGGRGzgjoVnAV3KwhLh/LA2XeStl5l/DO+N2v7x0qSAtFJxvr5Rs0k+
         WKgh+DOdMXnAVOI0DkrTRpElSnQ15qHVME8UvXiofMSf5iuj+bGwRdJzzfu6TNdtl20o
         P9kkY+ZXiBc1XhfipiGIkwg0xU5VfSN++Zh1hhsne9o5UCs9jzrtfA08rTzwN8AQ680G
         jHp3HH1JPmm/8MSgQCd0iHh0kdXRZQwBv43GurYkO2WcC5NVS3aMyrWfMoVgUWqwXmjr
         VmnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691998305; x=1692603105;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ixpphlS+lzvOkktfW5pGEx4frnWlNln3Xa4giRpZV6I=;
        b=iXerW4BbDpSaLH+PKZH3VeaCvMe7jW91YJYRCdHOv3iZPErJLjGoV2qq+Lnxu0oG7g
         V5WYW4xLXBcc1kq7YhaTG2Z3Jau9TIHCEck29D/xxhzFwvPfsDs+8V8AATzflKpfPQrX
         FGjUSkB1YzxnHWkZY49o8mJgQPqTsBfw/rTwrZ0eNnbyMUwKnRpa6AhI1JvFNeJ+Jeo6
         KOC0jaewLs501SDONHcvWdKUtqHCZTuGULp3/YkfoU7HDQpio6aBkZxsVIDexwHdbDff
         M/xvkQXdTbJM78ZkdA91pOLXlbWEYbuZbEs/FEqAMnA+qYBxfVdIeLJVsg1t/X+2LyOD
         Zouw==
X-Gm-Message-State: AOJu0YzChskCgC6ofYgoay1BD4/oraeSZvBWlK80ME28hGIEdcqQR2x8
        gqHo1z5ozERhQ+wily3JmM37qtCr1YN2ZA==
X-Google-Smtp-Source: AGHT+IFJyPcsbqpLS8ia463YpUO5wOtqc+4CdEpeMoN5A7nk3MjvUAeDsuD9OTqkghOnDbZyC9ps9w==
X-Received: by 2002:a05:6512:3b0f:b0:4fc:4f3e:9cbf with SMTP id f15-20020a0565123b0f00b004fc4f3e9cbfmr7161373lfv.50.1691998304535;
        Mon, 14 Aug 2023 00:31:44 -0700 (PDT)
Received: from localhost.localdomain (ip-085-216-017-139.um25.pools.vodafone-ip.de. [85.216.17.139])
        by smtp.gmail.com with ESMTPSA id r13-20020aa7d14d000000b005256ae8494asm451962edo.17.2023.08.14.00.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 00:31:44 -0700 (PDT)
From:   Gerd Haeussler <haeussler.gerd@gmail.com>
To:     linux-kernel@vger.kernel.org, Hans de Goede <hdegoede@redhat.com>
Cc:     linux-leds@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-watchdog@vger.kernel.org,
        Tobias Schaffner <tobias.schaffner@siemens.com>,
        Xing Tong Wu <xingtong.wu@siemens.com>,
        Gerd Haeussler <gerd.haeussler.ext@siemens.com>
Subject: [PATCH] MAINTAINERS: Add entries for Siemens IPC modules
Date:   Mon, 14 Aug 2023 09:31:14 +0200
Message-Id: <20230814073114.2885-1-haeussler.gerd@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gerd Haeussler <gerd.haeussler.ext@siemens.com>

There are different IPC driver modules in the kernel that are actively
maintained by Siemens but not yet listed in the MAINTAINERS file.
Add the missing entries.

Signed-off-by: Gerd Haeussler <gerd.haeussler.ext@siemens.com>
---
 MAINTAINERS | 26 ++++++++++++++++++++++++++
 1 file changed, 26 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0f966f05fb0d..6ca5564a4f8c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19402,6 +19402,32 @@ F:	drivers/media/mmc/siano/
 F:	drivers/media/usb/siano/
 F:	drivers/media/usb/siano/
 
+SIEMENS IPC LED DRIVERS
+M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+M:	Xing Tong Wu <xingtong.wu@siemens.com>
+M:	Tobias Schaffner <tobias.schaffner@siemens.com>
+L:	linux-leds@vger.kernel.org
+S:	Maintained
+F:	drivers/leds/simple/
+
+SIEMENS IPC PLATFORM DRIVERS
+M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+M:	Xing Tong Wu <xingtong.wu@siemens.com>
+M:	Tobias Schaffner <tobias.schaffner@siemens.com>
+L:	platform-driver-x86@vger.kernel.org
+S:	Maintained
+F:	drivers/platform/x86/siemens/
+F:	include/linux/platform_data/x86/simatic-ipc-base.h
+F:	include/linux/platform_data/x86/simatic-ipc.h
+
+SIEMENS IPC WATCHDOG DRIVERS
+M:	Gerd Haeussler <gerd.haeussler.ext@siemens.com>
+M:	Xing Tong Wu <xingtong.wu@siemens.com>
+M:	Tobias Schaffner <tobias.schaffner@siemens.com>
+L:	linux-watchdog@vger.kernel.org
+S:	Maintained
+F:	drivers/watchdog/simatic-ipc-wdt.c
+
 SIFIVE DRIVERS
 M:	Palmer Dabbelt <palmer@dabbelt.com>
 M:	Paul Walmsley <paul.walmsley@sifive.com>
-- 
2.20.1

