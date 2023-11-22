Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D2B27F5460
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 00:17:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbjKVXRT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 18:17:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKVXRS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 18:17:18 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA96A191
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:17:12 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id e9e14a558f8ab-359c1f42680so1028785ab.2
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 15:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700695032; x=1701299832; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z1zcqtTqhZ4Ynym9UE3ui8YaDfpYk7NuHJ7599B7McE=;
        b=Kno2ufhdPL3SIdPahYr7OYEUBQEzF0iEc1TVm7UAmED/0Zx/hq6OLpgntHsoRQoXyU
         WVzIu7wDQHyHUqJ8S3yWl0oZ88vIWWqOlNsGwkxvVhE0EeVX81kIDgu3njVGijwpEe1a
         4pjKasKmSxv643/8HqNj2Oy9ZAMi6aC5VEcnEVU7zgMJC7bSgBgTjCutxQAUx9FDYYzh
         ERnvobp2nvMRmkM5jtq1sgWX4tqWE4WjfrHhhcYQmLozt8mqWYyfLgzAuoDZKj21MoGg
         xeMPYwWEJtlGkoM6PZlUYLOqlUNmGSi0D/HOz+h+r5fQWLHpAP9KW9MWRxEAHiFo+6S4
         Yfag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700695032; x=1701299832;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z1zcqtTqhZ4Ynym9UE3ui8YaDfpYk7NuHJ7599B7McE=;
        b=wuoqibC8NhNcPJ91aHLZk4d/nef/dxXkr/of231LEUoRXaRJVF2wx/4pJw0doBzxmw
         S6kcxeoFt+ddTkCUy2DXkOE/SL5TqvvISoM0cG5d1/60jkEwFpExX0zSGRc2ROioZQTR
         KNoxj6krEl80dI8fQ32ZJzLheu/lVT10VCCy1jwURKZXLK9eJhl1ylgO6cG3Ga00TrdA
         6eeNKRCw8ruhebbyI0DZH+aq4UFmxeIl/8s0wbNLaXpQ4ZUIeykatT1yV3MNQkX44xgJ
         TBsxC4O33AAxiSNkhGVJUPMQMwIB1xaamp416Ugd8oOXiWHkJxTUv8jMczbuCm8Ltkw9
         W2jw==
X-Gm-Message-State: AOJu0YzXZPkdw+oYYW2OFcpq3iB3Qb0egpoTgOtVZy7PMBWkMDhRQYhc
        yHkr7ztr+ItL/WlaL3HJSB402IJd0jLVtkkx45M=
X-Google-Smtp-Source: AGHT+IEONm3/0yle1mIzMytvh9Hjkg6xElFdJTDJzge/HIBKtNQ8pLGn46mQVQ+ZJ0HcXemIm4IMdw==
X-Received: by 2002:a05:6e02:1285:b0:359:ca5f:5103 with SMTP id y5-20020a056e02128500b00359ca5f5103mr3775252ilq.6.1700695032097;
        Wed, 22 Nov 2023 15:17:12 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id cb12-20020a056e02318c00b00359b09f0710sm195468ilb.6.2023.11.22.15.17.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 15:17:11 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net v2] net: ipa: fix one GSI register field width
Date:   Wed, 22 Nov 2023 17:17:08 -0600
Message-Id: <20231122231708.896632-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
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

The width of the R_LENGTH field of the EV_CH_E_CNTXT_1 GSI register
is 24 bits (not 20 bits) starting with IPA v5.0.  Fix this.

Fixes: faf0678ec8a0 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alex Elder <elder@linaro.org>
---
v2: Fixed erroneous commit hash in the "Fixes" tag.

 drivers/net/ipa/reg/gsi_reg-v5.0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ipa/reg/gsi_reg-v5.0.c b/drivers/net/ipa/reg/gsi_reg-v5.0.c
index d7b81a36d673b..145eb0bd096d6 100644
--- a/drivers/net/ipa/reg/gsi_reg-v5.0.c
+++ b/drivers/net/ipa/reg/gsi_reg-v5.0.c
@@ -78,7 +78,7 @@ REG_STRIDE_FIELDS(EV_CH_E_CNTXT_0, ev_ch_e_cntxt_0,
 		  0x0001c000 + 0x12000 * GSI_EE_AP, 0x80);
 
 static const u32 reg_ev_ch_e_cntxt_1_fmask[] = {
-	[R_LENGTH]					= GENMASK(19, 0),
+	[R_LENGTH]					= GENMASK(23, 0),
 };
 
 REG_STRIDE_FIELDS(EV_CH_E_CNTXT_1, ev_ch_e_cntxt_1,
-- 
2.34.1

