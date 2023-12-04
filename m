Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 771A0802A22
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:06:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234277AbjLDCDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234307AbjLDCDD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:03:03 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2296EFF
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:03:09 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2c9ee6fed3eso20794041fa.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 18:03:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701655387; x=1702260187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7w3IPGNvRYti0737C04DV640y8lLrN0zZWGxZvPfBuQ=;
        b=RuIt6aEXs8YvqAjLVu1VycJ5l75taKd0KGIVnK8Dbcj8QEY6jLV0R2KXy8bUS82b6E
         lbsqKw4flKq9JAIP4R61UGRKrbK81JdVpmzFulpFj/I6iOHdgjKJ/3hEenG8vKlnOwM2
         RwhPlR1YznyNuohXt0MTZClr43lKK/9OlPFuQbzOK9sJ1XhqgIkrsz0U3syfgi0vhfPi
         YMo3cz1+s0CMLgmXq5B4IcJSfUoYuGcmHnwbrQa9pwCa2SMwoni/l2saHET6wcmdN1/K
         ib5S5Hu6DVmy0EAkQfdERE8GGRsKDqDQ8bapOP63lhGigVosTfGvOZk9fzHXkwkagY9o
         W+eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701655387; x=1702260187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7w3IPGNvRYti0737C04DV640y8lLrN0zZWGxZvPfBuQ=;
        b=qRvmUYFKeQcmHo/FLD9IABqtDxPw7LfsJP3Tx4ALZejHssoSYWsrlMI7MjUTE0rOVX
         C1o/b/LcSTN5QuUUAJ7WrzhhaCdixrZWAoqupCE/EEgYcUzDWMfnt0iUe8ZY4Fs4ha5H
         86LBdbD7ETwOJQYsWt9rRElNLZLzT2WDJOtzrFFYQTSnZTg68y4fpAvF5ar/OFWSFDZh
         V2NjvbzjlKL2iKuXbvwfpiVjE807ux4AvQ27u4i2fCJCGhl3xfVog8KMm2QQyR7X2ohQ
         crvR5WHK3hIpyH90M8tslug5VwjJOJPz/RdXdMrllN3HHbqBGGSop2bAmanMydBk309c
         ZnBw==
X-Gm-Message-State: AOJu0YxYiyF4QVKtCi7agHLSMUJfCsOjZj75N/y8yLulxG5gZmzk/Ubg
        F44TA+hau8BUkK2SR/QNCXshig==
X-Google-Smtp-Source: AGHT+IG7QyaVUc2ZKhy1cxZKsZEOS4C6cyPro5nNM707U6/C0w0pXqPIoFPEWzbXku87m7lBxnj77w==
X-Received: by 2002:a05:6512:3ba4:b0:50b:de3b:5359 with SMTP id g36-20020a0565123ba400b0050bde3b5359mr2580077lfv.107.1701655387091;
        Sun, 03 Dec 2023 18:03:07 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b0050bea5c2850sm525381lfr.39.2023.12.03.18.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 18:03:06 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v4 3/3] arm64: dts: qcom: qrb5165-rb5: use u16 for DP altmode svid
Date:   Mon,  4 Dec 2023 04:03:02 +0200
Message-ID: <20231204020303.2287338-4-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
References: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
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

