Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6007FB8F9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 12:06:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344450AbjK1LGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 06:06:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344544AbjK1LFh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 06:05:37 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4460E1FCE
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:05:17 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54ba86ae133so681190a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 03:05:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=melexis.com; s=google; t=1701169516; x=1701774316; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZErotTciFh+W4EIUk/jK7VwlzHqyAHTYt/8Z9M3bwy0=;
        b=WmB+7bvc0AI//kI5Yk+uioBlenkszXC3fMviF6oE4RyBhksmbogyUfPB5KAA+8ekGo
         0vDcIN/j/NDAAN3mg2sKRBeBowSmCmcy9dYRjYlBeQAjrmfQpqqWD8Vbqtp9xG+tT1T6
         7x/L+6ek8rpEXw7+uyE1Hcxydr9/BqmeDnfRahDavVo6wVl2lqUYN+er8FNBJpnmB0wa
         aG4UqrH6qFo7TftS42urB8keYRmZFkxSWMD4+zrtGTdm39ZWSPnZt1dt1W3KXujfAkQH
         ijktlzdmEDwpQ+mgnqanaV+mm6nr/YT2qUp9heW4IBKyRe+xMiSeaio/cBjiBLpDL9J3
         xDrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701169516; x=1701774316;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZErotTciFh+W4EIUk/jK7VwlzHqyAHTYt/8Z9M3bwy0=;
        b=dCocDD20I0ZhMysszoTkxGhH/RnuLHz6Y1lqYi9c1fNmD4ODfHJ+nj9I1BVQ21H9Dq
         DSEKTOxh/LjuLrjdy3ZF/UJ+9iVyeU6XR8f+HrLTMxJeX51k4gjA//UsfRRJv49JSx0N
         97m5lGDNRnNIAcSwqyREq3AfsqHG3KmiWIndZIY5FGTWuvlNXYOrz21/xqJ+pvvVk+mp
         botWzEMX1W5+EOT0pg7VGING9GGz72o0oYJFkRzabh/IYm+rEE9QU7PrGBUUslNjcAD+
         vAB/o/nP4uPAY+vG59og4SZlsn1qzJd4XHlWnAq6Y5XBYTdTJtQvhHcsC1Hnxce3rQBE
         afFg==
X-Gm-Message-State: AOJu0Yxpgd8kpIzauhjxTRKYygNSG+pTd3C+tyvkAxYZXt/eR5viZo1p
        1Qg+2MQKk6Fvrsb5W/nM8Ji7Xg==
X-Google-Smtp-Source: AGHT+IF88graGsp2EiQI3DeNW7yBOyI3PBwjZMG5ecHagJ7rlExos2CVPUI+aemtEVMhr8ijiIc6Cw==
X-Received: by 2002:a17:906:b20a:b0:9e6:4410:2993 with SMTP id p10-20020a170906b20a00b009e644102993mr6893876ejz.18.1701169515620;
        Tue, 28 Nov 2023 03:05:15 -0800 (PST)
Received: from localhost.localdomain (d54C3956F.access.telenet.be. [84.195.149.111])
        by smtp.gmail.com with ESMTPSA id lv20-20020a170906bc9400b00a0f78db91c3sm2236936ejb.95.2023.11.28.03.05.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 03:05:15 -0800 (PST)
From:   Crt Mori <cmo@melexis.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Lars-Peter Clausen <lars@metafoo.de>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Crt Mori <cmo@melexis.com>
Subject: [PATCH v2 2/2] dt-bindings: iio: temperature: add MLX90635 device
Date:   Tue, 28 Nov 2023 12:02:52 +0100
Message-Id: <f8cb0afb2966540dd266da09e832eab22604347b.1701168726.git.cmo@melexis.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <cover.1701168726.git.cmo@melexis.com>
References: <cover.1701168726.git.cmo@melexis.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree bindings for MLX90635 Infra Red contactless temperature
sensor.

Signed-off-by: Crt Mori <cmo@melexis.com>
---
 .../iio/temperature/melexis,mlx90632.yaml     | 19 +++++++++++++++++--
 1 file changed, 17 insertions(+), 2 deletions(-)

diff --git a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
index 4a55e7f25ae7..03bb5d4fa8b5 100644
--- a/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
+++ b/Documentation/devicetree/bindings/iio/temperature/melexis,mlx90632.yaml
@@ -4,7 +4,7 @@
 $id: http://devicetree.org/schemas/iio/temperature/melexis,mlx90632.yaml#
 $schema: http://devicetree.org/meta-schemas/core.yaml#
 
-title: Melexis MLX90632 contactless Infra Red temperature sensor
+title: Melexis MLX90632 and MLX90635 contactless Infra Red temperature sensor
 
 maintainers:
   - Crt Mori <cmo@melexis.com>
@@ -27,9 +27,24 @@ description: |
   Since measured object emissivity effects Infra Red energy emitted,
   emissivity should be set before requesting the object temperature.
 
+  https://www.melexis.com/en/documents/documentation/datasheets/datasheet-mlx90635
+
+  MLX90635 is most suitable for consumer applications where
+  measured object temperature is in range between -20 to 100 degrees
+  Celsius with relative error of measurement 2 degree Celsius in
+  object temperature range for industrial applications, while just 0.2
+  degree Celsius for human body measurement applications. Since it can
+  operate and measure ambient temperature in range of -20 to 85 degrees
+  Celsius it is suitable also for outdoor use.
+
+  Since measured object emissivity effects Infra Red energy emitted,
+  emissivity should be set before requesting the object temperature.
+
 properties:
   compatible:
-    const: melexis,mlx90632
+    enum:
+      - melexis,mlx90632
+      - melexis,mlx90635
 
   reg:
     maxItems: 1
-- 
2.40.1

