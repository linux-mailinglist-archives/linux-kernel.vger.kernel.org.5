Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110DC7F5287
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 22:25:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343940AbjKVVZO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 16:25:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231535AbjKVVZN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 16:25:13 -0500
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150CF1A4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:25:09 -0800 (PST)
Received: by mail-io1-xd32.google.com with SMTP id ca18e2360f4ac-7b063a6420dso7043739f.1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 13:25:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700688308; x=1701293108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OK4yjGOQCQ1Of5MUW9eg8KxwFZFuyIMn1rGG5EPO/5s=;
        b=o3ms0IWuFUo90hh2SYWVNSjQjcAmVRiY71xmHKlwRjTNy62wmRBTrYtefHtQPahxTu
         RVjjJHbvW1/t/OG3PJ7VfQBKPYjqw6hSW8LRKaXyN2rSwWy7xFcnJ6SH2dGUPqjxLJfn
         dNYnFQNR2wbMrNtxbUikkhMXi6AvQW+yGFqFb5MEv6QJBioVVrSzuK8suCHbiFwj1QNo
         HoBMoDV8+DZhFOpwp14GZBS3KBOiUaZzvTpvqZF0+z7ah1piiEpfX310CDs8wdThLsgN
         Xjgl4Zt5jFUxvTX8ZDk9WcQdDZHx6sqYH/bx2iJoMwf8FTftQuQ+kfeHu2CbmwjNKGpQ
         ObLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700688308; x=1701293108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OK4yjGOQCQ1Of5MUW9eg8KxwFZFuyIMn1rGG5EPO/5s=;
        b=VoCrDwyD1W7HxkmbU/gLUVmRl7UNTxTuilzT17kuRrJrNCUV204kUueD0Zkep/1u5E
         1sqYYSZiPKN7m2b/EN0Q627HJE+tc6d5hzdW7iDFZrYvrTUy+3yrbowJsGJlGrkEL90X
         zf+jWEqXGgKNE6Giu3+CsiG1VY7MktQ2VNe6en9BhhcKKNciIgCvMKqKObxXVnGlzXsq
         TC0RCK7aoucxymXYRgZXVJDE2u+XlUvIID8fGZT5o3jXQXUS/tkBLZZCRh3D6dMCTF4a
         yBJ+pycQP9kuL9QR8SbqS3DfLFulk+xIo6FEZLTCb+C02RD/R6N65hjZzWVyb3igXjSd
         T/gw==
X-Gm-Message-State: AOJu0YyN2rhD5pjblJ9uD/6B11Q43Mbmfeb5o6hSTKlRsJZE85UDCb7X
        cSOPA9dFyuK6dMkmvR6p3CZ3l4bSac0M9YIthm0=
X-Google-Smtp-Source: AGHT+IGfqWQCALQ2sbl53cSx59NR6o3lXjdDQ8ypxQCzXrbtIkKuIukuNRzmX3tbmVN1WRYaJX1GYQ==
X-Received: by 2002:a6b:e217:0:b0:785:d5d4:9f26 with SMTP id z23-20020a6be217000000b00785d5d49f26mr719339ioc.9.1700688308378;
        Wed, 22 Nov 2023 13:25:08 -0800 (PST)
Received: from localhost.localdomain (c-98-61-227-136.hsd1.mn.comcast.net. [98.61.227.136])
        by smtp.gmail.com with ESMTPSA id i3-20020a6bf403000000b007a66df53f71sm3591812iog.38.2023.11.22.13.25.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Nov 2023 13:25:08 -0800 (PST)
From:   Alex Elder <elder@linaro.org>
To:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc:     mka@chromium.org, andersson@kernel.org, quic_cpratapa@quicinc.com,
        quic_avuyyuru@quicinc.com, quic_jponduru@quicinc.com,
        quic_subashab@quicinc.com, elder@kernel.org,
        netdev@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH net] net: ipa: fix one GSI register field width
Date:   Wed, 22 Nov 2023 15:25:04 -0600
Message-Id: <20231122212504.714276-1-elder@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The width of the R_LENGTH field of the EV_CH_E_CNTXT_1 GSI register
is 24 bits (not 20 bits) starting with IPA v5.0.  Fix this.

Fixes: 627659d542c5 ("net: ipa: add IPA v5.0 GSI register definitions")
Signed-off-by: Alex Elder <elder@linaro.org>
---
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

