Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8A1780537
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 06:52:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357888AbjHREvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 00:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357885AbjHREvd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 00:51:33 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFBF35A1
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:51:32 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 41be03b00d2f7-53fbf2c42bfso418597a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 21:51:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1692334292; x=1692939092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TD+gevgj24BK8HPP9GIiWb36T/VnfPNgPphoj/WcGx0=;
        b=LeYl1NvcE31cfFvU2zGE9J5cv1gngt8rryB1sAeEokizuZXe19tFTbtA0Hhh4TVe+v
         2ABCitl7HkikCwBgKVIlMa/nKGlTc1WrSIjOsm5OT1mH2kbV//8CmR4OWqxARI9ZNmHE
         WM7J7AZiVSQsiKli6vfG+P7i7aUqtmxz5tNaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692334292; x=1692939092;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TD+gevgj24BK8HPP9GIiWb36T/VnfPNgPphoj/WcGx0=;
        b=ksAVzLX2FHsII78pNkgf0oJT0slic1rmghOuMN+jExy5eiG4HwLvEZOLUmOwZd0Eu5
         VF7ecJCY7aM/e0JcNCbsnaQr93I0go3k//rPkZcOIDCmaLYDyuePqvuPFmRQGref9hIG
         LWuNApY/MIg6hoQkNRgoS5B/eF4wxtTjtNAQFGh4qm19LxMnSdEUQEgKMqvvyWBmpybG
         JuAf88NVjtga/eZg3A/BYg2Iz5x2O5sE1yCS8kOnSixqorzs27DnpblVGCD0x0JI/YS/
         ChdSco4a5ssAGkNM40BZrFoIItEFT2OMBOcvPl/NPbWbIZTmc8GAHXOU2UZHPO41Y451
         mHuA==
X-Gm-Message-State: AOJu0YzM0+OOxz7zzPzk1g/z/R+/EjGqwzKxyWGLBSDzCQxoj0py0xmD
        UjHhlElx5QWMkAcxLp0i8l0o4A==
X-Google-Smtp-Source: AGHT+IFjIFUEtXq1tnxcTXCexqGlqyUOsce3/7NPFcbB/8zb467vXeOLFQEEiT7xtoEunJegNEbCpA==
X-Received: by 2002:a05:6a20:2593:b0:13e:e3aa:d871 with SMTP id k19-20020a056a20259300b0013ee3aad871mr1699472pzd.53.1692334292110;
        Thu, 17 Aug 2023 21:51:32 -0700 (PDT)
Received: from localhost (97.176.124.34.bc.googleusercontent.com. [34.124.176.97])
        by smtp.gmail.com with UTF8SMTPSA id a2-20020aa780c2000000b00688214cff65sm603812pfn.44.2023.08.17.21.51.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Aug 2023 21:51:31 -0700 (PDT)
From:   yuanhsinte@chromium.org
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hsin-Te Yuan <yuanhsinte@chromium.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Hsin-Te Yuan <yuanhsinte@google.com>
Subject: [PATCH RESEND v2] arm64: dts: mt8195-cherry-tomato: change watchdog reset
 boot flow
Date:   Fri, 18 Aug 2023 04:51:17 +0000
Message-ID: <20230818-send-upstream-v2-1-f10d951a2971@google.com>
X-Mailer: git-send-email 2.42.0.rc1.204.g551eb34607-goog
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
X-Mailer: b4 0.12.2
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Hsin-Te Yuan <yuanhsinte@chromium.org>=0D

The external output reset signal was originally disabled and sent from=0D
firmware. However, an unfixed bug in the firmware on tomato prevents=0D
the signal from being sent, causing the device to fail to boot. To fix=0D
this, enable external output reset signal to allow the device to reboot=0D
normally.=0D
=0D
Signed-off-by: Hsin-Te Yuan <yuanhsinte@google.com>=0D
---=0D
Changes in v2:=0D
- Limit the effect only on tomato.=0D
---=0D
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts | 4 ++++=0D
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts | 4 ++++=0D
 arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts | 4 ++++=0D
 3 files changed, 12 insertions(+)=0D
=0D
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts b/arc=
h/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts=0D
index 2d5e8f371b6de..a82d716f10d44 100644=0D
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts=0D
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r1.dts=0D
@@ -23,3 +23,7 @@ &sound {=0D
 &ts_10 {=0D
 	status =3D "okay";=0D
 };=0D
+=0D
+&watchdog {=0D
+	/delete-property/ mediatek,disable-extrst;=0D
+};=0D
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts b/arc=
h/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts=0D
index 2586c32ce6e6f..2fe20e0dad836 100644=0D
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts=0D
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r2.dts=0D
@@ -43,3 +43,7 @@ &sound {=0D
 &ts_10 {=0D
 	status =3D "okay";=0D
 };=0D
+=0D
+&watchdog {=0D
+	/delete-property/ mediatek,disable-extrst;=0D
+};=0D
diff --git a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts b/arc=
h/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts=0D
index f54f9477b99da..dd294ca98194c 100644=0D
--- a/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts=0D
+++ b/arch/arm64/boot/dts/mediatek/mt8195-cherry-tomato-r3.dts=0D
@@ -44,3 +44,7 @@ &sound {=0D
 &ts_10 {=0D
 	status =3D "okay";=0D
 };=0D
+=0D
+&watchdog {=0D
+	/delete-property/ mediatek,disable-extrst;=0D
+};=0D
=0D
---=0D
base-commit: 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4=0D
change-id: 20230818-send-upstream-e91e615a893c=0D
=0D
Best regards,=0D
-- =0D
Hsin-Te Yuan <yuanhsinte@google.com>=0D
=0D
