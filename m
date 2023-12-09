Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1D4280B3B8
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 11:44:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230154AbjLIKoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 05:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjLIKoO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 05:44:14 -0500
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED0010E6
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 02:44:19 -0800 (PST)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-54c79968ffbso3839001a12.3
        for <linux-kernel@vger.kernel.org>; Sat, 09 Dec 2023 02:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702118658; x=1702723458; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x4Hqs9/ZrITwFhPupOGW4Vaim70WWGNp01DNqeiJxRM=;
        b=BEpQoM0rZBzJA0wIlph58J4PbcQHGuwByVDWgaA9l+XxXjuBArPhx3zsgSXr8caxUi
         wpv1aHqM9suMlLw7+jEWXZUlRVNgXHeU2iot7Avf5ksKhnRhnS7hW7rtwoIlJdQqChas
         7vyaFaZB5KI/DnkjNMv9qOHTljGF0e1BFfimc2fdWnRXFODvK3XftyM2jFnfE7/V6PQK
         WH1mmMQkpQs0EsGVd13j5jkLWI/f722FXCPEmPOjK1wDMNslyReS8co5ytlXrqwrNpt/
         Fz7vn9ZQg9AvtPy03ejzeDDO0YPT+s2fcm158yHHax6mtiuXcIxOhYcGX9w/wQyvI1PZ
         IpfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702118658; x=1702723458;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x4Hqs9/ZrITwFhPupOGW4Vaim70WWGNp01DNqeiJxRM=;
        b=PBd/DrQ7iUf3NCaTpvZvO0yPLSSHVQIlHbZ5Az8VqCg0v5izm31789P/gUMhFo26iF
         3Fu9y2MnoMAgfkQqES2dg6IQRixTQbk6Xu5COHqhJotOb7jj2itmkl5UhQa6kDSX7JhX
         hus+dYVS6iyJPbzqPZA29jQSlXnUoAVoKqDtz5Trwsau/XHBrUXgQwLs3Mh76Q4SEvnl
         sAdbP8N5CKyVHWY3gOfwQ6cAlvfJRPvi6PWelZc9cLfMvP0KKugQBXTrwpi/w4PW3TtT
         MEabHwKFd8FP0NKO3GJIUGazyaSAm5NDd0JEQJiVzkNg4qxwO/5xD89ZkoF2vKQ3uNVZ
         5Naw==
X-Gm-Message-State: AOJu0YxQkzK+VJFinZMAcNXqhwDRBw8VOKsbAyo1tVPeeVT9sm7hDFui
        wpc6gcjtfmqkDVY46w2UE5Tz4A==
X-Google-Smtp-Source: AGHT+IEkzNG9N1bAbnaeGgMfxxB2TwMSICgsr4j3JwI3MWSMFxSNj17nraBpbbXjUP70L03CqcJXNA==
X-Received: by 2002:a50:8a99:0:b0:54b:28e9:b283 with SMTP id j25-20020a508a99000000b0054b28e9b283mr717390edj.14.1702118657731;
        Sat, 09 Dec 2023 02:44:17 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id eh12-20020a0564020f8c00b00550e21a4f76sm349604edb.8.2023.12.09.02.44.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 Dec 2023 02:44:17 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@codeconstruct.com.au>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH 2/4] ARM: dts: aspeed: minerva-cmc: correct Mellanox multi-host property
Date:   Sat,  9 Dec 2023 11:44:10 +0100
Message-Id: <20231209104412.12916-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
References: <20231209104412.12916-1-krzysztof.kozlowski@linaro.org>
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

"mlx,multi-host" is using incorrect vendor prefix and is not documented.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
index f04ef9063520..29f042a47e96 100644
--- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
+++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-minerva-cmc.dts
@@ -51,7 +51,7 @@ &mac3 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_rmii4_default>;
 	use-ncsi;
-	mlx,multi-host;
+	mellanox,multi-host;
 };
 
 &fmc {
-- 
2.34.1

