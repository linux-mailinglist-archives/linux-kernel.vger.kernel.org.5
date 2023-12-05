Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DE73805E08
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 19:48:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235129AbjLESsV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 13:48:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232202AbjLESsR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 13:48:17 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CED6AD42
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 10:48:21 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-6ce6f4d3dafso166663b3a.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 10:48:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1701802101; x=1702406901; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMuwtjnej1x8HFalp3Q3/OE/xfiviC9gRjxwKKTrR6w=;
        b=gpEQpc62O1bItJgwaYS33n3QRx0bg7SaxQZ+UbpjC8QwzanI0+gn9nayYjx+p3VEoQ
         IOVL8qx7o7ZF9TzF+j1URzR9MJsJemhepUEQv3HX9DxZVfv4p/Dz14OMvIJQPzqmJ44h
         QClHW7S4s88WtIOGPEeT8fAwTPMDdNWD4o/Sw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701802101; x=1702406901;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMuwtjnej1x8HFalp3Q3/OE/xfiviC9gRjxwKKTrR6w=;
        b=A2bRA4FX6MfA9wjhv3Yy2W0UH5syAQoo4TclehP3mpYxMGLNXpHXrwgj760v0jxfYB
         h7QAw6X8coMIU06mpKHL/oR2NysWdAogH9qMhPB6SvvSNxHgsFt5INlEWFbX9aTH0YOg
         tBAc5etcViwnI9uOjsw5vjBetu4Gqi1gMluNPxwOcg7cvxQCzBOblfzlQMJ81uq4fo6O
         mcVqinZ2JBI3R6XVQ3OGuJReRCcTSYnmvQDya4sNVUT30Bzya+6LKaGBc9cMgER/VxFO
         Qiq+oBiRtSGH4gCfvf9fgh/zfr5TfFP66AYYtKBPA2BNmR01a3hyRiCkzsYvIIpapkxH
         df4Q==
X-Gm-Message-State: AOJu0Yx31D755pfRZgNvPvzXK/P6NYvY0HXqRjXT+A5DxFyQhNTVycIq
        fqPuoQVYqR/nTY65uQ30LEo5gw==
X-Google-Smtp-Source: AGHT+IG46+Q5aksBlxRdZwdbXbmdyxxtbUSk8xgwaeO6yDd7b65xBm2D2UXEYhMABHOhQrKOMFxh8w==
X-Received: by 2002:aa7:88c6:0:b0:6ce:4c49:58e4 with SMTP id k6-20020aa788c6000000b006ce4c4958e4mr8321583pff.0.1701802101086;
        Tue, 05 Dec 2023 10:48:21 -0800 (PST)
Received: from lbrmn-mmayer.ric.broadcom.net ([192.19.161.248])
        by smtp.gmail.com with ESMTPSA id k14-20020aa788ce000000b006ce5b404f5csm3213329pff.134.2023.12.05.10.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 10:48:20 -0800 (PST)
Received: by lbrmn-mmayer.ric.broadcom.net (Postfix, from userid 1000)
        id 5BF12D04; Tue,  5 Dec 2023 10:48:19 -0800 (PST)
From:   Markus Mayer <mmayer@broadcom.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Florian Fainelli <florian.fainelli@broadcom.com>,
        Rob Herring <robh+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Markus Mayer <mmayer@broadcom.com>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Device Tree Mailing List <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/4] memory: brcmstb_dpfe: introduce version-specific compatible strings
Date:   Tue,  5 Dec 2023 10:47:35 -0800
Message-ID: <20231205184741.3092376-3-mmayer@broadcom.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205184741.3092376-1-mmayer@broadcom.com>
References: <20231205184741.3092376-1-mmayer@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce compatible strings brcm,dpfe-cpu-v1 through brcm,dpfe-cpu-v3
to the Broadcom DPFE driver.

Signed-off-by: Markus Mayer <mmayer@broadcom.com>
---
 drivers/memory/brcmstb_dpfe.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/memory/brcmstb_dpfe.c b/drivers/memory/brcmstb_dpfe.c
index a7ab3d377206..66876b409e59 100644
--- a/drivers/memory/brcmstb_dpfe.c
+++ b/drivers/memory/brcmstb_dpfe.c
@@ -924,6 +924,12 @@ static const struct of_device_id brcmstb_dpfe_of_match[] = {
 	{ .compatible = "brcm,bcm7271-dpfe-cpu", .data = &dpfe_api_old_v2 },
 	{ .compatible = "brcm,bcm7278-dpfe-cpu", .data = &dpfe_api_old_v2 },
 	{ .compatible = "brcm,bcm7211-dpfe-cpu", .data = &dpfe_api_new_v2 },
+
+	/* Match specific DCPU versions */
+	{ .compatible = "brcm,dpfe-cpu-v1", .data = &dpfe_api_old_v2 },
+	{ .compatible = "brcm,dpfe-cpu-v2", .data = &dpfe_api_new_v2 },
+	{ .compatible = "brcm,dpfe-cpu-v3", .data = &dpfe_api_v3 },
+
 	/* API v3 is the default going forward */
 	{ .compatible = "brcm,dpfe-cpu", .data = &dpfe_api_v3 },
 	{}
-- 
2.43.0

