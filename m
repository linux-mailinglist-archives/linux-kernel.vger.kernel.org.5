Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7BB67D8D4D
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 05:05:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjJ0DFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 23:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbjJ0DFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 23:05:09 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD58129
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:05:07 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-1cacf449c1aso3081415ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 20:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quanta-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1698375907; x=1698980707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W03Y8lFBgksp4nZkRCf2tWXHM6a0g6coXGTRRAurfQs=;
        b=CLGIwo9Pt88zCK2YGh7800sb8rooFvpKLATeODP90eTS5lFV7on0tLkOEHTUd47Ej3
         8KMm1/3sbNnKAk97WFTd2SAEqTfW6V9CykZsqyCYC/Xcg7R4yNo1Fb7W+xG2EstiImOT
         K7Y/PdcDKtt0m6TLXM3wFRtsnKE/rp8woup3rfp04hhn9VdrzFpLVYJWMG4fEOtNYN6w
         kZyosBhFsDxG9B/HAu/+LzmnOX8+09ENposFLHe6Zi0snAiZbbzqTndMS+3+w7LFsl5r
         vIa8oLlCRK9H18lCWGHXR+PBW5esblyljukIGzbTtAPu3M6t0GAaPveXQjilwPArb4a+
         oJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698375907; x=1698980707;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W03Y8lFBgksp4nZkRCf2tWXHM6a0g6coXGTRRAurfQs=;
        b=cHw7WPlIMhLLHC+1SDdRcsrwJdcfPMD/WP3aejRMUG4zzmTOhusGqtc40dR7cwBWKD
         ConwCZzFWJnx/BfWIgPXLHTz56L6QnpgxDdp+Gx3haCe6GufRRdehHexD/vRV35g46cH
         i5svjkIzjnrc4x1CWaA1wMw8pCLw5pzAxT/f1yNZNxtQUKSxWzB0ymCnPkdK3e3tpPje
         SKRYHSWuadO/qyh9ZXM/40/igVUBe8EsoOSWtdwfyL4Q4M5CyQPWF4jqOB8W8bW7L189
         1ZljUPfGVmeZOcwUvibF7A8QXYwTKYMRS7h+dkvplzFl8DuR8lbf7v383Fv8ucP9Z+pb
         KixA==
X-Gm-Message-State: AOJu0YwM4gfpp5sMQxTfG6qIA3wiM+JcdugKrOob8I2GLm+H3nyGwDf+
        RTBwc6hvUp76I7d+zUeWRjr165eLTr1jIpMsio7mdQ==
X-Google-Smtp-Source: AGHT+IGcvKHk/AFqkD/tlUI6koT0Yo2gHCM03/iP03ms+DONAkcKud1bMM9d3ud2JrcOKbws/jrOoA==
X-Received: by 2002:a05:6a20:4281:b0:163:d382:ba99 with SMTP id o1-20020a056a20428100b00163d382ba99mr1931238pzj.5.1698375906700;
        Thu, 26 Oct 2023 20:05:06 -0700 (PDT)
Received: from liang-Predator-PH517-52.. (60-250-232-247.hinet-ip.hinet.net. [60.250.232.247])
        by smtp.gmail.com with ESMTPSA id b21-20020a170902ed1500b001c74876f032sm396865pld.162.2023.10.26.20.05.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Oct 2023 20:05:06 -0700 (PDT)
From:   Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     dianders@chromium.org,
        Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH] drm/panel-edp: Add panel entry for AUO B116XTN02 and BOE NT116WHM-N21,836X2 and NV116WHM-N49 V8.0
Date:   Fri, 27 Oct 2023 11:04:56 +0800
Message-Id: <20231027110435.1.Ia01fe9ec1c0953e0050a232eaa782fef2c037516@changeid>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add panel identification entry for
- AUO B116XTN02 family (product ID:0x235c)
- BOE NT116WHM-N21,836X2 (product ID:0x09c3)
- BOE NV116WHM-N49 V8.0 (product ID:0x0979)

Signed-off-by: Sheng-Liang Pan <sheng-liang.pan@quanta.corp-partner.google.com>
---

 drivers/gpu/drm/panel/panel-edp.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 95c8472d878a..5bf28c8443ef 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -1840,6 +1840,7 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x145c, &delay_200_500_e50, "B116XAB01.4"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1e9b, &delay_200_500_e50, "B133UAN02.1"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x1ea5, &delay_200_500_e50, "B116XAK01.6"),
+	EDP_PANEL_ENTRY('A', 'U', 'O', 0x235c, &delay_200_500_e50, "B116XTN02"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x405c, &auo_b116xak01.delay, "B116XAK01"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x582d, &delay_200_500_e50, "B133UAN01.0"),
 	EDP_PANEL_ENTRY('A', 'U', 'O', 0x615c, &delay_200_500_e50, "B116XAN06.1"),
@@ -1848,8 +1849,10 @@ static const struct edp_panel_entry edp_panels[] = {
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0786, &delay_200_500_p2e80, "NV116WHM-T01"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x07d1, &boe_nv133fhm_n61.delay, "NV133FHM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x082d, &boe_nv133fhm_n61.delay, "NV133FHM-N62"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09c3, &delay_200_500_e50, "NT116WHM-N21,836X2"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x094b, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x095f, &delay_200_500_e50, "NE135FBM-N41 v8.1"),
+	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0979, &delay_200_500_e50, "NV116WHM-N49 V8.0"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x098d, &boe_nv110wtm_n61.delay, "NV110WTM-N61"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x09dd, &delay_200_500_e50, "NT116WHM-N21"),
 	EDP_PANEL_ENTRY('B', 'O', 'E', 0x0a5d, &delay_200_500_e50, "NV116WHM-N45"),
-- 
2.34.1

