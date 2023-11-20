Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E8867F2151
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232547AbjKTXSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:18:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjKTXSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:18:05 -0500
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA491C9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:18:01 -0800 (PST)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-507a62d4788so6989206e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700522280; x=1701127080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bFG5UZCWSj4c38SGi7sUkHkOSwjgQKhUp/xUHaHE5CA=;
        b=SwxzExPJPjvRgOB1RloZ4w57l77d/v1ZwZVgR4snrjwUcIKFomdKcqFHEK+FymobGJ
         FMiHDUWVKGGoDW8HIfIr6+ladZ+xeezhGlNtdpB+3Ob1IPGaWTrMrMkEBUaktmODravI
         CBriBq9+eyL4LwBCw7VyP6BLDimbe7KzKZ25vGRxjnmruvLWMQ3klpXfI2dnQfKyg5+E
         xC/WWS6iwOqmhCENW1c6Ce1Q4JtD+4fKtPUmAOse2RfHs6PJtgsWQC+242KPISGOobNs
         MMRFw4eGayuo5ERxubBILv3+h0tq0XgxwzOHm+/Ik9Ttmk2oCThN9xTdDktUDDxBA6NK
         gN/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522280; x=1701127080;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFG5UZCWSj4c38SGi7sUkHkOSwjgQKhUp/xUHaHE5CA=;
        b=onXEWuxqyj+V9pk3IfqhGimbzTKPOacGdQ2LqL6XZ+IwmYda6bRI/6ycXm79KPAySP
         LATJtvr1QI2eVScu8HHB7F9LrnzwBGWoLRQDaHCqzKBcWGEJxJxg4AmHOwymMEWo51zx
         Z5nH/rVKgX5jbTngzHM5SVTJ1gmR6Ll/fB48P50Su7qufrB+805sBg3n8e9eON8I/UPv
         sCeC3fWmYhcZhtFLmfWUT/oQz1+peOI6hGuA9KsGO8MqlLwb9tMWUiE3zH/tVv8xKZFD
         D3dobLQB+TgU4gbvosz48ss82VNgUYGA5jaMnOpqzJHjp9ZhcreNqRmm2rcWXNh1pOPF
         ikxA==
X-Gm-Message-State: AOJu0Yw8P/3QDlLGdeq+5rZ5b0zBBxzU3//+Av+Ab0vD7212iws4pQ35
        gz6cu9CUvbAUbTuosbakq3MNyg==
X-Google-Smtp-Source: AGHT+IF43HFbIPmn6HBOTMZR09V95y1irPM+XxX1kmWAOq9mfIqu2NLsmIkZAWWGweUOLoXS6AqbfA==
X-Received: by 2002:ac2:59c7:0:b0:507:9787:6776 with SMTP id x7-20020ac259c7000000b0050797876776mr6501306lfn.5.1700522279928;
        Mon, 20 Nov 2023 15:17:59 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id bi32-20020a0565120ea000b0050aab042c7csm677036lfb.190.2023.11.20.15.17.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:17:59 -0800 (PST)
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
Subject: [PATCH 1/2] dt-bindings: connector: usb: add accessory mode description
Date:   Tue, 21 Nov 2023 01:11:07 +0200
Message-ID: <20231120231757.2309482-2-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120231757.2309482-1-dmitry.baryshkov@linaro.org>
References: <20231120231757.2309482-1-dmitry.baryshkov@linaro.org>
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

