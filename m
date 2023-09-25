Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1FAB7AD8D1
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 15:18:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbjIYNSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 09:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231719AbjIYNSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 09:18:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070DA10C
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:18:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2bff7d81b5eso107652281fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 06:17:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1695647878; x=1696252678; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AhqA1MINgd8wyumHzpkMN5QpwMn1VgvFU5R0O3ONAJM=;
        b=WJZ1+v4dJpEF0/JCo1gXHeok7+x23CgH7EbvEhJDP6uGQnY1nGzvLiAkqrwyOS3FK7
         CLB4/TGALr4AbLXmqZ+gTqp3OqLj9NMti4DTfbCN/txNBwHi+Qv64WUjMekKK5JUe8Gt
         810uMZs4frSaJw1srOAaVLtrEewI2d0Ne3ePowg0nYXvzDYSl8oXKq55dmj7s80N9ll+
         OlS4UZ9/vRFFw7G1lt6vrutHy0RxBRzdNmIBw8anv3HGDWh7/jbqBRE+pdERL9oWb+ZX
         wsHBy4DXxdWOuqhlY0DIQCLLE+ktTe89kV4/BvOZEb+M0Z8J0T6hLI5jQIn3XiZn2JfN
         kDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695647878; x=1696252678;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AhqA1MINgd8wyumHzpkMN5QpwMn1VgvFU5R0O3ONAJM=;
        b=v1NikzRkcTutCEceXkpK6QLpBoV2udm9qZFFOuBZFdl6r+VDUwxJJs+hfMa/UVs+Fe
         voHA7WLq6HBUahq+zeQBXt6qU6GZkjt7TawPOHAHw8a9U0p+1Dxj8peAJNdpFrE54e0P
         hrDJB7ggcXKCLDlk7frotY6CvLpkI+8+9RgINpiS0hk/TbzFfNTvpE3Bk0gmlycg6JXk
         USATUqhdGL7nLLVWivv/bXwhzWDj8HwM3/WWmAhIhrXF9xqJ82CXlXQJ/bcyQCNPA9Vk
         BNhiOvlM+IvnTACmCgB4Yh0PTAXF6y18fLwHLn0ftflbbBUO9hHVwBO2iqkakegu/O2e
         pi2g==
X-Gm-Message-State: AOJu0YzFCklcnGp04zOmFE+IRWVbIOX+r15TeP4+8E7aJu0gm3WL4Gq7
        SjeryePy2rzn6x4hqVpd0Rf5qHIrLpwh84rwmtI=
X-Google-Smtp-Source: AGHT+IEx0/FnswSLreQOTAQvzgEeo+ZXQR2hUTbg7rc24PHFcZe2gDmlgALwkrWzUFAiCn1WtP5WzQ==
X-Received: by 2002:a05:6512:3082:b0:4fa:ad2d:6c58 with SMTP id z2-20020a056512308200b004faad2d6c58mr6251416lfd.61.1695647878222;
        Mon, 25 Sep 2023 06:17:58 -0700 (PDT)
Received: from uffe-tuxpro14.. (h-94-254-63-18.NA.cust.bahnhof.se. [94.254.63.18])
        by smtp.gmail.com with ESMTPSA id m29-20020a056512015d00b004fe10276bbfsm1823583lfo.296.2023.09.25.06.17.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Sep 2023 06:17:57 -0700 (PDT)
From:   Ulf Hansson <ulf.hansson@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Cristian Marussi <cristian.marussi@arm.com>,
        Viresh Kumar <vireshk@kernel.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>
Cc:     Nishanth Menon <nm@ti.com>, Stephen Boyd <sboyd@kernel.org>,
        Nikunj Kela <nkela@quicinc.com>,
        Prasad Sodagudi <psodagud@quicinc.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Ulf Hansson <ulf.hansson@linaro.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 3/9] OPP: Add dev_pm_opp_add_dynamic() to allow more flexibility
Date:   Mon, 25 Sep 2023 15:17:09 +0200
Message-Id: <20230925131715.138411-4-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230925131715.138411-1-ulf.hansson@linaro.org>
References: <20230925131715.138411-1-ulf.hansson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The dev_pm_opp_add() API is limited to add dynamic OPPs with a frequency
and a voltage level. To enable more flexibility, let's add a new API,
dev_pm_opp_add_dynamic() that's takes a struct dev_pm_opp_data* instead of
a list of in-parameters.

Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
---
 drivers/opp/core.c     | 22 ++++++++++------------
 drivers/opp/of.c       | 10 ++++++----
 drivers/opp/opp.h      |  2 +-
 include/linux/pm_opp.h | 29 +++++++++++++++++++++++++----
 4 files changed, 42 insertions(+), 21 deletions(-)

diff --git a/drivers/opp/core.c b/drivers/opp/core.c
index 919cc53bc02e..54b6138e1189 100644
--- a/drivers/opp/core.c
+++ b/drivers/opp/core.c
@@ -2002,8 +2002,7 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * _opp_add_v1() - Allocate a OPP based on v1 bindings.
  * @opp_table:	OPP table
  * @dev:	device for which we do this operation
- * @freq:	Frequency in Hz for this OPP
- * @u_volt:	Voltage in uVolts for this OPP
+ * @data:	The OPP data for the OPP to add
  * @dynamic:	Dynamically added OPPs.
  *
  * This function adds an opp definition to the opp table and returns status.
@@ -2021,10 +2020,10 @@ int _opp_add(struct device *dev, struct dev_pm_opp *new_opp,
  * -ENOMEM	Memory allocation failure
  */
 int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
-		unsigned long freq, long u_volt, bool dynamic)
+		struct dev_pm_opp_data *data, bool dynamic)
 {
 	struct dev_pm_opp *new_opp;
-	unsigned long tol;
+	unsigned long tol, u_volt = data->u_volt;
 	int ret;
 
 	if (!assert_single_clk(opp_table))
@@ -2035,7 +2034,7 @@ int _opp_add_v1(struct opp_table *opp_table, struct device *dev,
 		return -ENOMEM;
 
 	/* populate the opp table */
-	new_opp->rates[0] = freq;
+	new_opp->rates[0] = data->freq;
 	tol = u_volt * opp_table->voltage_tolerance_v1 / 100;
 	new_opp->supplies[0].u_volt = u_volt;
 	new_opp->supplies[0].u_volt_min = u_volt - tol;
@@ -2825,10 +2824,9 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
 }
 
 /**
- * dev_pm_opp_add()  - Add an OPP table from a table definitions
- * @dev:	device for which we do this operation
- * @freq:	Frequency in Hz for this OPP
- * @u_volt:	Voltage in uVolts for this OPP
+ * dev_pm_opp_add_dynamic()  - Add an OPP table from a table definitions
+ * @dev:	The device for which we do this operation
+ * @data:	The OPP data for the OPP to add
  *
  * This function adds an opp definition to the opp table and returns status.
  * The opp is made available by default and it can be controlled using
@@ -2841,7 +2839,7 @@ int dev_pm_opp_xlate_performance_state(struct opp_table *src_table,
  *		Duplicate OPPs (both freq and volt are same) and !opp->available
  * -ENOMEM	Memory allocation failure
  */
-int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
+int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *data)
 {
 	struct opp_table *opp_table;
 	int ret;
@@ -2853,13 +2851,13 @@ int dev_pm_opp_add(struct device *dev, unsigned long freq, unsigned long u_volt)
 	/* Fix regulator count for dynamic OPPs */
 	opp_table->regulator_count = 1;
 
-	ret = _opp_add_v1(opp_table, dev, freq, u_volt, true);
+	ret = _opp_add_v1(opp_table, dev, data, true);
 	if (ret)
 		dev_pm_opp_put_opp_table(opp_table);
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dev_pm_opp_add);
+EXPORT_SYMBOL_GPL(dev_pm_opp_add_dynamic);
 
 /**
  * _opp_set_availability() - helper to set the availability of an opp
diff --git a/drivers/opp/of.c b/drivers/opp/of.c
index ada4963c7cfa..ade6d42cae46 100644
--- a/drivers/opp/of.c
+++ b/drivers/opp/of.c
@@ -1077,13 +1077,15 @@ static int _of_add_opp_table_v1(struct device *dev, struct opp_table *opp_table)
 
 	val = prop->value;
 	while (nr) {
-		unsigned long freq = be32_to_cpup(val++) * 1000;
-		unsigned long volt = be32_to_cpup(val++);
+		struct dev_pm_opp_data data = {
+			.freq = be32_to_cpup(val++) * 1000,
+			.u_volt = be32_to_cpup(val++),
+		};
 
-		ret = _opp_add_v1(opp_table, dev, freq, volt, false);
+		ret = _opp_add_v1(opp_table, dev, &data, false);
 		if (ret) {
 			dev_err(dev, "%s: Failed to add OPP %ld (%d)\n",
-				__func__, freq, ret);
+				__func__, data.freq, ret);
 			goto remove_static_opp;
 		}
 		nr -= 2;
diff --git a/drivers/opp/opp.h b/drivers/opp/opp.h
index 8a5ea38f3a3d..fefdf9845692 100644
--- a/drivers/opp/opp.h
+++ b/drivers/opp/opp.h
@@ -251,7 +251,7 @@ struct dev_pm_opp *_opp_allocate(struct opp_table *opp_table);
 void _opp_free(struct dev_pm_opp *opp);
 int _opp_compare_key(struct opp_table *opp_table, struct dev_pm_opp *opp1, struct dev_pm_opp *opp2);
 int _opp_add(struct device *dev, struct dev_pm_opp *new_opp, struct opp_table *opp_table);
-int _opp_add_v1(struct opp_table *opp_table, struct device *dev, unsigned long freq, long u_volt, bool dynamic);
+int _opp_add_v1(struct opp_table *opp_table, struct device *dev, struct dev_pm_opp_data *data, bool dynamic);
 void _dev_pm_opp_cpumask_remove_table(const struct cpumask *cpumask, int last_cpu);
 struct opp_table *_add_opp_table_indexed(struct device *dev, int index, bool getclk);
 void _put_opp_list_kref(struct opp_table *opp_table);
diff --git a/include/linux/pm_opp.h b/include/linux/pm_opp.h
index 91f87d7e807c..a8ee93ba41d8 100644
--- a/include/linux/pm_opp.h
+++ b/include/linux/pm_opp.h
@@ -92,6 +92,16 @@ struct dev_pm_opp_config {
 	struct device ***virt_devs;
 };
 
+/**
+ * struct dev_pm_opp_data - The data to use to initialize an OPP.
+ * @freq: The clock rate in Hz for the OPP.
+ * @u_volt: The voltage in uV for the OPP.
+ */
+struct dev_pm_opp_data {
+	unsigned long freq;
+	unsigned long u_volt;
+};
+
 #if defined(CONFIG_PM_OPP)
 
 struct opp_table *dev_pm_opp_get_opp_table(struct device *dev);
@@ -152,8 +162,8 @@ struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 
 void dev_pm_opp_put(struct dev_pm_opp *opp);
 
-int dev_pm_opp_add(struct device *dev, unsigned long freq,
-		   unsigned long u_volt);
+int dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp);
+
 void dev_pm_opp_remove(struct device *dev, unsigned long freq);
 void dev_pm_opp_remove_all_dynamic(struct device *dev);
 
@@ -322,8 +332,8 @@ static inline struct dev_pm_opp *dev_pm_opp_find_bw_floor(struct device *dev,
 
 static inline void dev_pm_opp_put(struct dev_pm_opp *opp) {}
 
-static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
-					unsigned long u_volt)
+static inline int
+dev_pm_opp_add_dynamic(struct device *dev, struct dev_pm_opp_data *opp)
 {
 	return -EOPNOTSUPP;
 }
@@ -519,6 +529,17 @@ static inline int dev_pm_opp_of_find_icc_paths(struct device *dev, struct opp_ta
 
 /* OPP Configuration helpers */
 
+static inline int dev_pm_opp_add(struct device *dev, unsigned long freq,
+				 unsigned long u_volt)
+{
+	struct dev_pm_opp_data data = {
+		.freq = freq,
+		.u_volt = u_volt,
+	};
+
+	return dev_pm_opp_add_dynamic(dev, &data);
+}
+
 /* Regulators helpers */
 static inline int dev_pm_opp_set_regulators(struct device *dev,
 					    const char * const names[])
-- 
2.34.1

