Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4577973C2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Sep 2023 17:31:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242592AbjIGP3D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Sep 2023 11:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242523AbjIGP1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Sep 2023 11:27:32 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB3BCA;
        Thu,  7 Sep 2023 08:27:03 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-52683da3f5cso1454216a12.3;
        Thu, 07 Sep 2023 08:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694100391; x=1694705191; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nn8Z/jGqRZ9itG0RlqprNFY2blvA+oxqrFjdAqCBlzs=;
        b=C3Im3a1ra+SVZXOORLDjh0gSoxXefDvj21uWXq630Papi55WqXtKk36YcHl5eJoi0+
         hPI6Yedce9COjtaC3Yee8WU5inAIj9NORagshY9+sbsYCwxO7zo5KXmbAXN7agwiebhD
         nubasRkNpik9zECiiQ4xnxuhvNyglfgIEUDAIEERB8MZ6seow/fdcSGnOmuqrOcU0shk
         hgdIzByyar2tp30r8cQT0baK1PgLEzzfzSNuJ4uWkfiQMvhRIQwXzUYGvbCM6IP8vUYc
         VNKrkxrxRYJHGIF/ojAFq1FIcv0meciRVRs56YZKeVu7bDuglixZIuvJiGdaajQ4c2ZV
         vBOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1694100391; x=1694705191;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nn8Z/jGqRZ9itG0RlqprNFY2blvA+oxqrFjdAqCBlzs=;
        b=VcqUqpXNjxAkmS5IlIhBwXKNRWtraXfnC+EGW/VyeHSTf5XaK45+1rM1R4gqp+ws8+
         /fjDemPPIwVvDbnUi3cAukkPI3PR23uOitY4JSFcHoTuGlyyxWmKQnorquagCn612ghC
         2F77di5PP8GR5JS68G54+Eh/P8oss9HU1b520J6+SDioOqjc+TnqPiZ8QnFMGu+6Tbaq
         Mrp8wZ/glQaHEeib6ub3FH6cu5JUv/EaxtOniW6a+3EliDhy2cDy04xeCQXbqK0r9tv/
         ppzTIzrL3Nxh0Tm76qMdIzSo4HZOJXzaBeTWPnacDLdlUEISQGrb4mjtNbbwXhqdnWO3
         nSSg==
X-Gm-Message-State: AOJu0Yzd8fSHZyjTQ1KfT2CQesZ5FlwfhOWyW5W0zcTEM1zJoBBUytIf
        rXSw/rFBS6U647AsZz/be//o8gKzNCMx3Q==
X-Google-Smtp-Source: AGHT+IGwqB/QeKYr78Cb/wkxyZKiPbzH4gGpc1Z9STFRTx1jV4gSJPT2SnI8z4IiTAFD941kik9PbQ==
X-Received: by 2002:a5d:4105:0:b0:314:3740:7f69 with SMTP id l5-20020a5d4105000000b0031437407f69mr4401146wrp.37.1694099897397;
        Thu, 07 Sep 2023 08:18:17 -0700 (PDT)
Received: from opti3050-1.lan (ip092042140082.rev.nessus.at. [92.42.140.82])
        by smtp.gmail.com with ESMTPSA id l16-20020adfe9d0000000b00317e77106dbsm23511973wrn.48.2023.09.07.08.18.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Sep 2023 08:18:17 -0700 (PDT)
From:   Jakob Unterwurzacher <jakobunt@gmail.com>
X-Google-Original-From: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>,
        Ermin Sunj <ermin.sunj@theobroma-systems.com>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Cc:     stable@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/2] arm64: dts: rockchip: set codec system-clock-fixed on px30-ringneck-haikou
Date:   Thu,  7 Sep 2023 17:17:16 +0200
Message-Id: <20230907151725.198347-2-jakob.unterwurzacher@theobroma-systems.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230907151725.198347-1-jakob.unterwurzacher@theobroma-systems.com>
References: <20230907151725.198347-1-jakob.unterwurzacher@theobroma-systems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Cc: stable@vger.kernel.org
Fixes: c484cf93f61b ("arm64: dts: rockchip: add PX30-µQ7 (Ringneck) SoM with Haikou baseboard")
Signed-off-by: Jakob Unterwurzacher <jakob.unterwurzacher@theobroma-systems.com>
---
 arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts b/arch/arm64/boot/dts/rockchip/px30-ringneck-haikou.dts
index 8792fae50257..de0a1f2af983 100644
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

