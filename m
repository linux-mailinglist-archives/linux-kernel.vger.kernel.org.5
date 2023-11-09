Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D01A97E71F8
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 20:09:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345107AbjKITJh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 14:09:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjKITJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 14:09:29 -0500
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 296243C14
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 11:09:27 -0800 (PST)
Received: by mail-ot1-x32d.google.com with SMTP id 46e09a7af769-6cd33d51852so643660a34.2
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 11:09:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699556966; x=1700161766; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=mrQce2fi5joicXGyijMSuzLaWJ9Gi53CJdUsyNCS/ek=;
        b=OTo5oK/6UirVtA1B4jjv9ymP/qPoprM8OKpC4sESNylk8Tmy0h0Qn/gFjKkHJsufed
         cFjKqKBPKV7EMQeP+GF/+ZuDTIwI+I1ozS81KcaAHNjUOFpAFzx+NJc5sw7SZPKucmlj
         7hahqHpyj4YaL5mKsVqk0UPkHN8ESP0n38lvbcUCYzJdYstJIQrh5thyL7Rwm1/SpQ3t
         mGnLbG1CmSeii1UFXhQPjGfP3p3xShewDg+4yoYjhxYTTEDqu4R6W5Kq14I19X1/JktO
         5VdGtMN7BPusmTQKbjBU2UsTVqY9b07iHKteQ7pUzV2cNgrwNqmVd0iNOx6VHsI6lL60
         +MIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699556966; x=1700161766;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mrQce2fi5joicXGyijMSuzLaWJ9Gi53CJdUsyNCS/ek=;
        b=wYhMRvfePNZcO11SrBLtGQbYFp81bHACPzSsbOKxOPreMtOSLykw/RAmb4dAx721/t
         RYky//xnJqhBA1K98orBOBDPmf/sSDvVYsmdvPuEY6RARmNOtrZbNwE9s7pO2+cqpKdf
         xm6go0g3DyJ0b0943jJsn19BgoCtpvPiXOex0WfWSRve/pM0ahA4GEBZiM2b+EpWnCxT
         icbJQrXymgjV6xJILwc/Wp3PKz6N/Foh0Ym8B4O7V724p6gLWSoZ9F4MkERVlSDuC6uo
         wFkB0D+n1uaJSeXPF97wgnpqaBoszI/ydkPPjfzoO1RCbdHmb40QV4nIOlUsO/85pl/B
         5UuQ==
X-Gm-Message-State: AOJu0YxjkFXJTF8IUqr2QJpiONjmi9Zx1XCOsE0IaDz1R91mgLcarCLI
        Coxg0+WA5Hfq+lVKes9+zWBjoAx/yuaVLYYv/C4PQgew
X-Google-Smtp-Source: AGHT+IEqhChy+9PfaLLygYaRjg10mzOliTG5x8L2DEzLyUa75MzGgjDixLGrR6Dvtd6wNHIA3mif1Q==
X-Received: by 2002:a05:6830:e08:b0:6b8:7880:de9 with SMTP id do8-20020a0568300e0800b006b878800de9mr6195268otb.19.1699556966399;
        Thu, 09 Nov 2023 11:09:26 -0800 (PST)
Received: from localhost ([136.62.192.75])
        by smtp.gmail.com with ESMTPSA id a23-20020a056830009700b006b9443ce478sm2300447oto.27.2023.11.09.11.09.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 11:09:26 -0800 (PST)
From:   Sam Protsenko <semen.protsenko@linaro.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        linux-samsung-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] clk: samsung: Fix kernel-doc comments
Date:   Thu,  9 Nov 2023 13:09:24 -0600
Message-Id: <20231109190925.2066-1-semen.protsenko@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix some issues found in kernel-doc comments in Samsung CCF framework.
It makes scripts/kernel-doc happy, which can be checked with:

    $ find drivers/clk/samsung/ -name '*.[ch]' -exec \
      scripts/kernel-doc -v -none {} \;

Signed-off-by: Sam Protsenko <semen.protsenko@linaro.org>
Fixes: ddeac8d968d4 ("clk: samsung: add infrastructure to register cpu clocks")
Fixes: 721c42a351b1 ("clk: samsung: add common clock framework helper functions for Samsung platforms")
Fixes: 3ff6e0d8d64d ("clk: samsung: Add support to register rate_table for samsung plls")
---
 drivers/clk/samsung/clk-cpu.h | 2 +-
 drivers/clk/samsung/clk.h     | 9 ++++++---
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/clk/samsung/clk-cpu.h b/drivers/clk/samsung/clk-cpu.h
index fc9f67a3b22e..103f64193e42 100644
--- a/drivers/clk/samsung/clk-cpu.h
+++ b/drivers/clk/samsung/clk-cpu.h
@@ -11,7 +11,7 @@
 #include "clk.h"
 
 /**
- * struct exynos_cpuclk_data: config data to setup cpu clocks.
+ * struct exynos_cpuclk_cfg_data: config data to setup cpu clocks.
  * @prate: frequency of the primary parent clock (in KHz).
  * @div0: value to be programmed in the div_cpu0 register.
  * @div1: value to be programmed in the div_cpu1 register.
diff --git a/drivers/clk/samsung/clk.h b/drivers/clk/samsung/clk.h
index ab9c3d7a25b3..4f17d5890a81 100644
--- a/drivers/clk/samsung/clk.h
+++ b/drivers/clk/samsung/clk.h
@@ -55,7 +55,7 @@ struct samsung_clock_alias {
  * @name: name of this fixed-rate clock.
  * @parent_name: optional parent clock name.
  * @flags: optional fixed-rate clock flags.
- * @fixed-rate: fixed clock rate of this clock.
+ * @fixed_rate: fixed clock rate of this clock.
  */
 struct samsung_fixed_rate_clock {
 	unsigned int		id;
@@ -74,7 +74,7 @@ struct samsung_fixed_rate_clock {
 		.fixed_rate	= frate,		\
 	}
 
-/*
+/**
  * struct samsung_fixed_factor_clock: information about fixed-factor clock
  * @id: platform specific id of the clock.
  * @name: name of this fixed-factor clock.
@@ -146,14 +146,16 @@ struct samsung_mux_clock {
 	__MUX(_id, cname, pnames, o, s, w, f, mf)
 
 /**
- * @id: platform specific id of the clock.
  * struct samsung_div_clock: information about div clock
+ * @id: platform specific id of the clock.
  * @name: name of this div clock.
  * @parent_name: name of the parent clock.
  * @flags: optional flags for basic clock.
  * @offset: offset of the register for configuring the div.
  * @shift: starting bit location of the div control bit-field in @reg.
+ * @width: width of the bitfield.
  * @div_flags: flags for div-type clock.
+ * @table: array of divider/value pairs ending with a div set to 0.
  */
 struct samsung_div_clock {
 	unsigned int		id;
@@ -244,6 +246,7 @@ struct samsung_clk_reg_dump {
  * @con_offset: offset of the register for configuring the PLL.
  * @lock_offset: offset of the register for locking the PLL.
  * @type: Type of PLL to be registered.
+ * @rate_table: array of PLL settings for possible PLL rates.
  */
 struct samsung_pll_clock {
 	unsigned int		id;
-- 
2.39.2

