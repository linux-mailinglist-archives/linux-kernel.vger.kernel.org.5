Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 190817E6767
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 11:07:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233917AbjKIKH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 05:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233290AbjKIKHG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 05:07:06 -0500
Received: from mail-pg1-x535.google.com (mail-pg1-x535.google.com [IPv6:2607:f8b0:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 783CD30E1
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 02:07:04 -0800 (PST)
Received: by mail-pg1-x535.google.com with SMTP id 41be03b00d2f7-5b856d73a12so566654a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 02:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699524424; x=1700129224; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Rs4qbwNofKphTE2zreJeFqCc6xRNAsKGF5LoBHdl0a8=;
        b=HAkuhHb7SzSz6OhGNf394Dui6jFOjbDVL3coBmNzq37xaektQl4rJtUPvTlaBeB42p
         q+As9HodIdDYp7KbqaNKRJTu1ASdCL5Fs1DdUMHs5q/gYAUtIuu2QVd5jVlYsoRlPPyL
         fpUw1CLXQhgPD3R7s6HFUjMFYsN+RuzDmDWk0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699524424; x=1700129224;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Rs4qbwNofKphTE2zreJeFqCc6xRNAsKGF5LoBHdl0a8=;
        b=wrLuduWSMbjbnZ5qsOQzOWsANM4tzrNDtVunWj7s3jm1hn/vlqrqWF+xgIyolI8urA
         SbeUK6rFjI2tM9BoykjrC3arEZWhb0kD120QMAPXj2USW4iI+ohp+m5fZ9db507Bmq2P
         Fkzr9XVj1w9kiICmCBsEgKs/uXTmvDFJwUYcTdLzup0onn0BdBQ0nLWxuETi6mbyqWWV
         YBNL340cLqM1Kmo1H9dIQidJm5bencB4ZIot/NG8pCmeZcGyTlDkYnv6FoL/1XiKk8TL
         bUSp161siLhtdJ+w0JUdbAgAKMMQ66CVaFg4p5VYENrMrrPuns5ColtHPdfRajOZNxLQ
         VQtg==
X-Gm-Message-State: AOJu0YzpjaitFS+vj5FfL1Wxq3UbTZEHx5GlH3zXE2lcIdYxU60Yxx6C
        AtZzrvT5HXhINVe6pkFIhllEKQ==
X-Google-Smtp-Source: AGHT+IHWUtsr4bhvzCEP1VHdQwxeHKMo7QV044imQ44mdSODoeojv4KtXVlrqKklo16HOdu2p0mAvw==
X-Received: by 2002:a17:902:f807:b0:1c9:b2c1:139c with SMTP id ix7-20020a170902f80700b001c9b2c1139cmr4180478plb.62.1699524423943;
        Thu, 09 Nov 2023 02:07:03 -0800 (PST)
Received: from wenstp920.tpe.corp.google.com ([2401:fa00:1:10:6f57:d4c:468c:5daf])
        by smtp.gmail.com with ESMTPSA id c13-20020a170902d48d00b001c60ba709b7sm3127511plg.125.2023.11.09.02.06.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 02:07:03 -0800 (PST)
From:   Chen-Yu Tsai <wenst@chromium.org>
To:     Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        andriy.shevchenko@linux.intel.com, Jiri Kosina <jikos@kernel.org>,
        linus.walleij@linaro.org, broonie@kernel.org,
        gregkh@linuxfoundation.org, hdegoede@redhat.com,
        james.clark@arm.com, james@equiv.tech, keescook@chromium.org,
        petr.tesarik.ext@huawei.com, rafael@kernel.org, tglx@linutronix.de,
        Jeff LaBundy <jeff@labundy.com>, linux-input@vger.kernel.org,
        Chen-Yu Tsai <wenst@chromium.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Douglas Anderson <dianders@chromium.org>,
        Johan Hovold <johan@kernel.org>
Subject: [RFC PATCH v2 5/7] of: hw_prober: Support Chromebook SKU ID based component selection
Date:   Thu,  9 Nov 2023 18:06:02 +0800
Message-ID: <20231109100606.1245545-6-wenst@chromium.org>
X-Mailer: git-send-email 2.42.0.869.gea05f2083d-goog
In-Reply-To: <20231109100606.1245545-1-wenst@chromium.org>
References: <20231109100606.1245545-1-wenst@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In cases where the same Chromebook model is manufactured with different
components (MIPI DSI panels, MIPI CSI camera sensors, or trackpad /
touchscreens with conflicting addresses), a different SKU ID is
allocated to each specific combination. This SKU ID is exported by the
bootloader into the device tree, and can be used to "discover" which
combination is present on the current machine.

This change adds a hardware prober that will match the SKU ID against
a provided table, and enable the component for the matched entry based
on the given compatible string. In the MIPI DSI panel and MIPI CSI
camera sensor cases which have OF graphs, it will also update the
remote endpoint to point to the enabled component. This assumes a single
endpoint only.

This will provide a path to reducing the number of Chromebook device
trees.

Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
---
 drivers/of/hw_prober.c | 160 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 160 insertions(+)

diff --git a/drivers/of/hw_prober.c b/drivers/of/hw_prober.c
index 442da6eff896..4345e5aed6d8 100644
--- a/drivers/of/hw_prober.c
+++ b/drivers/of/hw_prober.c
@@ -8,6 +8,7 @@
 #include <linux/array_size.h>
 #include <linux/i2c.h>
 #include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 
 #define DRV_NAME	"hw_prober"
@@ -108,9 +109,168 @@ static int i2c_component_prober(struct platform_device *pdev, const void *data)
 	return ret;
 }
 
+static int cros_get_coreboot_sku_id(struct device *dev, u32 *sku_id)
+{
+	struct device_node *node = NULL;
+	int ret;
+
+	node = of_find_node_by_path("/firmware/coreboot");
+	if (!node)
+		return dev_err_probe(dev, -EINVAL, "Cannot find coreboot firmware node\n");
+
+	ret = of_property_read_u32(node, "sku-id", sku_id);
+	if (ret)
+		dev_err_probe(dev, ret, "Cannot get SKU ID\n");
+
+	of_node_put(node);
+	return ret;
+}
+
+struct cros_sku_option {
+	u32	sku_id_val;
+	u32	sku_id_mask;
+	const char *compatible;
+};
+
+struct cros_sku_component_data {
+	const struct cros_sku_option *options;
+	int num_options;
+};
+
+/*
+ * cros_sku_component_selector - Selectively enable a component based on SKU ID
+ *
+ * Based on the list of component options and SKU ID read back from the device
+ * tree, enable the matching component. Also update the OF graph if it exists,
+ * so that the enabled component's remote endpoint correctly points to it. This
+ * assumes a single local endpoint, which should be the case for panels and
+ * camera sensors.
+ */
+static int cros_sku_component_selector(struct platform_device *pdev, const void *data)
+{
+	const struct cros_sku_component_data *pdata = data;
+	const char *compatible;
+	struct device_node *node = NULL, *endpoint = NULL, *remote = NULL;
+	struct property *status_prop = NULL, *endpoint_prop = NULL;
+	struct of_changeset *ocs = NULL;
+	__be32 *val = NULL;
+	int ret, i;
+	u32 sku_id;
+
+	if (!data)
+		return dev_err_probe(&pdev->dev, -EINVAL, "No data given\n");
+
+	ret = cros_get_coreboot_sku_id(&pdev->dev, &sku_id);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < pdata->num_options; i++)
+		if ((sku_id & pdata->options[i].sku_id_mask) == pdata->options[i].sku_id_val) {
+			compatible = pdata->options->compatible;
+			break;
+		}
+
+	if (i == pdata->num_options)
+		return dev_err_probe(&pdev->dev, -EINVAL, "Unknown SKU ID: 0x%x\n", sku_id);
+
+	node = of_find_compatible_node(NULL, NULL, compatible);
+	if (!node)
+		return dev_err_probe(&pdev->dev, -ENODEV, "Cannot find matching device node\n");
+
+	/* device node not marked as fail; don't mess with the device tree */
+	if (!of_device_is_fail(node))
+		goto err_free;
+
+	dev_info(&pdev->dev, "Enabling %pOF for SKU 0x%x\n", node, sku_id);
+
+	ret = -ENOMEM;
+	ocs = kzalloc(sizeof(*ocs), GFP_KERNEL);
+	if (!ocs)
+		goto err_free;
+
+	status_prop = kzalloc(sizeof(*status_prop), GFP_KERNEL);
+	if (!status_prop)
+		goto err_free;
+
+	status_prop->name   = "status";
+	status_prop->length = 5;
+	status_prop->value  = "okay";
+
+	/* Create changeset to apply DT changes atomically */
+	of_changeset_init(ocs);
+
+	if (of_graph_is_present(node)) {
+		ret = -EINVAL;
+
+		/* This currently assumes a single port on the component. */
+		endpoint = of_graph_get_next_endpoint(node, NULL);
+		if (!endpoint) {
+			dev_err(&pdev->dev, "No endpoint found for %pOF\n", node);
+			goto err_destroy_ocs;
+		}
+
+		remote = of_graph_get_remote_endpoint(endpoint);
+		if (!remote) {
+			dev_err(&pdev->dev, "No remote endpoint node found for %pOF\n", endpoint);
+			goto err_destroy_ocs;
+		}
+
+		endpoint_prop = kzalloc(sizeof(*endpoint_prop), GFP_KERNEL);
+		if (!endpoint_prop)
+			goto err_destroy_ocs;
+
+		val = kzalloc(sizeof(*val), GFP_KERNEL);
+		if (!val)
+			goto err_destroy_ocs;
+
+		*val = cpu_to_be32(endpoint->phandle);
+		endpoint_prop->name   = "remote-endpoint";
+		endpoint_prop->length = sizeof(*val);
+		endpoint_prop->value  = val;
+
+		ret = of_changeset_update_property(ocs, node, endpoint_prop);
+		if (ret)
+			goto err_destroy_ocs;
+	}
+
+	ret = of_changeset_update_property(ocs, node, status_prop);
+	if (ret)
+		goto err_destroy_ocs;
+	ret = of_changeset_apply(ocs);
+	if (ret)
+		goto err_destroy_ocs;
+
+	of_node_put(node);
+
+	return 0;
+
+err_destroy_ocs:
+	of_node_put(remote);
+	of_node_put(endpoint);
+	kfree(val);
+	kfree(endpoint_prop);
+	of_changeset_destroy(ocs);
+err_free:
+	kfree(ocs);
+	kfree(status_prop);
+	of_node_put(node);
+	return ret;
+}
+
+static const struct cros_sku_option cros_krane_panel_options[] = {
+	{ .sku_id_val = 0x00, .sku_id_mask = 0xf0, .compatible = "auo,kd101n80-45na" },
+	{ .sku_id_val = 0xb0, .sku_id_mask = 0xf0, .compatible = "boe,tv101wum-nl6" },
+};
+
+static const struct cros_sku_component_data cros_krane_panel_data = {
+	.options     = cros_krane_panel_options,
+	.num_options = ARRAY_SIZE(cros_krane_panel_options),
+};
+
 static const struct hw_prober_entry hw_prober_platforms[] = {
 	{ .compatible = "google,hana", .prober = i2c_component_prober, .data = "touchscreen" },
 	{ .compatible = "google,hana", .prober = i2c_component_prober, .data = "trackpad" },
+	{ .compatible = "google,krane", .prober = cros_sku_component_selector, .data = &cros_krane_panel_data },
 };
 
 static int hw_prober_probe(struct platform_device *pdev)
-- 
2.42.0.869.gea05f2083d-goog

