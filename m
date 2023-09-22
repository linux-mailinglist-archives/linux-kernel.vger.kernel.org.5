Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 607A97AB887
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 19:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233770AbjIVRye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 13:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbjIVRyD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 13:54:03 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0590710F8
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:36 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-68c576d35feso2262676b3a.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Sep 2023 10:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1695405156; x=1696009956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJdLYVSWRxq3AIlS4Kyz9YBlE5nYYkWXarwNDO1ghNY=;
        b=mF6qe9PA5R5otO9zQnKcKj5oC+4+CP4hBXkWIjBl2HDYJBPTRln4UaDH48DkP5TPat
         Ol/LoLZhF1VQRtz6drK/5zIwBNaCeeynVqn0LBW67vUzK3bL6d2b0KFoHFVGyHbMI0I7
         mKBZDl8igK8nLzRodV/DhXyPirWDfOYHCVzHE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695405156; x=1696009956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZJdLYVSWRxq3AIlS4Kyz9YBlE5nYYkWXarwNDO1ghNY=;
        b=qLhIeR4cqDjtU3S/zdBynFNBuaDgHrNf42FvHbHupGkVIM85Dy/tUXxPJdQa4cQ5Uu
         0YMtV4bkWQTOz/wwQfeOECICTbjk+k3pYC9BZcEkBqSj4cQ7NiD1m9aZGlgR/I38CulP
         8lTazbF/6AyIUZ3YAG5IKBDmVNht9OeBJ9LDSf+uZAihXBxSrsDZxn/eIiO48UNId8Kb
         n2B1SpYILAF4+RKGaPF6zcHzls1wsxCSXk48w7ouWVPaPVeQrWlIZC/euBf57H/yOT76
         awp15hK5TOQpU211VNDc9U9EPF/d0HvbzPhZ/RUfJofdVklIQ6TvuWon0Sm+Y1ZH+vd8
         5O8A==
X-Gm-Message-State: AOJu0Yy781/Z41uWjZj8Ks147k7CfxtMgi+IcVGi12dBylhROrcLLexE
        uFJrPYN4+M65+wfPV35XV982ZA==
X-Google-Smtp-Source: AGHT+IFoQrSp0SiFF6qLCBvHgOfTOrpApeeY7D6DEhe0wY4aS5rS++y/hvFvRE1hRHq+xbkNHBtrKg==
X-Received: by 2002:a05:6a21:3392:b0:15d:6ea0:82da with SMTP id yy18-20020a056a21339200b0015d6ea082damr339756pzb.33.1695405156459;
        Fri, 22 Sep 2023 10:52:36 -0700 (PDT)
Received: from www.outflux.net (198-0-35-241-static.hfc.comcastbusiness.net. [198.0.35.241])
        by smtp.gmail.com with ESMTPSA id s24-20020aa78298000000b00687a4b70d1esm3453975pfm.218.2023.09.22.10.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Sep 2023 10:52:36 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Liviu Dudau <liviu.dudau@arm.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>, Yangtao Li <frank.li@vivo.com>,
        linux-arm-kernel@lists.infradead.org,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, linux-hardening@vger.kernel.org
Subject: [PATCH] bus: vexpress-config: Annotate struct vexpress_syscfg_func with __counted_by
Date:   Fri, 22 Sep 2023 10:52:35 -0700
Message-Id: <20230922175234.work.134-kees@kernel.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1359; i=keescook@chromium.org;
 h=from:subject:message-id; bh=3PVI9STddT1UYeIAqa7UhvgteCrsOUq0jUn/ld5S1vw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBlDdRiLsX/0CwUbyt/VlYPcyGDAI+9ukcXqigL5
 VN0fQ0VpkqJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCZQ3UYgAKCRCJcvTf3G3A
 JkGEEACWR8ueSvd6K6fybEhvi0LAyEorYYtD45WON1Xxm4nFzcoie++vcc65U3s2vBo2Q+Ca6Hv
 3ZlC4gOLONusN/ab1KT6HRYpnvJ3kav1cG92LF06cpQ1sJM6wmecTH9Z/tS/SycFLTUsIiR+fRx
 VYnTm5uuM8vTCvMMXoiJkxhwIWd5huI93hNq/4b/1hrZiKkAFxT9fQV1bTpNpzze1+0V6hrdHbX
 pZHHEP4xCGvwBY1r50vXi5jevgIbjCNQ9ZDO3HM2o4FOVVmsudLOzt0DO4EQZYPBeGfKzRA1dDm
 46X09cXsawNxRUH9HeOn8+g+A1+QGMy4embVLeal2qjyAve/vCfwlr9PUlRYdcgVDsuPD1SLK8O
 YNO4CerpAmMXWOQqCxOnk98lIz6diCC7o25PAmFbqg9O/7GMYymae6IbxT92aTG9xxtmFs+NL0P
 67f6B8yIoj4ViQNWe4c6XqTiMxlAsWuELYoSodTUiuA7yqXjwvFOtw1iOpyPogRQ7mAxjVMxYlN
 Wkmhjs3gY00bdzo7/b6dZ9vCmHH8xxnvDWNqtcr8TOt0bJUNv0ZtzRK2F0DrgUrtcfY1cv92fAe
 j28xJqCPhn9eeB0YArMpn7Z8rk6viQHx2tOeW59Cc8rUZc5r+NplUk4pxad20p/nYkd8v4n93u7
 rwdVR3q sgzoqcAQ==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Prepare for the coming implementation by GCC and Clang of the __counted_by
attribute. Flexible array members annotated with __counted_by can have
their accesses bounds-checked at run-time checking via CONFIG_UBSAN_BOUNDS
(for array indexing) and CONFIG_FORTIFY_SOURCE (for strcpy/memcpy-family
functions).

As found with Coccinelle[1], add __counted_by for struct vexpress_syscfg_func.

[1] https://github.com/kees/kernel-tools/blob/trunk/coccinelle/examples/counted_by.cocci

Cc: Liviu Dudau <liviu.dudau@arm.com>
Cc: Sudeep Holla <sudeep.holla@arm.com>
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>
Cc: Rob Herring <robh@kernel.org>
Cc: Yangtao Li <frank.li@vivo.com>
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 drivers/bus/vexpress-config.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/bus/vexpress-config.c b/drivers/bus/vexpress-config.c
index c4e1becbb2d2..d2c7ada90186 100644
--- a/drivers/bus/vexpress-config.c
+++ b/drivers/bus/vexpress-config.c
@@ -54,7 +54,7 @@ struct vexpress_syscfg_func {
 	struct vexpress_syscfg *syscfg;
 	struct regmap *regmap;
 	int num_templates;
-	u32 template[]; /* Keep it last! */
+	u32 template[] __counted_by(num_templates); /* Keep it last! */
 };
 
 struct vexpress_config_bridge_ops {
-- 
2.34.1

