Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACE4B7911E3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:15:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352387AbjIDHPR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:15:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352388AbjIDHPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:15:04 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ACD312A;
        Mon,  4 Sep 2023 00:15:01 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-590685a3be5so10834837b3.0;
        Mon, 04 Sep 2023 00:15:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693811700; x=1694416500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jiAwVwkckA9CkhcVmAh5lppaL9NHm/93zM8EaKeKerA=;
        b=oIkX9lvpcsnmSkgqnry+BAb7wAvvqJe5dL5iIsvFL4w8jn/xCl3+pZsJXwJnJU0mCT
         mMNbsOWGoUgR+guTGGKzKMNc0mxVqDNaCYmOrdO4b8n0KJwwGyeoZHslmb07SDq+7JZy
         1O/mQslWwJB3RaB6u/22iOK0mPfVeGfOV3hSKGfJdLrDDJriOFuOfQ8PxQzXaEKVUpfg
         9mluufyLQgIJBJwfkJxY6bH8gF4Iu9K7LlM9iMR8Drwblar7RnJilfDRGUW5pZUio2ZI
         NQHjwPg/UMLxn2EFAJwxYLqzRWx/ALJXUyOyWZFXdAd/NvMcW9u+w0uG7wuVVwkwudOq
         oxqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811700; x=1694416500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jiAwVwkckA9CkhcVmAh5lppaL9NHm/93zM8EaKeKerA=;
        b=hqyeDCGTxdSBq9Ig4itXQICsv7x+DnUzY9UQ2+998qlnz7xk/7inNpjb/Awxtpv6xf
         GWe3x4vGIgH14hqL9b0nMJha1vFtBd9Sioa7dEBsupnNfHjbsrVqfuD50iSfg5ZZE4Xu
         ngQVBcikUEMjAr0sQVaqd1hSQc9kOYJ2fzuZ1nsYAQwtl/D/MFuEn13pqHdcks6arlbu
         I9qixnclKQ3s6wpNEXr8ZiQmi/cefbaCPraiZkccUsojxD+3SRchnHsqFqkMWA6TaVWO
         /sCon9XIroF9/FP0rtZMpqzZVFWOZhZtcSGZoQhFjeZxFAkjLi2adERrAyONqaKjq5cQ
         /Kmw==
X-Gm-Message-State: AOJu0Yyic70W5h++HH55/voi3AyIqZSAIKihbRE9z4vO4PzeaxRt6J2S
        6Ii2KRX/YAMQEwRc2htNUXeqngp6KBJcCQ==
X-Google-Smtp-Source: AGHT+IHE3fox3/egkV9aUlWYwF9NTGZpn9AFHAPk6xZIq8ZyUJ+B0xdbDgWulC2UymqhgTT5wCB/nQ==
X-Received: by 2002:a25:cf4b:0:b0:d7e:6d10:9792 with SMTP id f72-20020a25cf4b000000b00d7e6d109792mr9323140ybg.5.1693811700606;
        Mon, 04 Sep 2023 00:15:00 -0700 (PDT)
Received: from PLK-D0032.dom2.local ([157.25.98.166])
        by smtp.gmail.com with ESMTPSA id 82-20020a251955000000b00d74b144004bsm2207565ybz.12.2023.09.04.00.14.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:15:00 -0700 (PDT)
From:   Tomasz Rostanski <tomasz.rostanski@gmail.com>
X-Google-Original-From: Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     stable@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>,
        Robert Hancock <robert.hancock@calian.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 3/5] usb: dwc3: Calculate REFCLKPER based on reference clock
Date:   Mon,  4 Sep 2023 09:14:24 +0200
Message-ID: <20230904071432.32309-3-tomasz.rostanski@thalesgroup.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
References: <20230904071432.32309-1-tomasz.rostanski@thalesgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sean Anderson <sean.anderson@seco.com>

Instead of using a special property to determine the reference clock
period, use the rate of the reference clock. When we have a legacy
snps,ref-clock-period-ns property and no reference clock, use it
instead. Fractional clocks are not currently supported, and will be
dealt with in the next commit.

Tested-by: Robert Hancock <robert.hancock@calian.com>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20220127200636.1456175-4-sean.anderson@seco.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 9635c915e2f7..6ee75a72c4d8 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -355,14 +355,24 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
  */
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
+	unsigned long period;
+	unsigned long rate;
 	u32 reg;
 
-	if (dwc->ref_clk_per == 0)
+	if (dwc->ref_clk) {
+		rate = clk_get_rate(dwc->ref_clk);
+		if (!rate)
+			return;
+		period = NSEC_PER_SEC / rate;
+	} else if (dwc->ref_clk_per) {
+		period = dwc->ref_clk_per;
+	} else {
 		return;
+	}
 
 	reg = dwc3_readl(dwc->regs, DWC3_GUCTL);
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
-	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, dwc->ref_clk_per);
+	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
 }
 
-- 
2.41.0

