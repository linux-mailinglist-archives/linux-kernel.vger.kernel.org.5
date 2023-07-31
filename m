Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F4587693B3
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 12:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232370AbjGaKyZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 06:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232053AbjGaKxh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 06:53:37 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FA751BDB
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:35 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-4fb960b7c9dso6932935e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jul 2023 03:52:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690800753; x=1691405553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SyCiXkI6QRxT+Oa2T9MJLKBFuocjUwBVkwW1HGRN0Ho=;
        b=oTuXgKxcrjmDmz/vd223QsDybin2mMNw85Qpe/BHUdzP3EJIOONTA3KDbmuqr6UvOs
         K3hkBZxZvH+CrWqW6xdM75qca26NAIcRsyhdi8CwjDo+k79+asbgBKqFfcoOZCBWpObp
         9KzqSxaGfZLeq6PWQnyZNH0+QW8zjTYWCzCwp+ysilSJl6vQHCzJCrHnZjwD66eB+zAc
         yS0KiMU7rfvCUu7ATFmmk9/Kzx7sl8mL19IDfy+VM0Z874GkT/IuSIakzpFrWvJf3ADF
         tZ1yZXruy7OHNTxtEAvnPXHFuRjAgcSOmfaWUl7A3lWgVjcIla4F1UkQEHZymhlqo+IL
         xhOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690800753; x=1691405553;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SyCiXkI6QRxT+Oa2T9MJLKBFuocjUwBVkwW1HGRN0Ho=;
        b=OmdFI1J6lGjfW7UjAGcj1hEcn4qKk+gFD1tKXyN04c6C801SZClCPuLKoFO+jAhf9W
         3G/3wUE+DzCY5gYlWn/jqWbqtGpleaWQ+Crq/ZmJV3bqmaSFIGxybf6bJQ+RKbDOTR35
         0fa+4XvveFK9tT3ZR2Wb1GpVe3GTjkq5u+ssIybXHhhJsE7uJlUw8/L89WhNH0LkWrIg
         DpJuoRIGGt9bySNqyBXuWjspd8bsaTEnNYnfiF0EC8s3EYBiXPJ70vc90YW4j5cTjL6h
         qp+tk6aDzyAYScIsxOAGcVdftSKUaEYH6ir2RbAZH7z5m8mOKbzcojPHEf5k6D4ok5kP
         Tt6A==
X-Gm-Message-State: ABy/qLboncufZPrxFtkuwJelFjp/ml+wVdQlefXeaCJtUHnpT+Q36MSm
        TnYcVnbeoU4P/dwRMcH4eA2o94AWI4YaWBqguGsWIg==
X-Google-Smtp-Source: APBJJlEkWx1UspnMOC4K6OlN6pUWWcihfTOd+aLAalf5gRPomz0lkaLo1QYzVqiO0ebewCDQ124Buw==
X-Received: by 2002:a05:6512:70c:b0:4fb:7675:1ff9 with SMTP id b12-20020a056512070c00b004fb76751ff9mr4987276lfs.9.1690800753268;
        Mon, 31 Jul 2023 03:52:33 -0700 (PDT)
Received: from [192.168.1.101] (abyk53.neoplus.adsl.tpnet.pl. [83.9.30.53])
        by smtp.gmail.com with ESMTPSA id p13-20020a05651238cd00b004fdc7ec5cbesm2016936lft.300.2023.07.31.03.52.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jul 2023 03:52:32 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Mon, 31 Jul 2023 12:52:19 +0200
Subject: [PATCH v2 03/10] interconnect: qcom: icc-rpm: Let nodes drive
 their own bus clock
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230726-topic-icc_coeff-v2-3-8c91c6c76076@linaro.org>
References: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
In-Reply-To: <20230726-topic-icc_coeff-v2-0-8c91c6c76076@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1690800744; l=4308;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=nSSCPCfi3ZZHojNecOL8pN1yRNY2ZL7Z9o4VoBkikQE=;
 b=iJSMtQp2Z2z2ss433XEhkkMGwAkdLDrkvHQX6vhXeClylbRp70A9lJV66giz8PV1T32pRph+F
 O+PVjr2sNN5AWsUf2c68aHFiOH/8NcW5POz+TNiBPWoe/J5CbUZL32C
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If this hardware couldn't get messier, some nodes are supposed to drive
their own bus clock.. Presumably to connect to some intermediate
interface between the node itself and the bus it's (supposed to be)
connected to.

Expand the node struct with the necessary data and hook up the
allocations & calculations.

To save on memory (not very many nodes have their own clocks), allocate
a pointer to an array instead of allocating an array within
qcom_icc_node.

Note that the node-specific AB/IB coefficients contribute (by design)
to both the node-level and the bus-level aggregation.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/interconnect/qcom/icc-rpm.c | 48 +++++++++++++++++++++++++++++++------
 drivers/interconnect/qcom/icc-rpm.h |  2 ++
 2 files changed, 43 insertions(+), 7 deletions(-)

diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
index f1d8ed354718..f0e575c95b49 100644
--- a/drivers/interconnect/qcom/icc-rpm.c
+++ b/drivers/interconnect/qcom/icc-rpm.c
@@ -411,6 +411,33 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
 		qp->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
 	}
 
+	/* Handle the node-specific clock */
+	if (!src_qn->bus_clk_desc)
+		return 0;
+
+	active_rate = qcom_icc_calc_rate(qp, src_qn, QCOM_SMD_RPM_ACTIVE_STATE);
+	sleep_rate = qcom_icc_calc_rate(qp, src_qn, QCOM_SMD_RPM_SLEEP_STATE);
+
+	if (active_rate != src_qn->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE]) {
+		ret = qcom_icc_rpm_set_bus_rate(src_qn->bus_clk_desc, QCOM_SMD_RPM_ACTIVE_STATE,
+						active_rate);
+		if (ret)
+			return ret;
+
+		/* Cache the rate after we've successfully committed it to RPM */
+		src_qn->bus_clk_rate[QCOM_SMD_RPM_ACTIVE_STATE] = active_rate;
+	}
+
+	if (sleep_rate != src_qn->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE]) {
+		ret = qcom_icc_rpm_set_bus_rate(src_qn->bus_clk_desc, QCOM_SMD_RPM_SLEEP_STATE,
+						sleep_rate);
+		if (ret)
+			return ret;
+
+		/* Cache the rate after we've successfully committed it to RPM */
+		src_qn->bus_clk_rate[QCOM_SMD_RPM_SLEEP_STATE] = sleep_rate;
+	}
+
 	return 0;
 }
 
@@ -531,24 +558,31 @@ int qnoc_probe(struct platform_device *pdev)
 		return ret;
 
 	for (i = 0; i < num_nodes; i++) {
+		struct qcom_icc_node *qn = qnodes[i];
 		size_t j;
 
-		node = icc_node_create(qnodes[i]->id);
+		if (qn->bus_clk_desc) {
+			qn->bus_clk_rate = devm_kcalloc(dev, QCOM_SMD_RPM_STATE_NUM,
+							sizeof(*qn->bus_clk_rate),
+							GFP_KERNEL);
+		}
+
+		node = icc_node_create(qn->id);
 		if (IS_ERR(node)) {
 			ret = PTR_ERR(node);
 			goto err_remove_nodes;
 		}
 
-		node->name = qnodes[i]->name;
-		node->data = qnodes[i];
+		node->name = qn->name;
+		node->data = qn;
 		icc_node_add(node, provider);
 
-		for (j = 0; j < qnodes[i]->num_links; j++)
-			icc_link_create(node, qnodes[i]->links[j]);
+		for (j = 0; j < qn->num_links; j++)
+			icc_link_create(node, qn->links[j]);
 
 		/* Set QoS registers (we only need to do it once, generally) */
-		if (qnodes[i]->qos.ap_owned &&
-		    qnodes[i]->qos.qos_mode != NOC_QOS_MODE_INVALID) {
+		if (qn->qos.ap_owned &&
+		    qn->qos.qos_mode != NOC_QOS_MODE_INVALID) {
 			ret = qcom_icc_qos_set(node);
 			if (ret)
 				return ret;
diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
index 5e7d6a4fd2f3..835b83cfb548 100644
--- a/drivers/interconnect/qcom/icc-rpm.h
+++ b/drivers/interconnect/qcom/icc-rpm.h
@@ -97,6 +97,7 @@ struct qcom_icc_qos {
  * @num_links: the total number of @links
  * @channels: number of channels at this node (e.g. DDR channels)
  * @buswidth: width of the interconnect between a node and the bus (bytes)
+ * @bus_clk_desc: a pointer to a rpm_clk_resource description of bus clocks
  * @sum_avg: current sum aggregate value of all avg bw requests
  * @max_peak: current max aggregate value of all peak bw requests
  * @mas_rpm_id:	RPM id for devices that are bus masters
@@ -110,6 +111,7 @@ struct qcom_icc_node {
 	u16 num_links;
 	u16 channels;
 	u16 buswidth;
+	const struct rpm_clk_resource *bus_clk_desc;
 	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
 	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
 	int mas_rpm_id;

-- 
2.41.0

