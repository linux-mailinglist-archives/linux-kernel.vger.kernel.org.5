Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E721680D023
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:56:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjLKP4S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:56:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344406AbjLKP4Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:56:16 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDB49B3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:56:22 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-a1ceae92ab6so622615866b.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Dec 2023 07:56:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702310181; x=1702914981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RybQrZs+eLSsMdObNv4v0HXZw2o3tDH/SAM3kDy3DRI=;
        b=MFl9GU4gvkIyipf5vnUO2TXGyOFCU5csi5ZOr8UiBcs+oM9u6kyeGXozcEz8nghU06
         VBqttOGHrgSFr9mCFKg7aEBkkpBvFdo0ga9Avkp5xACchYtbKMYepoMqenS282k/8A3b
         l7+zn2iO4bk9v6KfRdcZBIVh2tNZvdB5N7BAFGjja+dDJxOmkF3ueBNm5cX0UCkpOeV5
         O1lCursH1zOa82vYffK9xF0Y9/hvZJUtv0vpaHAcSN4S6HVaOD3MXs7ePhjb5dwF7rsw
         +INzjOIWG4SHHHopcBZKrIGVffZDDt1n0vJK90xkMNrJJCP4NuHZudp5Hzu4T9IvuFZe
         JoCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702310181; x=1702914981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=RybQrZs+eLSsMdObNv4v0HXZw2o3tDH/SAM3kDy3DRI=;
        b=mWg7nOf5oGhDSM4liRsbtYFwLHv7GwQ/Yiuv4FPLWvVZlhgnGxYdLroLCX9FGeFE6I
         BnFbUhhoDcgfQdft5yvkGGVE4UpYi4emKPbrfI6rp+t21OfwJTHiBL54W1A+y8cAXVR/
         Vlnko06bWtXzagM5XGOCioRjEFSHSoceKNjY5YDRqvki6UADPgbXIxiSsfNGsl3MeY4n
         RrevPzjw42RPUjTnVIhDq7lZL3SS0MtBRsUWPEz42+UCXkxuf1aFJ1VrjLIBTM1hJKIU
         dyOmQYiLCfNFi/mDvFgvNIewu6wl7rFGrqDz7Ikt8bgNt9s8aOvMzhA1wCVx43HShyxO
         WNkQ==
X-Gm-Message-State: AOJu0YxEm0ueNNUo7/K1/DiRS05N5G8lN95JJaBqq4PkHfbXBDSrDnI6
        QRopRKm6ZIxbud3rDzN9wTXSog==
X-Google-Smtp-Source: AGHT+IEQ5hYta5LdO6d4vzHPw3b9RjbZ+VcrlqMEDmZGTKb+VdwmNjF/2DI6kyj5TmutkUe3+P4XLw==
X-Received: by 2002:a17:907:94c9:b0:a11:2ad2:6563 with SMTP id dn9-20020a17090794c900b00a112ad26563mr2910577ejc.26.1702310181330;
        Mon, 11 Dec 2023 07:56:21 -0800 (PST)
Received: from krzk-bin.. ([2a04:ee41:3:e085:3572:d83d:98f3:19dd])
        by smtp.gmail.com with ESMTPSA id lm11-20020a17090718cb00b00a1cf3fce937sm4983602ejc.162.2023.12.11.07.56.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 07:56:20 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>
Subject: [PATCH] qcom: MAINTAINERS: move Andy Gross to credits
Date:   Mon, 11 Dec 2023 16:55:33 +0100
Message-Id: <20231211155533.106003-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Andy's last emails related to Qualcomm SoC ARM subarchitecture are from
November 2019, so move him to credits.  Stale maintainer entries hide
information whether subsystem needs help, has a bus-factor or is even
orphaned.

Link: https://lore.kernel.org/all/?q=f%3A%22Andy+Gross%22
Cc: Arnd Bergmann <arnd@arndb.de>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <andersson@kernel.org>
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 CREDITS     | 4 ++++
 MAINTAINERS | 1 -
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/CREDITS b/CREDITS
index 59cdc6a9c8fd..6cb661c46985 100644
--- a/CREDITS
+++ b/CREDITS
@@ -1421,6 +1421,10 @@ S: University of Stellenbosch
 S: Stellenbosch, Western Cape
 S: South Africa
 
+N: Andy Gross
+E: agross@kernel.org
+D: Qualcomm SoC subsystem and drivers
+
 N: Grant Grundler
 E: grantgrundler@gmail.com
 W: http://obmouse.sourceforge.net/
diff --git a/MAINTAINERS b/MAINTAINERS
index 82ef00014f41..37d1bb7b1fc5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2550,7 +2550,6 @@ F:	arch/arm64/boot/dts/qcom/sc7280*
 F:	arch/arm64/boot/dts/qcom/sdm845-cheza*
 
 ARM/QUALCOMM SUPPORT
-M:	Andy Gross <agross@kernel.org>
 M:	Bjorn Andersson <andersson@kernel.org>
 M:	Konrad Dybcio <konrad.dybcio@linaro.org>
 L:	linux-arm-msm@vger.kernel.org
-- 
2.34.1

