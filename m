Return-Path: <linux-kernel+bounces-163576-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 068AE8B6D4A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 282381C2264B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25D50128382;
	Tue, 30 Apr 2024 08:49:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bannaZ70"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E84127B45
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714466982; cv=none; b=V1aSJu5t9+B6W3lOYlhUngETzt29SXRopVYNVJkJtVhzlrotjGLLqkCNAx2kMlEF2u8m5uGhm7K54FVaU3Gz9WvTaxEWhYMJluuvCsXJGKpT2dW4WsROHcjGSIHIIFNUyWJM97tujtIW7tUQs9ECwr1fB+ovUi0J4XQJiDq7nZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714466982; c=relaxed/simple;
	bh=wG99v6X7OpIvltklYuVbpJOcvXTcM6sI6l2HD1gu9UE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jAcAkK7gTyfnWQl62zlpwBFvzKci6WVG1lRGNV/K/278SMT3R0pfgzloyRH+ToUurm/+5RDrK7BdXalMpGjJcrwq7wPtaP4JCOap38sFFaeGk5DDJ/zSx/UuJtMvy+131bKh5DG9ZYXC6eXJu9NeP3nrDZWi0SkPov72+SdQFtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=bannaZ70; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-41a1d88723bso38315905e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714466979; x=1715071779; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V/xhbt/COXGlqFBli73T3+IaeAJ1P5jCwcywvz9zn9Y=;
        b=bannaZ70dVZXLdcn7dvJC3ejF1++GtIAv4jit72eElyqsmp4SbuwzAjSfN8/8Xmn6D
         fGV7rOjNaA87sX9h32IxGMMHmJw5S5N4FzeBZIPDyx1KQur7HcO/ny24smYnVOltfnWZ
         X+0JR/u5beVNLvIngPJQpTi2bIK6w5I2ruYettBQtQMaQx7JoMN393RRsi/m+cs3A6z/
         eJV+eOafzPHoxKxS23oFO/YGk/DWLGdwzifQb116ZiYoDuMoj16vxBfJeoqFHBvx4R0A
         /dQhjrm4cSVuqMQFm5vRnwy2olDh+tpqo5zEcnJSse6avo1e229RdE4IdOt8mRCSUD1A
         TsVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714466979; x=1715071779;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=V/xhbt/COXGlqFBli73T3+IaeAJ1P5jCwcywvz9zn9Y=;
        b=I5q2I1eXfCWjPn9QbZ7edaktvL4JrVDgCwiZYN1+tSd/yn4SQSbyAvgpdKdndAjMgF
         aqeV6VXeB7H4eD2FH3eLMVDxmLmrYPbpZLdhTkxso/c9a9Ddb3nTjE6kRacsNZ+Qlw3b
         dsPn9YN9mjX5XQLXMstLhwmLIjiLEJ3ww6eLfyiagDu6zhRD5cf9HZKTfpXRHpEChZ07
         SNu74GCeW9ngLBw6ctkIBRobpaZxfCoE7JsqK8r5W9OYunvrpxe7ViQDhU4x4pB5muey
         h4l0eZLe7faJNFffqDl1JZln9hMfBWIqsER7pWyDmyUKf0gmggmWd/11JTuQIBv3J98e
         gc3A==
X-Gm-Message-State: AOJu0YyWqa4Wr2L3f0Y/9WIMmKXmntCqtnZlhJPD0daq4MyQN/agZZrY
	y6G+igijKOXf+hoO76/TKBSSLRD3JdapXzszMM9R0JOW+URawFnqIQ1WFLe4qiQ=
X-Google-Smtp-Source: AGHT+IEW2Fm1C3AK54zpPeOWBy1iuGBk8poztNfR2ABXIEMG2veQlRIYQzOytkGS8WbCziVgcJrktQ==
X-Received: by 2002:a05:600c:3554:b0:41c:503:9a01 with SMTP id i20-20020a05600c355400b0041c05039a01mr6110811wmq.25.1714466979088;
        Tue, 30 Apr 2024 01:49:39 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b0041892857924sm44490309wmo.36.2024.04.30.01.49.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:49:38 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Michael Walle <mwalle@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 02/11] nvmem: layouts: onie-tlv: drop driver owner initialization
Date: Tue, 30 Apr 2024 09:49:12 +0100
Message-Id: <20240430084921.33387-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
References: <20240430084921.33387-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=886; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nVu6mCCZB03QKYWEDrj9eorhlWzJbNAoFu1fp915O9M=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLCMHfSOpQROpW0/OszgRNfVnotYB9fFa9v9O yo7x7HHZ0SJATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwjAAKCRB6of1ZxzRV N7FaB/44mXtR3vvJ1FliEListe4XTu/pAFqCfUu5Jug8DQBj5ciEGu5NJcS6XILklEJsWSueHM+ yYBHgIifBfEPlUy/Q0TAKgWe6bYhu8r2GxLPsdT06a68UbOZ9IqlvOE+FXbkLxqOh6rgwaPie57 qHmO/mtFole35y4UAWtOjvq+72fwxWo8kRJDy/eQdtGv69Wjc/CgN7eZt31tRNjGLdqfJyAn/yo ZKvGx9Cupz6WJRBciCgu1JqpM1R3pE0OoEG7Z/oYEjHcaHSyTkT7RK/fTynJspfgtIwgR1B/h01 aK2EF1FOsi5RdOS4EbGkcB3WKW0XYt08xDagEm9+RPCVijsj
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Core in nvmem_layout_driver_register() already sets the .owner, so
driver does not need to.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/layouts/onie-tlv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvmem/layouts/onie-tlv.c b/drivers/nvmem/layouts/onie-tlv.c
index 9d2ad5f2dc10..0967a32319a2 100644
--- a/drivers/nvmem/layouts/onie-tlv.c
+++ b/drivers/nvmem/layouts/onie-tlv.c
@@ -247,7 +247,6 @@ MODULE_DEVICE_TABLE(of, onie_tlv_of_match_table);
 
 static struct nvmem_layout_driver onie_tlv_layout = {
 	.driver = {
-		.owner = THIS_MODULE,
 		.name = "onie-tlv-layout",
 		.of_match_table = onie_tlv_of_match_table,
 	},
-- 
2.25.1


