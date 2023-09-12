Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00E979CF14
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 13:01:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234496AbjILLBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 07:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234538AbjILLAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 07:00:07 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD247173D
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:00:01 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-3a88ef953adso4248697b6e.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 04:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=huaqin-corp-partner-google-com.20230601.gappssmtp.com; s=20230601; t=1694516401; x=1695121201; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CMG6a3B9JSS3bDoYC2nmmUP21A8iJCDZj6ACi+jsAKs=;
        b=MvvUzfvH/n43nqJMUc1RdUap2btZowlv+rShSrevV2Em1ciXh416zuhzpblbexvBfq
         wLExweAXu41DM2sqwjHh1dxL1gI9C4blO6uvgpnbQ41sNg6fGCbKoroFEcxw6/m98Sbz
         fecA2rfeA3JjfE5fMgnq8upGSc7Qzixv3Pp+f2RZGTBz2/D0TAdFPr6tldD1qxl0zZ8b
         IRzdwKxupWsRO9oUdhLzYH4hG5yPQF21OBODJ1gZ47DK6p7xiBsg0C3fcZO/ZvGw0K1Y
         QdRDS0SeT0lFT5KQVSNm+C2pIXDBDub/3YSNv5WpJwwm+A/PFq1IbEx1sHD801N8gGK0
         Aojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694516401; x=1695121201;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CMG6a3B9JSS3bDoYC2nmmUP21A8iJCDZj6ACi+jsAKs=;
        b=gCZ8e5dE5QLOkZruPmi3iDr/h+p4cCXGCydVPwH1XboGCHyFdTLT2BA5u3zvfETGxQ
         JXPoyRxJseASL+O53DtpjXy7Lfb2PtcweNBPjhjSBJAYOyIHI66JN4HOJPHwGVWwXDK/
         KxsvGzE1bBIABs2VzXmmvIzOFyiPkDlEAWk0aLlIE7L+bnmc9EeY70eNuXlRqZ8mOM6/
         sG5giVx3MB0U2EO3jdmR1XwihhyXdMUmAaAQD1SkxE3OFjKdsyZWFO/TlzF/9WJaF+NY
         WVq4spCz0J9oIgyPj/eEowFlL+RjTO2DBarBrmObCJVQES6qfuCtTXk73Y/skAhhZwe9
         wHJg==
X-Gm-Message-State: AOJu0Yx2MWZ5xM7XWXa0fIrtqhhEB6ZoOpoIRlFsZHf5w119cOtdRd0C
        f2j8C1RC+kXE9zW8hROu6B8whQ==
X-Google-Smtp-Source: AGHT+IEkeRwFiCQH+Swyjb4qUbEnJQs4OMbOm03U1v1iQAiCUcYftTwKwbLjw/peAKOmWRxHIkyczQ==
X-Received: by 2002:aca:f0a:0:b0:3a7:7d4:4f91 with SMTP id 10-20020aca0f0a000000b003a707d44f91mr13458976oip.14.1694516401274;
        Tue, 12 Sep 2023 04:00:01 -0700 (PDT)
Received: from chromeos.huaqin.com ([101.78.151.205])
        by smtp.gmail.com with ESMTPSA id w20-20020a63af14000000b00577ae8ad823sm760255pge.80.2023.09.12.03.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Sep 2023 04:00:00 -0700 (PDT)
From:   Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
To:     neil.armstrong@linaro.org, quic_jesszhan@quicinc.com,
        sam@ravnborg.org, airlied@gmail.com, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        linus.walleij@linaro.org,
        Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
Subject: [PATCH] drm/panel: boe-tv101wum-nl6: Completely Pull GPW to VGL before TP term
Date:   Tue, 12 Sep 2023 18:59:32 +0800
Message-Id: <20230912105932.16618-1-zhouruihai@huaqin.corp-partner.google.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The sta_himax83102 panel sometimes shows abnormally flickering
horizontal lines. The front gate output will precharge the X point of
the next pole circuit before TP(TouchPanel Enable) term starts, and wait
until the end of the TP term to resume the CLK. For this reason, the X
point must be maintained during the TP term. In abnormal case, we
measured a slight leakage at point X. This because during the TP term,
the GPW does not fully pull the VGL low, causing the TFT to not be
closed tightly.

To fix this, we completely pull GPW to VGL before entering the TP term.
This will ensure that the TFT is closed tightly and prevent the abnormal
display.

Signed-off-by: Ruihai Zhou <zhouruihai@huaqin.corp-partner.google.com>
---
This patch base on original fixes series [1]
[1] https://patchwork.kernel.org/project/dri-devel/cover/20230703-fix-boe-tv101wum-nl6-v3-0-bd6e9432c755@linaro.org/
---
 drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index c2ee2c6b4150..e37b9b4f528d 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -1305,9 +1305,8 @@ static int starry_himax83102_j02_init(struct mipi_dsi_device *dsi)
 	mipi_dsi_dcs_write_seq(dsi, 0xB1, 0x01, 0xBF, 0x11);
 	mipi_dsi_dcs_write_seq(dsi, 0xCB, 0x86);
 	mipi_dsi_dcs_write_seq(dsi, 0xD2, 0x3C, 0xFA);
-	mipi_dsi_dcs_write_seq(dsi, 0xE9, 0xC5);
-	mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x00, 0x00, 0x00, 0x00, 0x80, 0x0C, 0x01);
-	mipi_dsi_dcs_write_seq(dsi, 0xE9, 0x3F);
+	mipi_dsi_dcs_write_seq(dsi, 0xD3, 0x00, 0x00, 0x44, 0x00, 0x00, 0x00, 0x00, 0x00, 0x80,
+			       0x0C, 0x01);
 	mipi_dsi_dcs_write_seq(dsi, 0xE7, 0x02, 0x00, 0x28, 0x01, 0x7E, 0x0F, 0x7E, 0x10, 0xA0,
 			       0x00, 0x00, 0x20, 0x40, 0x50, 0x40);
 	mipi_dsi_dcs_write_seq(dsi, 0xBD, 0x02);
-- 
2.17.1

