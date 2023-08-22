Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA2F6783CCA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 11:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234276AbjHVJYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 05:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230404AbjHVJYW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 05:24:22 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91426113;
        Tue, 22 Aug 2023 02:24:20 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fe61ae020bso6436211e87.2;
        Tue, 22 Aug 2023 02:24:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692696259; x=1693301059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zI3MgR1LXRyYEK7UHlSxA4reZwr5ug/du2XE/mti7jk=;
        b=khyvXxUFO523zkQYiAnT5nDsilCeLi/EH+bHe8RZfETTspSimNLq6iWbWx5M/HgIfR
         WhiNsCK7mRAOXC5B+82L3JLSP+XCLo4NLN2e+QbEhvep3hcn7cUnS1j3c+Q/Q9w20J7o
         GrBajaauq4sMPZG7y3WRXg5x4d+HwMJXOuaHjQ/2ceGRVJRpj5gHLPif9cfyaGHDgKot
         ZrqqQ2d3YwPhZsL+4cLmB9hGFvShDPhrGbrw2YD2wiqd1W+jOtzhtWic4ZZ82OuChvxd
         v7kn+AGL9gNXcvAMuimRiUU1J3DShIAHJBK5KsNv2KQ8ggIE5DK8VNZLRwkyp7734waW
         8REQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692696259; x=1693301059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zI3MgR1LXRyYEK7UHlSxA4reZwr5ug/du2XE/mti7jk=;
        b=cJ41twXJog9sE8X34hOrM56Ym0fvXkrn4L5Op6CTGZi02AnxU4xQQyDZlIUFCKS9M1
         d22dM1dZ8iOB4AadtlHYkyz+yCvF3fyadzlYx3gifTKlgy4b/YqqW+rWD0qCE08HTOYZ
         8gTOHRKN7PLIaTBmp6AXbxvzlD+wUFGXahOV8cp9u96oPVJmVNol/8eFfTzWo/Q3Jfsh
         QzYaWYBtdFp1lFnCSCXFR0A/EnL5HeU1VuSPGZMkK+nLS482SRDUHymzim1qb4E9b6G9
         zZdbz8efniyOjC5Lxko7ndaoWZlfHw0IbSbOqJvNXQ5WrFyiD4D2uKegK2ldBhQvlMOY
         +pyQ==
X-Gm-Message-State: AOJu0Yx1xcD++Lb7XbClKqoAvv7oe2w4lWxyC9wku+WMRG5EjT/qIoG3
        frIu1EFCbeF32xnn5b4jKTU=
X-Google-Smtp-Source: AGHT+IFgl1be/hZeWP4yJbdiroqhm01VYXbNSKEn50xeY1C5Tc/vVDIi451lfLVqFug/63K3oboHSA==
X-Received: by 2002:a05:6512:2029:b0:4fb:740a:81ae with SMTP id s9-20020a056512202900b004fb740a81aemr5613049lfs.16.1692696258484;
        Tue, 22 Aug 2023 02:24:18 -0700 (PDT)
Received: from localhost.localdomain ([2a05:3580:f312:6c00:826c:ae47:61a7:8af8])
        by smtp.gmail.com with ESMTPSA id j5-20020ac253a5000000b005007c6ea158sm1109372lfh.254.2023.08.22.02.24.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Aug 2023 02:24:17 -0700 (PDT)
From:   Andrey Skvortsov <andrej.skvortzov@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Kees Cook <keescook@chromium.org>,
        Tony Luck <tony.luck@intel.com>,
        "Guilherme G. Piccoli" <gpiccoli@igalia.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Jarrah Gosbell <kernel@undef.tools>,
        Arnaud Ferraris <arnaud.ferraris@collabora.com>,
        Pavel Machek <pavel@ucw.cz>
Cc:     Andrey Skvortsov <andrej.skvortzov@gmail.com>
Subject: [PATCH v2] arm64: dts: pinephone: Add pstore support for PinePhone A64
Date:   Tue, 22 Aug 2023 12:23:58 +0300
Message-Id: <20230822092358.309835-1-andrej.skvortzov@gmail.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230821160817.GA2227@bug>
References: <20230821160817.GA2227@bug>
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

This patch reserves some memory in the DTS and sets up a
pstore device tree node to enable pstore support.

In general any DRAM address, that isn't overwritten during a boot is
suitable for pstore.

Range from 0x40000000 - 0x50000000 is heavily used by u-boot for
internal use and to load kernel, fdt, fdto, scripts, pxefile and ramdisk
later in the boot process. Ramdisk start address is 0x4FF00000,
initramfs for kernel with some hacking features and debug info enabled
can take more than 100Mb and final address will be around 0x58000000.
Address 0x61000000 will most likely not overlap with that.

Signed-off-by: Andrey Skvortsov <andrej.skvortzov@gmail.com>
---

Changes in v2:
 - Update commit description with information about why this base address is used.

 .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
index 87847116ab6d..84f9410b0b70 100644
--- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
+++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
@@ -19,6 +19,22 @@ aliases {
 		serial0 = &uart0;
 	};
 
+	reserved-memory {
+		#address-cells = <1>;
+		#size-cells = <1>;
+		ranges;
+
+		pstore_mem: ramoops@61000000 {
+			compatible = "ramoops";
+			reg = <0x61000000 0x100000>;
+			record-size = <0x20000>;
+			console-size = <0x20000>;
+			ftrace-size = <0x20000>;
+			pmsg-size = <0x20000>;
+			ecc-size = <16>;
+		};
+	};
+
 	backlight: backlight {
 		compatible = "pwm-backlight";
 		pwms = <&r_pwm 0 50000 PWM_POLARITY_INVERTED>;
-- 
2.40.1

