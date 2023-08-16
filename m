Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD0977E2D0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 15:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245656AbjHPNkI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 09:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245609AbjHPNjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 09:39:49 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 459C726A9;
        Wed, 16 Aug 2023 06:39:48 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1bdf7086ae5so16019805ad.0;
        Wed, 16 Aug 2023 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692193188; x=1692797988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oscugnf7qYaTZOb13U9ax19uPvy15y4ztIfQsoTuemg=;
        b=C4NKz8S2dkpWNgwFeQmkOLjPwyXB2iURVjCpQ73Sa5SYRQEjIRSFZkXJV17gS6ppfG
         etzuAmbwu94iRIMEuqQdmVd73tTyXvyqJd7wBVNUoL4It95ok5sKs4YF3iEXC7BnQ1lE
         7UmKVCEHWgGebJ16Od3m8lfc1Inl/OFqt8wLn0hDLSUpK8n3ZqsVANSFkesUI7EncayZ
         6zw8MDCGSToRyvnVXuadnKjst7LTvrNNZSCX32IiUjOaN++Vb/1WI+vZUyAw9vJMo1dO
         MaV3mgE4pGTCUxje2bS0xZDNqpQYB5dTAka55kHTzaXTwHUhVFKBfpjCJegRp6/DG4IN
         3oYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692193188; x=1692797988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oscugnf7qYaTZOb13U9ax19uPvy15y4ztIfQsoTuemg=;
        b=ELyaDrVOw2A5kSFsFBR+lKpw4E5k8CHEilru8m/BWuTL+UIbc73maZgnJJiZuotbvw
         gGHOpU3SsGts1hBiJnKmYIn78cmnw5QRo2PkE+uPoKJ3IOTfJ1CTxH0yjm0wqkxGGLo2
         QX9+8aOAjNRhBR3eUqReIxgLhuwZilKY6f7rkAKJVAgOEd0kIgfOzp5SfsboAsGXtpY0
         IwIMZGGp0aPD+TSaLpkxNlJ9UmTdNAJi0t9wIvJc+t1MjOltYAzgAv0nACKp8xU34jd/
         XlOoFmlF9uz2tPA7Z93U+f5uiOeKICp/51Ee7ogVOVYZDjssZ8ZcPga2uY0YXhQbvp9x
         DtiQ==
X-Gm-Message-State: AOJu0Yy37Bj6l3ySemJSxlhmBjS76kOT+sXFXK4LBpjF2JQbamq3R0lS
        YB8ynoRXArC5pd4PECQHtv172L/ltCk=
X-Google-Smtp-Source: AGHT+IE9o2BFl+XSfkXzpZE3w/IEWeczET+nJDuzj9eYjAN8CUJekT0r5nLPfNh05AT8k+Z6CzUjWg==
X-Received: by 2002:a17:902:e5cc:b0:1bc:5197:73c5 with SMTP id u12-20020a170902e5cc00b001bc519773c5mr2172551plf.54.1692193187739;
        Wed, 16 Aug 2023 06:39:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b4-20020a170902d50400b001bb9b5e86b7sm13173773plg.91.2023.08.16.06.39.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 06:39:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Benson Leung <bleung@chromium.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <jstultz@google.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-rtc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4/7] rtc: cmos: Report supported alarm limit to rtc infrastructure
Date:   Wed, 16 Aug 2023 06:39:33 -0700
Message-Id: <20230816133936.2150294-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230816133936.2150294-1-linux@roeck-us.net>
References: <20230816133936.2150294-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The alarm window supported by the cmos RTC depends on the chip
and its configuration. Report the limit to the RTC core.

Cc: Brian Norris <briannorris@chromium.org>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 drivers/rtc/rtc-cmos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index c9416fe8542d..c565dc4d5bf5 100644
--- a/drivers/rtc/rtc-cmos.c
+++ b/drivers/rtc/rtc-cmos.c
@@ -913,6 +913,10 @@ static inline void cmos_check_acpi_rtc_status(struct device *dev,
 #define	INITSECTION	__init
 #endif
 
+#define SECS_PER_DAY	(24 * 60 * 60)
+#define SECS_PER_MONTH	(28 * SECS_PER_DAY)
+#define SECS_PER_YEAR	(365 * SECS_PER_DAY)
+
 static int INITSECTION
 cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 {
@@ -1019,6 +1023,13 @@ cmos_do_probe(struct device *dev, struct resource *ports, int rtc_irq)
 		goto cleanup0;
 	}
 
+	if (cmos_rtc.mon_alrm)
+		cmos_rtc.rtc->range_max_offset = SECS_PER_YEAR - 1;
+	else if (cmos_rtc.day_alrm)
+		cmos_rtc.rtc->range_max_offset = SECS_PER_MONTH - 1;
+	else
+		cmos_rtc.rtc->range_max_offset = SECS_PER_DAY - 1;
+
 	rename_region(ports, dev_name(&cmos_rtc.rtc->dev));
 
 	if (!mc146818_does_rtc_work()) {
-- 
2.39.2

