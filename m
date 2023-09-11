Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3F1279B3F1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355259AbjIKV5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:57:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237804AbjIKNOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 09:14:33 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA40CD7
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:27 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-99c136ee106so552876866b.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 06:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1694438066; x=1695042866; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xlz6iwTR+P+aX/Li0khE/j1svXvZ2ELJqgA8Sp/LWUg=;
        b=riXB3fTGKV3MTaRcTdAtxsKHyrSTnbX6ELDPgcPe4rDRp08KkX6jk+v4s5Pvb8BCT4
         jGr8Tz6wCWxERs61lIOQ0LKNk5fn5ZZVGzuketuaYgFzBEo2qV1oD7d/WijarShCUx0x
         EILB0LzqzmK09J6btHNFkgG/4OrJeE342WhaU0VjfsjT/WAk2hHb+KeuZA2p+K0id8GR
         4F3jUpLxOVFhA9frkCvMODUf2MwH3Ud747rgSWPxr0yt4GIIPGBoLQsb5jm33fsXPZb8
         rDBy1si0M01TVvFBm5iwl5saBeAdGjW6ohDA0qpYNzN3t25x9zqLvO/i9Z0RiwzG37TD
         ecjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694438066; x=1695042866;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xlz6iwTR+P+aX/Li0khE/j1svXvZ2ELJqgA8Sp/LWUg=;
        b=sh4sIVYNo11SMlehKLEzX2cHSANIgYvovvA8tYJlaqhkrnamCeBVGOVPbra0qu9UXF
         KLL/rQNH4ciQB/AJhFxaLf7POVseo6cQtMYxfmLwckilceKHBRUF9qR1gJJJvDJ6M+p9
         yxKHi1SvvlVp7czufdKeCgsS0Lqu9I62rEBOM/e59qtn0FF7uJqUSUn4oYS6gZhObGhn
         hl7ztNW0II/vH9F/6mEXQn1xzf32uECeksaNY3vlMorJSlZzyv4KGmednicliZCFjM0X
         /X3mdgNdM28l7zZbMCdppNwg3/LF5DH3yo6DqcK2zz0JIPMpQ4wlwDkBqTPN2ZxXtNY8
         xnmA==
X-Gm-Message-State: AOJu0YxrPP1CXpsPRcOfvWKyA0tz4672MqJL9MkvLjWrsFY1PlI0AKNH
        7Jc+paRl6O1+KTbeW5kt+Lsplg==
X-Google-Smtp-Source: AGHT+IHi1NjC7YYvhb26l/0B9n9PKoTamfRqC35EE+RVrZTXnpH8uVnn+2cDTnwSP+ZX2QXdmHP+Ow==
X-Received: by 2002:a17:906:1d4:b0:9a2:276d:d83c with SMTP id 20-20020a17090601d400b009a2276dd83cmr8333692ejj.18.1694438066126;
        Mon, 11 Sep 2023 06:14:26 -0700 (PDT)
Received: from sagittarius-a.chello.ie (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id kt8-20020a170906aac800b00988e953a586sm5313648ejb.61.2023.09.11.06.14.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 06:14:25 -0700 (PDT)
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
To:     rfoss@kernel.org, todor.too@gmail.com, bryan.odonoghue@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mchehab@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, sakari.ailus@linux.intel.com,
        andrey.konovalov@linaro.org
Cc:     linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v5 11/17] media: qcom: camss: Allow clocks vfeN vfe_liteN or vfe_lite
Date:   Mon, 11 Sep 2023 14:14:05 +0100
Message-ID: <20230911131411.196033-12-bryan.odonoghue@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
References: <20230911131411.196033-1-bryan.odonoghue@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The number of Video Front End - VFE or Image Front End - IFE supported
with new SoCs can vary both for the full and lite cases.

For example sdm845 has one vfe_lite and two vfe interfaces with the vfe
clock called simply "vfe_lite" with no integer postfix. sc8280xp has four
vfe and four vfe lite blocks.

At the moment we declare vfe_lite0 and vfe_lite1 for sm8250 but never set
those clocks because we don't match the strings.

We need to support the following clock name formats

- vfeN
- vfe_liteN
- vfe_lite

with N being any reasonably sized integer.

There are two sites in this code which need to do the same thing,
constructing and matching strings with the pattern above, so encapsulate
the logic in one function.

Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
---
 drivers/media/platform/qcom/camss/camss-vfe.c | 22 ++++++++++++++-----
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/media/platform/qcom/camss/camss-vfe.c b/drivers/media/platform/qcom/camss/camss-vfe.c
index db8f68819ded9..f3cf387e4907e 100644
--- a/drivers/media/platform/qcom/camss/camss-vfe.c
+++ b/drivers/media/platform/qcom/camss/camss-vfe.c
@@ -431,6 +431,20 @@ void vfe_isr_reset_ack(struct vfe_device *vfe)
 	complete(&vfe->reset_complete);
 }
 
+static int vfe_match_clock_names(struct vfe_device *vfe,
+				 struct camss_clock *clock)
+{
+	char vfe_name[6]; /* vfeXX\0 */
+	char vfe_lite_name[11]; /* vfe_liteXX\0 */
+
+	snprintf(vfe_name, sizeof(vfe_name), "vfe%d", vfe->id);
+	snprintf(vfe_lite_name, sizeof(vfe_lite_name), "vfe_lite%d", vfe->id);
+
+	return (!strcmp(clock->name, vfe_name) ||
+		!strcmp(clock->name, vfe_lite_name) ||
+		!strcmp(clock->name, "vfe_lite"));
+}
+
 /*
  * vfe_set_clock_rates - Calculate and set clock rates on VFE module
  * @vfe: VFE device
@@ -454,9 +468,7 @@ static int vfe_set_clock_rates(struct vfe_device *vfe)
 	for (i = 0; i < vfe->nclocks; i++) {
 		struct camss_clock *clock = &vfe->clock[i];
 
-		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1") ||
-		    !strcmp(clock->name, "vfe_lite")) {
+		if (vfe_match_clock_names(vfe, clock)) {
 			u64 min_rate = 0;
 			long rate;
 
@@ -537,9 +549,7 @@ static int vfe_check_clock_rates(struct vfe_device *vfe)
 	for (i = 0; i < vfe->nclocks; i++) {
 		struct camss_clock *clock = &vfe->clock[i];
 
-		if (!strcmp(clock->name, "vfe0") ||
-		    !strcmp(clock->name, "vfe1") ||
-		    !strcmp(clock->name, "vfe_lite")) {
+		if (vfe_match_clock_names(vfe, clock)) {
 			u64 min_rate = 0;
 			unsigned long rate;
 
-- 
2.42.0

