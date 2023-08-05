Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BECEA770E8E
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 09:51:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbjHEHv3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 03:51:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjHEHv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 03:51:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138754ED0
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 00:51:25 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so8281557a12.1
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 00:51:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691221883; x=1691826683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qo01VZv46WbWZeQUoDu+eNXSK4QNZCobvRPShRBmW3A=;
        b=eFa/+pdZy12eq7uhOk6oj8lqvgCn7Ccc2eymJdN9wZhYSADZd8x6/6x2r1uWtvr275
         nyWcYMIKSTfIBpD31rf1i1b8J5jyywnbJeRYabxqSCY3j4Y3ndQZmv3frI4wf5/7f54x
         oPSjlE3KIgZ59NjdIlXI/XvfMMOrxlM8gGh+LfYqQHR3qkSBHrL9XQR8wwHYQyYUlYoA
         dPuQP3yA8Fqb8Dd5vbDrbOzpO1uTVyd3cDeOMNRQTeAlpzW52ysHL/SNGq6b65iJj2MT
         wGTflgu6ROT5KHYPu0mIZKZn1s1o51tdEzuv71ijYEjyJ46xFD+a3oHdg3Akhf7bYqMj
         C3yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691221883; x=1691826683;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qo01VZv46WbWZeQUoDu+eNXSK4QNZCobvRPShRBmW3A=;
        b=WjyJKUL9Ur7UqXCJNwvFGF0CdCriITJX+CMIUeRCKYj5edQ+SDDhBNDvHJ/xvB4Hg1
         YFPNFHQddlDJ9HUSGd9ym0nqZlkO2O27oA/SK7Tjok7nuUd/CdBNYsWjg04tsIUueOiq
         d6oDJr1jAXB9FGaqj4IjlQ5j4ebUID8IOU43LQVIEEAPOHXAn+DbEvXelTvM9CKZzfp6
         B1dtUwy7fMMuGk2yOCvEo0F4F1j7VKaBVeN31uqdfY8YIZ142YXHGuvClPu3ldSLyOJW
         ZGlOGTyX8nLKRqvEtD7e0FF6Yfpx8OmFeK+6rY8JvV1fPY7/t5c1ryhJXztZk53FzILQ
         bZUQ==
X-Gm-Message-State: AOJu0YxMezmPfl+1se94GdfXeNJbLfz5GYX4gedAO2swRFAI/aeaZpGs
        wJMBPrWs2DLocUVPwS2jkx0=
X-Google-Smtp-Source: AGHT+IEdLfKGC4Ymsl5AtF+aEqvdXaiMMHCh98KsjWyPo5aFKy+g6+j686PwFwGNtNXMIIoJq8sAzg==
X-Received: by 2002:a17:907:7f91:b0:99c:572:c0e4 with SMTP id qk17-20020a1709077f9100b0099c0572c0e4mr2255590ejc.7.1691221883217;
        Sat, 05 Aug 2023 00:51:23 -0700 (PDT)
Received: from localhost.localdomain ([95.90.187.185])
        by smtp.gmail.com with ESMTPSA id o17-20020a17090611d100b0099bd0b5a2bcsm2379716eja.101.2023.08.05.00.51.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Aug 2023 00:51:23 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH] staging: rtl8192e: prefer strscpy over strncpy
Date:   Sat,  5 Aug 2023 09:51:14 +0200
Message-ID: <20230805075114.15186-1-straube.linux@gmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Replace strncpy with strscpy in two places where the destination buffer
should be NUL-terminated. Found by checkpatch.

WARNING: Prefer strscpy, strscpy_pad, or __nonstring over strncpy - see: https://github.com/KSPP/linux/issues/90

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/rtl8192e/rtllib_softmac.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8192e/rtllib_softmac.c b/drivers/staging/rtl8192e/rtllib_softmac.c
index 0e52b207942d..bd19d6a2ce41 100644
--- a/drivers/staging/rtl8192e/rtllib_softmac.c
+++ b/drivers/staging/rtl8192e/rtllib_softmac.c
@@ -1564,7 +1564,7 @@ inline void rtllib_softmac_new_net(struct rtllib_device *ieee,
 				    (!strncmp(ieee->current_network.ssid,
 				    net->hidden_ssid, net->hidden_ssid_len));
 			if (net->hidden_ssid_len > 0) {
-				strncpy(net->ssid, net->hidden_ssid,
+				strscpy(net->ssid, net->hidden_ssid,
 					net->hidden_ssid_len);
 				net->ssid_len = net->hidden_ssid_len;
 				ssidbroad = 1;
@@ -2431,7 +2431,7 @@ static void rtllib_start_master_bss(struct rtllib_device *ieee)
 	ieee->assoc_id = 1;
 
 	if (ieee->current_network.ssid_len == 0) {
-		strncpy(ieee->current_network.ssid,
+		strscpy(ieee->current_network.ssid,
 			RTLLIB_DEFAULT_TX_ESSID,
 			IW_ESSID_MAX_SIZE);
 
-- 
2.41.0

