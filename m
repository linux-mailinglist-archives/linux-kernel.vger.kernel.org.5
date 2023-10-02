Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AC67B54E6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 16:31:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237739AbjJBOUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237730AbjJBOUg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:20:36 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE33C9
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 07:20:32 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-52fe27898e9so23027568a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 07:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1696256431; x=1696861231; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P1hZYPziDEWmtdRiUaFpSGZqLrCtBE6eM/yrVSmM+ac=;
        b=zHyiXBuX02GTWjhbEMuVda/7vb0nTmIEluWBJOJWDh2BNkmlDQBkhd21LlSqSRB6IQ
         g8YwPujM654dlXByMzho0iNUYZkt3AbpzyTlX9YYEBtOsF7FULUwHWsvF4xBr8vbC33m
         6NKDX016MSIA6YTit/C1QUxfWEJ1z1nqDPoD3o18aiCOagFA57zqH4YFo5bhnJN8mgCA
         EmzeElY+M7gA2wglSjZMquE28BrGGXkJZv1Tii3E0rWyFatyK0+/JG6fYfmeHVNmEIz0
         Dyul+Gn6xAFOYE8qY+To6TFUdcODa7XrvJszfpPXKDOaRjJC//NdRckE2rtH/oxcISp9
         WNiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696256431; x=1696861231;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=P1hZYPziDEWmtdRiUaFpSGZqLrCtBE6eM/yrVSmM+ac=;
        b=MxY1uYJsUCv3kDAzWe30Gxpllv20lI82lY9vu+Za31NYD3lrVfLWSaq/UR1QR9kNAA
         DTPNEo9VZKgMvkv6Mu/rEVxsBlUM5cEqcNOxCc5CHrKi1/SHZespMTFe8zNM9Ydz85Pr
         qjswf741A5BBWUEOGSChNuBptclR2Ch2ZpZ3bQdxsLN99zwBj9j2BBdO9SNyrF6p0KM7
         RzcOpuUhW5AYV4TkGMu1m86lC8aEkqiPcZm1pvrE2p03oZVnemcIuZbk+cKZ1bpJoESO
         RXLlpfSqMv2hBCNIOiL113I/uCXo5m4cCQNEFG+9CJDqfjtaYOUeSPMPPQF/QQGZgEDN
         hcxw==
X-Gm-Message-State: AOJu0Yzgq8qIZGQEt39ENn5xnj1CRSpy+jkbz8FoA1Wf/ZNM7ZzoyiZP
        WiZfsj52Y44cVtVlpr7EupZqsA==
X-Google-Smtp-Source: AGHT+IHS8qXn+yYgV2nDhPjPMgXw9/Id9Vs7YQjL3WRjgJE3pFeEWP9RTn1o1Ihd/bOo2hngzdHi/g==
X-Received: by 2002:a50:ee1a:0:b0:523:3e23:15ab with SMTP id g26-20020a50ee1a000000b005233e2315abmr2670995eds.26.1696256431036;
        Mon, 02 Oct 2023 07:20:31 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id w10-20020aa7dcca000000b005309eb7544fsm15583356edu.45.2023.10.02.07.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Oct 2023 07:20:30 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Mon, 02 Oct 2023 16:20:29 +0200
Subject: [PATCH v2 1/3] media: venus: core: Set up secure memory ranges for
 SC7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231002-sc7280-venus-pas-v2-1-bd2408891317@fairphone.com>
References: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
In-Reply-To: <20231002-sc7280-venus-pas-v2-0-bd2408891317@fairphone.com>
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
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/media/platform/qcom/venus/core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/platform/qcom/venus/core.c b/drivers/media/platform/qcom/venus/core.c
index 054b8e74ba4f..5c6baa0f4d45 100644
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
2.42.0

