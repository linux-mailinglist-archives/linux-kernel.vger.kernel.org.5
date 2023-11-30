Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E87A87FF30A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 15:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346192AbjK3O62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 09:58:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346156AbjK3O6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 09:58:23 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0DB110D5
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:28 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id 4fb4d7f45d1cf-54b450bd014so1116557a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 06:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701356307; x=1701961107; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=FEWaT4vWmB9FPKlxuE8ZsMpGec2h+D+gnsnqlOC+FWw=;
        b=vnhsGY89wdTqXzmws+jns2gkOizWSLwPUVYkbMAsNJs3C8Xjigja3UyjoOU430UeAS
         tfG4iSSkTrsAIKiS7yrqa5o5p6bgQQ6tOHWUBOKzSir3YL2V+QeBdeFiI/rpng8n7mlR
         TfMidStH8w8ptL5dpW11vExK3mVFj2t43hVsB24jt5FXD/mhDv6J8xo9fVeq10+/DPE0
         SmnkSGi9Ag2j7/srLdursJvf3nZO3cBl7LVZZsmtcpUeYgmQB12xywm3jXzD2Wvgj7D2
         9A4jYHUuWEbi+yGJ/5AzbSJBCUtnBGwVcKR4Trnr0XQ1UY7l1qCxaHPXcqUps7GQEtSz
         Dt6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701356307; x=1701961107;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FEWaT4vWmB9FPKlxuE8ZsMpGec2h+D+gnsnqlOC+FWw=;
        b=lzSazBdTMVk51AkJ3UjMdBP9mREQZ+UZIlRrGc/685iy9u/S1w2CCIEqG3AZwlyCN6
         Au8GZYgTxDyA+IKuQ2/QV/BSQtxBqTfpMnzoZn5RjZ4qiQeLQ5QlK7V2WU1LqpnpE3vW
         0o21U/AnUYte15OtsoCCB2MjreIothdoy3TJxWoYvihZvh/MU4fYiWCeTUK/iycE/JJB
         a06bfFZy4lFOJ0bd9/NhVr42snJAX9VRx8LsDttvhNWsEMiSGu0SV+dIhLHuNVacrimg
         +XC6hSAupkiULPjEqteU+4EpBvh2nJ0Y0zLgr3kz5NbD4qdZX5nNICn8zWXSalUPfxfZ
         Kz6g==
X-Gm-Message-State: AOJu0Yykokd2IPJVYw/F4VtHStUElreQ7zsEkU3mpxmoxNs4oa6Q3bPB
        uq5irv+tibQchhLT/EJoaZAxhg==
X-Google-Smtp-Source: AGHT+IH32OpKgq8DOm58fWQmY+Cdt2aGkHh2/RMF2craPX73HwEmtnQ2TUVg6DtANndN58S6bPTkMg==
X-Received: by 2002:a17:906:5307:b0:a09:589f:8853 with SMTP id h7-20020a170906530700b00a09589f8853mr14757421ejo.66.1701356307328;
        Thu, 30 Nov 2023 06:58:27 -0800 (PST)
Received: from [10.167.154.1] (178235187166.dynamic-4-waw-k-2-3-0.vectranet.pl. [178.235.187.166])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090640c500b009e50ea0a05asm756753ejk.99.2023.11.30.06.58.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 06:58:27 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Date:   Thu, 30 Nov 2023 15:58:22 +0100
Subject: [PATCH 2/3] soc: qcom: stats: Add DDR sleep stats
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231130-topic-ddr_sleep_stats-v1-2-5981c2e764b6@linaro.org>
References: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
In-Reply-To: <20231130-topic-ddr_sleep_stats-v1-0-5981c2e764b6@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maulik Shah <quic_mkshah@quicinc.com>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1701356302; l=7789;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=n247b3gscc6TQzkRebaWpfpSPhntN+5rBPC03jA9Nlw=;
 b=pquLU0BKQ6uVxtgV2+o/+kiSu+6/SuinRalqCnajEMKMU120Sw1UvjY/mYzKPOWcvLN74U395
 3PzqcQeldxHDYc6iIR8UYsQyRBwAvJZjnKoN20NCDQJh4KIgfrigEzh
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add DDR sleep stats that include:

- the available RAM low power states
- per-state residency information
- per-frequency residency information (for some freqs only, it seems)
- DDR vote information (AB/IB)

and some magic thing that we're yet to decode.

Based on the msm-5.4 downstream implementation, debugged with some help
from Qualcomm's Maulik Shah.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/soc/qcom/qcom_stats.c | 186 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 185 insertions(+), 1 deletion(-)

diff --git a/drivers/soc/qcom/qcom_stats.c b/drivers/soc/qcom/qcom_stats.c
index 0216fc24f2ca..94ee543d2e8e 100644
--- a/drivers/soc/qcom/qcom_stats.c
+++ b/drivers/soc/qcom/qcom_stats.c
@@ -11,6 +11,7 @@
 #include <linux/platform_device.h>
 #include <linux/seq_file.h>
 
+#include <linux/soc/qcom/qcom_aoss.h>
 #include <linux/soc/qcom/smem.h>
 #include <clocksource/arm_arch_timer.h>
 
@@ -22,8 +23,20 @@
 #define LAST_ENTERED_AT_OFFSET	0x8
 #define LAST_EXITED_AT_OFFSET	0x10
 #define ACCUMULATED_OFFSET	0x18
+#define DDR_DYNAMIC_OFFSET	0x1c
+ #define DDR_OFFSET_MASK	GENMASK(9, 0)
 #define CLIENT_VOTES_OFFSET	0x20
 
+#define ARCH_TIMER_FREQ		19200000
+#define DDR_MAGIC_KEY1		0xA1157A75 /* leetspeak "ALLSTATS" */
+#define DDR_MAX_NUM_ENTRIES	20
+
+#define DDR_VOTE_DRV_MAX	18
+#define DDR_VOTE_DRV_ABSENT	0xdeaddead
+#define DDR_VOTE_DRV_INVALID	0xffffdead
+#define DDR_VOTE_X		GENMASK(27, 14)
+#define DDR_VOTE_Y		GENMASK(13, 0)
+
 struct subsystem_data {
 	const char *name;
 	u32 smem_item;
@@ -48,6 +61,7 @@ struct stats_config {
 	bool appended_stats_avail;
 	bool dynamic_offset;
 	bool subsystem_stats_in_smem;
+	bool ddr_stats;
 };
 
 struct stats_data {
@@ -68,6 +82,25 @@ struct appended_stats {
 	u32 reserved[3];
 };
 
+struct ddr_stats_entry {
+	u32 name;
+	u32 count;
+	u64 dur;
+} __packed;
+
+struct ddr_stats {
+	u32 key;
+	u32 entry_count;
+#define MAX_DDR_STAT_ENTRIES	20
+	struct ddr_stats_entry entry[MAX_DDR_STAT_ENTRIES];
+} __packed;
+
+struct ddr_stats_data {
+	struct device *dev;
+	void __iomem *base;
+	struct qmp *qmp;
+};
+
 static void qcom_print_stats(struct seq_file *s, const struct sleep_stats *stat)
 {
 	u64 accumulated = stat->accumulated;
@@ -118,6 +151,108 @@ static int qcom_soc_sleep_stats_show(struct seq_file *s, void *unused)
 	return 0;
 }
 
+#define DDR_NAME_TYPE		GENMASK(15, 8)
+ #define DDR_NAME_TYPE_LPM	0
+ #define DDR_NAME_TYPE_FREQ	1
+
+#define DDR_NAME_LPM_NAME	GENMASK(7, 0)
+
+#define DDR_NAME_FREQ_MHZ	GENMASK(31, 16)
+#define DDR_NAME_FREQ_CP_IDX	GENMASK(4, 0)
+static void qcom_ddr_stats_print(struct seq_file *s, struct ddr_stats_entry *entry)
+{
+	u32 cp_idx, name;
+	u8 type;
+
+	type = FIELD_GET(DDR_NAME_TYPE, entry->name);
+
+	switch (type) {
+	case DDR_NAME_TYPE_LPM:
+		name = FIELD_GET(DDR_NAME_LPM_NAME, entry->name);
+
+		seq_printf(s, "LPM  | Type 0x%2x\tcount: %u\ttime: %llums\n",
+			   name, entry->count, entry->dur);
+		break;
+	case DDR_NAME_TYPE_FREQ:
+		cp_idx = FIELD_GET(DDR_NAME_FREQ_CP_IDX, entry->name);
+		name = FIELD_GET(DDR_NAME_FREQ_MHZ, entry->name);
+
+		/* Neither 0Mhz nor 0 votes is very interesting */
+		if (!name || !entry->count)
+			return;
+
+		seq_printf(s, "Freq | %dMHz (idx %u)\tcount: %u\ttime: %llums\n",
+			   name, cp_idx, entry->count, entry->dur);
+		break;
+	default:
+		seq_printf(s, "Unknown data chunk (type = 0x%x count = 0x%x dur = 0x%llx)\n",
+			   type, entry->count, entry->dur);
+	}
+}
+
+static int qcom_ddr_stats_show(struct seq_file *s, void *unused)
+{
+	struct ddr_stats_data *ddrd = s->private;
+	struct ddr_stats ddr;
+	struct ddr_stats_entry *entry = ddr.entry;
+	u32 entry_count, stats_size;
+	u32 votes[DDR_VOTE_DRV_MAX];
+	int i, ret;
+
+	/* Request a stats sync, it may take some time to update though.. */
+	ret = qmp_send(ddrd->qmp, "{class: ddr, action: freqsync}");
+	if (ret) {
+		dev_err(ddrd->dev, "failed to send QMP message\n");
+		return ret;
+	}
+
+	entry_count = readl(ddrd->base + offsetof(struct ddr_stats, entry_count));
+	if (entry_count > DDR_MAX_NUM_ENTRIES)
+		return -EINVAL;
+
+	/* We're not guaranteed to have DDR_MAX_NUM_ENTRIES */
+	stats_size = sizeof(ddr);
+	stats_size -= DDR_MAX_NUM_ENTRIES * sizeof(*entry);
+	stats_size += entry_count * sizeof(*entry);
+
+	/* Copy and process the stats */
+	memcpy_fromio(&ddr, ddrd->base, stats_size);
+
+	for (i = 0; i < ddr.entry_count; i++) {
+		/* Convert the period to ms */
+		entry[i].dur = mult_frac(MSEC_PER_SEC, entry[i].dur, ARCH_TIMER_FREQ);
+	}
+
+	for (i = 0; i < ddr.entry_count; i++)
+		qcom_ddr_stats_print(s, &entry[i]);
+
+	/* Ask AOSS to dump DDR votes */
+	ret = qmp_send(ddrd->qmp, "{class: ddr, res: drvs_ddr_votes}");
+	if (ret) {
+		dev_err(ddrd->dev, "failed to send QMP message\n");
+		return ret;
+	}
+
+	/* Subsystem votes */
+	memcpy_fromio(votes, ddrd->base + stats_size, sizeof(u32) * DDR_VOTE_DRV_MAX);
+
+	for (i = 0; i < DDR_VOTE_DRV_MAX; i++) {
+		u32 ab, ib;
+
+		if (votes[i] == DDR_VOTE_DRV_ABSENT || votes[i] == DDR_VOTE_DRV_INVALID)
+			ab = ib = votes[i];
+		else {
+			ab = FIELD_GET(DDR_VOTE_X, votes[i]);
+			ib = FIELD_GET(DDR_VOTE_Y, votes[i]);
+		}
+
+		seq_printf(s, "Vote | AB = %5u\tIB = %5u\n", ab, ib);
+	}
+
+	return 0;
+}
+
+DEFINE_SHOW_ATTRIBUTE(qcom_ddr_stats);
 DEFINE_SHOW_ATTRIBUTE(qcom_soc_sleep_stats);
 DEFINE_SHOW_ATTRIBUTE(qcom_subsystem_sleep_stats);
 
@@ -180,13 +315,56 @@ static void qcom_create_subsystem_stat_files(struct dentry *root,
 				    &qcom_subsystem_sleep_stats_fops);
 }
 
+static int qcom_create_ddr_stats_files(struct device *dev,
+				       struct dentry *root,
+				       void __iomem *reg,
+				       const struct stats_config *config)
+{
+	struct ddr_stats_data *ddrd;
+	u32 key, stats_offset;
+	struct dentry *dent;
+
+	/* Nothing to do */
+	if (!config->ddr_stats)
+		return 0;
+
+	ddrd = devm_kzalloc(dev, sizeof(*ddrd), GFP_KERNEL);
+	if (!ddrd)
+		return dev_err_probe(dev, -ENOMEM, "Couldn't allocate DDR stats data\n");
+
+	ddrd->dev = dev;
+
+	/* Get the offset of DDR stats */
+	stats_offset = readl(reg + DDR_DYNAMIC_OFFSET) & DDR_OFFSET_MASK;
+	ddrd->base = reg + stats_offset;
+
+	/* Check if DDR stats are present */
+	key = readl(ddrd->base);
+	if (key != DDR_MAGIC_KEY1)
+		return 0;
+
+	dent = debugfs_create_file("ddr_sleep_stats", 0400, root, ddrd, &qcom_ddr_stats_fops);
+	if (IS_ERR(dent))
+		return PTR_ERR(dent);
+
+	/* QMP is only necessary for DDR votes */
+	ddrd->qmp = qmp_get(dev);
+	if (IS_ERR(ddrd->qmp)) {
+		dev_err(dev, "Couldn't get QMP mailbox: %ld. DDR votes won't be available.\n",
+			PTR_ERR(ddrd->qmp));
+		debugfs_remove(dent);
+	}
+
+	return 0;
+}
+
 static int qcom_stats_probe(struct platform_device *pdev)
 {
 	void __iomem *reg;
 	struct dentry *root;
 	const struct stats_config *config;
 	struct stats_data *d;
-	int i;
+	int i, ret;
 
 	config = device_get_match_data(&pdev->dev);
 	if (!config)
@@ -208,6 +386,11 @@ static int qcom_stats_probe(struct platform_device *pdev)
 
 	qcom_create_subsystem_stat_files(root, config);
 	qcom_create_soc_sleep_stat_files(root, reg, d, config);
+	ret = qcom_create_ddr_stats_files(&pdev->dev, root, reg, config);
+	if (ret) {
+		debugfs_remove_recursive(root);
+		return ret;
+	};
 
 	platform_set_drvdata(pdev, root);
 
@@ -254,6 +437,7 @@ static const struct stats_config rpmh_data = {
 	.appended_stats_avail = false,
 	.dynamic_offset = false,
 	.subsystem_stats_in_smem = true,
+	.ddr_stats = true,
 };
 
 static const struct of_device_id qcom_stats_table[] = {

-- 
2.43.0

