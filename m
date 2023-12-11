Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8883A80D4A1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345221AbjLKRwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:52:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjLKRvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:51:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE60139;
        Mon, 11 Dec 2023 09:51:09 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-50bfd7be487so5404582e87.0;
        Mon, 11 Dec 2023 09:51:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702317067; x=1702921867; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=U1YDTnus4TPxjUF248/sdbNAm7YGCStl7FgqnfZm760=;
        b=HvQLV7n0+0kL/JkTnuruE2QH57SRtUBKq23ypn64xAT4uCP41PoWG6JE2M/pQKWg70
         WUPQwJ+/R5dxsLkx3nScegHTWcGqDnNhTG37g59LXT+19QS13Y52f5jvZ6D/mT/XTXZR
         X5khxPJNsPpad5cIHWC2LOVuKbaytE6q09z8OE5K2k5FJdSbXbkd1z7M0wNaL8/uGgiL
         xNZZ3aep/hCyMAahsq1aWLGoSBQFQmdYX8KRZhh559sj2otiO9FHZGCq+2iuCjTT4xuO
         xlthv1YwJnybr/G+ZnlizzUz7GpLcuPVq1f1YBT+/ES6Sn/jMnCNx4pztpDj5rFXzq+U
         cUbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702317067; x=1702921867;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=U1YDTnus4TPxjUF248/sdbNAm7YGCStl7FgqnfZm760=;
        b=iywDbUfYCaFIoNmC23gbarIxewmP7HIXrP5JIv4+Bk3Tt+hOeDwK0/TX+UVnzR/jQK
         5FY/3BCw//A2ZGDC6gcDQ3LHPDavRVNztFCWwEd7uKPVM89aGC/1K80zWWlsumJXI3tC
         neR2kfODxukqlEuVK8144f7UeNJcCq0/CR0JMdrFCtI7+5tsUFfYDTbmBdLFrLi105wQ
         cQPmsL3Y6KZcR6NHAu+tyrAoY5k1kcQgXkMR1o3X3uPtMq7EwINzbnplHKQRft7850EC
         CFTMznCLU3YSm+q1HuO80/AwC4TRXNDUIP7kPPJLVe2zmG/dJmf+L0vHBTsH9HaEVGRh
         UCOg==
X-Gm-Message-State: AOJu0YxFYUsg5TB2BviCcac6ESfqDvt6ELIQLlzZM2XowUcYxrTcqPek
        VBYLbfE1+UVi+oyBHyDe017qgh9zrM668vFI
X-Google-Smtp-Source: AGHT+IG5BOp7VhvgRqCCYsmBh67jrm30a3uHAg9k3J7ENktQbN1mhSViUaSYms+UtGpROgyofNGY2w==
X-Received: by 2002:a05:6512:3112:b0:50b:fda6:9135 with SMTP id n18-20020a056512311200b0050bfda69135mr1973338lfb.101.1702317066908;
        Mon, 11 Dec 2023 09:51:06 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id v25-20020ac25939000000b0050bef1c5b39sm1153777lfi.61.2023.12.11.09.51.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 09:51:06 -0800 (PST)
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Tommaso Merciai <tommaso.merciai@amarulasolutions.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH 18/19] media: i2c: ov4689: Refactor ov4689_s_stream
Date:   Mon, 11 Dec 2023 20:50:21 +0300
Message-ID: <20231211175023.1680247-19-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231211175023.1680247-1-mike.rudenko@gmail.com>
References: <20231211175023.1680247-1-mike.rudenko@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove repetitive pm_runtime_put calls in ov4689_s_stream function,
and call pm_runtime_put once at the end of the "on" branch if any
error occurred.

Signed-off-by: Mikhail Rudenko <mike.rudenko@gmail.com>
---
 drivers/media/i2c/ov4689.c | 29 ++++++++++-------------------
 1 file changed, 10 insertions(+), 19 deletions(-)

diff --git a/drivers/media/i2c/ov4689.c b/drivers/media/i2c/ov4689.c
index e21527ae0b10..034bd9077a3a 100644
--- a/drivers/media/i2c/ov4689.c
+++ b/drivers/media/i2c/ov4689.c
@@ -555,35 +555,26 @@ static int ov4689_s_stream(struct v4l2_subdev *sd, int on)
 					  ov4689_common_regs,
 					  ARRAY_SIZE(ov4689_common_regs),
 					  NULL);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = ov4689_setup_timings(ov4689, sd_state);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = ov4689_setup_blc_anchors(ov4689, sd_state);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = __v4l2_ctrl_handler_setup(&ov4689->ctrl_handler);
-		if (ret) {
-			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
+		if (ret)
+			goto cleanup_pm;
 
 		ret = cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 				OV4689_MODE_STREAMING, NULL);
-		if (ret) {
+cleanup_pm:
+		if (ret)
 			pm_runtime_put(dev);
-			goto unlock_and_return;
-		}
 	} else {
 		cci_write(ov4689->regmap, OV4689_REG_CTRL_MODE,
 			  OV4689_MODE_SW_STANDBY, NULL);
-- 
2.43.0

