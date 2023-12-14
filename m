Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8114A812B4E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 10:12:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235665AbjLNJMQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 04:12:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235658AbjLNJML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 04:12:11 -0500
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E339126
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:17 -0800 (PST)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-77f35009e78so461366585a.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Dec 2023 01:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702545136; x=1703149936; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h2DCBxer6HmgtNkGKJ5qBuor3JmQBFkVeksd4AY7uXs=;
        b=EZtDLq/HI79bcsz2P1q56tHB+9aIk3GB44kaMqKEyr/ZNhFBygCWZxafZhG0LD/EdK
         wLEv8+WgXswNUAMOn5cAnEGAnqdYhT5BHf7h0OOOl+OlTxfVLvn2D4Sddmqv7xh1xykc
         aGVXEdUraCWWV8GRM6il1JMCwxt+Yxj/cSH+Uo6gI3Iq+1NvPLlG6dXhk49PGJYAY57X
         OgVW+tIeII6DLbdteNNObDmfy/3q+Juu4WP7T2GsQ5esVtqpshCyDUKma9iqJV+Aj8eX
         d7HyiJIzL6/KqnOOf84vYwjXGvQbEPKatamIsXngigWczEehHQOxFFfnpzAbqNBsQAml
         fftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702545136; x=1703149936;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h2DCBxer6HmgtNkGKJ5qBuor3JmQBFkVeksd4AY7uXs=;
        b=flQG/0ljdfokgrhY9xzsfGkDVaKvlH/CUnZzbpwLQhG+pVvYJRo9gSY4AfhNJ8LWKs
         bpIZqfQvzECYsxNvI1LlDMo1X3w47O5X8eqfp5i2YUKVeUO39OoR2hI3wgpUuhCZnRyK
         bCiUpj0XtD0l9I7eCIDeYd8sQFItwyJffZHPgcN5OQW+z8BdBsjHfF9LZzJ9cmMXODSk
         Zp8WQUzUo6TMyGherde2s2DdlpOUlz9PodnTaVrY9aahm6mojqxph27YUsiR57EXtiQ5
         4yk8zvXHDT4EzGjRO7bYHq1y3M3k9TY470jS0ovBKQXTIPCpU8Ohu/ojGRbpiv9ZMn1+
         HIEg==
X-Gm-Message-State: AOJu0Yz5yYctlTJ9XnfMy5mCX6CrFSRABYIIL11C6M3HPe3Z+vmim+c4
        wL57dNLWtCKaYhKbqiMRW6cP
X-Google-Smtp-Source: AGHT+IFeqUZblWasaHyv4TNb43kurEEqUO9LouxNXSij17ija+k+4i+/EtljJ8EFj0dMBIAuZum45g==
X-Received: by 2002:a05:620a:6109:b0:77f:983d:9606 with SMTP id oq9-20020a05620a610900b0077f983d9606mr1935569qkn.98.1702545136695;
        Thu, 14 Dec 2023 01:12:16 -0800 (PST)
Received: from localhost.localdomain ([117.213.102.12])
        by smtp.gmail.com with ESMTPSA id qt13-20020a05620a8a0d00b0077d75164ef9sm5144119qkn.124.2023.12.14.01.12.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 01:12:16 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, konrad.dybcio@linaro.org, vkoul@kernel.org,
        sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 10/16] arm64: dts: qcom: sm6350: Fix UFS PHY clocks
Date:   Thu, 14 Dec 2023 14:40:55 +0530
Message-Id: <20231214091101.45713-11-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
References: <20231214091101.45713-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

QMP PHY used in SM6350 requires 3 clocks:

* ref - 19.2MHz reference clock from RPMh
* ref_aux - Auxiliary reference clock from GCC
* qref - QREF clock from GCC

While at it, let's move 'clocks' property before 'clock-names' to match
the style used commonly.

Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8fd6f4d03490..ef793d48316d 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1192,10 +1192,12 @@ ufs_mem_phy: phy@1d87000 {
 			#size-cells = <2>;
 			ranges;
 
+			clocks = <&rpmhcc RPMH_CXO_CLK>,
+				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>,
+				 <&gcc GCC_UFS_MEM_CLKREF_CLK>;
 			clock-names = "ref",
-				      "ref_aux";
-			clocks = <&gcc GCC_UFS_MEM_CLKREF_CLK>,
-				 <&gcc GCC_UFS_PHY_PHY_AUX_CLK>;
+				      "ref_aux",
+				      "qref";
 
 			resets = <&ufs_mem_hc 0>;
 			reset-names = "ufsphy";
-- 
2.25.1

