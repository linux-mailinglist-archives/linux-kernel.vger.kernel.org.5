Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1965B7B2DF5
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 10:38:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232890AbjI2Iiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 04:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232859AbjI2Iih (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 04:38:37 -0400
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062EF1B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:38:34 -0700 (PDT)
Received: by mail-ej1-x632.google.com with SMTP id a640c23a62f3a-9ae2cc4d17eso1850928466b.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 01:38:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1695976712; x=1696581512; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fOWusuB+PJKjWg0I1/CANfiCcxqSyq9YW+0X1DGwXrU=;
        b=u6lLL8ECo0kIt9x8I4vz7H4uB1KlrBw2gHITC2PUnkyZau8rWGm93FdXsyCPksI7d1
         2r4KSTj8qkKnr8AKdxDP+jEaz6OHjO4Mpaov+aKwA9XfrlAevfLQz796BrAPUc740pKQ
         oDIa6U2x9s/GIHqcxYRUaD7WEgZrty0ytB3LIATJYGcZaHAiKUM1VJRIAhXUEe5OM51J
         qUVDGhCZBDWDmHclGZhTPcLknRw5EOjSGJO6BftM0yoi5NZGlaRB3aihZJ4vV2Vmfyia
         8dSGqPoWCVXZZ1jEVhM7exmoRojreMlS+pfaHCMIYBSzsh0nn5SU2LEqr4Tiw84QF4CI
         iYCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695976712; x=1696581512;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOWusuB+PJKjWg0I1/CANfiCcxqSyq9YW+0X1DGwXrU=;
        b=PSgOtynLcJYkf0q5DOTkYNuuD3NrxXJO7JwAZgyGtdmPNpBISEAFVvydW4+wpv0ygA
         o3eIsnCD8PVVwDX+Oe8zFG6flXZkRke2sx3KA6uP9et3BSCqq27rNYMENkc/fZZBA8wc
         0+LpdW6wjSB1GwGv64WsYVVqkJ9LdeIAtvzG0P6qTPnD2shYMHJQ08EdUl52qiEila8e
         SZyamc0UtAaCAO1ysi8pJApfz9imMrv3iwplTJL/aYPjjzVXn9naS3iMPKcUfTXeaG/6
         xV4K+3yxmCtKSD4ZWtx7z8ZftKaOBgVWykFFM4DzbVZxlcRSnBN3BhWwOmlstcCD0/pf
         irZA==
X-Gm-Message-State: AOJu0YyKlCIn8nv6j3CVEmXi0fZhHav24TkXsvZyZPZnm4WY1bXm0PXo
        GhBlB1PfVKCZUoe2dJq+wamXZQ==
X-Google-Smtp-Source: AGHT+IEWR92YMVGrUJ5RbQ/heh37u0ZBG1Ma86v3zGzQBjc8vLO3PtSXU3sJrxy1LVODE3qkkrxcVA==
X-Received: by 2002:a17:906:30ca:b0:9b2:794d:62d3 with SMTP id b10-20020a17090630ca00b009b2794d62d3mr2952442ejb.14.1695976712440;
        Fri, 29 Sep 2023 01:38:32 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id qk8-20020a170906d9c800b009ad89697c86sm12208965ejb.144.2023.09.29.01.38.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 01:38:31 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 29 Sep 2023 10:38:19 +0200
Subject: [PATCH 1/3] media: venus: core: Set up secure memory ranges for
 SC7280
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230929-sc7280-venus-pas-v1-1-9c6738cf157a@fairphone.com>
References: <20230929-sc7280-venus-pas-v1-0-9c6738cf157a@fairphone.com>
In-Reply-To: <20230929-sc7280-venus-pas-v1-0-9c6738cf157a@fairphone.com>
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
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
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

