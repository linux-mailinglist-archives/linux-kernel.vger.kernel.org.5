Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D59F7CE5A8
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344735AbjJRR6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjJRR6F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:58:05 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73A4FD51;
        Wed, 18 Oct 2023 10:58:00 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 39IH92q6014424;
        Wed, 18 Oct 2023 12:57:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=B7VvDX2saUSmkbGwMjzHI+I1JoiQDqH/DET9FBAsyGQ=; b=
        fIkTbplQE5X3htpzONsCERfP/bUfH58Y4W0EyIP2BAXHCGhOOdgBL1AU69Iohh1/
        I4cCepuNGpYn3JyeN7cL7qtY06cxpUWZ/7pvyny46F7rEFIaHUrOvWzLIzyO7xVf
        LDWfofSPRp3GML5LUgLAn4zyZrp+I4RN6kw2vcmJw2C/XTuqhPEltnYlrXjBwWFL
        c9KqkcRkCiyETc13m89ejlJS0tlpe+dNGqG/fKZueSKFA2uONnRw3EO/yd5HWStU
        s2g1AfF7d33SrhOjxGbHlI8/d+VI+ib/3sif0PM11WDL6OUH1qKtxEGS6DApoN99
        ajtVVyW8vwHMKRyH6ei6MA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3tqqdh50th-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 18 Oct 2023 12:57:47 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.37; Wed, 18 Oct
 2023 18:57:46 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.37 via Frontend
 Transport; Wed, 18 Oct 2023 18:57:46 +0100
Received: from aus-sw-rshr002.ad.cirrus.com (aus-sw-rshr002.ad.cirrus.com [141.131.145.53])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id AF3CB458;
        Wed, 18 Oct 2023 17:57:44 +0000 (UTC)
From:   James Ogletree <james.ogletree@opensource.cirrus.com>
CC:     James Ogletree <james.ogletree@cirrus.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Fred Treven <fred.treven@cirrus.com>,
        Ben Bright <ben.bright@cirrus.com>,
        <linux-input@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v4 2/4] Input: cs40l50 - Add cirrus haptics base support
Date:   Wed, 18 Oct 2023 17:57:23 +0000
Message-ID: <20231018175726.3879955-3-james.ogletree@opensource.cirrus.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
References: <20231018175726.3879955-1-james.ogletree@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: g3yf0VngreZ_qEeF9lKrm7e6n_-4MuMi
X-Proofpoint-ORIG-GUID: g3yf0VngreZ_qEeF9lKrm7e6n_-4MuMi
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Ogletree <james.ogletree@cirrus.com>

Introduce the cirrus haptics library which factors out
common haptics operations used by Cirrus Logic Input
drivers.

Signed-off-by: James Ogletree <james.ogletree@cirrus.com>
---
 MAINTAINERS                          |   2 +
 drivers/input/misc/cirrus_haptics.c  | 586 +++++++++++++++++++++++++++
 include/linux/input/cirrus_haptics.h | 121 ++++++
 3 files changed, 709 insertions(+)
 create mode 100644 drivers/input/misc/cirrus_haptics.c
 create mode 100644 include/linux/input/cirrus_haptics.h

diff --git a/MAINTAINERS b/MAINTAINERS
index 28f0ca9324b3..57daf77bf550 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4970,6 +4970,8 @@ M:	Ben Bright <ben.bright@cirrus.com>
 L:	patches@opensource.cirrus.com
 S:	Supported
 F:	Documentation/devicetree/bindings/input/cirrus,cs40l50.yaml
+F:	drivers/input/misc/cirrus*
+F:	include/linux/input/cirrus*
 
 CIRRUS LOGIC DSP FIRMWARE DRIVER
 M:	Simon Trimmer <simont@opensource.cirrus.com>
diff --git a/drivers/input/misc/cirrus_haptics.c b/drivers/input/misc/cirrus_haptics.c
new file mode 100644
index 000000000000..7e539cd45167
--- /dev/null
+++ b/drivers/input/misc/cirrus_haptics.c
@@ -0,0 +1,586 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Helper functions for dealing with wavetable
+ * formats and DSP interfaces used by Cirrus
+ * haptic drivers.
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ */
+
+#include <linux/firmware/cirrus/cs_dsp.h>
+#include <linux/input.h>
+#include <linux/input/cirrus_haptics.h>
+#include <linux/pm_runtime.h>
+
+static int cs_hap_pseq_init(struct cs_hap *haptics)
+{
+	struct cs_hap_pseq_op *op;
+	int error, i, num_words;
+	u8 operation;
+	u32 *words;
+
+	if (!haptics->dsp.pseq_size || !haptics->dsp.pseq_reg)
+		return 0;
+
+	INIT_LIST_HEAD(&haptics->pseq_head);
+
+	words = kcalloc(haptics->dsp.pseq_size, sizeof(u32), GFP_KERNEL);
+	if (!words)
+		return -ENOMEM;
+
+	error = regmap_bulk_read(haptics->regmap, haptics->dsp.pseq_reg,
+				 words, haptics->dsp.pseq_size);
+	if (error)
+		goto err_free;
+
+	for (i = 0; i < haptics->dsp.pseq_size; i += num_words) {
+		operation = FIELD_GET(PSEQ_OP_MASK, words[i]);
+		switch (operation) {
+		case PSEQ_OP_END:
+		case PSEQ_OP_WRITE_UNLOCK:
+			num_words = PSEQ_OP_END_WORDS;
+			break;
+		case PSEQ_OP_WRITE_ADDR8:
+		case PSEQ_OP_WRITE_H16:
+		case PSEQ_OP_WRITE_L16:
+			num_words = PSEQ_OP_WRITE_X16_WORDS;
+			break;
+		case PSEQ_OP_WRITE_FULL:
+			num_words = PSEQ_OP_WRITE_FULL_WORDS;
+			break;
+		default:
+			error = -EINVAL;
+			dev_err(haptics->dev, "Unsupported op: %u\n", operation);
+			goto err_free;
+		}
+
+		op = devm_kzalloc(haptics->dev, sizeof(*op), GFP_KERNEL);
+		if (!op) {
+			error = -ENOMEM;
+			goto err_free;
+		}
+
+		op->size = num_words * sizeof(u32);
+		memcpy(op->words, &words[i], op->size);
+		op->offset = i * sizeof(u32);
+		op->operation = operation;
+		list_add(&op->list, &haptics->pseq_head);
+
+		if (operation == PSEQ_OP_END)
+			break;
+	}
+
+	if (operation != PSEQ_OP_END)
+		error = -ENOENT;
+
+err_free:
+	kfree(words);
+
+	return error;
+}
+
+static int cs_hap_pseq_find_end(struct cs_hap *haptics,
+				struct cs_hap_pseq_op **op_end)
+{
+	u8 operation = PSEQ_OP_WRITE_FULL;
+	struct cs_hap_pseq_op *op;
+
+	list_for_each_entry(op, &haptics->pseq_head, list) {
+		operation = op->operation;
+		if (operation == PSEQ_OP_END)
+			break;
+	}
+
+	if (operation != PSEQ_OP_END) {
+		dev_err(haptics->dev, "Missing PSEQ list terminator\n");
+		return -ENOENT;
+	}
+
+	*op_end = op;
+
+	return 0;
+}
+
+static struct cs_hap_pseq_op *cs_hap_pseq_find_op(struct cs_hap_pseq_op *match_op,
+						  struct list_head *pseq_head)
+{
+	struct cs_hap_pseq_op *op;
+
+	list_for_each_entry(op, pseq_head, list) {
+		if (op->operation == PSEQ_OP_END)
+			break;
+		if (op->operation != match_op->operation ||
+		    op->words[0] != match_op->words[0])
+			continue;
+		switch (op->operation) {
+		case PSEQ_OP_WRITE_FULL:
+			if (FIELD_GET(GENMASK(23, 8), op->words[1]) ==
+			    FIELD_GET(GENMASK(23, 8), match_op->words[1]))
+				return op;
+			break;
+		case PSEQ_OP_WRITE_H16:
+		case PSEQ_OP_WRITE_L16:
+			if (FIELD_GET(GENMASK(23, 16), op->words[1]) ==
+			    FIELD_GET(GENMASK(23, 16), match_op->words[1]))
+				return op;
+			break;
+		default:
+			break;
+		}
+	}
+
+	return NULL;
+}
+
+int cs_hap_pseq_write(struct cs_hap *haptics, u32 addr,
+		      u32 data, bool update, u8 op_code)
+{
+	struct cs_hap_pseq_op *op, *op_end, *op_new;
+	struct cs_dsp_chunk ch;
+	u32 pseq_bytes;
+	int error;
+
+	op_new = devm_kzalloc(haptics->dev, sizeof(*op_new), GFP_KERNEL);
+	if (!op_new)
+		return -ENOMEM;
+
+	op_new->operation = op_code;
+
+	ch = cs_dsp_chunk((void *) op_new->words,
+			  PSEQ_OP_WRITE_FULL_WORDS * sizeof(u32));
+	cs_dsp_chunk_write(&ch, 8, op_code);
+	switch (op_code) {
+	case PSEQ_OP_WRITE_FULL:
+		cs_dsp_chunk_write(&ch, 32, addr);
+		cs_dsp_chunk_write(&ch, 32, data);
+		break;
+	case PSEQ_OP_WRITE_L16:
+	case PSEQ_OP_WRITE_H16:
+		cs_dsp_chunk_write(&ch, 24, addr);
+		cs_dsp_chunk_write(&ch, 16, data);
+		break;
+	default:
+		error = -EINVAL;
+		goto op_new_free;
+	}
+
+	op_new->size = cs_dsp_chunk_bytes(&ch);
+
+	if (update) {
+		op = cs_hap_pseq_find_op(op_new, &haptics->pseq_head);
+		if (!op) {
+			error = -EINVAL;
+			goto op_new_free;
+		}
+	}
+
+	error = cs_hap_pseq_find_end(haptics, &op_end);
+	if (error)
+		goto op_new_free;
+
+	pseq_bytes = haptics->dsp.pseq_size * sizeof(u32);
+
+	if (pseq_bytes - op_end->offset < op_new->size) {
+		error = -ENOMEM;
+		goto op_new_free;
+	}
+
+	if (update) {
+		op_new->offset = op->offset;
+	} else {
+		op_new->offset = op_end->offset;
+		op_end->offset += op_new->size;
+	}
+
+	error = regmap_raw_write(haptics->regmap, haptics->dsp.pseq_reg +
+				 op_new->offset, op_new->words, op_new->size);
+	if (error)
+		goto op_new_free;
+
+	if (update) {
+		list_replace(&op->list, &op_new->list);
+	} else {
+		error = regmap_raw_write(haptics->regmap, haptics->dsp.pseq_reg +
+					 op_end->offset, op_end->words,
+					 op_end->size);
+		if (error)
+			goto op_new_free;
+
+		list_add(&op_new->list, &haptics->pseq_head);
+	}
+
+	return 0;
+
+op_new_free:
+	devm_kfree(haptics->dev, op_new);
+
+	return error;
+}
+EXPORT_SYMBOL_GPL(cs_hap_pseq_write);
+
+int cs_hap_pseq_multi_write(struct cs_hap *haptics,
+			    const struct reg_sequence *reg_seq,
+			    int num_regs, bool update, u8 op_code)
+{
+	int error, i;
+
+	for (i = 0; i < num_regs; i++) {
+		error = cs_hap_pseq_write(haptics, reg_seq[i].reg,
+					  reg_seq[i].def, update, op_code);
+		if (error)
+			return error;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cs_hap_pseq_multi_write);
+
+static struct cs_hap_effect *cs_hap_find_effect(int id,
+						struct list_head *effect_head)
+{
+	struct cs_hap_effect *effect;
+
+	list_for_each_entry(effect, effect_head, list)
+		if (effect->id == id)
+			return effect;
+
+	return NULL;
+}
+
+static int cs_hap_effect_bank_set(struct cs_hap *haptics,
+				  struct cs_hap_effect *effect,
+				  struct ff_periodic_effect add_effect)
+{
+	s16 bank = add_effect.custom_data[0] & 0xffffu;
+	unsigned int len = add_effect.custom_len;
+
+	if (bank >= WVFRM_BANK_NUM) {
+		dev_err(haptics->dev, "Invalid waveform bank: %d\n", bank);
+		return -EINVAL;
+	}
+
+	effect->bank = len > CUSTOM_DATA_SIZE ? WVFRM_BANK_OWT : bank;
+
+	return 0;
+}
+
+static int cs_hap_effect_mapping_set(struct cs_hap *haptics, u16 button,
+				     struct cs_hap_effect *effect)
+{
+	u32 gpio_num, gpio_edge;
+
+	if (button) {
+		gpio_num = FIELD_GET(BTN_NUM_MASK, button);
+		gpio_edge = FIELD_GET(BTN_EDGE_MASK, button);
+		effect->mapping = haptics->dsp.gpio_base_reg +
+				  (gpio_num * 8) - gpio_edge;
+
+		return regmap_write(haptics->regmap, effect->mapping, button);
+	}
+
+	effect->mapping = GPIO_MAPPING_INVALID;
+
+	return 0;
+}
+
+static int cs_hap_effect_index_set(struct cs_hap *haptics,
+				   struct cs_hap_effect *effect,
+				   struct ff_periodic_effect add_effect)
+{
+	struct cs_hap_effect *owt_effect;
+	u32 base_index, max_index;
+
+	base_index = haptics->banks[effect->bank].base_index;
+	max_index = haptics->banks[effect->bank].max_index;
+
+	effect->index = base_index;
+
+	switch (effect->bank) {
+	case WVFRM_BANK_OWT:
+		list_for_each_entry(owt_effect, &haptics->effect_head, list)
+			if (owt_effect->bank == WVFRM_BANK_OWT)
+				effect->index++;
+		break;
+	case WVFRM_BANK_ROM:
+	case WVFRM_BANK_RAM:
+		effect->index += add_effect.custom_data[1] & 0xffffu;
+		break;
+	default:
+		dev_err(haptics->dev, "Bank not supported: %d\n", effect->bank);
+		return -EINVAL;
+	}
+
+	if (effect->index > max_index || effect->index < base_index) {
+		dev_err(haptics->dev, "Index out of bounds: %u\n", effect->index);
+		return -ENOSPC;
+	}
+
+	return 0;
+}
+
+static int cs_hap_upload_pwle(struct cs_hap *haptics,
+			      struct cs_hap_effect *effect,
+			      struct ff_periodic_effect add_effect)
+{
+	u32 len, wt_offset, wt_size_words;
+	struct cs_hap_pwle_header header;
+	u8 *out_data;
+	int error;
+
+	error = regmap_read(haptics->regmap, haptics->dsp.owt_offset_reg,
+			    &wt_offset);
+	if (error)
+		return error;
+
+	error = regmap_read(haptics->regmap, haptics->dsp.owt_size_reg,
+			    &wt_size_words);
+	if (error)
+		return error;
+
+	len = 2 * add_effect.custom_len;
+
+	if ((wt_size_words * sizeof(u32)) < OWT_HEADER_SIZE + len)
+		return -ENOSPC;
+
+	out_data = kzalloc(OWT_HEADER_SIZE + len, GFP_KERNEL);
+	if (!out_data)
+		return -ENOMEM;
+
+	header.type = add_effect.custom_data[0] == PCM_ID ? OWT_TYPE_PCM :
+							    OWT_TYPE_PWLE;
+	header.offset = OWT_HEADER_SIZE / sizeof(u32);
+	header.data_words = len / sizeof(u32);
+
+	memcpy(out_data, &header, sizeof(header));
+	memcpy(out_data + OWT_HEADER_SIZE, add_effect.custom_data, len);
+
+	error = regmap_bulk_write(haptics->regmap, haptics->dsp.owt_base_reg +
+				  (wt_offset * sizeof(u32)), out_data,
+				  OWT_HEADER_SIZE + len);
+	if (error)
+		goto err_free;
+
+	error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
+			     haptics->dsp.push_owt_cmd);
+
+err_free:
+	kfree(out_data);
+
+	return error;
+}
+
+static void cs_hap_add_worker(struct work_struct *work)
+{
+	struct cs_hap *haptics = container_of(work, struct cs_hap,
+					      add_work);
+	struct ff_effect add_effect = haptics->add_effect;
+	bool is_new = false;
+	struct cs_hap_effect *effect;
+	int error;
+
+	if (haptics->runtime_pm) {
+		error = pm_runtime_resume_and_get(haptics->dev);
+		if (error < 0) {
+			haptics->add_error = error;
+			return;
+		}
+	}
+
+	mutex_lock(&haptics->lock);
+
+	effect = cs_hap_find_effect(add_effect.id, &haptics->effect_head);
+	if (!effect) {
+		effect = kzalloc(sizeof(*effect), GFP_KERNEL);
+		if (!effect) {
+			error = -ENOMEM;
+			goto err_mutex;
+		}
+		effect->id = add_effect.id;
+		is_new = true;
+	}
+
+	error = cs_hap_effect_bank_set(haptics, effect, add_effect.u.periodic);
+	if (error)
+		goto err_free;
+
+	error = cs_hap_effect_index_set(haptics, effect, add_effect.u.periodic);
+	if (error)
+		goto err_free;
+
+	error = cs_hap_effect_mapping_set(haptics, add_effect.trigger.button,
+					  effect);
+	if (error)
+		goto err_free;
+
+	if (effect->bank == WVFRM_BANK_OWT)
+		error = cs_hap_upload_pwle(haptics, effect,
+					   add_effect.u.periodic);
+
+err_free:
+	if (is_new) {
+		if (error)
+			kfree(effect);
+		else
+			list_add(&effect->list, &haptics->effect_head);
+	}
+
+err_mutex:
+	mutex_unlock(&haptics->lock);
+
+	if (haptics->runtime_pm) {
+		pm_runtime_mark_last_busy(haptics->dev);
+		pm_runtime_put_autosuspend(haptics->dev);
+	}
+
+	haptics->add_error = error;
+}
+
+static void cs_hap_erase_worker(struct work_struct *work)
+{
+	struct cs_hap *haptics = container_of(work, struct cs_hap,
+					      erase_work);
+	int error = 0;
+	struct cs_hap_effect *owt_effect, *erase_effect;
+
+	if (haptics->runtime_pm) {
+		error = pm_runtime_resume_and_get(haptics->dev);
+		if (error < 0) {
+			haptics->erase_error = error;
+			return;
+		}
+	}
+
+	mutex_lock(&haptics->lock);
+
+	erase_effect = cs_hap_find_effect(haptics->erase_effect->id,
+					  &haptics->effect_head);
+	if (!erase_effect) {
+		dev_err(haptics->dev, "Effect to erase does not exist\n");
+		error = -EINVAL;
+		goto err_mutex;
+	}
+
+	if (erase_effect->mapping != GPIO_MAPPING_INVALID) {
+		error = regmap_write(haptics->regmap, erase_effect->mapping,
+				     GPIO_DISABLE);
+		if (error)
+			goto err_mutex;
+	}
+
+	if (erase_effect->bank == WVFRM_BANK_OWT) {
+		error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
+				     haptics->dsp.delete_owt_cmd |
+				     erase_effect->index);
+		if (error)
+			goto err_mutex;
+
+		list_for_each_entry(owt_effect, &haptics->effect_head, list)
+			if (owt_effect->bank == WVFRM_BANK_OWT &&
+			    owt_effect->index > erase_effect->index)
+				owt_effect->index--;
+	}
+
+	list_del(&erase_effect->list);
+	kfree(erase_effect);
+
+err_mutex:
+	mutex_unlock(&haptics->lock);
+
+	if (haptics->runtime_pm) {
+		pm_runtime_mark_last_busy(haptics->dev);
+		pm_runtime_put_autosuspend(haptics->dev);
+	}
+
+	haptics->erase_error = error;
+}
+
+static void cs_hap_vibe_start_worker(struct work_struct *work)
+{
+	struct cs_hap *haptics = container_of(work, struct cs_hap,
+					      vibe_start_work);
+	struct cs_hap_effect *effect;
+	int error;
+
+	if (haptics->runtime_pm) {
+		error = pm_runtime_resume_and_get(haptics->dev);
+		if (error < 0) {
+			haptics->start_error = error;
+			return;
+		}
+	}
+
+	mutex_lock(&haptics->lock);
+
+	effect = cs_hap_find_effect(haptics->start_effect->id,
+				    &haptics->effect_head);
+	if (effect) {
+		error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
+				     effect->index);
+	} else {
+		dev_err(haptics->dev, "Effect to start does not exist\n");
+		error = -EINVAL;
+	}
+
+	mutex_unlock(&haptics->lock);
+
+	if (haptics->runtime_pm) {
+		pm_runtime_mark_last_busy(haptics->dev);
+		pm_runtime_put_autosuspend(haptics->dev);
+	}
+
+	haptics->start_error = error;
+}
+
+static void cs_hap_vibe_stop_worker(struct work_struct *work)
+{
+	struct cs_hap *haptics = container_of(work, struct cs_hap,
+					      vibe_stop_work);
+	int error;
+
+	if (haptics->runtime_pm) {
+		error = pm_runtime_resume_and_get(haptics->dev);
+		if (error < 0) {
+			haptics->stop_error = error;
+			return;
+		}
+	}
+
+	mutex_lock(&haptics->lock);
+	error = regmap_write(haptics->regmap, haptics->dsp.mailbox_reg,
+			     haptics->dsp.stop_cmd);
+	mutex_unlock(&haptics->lock);
+
+	if (haptics->runtime_pm) {
+		pm_runtime_mark_last_busy(haptics->dev);
+		pm_runtime_put_autosuspend(haptics->dev);
+	}
+
+	haptics->stop_error = error;
+}
+
+int cs_hap_init(struct cs_hap *haptics)
+{
+	haptics->vibe_wq = alloc_ordered_workqueue("vibe_wq", 0);
+	if (!haptics->vibe_wq)
+		return -ENOMEM;
+
+	mutex_init(&haptics->lock);
+
+	INIT_WORK(&haptics->vibe_start_work, cs_hap_vibe_start_worker);
+	INIT_WORK(&haptics->vibe_stop_work, cs_hap_vibe_stop_worker);
+	INIT_WORK(&haptics->erase_work, cs_hap_erase_worker);
+	INIT_WORK(&haptics->add_work, cs_hap_add_worker);
+
+	return cs_hap_pseq_init(haptics);
+}
+EXPORT_SYMBOL_GPL(cs_hap_init);
+
+void cs_hap_remove(struct cs_hap *haptics)
+{
+	flush_workqueue(haptics->vibe_wq);
+	destroy_workqueue(haptics->vibe_wq);
+}
+EXPORT_SYMBOL_GPL(cs_hap_remove);
+
+MODULE_DESCRIPTION("Cirrus Logic Haptics Support");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/input/cirrus_haptics.h b/include/linux/input/cirrus_haptics.h
new file mode 100644
index 000000000000..42f6afed7944
--- /dev/null
+++ b/include/linux/input/cirrus_haptics.h
@@ -0,0 +1,121 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Helper functions for dealing with wavetable
+ * formats and DSP interfaces used by Cirrus
+ * haptic drivers.
+ *
+ * Copyright 2023 Cirrus Logic, Inc.
+ */
+
+#ifndef __CIRRUS_HAPTICS_H
+#define __CIRRUS_HAPTICS_H
+
+#include <linux/property.h>
+#include <linux/regmap.h>
+
+/* Power-on write sequencer */
+#define PSEQ_OP_MASK			GENMASK(23, 16)
+#define PSEQ_OP_SHIFT			16
+#define PSEQ_OP_WRITE_FULL_WORDS	3
+#define PSEQ_OP_WRITE_X16_WORDS		2
+#define PSEQ_OP_END_WORDS		1
+#define PSEQ_OP_WRITE_FULL		0x00
+#define PSEQ_OP_WRITE_ADDR8		0x02
+#define PSEQ_OP_WRITE_L16		0x04
+#define PSEQ_OP_WRITE_H16		0x05
+#define PSEQ_OP_WRITE_UNLOCK		0xFD
+#define PSEQ_OP_END			0xFF
+
+/* Open wavetable */
+#define OWT_HEADER_SIZE		12
+#define OWT_TYPE_PCM		8
+#define OWT_TYPE_PWLE		12
+#define PCM_ID			0x0
+#define CUSTOM_DATA_SIZE	2
+
+/* GPIO */
+#define BTN_NUM_MASK		GENMASK(14, 12)
+#define BTN_EDGE_MASK		BIT(15)
+#define GPIO_MAPPING_INVALID	0
+#define GPIO_DISABLE		0x1FF
+
+enum cs_hap_bank_type {
+	WVFRM_BANK_RAM,
+	WVFRM_BANK_ROM,
+	WVFRM_BANK_OWT,
+	WVFRM_BANK_NUM,
+};
+
+struct cs_hap_pseq_op {
+	struct list_head list;
+	u32 words[3];
+	u16 offset;
+	u8 operation;
+	u8 size;
+};
+
+struct cs_hap_effect {
+	enum cs_hap_bank_type bank;
+	struct list_head list;
+	u32 mapping;
+	u32 index;
+	int id;
+};
+
+struct cs_hap_pwle_header {
+	u32 type;
+	u32 data_words;
+	u32 offset;
+} __packed;
+
+struct cs_hap_bank {
+	enum cs_hap_bank_type bank;
+	u32 base_index;
+	u32 max_index;
+};
+
+struct cs_hap_dsp {
+	u32 gpio_base_reg;
+	u32 owt_offset_reg;
+	u32 owt_size_reg;
+	u32 owt_base_reg;
+	u32 mailbox_reg;
+	u32 pseq_reg;
+	u32 push_owt_cmd;
+	u32 delete_owt_cmd;
+	u32 stop_cmd;
+	u32 pseq_size;
+};
+
+struct cs_hap {
+	struct regmap *regmap;
+	struct mutex lock;
+	struct device *dev;
+	struct list_head pseq_head;
+	struct cs_hap_bank *banks;
+	struct cs_hap_dsp dsp;
+	struct workqueue_struct *vibe_wq;
+	struct work_struct vibe_start_work;
+	struct work_struct vibe_stop_work;
+	struct work_struct erase_work;
+	struct work_struct add_work;
+	struct ff_effect *start_effect;
+	struct ff_effect *erase_effect;
+	struct ff_effect add_effect;
+	struct list_head effect_head;
+	int erase_error;
+	int start_error;
+	int stop_error;
+	int add_error;
+	bool runtime_pm;
+};
+
+int cs_hap_pseq_write(struct cs_hap *haptics, u32 addr,
+		      u32 data, bool update, u8 op_code);
+int cs_hap_pseq_multi_write(struct cs_hap *haptics,
+			    const struct reg_sequence *reg_seq,
+			    int num_regs, bool update, u8 op_code);
+int cs_hap_init(struct cs_hap *haptics);
+void cs_hap_remove(struct cs_hap *haptics);
+
+#endif
-- 
2.25.1

