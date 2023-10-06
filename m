Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4F17BB0BA
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 06:12:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230028AbjJFEMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 00:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJFEMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 00:12:25 -0400
Received: from mail-oa1-x2e.google.com (mail-oa1-x2e.google.com [IPv6:2001:4860:4864:20::2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57D2A107;
        Thu,  5 Oct 2023 21:12:22 -0700 (PDT)
Received: by mail-oa1-x2e.google.com with SMTP id 586e51a60fabf-1dd7139aa57so1106639fac.1;
        Thu, 05 Oct 2023 21:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696565540; x=1697170340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oVKOeyfzPTqe/CUiQ9KqX2upeUQqv3i7YeBbchF99cg=;
        b=X31PaMlJA60AjBFamrlz0GE07si2+jQDB9NnMTbueWBBWdYzaUhy35ZiN+EMZnzEYb
         ktOTjR35xABZ3vH8H+eIIk3z4JM84YE5xxN5J/nPEh+8FgHWaDOOkletCedsnPacYJGw
         k3o8Zy/hml+dq6SQ0hy9VAfzp2SdAQLDl01wkkSa87vEk6wOxWpu6lhRBfhGoDEF0STH
         jKiMxr4fx8xRC/TFK6xLnwUyyrG4UyhI5cbzmP3s5G4qBLHapEUhPf6nLIxaSQ2Lu4pX
         eoNGuuyUz5RYlyXCfgyDu5Zk46LJRHpALLMKi65B7yTjCiXxnKOXrBr3ltt9gSivaI4N
         rQcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696565540; x=1697170340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oVKOeyfzPTqe/CUiQ9KqX2upeUQqv3i7YeBbchF99cg=;
        b=fZvTd3tvP1cbN7FviuLr9D3dhHr0+6zOTnxiEJrnx7TGneTYv50d+BvtFWyGnxRiBP
         XIXItPcVnLTbe7mHB/hmNpkRqTdm0IOSXkqeTO+HfzH0DXrKfe2hnX06XDx84OUBGXQw
         8R2lrasUtaq1fGIJmHr/Gv21aP8KlGRMeY/pMvS/fwKKaWQ/83CY3cVdNH+eg0u8cPKg
         /G3pSbOZnb8R2gYRvQ2+bX7IplPgNjIOQC3w3heed52qzAn9ICcomf6WFqhrhvbT5DZC
         v4/os20Y386+eKuCJa6BfCA8PooX9kJzT8MUVmh7esOZ5V9l+KDU1EnJ7Q3FkLzMpVJC
         cPFQ==
X-Gm-Message-State: AOJu0Yz0bUovv+IWppOyLFESvm/EiZbWme1GA5StzhTvYEoGSWF4mYAP
        TzJtUzOFByGmvPLoJ+dYWwaqp5LGyVEJhQ==
X-Google-Smtp-Source: AGHT+IHKShHmFoX6g4eYJMYkSYLJOFe6EddPNVGX6m8IyulpLKYMQXzc/RE5XrQ7C5u/q6l3ytJgYw==
X-Received: by 2002:a05:6870:e2cf:b0:1d6:563b:c3a5 with SMTP id w15-20020a056870e2cf00b001d6563bc3a5mr8732318oad.7.1696565539958;
        Thu, 05 Oct 2023 21:12:19 -0700 (PDT)
Received: from toolbox.iitism.net ([103.15.228.92])
        by smtp.gmail.com with ESMTPSA id t17-20020aa79391000000b00694fee1011asm401131pfe.208.2023.10.05.21.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Oct 2023 21:12:19 -0700 (PDT)
From:   Ayush Singh <ayushdevel1325@gmail.com>
To:     greybus-dev@lists.linaro.org
Cc:     Ayush Singh <ayushdevel1325@gmail.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        vaishnav@beagleboard.org, jkridner@beagleboard.org, nm@ti.com,
        krzysztof.kozlowski+dt@linaro.org, vigneshr@ti.com,
        kristo@kernel.org, robh+dt@kernel.org, conor+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH v8 3/3] dts: ti: k3-am625-beagleplay: Add beaglecc1352
Date:   Fri,  6 Oct 2023 09:40:33 +0530
Message-ID: <20231006041035.652841-4-ayushdevel1325@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231006041035.652841-1-ayushdevel1325@gmail.com>
References: <20231006041035.652841-1-ayushdevel1325@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BeaglePlay board by BeagleBoard.org has a CC1352P7 co-processor
connected to the main AM62 (running Linux) over UART. In the BeagleConnect
Technology, CC1352 is responsible for handling 6LoWPAN communication with
beagleconnect freedom nodes as well as their discovery.

This mcu is used by gb-beagleplay, a Greybus driver for BeaglePlay.

Signed-off-by: Ayush Singh <ayushdevel1325@gmail.com>
---
 arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
index 7cfdf562b53b..5160923b4dc2 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-beagleplay.dts
@@ -870,6 +870,10 @@ &main_uart6 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&wifi_debug_uart_pins_default>;
 	status = "okay";
+
+	mcu {
+		compatible = "ti,cc1352p7";
+	};
 };
 
 &dss {
-- 
2.41.0

