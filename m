Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A48770242
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Aug 2023 15:50:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231449AbjHDNub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Aug 2023 09:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231448AbjHDNuY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Aug 2023 09:50:24 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8FD7198C
        for <linux-kernel@vger.kernel.org>; Fri,  4 Aug 2023 06:50:21 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-3fe1d462762so20131135e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 04 Aug 2023 06:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691157020; x=1691761820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fvPQtc3n+AQ43mIboHGUgEC6liC/yfr/8rGlBJbQd4M=;
        b=Hg+tVobDGieGUcB28lGqS7u/Kg3Nec6NTkRIl1Ry/jMOdf8E6uw5PkUJxKIrkSfB4Y
         ruf6OQk0fSxWy58aGsGLy4bKe9ZgL27XuaqTs1Lw0HM7nnqvP28+o5ORbry/NFq7Bp1x
         en7SEiP0k5pWEgst/l4IEPtL1ByPI8gZOCQZP64rJmv/lBRBZ3UQRZybg8tFivpvWhZA
         IvzQZ3VxNECumqpkVlxSLIRntXB5CWqtG1VBKy4RHT2flgzmDqKRY7TOnRWaGScFgRfv
         O0LG/t6PUuwKIU7WtkaNnYr1JnB/OMZljOV9hc9fg0AjnO4VxiwmculhzmYXWHSD08B4
         9gfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691157020; x=1691761820;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fvPQtc3n+AQ43mIboHGUgEC6liC/yfr/8rGlBJbQd4M=;
        b=LOfApIk1XRLLUzPff3HoIkLnxwIWb3rutYlpUUa9L//WPD84pFh5jzIxa3Z4AtV9Bu
         ggNiU14YgPi7+hHRezU6In21Cl+AwhenUsSlUx+jumn+s2zbYQpSPbQge5JVzUoISX8y
         FcJiRy0lCplML/11VcD/mbsyr17yLoLxOsChr9R+h4O7NJ5OpH+1QRn/LR40SyOQkALf
         LyOROs+3bArC3hjB+sX/e4l035rgiT0dw6OogMZGwB1ybUKkBNMSrwIemmiEHQ/NRGtt
         bsh1MjqGCTq7AZ7kb7pTcJpw2Z/bthCxQZ6WYmrrykTQvDAU0l6dNmv+I8TBx4ydSoqO
         8p0g==
X-Gm-Message-State: AOJu0YyA0Gvh3kOrQKXwzmqvgoW7UDNDw0mXWVbFiusnvDKfCbQJMqT/
        I7uUvjbW1c55o5jaKoTexfuVdw==
X-Google-Smtp-Source: AGHT+IFeH01Ul71Lfz7yHy0osMqSe97w2MvNWjvgtaNtKBWxfM55R1zGaAeI12b49Qk9Scr0K3+iNQ==
X-Received: by 2002:a1c:7709:0:b0:3fe:1b9e:e790 with SMTP id t9-20020a1c7709000000b003fe1b9ee790mr1609742wmi.2.1691157020150;
        Fri, 04 Aug 2023 06:50:20 -0700 (PDT)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:8261:5fff:fe11:bdda])
        by smtp.gmail.com with ESMTPSA id u25-20020a7bcb19000000b003fe1cac37d8sm6894793wmj.11.2023.08.04.06.50.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Aug 2023 06:50:19 -0700 (PDT)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Fri, 04 Aug 2023 15:50:08 +0200
Subject: [PATCH 2/4] usb: ucsi: glink: use the connector orientation GPIO
 to provide switch events
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230804-topic-sm8550-upstream-type-c-orientation-v1-2-36dd3edec7bf@linaro.org>
References: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
In-Reply-To: <20230804-topic-sm8550-upstream-type-c-orientation-v1-0-36dd3edec7bf@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=3618;
 i=neil.armstrong@linaro.org; h=from:subject:message-id;
 bh=2Yx8kmPz9CwCyctqse+y5FCFBBh71PuYcaSNl/C5414=;
 b=owEBbQKS/ZANAwAKAXfc29rIyEnRAcsmYgBkzQIYPn2uv3f3KnvwEme1PsIabLipHvXWSFjfWe5D
 0zTCEMyJAjMEAAEKAB0WIQQ9U8YmyFYF/h30LIt33NvayMhJ0QUCZM0CGAAKCRB33NvayMhJ0Rs0D/
 9Nf3DUub/be65RQP+RUcneISyhvLm49D5YBD2LAAYHwx7aJkO8B3QKE2D8zeWzWw6V6MQPFVwJeyr1
 JwJMiQpX/1CaJtLDR1y5RQ4kPLNjn1E4f+33VD+BSciFR/qbJWD2LllMU9k7ZLE6DZ9IF7fPLb08sB
 Okb869TcY0LZBQdoCgG9YAdycRmQVwez1aZAaPRAOciaMjfunRfGi71aN6UeAi8SonfpvrruLnBz5r
 U/ZLZRVdrh60lRULOoEvY7ZhVLK8UYDWNRHlyj0Wrjm3s49bPF62GRdaDZjtf21C+YlVdoS7+1NHhS
 KtQVlfZpEJ3XSbLz10WL7bNLOdYUaSa4g9XZEGX8A4IGDYGh4mOEskjHKvm5IFM5vPstFXIDtDUz/o
 zK03gXcBrPayuugsjvoAimjZnCnY238GrM80rO8X8qYqVKz6QgIerBv2VgabGRGLjktNgAyINrJY+6
 kJH5y4Lg5LYHHDz6BZvEog5RyE3OwuTvbHbU3j2Pb5t/v+c/mWaBlMgkisFWo+NNtq7iffhzM5So+p
 xvIMI2OIOs11+tl7YKprs0NxzFwzOFpfYUDr6sETCaNrZaHmnoe7AX7Ob5ZC43ZetaCs3bFVJDaOv6
 plvBMBGhVBWTJomHEnF6qGJfNbFb22l9g8LgqnerA5xeXOypceV4AcunklcA==
X-Developer-Key: i=neil.armstrong@linaro.org; a=openpgp;
 fpr=89EC3D058446217450F22848169AB7B1A4CFF8AE
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On SM8550, the non-altmode orientation is not given anymore within
altmode events, even with USB SVIDs events.

On the other side, the Type-C connector orientation is correctly
reported by a signal from the PMIC.

Take this gpio signal when we detect some Type-C port activity
to notify any Type-C switches tied to the Type-C port connectors.

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 drivers/usb/typec/ucsi/ucsi_glink.c | 54 ++++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/ucsi/ucsi_glink.c b/drivers/usb/typec/ucsi/ucsi_glink.c
index bb1854b3311d..db6e248f8208 100644
--- a/drivers/usb/typec/ucsi/ucsi_glink.c
+++ b/drivers/usb/typec/ucsi/ucsi_glink.c
@@ -8,9 +8,13 @@
 #include <linux/mutex.h>
 #include <linux/property.h>
 #include <linux/soc/qcom/pdr.h>
+#include <linux/usb/typec_mux.h>
+#include <linux/gpio/consumer.h>
 #include <linux/soc/qcom/pmic_glink.h>
 #include "ucsi.h"
 
+#define PMIC_GLINK_MAX_PORTS	2
+
 #define UCSI_BUF_SIZE                   48
 
 #define MSG_TYPE_REQ_RESP               1
@@ -52,6 +56,9 @@ struct ucsi_notify_ind_msg {
 struct pmic_glink_ucsi {
 	struct device *dev;
 
+	struct gpio_desc *port_orientation[PMIC_GLINK_MAX_PORTS];
+	struct typec_switch *port_switch[PMIC_GLINK_MAX_PORTS];
+
 	struct pmic_glink_client *client;
 
 	struct ucsi *ucsi;
@@ -220,8 +227,20 @@ static void pmic_glink_ucsi_notify(struct work_struct *work)
 	}
 
 	con_num = UCSI_CCI_CONNECTOR(cci);
-	if (con_num)
+	if (con_num) {
+		if (con_num < PMIC_GLINK_MAX_PORTS &&
+		    ucsi->port_orientation[con_num - 1]) {
+			int orientation = gpiod_get_value(ucsi->port_orientation[con_num - 1]);
+
+			if (orientation >= 0) {
+				typec_switch_set(ucsi->port_switch[con_num - 1],
+						 orientation ? TYPEC_ORIENTATION_REVERSE
+							     : TYPEC_ORIENTATION_NORMAL);
+			}
+		}
+
 		ucsi_connector_change(ucsi->ucsi, con_num);
+	}
 
 	if (ucsi->sync_pending && cci & UCSI_CCI_BUSY) {
 		ucsi->sync_val = -EBUSY;
@@ -282,6 +301,7 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 {
 	struct pmic_glink_ucsi *ucsi;
 	struct device *dev = &adev->dev;
+	struct fwnode_handle *fwnode;
 	int ret;
 
 	ucsi = devm_kzalloc(dev, sizeof(*ucsi), GFP_KERNEL);
@@ -309,6 +329,38 @@ static int pmic_glink_ucsi_probe(struct auxiliary_device *adev,
 
 	ucsi_set_drvdata(ucsi->ucsi, ucsi);
 
+	device_for_each_child_node(dev, fwnode) {
+		struct gpio_desc *desc;
+		u32 port;
+
+		ret = fwnode_property_read_u32(fwnode, "reg", &port);
+		if (ret < 0) {
+			dev_err(dev, "missing reg property of %pOFn\n", fwnode);
+			return ret;
+		}
+
+		if (port >= PMIC_GLINK_MAX_PORTS) {
+			dev_warn(dev, "invalid connector number, ignoring\n");
+			continue;
+		}
+
+		desc = devm_gpiod_get_index_optional(&adev->dev, "orientation", port, GPIOD_IN);
+
+		/* If GPIO isn't found, continue */
+		if (!desc)
+			continue;
+
+		if (IS_ERR(desc))
+			return dev_err_probe(dev, PTR_ERR(desc),
+					     "unable to acquire orientation gpio\n");
+		ucsi->port_orientation[port] = desc;
+
+		ucsi->port_switch[port] = fwnode_typec_switch_get(fwnode);
+		if (IS_ERR(ucsi->port_switch[port]))
+			return dev_err_probe(dev, PTR_ERR(ucsi->port_switch[port]),
+					"failed to acquire orientation-switch\n");
+	}
+
 	ucsi->client = devm_pmic_glink_register_client(dev,
 						       PMIC_GLINK_OWNER_USBC,
 						       pmic_glink_ucsi_callback,

-- 
2.34.1

