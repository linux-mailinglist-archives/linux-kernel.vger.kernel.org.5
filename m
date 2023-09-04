Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02C597911E4
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:15:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352425AbjIDHPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352392AbjIDHPH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:15:07 -0400
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A38A1A7;
        Mon,  4 Sep 2023 00:15:03 -0700 (PDT)
Received: by mail-yb1-xb36.google.com with SMTP id 3f1490d57ef6-d7260fae148so951259276.1;
        Mon, 04 Sep 2023 00:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693811703; x=1694416503; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YKIRtA0yq/5fynHAAMm8DiqA6Q5iMhgVgj9GQi1BiRw=;
        b=YXM3sCvDGBdTmdvTgYK/zh+yROLb0RuLrtDJqBYpz9zeLI3tnGXzJpNPlCPhYTC6J9
         t8Ex6TA0dXuz+iWlum6d+7ySSI78pWTQ4pJLnjUk8liuH/94zaaHx3TeEmuigSG8bfs1
         2RqnrxZV3UVnFH3XRZ5lgQNpGqdDWrBf1+KpRoJNIaxEFO0pNa3iArsP0lMsT2+1k4F4
         23WxvH51+yFQ2m8r/vfJ0OXHBLP73s4c385jXsFNu/486tRz01nqVMpEliiMK12KS6Vh
         l3wq01qagXGiiJzxTZUyO8fRrGRyJjO+yFXObvEWuk9osqXyHwmV4gMiOro+yMwHVpF4
         Zd+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693811703; x=1694416503;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YKIRtA0yq/5fynHAAMm8DiqA6Q5iMhgVgj9GQi1BiRw=;
        b=Vk7gXKnpzn1xLfCoowKywq01qzWjrJI8JxJh49NtR+DwQ+0GMuglqB1U/Cdvnu+JNW
         qMrom2jKnCaB1wX4svZ++ucP0OmqZn9poEfYN/hHcsuaoMX1UXRTurJKiwWl5Qe5MN4o
         ef+2A+x4kj2HEzCVe68P0MfF6rXrwoiQGHfgJJ1D2yjeS7/L9y7pr2tomvgDxgLmYNP9
         P99jZHmClera513N6FxVfGi5XPAawRGKiEfFEcj+CtDkcOX481MPYf2y3sV1TwbvMbE1
         YepTJWQIGoQFSOuF2r6JkExMDL8N6UMXXvJ3xFyPuspmI5+/nb2CQOOqwqimBpw+Nqjb
         e1ew==
X-Gm-Message-State: AOJu0YykD+UTigQGKnwlXNuakOgYFeiQQ55L51/TJEOGDNHliqrDjigS
        hSvsvVWj7qocNKIoTWhr+ckvy7hWsae4gg==
X-Google-Smtp-Source: AGHT+IGq/uAJfBDQUhKSqxwYxw9HN08zaEmSJF0/2Ib1RNi0uNm0MzGu4QCxO2A3aaTTlLawDb8gMQ==
X-Received: by 2002:a25:44c:0:b0:d05:bf5b:918f with SMTP id 73-20020a25044c000000b00d05bf5b918fmr8224878ybe.28.1693811702692;
        Mon, 04 Sep 2023 00:15:02 -0700 (PDT)
Received: from PLK-D0032.dom2.local ([157.25.98.166])
        by smtp.gmail.com with ESMTPSA id 82-20020a251955000000b00d74b144004bsm2207565ybz.12.2023.09.04.00.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Sep 2023 00:15:02 -0700 (PDT)
From:   Tomasz Rostanski <tomasz.rostanski@gmail.com>
X-Google-Original-From: Tomasz Rostanski <tomasz.rostanski@thalesgroup.com>
Cc:     stable@vger.kernel.org, Sean Anderson <sean.anderson@seco.com>,
        Robert Hancock <robert.hancock@calian.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] usb: dwc3: Program GFLADJ
Date:   Mon,  4 Sep 2023 09:14:25 +0200
Message-ID: <20230904071432.32309-4-tomasz.rostanski@thalesgroup.com>
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

GUCTL.REFCLKPER can only account for clock frequencies with integer
periods. To address this, program REFCLK_FLADJ with the relative error
caused by period truncation. The formula given in the register reference
has been rearranged to allow calculation based on rate (instead of
period), and to allow for fixed-point arithmetic.

Additionally, calculate a value for 240MHZDECR. This configures a
simulated 240Mhz clock using a counter with one fractional bit (PLS1).

This register is programmed only for versions >= 2.50a, since this is
the check also used by commit db2be4e9e30c ("usb: dwc3: Add frame length
adjustment quirk").

Tested-by: Robert Hancock <robert.hancock@calian.com>
Reviewed-by: Robert Hancock <robert.hancock@calian.com>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20220127200636.1456175-5-sean.anderson@seco.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/core.c | 39 ++++++++++++++++++++++++++++++++++++++-
 drivers/usb/dwc3/core.h |  3 +++
 2 files changed, 41 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.c b/drivers/usb/dwc3/core.c
index 6ee75a72c4d8..2eb27c60542a 100644
--- a/drivers/usb/dwc3/core.c
+++ b/drivers/usb/dwc3/core.c
@@ -356,6 +356,8 @@ static void dwc3_frame_length_adjustment(struct dwc3 *dwc)
 static void dwc3_ref_clk_period(struct dwc3 *dwc)
 {
 	unsigned long period;
+	unsigned long fladj;
+	unsigned long decr;
 	unsigned long rate;
 	u32 reg;
 
@@ -366,6 +368,7 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 		period = NSEC_PER_SEC / rate;
 	} else if (dwc->ref_clk_per) {
 		period = dwc->ref_clk_per;
+		rate = NSEC_PER_SEC / period;
 	} else {
 		return;
 	}
@@ -374,8 +377,42 @@ static void dwc3_ref_clk_period(struct dwc3 *dwc)
 	reg &= ~DWC3_GUCTL_REFCLKPER_MASK;
 	reg |=  FIELD_PREP(DWC3_GUCTL_REFCLKPER_MASK, period);
 	dwc3_writel(dwc->regs, DWC3_GUCTL, reg);
-}
 
+	if (DWC3_VER_IS_PRIOR(DWC3, 250A))
+		return;
+
+	/*
+	 * The calculation below is
+	 *
+	 * 125000 * (NSEC_PER_SEC / (rate * period) - 1)
+	 *
+	 * but rearranged for fixed-point arithmetic. The division must be
+	 * 64-bit because 125000 * NSEC_PER_SEC doesn't fit in 32 bits (and
+	 * neither does rate * period).
+	 *
+	 * Note that rate * period ~= NSEC_PER_SECOND, minus the number of
+	 * nanoseconds of error caused by the truncation which happened during
+	 * the division when calculating rate or period (whichever one was
+	 * derived from the other). We first calculate the relative error, then
+	 * scale it to units of 8 ppm.
+	 */
+	fladj = div64_u64(125000ULL * NSEC_PER_SEC, (u64)rate * period);
+	fladj -= 125000;
+
+	/*
+	 * The documented 240MHz constant is scaled by 2 to get PLS1 as well.
+	 */
+	decr = 480000000 / rate;
+
+	reg = dwc3_readl(dwc->regs, DWC3_GFLADJ);
+	reg &= ~DWC3_GFLADJ_REFCLK_FLADJ_MASK
+	    &  ~DWC3_GFLADJ_240MHZDECR
+	    &  ~DWC3_GFLADJ_240MHZDECR_PLS1;
+	reg |= FIELD_PREP(DWC3_GFLADJ_REFCLK_FLADJ_MASK, fladj)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR, decr >> 1)
+	    |  FIELD_PREP(DWC3_GFLADJ_240MHZDECR_PLS1, decr & 1);
+	dwc3_writel(dwc->regs, DWC3_GFLADJ, reg);
+}
 
 /**
  * dwc3_free_one_event_buffer - Frees one event buffer
diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 1e5ef1c512fb..9c421de4d01d 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -384,6 +384,9 @@
 /* Global Frame Length Adjustment Register */
 #define DWC3_GFLADJ_30MHZ_SDBND_SEL		BIT(7)
 #define DWC3_GFLADJ_30MHZ_MASK			0x3f
+#define DWC3_GFLADJ_REFCLK_FLADJ_MASK		GENMASK(21, 8)
+#define DWC3_GFLADJ_240MHZDECR			GENMASK(30, 24)
+#define DWC3_GFLADJ_240MHZDECR_PLS1		BIT(31)
 
 /* Global User Control Register*/
 #define DWC3_GUCTL_REFCLKPER_MASK		0xffc00000
-- 
2.41.0

