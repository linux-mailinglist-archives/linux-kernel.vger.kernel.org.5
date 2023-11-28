Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43EB27FC1B1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Nov 2023 19:15:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345931AbjK1PA4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Nov 2023 10:00:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346583AbjK1PAu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Nov 2023 10:00:50 -0500
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AACB1B5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:00:55 -0800 (PST)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-a06e59384b6so713506566b.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Nov 2023 07:00:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701183654; x=1701788454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wtzvOORU1m23t60LTV9e86QfYgBtpGNq+GKxLg73wN0=;
        b=ejtjY8529E3nFL4LIhsfe8bBS6KpGkjhRp8zSx4DuzMsKut5DGM++ZukDJ/y1/RGrO
         /0NwESXxPWlgIYA6ZpbGhFLyF4VWZopVQSGB30VuMhZWDoIbbjCC0rSmRgFSXgDmegWk
         KlncRi1HwHfOBEp9RzUx9FYXws9laNZSXu7ELI238UgI3dhlEzScMkuUmYExP1Jm0BrR
         yiY+tWgnmtQlTtG2dSZytilF//Mjkm7+jDLXdVhWNx2FcloaZPaPnR7Mc+zcSdwlsb3E
         pGGD851aemp4TCnzLIo7y4V6eGfA7jO53I1dsBmsAvfrPv2q7tdwvHgeg/QFc6Olu0j/
         lACg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701183654; x=1701788454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wtzvOORU1m23t60LTV9e86QfYgBtpGNq+GKxLg73wN0=;
        b=iH8fW6IBklNjQcEt/nEPeeAxP54p7AkdHl5LJ2VaHpcHpVRUdQu0rg1QKoY4O8EVm5
         92iOY9UBSuS8gj+V6vosd9qkIKMISQxvpy7of+qwmKsSMcMcArbbZLe9Y8qk7hic95CY
         iDGPHJfladmum9V4qefZxcQxsZtKMzWehKDXKoig8X4aWvtfC7dzssGZZJ0DWuNIgDDx
         IGVJkpR0aG67Z0BcgaBT97TIGGJt5AAxifXj9RxoPBEjul8hQXyQlKAsw3zbAFuZy3Za
         mO+ID7TFtwqcPC0xok3MGKYZbsIscpHphtoWpuDK3089D0P565WbRdzTpNahYdYUWMNi
         AEkg==
X-Gm-Message-State: AOJu0YxCpErpvRtCWBaiLR/QsXgqXrdB3s6k8382SR5wU90OgFgJPO7U
        hQKW4MFNGyz/rrHNcclGFFLYRQ==
X-Google-Smtp-Source: AGHT+IFRWlG86Ino62rK496hPwfuaTK2b6cocVn/StHlsrRflRZQOwgPf8SPpdGuQOvrfjs/iOsLkA==
X-Received: by 2002:a17:907:1687:b0:a12:9aa8:c560 with SMTP id cx7-20020a170907168700b00a129aa8c560mr1808321ejd.59.1701183654099;
        Tue, 28 Nov 2023 07:00:54 -0800 (PST)
Received: from krzk-bin.. ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id xo25-20020a170907bb9900b00a0b6541b592sm4433071ejc.88.2023.11.28.07.00.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 07:00:53 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH] soundwire: qcom: allow multi-link on newer devices
Date:   Tue, 28 Nov 2023 16:00:49 +0100
Message-Id: <20231128150049.412236-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
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

Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
over two Soundwire controllers, thus they need a multi-link Soundwire
stream runtime.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

This is an entirely different approach than my previous try here:
https://lore.kernel.org/all/20231025144601.268645-1-krzysztof.kozlowski@linaro.org/
---
 drivers/soundwire/qcom.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index 412b8e663a0a..57943724f0eb 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -920,6 +920,18 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
 	return 0;
 }
 
+static int qcom_swrm_read_prop(struct sdw_bus *bus)
+{
+	struct qcom_swrm_ctrl *ctrl = to_qcom_sdw(bus);
+
+	if (ctrl->version >= SWRM_VERSION_2_0_0) {
+		bus->multi_link = true;
+		bus->hw_sync_min_links = 3;
+	}
+
+	return 0;
+}
+
 static enum sdw_command_response qcom_swrm_xfer_msg(struct sdw_bus *bus,
 						    struct sdw_msg *msg)
 {
@@ -1078,6 +1090,7 @@ static const struct sdw_master_port_ops qcom_swrm_port_ops = {
 };
 
 static const struct sdw_master_ops qcom_swrm_ops = {
+	.read_prop = qcom_swrm_read_prop,
 	.xfer_msg = qcom_swrm_xfer_msg,
 	.pre_bank_switch = qcom_swrm_pre_bank_switch,
 	.post_bank_switch = qcom_swrm_post_bank_switch,
@@ -1196,6 +1209,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 
 	mutex_lock(&ctrl->port_lock);
 	list_for_each_entry(m_rt, &stream->master_list, stream_node) {
+		/*
+		 * For streams with multiple masters:
+		 * Allocate ports only for devices connected to this master.
+		 * Such devices will have ports allocated by their own master
+		 * and its qcom_swrm_stream_alloc_ports() call.
+		 */
+		if (ctrl->bus.id != m_rt->bus->id)
+			continue;
+
 		if (m_rt->direction == SDW_DATA_DIR_RX) {
 			maxport = ctrl->num_dout_ports;
 			port_mask = &ctrl->dout_port_mask;
-- 
2.34.1

