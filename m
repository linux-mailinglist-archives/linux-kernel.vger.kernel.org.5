Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D527A3EAE
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 00:41:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239543AbjIQWlG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 18:41:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235283AbjIQWkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 18:40:42 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D5D512B;
        Sun, 17 Sep 2023 15:40:37 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-401ec23be82so41938855e9.0;
        Sun, 17 Sep 2023 15:40:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694990435; x=1695595235; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gCq7gxZ6dHwUyWczpY7Vh5cbaVAZn1kPig1Zw4rFZSA=;
        b=c3gWT+ktkGFTAsvVOZqhzvIAYGwF0xff0TI/tiBaHCNA7vazqV8/L27g2EaeMjg/aK
         3NTGmqVBnQaxqOomdOmrLGTyVfj7eDQZgZvdqg+MXT2+J0pKSt2KQGYifZ4P5O2NqH9N
         5axvBr/eVnl6T+3PfiRS3zvp90aAY26AwNx+A79wpp9WH8FzpVleuI1AGNdled55l9eO
         OPwjK3u2W+bjfz4hCmcT05+aQ4T9V9AH7WgtvHo3y1whLZjtiMme5iH1YhzgLHiaOY6R
         j8d0/GTO9oGJFfLFOUvCSqVLnIuQ6KMhYYWXCL4eCmNObAS+UiszRuytendi60ww9SeW
         fnyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694990435; x=1695595235;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCq7gxZ6dHwUyWczpY7Vh5cbaVAZn1kPig1Zw4rFZSA=;
        b=GpC49hf3RaUZOiJolYwihUaFW9kkuG/5i4Y+c4BybYMsB3S8qJY5cxLmWHmT5LiLan
         IDXzbg/yMCOVgf1dzd2p7qUyr9OatxEookUnFkVGFCAXUQdgv0cjcMcAjSmqpvXRe8EG
         GQ82byVUtY5NFSNxYAHcygDT5cfs5Q12e7eVLAw8S/8KaNVkxbDyzklwawvCU/iT/8d1
         8VjsfTsUnnIWVav3rL9OTc6fw69NewtSziAcLimQtKbA3niYZrjJNbKbgHqNKeNLY5LR
         7IuASN1CV/r3C5mCwwX5j9sTO/YI3V2k22PAv0ZaGjQh0CgZg9WODY3dlsNEvcUgtCfT
         nIcw==
X-Gm-Message-State: AOJu0YxCW3X7LRuNogG1nI4GuZSICqHz7OdCDBo8y6oRn/vTlhVVnvbi
        zYa2p5CRnvCdBYfbXGmfIb4=
X-Google-Smtp-Source: AGHT+IE9Gpa9OGGS1u8fMnQqhz/589mtCuJtM8X+qAmxlIvQ+ije0qLFWk06/6xK0LIv4W/DRv7WnA==
X-Received: by 2002:a05:600c:21d7:b0:3fe:d1e9:e6b8 with SMTP id x23-20020a05600c21d700b003fed1e9e6b8mr6261880wmj.12.1694990435584;
        Sun, 17 Sep 2023 15:40:35 -0700 (PDT)
Received: from [127.0.1.1] ([91.230.2.244])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003fe2b081661sm13642931wmc.30.2023.09.17.15.40.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 15:40:35 -0700 (PDT)
From:   Benjamin Bara <bbara93@gmail.com>
Date:   Mon, 18 Sep 2023 00:40:01 +0200
Subject: [PATCH 05/13] clk: keep track of the trigger of an ongoing
 clk_set_rate
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230918-imx8mp-dtsi-v1-5-1d008b3237c0@skidata.com>
References: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
In-Reply-To: <20230918-imx8mp-dtsi-v1-0-1d008b3237c0@skidata.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Abel Vesa <abelvesa@kernel.org>, Peng Fan <peng.fan@nxp.com>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Benjamin Bara <benjamin.bara@skidata.com>

When we keep track of the rate change trigger, we can easily check if an
affected clock is affiliated with the trigger. Additionally, the trigger
is added to the notify data, so that drivers can implement workarounds
that might be necessary if a shared parent changes.

Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
---
 drivers/clk/clk.c   | 12 ++++++++++++
 include/linux/clk.h |  2 ++
 2 files changed, 14 insertions(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index 4954d31899ce..8f4f92547768 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -33,6 +33,9 @@ static struct task_struct *enable_owner;
 static int prepare_refcnt;
 static int enable_refcnt;
 
+/* responsible for ongoing rate change, protected by prepare_lock */
+static struct clk *rate_trigger_clk;
+
 static HLIST_HEAD(clk_root_list);
 static HLIST_HEAD(clk_orphan_list);
 static LIST_HEAD(clk_notifier_list);
@@ -1742,6 +1745,7 @@ static int __clk_notify(struct clk_core *core, unsigned long msg,
 
 	cnd.old_rate = old_rate;
 	cnd.new_rate = new_rate;
+	cnd.trigger = rate_trigger_clk ? : core->parent->hw->clk;
 
 	list_for_each_entry(cn, &clk_notifier_list, node) {
 		if (cn->clk->core == core) {
@@ -2513,6 +2517,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
+	rate_trigger_clk = clk;
+
 	if (clk->exclusive_count)
 		clk_core_rate_unprotect(clk->core);
 
@@ -2521,6 +2527,8 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
 	if (clk->exclusive_count)
 		clk_core_rate_protect(clk->core);
 
+	rate_trigger_clk = NULL;
+
 	clk_prepare_unlock();
 
 	return ret;
@@ -2556,6 +2564,8 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 	/* prevent racing with updates to the clock topology */
 	clk_prepare_lock();
 
+	rate_trigger_clk = clk;
+
 	/*
 	 * The temporary protection removal is not here, on purpose
 	 * This function is meant to be used instead of clk_rate_protect,
@@ -2568,6 +2578,8 @@ int clk_set_rate_exclusive(struct clk *clk, unsigned long rate)
 		clk->exclusive_count++;
 	}
 
+	rate_trigger_clk = NULL;
+
 	clk_prepare_unlock();
 
 	return ret;
diff --git a/include/linux/clk.h b/include/linux/clk.h
index 06f1b292f8a0..f0fe78c7a0f1 100644
--- a/include/linux/clk.h
+++ b/include/linux/clk.h
@@ -60,6 +60,7 @@ struct clk_notifier {
 /**
  * struct clk_notifier_data - rate data to pass to the notifier callback
  * @clk: struct clk * being changed
+ * @trigger: struct clk * being responsible for the change
  * @old_rate: previous rate of this clk
  * @new_rate: new rate of this clk
  *
@@ -70,6 +71,7 @@ struct clk_notifier {
  */
 struct clk_notifier_data {
 	struct clk		*clk;
+	struct clk		*trigger;
 	unsigned long		old_rate;
 	unsigned long		new_rate;
 };

-- 
2.34.1

