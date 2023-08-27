Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0349578A28A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 00:16:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229937AbjH0WPu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Aug 2023 18:15:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjH0WPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Aug 2023 18:15:45 -0400
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8ACF129;
        Sun, 27 Aug 2023 15:15:41 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EBFEF240002;
        Sun, 27 Aug 2023 22:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1693174540;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=wPE/4NPToKL7SRA/dCsumBLN2HGXzE/yEx3bSXx+wKE=;
        b=G8x/PCZ0E4AS0X/uKIetZsi5utIOBAybfRxePJsnW6KKUhYWGsL534X/EWt2dqfISD26El
        4TzRLnSGM6rbA3+PIkaHiNDxCEuWloDrLSpAXh+L3vdmuifZaKnmVoFb/Bm834hdLTELJR
        OgeXsdN/NoKgbjtBTGglTuM5LndGz+W0anq3TEbkiWRCw8+k4fbJ7WQxH0TveMQDKvgTSF
        bLhj76Pmgtgt1/Pq+iTybRLQAZL70AjcC9i11V86x9y3WI/GVTSCN41ED9dQbUI5TIUEwX
        j0x3aJCXtFZS0ZWL4R9HzvprPkEVrEkyVwoQgwwR9XrXSGndAiPEOy5hjdto8A==
From:   alexandre.belloni@bootlin.com
To:     Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc:     linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] rtc: stop warning for invalid alarms when the alarm is disabled
Date:   Mon, 28 Aug 2023 00:15:31 +0200
Message-ID: <20230827221532.543353-1-alexandre.belloni@bootlin.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alexandre Belloni <alexandre.belloni@bootlin.com>

When the alarm is not enabled, it may never have been set and so we can't
expect it to be valid. This will prevent the apparition of boot messages
like this one:

rtc rtc0: invalid alarm value: 2023-7-8 45:85:85

Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
---
 drivers/rtc/interface.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/interface.c b/drivers/rtc/interface.c
index 499d89150afc..1b63111cdda2 100644
--- a/drivers/rtc/interface.c
+++ b/drivers/rtc/interface.c
@@ -376,7 +376,7 @@ int __rtc_read_alarm(struct rtc_device *rtc, struct rtc_wkalrm *alarm)
 	err = rtc_valid_tm(&alarm->time);
 
 done:
-	if (err)
+	if (err && alarm->enabled)
 		dev_warn(&rtc->dev, "invalid alarm value: %ptR\n",
 			 &alarm->time);
 
-- 
2.41.0

