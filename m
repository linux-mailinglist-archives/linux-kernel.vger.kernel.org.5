Return-Path: <linux-kernel+bounces-163630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBCB8B6DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 11:13:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08F2328493A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3464128828;
	Tue, 30 Apr 2024 09:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tuo8cJnd"
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C4E129E81
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 09:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714468367; cv=none; b=gVcnoo8pbrg9TjBlnD7mhMByyeWob2Wg/+eHjPDVT8ICRCjKQtrB4hGa1PqyJsan+YN6IWRRDBhq/7L6qqi3uXBNKq2Q0JSxW0E2TLNvUOA5SHLBWX7hF6la1SmdiR/nBG5r3v+BjWOzKQoQ2bNePRrN+J8tGbtuIfwRS4vHj88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714468367; c=relaxed/simple;
	bh=7OkAqKieBSDhAhQDX4AtdgKVwzo06pSREmFyHqNCt8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=VjyqsOYXQl+yuyUGSHOW3ECHqhIsrH/KQTV7E6n9zN7WnpjQJrTMp2fpjVSMmQEJXO8jXW4YGiwFol5/7ErdvRROZW8WZTEIlExvs3R6ii9bP6sXLV23XjtjoZSYPXRCYe18+/K233n2jM0UBn/EFAxdIYR/otqG8G0HHLe8KWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Tuo8cJnd; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2dac77cdf43so69180631fa.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 02:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714468363; x=1715073163; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JIXMZ+tmEG/2vj3SvYBH4bXcI4VlX9A3+yAB/lRDd4=;
        b=Tuo8cJndBf1xx5Lv7PCLXceNh1P/VLZcrBmzyiKsQ4vMNfzcsL/7LWJI1MNzQqVF3Z
         +o91pZqq9Kg4SXTb3+O63HDAzRbFQOMt9bOzaT2oA0E8D8FNo/qlPI4FZz5lYpmWd+PW
         Y16PGPdo3RqT2TX66DzMgjaWCfJMZeUAeLqk1+KpKTaFsMjVtbm60G3cn1G7/CGrD5qS
         Tpb3gMzZ1FnxZ62346ovr76VL8+XJYHUPK3g61YAZZ4OSz2vQ9qlmnm3MNc+Wt7Iomfn
         ij9xFfRSWaI24+97qGH9zC1LTttI0COy9LVJ7r1MK7cekyU3O4hjw3Zo/0VRcAv2eaws
         PyUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714468363; x=1715073163;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JIXMZ+tmEG/2vj3SvYBH4bXcI4VlX9A3+yAB/lRDd4=;
        b=HAasaGtgBa51PdfJV3R5WvrDYMtT6ybDqZHVuqWk2F4lF9uQl08qZQlVrnoe3VYIQL
         4yZ5eTkUPTdVCNIibKdPM9eS5mDVRkyXiJrVBMNO5zUK7/BPZcrgj5UI5zGTEXerR6ir
         0+SHgkmuBNaj34zyZS38s16Ew5diBruFOda/vGfEXVxFpSDylhmRcxIxR/FIi5uNKfS+
         2JiPvaZCWCvKUh5j/deJJbQD8ozSbWh3Rh53Jz+ZcStLLnRki1fiETYjF15iVjK2bFxe
         o5NfYSSk2+oZo7ylv2OGJy6xoHVuYfg9J+lMbAOk+hqy77AK1nEwZ0HxpOZq2fglPEwJ
         BI6w==
X-Gm-Message-State: AOJu0Yw7d03kQN0Vdhw4MA46upeDIR8FmUrB3QOr9j8iex18PRTM7D8g
	g1p/mHTKUNdYU/QMFBkCSdoBDW23peJO/inXW/iXrCDt/8dfaLjMGTji9c8gRs4=
X-Google-Smtp-Source: AGHT+IE1C/pV3fQbZ1npEvn9jYsbIVazA75C3yRortDB86xYNP4RhDsS3v1bh2f+LFvT9p1grv7z/A==
X-Received: by 2002:a2e:7214:0:b0:2d8:54b3:954b with SMTP id n20-20020a2e7214000000b002d854b3954bmr8056617ljc.53.1714468363074;
        Tue, 30 Apr 2024 02:12:43 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b004182b87aaacsm44334164wmq.14.2024.04.30.02.12.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 02:12:42 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/1] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Date: Tue, 30 Apr 2024 10:12:38 +0100
Message-Id: <20240430091238.35209-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430091238.35209-1-srinivas.kandagatla@linaro.org>
References: <20240430091238.35209-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nY3vC2NApvFywCNrd7bStLnbD2rZAm4vIaxy7vAQZe8=; b=owGbwMvMwMVYtfBv5HGTUHPG02pJDGkG29i8Raa4yZwz+RpfX+dnO33J/5d6u9oclq+PcvXc5 HXMYdm7TkZjFgZGLgZZMUUWpef+Ucf+PPr2Xe5uL8wgViaQKQxcnAIwkbs27P9LHf36C5wZVmhV FRd4zNo4/Xbat2ov7dVLm5Lv7ddsv5kZ+eTqDQmXSunupzXHUvK1eK72+i/lPTUryES80ebc9Cl 1+/kuaRuGOJ32+B8zM73jMrdPm9Hyb5lCDM26E88HVa2bwe58g2mt18Idd47kbfw9R92t7W1nf+ npALlXXwtPtsQ0lPSkL17/1ZvNYvlMvra/GxMnO98Vis8WD4jLZrFlVy2wn3paOoqRQ2Xi86ypj P4xMRrvLio6li5RmsV57aTILC+xr75SM1vYzN12bdHU3b3GoEmpWJj54AlOryc1UbPcJpsIWmQJ FzeLTzb2LPWZ4s65/zVjj6DDjzs7NbZlaLH0H7707psSAA==
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Viken Dadhaniya <quic_vdadhani@quicinc.com>

In current driver qcom_slim_ngd_up_worker() indefinitely
waiting for ctrl->qmi_up completion object. This is
resulting in workqueue lockup on Kthread.

Added wait_for_completion_interruptible_timeout to
allow the thread to wait for specific timeout period and
bail out instead waiting infinitely.

Fixes: a899d324863a ("slimbus: qcom-ngd-ctrl: add Sub System Restart support")
Cc: stable@vger.kernel.org
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Viken Dadhaniya <quic_vdadhani@quicinc.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/slimbus/qcom-ngd-ctrl.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/slimbus/qcom-ngd-ctrl.c b/drivers/slimbus/qcom-ngd-ctrl.c
index efeba8275a66..a09a26bf4988 100644
--- a/drivers/slimbus/qcom-ngd-ctrl.c
+++ b/drivers/slimbus/qcom-ngd-ctrl.c
@@ -1451,7 +1451,11 @@ static void qcom_slim_ngd_up_worker(struct work_struct *work)
 	ctrl = container_of(work, struct qcom_slim_ngd_ctrl, ngd_up_work);
 
 	/* Make sure qmi service is up before continuing */
-	wait_for_completion_interruptible(&ctrl->qmi_up);
+	if (!wait_for_completion_interruptible_timeout(&ctrl->qmi_up,
+						       msecs_to_jiffies(MSEC_PER_SEC))) {
+		dev_err(ctrl->dev, "QMI wait timeout\n");
+		return;
+	}
 
 	mutex_lock(&ctrl->ssr_lock);
 	qcom_slim_ngd_enable(ctrl, true);
-- 
2.25.1


