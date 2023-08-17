Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 582BA78000B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 23:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355393AbjHQVkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 17:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355389AbjHQVjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 17:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E44742D68
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692308317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FqqZicTGV7T3Kk10xXAHHZqVsDBeCNcyh9Qza7vGkZ8=;
        b=E1/nQsg7rGooTR9UYOJiuhCUCduKPRBwe9EXKiLKNEZo7SPh/sgAtMRY1DHIDUnwFyCixr
        neoNvTILaSvV2GVfHdFxn7vi0MMe8wH4Ih96Jc8ugvvM73Es3ZiD6lLR9WUuvqrV+WfzAB
        tnR7FMZZkCaci65kXamIAwApxfpphxc=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-c7zmcEJ5OW-BtAYC7FllnQ-1; Thu, 17 Aug 2023 17:38:35 -0400
X-MC-Unique: c7zmcEJ5OW-BtAYC7FllnQ-1
Received: by mail-qk1-f198.google.com with SMTP id af79cd13be357-76c83aab2c7so34208985a.0
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 14:38:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692308315; x=1692913115;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FqqZicTGV7T3Kk10xXAHHZqVsDBeCNcyh9Qza7vGkZ8=;
        b=gLfU/e+yNSNRwWXcbJRBgWOoesYCLbbTfjBlq/WWinlIm46bj0lzERpIoccUBWRTHr
         OZThrvR+YGxOZXwo6G6lO7cBZVHZzkaMSDun6upafFVIX08xJbOuOcDOUJ03RuWyXgPx
         o2MiqKWhdAgOQOKMIbn270XU37M6XfZc3hF8ZL7N3UB7rOfiaWzs5/P5DMWf1VpTwW92
         YGDlpYkfSk/nOROWcyIKvNfQhdHAd5lb4KKMOgVtv6EwYWnErOSxktG6c4oMYnaxrEVI
         gr+Raz/qlzVDsgFQ1bqCcbhrTi5UO8y/bbaMCkIamqiwjR05PJ5n/E5oEY7j25Vp1Z6/
         tY5Q==
X-Gm-Message-State: AOJu0YywdOMhjGwdzH4X1VPJPhmg+CafeGCJbo5Tx0bE5obDWZhJu875
        l75wPypeFP5IKlFXyP25Fv9WYugNZkJnoIQPUNawJEzXMt1STm8NCNnsrMcKMCCdapGLOp1AI50
        Wh9MmEGY4uxfqD3cVnPvwev5X
X-Received: by 2002:a05:620a:4451:b0:75b:23a0:d9e1 with SMTP id w17-20020a05620a445100b0075b23a0d9e1mr1197247qkp.55.1692308314962;
        Thu, 17 Aug 2023 14:38:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEkp3rZRvDcTzFKJ6Hqm2t/JobO+mLJ0a7jWTkq/V/9LaaPUGogroqre6KXatk72o3i6DIw8Q==
X-Received: by 2002:a05:620a:4451:b0:75b:23a0:d9e1 with SMTP id w17-20020a05620a445100b0075b23a0d9e1mr1197225qkp.55.1692308314722;
        Thu, 17 Aug 2023 14:38:34 -0700 (PDT)
Received: from fedora.redhat.com ([2600:1700:1ff0:d0e0::37])
        by smtp.gmail.com with ESMTPSA id s1-20020ae9f701000000b0076c71c1d2f5sm96547qkg.34.2023.08.17.14.38.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Aug 2023 14:38:34 -0700 (PDT)
From:   Andrew Halaney <ahalaney@redhat.com>
To:     andersson@kernel.org
Cc:     agross@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, brgl@bgdev.pl,
        Andrew Halaney <ahalaney@redhat.com>
Subject: [PATCH 2/2] arm64: dts: qcom: sa8775p-ride: Describe sgmii_phy1 irq
Date:   Thu, 17 Aug 2023 16:37:17 -0500
Message-ID: <20230817213815.638189-3-ahalaney@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230817213815.638189-1-ahalaney@redhat.com>
References: <20230817213815.638189-1-ahalaney@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's an irq hooked up, so let's describe it.

Prior to commit 9757300d2750
("pinctrl: qcom: Add intr_target_width field to support increased number of interrupt targets")
one would not see the IRQ fire, despite some (invasive) debugging
showing that the GPIO was in fact asserted, resulting in the interface
staying down.

Now that the IRQ is properly routed we can describe it.

Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index 8fde6935cd6e..9760bb4b468c 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -295,6 +295,7 @@ sgmii_phy1: phy@a {
 			compatible = "ethernet-phy-id0141.0dd4";
 			reg = <0xa>;
 			device_type = "ethernet-phy";
+			interrupts-extended = <&tlmm 26 IRQ_TYPE_EDGE_FALLING>;
 			reset-gpios = <&pmm8654au_2_gpios 9 GPIO_ACTIVE_LOW>;
 			reset-assert-us = <11000>;
 			reset-deassert-us = <70000>;
-- 
2.41.0

