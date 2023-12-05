Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4BC48053E1
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 13:12:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjLEMMm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 07:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235396AbjLEL0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:26:21 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96C4D1720
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 03:23:50 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id ffacd0b85a97d-3333224c7b9so3418026f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 Dec 2023 03:23:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1701775402; x=1702380202; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=dWGEOgBlaV+9GD0eZ+EUXVzemfxXSkN0akB4k15I/sQ=;
        b=TuG7clMsgAuNCb+eIJ4lLSuOhYVfEOKcCcMWx53HP7pOcQIQ/5VnWAuPnixDYyAHl7
         YIbF8cT/OzjFBtxfYaXAqcM0YSipME1C+XaKznTTJRfqgUg3JADclvbwbeXlflzQ3/nf
         qpeHihzxGNAkei4lsgX4s875DZUg1hg2pT9S4Pkra3l1EZ0aNGZ9GmTh4JpRUAihJV+3
         gmFlFTd7mJYAhkJLdWjZJQK34vg5f5vnqhPTbEZfmpn9Vmpgubthb9cbo62Z4gfTHR/w
         dp7BgYDP+UHu3BnPv4QFOOIjyDNBO2wEu4bIYT2a7jsFMeZPEcCFGamaMAz5Zc0DBWxY
         dwCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701775402; x=1702380202;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dWGEOgBlaV+9GD0eZ+EUXVzemfxXSkN0akB4k15I/sQ=;
        b=ibm6vS32maLZxHK6Xi1Bx4djUbrVT4P8NdHUadSfsP/1Cex7T+JuRaTpSBJ5aysdjX
         ZpKk0WOp2LSKiMzTHBaWYXGvhkfIhCEhaQay1ZboGe8QKbHKUxwohFA66nGK4rv6YmJP
         7aDpkEd0RuBM8fj75LOHcqO4uaOMdqgIVukdesvLCKaHMIz+POGRy7aXQYxPVVBht8MT
         jJ6eWvsc7rSs9zNk+/NCoLO6I6eMh4js3F0/cvOAHNZqGGS1WCvkCJqvYlI4olFMAiE4
         IV3djGSPXeKlFhwjb7IqgO7/jh2FsYETjDPXYKi/od6G+fQw9WWTgwTxD/l7j9ciE06Z
         xKMA==
X-Gm-Message-State: AOJu0Yx7kh6vRdhLrbEaQufSRZCpUuZaY45MFnkW0TYMdTt23BblpmLT
        B2xNTnL6Dp/elzKPIh4LSccACQ==
X-Google-Smtp-Source: AGHT+IERJhbMlFae8VaZ0toP10wux4ZqDAU5aWYjeBHgjCeQv0tlJZg2P6EOxMzPBICtQOwgXli8Vw==
X-Received: by 2002:adf:cf10:0:b0:333:272f:b5a9 with SMTP id o16-20020adfcf10000000b00333272fb5a9mr4421979wrj.36.1701775401961;
        Tue, 05 Dec 2023 03:23:21 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:2dd9:dce:96c5:9e9a])
        by smtp.gmail.com with ESMTPSA id p8-20020a5d59a8000000b003333ed23356sm8127775wrr.4.2023.12.05.03.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Dec 2023 03:23:21 -0800 (PST)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 1/3] arm64: dts: qcom: qrb5165-rb5: add an alias for uart6
Date:   Tue,  5 Dec 2023 12:23:09 +0100
Message-Id: <20231205112311.16391-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Alias uart6 to serial1 for qrb5165-rb5. This is the high-speed port used
by Bluetooth.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index c8cd40a462a3..ce6ae0771d34 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -23,6 +23,7 @@ / {
 
 	aliases {
 		serial0 = &uart12;
+		serial1 = &uart6;
 		sdhc2 = &sdhc_2;
 	};
 
-- 
2.40.1

