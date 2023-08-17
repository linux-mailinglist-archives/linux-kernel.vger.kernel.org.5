Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB6FF780163
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 00:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355960AbjHQW4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 18:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355935AbjHQW4F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 18:56:05 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E4BB3A86;
        Thu, 17 Aug 2023 15:55:46 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1bee82fab5aso2700275ad.3;
        Thu, 17 Aug 2023 15:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692312946; x=1692917746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oBswWeic/lo4KfdmWov/kNdO9T86copP+2hJMykbXoU=;
        b=SkFvGImlqWNj7k34nqFQ0h98ZUGV0d/dBxQ/TCfwPQJFUW2xvaBQgORu9wRoxqFTB6
         zj4mWDkCrU6t3meRpjTUmUsmnC/sDXkqoFesuLocHt005vmRQzOI40MQjQRN1JC60wZX
         d4+KusfOGcATN9sZliVHVD9vHGAq6gkSByL/plmCiNElMXC27/BO0p/Rw1eKjQbzkd/l
         pP6bdRd23JTnGMGW3Bs/M+I5Xr0yMyAKxvSvLJDaH7SS0d9aRy7f+RgAvUmQFMVmVvKi
         8ZFBeDdf+8WvG3+1F15iL1eATbVw2c7gi4Ew7+Gy7v0vcqLLv6w4NDH27+RqQ31s07GG
         SqYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692312946; x=1692917746;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oBswWeic/lo4KfdmWov/kNdO9T86copP+2hJMykbXoU=;
        b=axFT9YhWC+w1W3VQyC2GB7EdrUBtRE2UC3L6++ql16Ye6Y5HChH5zTJCIzmQdhN+fu
         Np1CX+TazP4L2mpQlJzAVPkxRe3D7XLuiBN3foD3HO+UTxOBwqS5nBEFpgfZONTmp1NP
         MNIo+Ak23JIwuWZlA68Sss6dGTuqSes+HgNRZjE9TvZBfi38D8Vp1lXYc+qBySEgn/il
         3DLJ/tccTbgTes4JuIjuBPkTTFYvRPlPAzatO84gXe5rriojEpIvS5hiUy8YrkR6wj8l
         9pHNV6zMGfKKi0M1ay+sfKbqKZpg+nECCsv9dHdw6frUfiaLdTkISCzQRZlroKwhFQOF
         3VhQ==
X-Gm-Message-State: AOJu0YzE04bf7WgA+FZZFrdywM87N9EmcuNr+JzPMujSDqEcASTS5e14
        U5YXvj0Hbi/r0MD8caJ2FSE=
X-Google-Smtp-Source: AGHT+IH/z7EPJYgQZK9t5l7bkg+hRtsW1dDieYTbI0lqpjOZ7BlFEpRYNW6bHMH6bWrXqay6elvAPQ==
X-Received: by 2002:a17:902:b783:b0:1b8:8dbd:e1a0 with SMTP id e3-20020a170902b78300b001b88dbde1a0mr807488pls.13.1692312945903;
        Thu, 17 Aug 2023 15:55:45 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id iz22-20020a170902ef9600b001b9da42cd7dsm282552plb.279.2023.08.17.15.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 15:55:45 -0700 (PDT)
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
Subject: [PATCH v2 4/7] rtc: cmos: Report supported alarm limit to rtc infrastructure
Date:   Thu, 17 Aug 2023 15:55:34 -0700
Message-Id: <20230817225537.4053865-5-linux@roeck-us.net>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230817225537.4053865-1-linux@roeck-us.net>
References: <20230817225537.4053865-1-linux@roeck-us.net>
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
v2: Rename range_max_offset -> alarm_offset_max

 drivers/rtc/rtc-cmos.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/rtc/rtc-cmos.c b/drivers/rtc/rtc-cmos.c
index c9416fe8542d..228fb2d11c70 100644
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
+		cmos_rtc.rtc->alarm_offset_max = SECS_PER_YEAR - 1;
+	else if (cmos_rtc.day_alrm)
+		cmos_rtc.rtc->alarm_offset_max = SECS_PER_MONTH - 1;
+	else
+		cmos_rtc.rtc->alarm_offset_max = SECS_PER_DAY - 1;
+
 	rename_region(ports, dev_name(&cmos_rtc.rtc->dev));
 
 	if (!mc146818_does_rtc_work()) {
-- 
2.39.2

