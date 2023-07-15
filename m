Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 984497547D8
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jul 2023 11:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231303AbjGOJU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 15 Jul 2023 05:20:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjGOJU2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Jul 2023 05:20:28 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4233AB5;
        Sat, 15 Jul 2023 02:20:03 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fbf1b82de7so16536985e9.1;
        Sat, 15 Jul 2023 02:20:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689412802; x=1692004802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y6EAhfoDoZ7HkHH1SwMxSyZ3vEbeVt8JnBzyWyltbvA=;
        b=WEzB1yK4ONu6RzeZXEjanCIg7xapsQp268NSP8ws/7ExCA+IXBkTY5LKcDcin/8Zjh
         uUgXinV4xkQVibnipIeG2rV3T0RFK/S5FbOEMNlKTlbQsfXocy7jfph6OtzGEjVm5nMg
         gQq/Tax55XKivN+A3zwygNsiQUB0/hfo0J7XnJP2+kGMs8v96JPZ0U7W5OWgeojOnKBo
         uM0AosEbxcUmamtsL/Hwrj3yBVCQsD2rsjOFjOd0ESi0FsB2GNIEhjnIlzBhbkyhb0dj
         WfBx+/7lcvmBtCw4Q0M/7QG0mb9GnnfOPMoamswGt3GHfxO49xjcvpp7OpQBUL+sY+xA
         rG6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689412802; x=1692004802;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y6EAhfoDoZ7HkHH1SwMxSyZ3vEbeVt8JnBzyWyltbvA=;
        b=HkPQQeZdyHRPFLbMzyiVi4gXO1yknlsXoshQ9qPrXaBbzw16qzuUP/BLA3aJNOKKiv
         Rw97E23q7qI0+nzqSUZrPGQAtD5zD85Fn9jNDTBAssJ5Hj5M0G5GfwPtFPid2IxgYEv0
         O0EG31349lW9cJxDmUcNRV8V7BLNwYBE9gexbLnbJHK5sX16DbtS6Ew2wtvT3B6uBCp6
         9+JQrXOYeAcbmgNKiI/FQGZF0rOtcIcjhbTn3dLvy5joXgrnFtyY8R5gr6KYCLfI6Tqk
         8HUNZ6YM5mJdcFCq1CBHsC7hZnjOlgNinToQ8TUF5+PAAEvhWRIfWI5Hh4uQlx81GkN2
         Tq0w==
X-Gm-Message-State: ABy/qLaKz4PI4vZPsTbPO3QNQt44ooRw/IJ4xYnre3C9+u/Q9fWKudxD
        yUryvS7274MNOfT783WdO+M=
X-Google-Smtp-Source: APBJJlGnM4FGqE3vWblVF678YNav3ff/lOOtXfCjSo53HpGrfUUKjr14ILxN6OSeJpdwuQTHQedSpw==
X-Received: by 2002:a1c:6a0d:0:b0:3f6:d90:3db with SMTP id f13-20020a1c6a0d000000b003f60d9003dbmr4211358wmc.3.1689412801449;
        Sat, 15 Jul 2023 02:20:01 -0700 (PDT)
Received: from david-ryuzu.fritz.box ([188.195.202.152])
        by smtp.googlemail.com with ESMTPSA id f22-20020a7bc8d6000000b003fbb5142c4bsm3238133wml.18.2023.07.15.02.20.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Jul 2023 02:20:01 -0700 (PDT)
From:   David Wronek <davidwronek@gmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <quic_tdas@quicinc.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        cros-qcom-dts-watchers@chromium.org,
        David Wronek <davidwronek@gmail.com>
Subject: [PATCH v3 1/7] clk: qcom: gcc-sc7180: Fix up gcc_sdcc2_apps_clk_src
Date:   Sat, 15 Jul 2023 11:16:07 +0200
Message-ID: <20230715091932.161507-2-davidwronek@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230715091932.161507-1-davidwronek@gmail.com>
References: <20230715091932.161507-1-davidwronek@gmail.com>
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

Set .flags = CLK_OPS_PARENT_ENABLE to fix "gcc_sdcc2_apps_clk_src: rcg
didn't update its configuration" error.

Fixes: 17269568f726 ("clk: qcom: Add Global Clock controller (GCC) driver for SC7180")
Signed-off-by: David Wronek <davidwronek@gmail.com>
---
 drivers/clk/qcom/gcc-sc7180.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/qcom/gcc-sc7180.c b/drivers/clk/qcom/gcc-sc7180.c
index cef3c77564cf..49f36e1df4fa 100644
--- a/drivers/clk/qcom/gcc-sc7180.c
+++ b/drivers/clk/qcom/gcc-sc7180.c
@@ -651,6 +651,7 @@ static struct clk_rcg2 gcc_sdcc2_apps_clk_src = {
 		.name = "gcc_sdcc2_apps_clk_src",
 		.parent_data = gcc_parent_data_5,
 		.num_parents = ARRAY_SIZE(gcc_parent_data_5),
+		.flags = CLK_OPS_PARENT_ENABLE,
 		.ops = &clk_rcg2_floor_ops,
 	},
 };
-- 
2.41.0

