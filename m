Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B85E7C84A1
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 13:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231535AbjJMLia (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 07:38:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbjJMLiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 07:38:14 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C40E1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:38:11 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-53e0d21a4easo2910307a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 13 Oct 2023 04:38:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697197090; x=1697801890; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1uiPM/GMm7F/lzEfR4zDqI+gGiL3ifxgoG2XzxhVsgY=;
        b=3GOmrLPkVtN9xW4/OIkqTs4PA107zkrjPsmVH8Wyx72GKfDMZBiumewP+3FcdOIjZZ
         vFg0DhT/CqAiGJHOXZfGLCAUKp4KoNwfiLxQtC/v1KpxETKGxuqlnDeWxRzH73jnX6dX
         g9iglOL0s4Um4p5X/YCSAIhrm3oFrk1aADo5Tvoe/YmBA5b0Urn5hFOieCOJFXxUPX6X
         PlV6M98oDG7gb37uopDcevR9PA9f5LonjSLuDsPVG3+dmq/GFo2TWzkMVsZywhSQo5EI
         DoBr/k4O/Tc3lNfGLEKbLS0H3qXckcvUI6I3IlmYKrB075Am153JbW+r+qACR5CS3yMo
         o4og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697197090; x=1697801890;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1uiPM/GMm7F/lzEfR4zDqI+gGiL3ifxgoG2XzxhVsgY=;
        b=UmUMZ6VNvBGC6hInI2j+yJp0dKJVEP1KNvAw04Ghs0ZJM9VEg+NVqK2e7wTFpRp72j
         /HTNNFcvTXdMgmxln+nMlm5KL1zyGNuyExi/mCS2pzMuslMm0InLUOKFkfjrptFB2hXl
         Gv05tZxbwMI6y2W6effNscEBRQy4+9Vd2OMgMQHBscFf76pgzioP8Cv9fIDv8F3aLHm2
         FfCtWLJf2CnVhFW04G9n2dwaLBKNivtinOyyyEPKOb4R8NX4qgE6zQY+eIyK4krCBA5q
         hobjfD+3Tr3JTrS5Imq6UznfJ5tL93EZ1Z+FX8V5lms1LvpKHPnqypNMo0GCdOEEfFYv
         fvsg==
X-Gm-Message-State: AOJu0Yzhr02wamOmcbIWGwgyecVoHRr8RbYHxUKxplllXPcaihOpTdRR
        p5JQuBQMZuCioA9zhBgBauozNg==
X-Google-Smtp-Source: AGHT+IExNo44l9xvr3Uvnq63IE4OvYn910JG+8iv9WqqfeyEBDscBkCmKkFryAUhYUkVXPNzMLuCbw==
X-Received: by 2002:aa7:db45:0:b0:533:520:a5a8 with SMTP id n5-20020aa7db45000000b005330520a5a8mr23756049edt.29.1697197089849;
        Fri, 13 Oct 2023 04:38:09 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7d652000000b00533dad8a9c5sm11360772edr.38.2023.10.13.04.38.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Oct 2023 04:38:09 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 13 Oct 2023 13:38:06 +0200
Subject: [PATCH 2/3] usb: typec: fsa4480: Add support to swap SBU
 orientation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231013-fsa4480-swap-v1-2-b877f62046cc@fairphone.com>
References: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
In-Reply-To: <20231013-fsa4480-swap-v1-0-b877f62046cc@fairphone.com>
To:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Luca Weiss <luca.weiss@fairphone.com>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some hardware designs the AUX+/- lanes are connected reversed to
SBU1/2 compared to the expected design by FSA4480.

Made more complicated, the otherwise compatible Orient-Chip OCP96011
expects the lanes to be connected reversed compared to FSA4480.

* FSA4480 block diagram shows AUX+ connected to SBU2 and AUX- to SBU1.
* OCP96011 block diagram shows AUX+ connected to SBU1 and AUX- to SBU2.

So if OCP96011 is used as drop-in for FSA4480 then the orientation
handling in the driver needs to be reversed to match the expectation of
the OCP96011 hardware.

Support parsing the data-lanes parameter in the endpoint node to swap
this in the driver.

The parse_data_lanes_mapping function is mostly taken from nb7vpq904m.c.

Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/usb/typec/mux/fsa4480.c | 81 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index e0ee1f621abb..6ee467c96fb6 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -9,6 +9,7 @@
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/mutex.h>
+#include <linux/of_graph.h>
 #include <linux/regmap.h>
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
@@ -60,6 +61,7 @@ struct fsa4480 {
 	unsigned int svid;
 
 	u8 cur_enable;
+	bool swap_sbu_lanes;
 };
 
 static const struct regmap_config fsa4480_regmap_config = {
@@ -76,6 +78,9 @@ static int fsa4480_set(struct fsa4480 *fsa)
 	u8 enable = FSA4480_ENABLE_DEVICE;
 	u8 sel = 0;
 
+	if (fsa->swap_sbu_lanes)
+		reverse = !reverse;
+
 	/* USB Mode */
 	if (fsa->mode < TYPEC_STATE_MODAL ||
 	    (!fsa->svid && (fsa->mode == TYPEC_MODE_USB2 ||
@@ -179,12 +184,84 @@ static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *st
 	return ret;
 }
 
+enum {
+	NORMAL_LANE_MAPPING,
+	INVERT_LANE_MAPPING,
+};
+
+#define DATA_LANES_COUNT	2
+
+static const int supported_data_lane_mapping[][DATA_LANES_COUNT] = {
+	[NORMAL_LANE_MAPPING] = { 0, 1 },
+	[INVERT_LANE_MAPPING] = { 1, 0 },
+};
+
+static int fsa4480_parse_data_lanes_mapping(struct fsa4480 *fsa)
+{
+	struct device_node *ep;
+	u32 data_lanes[DATA_LANES_COUNT];
+	int ret, i, j;
+
+	ep = of_graph_get_next_endpoint(fsa->client->dev.of_node, NULL);
+	if (!ep)
+		return 0;
+
+	ret = of_property_count_u32_elems(ep, "data-lanes");
+	if (ret == -EINVAL)
+		/* Property isn't here, consider default mapping */
+		goto out_done;
+	if (ret < 0)
+		goto out_error;
+
+	if (ret != DATA_LANES_COUNT) {
+		dev_err(&fsa->client->dev, "expected 2 data lanes\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
+
+	ret = of_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+	if (ret)
+		goto out_error;
+
+	for (i = 0; i < ARRAY_SIZE(supported_data_lane_mapping); i++) {
+		for (j = 0; j < DATA_LANES_COUNT; j++) {
+			if (data_lanes[j] != supported_data_lane_mapping[i][j])
+				break;
+		}
+
+		if (j == DATA_LANES_COUNT)
+			break;
+	}
+
+	switch (i) {
+	case NORMAL_LANE_MAPPING:
+		break;
+	case INVERT_LANE_MAPPING:
+		fsa->swap_sbu_lanes = true;
+		dev_info(&fsa->client->dev, "using inverted data lanes mapping\n");
+		break;
+	default:
+		dev_err(&fsa->client->dev, "invalid data lanes mapping\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
+
+out_done:
+	ret = 0;
+
+out_error:
+	of_node_put(ep);
+
+	return ret;
+}
+
 static int fsa4480_probe(struct i2c_client *client)
 {
 	struct device *dev = &client->dev;
 	struct typec_switch_desc sw_desc = { };
 	struct typec_mux_desc mux_desc = { };
 	struct fsa4480 *fsa;
+	int ret;
 
 	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
 	if (!fsa)
@@ -193,6 +270,10 @@ static int fsa4480_probe(struct i2c_client *client)
 	fsa->client = client;
 	mutex_init(&fsa->lock);
 
+	ret = fsa4480_parse_data_lanes_mapping(fsa);
+	if (ret)
+		return ret;
+
 	fsa->regmap = devm_regmap_init_i2c(client, &fsa4480_regmap_config);
 	if (IS_ERR(fsa->regmap))
 		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");

-- 
2.42.0

