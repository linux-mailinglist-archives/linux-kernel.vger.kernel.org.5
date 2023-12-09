Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 577CE80B3B7
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbjLIKoN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:44:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKoL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:44:11 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1D42C8
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:44:17 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-54c64316a22so3870274a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 02:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702118656; x=1702723456; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jtN/02LS5E97y/eNJTai0WYBoLVbIzeuypbCd6U1aWQ=;
        b=HzTpzIGReSk+wd1TqYSbH8f5bY7LQiWH1NTNZVXdjMHGIyTTdVH3cmWWHiu2xT58qW
         ND9+KsxIM0eUjdp62eIxNNxsck7MJNFn/QQO7+Fw8fO6EVY7IBU+MMdJmPzmvU0hjyW+
         U0TKYj8gs28ovSepXjVrNC3QyadYjDUnOnSUSCcJBAjUP7/dm53wVaGYzPuqaciXumHD
         UUM/G1nnx0QHsc8l1cKJ+uJmgLYhcyocTKqg2wxsP6Tj3fXpLfHJKeaFYu85n171ie2k
         4M6UTmTUprHfoFj46QnN/i8dGvYQYJVvvmDBUF6yO8I8P6CrBeaDuJKT6oF39sgaYHpB
         aegA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118656; x=1702723456;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jtN/02LS5E97y/eNJTai0WYBoLVbIzeuypbCd6U1aWQ=;
        b=gqyISh5EtygC7EgWOgqu0bBSeJG5UOGDp0F8VAHM6ctirgMiDYm8MfJKy3lKUoPYnZ
         Bb4j1dvHlWMQ+bCHFBdbCTdJCJJODjuSBWNsbA/8TWdAKVfttEP2TpA+eWW7Fs0y6IkK
         cqKjtzv0k70FHFNblx7T9L4I6seUIhfD6Ro7Cf4LSdPBbExubxLC5jwjxtVZIGta3lQk
         zhMchR3NBu426P+TJvv4OhrPCDlpYV9g+5gQSble+UmDXJXyOsKCoYoOSHs2ZMcuSEvW
         rxjBCvH7Dz9p6f5orXuBTO/2MDQBUjNXOVjclEQFPefP+KPBJzjFVRpQ8vgULjWcwRpc
         Eh1A==
X-Gm-Message-State: AOJu0Yy/jvet4lyZEq1FmJZM4lXAPsWtRg9a33FU8YvEF83gqehG5Gfn
        vIKtE0zRnNBto6mNZ3aBxOdH2A==
X-Google-Smtp-Source: AGHT+IG0NrZS0c4C0ix0b3pjL98TjBc1sefC79SI5ddIN36Yx4a1EYmrZ64aGRIjRluE67nicf7OAw==
X-Received: by 2002:a50:aa8f:0:b0:54c:4837:7587 with SMTP id q15-20020a50aa8f000000b0054c48377587mr948749edc.51.1702118656099;
        Sat, 09 Dec 2023 02:44:16 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id eh12-20020a0564020f8c00b00550e21a4f76sm349604edb.8.2023.12.09.02.44.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:44:15 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 1/4] ARM: dts: aspeed: greatlakes: correct Mellanox multi-host property
Date:   Sat,  9 Dec 2023 11:44:09 +0100
Message-Id: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"mlx,multi-host" is using incorrect vendor prefix and is not documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
index 7a53f54833a0..9a6757dd203f 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-greatlakes.dts
@@ -66,7 +66,7 @@ &mac3 {
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	no-hw-checksum;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 	ncsi-ctrl,start-redo-probe;
 	ncsi-ctrl,no-channel-monitor;
 	ncsi-package = <1>;
-- 
2.34.1

