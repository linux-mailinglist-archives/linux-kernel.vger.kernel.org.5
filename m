Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80FF277723D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 10:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjHJIJb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 04:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233979AbjHJIJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 04:09:25 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1FD0268E
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:21 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-4fe48d0ab0fso878855e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 01:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1691654960; x=1692259760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hHrp6Ft5M/sZ0FkW3Vzz3FknXdyR9hhUh3bpgMqvZnE=;
        b=Xyxh0icQq0/Iiu3mr6XTjxT4dRe3aN7c6Lp4HiDYlXIvQZWJ2B6+XWpRcPcwbXySLx
         nsG0/Wj9u8lgmk8FHbPftyLcL0i3HrignsIESoV2fcByiBBz5tn3/nIa11rImFhe5sil
         j3fDxwRO0bQ2AoRPhaHMUyrGENfmcHSkvStaKUJ5JlDy594+5sF/Qequiz9piGObjf5I
         nk4iZP3LEqmYzg5odtACe+mXDkRyMuefLoogJXMD6GAhdoKQ0YL1ebQ8neCwOj4Ve954
         KKFslwAs8pWd7HGmm/GSgwCweDWFQwKlXsfDkQuR4NbBC6CtA8PIj7qKi1q4Ulav5/uq
         VjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691654960; x=1692259760;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=hHrp6Ft5M/sZ0FkW3Vzz3FknXdyR9hhUh3bpgMqvZnE=;
        b=GN1OzFaffdaQU8ptPLP/2dt+3CVoQVpu0dJpNj2fY8IrqPIkbxgHKWdbYCoV6MFdeC
         d/zzrPlY5GvuWIuFMbG84WT4YzQkqcnNHrnQzm472BR2X+8i5pLXlrb5OYaKaVcuSml9
         7APi7etymeGPIwlylNXkGOFInqgNYaFhwiSR+YOE4I6YX03dlUStBXc47DvMj0CBvYoZ
         X3ji99jiVP4D8NuAkgGZmKRHXBbYbV+MFjd709FlFQGagMB2fc4HthI9gWBcpLmZ4u3i
         SCs848yxaTVCcOyHo31CLlav1YIFhGwW47RX2GcONP2aCXmQJyq8ZYUD2wxfthczrEZK
         apGA==
X-Gm-Message-State: AOJu0YxP+uEcqNukhTltw11cVJGFsriuNIPjbcSWgPZnK/70NTqlEPtR
        BqIB7j0D7HK8i+ZqazDk33Tesw==
X-Google-Smtp-Source: AGHT+IGvaGx0zd413sbvjU6gfReN+Bzz4/M2soeQRahUIP628XQwAbyZgVC/DgJ+12HmFVpdaQZqTA==
X-Received: by 2002:ac2:4f06:0:b0:4f8:7568:e94b with SMTP id k6-20020ac24f06000000b004f87568e94bmr1611776lfr.56.1691654959869;
        Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:74d3:226a:31b3:454c])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b003fe2f3a89d4sm1321790wma.7.2023.08.10.01.09.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Aug 2023 01:09:19 -0700 (PDT)
From:   Bartosz Golaszewski <brgl@bgdev.pl>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alex Elder <elder@linaro.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        Andrew Halaney <ahalaney@redhat.com>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 6/9] arm64: dts: qcom: sa8775p-ride: add the second SGMII PHY
Date:   Thu, 10 Aug 2023 10:09:06 +0200
Message-Id: <20230810080909.6259-7-brgl@bgdev.pl>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230810080909.6259-1-brgl@bgdev.pl>
References: <20230810080909.6259-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Add a second SGMII PHY that will be used by EMAC1 on sa8775p-ride.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 arch/arm64/boot/dts/qcom/sa8775p-ride.dts | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
index f9e1a017798e..486cb48ecb9d 100644
--- a/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
+++ b/arch/arm64/boot/dts/qcom/sa8775p-ride.dts
@@ -287,6 +287,15 @@ sgmii_phy0: phy@8 {
 			reset-assert-us = <11000>;
 			reset-deassert-us = <70000>;
 		};
+
+		sgmii_phy1: phy@a {
+			compatible = "ethernet-phy-id0141.0dd4";
+			reg = <0xa>;
+			device_type = "ethernet-phy";
+			reset-gpios = <&pmm8654au_2_gpios 9 GPIO_ACTIVE_LOW>;
+			reset-assert-us = <11000>;
+			reset-deassert-us = <70000>;
+		};
 	};
 
 	mtl_rx_setup: rx-queues-config {
-- 
2.39.2

