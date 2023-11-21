Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4902B7F293A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 10:47:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234127AbjKUJrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 04:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234108AbjKUJrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 04:47:03 -0500
Received: from mail-pl1-x632.google.com (mail-pl1-x632.google.com [IPv6:2607:f8b0:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CAC4123;
        Tue, 21 Nov 2023 01:46:58 -0800 (PST)
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-1ce5e65ba37so27680095ad.1;
        Tue, 21 Nov 2023 01:46:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700560017; x=1701164817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BCAV9pEXZft0HS/dcoIHi8BP6UZFgoqvZCUuzN8un3k=;
        b=ilDL3NoeQeHCe7CgIdO+3mjd+SoQY+G2vpGtLKcZ0lRIvj5TTWFmvgOOgDgq/0y+B+
         7bs75TJAb9AUeER5kMmhsSrKiNgD0hIjVK9l+y1SXdF0tQT/Esg7I6+CILJAicBIVi/o
         oP1eh9l60/fLwRnTqjguMCU7frEBlSBOLBQ0RabK8R3Ts3iUQCwK3080JlaNLSeUFNBX
         oWMI6bvuONxqNvyI5duRAaYWDu6oz6JFZKUnzLGAkaxbjxgzpOcH2pwyCl2xkkM9E/Lm
         I9/Mtfq7miDHzSZK1ihhYUmie31xeorTsGCbULJfHoCl+rvEyDbaogRxsLf5WHCzSRm7
         kxfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700560017; x=1701164817;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BCAV9pEXZft0HS/dcoIHi8BP6UZFgoqvZCUuzN8un3k=;
        b=EGIpB2jeiI4TjLqqIAENXFbfWO0NkGactE1ye68ckVQqkC8GMKnv8sKm35deapP9y4
         e9UJ4+ARij8aWMZ3TSeh74HckBajFw4U1JTzO6PgshMiXJn5lZPrjQ/cYgF4v1kl6eJ3
         TZG+MF4ZDtAv9lz/fWLCKUENOsWW3A0H79QhCLVRR/Wk0pmx7an9jWiJ0NuLD7S2I1q9
         awRkoFNHUvhBVcrBBVWgRwDp8340FHax2OlJO20uWmvknElumCYRVKs+Bxu/cfruSM1e
         yb06mx3T6ZgREHIwaYy/3DE7njsnSoC6XSVu0Iacxat5ibDjCdscTgjQX0A5EqydMG+A
         WH/A==
X-Gm-Message-State: AOJu0YznzSSdwVoxlFDvcaQRR5dRKQpEKzeccovhkPmeloneUGeJDp1M
        /IkZG1OTkIuMXZPIBFaxzws=
X-Google-Smtp-Source: AGHT+IHdlkUMhUFMpTle56kIPqsDsXlE8rVKVKTjUSo8AGRFTrVPH41FJYsCpu8Ml6FZNJsPfC9DmA==
X-Received: by 2002:a17:903:246:b0:1cc:6078:52ff with SMTP id j6-20020a170903024600b001cc607852ffmr2689886plh.26.1700560017496;
        Tue, 21 Nov 2023 01:46:57 -0800 (PST)
Received: from localhost ([2404:7ac0:4d26:224f:5ec1:6805:f429:17ba])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902b28100b001cf567252besm4903538plr.237.2023.11.21.01.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 01:46:57 -0800 (PST)
From:   Jingbao Qiu <qiujingbao.dlmu@gmail.com>
To:     a.zummo@towertech.it, alexandre.belloni@bootlin.com,
        krzysztof.kozlowski+dt@linaro.org, chao.wei@sophgo.com,
        unicorn_wang@outlook.com, conor+dt@kernel.org, robh+dt@kernel.org,
        conor@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu
Cc:     linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Jingbao Qiu <qiujingbao.dlmu@gmail.com>
Subject: [PATCH 3/3] riscv: dts: sophgo: add rtc dt node for CV1800B
Date:   Tue, 21 Nov 2023 17:46:42 +0800
Message-Id: <20231121094642.2973795-4-qiujingbao.dlmu@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
References: <20231121094642.2973795-1-qiujingbao.dlmu@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the rtc device tree node to CV1800B SoC.

Signed-off-by: Jingbao Qiu <qiujingbao.dlmu@gmail.com>
---
 arch/riscv/boot/dts/sophgo/cv1800b.dtsi | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
index df40e87ee063..89411c75b89a 100644
--- a/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
+++ b/arch/riscv/boot/dts/sophgo/cv1800b.dtsi
@@ -119,5 +119,13 @@ clint: timer@74000000 {
 			reg = <0x74000000 0x10000>;
 			interrupts-extended = <&cpu0_intc 3>, <&cpu0_intc 7>;
 		};
+
+		rtc: rtc-controller@05026000 {
+			compatible = "sophgo,cv800b-rtc";
+			reg = <0x05026000 0x1000>;
+			interrupts = <17 IRQ_TYPE_LEVEL_HIGH>;
+			interrupt-parent = <&plic>;
+			clocks = <&osc>;
+		};
 	};
 };
-- 
2.25.1

