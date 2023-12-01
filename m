Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E539F800728
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:34:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378139AbjLAJed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:34:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378143AbjLAJeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:34:15 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A8E3581
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 01:33:46 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-54c54a3b789so727840a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 01 Dec 2023 01:33:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1701423224; x=1702028024; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=niGbj670flkgPie6QF876KkLwnZEAB/QBU6SIajf+Qs=;
        b=EeD95u3mVtGo/1uuMTq9lGsHSm2JbpAUkH2nRPe0QRKZhr/XIkqRvlwp+Y3yNHdx1r
         moVhNc3PvJd9S2sX3BcjuSEnZenCKg3c0Ggb2JX7XRInjkpzw9nLZSWUn5AcxHSTeJI8
         BzXb1vhQY7e8IxTgs/4Yu/6xeZkNEb2ms/kwqSNUVlensm3Fj6IOjpGPORL5DJU4fN5j
         GrB2JQQwWJw4u0mmI2q+I3zLbwdisBSuXcOnNVs5eD72pq4C3qESmrxxIfC5A2I33DeY
         YXWNyKdC91Ph+3dGjlPpLCczoN1adoIwBZTNI5w8C4MySJAD9ps5jKRwhSmxZ99JG+aH
         PKFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701423224; x=1702028024;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=niGbj670flkgPie6QF876KkLwnZEAB/QBU6SIajf+Qs=;
        b=I4B7n+y8fTPoImc4qeBGsiYftUiUPLuVE/vkqJ8q9SMkE5foBZQL6te0R9eIcAz+wm
         w09z2sO7KHAgSfzXApb0jP0+A2CC/UzzRuX1VT1/Ig4qhGUgnk7nUAbTkD8QMmhclgsi
         wXmxgkVWGP4WzayVdwWCBiG1vPZXa3qUoq2JNTzFjfLLDPbtMO+SaTdUvFCWUcP93AWT
         NSvLCbIErEYKhpAznck3gvUs259J9W6iKOjchXUfwIQnwRLIpbA6DhnW0I8ASOk3RaG8
         wtUlUBCZyt4HYRLj5w9wSN/hurv0zqkeFc92w8dbvlKQsERw2bEKbb8WakUtpT9pXIL5
         13nA==
X-Gm-Message-State: AOJu0YzH/byTxvLUjg7GTT0Bf59YDi5nMw9Xtc24+5aC2zUU5LQaBeWc
        1W5PPzMfkfWAOEG6PYmyUc0DCQ==
X-Google-Smtp-Source: AGHT+IFJZAiqLGITBB9Yi0hCcn8yRnUqkmyP8eOY/RIfQMB3OI8uDZT1rn/dXA6QXyfX1QB/Ha0Z1A==
X-Received: by 2002:a50:8d52:0:b0:54c:48aa:cd0e with SMTP id t18-20020a508d52000000b0054c48aacd0emr1134309edt.30.1701423224409;
        Fri, 01 Dec 2023 01:33:44 -0800 (PST)
Received: from otso.luca.vpn.lucaweiss.eu (dhcp-089-099-055-216.chello.nl. [89.99.55.216])
        by smtp.gmail.com with ESMTPSA id b16-20020a05640202d000b0054bbc6b6580sm1423708edx.31.2023.12.01.01.33.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 01:33:44 -0800 (PST)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 01 Dec 2023 10:33:18 +0100
Subject: [PATCH v3 1/3] media: venus: core: Set up secure memory ranges for
 SC7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231201-sc7280-venus-pas-v3-1-bc132dc5fc30@fairphone.com>
References: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
In-Reply-To: <20231201-sc7280-venus-pas-v3-0-bc132dc5fc30@fairphone.com>
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        cros-qcom-dts-watchers@chromium.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Not all SC7280 devices ship with ChromeOS firmware. Other devices need
PAS for image authentication. That requires the predefined virtual
address ranges to be passed via scm calls. Define them to enable Venus
on non-CrOS SC7280 devices.

Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Reviewed-by: Vikash Garodia <quic_vgarodia@quicinc.com>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/media/platform/qcom/venus/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 9cffe975581b..a712dd4f02a5 100644
--- a/drivers/media/platform/qcom/venus/core.c
+++ b/drivers/media/platform/qcom/venus/core.c
@@ -881,6 +881,10 @@ static const struct venus_resources sc7280_res = {
 	.vmem_size = 0,
 	.vmem_addr = 0,
 	.dma_mask = 0xe0000000 - 1,
+	.cp_start = 0,
+	.cp_size = 0x25800000,
+	.cp_nonpixel_start = 0x1000000,
+	.cp_nonpixel_size = 0x24800000,
 	.fwname = "qcom/vpu-2.0/venus.mbn",
 };
 

-- 
2.43.0

