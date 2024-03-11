Return-Path: <linux-kernel+bounces-98885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF4968780AA
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 14:32:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462241F22BB8
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 13:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC0813D961;
	Mon, 11 Mar 2024 13:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b="XAH33kDO"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 070762E3F7
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 13:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710163963; cv=none; b=Cx+ZHUelrgwTUL3WDGKf6YxLuXtTC62rCP8mF6KdR7b/fXl+GGtOMG27Ai6GTiGqzV4j8oGHWGfa2Cxuu4pF5+TurmnotKIOHXPu+QsedPOHJVOrlgXDpleSDYPI07ufGG1eowwj37MJicOKOGLRaNhwHEnTK/RX8ZjBt3DfD7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710163963; c=relaxed/simple;
	bh=I9l/m9/sESJzPfg9zL5RZnfr9QHcIOTJ6oQii+l25rY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=C1rx5XjkQG0uf//hf6ioVTCL1ABi0VVd6B92p8Wdj7ZjAqFZRCIVhNodW2YBD4PjyadiMlmQO77Iak4/WNvU0pcdjMWDPkFSLntjI676NhisczByyjOwlgjS7snDFRwFHeggePzE805nZodLj0RWJYSlwFeF9h5wkvO05C+5M0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com; spf=pass smtp.mailfrom=ionos.com; dkim=pass (2048-bit key) header.d=ionos.com header.i=@ionos.com header.b=XAH33kDO; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ionos.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ionos.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so44963481fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 06:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ionos.com; s=google; t=1710163958; x=1710768758; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=pydvit0k5bF0u99aS8RvUteGFoApwP4u2/5qle+X0TE=;
        b=XAH33kDOGKjIkkMWTaSJzO6Mhwfmgmbt/FrNLgzIOUtpiMwgd2esnCicK87qvQwnIs
         +eheJiHvrjYhEN6QZRDPgQ9zSGkgHxeqhNVoMfk8EWqtHEQEjiZbbc0t5QPE9uobOp/w
         ZOIxpqHtBaa5wRTGKOp6bg6ia6XY+XX0JUrGFZaZliTA4AueYhGJBHpmhZpJZSFkMcks
         TQ2bqfI9X5NrBkZTmlSE7V7SmVitUfbH2xoXC7DabjMQ9TFLCmbfb+DE7S7vh9RJNwzN
         0Biwg8wOcMxG6srMUtFUXuvUz6LQVMya1qB5oOoVhCTZxL3MRKHJPM8ptWixufbWW1pt
         EJ8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710163958; x=1710768758;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pydvit0k5bF0u99aS8RvUteGFoApwP4u2/5qle+X0TE=;
        b=L6jGS+HEihhle80VM9f8CF0YgKqmGbsvBsQ57W7Hu5prPBuR8F24pnwoNCAtlhbFwk
         s++D8SLPYznHRqUt92iNyLqeuSB26K3E1oBzlIvsKehZh83SYxXNQpU+vHfC/5+u7g5t
         y6832OtUEft1007hZJjp18bOp1cRuxOks+fjPky+HWKOEiPTnNlKcrPuxut1HJetNjBs
         /at3YkWzmBtwdxGnOYfIPIZqkX7VqwbtGquoCNdangsk5g8exEk0wLfk3JFrmR8gLo2o
         K+4DuEcNI3JgK0hyDtsvjC8gDXOtosxF8rHxLGIwISf8BbgJnlqzwOSKRRTnaiJKkese
         gkeA==
X-Forwarded-Encrypted: i=1; AJvYcCWAWIjGI4fIMQRI6RfQcldL7BqcB56yz06Bb2WNGrGBClsZ1HUderuqOIrpQMZ3FmIDD+XyfROcWekrkl+ehyyUtFiSV7onyFvrMYyl
X-Gm-Message-State: AOJu0Yxcu51Zyf+xzzM/V2Ep597Te/6q6Io7mQ4WlXdXO7YhgQWkNgJq
	8/8n5mHvoYPBI/LZKJ6h74sp7YjGA3mFPUKMWrRZq/sFbp0K+KUO0EeDLM0FQtM=
X-Google-Smtp-Source: AGHT+IF4nCfaEVZ8lezh+TtTa3vRsYojgVPmHkyqd40yjAWy8wmDLzK2Zs88Hh7EVVZHr3pmvPpnGg==
X-Received: by 2002:a2e:8058:0:b0:2d2:a839:a39a with SMTP id p24-20020a2e8058000000b002d2a839a39amr4359305ljg.5.1710163958137;
        Mon, 11 Mar 2024 06:32:38 -0700 (PDT)
Received: from raven.blarg.de (p200300dc6f010900023064fffe740809.dip0.t-ipconnect.de. [2003:dc:6f01:900:230:64ff:fe74:809])
        by smtp.gmail.com with ESMTPSA id p3-20020a17090628c300b00a444526962asm2861953ejd.128.2024.03.11.06.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 06:32:37 -0700 (PDT)
From: Max Kellermann <max.kellermann@ionos.com>
To: linus.walleij@linaro.org,
	brgl@bgdev.pl,
	linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Max Kellermann <max.kellermann@ionos.com>
Subject: [PATCH] drivers/gpio/nomadik: move dummy nmk_gpio_dbg_show_one() to header
Date: Mon, 11 Mar 2024 14:32:23 +0100
Message-Id: <20240311133223.3429428-1-max.kellermann@ionos.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When `CONFIG_DEBUG_FS` is disabled, nmk_gpio_dbg_show_one() is an
empty dummy function; this however triggers a `-Wmissing-prototypes`
warning and later a linker error because the function is also used by
drivers/pinctrl/nomadik/pinctrl-nomadik.c, therefore it needs to be
non-static.

To allow both sources to access this dummy function, this patch moves
it to the header, adding the `#ifdef CONFIG_DEBUG_FS` there as well.

Signed-off-by: Max Kellermann <max.kellermann@ionos.com>
---
 drivers/gpio/gpio-nomadik.c       |  8 --------
 include/linux/gpio/gpio-nomadik.h | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/drivers/gpio/gpio-nomadik.c b/drivers/gpio/gpio-nomadik.c
index 463a765620dc..9637ede8ab43 100644
--- a/drivers/gpio/gpio-nomadik.c
+++ b/drivers/gpio/gpio-nomadik.c
@@ -486,14 +486,6 @@ static void nmk_gpio_dbg_show(struct seq_file *s, struct gpio_chip *chip)
 
 #else
 
-static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
-					 struct pinctrl_dev *pctldev,
-					 struct gpio_chip *chip,
-					 unsigned int offset,
-					 unsigned int gpio)
-{
-}
-
 #define nmk_gpio_dbg_show	NULL
 
 #endif
diff --git a/include/linux/gpio/gpio-nomadik.h b/include/linux/gpio/gpio-nomadik.h
index 4a95ea7935fb..b5a84864650d 100644
--- a/include/linux/gpio/gpio-nomadik.h
+++ b/include/linux/gpio/gpio-nomadik.h
@@ -253,6 +253,8 @@ nmk_pinctrl_db8540_init(const struct nmk_pinctrl_soc_data **soc)
 
 struct platform_device;
 
+#ifdef CONFIG_DEBUG_FS
+
 /*
  * Symbols declared in gpio-nomadik used by pinctrl-nomadik. If pinctrl-nomadik
  * is enabled, then gpio-nomadik is enabled as well; the reverse if not always
@@ -261,6 +263,19 @@ struct platform_device;
 void nmk_gpio_dbg_show_one(struct seq_file *s, struct pinctrl_dev *pctldev,
 			   struct gpio_chip *chip, unsigned int offset,
 			   unsigned int gpio);
+
+#else
+
+static inline void nmk_gpio_dbg_show_one(struct seq_file *s,
+					 struct pinctrl_dev *pctldev,
+					 struct gpio_chip *chip,
+					 unsigned int offset,
+					 unsigned int gpio)
+{
+}
+
+#endif
+
 void __nmk_gpio_make_output(struct nmk_gpio_chip *nmk_chip,
 			    unsigned int offset, int val);
 void __nmk_gpio_set_slpm(struct nmk_gpio_chip *nmk_chip, unsigned int offset,
-- 
2.39.2


