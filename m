Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25AE57D0BED
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 11:34:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376755AbjJTJeT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 05:34:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376853AbjJTJdq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 05:33:46 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D3F10E9
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:33:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-53e2308198eso843967a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 02:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1697794403; x=1698399203; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8HAqgphO8/nmhxveYYWq+PwS2fkw9vCkjtGCsYcP8DE=;
        b=FYeQJxToEaN56qaSjTi3xRkXXFxyQCFqoO9YHmFtdDCoeL1iwFeClkv8LCZPlFhEzQ
         Laj94aMaSp0ObpaFepN5IsHCkBJAlI0nxiUe62fgR/ahMYbMyT1ThaSnjKFtFPJrzjBE
         OaInWd+rCFYFqYGkoHNJ7QWmsR1x1Wgp1rVHZJa0vo9KemFrDJcx4jx1bAnIbd3dMAXH
         ekqHIp/GF/zWBeyvolfi2OK70RWRAtnSs/OWgvdAjLp54PlPuktGNmLoAAWNcVIQuHBO
         HlRwv3kfTSY7L/C4/iBbKoWKDAqBWySmUTSdK5KVyRTtZnNtG3bka/2Z+CRIm57pQ0vG
         HCIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697794403; x=1698399203;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8HAqgphO8/nmhxveYYWq+PwS2fkw9vCkjtGCsYcP8DE=;
        b=o9cBXblF+fvW0zyR3zPU6ZlCfFeKZmvgSp8z7TKCJ5BjAoOAfBd9rpOx0x5+QRRzOR
         EH84DRg6skgtTCEjiDX4zdLvLhZpxzFYrt/x8mDeytnWwvcGS5mFvx01v33ib0y+NJDJ
         hUeMQmrQ0Ym1XaVX48vqKxx9lzU5ZloP2W8imdo1wUVI0CkNJWyFC4jLkM52+ixiG/7G
         NrlpZT43f15kV2b+QLxpp/10E3HFrAMriGlMFBh8Buj8ywTENLA+EDbzHZ3LLLzNwyph
         2x3/+Eei/skosFiK+l4bV+U+DYgU78oGKsKUkjjfol/UbLbO28YRalu6WSundJHwpLY6
         /CZw==
X-Gm-Message-State: AOJu0YzhmxvuR00Nr2gztpqDpxhmzV+/RTY3lvxyKo7fXVGL1YY9iaCa
        xDp+TurfSmpqWOummXDFI3MsUA==
X-Google-Smtp-Source: AGHT+IFP1JXUdkDGNVp03jbl+ZSC03News4HiarnwyTD2JABp9j7F8z4tTvDzgffGBOsPBTwQNK6FA==
X-Received: by 2002:a17:907:9724:b0:9bd:f3b0:c087 with SMTP id jg36-20020a170907972400b009bdf3b0c087mr922647ejc.2.1697794403304;
        Fri, 20 Oct 2023 02:33:23 -0700 (PDT)
Received: from otso.luca.vpn.lucaweiss.eu (k10064.upc-k.chello.nl. [62.108.10.64])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709066bcf00b009a13fdc139fsm1102535ejs.183.2023.10.20.02.33.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Oct 2023 02:33:22 -0700 (PDT)
From:   Luca Weiss <luca.weiss@fairphone.com>
Date:   Fri, 20 Oct 2023 11:33:19 +0200
Subject: [PATCH v2 2/3] usb: typec: fsa4480: Add support to swap SBU
 orientation
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231020-fsa4480-swap-v2-2-9a7f9bb59873@fairphone.com>
References: <20231020-fsa4480-swap-v2-0-9a7f9bb59873@fairphone.com>
In-Reply-To: <20231020-fsa4480-swap-v2-0-9a7f9bb59873@fairphone.com>
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
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
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

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/usb/typec/mux/fsa4480.c | 71 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 71 insertions(+)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index e0ee1f621abb..cb7cdf90cb0a 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -60,6 +60,7 @@ struct fsa4480 {
 	unsigned int svid;
 
 	u8 cur_enable;
+	bool swap_sbu_lanes;
 };
 
 static const struct regmap_config fsa4480_regmap_config = {
@@ -76,6 +77,9 @@ static int fsa4480_set(struct fsa4480 *fsa)
 	u8 enable = FSA4480_ENABLE_DEVICE;
 	u8 sel = 0;
 
+	if (fsa->swap_sbu_lanes)
+		reverse = !reverse;
+
 	/* USB Mode */
 	if (fsa->mode < TYPEC_STATE_MODAL ||
 	    (!fsa->svid && (fsa->mode == TYPEC_MODE_USB2 ||
@@ -179,12 +183,75 @@ static int fsa4480_mux_set(struct typec_mux_dev *mux, struct typec_mux_state *st
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
+	struct fwnode_handle *ep;
+	u32 data_lanes[DATA_LANES_COUNT];
+	int ret, i, j;
+
+	ep = fwnode_graph_get_next_endpoint(dev_fwnode(&fsa->client->dev), NULL);
+	if (!ep)
+		return 0;
+
+	ret = fwnode_property_read_u32_array(ep, "data-lanes", data_lanes, DATA_LANES_COUNT);
+	if (ret == -EINVAL)
+		/* Property isn't here, consider default mapping */
+		goto out_done;
+	if (ret) {
+		dev_err(&fsa->client->dev, "invalid data-lanes property: %d\n", ret);
+		goto out_error;
+	}
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
+		break;
+	default:
+		dev_err(&fsa->client->dev, "invalid data-lanes mapping\n");
+		ret = -EINVAL;
+		goto out_error;
+	}
+
+out_done:
+	ret = 0;
+
+out_error:
+	fwnode_handle_put(ep);
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
@@ -193,6 +260,10 @@ static int fsa4480_probe(struct i2c_client *client)
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

