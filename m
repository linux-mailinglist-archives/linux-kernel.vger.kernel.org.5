Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23E997F3770
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:30:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234515AbjKUUae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:30:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234599AbjKUUaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:30:16 -0500
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C871FD4
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:29:31 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-50aaaf6e58fso4322140e87.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:29:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700598568; x=1701203368; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFG5UZCWSj4c38SGi7sUkHkOSwjgQKhUp/xUHaHE5CA=;
        b=XbUOLmjjz9PPlcr3KzGO4M0K/yAcbwtQDQcaYeKxnPrVbT9XvSg/Q2rmlrffDl5t9B
         Zbx/LoXc9yq/h8eIFlX7r24EO5vPk1nyhtmHEep1JWBRk5MIOOmKaUUx31l0P+a5eGv4
         pwA7IXMAeeRA4oQh3c2aVY4snPBOnZaKcstSDTSA155gKBaFmOa2LAdFOLydJVqDOaE5
         2uOIOYt4E5jIa6MdShVxxgpL9MxqI5BwacvDGfN+JEWsAmaNUN9bTJ/qUMI43O/FV7oe
         XtqaeSWJgwYhQk6+7+uKsVRdhlVJlBEntzt3NuOCdYrp9erd8KDDspO90qKdASPXQc+2
         iY4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598568; x=1701203368;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFG5UZCWSj4c38SGi7sUkHkOSwjgQKhUp/xUHaHE5CA=;
        b=qVMF939JeqjfovU2G64vu2QZD6Foz4IVRVx6WUnP8y2jSaoAXwyzA5go0I9VoDB28J
         L2UKoFO5rw6mvP+g1vRMc+VSJFkUEDzAGdebt9wDvgi8lwpyG+dSaQJvm5JT29TCDIw6
         ORzpWo8fs6FjxQzTQHw8aYxU9c2TDyW3eXa0O5Co169AgpiNrF5U3Cd5KlmlzcMVXGTU
         xcnBbZvWDEN+DRWcX6fAbJgU1b3tzdvtmjtkmFnZ4oGNcRGQ8/SMjwZaYHjsQRWas34+
         4uQMaoe4HTB/xUgHsQ6+OcCBgMtFbYFVQ0jtVfMhNtgvg8+B8uSwJ4Rif21CjsSz9gLb
         YLwQ==
X-Gm-Message-State: AOJu0Ywhnondh7PGb2/K+uaXGvmHhoW3I5JKvlNLtr8qV2px9BWC7tgD
        8twcdWJmTKttrN1sitiyxvh4DA==
X-Google-Smtp-Source: AGHT+IHdxm/QrmdM6SWBooHi4UuMpcZ44xT8udenVhL8SjC3GHrt+VgknHZ0o2wEJMoiWz88C1wPFA==
X-Received: by 2002:ac2:4c36:0:b0:508:1470:6168 with SMTP id u22-20020ac24c36000000b0050814706168mr204843lfq.57.1700598567709;
        Tue, 21 Nov 2023 12:29:27 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050ab6112af2sm286287lfs.65.2023.11.21.12.29.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:29:26 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Mark Gross <markgross@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v2 1/2] dt-bindings: connector: usb: add accessory mode description
Date:   Tue, 21 Nov 2023 22:26:59 +0200
Message-ID: <20231121202925.2481471-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121202925.2481471-1-dmitry.baryshkov@linaro.org>
References: <20231121202925.2481471-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add description of the USB-C Accessory Modes supported on the particular
USB-C connector. This is required for devices like Qualcomm SM8150-HDK,
which have no other way to express accessory modes supported by the
hardware platform.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 .../devicetree/bindings/connector/usb-connector.yaml | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/Documentation/devicetree/bindings/connector/usb-connector.yaml b/Documentation/devicetree/bindings/connector/usb-connector.yaml
index c1aaac861d9d..b4f96ef85fb0 100644
--- a/Documentation/devicetree/bindings/connector/usb-connector.yaml
+++ b/Documentation/devicetree/bindings/connector/usb-connector.yaml
@@ -171,6 +171,18 @@ properties:
       offer the power, Capability Mismatch is set. Required for power sink and
       power dual role.
 
+  accessory-mode-audio:
+    type: boolean
+    description: Whether the device supports Audio Adapter Accessory Mode. This
+      is only necessary if there are no other means to discover supported
+      alternative modes (e.g. through the UCSI firmware interface).
+
+  accessory-mode-debug:
+    type: boolean
+    description: Whether the device supports Debug Accessory Mode. This
+      is only necessary if there are no other means to discover supported
+      alternative modes (e.g. through the UCSI firmware interface).
+
   altmodes:
     type: object
     description: List of Alternative Modes supported by the schematics on the
-- 
2.42.0

