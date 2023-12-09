Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481CF80B59C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 18:31:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbjLIRbY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 12:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbjLIRbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 12:31:08 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB68E173F
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 09:31:01 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50bce78f145so3609157e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 09:31:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702143060; x=1702747860; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l/mGJNaNyYtrtX/eKur4vqWC9SNDz4+L7gUzAKh8niA=;
        b=OSOnU5VyEr2IFPyECs+bhv3+MfC9vAFQkPOuOgp5fz4NNLgf3M94ELEWBvwMWg5dGR
         0kO0R+cLvtEle4gYUAbyWJPG63XyU2tnlAfLB6tvbLIr2/xznWWBQHgpKE9k5adXbAMF
         7zK1otU6FxGIZH8H4kUZl6R3ZLTyjgM46YdBjINP0t65DMBTq82oiqCW7iI+vXu2iMQ+
         jb4yn02b0Iz0GT69zQfFpKIL9QTebn2PxTAvsaX4hz6Kjvk4Xd0avAhlTKJwUBuLvMLS
         aeB1ctl8RPYqThe5WYNyXSwSTEN58+Fp3T9Ngo71jQOL/pqkNWHZMcuh7lvEfdU9wtbg
         tZwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702143060; x=1702747860;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l/mGJNaNyYtrtX/eKur4vqWC9SNDz4+L7gUzAKh8niA=;
        b=Uc15IzCiZr0XOPzbP7XhKFWV0a/kOKK6ieOsJxb27zETLKsakhaWneqANuTbQPKJt0
         eI4iDhnDdToAD9m9XEBOpKIghMlWxuJBruIBjAaAEsDI+h8L1VuV5yYtHbulX5Z0vInn
         4CZLugB+ykDTIQkllOWcM85t7bhIrHNydqU++uZpgkrjwzBWQs31eIlCVI18TBU7q87x
         7GtRKjzG9SDPqx1TkJEMHWUYkhE7bk6hW9Z1WQ6yKSO3Pb6zO8RCNlSFLaHtNXJPx6Cx
         US60aLYVk+aKgXusbI57wEVTaCFdHV2CoZkyDBrx+xplBNmLefJYLcYMVewEQTj6C7pl
         lczA==
X-Gm-Message-State: AOJu0YzNRORZND2jyT+OyHZOJ5TMuN66oso5L31VcfjuZzl4lsijXlgk
        3yEUGo96G+7hSqS0AUhlEdPXhGMtb/a9U3Krjek=
X-Google-Smtp-Source: AGHT+IGUAf0Rye8yb8vzFUPgUMYU+8xgoBkGJ+TrIeQYGIt0coEWYvdmn2SEL60pxjBHs7tZHE1J1A==
X-Received: by 2002:a05:6512:239a:b0:50c:1047:59fd with SMTP id c26-20020a056512239a00b0050c104759fdmr476113lfv.167.1702143060149;
        Sat, 09 Dec 2023 09:31:00 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id m26-20020a50931a000000b0054ce5c00e74sm1926621eda.88.2023.12.09.09.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 09:30:59 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Dinh Nguyen <dinguyen@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 10/15] arm64: dts: socfpga: stratix10_swvp: drop unsupported DW MSHC properties
Date:   Sat,  9 Dec 2023 18:30:39 +0100
Message-Id: <20231209173044.257684-10-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
References: <20231209173044.257684-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

altr,dw-mshc-ciu-div and altr,dw-mshc-sdr-timing are neither documented
nor used by Linux, so remove them to fix dtbs_check warnings like:

  socfpga_stratix10_swvp.dtb: mmc@ff808000: Unevaluated properties are not allowed
    ('altr,dw-mshc-ciu-div', 'altr,dw-mshc-sdr-timing' were unexpected)

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
index ff413f8e3b07..0d837d3e65a5 100644
--- a/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
+++ b/arch/arm64/boot/dts/altera/socfpga_stratix10_swvp.dts
@@ -80,8 +80,6 @@ &gmac2 {
 
 &mmc {
 	status = "okay";
-	altr,dw-mshc-ciu-div = <0x3>;
-	altr,dw-mshc-sdr-timing = <0x0 0x3>;
 	cap-sd-highspeed;
 	cap-mmc-highspeed;
 	broken-cd;
-- 
2.34.1

