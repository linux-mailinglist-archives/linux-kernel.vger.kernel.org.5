Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10614785903
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:19:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234601AbjHWNTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235814AbjHWNSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:18:34 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4D410EA;
        Wed, 23 Aug 2023 06:17:58 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2bcd7a207f7so18110571fa.3;
        Wed, 23 Aug 2023 06:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692796638; x=1693401438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gCkeO3JMTWnAck68Ec8pL9VBr1IQgmzcgGRPd/I418Q=;
        b=HHtL5kjzz9CC75rSGGBlEATePuGnbCNdaaRHirXhA8oryVb0k/uQZAXAVgigFYDGvD
         4rLRJDPfVM5oJOfqgaaZWd9SRVV7ZJ9v20yzMkiAKpcu1upmMIuM/1jv7OeYQEPCwwnc
         KxIv5GTjHAZdcZLqfn9kZBy9etsiWdHmAsx6tovC1VP8g5qlrRIxjSlwbbChMPVX4LIJ
         3iU3WoT1HSc7J7UW3RIdnS2C6rzRf653gYmWtsWVkO6XwafAq8wauIZaos2ZT5M/TpGM
         Kv2CzDxiBNuU8OrV/fzvLtAvY4kIDFP07SFewBZeWjpnpk+376iOYfW1NmXj1udyfqZu
         4QGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692796638; x=1693401438;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gCkeO3JMTWnAck68Ec8pL9VBr1IQgmzcgGRPd/I418Q=;
        b=PCinEUkFO8OTfJsPaVSZ/B2dQ6iF9MhJHSrH/gQah7QSMQyitqpCyh9NdH4RADjNX5
         D3XC6qMP527VQM56g8QNVI0wnGPjuu4bNjARiIJEBcqyRcrd4dVhJ5vWTt1YwpcwA5sM
         rJMCdoJ+1hjKJIrne7cMiLvrcvzeWVq4kkR8UqBXj3zaoEZj+bRlMsx4sjv59oqzqR++
         x223oiauwDUgl9TDQ7WDMVQfMizAG/i+meuCRpg14AsjnlNZWZUm5Cpki9XWTkWUbN05
         y8vE6bXaO6BlKEBGrXvAaR1hG5QWF5PTYWz6tGbd6RrGcFIH/B5NgX+iHi+uoiUZTTNh
         +SGQ==
X-Gm-Message-State: AOJu0Yyo59mkoMpFMYD3AHYnasftCrJdu9gIeIPvGkj8oRAmkuwnVlwL
        gz760clS1GCLYlwjZxaoOkQ=
X-Google-Smtp-Source: AGHT+IHsC8O1Dq5TVhEX9ZRsOegPJCDRHJD3up522LXRl9bLZX1msmlAVl5aMPUj2r2JwDGJl5PCmA==
X-Received: by 2002:a2e:7d04:0:b0:2b8:3ac9:e201 with SMTP id y4-20020a2e7d04000000b002b83ac9e201mr9171906ljc.40.1692796638300;
        Wed, 23 Aug 2023 06:17:18 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id e1-20020a05600c218100b003fc080acf68sm22463192wme.34.2023.08.23.06.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 06:17:18 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     jakob.unterwurzacher@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-haikou
Date:   Wed, 23 Aug 2023 15:16:51 +0200
Message-Id: <20230823131651.586934-2-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com>
References: <20230823131651.586934-1-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Having sgtl5000_clk defines as "fixed-clock" is not enough to prevent
the dai subsystem from overwriting the frequency via sgtl5000_set_dai_sysclk.

Setting system-clock-fixed does the job, and now a 1kHz sine wave
comes out as actually 1kHz, no matter the sample rate of the source.

Testcase: These should sound the same:

 speaker-test -r 48000 -t sine -f 1000
 speaker-test -r 24000 -t sine -f 1000

Also remove the clock link here as having it in sgtl5000 and
sgtl5000_codec causes duplicate clock unprepares with associated
backtrace.

Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index dafeef0c2dab..2cad02096271 100644
--- a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
+++ b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
@@ -72,8 +72,10 @@ i2s0-sound {
 		simple-audio-card,bitclock-master = <&sgtl5000_codec>;
 
 		sgtl5000_codec: simple-audio-card,codec {
-			clocks = <&sgtl5000_clk>;
 			sound-dai = <&sgtl5000>;
+			// Prevent the dai subsystem from overwriting the clock
+			// frequency. We are using a fixed-frequency oscillator.
+			system-clock-fixed;
 		};
 
 		simple-audio-card,cpu {
-- 
2.39.2

