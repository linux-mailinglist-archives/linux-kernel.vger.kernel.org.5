Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 737257F20A6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 23:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232539AbjKTWtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 17:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232621AbjKTWt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 17:49:29 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC412D2
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:49:25 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-5094727fa67so6867682e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 14:49:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700520564; x=1701125364; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w3IPGNvRYti0737C04DV640y8lLrN0zZWGxZvPfBuQ=;
        b=M4w6FHVX3LRUMRClON2OC7B5vpY/nKiTmNJrkxPFvvIBoz89qgubpOUxrk0oJgvSLu
         VyJr2k/b7HlVaSOYMFwtGuwK1wLYbl7K3AsOXkAMeblID7QfTA/2QBCoxh8ABE0k22TS
         MMYIaKOw1EsXEZZrM8YOwGzI2HyVk3qOxS5AtHZZcA1QssoJLboXBsxe9crtZWhD37UD
         GUSDO4QJXumQWyv1bueA3fwR9lyOjamhjK8xFynenM+WUpuP2DsHICtExWD0l9JLoDGv
         q+b3rJZihnY7M5Jbrk//Fj6bI1B+I4qQbc09ju7hzSH6ErMc6P0rkp9zdv3pP0l+lm9E
         OZHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700520564; x=1701125364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w3IPGNvRYti0737C04DV640y8lLrN0zZWGxZvPfBuQ=;
        b=fU4Vr0ULicGTFFJdVh0DlBTgiWE41do7O2MByR+9duGNdrTGFWk24bN5wgal9xZtt7
         EgnXo3LlBlsX5aqMi1bOlEhSFMX47eRrmj1DeQTBA7PZ5HChcYmN0qIVjOWDminhyWL+
         uFA7EhbNrfa7GlTnbE57cvF6xlrAIrs7nwUgQ+HKg/w6BS0HjQcE+/L+h55rlxAjJGOC
         1aovgay10cOUmSOXjv2CtxhwnugyXFJ2jq2coNAywMwLkB2jRH2CfM+fHpCzWJV4DUlW
         7wgGgF8xSGDmL2qWPxGVR7sWB2nqChaQ8mj7Y/I8BrkLT0WAME1/T1m+3PXFdWVvNtx4
         TaCQ==
X-Gm-Message-State: AOJu0Ywl5Fbqrh1JUoexUAc+R3EIqCw15/0D0pZKawkF0MCVxvJYiVJr
        uStKHfWT4oUszQ1THRGh010bS/gEL25ZhLu4hJl4wcEV
X-Google-Smtp-Source: AGHT+IFD8UwHvlZIXLl531QOdo6XgS1ewvLFiSPtvmWi8CMmPCZ9J2HRygNxOeDgJlm3R/0ER3Qymw==
X-Received: by 2002:ac2:549c:0:b0:509:46ff:6e57 with SMTP id t28-20020ac2549c000000b0050946ff6e57mr6342427lfk.8.1700520564046;
        Mon, 20 Nov 2023 14:49:24 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id c26-20020ac25f7a000000b00503189d8b8csm1297756lfc.198.2023.11.20.14.49.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 14:49:23 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v3 3/3] arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid
Date:   Tue, 21 Nov 2023 00:00:20 +0200
Message-ID: <20231120224919.2293730-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120224919.2293730-1-dmitry.baryshkov@linaro.org>
References: <20231120224919.2293730-1-dmitry.baryshkov@linaro.org>
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

Follow the bindings and use 16-bit value for AltMode SVID instead of
using the full u32.

Fixes: b3dea914127e ("arm64: dts: qcom: qrb5165-rb5: enable DP altmode")
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 arch/arm64/boot/dts/qcom/qrb5165-rb5.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
index c8cd40a462a3..88b37ceb13ed 100644
--- a/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
+++ b/arch/arm64/boot/dts/qcom/qrb5165-rb5.dts
@@ -1425,7 +1425,7 @@ PDO_FIXED_USB_COMM |
 
 		altmodes {
 			displayport {
-				svid = <0xff01>;
+				svid = /bits/ 16 <0xff01>;
 				vdo = <0x00001c46>;
 			};
 		};
-- 
2.42.0

