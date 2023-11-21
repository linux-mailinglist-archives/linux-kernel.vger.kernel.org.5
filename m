Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 105AC7F377A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 21:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234023AbjKUUcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 15:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234476AbjKUUbw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 15:31:52 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1EC11FF6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:29:33 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a5f2193bso167914e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 12:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700598569; x=1701203369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=H6pUSylQ57QDAnOYu4uoAZWK5eAYHbB7ZTMJQDUS70M=;
        b=fCCR6+pbo1xyY31e4mJ4cQXLs2L4HGXuHsCeD8RpJ4hj4cwx1nXW4hRhytYk81PBda
         wfmGjdEilXAxS699atHxZIdWrI5R9sVkCOwQR1OrBdPFeFG+h6i7R1bJipwEl7VfJ94D
         YTFykVcMwgeGntOEeCSW0Ktil4bI0i0o4PCYJz2hOpv36I+JVbro64MVO2Gf2E1+chth
         rNf+Ri48jKkc+dfkZQL/JRg1wvo8meRfxNmEsig0u5h6OPs0DLUC164A7au+KP/3sZ1X
         D9H8i07ZhFb5uGbRkM06vTp0MyEeBrW4pzBmr8DmFwSWUooIynKUnfZTzPNsRzGcEEUd
         5ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700598569; x=1701203369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=H6pUSylQ57QDAnOYu4uoAZWK5eAYHbB7ZTMJQDUS70M=;
        b=R1pma95GX7z8JMQLo6AM7eIk/pWI+u52CRBwEFtV4LUp86adLtkm9sXLWBauEPahvD
         zLXwHiuRJknpsAFwVNxU8onmm9j4R57V5Y7C3kKPraNuyGXZA+B/U4QjPM00kue/KnK1
         jIJoCJltIk90K/OrFQ1l+h3tvb7i67h0+zF2IQMJe0a0fp/cMtpyEjKpozHSMZy7Jfhj
         v5X2xSxy2ZxrRkude13NiranUohCkxET4eYIWV7OYfRIznFyq/Y6bbrr3DTHDZrDFw2i
         8cJl+DwXiJmVi6vZVpEnKbxKiiYO9NzTdXRHqtwHLlM+v97xXOZNCx7WWuqzfBAH9PMW
         5A6Q==
X-Gm-Message-State: AOJu0YyeQTk/xi1Wm65yBd4hNehfDodcUHxShqIALUD6n+Yy4yeo7F0B
        mSnb9fa+SwhJNsxu0c2EYmwmJQ==
X-Google-Smtp-Source: AGHT+IH0jTRQM5w+kYWIMAHKUNTpVDgqlCy01ePT/kCx57Ft4PfLmDfBxK5KunZbk5hReZpNqqabLA==
X-Received: by 2002:a05:6512:3708:b0:50a:6fb8:a0c0 with SMTP id z8-20020a056512370800b0050a6fb8a0c0mr114755lfr.19.1700598568810;
        Tue, 21 Nov 2023 12:29:28 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id h4-20020a056512350400b0050ab6112af2sm286287lfs.65.2023.11.21.12.29.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Nov 2023 12:29:28 -0800 (PST)
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
Subject: [PATCH v2 2/2] usb: typec: tcpm: Parse Accessory Mode information
Date:   Tue, 21 Nov 2023 22:27:00 +0200
Message-ID: <20231121202925.2481471-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121202925.2481471-1-dmitry.baryshkov@linaro.org>
References: <20231121202925.2481471-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some of the boards supported by the TCPM drivers can support USB-C
Accessory Modes (Analog Audio, Debug). Parse information about supported
modes from the device tree.

Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/usb/typec/tcpm/tcpm.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6e843c511b85..ba2926846269 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6114,6 +6114,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 {
 	const char *opmode_str;
 	int ret;
+	int mode;
 	u32 mw, frs_current;
 
 	if (!fwnode)
@@ -6132,6 +6133,14 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	if (ret < 0)
 		return ret;
 
+	mode = 0;
+
+	if (fwnode_property_read_bool(fwnode, "accessory-mode-audio"))
+		port->typec_caps.accessory[mode++] = TYPEC_ACCESSORY_AUDIO;
+
+	if (fwnode_property_read_bool(fwnode, "accessory-mode-debug"))
+		port->typec_caps.accessory[mode++] = TYPEC_ACCESSORY_DEBUG;
+
 	port->port_type = port->typec_caps.type;
 	port->pd_supported = !fwnode_property_read_bool(fwnode, "pd-disable");
 
-- 
2.42.0

