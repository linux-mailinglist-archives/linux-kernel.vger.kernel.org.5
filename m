Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DACB7F1B5A
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 18:47:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232483AbjKTRrc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 12:47:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjKTRrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 12:47:31 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CE811C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:27 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-40a4848c6e1so15477725e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 09:47:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700502446; x=1701107246; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BPwJyVhhexCZzbUP41lTNUU8tlh1YKVSoA80AxKe1yA=;
        b=hn1cuqKDewPGlGC0CKnX9RcqXiSOllL1UDJOAu6bWGLUMGKDzr58qxV9j8RcajRR/R
         bOLpXs7J/usWMQkByne191vlyDrU8Xxunzv1oKVFb9T8shiZA0guVUOjCSNQcowmCTru
         /DEeq6DVvYaeyTTWvurUc3WRweIOXArnuy+3c/7y7QUMJbIpwPGfWsjw59oqen5fIjVR
         F25AfQhFz13kjwzOKKvM8LPyFPZXvok41RDpPDEmSgkmZId0EfW3akjr8z2pfbZ9tVhu
         mwJpq/VQrAchFoN8CuZ764olktS3/vOO3KT1E9xkk7BzCyxtcta/OfIobdf67iCWxaMP
         vkHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700502446; x=1701107246;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BPwJyVhhexCZzbUP41lTNUU8tlh1YKVSoA80AxKe1yA=;
        b=VdWethUngQ2CO08/qkNeVfRMfOObWhm504LLXmPoGj338P8ZLqmJJCTwM2Tl3nJaB0
         y7O8YFo2eotm7+muUvfd7y+6QOrbMiBY7pYNi0brbEkFWURnrapv2G5noDjUTYJjgvl6
         OgrpClTzGAxCvnV2zW3BtFD+IDgP9S+iDsgCUy17upTv8QVTyqckThm0HPslUiOTcQOa
         dYoS+8ZxVu6bzFYWkSvaTGFVtbDSU2bh3KFUqPtCRzlnHqglTrE/YBV7jq9U3D36FC+o
         K+r7uQRWitGO/5Nqu+ednC7KebhZKdYRnXkSnrRPTcoOL3CvWkU9m6KWZc+EajBmFjGQ
         p8rg==
X-Gm-Message-State: AOJu0YwgevRpbbwPURs1shiEXF8LhLfx57nnDD5WGASiNL97yNqWCfEm
        Z2CUZMD0tOPHwupKdlpdAfatKg==
X-Google-Smtp-Source: AGHT+IHvLU3AHYInt84F0JGn0xDDQmY4uHZG9iBWciPCO/udT9tvcgKRsOjlRVTFcDKUl91guEtcHw==
X-Received: by 2002:a05:600c:4707:b0:40a:6239:39b with SMTP id v7-20020a05600c470700b0040a6239039bmr6589583wmo.21.1700502445681;
        Mon, 20 Nov 2023 09:47:25 -0800 (PST)
Received: from krzk-bin.. ([178.197.222.11])
        by smtp.gmail.com with ESMTPSA id d19-20020adf9b93000000b003316eb9db40sm9595734wrc.51.2023.11.20.09.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 09:47:24 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH] soundwire: stream: constify sdw_port_config when adding devices
Date:   Mon, 20 Nov 2023 18:47:20 +0100
Message-Id: <20231120174720.239610-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

sdw_stream_add_master() and sdw_stream_add_slave() do not modify
contents of passed sdw_port_config, so it can be made const for code
safety and as documentation of expected usage.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/stream.c    | 10 +++++-----
 include/linux/soundwire/sdw.h |  6 +++---
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/soundwire/stream.c b/drivers/soundwire/stream.c
index 69719b335bcb..9dc6399f206a 100644
--- a/drivers/soundwire/stream.c
+++ b/drivers/soundwire/stream.c
@@ -897,7 +897,7 @@ static struct sdw_port_runtime *sdw_port_alloc(struct list_head *port_list)
 }
 
 static int sdw_port_config(struct sdw_port_runtime *p_rt,
-			   struct sdw_port_config *port_config,
+			   const struct sdw_port_config *port_config,
 			   int port_index)
 {
 	p_rt->ch_mask = port_config[port_index].ch_mask;
@@ -970,7 +970,7 @@ static int sdw_slave_port_is_valid_range(struct device *dev, int num)
 
 static int sdw_slave_port_config(struct sdw_slave *slave,
 				 struct sdw_slave_runtime *s_rt,
-				 struct sdw_port_config *port_config)
+				 const struct sdw_port_config *port_config)
 {
 	struct sdw_port_runtime *p_rt;
 	int ret;
@@ -1026,7 +1026,7 @@ static int sdw_master_port_alloc(struct sdw_master_runtime *m_rt,
 }
 
 static int sdw_master_port_config(struct sdw_master_runtime *m_rt,
-				  struct sdw_port_config *port_config)
+				  const struct sdw_port_config *port_config)
 {
 	struct sdw_port_runtime *p_rt;
 	int ret;
@@ -1861,7 +1861,7 @@ EXPORT_SYMBOL(sdw_release_stream);
  */
 int sdw_stream_add_master(struct sdw_bus *bus,
 			  struct sdw_stream_config *stream_config,
-			  struct sdw_port_config *port_config,
+			  const struct sdw_port_config *port_config,
 			  unsigned int num_ports,
 			  struct sdw_stream_runtime *stream)
 {
@@ -1981,7 +1981,7 @@ EXPORT_SYMBOL(sdw_stream_remove_master);
  */
 int sdw_stream_add_slave(struct sdw_slave *slave,
 			 struct sdw_stream_config *stream_config,
-			 struct sdw_port_config *port_config,
+			 const struct sdw_port_config *port_config,
 			 unsigned int num_ports,
 			 struct sdw_stream_runtime *stream)
 {
diff --git a/include/linux/soundwire/sdw.h b/include/linux/soundwire/sdw.h
index 4f3d14bb1538..904004d8b562 100644
--- a/include/linux/soundwire/sdw.h
+++ b/include/linux/soundwire/sdw.h
@@ -1040,7 +1040,7 @@ int sdw_compute_params(struct sdw_bus *bus);
 
 int sdw_stream_add_master(struct sdw_bus *bus,
 		struct sdw_stream_config *stream_config,
-		struct sdw_port_config *port_config,
+		const struct sdw_port_config *port_config,
 		unsigned int num_ports,
 		struct sdw_stream_runtime *stream);
 int sdw_stream_remove_master(struct sdw_bus *bus,
@@ -1062,7 +1062,7 @@ void sdw_extract_slave_id(struct sdw_bus *bus, u64 addr, struct sdw_slave_id *id
 
 int sdw_stream_add_slave(struct sdw_slave *slave,
 			 struct sdw_stream_config *stream_config,
-			 struct sdw_port_config *port_config,
+			 const struct sdw_port_config *port_config,
 			 unsigned int num_ports,
 			 struct sdw_stream_runtime *stream);
 int sdw_stream_remove_slave(struct sdw_slave *slave,
@@ -1084,7 +1084,7 @@ int sdw_update_no_pm(struct sdw_slave *slave, u32 addr, u8 mask, u8 val);
 
 static inline int sdw_stream_add_slave(struct sdw_slave *slave,
 				       struct sdw_stream_config *stream_config,
-				       struct sdw_port_config *port_config,
+				       const struct sdw_port_config *port_config,
 				       unsigned int num_ports,
 				       struct sdw_stream_runtime *stream)
 {
-- 
2.34.1

