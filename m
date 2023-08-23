Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ABF27857D3
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 14:20:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235051AbjHWMUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 08:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234605AbjHWMUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 08:20:32 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC145E69;
        Wed, 23 Aug 2023 05:20:29 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-31c3df710bdso2871155f8f.1;
        Wed, 23 Aug 2023 05:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692793228; x=1693398028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S0PcjJ9/tpEyzgWyGCozvGUJD+4alNset4hxE/zN5P4=;
        b=lp7CyabF9Pw8kMokiEHWY0IZr8JB86eYd+goysr2mkHjjdpku0xn91F2wCLWE+3cgJ
         /Z6frzFHUBWWoB4QmD13ufXhR0o0JytjC8aKOHcGesSQB6ext8qcRRQUqL2DWY+IcCJO
         gHYOom39IabzaKggFoIGTZ1Q3s1TQ60llID5Wmm09EDBwcgp4p4nQJkkVQt/uUMvsbtZ
         pbPA1m6vWrNSuvY+sioYiod1gJGSLAjFkF3Z3D/zRkzMHO0Z/WpgLKwZ2SB6zLSMzelU
         ip82XIZmzOYMTp3RLAaVKU8EJKEDSS1gYEh5kFELN6aVD/stcuRgfnr//JTi5ltb7EA4
         ygcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692793228; x=1693398028;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S0PcjJ9/tpEyzgWyGCozvGUJD+4alNset4hxE/zN5P4=;
        b=a7w0/dpwAhbcfUT8+f0G9BXXjOT/htDErSFAlRZ6lOWqNNaIlXrlJy3NwA8QdV8V3R
         EPJe6zVBZo+h+9TOVYBrJ+mb7RqzY7Jb7Hf/AK1MuR7bRXBpwXI6+XjWNFaSfs1KHtx9
         ttpvYay6Rn/k2B4EVBsyal//VM226KJaNuuDitM0UiB4767JmVwcWxITEZHeKlLbfSLX
         vb2r/J2yauig44RSXcHT7aZt+06HXN308Oigiy7PbIHybfzBtLFRzlyMbDdZLPvwr0Wk
         P5OGdjcijEGkp7ZKy+M7egy/Bp04J3yV2Th+MsGwONJfIjZmkuwhfr7BbrYOOfR6nz2F
         8eLg==
X-Gm-Message-State: AOJu0YxnBOKu2gnq54YR3wIhs6OxUkrPbazKvAaxMrQfjhOiCOTcLqey
        wgULYzt+jm7H8MvAF/O+QJRi05evGyngVA==
X-Google-Smtp-Source: AGHT+IHdOObfzHaSlbCwyRwlQdkYL3vpdYaYAdGh9ZsTlwPkRCy7BY4zwFQGs4oPumfuVyR+qFOa/A==
X-Received: by 2002:adf:e84f:0:b0:31a:d112:954e with SMTP id d15-20020adfe84f000000b0031ad112954emr8628421wrn.46.1692793228210;
        Wed, 23 Aug 2023 05:20:28 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id w16-20020a5d6810000000b003197b85bad2sm18909196wru.79.2023.08.23.05.20.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Aug 2023 05:20:28 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     jakob.unterwurzacher@theobroma-systems.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] TSD: arm64: dts: rockchip: set system-clock-fixed in sgtl5000_codec
Date:   Wed, 23 Aug 2023 14:20:00 +0200
Message-Id: <20230823122000.585787-2-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com>
References: <20230823122000.585787-1-jakob.unterwurzacher@theobroma-systems.com>
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

