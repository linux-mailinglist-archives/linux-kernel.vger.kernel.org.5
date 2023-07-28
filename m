Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5237D766BAA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 13:29:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236253AbjG1L26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 07:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232959AbjG1L2y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 07:28:54 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0580D35AB
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:28:53 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-3fbf1b82d9cso20192215e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jul 2023 04:28:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690543731; x=1691148531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=BQ34vB3coODdnCqDRzNfJbwKt6237pIU9W1p9j3eoLQ=;
        b=bOkI9D8dNzJpn9aOYEnooCIj1cr2YtJDjjbFmyJvdCWIILWwPhp3mgLj6I3/vayjFC
         wm93ZBG78NEwwxCQWagNXxT98EUSP1Kmvy5PwxiJdEnbrPE4FGZBcFgXP0Yr7sOkbsnb
         NsHP1lST+OyJwaINFmtQOPSJcjS3xHQgvfSeVcfwOCnke2d7tDVwoqTjEGxlCd8hh0+w
         7sNLdIkAcxXjGUtlPX+twW7fjeEhGre1tWsekg9KAjwPfjFP8Kkp849K/We9epd30M4b
         VN6K4Z99oOCGYx0jhqtjxrRwiv7sTEmRPuQTWKB+1Qj0bzWcL367ad9bgsczm97PCDuQ
         y/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690543731; x=1691148531;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BQ34vB3coODdnCqDRzNfJbwKt6237pIU9W1p9j3eoLQ=;
        b=X0sXLuVgSBB5UKlg4MKhJo/XCJmBb9Sa1k2EeHHVXc/8NVObjRLuWNU5XDLVBdfoKP
         7RJMaII9l0mH+qYhdwjkR1DtFAABxoWhAdM/Z4JgMVavbz+18A1zX8TQu5PBBZJm6jZK
         P2GMJfwkJK3GExebZgVI1yPx1vwb6u1fMP1rkoKQqMGHqpGoDquXIM2W+pk3+EWFEgB1
         JrXQ7q0hhriTYzYyJJtwohS1d+Oy4Y8OyfTTrmQ6l3R7gPl/8nEeHWtn/jf8WVBSOh0v
         jw0dCVIz1GRk9IMb8c6fcQv9xXxorP5O2ibg+99lhX8sYTjbUxLcZ5Pmd29BM0H1KPXN
         c2rQ==
X-Gm-Message-State: ABy/qLblt8tTY5Fg9CK1Mh3rUfpRg79UYXM7ajU7fdmCfMfzxIehgmQJ
        hVdJMsgcR9b0b+PMr3uuqyz7ww==
X-Google-Smtp-Source: APBJJlHXUGNVhjNXkYvUnBfA5cPneRuKYRGzxZjx6jl9lNQLLXcdU37HddGAzCimNmmjr1yI9PQOkw==
X-Received: by 2002:a05:600c:2208:b0:3fc:a49:4c05 with SMTP id z8-20020a05600c220800b003fc0a494c05mr1355381wml.40.1690543731305;
        Fri, 28 Jul 2023 04:28:51 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id q10-20020a1cf30a000000b003fbb618f7adsm4011911wmq.15.2023.07.28.04.28.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jul 2023 04:28:50 -0700 (PDT)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/2] soundwire: qcom: use newer link status tregister on v2.0.0
Date:   Fri, 28 Jul 2023 13:28:47 +0200
Message-Id: <20230728112848.67092-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Soundwire v2.0.0 comes with a new register LINK_STATUS for the
FRAME_GEN_ENABLED field (bit indicating that an active frame is
running).  The old register COMP_STATUS is still there and still works,
although the new one is preferred in downstream sources.  Probably
because it allows to choose Soundwire instance per CPU.  Most of the
code allowing to use new register for Soundwire v2.0.0 was already there
as part of commit 312355a6a9f6 ("soundwire: qcom: add support for v2.0.0
controller"), so switch to it in swrm_wait_for_frame_gen_enabled()
function.  This should not have functional impact, because the old
register still behaves correctly.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 drivers/soundwire/qcom.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index f8fd2eb4a2bb..3ae3e5896308 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -817,8 +817,8 @@ static bool swrm_wait_for_frame_gen_enabled(struct qcom_swrm_ctrl *ctrl)
 	int comp_sts;
 
 	do {
-		ctrl->reg_read(ctrl, SWRM_COMP_STATUS, &comp_sts);
-
+		ctrl->reg_read(ctrl, ctrl->reg_layout[SWRM_REG_FRAME_GEN_ENABLED],
+			       &comp_sts);
 		if (comp_sts & SWRM_FRM_GEN_ENABLED)
 			return true;
 
-- 
2.34.1

