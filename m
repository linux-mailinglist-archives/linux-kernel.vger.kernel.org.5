Return-Path: <linux-kernel+bounces-133179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 73E7289A003
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 16:42:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A5DC01C220AE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 14:42:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 851D316F82C;
	Fri,  5 Apr 2024 14:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="H7brh+Ym"
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 080A016F820
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 14:41:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712328110; cv=none; b=ejDN/FDPa0vw4OcrQkJXOSiVSiQvxmNrLBxa2Dv4O5fbmwMQ5qZDVgDq4AnrefaEPEEhwYPMH9BiD3Mog4jwzDP+9DNnY0gXemyAE4V8j2Kjuh4AqtDVAnLwQE0/MZ68xjckgL81osx+p/V9SpHvw9aRGLnBBHPmLJU82Oj8LPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712328110; c=relaxed/simple;
	bh=sxY2AEeSba+Q/Kxf5OSL1C7dhwkaGiayEInG3JEg4Go=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rQaB1fZw4GPsoRFsO32U1J6UPN9g50peHCNSE8bPxhxfphmil5U2z7XqaLQofKvVUZoepQ/mBA+Xc3ZGzpF4EgQEWzitc2g+1naO6DA+Tv5ApVzgax53rkXrPG4jyV3bRz3fk1p17nmuVH7w57dBLA+gBIuJnCVTqkTmmMNmA/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=H7brh+Ym; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-563cb3ba9daso2402737a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 07:41:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712328107; x=1712932907; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JTqiLc0V7BtkLzywEdmRvMeMh3GhRnDflsLTNgiO3NQ=;
        b=H7brh+YmdpS8KDDdr3d9x/yRYHOcUO9ohLylaqjYwaI5e1R4SXXPqq4G5dF1zjkpUc
         h2RAPpfx8PJqhNPRLt8zLWB09Y/cSU8/MZma8xMXaMgsmejmt47FDkH0VJ8feHJ2qRTI
         emtQKIOYVpqJ8k0ACtZN74YqZglFN2MnvxTsiWr48bmX7kH14zT4W3atquMWHP/P6Kns
         PhhKTPaLsqRI0e82Ogp4HoOrC1/BB0xFalEp7IpTECU6yspdJKYhU0RIse943kYoOM14
         zpr/GoABjK5TqCZ7qmybH/4xmeQo8F3bQiz+I/4u/Yla3E9+TXKs7wRmai/v/KHDq9qS
         jCNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712328107; x=1712932907;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JTqiLc0V7BtkLzywEdmRvMeMh3GhRnDflsLTNgiO3NQ=;
        b=FGcWybs9Mam8OEfZg9t8zR2Ja+Llxi0oB0PINB33xfLOHOybq3wP6yL2kG5QV8VFwS
         Hc7VYoOmKvUUAJbfZ3S9VX4jV9YHujiXdwdUCKkAlQIz0loQzRFBf2fVa3WQ+KG33u34
         nyTFEtAqTrwCNajRnwp9BWZynVjCHu36lvH0fVSKxHGGwfRlUDYo0c9ZV7YJA0c9OUwD
         HgrwF/JCYerbADfC8W0KqNyMkDr4dJOy/OgXcou+vb/NjGca9lXnjS7ArznFtZGLcLyh
         Od1YkK4prF+owKEF+UTbPjL/XzqjmPa1BFWuAfRoDipmVCrZzH/j13acRag8w7EEQb+M
         3EUQ==
X-Forwarded-Encrypted: i=1; AJvYcCXLqgCT18k1F6ZO818J/7bBjSHSraHgF5EPCFK0NiegsR8vvsQiSDgfY1mj1lUr3U8Liz8xjwsDvgm9RImqpdt0SenIXQYldK/0YBZU
X-Gm-Message-State: AOJu0Ywvqa1GhVyuoXoBp1W/zXrJFtYBEumrgRjRAUzDJ9ZsQ3kME31S
	YU0Bl0v3juBNdt8vi6bHIyeF8OgyJT7DYWIBR9eDkwgQ1iQ0ybnqGJMesy9qTtE=
X-Google-Smtp-Source: AGHT+IHh+ZxoCzU1FGg+Ay1sdVh8yffh8/bUZTifdB3YwV0ck6OUItK6hnnakWAv1mKM1jDatQrBDA==
X-Received: by 2002:a17:906:5ad8:b0:a4e:a204:e699 with SMTP id x24-20020a1709065ad800b00a4ea204e699mr1326916ejs.17.1712328107384;
        Fri, 05 Apr 2024 07:41:47 -0700 (PDT)
Received: from krzk-bin.. ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g15-20020a170906198f00b00a4e2bf2f743sm899183ejd.184.2024.04.05.07.41.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Apr 2024 07:41:46 -0700 (PDT)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Vinod Koul <vkoul@kernel.org>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
	Sanyog Kale <sanyog.r.kale@intel.com>,
	linux-arm-msm@vger.kernel.org,
	alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Mark Brown <broonie@kernel.org>
Subject: [PATCH v2] soundwire: qcom: allow multi-link on newer devices
Date: Fri,  5 Apr 2024 16:41:41 +0200
Message-Id: <20240405144141.47217-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Newer Qualcomm SoCs like X1E80100 might come with four speakers spread
over two Soundwire controllers, thus they need a multi-link Soundwire
stream runtime.

Cc: Mark Brown <broonie@kernel.org>
Cc: alsa-devel@alsa-project.org
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

---

Changes in v2:
1. Only rebase (slightly different context)
---
 drivers/soundwire/qcom.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/soundwire/qcom.c b/drivers/soundwire/qcom.c
index fb70afe64fcc..ce5cf3ecceb5 100644
--- a/drivers/soundwire/qcom.c
+++ b/drivers/soundwire/qcom.c
@@ -905,6 +905,18 @@ static int qcom_swrm_init(struct qcom_swrm_ctrl *ctrl)
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
@@ -1056,6 +1068,7 @@ static const struct sdw_master_port_ops qcom_swrm_port_ops = {
 };
 
 static const struct sdw_master_ops qcom_swrm_ops = {
+	.read_prop = qcom_swrm_read_prop,
 	.xfer_msg = qcom_swrm_xfer_msg,
 	.pre_bank_switch = qcom_swrm_pre_bank_switch,
 };
@@ -1173,6 +1186,15 @@ static int qcom_swrm_stream_alloc_ports(struct qcom_swrm_ctrl *ctrl,
 
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


