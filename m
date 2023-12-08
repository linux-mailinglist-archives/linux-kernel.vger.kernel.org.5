Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAC9B809EE2
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 10:11:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235835AbjLHJKf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 04:10:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232968AbjLHJK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 04:10:29 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD2341735
        for <linux-kernel@vger.kernel.org>; Fri,  8 Dec 2023 01:10:34 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40c0a074e71so18806455e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 08 Dec 2023 01:10:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702026633; x=1702631433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kNLG30CN2zegE/M7jl95INA4rCvQrv07QBb0d7Gkeww=;
        b=uEBgXbZtxIIXWocqukMR7esUC+HnA3A27K/Ltu6PyX6AbGcyP65pQzWVfOCJumk/22
         /UPeKtNEBeaIyZTcqT643edU92af6LGqGVzs+twU6P+GTPdYpACgUgn73A8uSL8R+oDP
         ZW9MJkgUKBXrinGmcjnMny/9RB620jUPvwPBwPDYOWLYSKhyRTQRPAvSWEzfgeaqNYgh
         oQdk8E++MA58mkdw1yjkHsCt7ByM7/EEC5ZcaI1atiWVTSZTdqcFvE9f+bPb+P75mzJX
         8H2WWrtnQI6/s7XR+0Sa54ewNx3k2TNzQEWbszgdurh6TzJULhhxmKS1yd0A3jWb+GTV
         xTBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702026633; x=1702631433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kNLG30CN2zegE/M7jl95INA4rCvQrv07QBb0d7Gkeww=;
        b=s5JU6Wyl1Rvyegk/2dazIN+ohcerqhRuYugsGttRsalIJj9EgUg4cYpGexuIsThjL+
         2hrjsZ3Fv07HfEGmT1+iz94buoyc073QTh7OEn6gn1eBf7EEwtqLW9NnNP9/ThI3a3AE
         fzsvjft5EEVK+l2eDWRkBt5iaTE6uQqnccy3vRpwvorxjPTFsuUBr98juyiw1ACtAda+
         XDxkGurXxz7iU4aXiBCEeJ2nptyPSy1+yI868IpdczkJIhNa84Wm8fkeZOnJkPauPz4R
         V74a8G/ZMInGW9Rh4MdS6MEdMb0QY8/y0DaS3j7fJHHVTUfUapN4w0ZilQNax3UWEFP5
         OZ1A==
X-Gm-Message-State: AOJu0YzNuBjg0BOjvjz36nk0zsRopTnBJnDZrbGZGjOuOZB2JOiGRStx
        SF9warq/VloottGUX0C8RCIXqQ==
X-Google-Smtp-Source: AGHT+IHx6Uzcak2KLc/VpwAnz/YzCDmjo98fnzg/Xudc/sXEyD36md+4/7yGRsrIODiWnAYGrk4xiw==
X-Received: by 2002:adf:e883:0:b0:333:2fd2:815c with SMTP id d3-20020adfe883000000b003332fd2815cmr2461364wrm.121.1702026633215;
        Fri, 08 Dec 2023 01:10:33 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b162:2510:4488:c0c3])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d5092000000b00333415503a7sm1572705wrt.22.2023.12.08.01.10.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Dec 2023 01:10:32 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Balakrishna Godavarthi <quic_bgodavar@quicinc.com>,
        Rocky Liao <quic_rjliao@quicinc.com>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [RESEND PATCH v2 1/3] dt-bindings: net: bluetooth: qualcomm: fix a typo
Date:   Fri,  8 Dec 2023 10:09:34 +0100
Message-Id: <20231208090936.27769-2-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20231208090936.27769-1-brgl@bgdev.pl>
References: <20231208090936.27769-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Spell supply correctly.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 .../devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml   | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
index eba2f3026ab0..ba8205f88e5f 100644
--- a/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
+++ b/Documentation/devicetree/bindings/net/bluetooth/qualcomm-bluetooth.yaml
@@ -69,7 +69,7 @@ properties:
     description: VDD_RFA_CMN supply regulator handle
 
   vddrfa0p8-supply:
-    description: VDD_RFA_0P8 suppply regulator handle
+    description: VDD_RFA_0P8 supply regulator handle
 
   vddrfa1p7-supply:
     description: VDD_RFA_1P7 supply regulator handle
-- 
2.40.1

