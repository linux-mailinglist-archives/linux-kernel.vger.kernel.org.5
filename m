Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE49B802A20
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 03:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbjLDCDF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Dec 2023 21:03:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234281AbjLDCDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Dec 2023 21:03:02 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07F4FD
        for <linux-kernel@vger.kernel.org>; Sun,  3 Dec 2023 18:03:08 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-50be10acaf9so1913120e87.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Dec 2023 18:03:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701655387; x=1702260187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nU+isl/cmvOumBeEJVaIP24Ow/f7bjobvPWRPynQaf8=;
        b=M56yn2aTw7h/zSNqrgKdfY7GEi7xsJoYZnVw79rEcs2p292xNgDpx7WosbEGZdbJVL
         eFi0fk+5kHsFcOhoOvqnYrD3gJ+oHuEUoU1JgUQRRdSxtskBPpsGQS3j/ojeMulZgbiw
         zhI6A829rMUYxAdTfuaPZEvyOIIkF24i4JVYTmMgjJlKtwxmUgquVBsYUJmeTL/Ei+E8
         DlSoQbxQHxuw6Q5BHztsPVjLSVAe0wIDCLFcmunTV8dd6yGQd4fI4n0XLIJ9zaoJ5J2x
         3WC29yS2N/DSbAeaZSdddKA1/+fn3ywdooUW06SnjJGpUelZKY62X60OKTzXFiiXpvO3
         X3aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701655387; x=1702260187;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nU+isl/cmvOumBeEJVaIP24Ow/f7bjobvPWRPynQaf8=;
        b=n3qowaQW2980088ev8o+8BDQozO1MtQ4g3HPTYV0n5VypWRJB3xgSjm0zTAyQJXKL8
         wpaMndgxPfOK8vs92AK/Q8QlqsXBb+17APQMIQmo72TBhhqeBw1E0tmmSUgJCDAvmCAm
         sNuOFTY8LuiRh8SjoYnaPmt0NUPFo9dwOBlCD8ellCquGNkDlxf/MPDyLpLSzKgP8mhe
         PL1h4w4+k90CWTyw/XCQM1jVwg9+a2Qv5rHQLgkB2dklgQqhNimffTSYHSWAnkCWTkVT
         7GjJQv/MdwCoj71TCrtnpouveeR0WZ3V9ieRYuzSu8TZwhOrvU6Ccn/ic/CuQT6go0X+
         vI+g==
X-Gm-Message-State: AOJu0YwWToFTFu/RTrK0UqJaGcD2k7SrOVRJAjxr8zK7BmAoKbxGODME
        K9PUibvMGExZdkYq2WPaYysLjg==
X-Google-Smtp-Source: AGHT+IF2BaKSfbGgOJcuur4nyNBw+zmrxBa85rY71yvqdk6sw/yYSlw4/eaFyeU/Nq5IFQWNX3P35w==
X-Received: by 2002:a05:6512:3d1d:b0:50b:c36e:a70e with SMTP id d29-20020a0565123d1d00b0050bc36ea70emr2917074lfv.34.1701655386300;
        Sun, 03 Dec 2023 18:03:06 -0800 (PST)
Received: from eriador.unikie.fi ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b0050bea5c2850sm525381lfr.39.2023.12.03.18.03.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Dec 2023 18:03:05 -0800 (PST)
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Hans de Goede" <hdegoede@redhat.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "Mark Gross" <markgross@kernel.org>,
        "Heikki Krogerus" <heikki.krogerus@linux.intel.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        linux-usb@vger.kernel.org
Subject: [PATCH v4 2/3] usb: typec: change altmode SVID to u16 entry
Date:   Mon,  4 Dec 2023 04:03:01 +0200
Message-ID: <20231204020303.2287338-3-dmitry.baryshkov@linaro.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
References: <20231204020303.2287338-1-dmitry.baryshkov@linaro.org>
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

As stated in the changelog for the commit 7b458a4c5d73 ("usb: typec: Add
typec_port_register_altmodes()"), the code should be adjusted according
to the AltMode bindings. As the SVID is 16 bits wide (according to the
USB PD Spec), use fwnode_property_read_u16() to read it.

Acked-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/platform/x86/intel/chtwc_int33fe.c | 2 +-
 drivers/usb/typec/class.c                  | 5 +++--
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/platform/x86/intel/chtwc_int33fe.c b/drivers/platform/x86/intel/chtwc_int33fe.c
index 848baecc1bb0..93f75ba1dafd 100644
--- a/drivers/platform/x86/intel/chtwc_int33fe.c
+++ b/drivers/platform/x86/intel/chtwc_int33fe.c
@@ -136,7 +136,7 @@ static const struct software_node altmodes_node = {
 };
 
 static const struct property_entry dp_altmode_properties[] = {
-	PROPERTY_ENTRY_U32("svid", 0xff01),
+	PROPERTY_ENTRY_U16("svid", 0xff01),
 	PROPERTY_ENTRY_U32("vdo", 0x0c0086),
 	{ }
 };
diff --git a/drivers/usb/typec/class.c b/drivers/usb/typec/class.c
index 2e0451bd336e..a959dcc3374a 100644
--- a/drivers/usb/typec/class.c
+++ b/drivers/usb/typec/class.c
@@ -2230,7 +2230,8 @@ void typec_port_register_altmodes(struct typec_port *port,
 	struct typec_altmode_desc desc;
 	struct typec_altmode *alt;
 	size_t index = 0;
-	u32 svid, vdo;
+	u16 svid;
+	u32 vdo;
 	int ret;
 
 	altmodes_node = device_get_named_child_node(&port->dev, "altmodes");
@@ -2238,7 +2239,7 @@ void typec_port_register_altmodes(struct typec_port *port,
 		return; /* No altmodes specified */
 
 	fwnode_for_each_child_node(altmodes_node, child) {
-		ret = fwnode_property_read_u32(child, "svid", &svid);
+		ret = fwnode_property_read_u16(child, "svid", &svid);
 		if (ret) {
 			dev_err(&port->dev, "Error reading svid for altmode %s\n",
 				fwnode_get_name(child));
-- 
2.42.0

