Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 498EE7F2150
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 00:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjKTXSM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 18:18:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbjKTXSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 18:18:06 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC38DD9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:18:02 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50aabfa1b75so2393873e87.3
        for <linux-kernel@vger.kernel.org>; Mon, 20 Nov 2023 15:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700522281; x=1701127081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8yRltIxaSGonkHk709wNhnMOnmu28WhSy5thJNygUYU=;
        b=IQQt0Zv2bwdEOXrSJevG+hwyn4s7Fis2UUAVNvK2bDT3wTVzJ9U/t13uVpkIGJQ8xI
         H4DZzy5poah2x2UW9PUBTqSedJqYNIfXf431BgcTtIRRtfAYjdgw07YlP+5KFgXFHNRT
         gtqBefFnrCoOeF+leB2m0LlnDX4mRhrsP6SOrUt0UUYA+5pXXC6IPTxs3rPweEQiJpAb
         cqLC02iH/sTTQYOD5ulE9nTKImqo36A4RXknvCzKnzku1noVJ2ZRJVuEZMyCQxTAq6Sl
         qlU/MSq4VTEoylegzVG/4rcZ49DWxvl1Xc8tus0zSjxENlbfuVhqWr5XbhS14e5JVAqy
         ijug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700522281; x=1701127081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8yRltIxaSGonkHk709wNhnMOnmu28WhSy5thJNygUYU=;
        b=UafkiU/tJ7WsiIfk0CN/g0EVz46o7Hm9zup9twMNvyV//hOUf/boRmUXfpnziyZCmY
         BAzNmiAOo4p5cKujanX5U1E9uOSZBErzxnXjNoVyewuXhmg9tlsznZBpHth37bIxk0cr
         EBwHoO/Hv8hqcjk66FoS6yMvy3TxQYY2c2TUC0EflsPtKTF/1qBVTaAo3NP0cyFSfc3/
         OfEVKB6g2VpjoIoOR4Doh/4edMQjNUGHmJQ3EcFdu0GV46QosozHD8imeJkoSEq24OJz
         sP56mkRKwx18r9wzfm5C8tr0nLjVrhvzdg0kVbZhwAy1xVFBHT5ttwu27i9Vdp4XXoM3
         ahnA==
X-Gm-Message-State: AOJu0YxZLYKt1CGBcHwN803q6pCl5sntQ9x2feqQ9c7fQlL85FSs/Vaa
        HIvt6U7ANjWGBn2z0loD81sWvg==
X-Google-Smtp-Source: AGHT+IE9L3VORyelf3Xks/jkQXQB478z0uVWNtaRVh9TqFZzCytSJ0a6JWGb/Zwah6hyHzQMJ/8ztQ==
X-Received: by 2002:ac2:4db3:0:b0:507:b1f8:7895 with SMTP id h19-20020ac24db3000000b00507b1f87895mr5887579lfe.38.1700522280876;
        Mon, 20 Nov 2023 15:18:00 -0800 (PST)
Received: from eriador.lan (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id bi32-20020a0565120ea000b0050aab042c7csm677036lfb.190.2023.11.20.15.18.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 15:18:00 -0800 (PST)
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
Subject: [PATCH 2/2] usb: typec: tcpm: Parse Accessory Mode information
Date:   Tue, 21 Nov 2023 01:11:08 +0200
Message-ID: <20231120231757.2309482-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231120231757.2309482-1-dmitry.baryshkov@linaro.org>
References: <20231120231757.2309482-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
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
 drivers/usb/typec/tcpm/tcpm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 6e843c511b85..6297f803de53 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -6114,6 +6114,7 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 {
 	const char *opmode_str;
 	int ret;
+	int mode;
 	u32 mw, frs_current;
 
 	if (!fwnode)
@@ -6132,6 +6133,12 @@ static int tcpm_fw_get_caps(struct tcpm_port *port,
 	if (ret < 0)
 		return ret;
 
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

