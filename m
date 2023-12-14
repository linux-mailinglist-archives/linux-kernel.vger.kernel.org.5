Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A9B7812D0C
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Dec 2023 11:35:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1443674AbjLNKeq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Dec 2023 05:34:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1443659AbjLNKeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Dec 2023 05:34:37 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 520BCA6;
        Thu, 14 Dec 2023 02:34:44 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-3363e9240b4so255495f8f.0;
        Thu, 14 Dec 2023 02:34:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702550083; x=1703154883; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y0a4gKP5gtrabO/Q+KI+zErFhUsDo6C0jBoUDN/BuNw=;
        b=Ulqv/kTn6DSCGrQrD7UJfsLODuwPo0nDdleUKfoY1pqu//QMthx8tpKlAY3iFJBfNZ
         mZegDFzb+iLRu0al+bZi/ydhYRPkYxCbbidE0FmDK7ipDv4UM1VvcwjQTlFBuCaZuCdW
         dsfN8azSP82WjDzUZRudjYsxcBoquMdZfSzaZIgSYz+ZvQAXScxB9VDMn2sczdYdU3k3
         uv1cA9YqiJUW+CICQgu3Eb6Va7JyEbM+Ch8139U+7KZU9eb26Wa071XmGB1HLQ9GF48S
         J1WZmAuwBdbPm63DS+pEMs6OKNMIpYkOX6ASHBpHYULIZuPHqzcxuNK+a+rDIamQhULj
         TO1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702550083; x=1703154883;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y0a4gKP5gtrabO/Q+KI+zErFhUsDo6C0jBoUDN/BuNw=;
        b=k0IjRzjUJ9/tsn6TBQa+O3RYE3XfNWodsIxIrzNYBJdsm+MU0UvPOtxf+qHi0LqVLW
         cldw0/Ij2ivTCQ2IlbUwuCWiLX6FJkkf4a3bVedBG6ChujpEn/b6gYWjTWbYcckufHSs
         rX6ZacP80oMjUggRoXYLUVUSZqNKJRVcAmwRJSvKZpannObtq0GTxHLNyCcvAMVBFH2O
         3hPNVzxfAtWsfyOPhQE2YAZR8Mx2WavSW1XWFRF+wBu4vU3VjP8u4q4/ODHXx4Iky8+6
         xngkd8wAgA78uhBCONtcgOE3W4W+BtBrZ53QccB31Ynf+uwhv16hpFBN/rd5BPZLiaL7
         3Hvw==
X-Gm-Message-State: AOJu0YwUJoTl9D01oqKcuFgY/3lhfU8Daqa6afBURmKK51sjIOde3Dz3
        7Qtjf7Ga0mrCjzJxaKU9fwg=
X-Google-Smtp-Source: AGHT+IFPVXHLmiez1c1QHJ6CdvlmAC2BBhWMXcwVlLmX7+8rd1VLGR63bHn6K6EuANrCno+ey5HLvQ==
X-Received: by 2002:adf:e904:0:b0:336:4176:9229 with SMTP id f4-20020adfe904000000b0033641769229mr1327326wrm.54.1702550082488;
        Thu, 14 Dec 2023 02:34:42 -0800 (PST)
Received: from localhost.localdomain ([129.0.226.240])
        by smtp.gmail.com with ESMTPSA id e4-20020a5d65c4000000b003333ed23356sm15849623wrw.4.2023.12.14.02.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 02:34:41 -0800 (PST)
From:   Brandon Cheo Fusi <fusibrandon13@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Yangtao Li <tiny.windzz@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        Brandon Cheo Fusi <fusibrandon13@gmail.com>
Subject: [PATCH 1/5] riscv: dts: allwinner: Update opp table to allow CPU frequency scaling
Date:   Thu, 14 Dec 2023 11:33:38 +0100
Message-Id: <20231214103342.30775-2-fusibrandon13@gmail.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20231214103342.30775-1-fusibrandon13@gmail.com>
References: <20231214103342.30775-1-fusibrandon13@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Two OPPs are currently defined for the D1/D1s; one at 408MHz and
another at 1.08GHz. Switching between these can be done with the
"sun50i-cpufreq-nvmem" driver. This patch populates the opp table
appropriately, with inspiration from
https://github.com/Tina-Linux/linux-5.4/blob/master/arch/riscv/boot/dts/sunxi/sun20iw1p1.dtsi

The supply voltages are PWM-controlled, but support for that IP
is still in the works. So stick to a fixed 0.9V vdd-cpu supply,
which seems to be the default on most D1 boards.

Signed-off-by: Brandon Cheo Fusi <fusibrandon13@gmail.com>
---
 arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi | 18 +++++++++++++++---
 1 file changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
index 64c3c2e6c..e211fe4c7 100644
--- a/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
+++ b/arch/riscv/boot/dts/allwinner/sun20i-d1s.dtsi
@@ -39,16 +39,22 @@ cpu0_intc: interrupt-controller {
 	};
 
 	opp_table_cpu: opp-table-cpu {
-		compatible = "operating-points-v2";
+		compatible = "allwinner,sun20i-d1-operating-points",
+				 "allwinner,sun50i-h6-operating-points";
+		nvmem-cells = <&cpu_speed_grade>;
+		nvmem-cell-names = "speed";
+		opp-shared;
 
 		opp-408000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <408000000>;
-			opp-microvolt = <900000 900000 1100000>;
+			opp-microvolt-speed0 = <900000>;
 		};
 
 		opp-1080000000 {
+			clock-latency-ns = <244144>; /* 8 32k periods */
 			opp-hz = /bits/ 64 <1008000000>;
-			opp-microvolt = <900000 900000 1100000>;
+			opp-microvolt-speed0 = <900000>;
 		};
 	};
 
@@ -115,3 +121,8 @@ pmu {
 			<0x00000000 0x0000000f 0xffffffff 0xffffffff 0x00020000>;
 	};
 };
+
+&sid {
+	cpu_speed_grade: cpu-speed-grade@0 {
+		reg = <0x00 0x2>;
+	};
+};
-- 
2.30.2

