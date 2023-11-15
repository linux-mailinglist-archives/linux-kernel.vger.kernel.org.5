Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A613F7ED5D0
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Nov 2023 22:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235079AbjKOVOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 16:14:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229912AbjKOVOd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 16:14:33 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE210AB;
        Wed, 15 Nov 2023 13:14:29 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4084095722aso612655e9.1;
        Wed, 15 Nov 2023 13:14:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1700082868; x=1700687668; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9gXOLsGU3AINvslcQJP0ar2ZCwMWGBkoqrhSNtYcZ/g=;
        b=CSIqWLkxwSuH/aJsP5K+KSMkKwClapfEWW8eKPSR896e3+XgKmRW/+D/sn99YVVMV5
         6rT1kGLIWXVlnWyFrjArmcySeGdZfdHTuAKfd9HdQrd8+LKQU2vZB4SfnQk239DYgTvC
         /IsXUT4y36NDfFuQoF3pXofSp12SfQr0G3nJTtnLpRPVPwnkEncv4Eo3zvmwDq3MFBh7
         2GRPrCu246Vx3Nw8YX3CDiXqGmTMrEmv0oBKsvUHklYKmGT9Fh5+H5Z6Bxf2shsGw4TD
         UZQ28NJbeaxN2zpyzYDBc7b3ddn3xAkmJCVEyi1ww3LMSwj4hVrhdQ6ThA/Iqt6wyCsb
         yXDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700082868; x=1700687668;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9gXOLsGU3AINvslcQJP0ar2ZCwMWGBkoqrhSNtYcZ/g=;
        b=LUDQljwehD6/BHz68pJWwejU5eeQTblDXeCUlP5OVhrU3Mg1BxjLRftLbuzd2CVMVi
         lH4QVKEc+pQ5g0yscuvk/MivJ0n0aQ6Gu4/MKIgMSZRMPQtDSIGL5aYzrGkVE6TguP/q
         85YhcyrWcOCGIyNPHJOnTTFbSoFsRr1UCV/boTmci2SfCwUIOEfRbVv7Qmmw33eCWHv4
         1vMseeldjByuelEvklU4pY55vtGu6LDFAwt8SyniSMDM7W5MPiwhU3OmB2vQAweW9/gQ
         yqW+Ayg1xZDmnPOI0JjBJXDaWJk9f+c3lQqgLZ/x5glqUuylwPs2WR71liaoBfc71neE
         D2sw==
X-Gm-Message-State: AOJu0Yz5e5XMNWG7P+99IKpO+pLa9ip8cSbCzevmR/Qg/yr5floGAJz2
        6/FK4CKj0K/7atmGPxfRldM=
X-Google-Smtp-Source: AGHT+IGK2jZWMyflqY75RqE/8465MfElaZToFqc/PjwUAdTbeQvV2DFkhZAMQyL8zkNzG5Hfsvg/rg==
X-Received: by 2002:a05:600c:4c12:b0:401:d803:6243 with SMTP id d18-20020a05600c4c1200b00401d8036243mr11607667wmp.32.1700082868138;
        Wed, 15 Nov 2023 13:14:28 -0800 (PST)
Received: from prasmi.home ([2a00:23c8:2500:a01:e8e:4851:e049:93fd])
        by smtp.gmail.com with ESMTPSA id l10-20020a5d674a000000b0032d09f7a713sm11524885wrw.18.2023.11.15.13.14.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Nov 2023 13:14:27 -0800 (PST)
From:   Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc:     Magnus Damm <magnus.damm@gmail.com>, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH] dt-bindings: usb: renesas,usbhs: Document RZ/Five SoC
Date:   Wed, 15 Nov 2023 21:14:07 +0000
Message-Id: <20231115211407.32067-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.34.1
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The USBHS IP block on the RZ/Five SoC is identical to one found on the
RZ/G2UL SoC. "renesas,usbhs-r9a07g043" compatible string will be used on
the RZ/Five SoC so to make this clear and to keep this file consistent,
update the comment to include RZ/Five SoC.

No driver changes are required as generic compatible string
"renesas,rza2-usbhs" will be used as a fallback on RZ/Five SoC.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
 Documentation/devicetree/bindings/usb/renesas,usbhs.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
index bad55dfb2fa0..40ada78f2328 100644
--- a/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
+++ b/Documentation/devicetree/bindings/usb/renesas,usbhs.yaml
@@ -19,7 +19,7 @@ properties:
       - items:
           - enum:
               - renesas,usbhs-r7s9210   # RZ/A2
-              - renesas,usbhs-r9a07g043 # RZ/G2UL
+              - renesas,usbhs-r9a07g043 # RZ/G2UL and RZ/Five
               - renesas,usbhs-r9a07g044 # RZ/G2{L,LC}
               - renesas,usbhs-r9a07g054 # RZ/V2L
           - const: renesas,rza2-usbhs
-- 
2.34.1

