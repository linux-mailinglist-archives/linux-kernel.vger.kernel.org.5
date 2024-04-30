Return-Path: <linux-kernel+bounces-163587-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 452EF8B6D5A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 10:52:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65428B22EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 08:52:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415FE211C;
	Tue, 30 Apr 2024 08:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="kkxaOIpz"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFE0F128366
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 08:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714467015; cv=none; b=bfvenfTypc/Hq5hT6koo97Z6d3aCZ2i7e1SBRcaz9grsCqes7gbs8li9+gaukrJpBC66GahcWxNr03g06+9XeJ7klim0+eiSTwstk/gmqf44DNViP50N89nidXUoaSMD1mG7n2V2M4aBNbruqgfU8sf8mwZ8VnfniKn022afZz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714467015; c=relaxed/simple;
	bh=7OkAqKieBSDhAhQDX4AtdgKVwzo06pSREmFyHqNCt8w=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=FK93mjKvt60FtTQhtzVGjJOXa7R0j4kqygu/MDAvowRNOuXyaO8VL/RbYoHAJWJLb/NkLU5yM6vaywwrMch3UuDVZ28BWub7hbwxRc8jQL9BdtwiK9Bvmu9BUohGITzJefFsJiwzBHxSxf7z9b+6o6okXJRrp5/lcXPqmrXqcaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=kkxaOIpz; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34da35cd01cso88874f8f.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 01:50:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714467012; x=1715071812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/JIXMZ+tmEG/2vj3SvYBH4bXcI4VlX9A3+yAB/lRDd4=;
        b=kkxaOIpzm9zXiCGjEXlBpxoQ5aSMhOLGIAUPTHc2N98i5oUnJRKAK/clHU4CGjsqQW
         NvvoYOXQlXc3G5OWMi0g8FUXfWpSEnO+E13jwUTfjIpODYl7n5pqaPEn/fHsboQQAv6I
         8oaUt3eE9hxbgugdQ8pnzOOBBlEtobfWGtDIg5fLp1kvi7AhaH/k3gpim+kZ3BJPbosL
         vLkKJIgvm8pk5O4c8Rr2CKUF3/fQDGzpI5f80peLw5+VL7mnNe4Jh6buDWV3htPYYIhC
         MxipxldVdSeuTeNuS8ru/T2i9Xl0Q+I4EwCoP/WB3B8lSf1AUYaFUB2N7IpJJK5HBmX8
         RdOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714467012; x=1715071812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/JIXMZ+tmEG/2vj3SvYBH4bXcI4VlX9A3+yAB/lRDd4=;
        b=fOsSH8YrqObl6U72YCVjhKDiyCBtrOgB+gOejogEZuhRDDWs4jJ5MgrMld36Rva5C2
         HU/VGfRp+P76XyN2m+iE/JtvZCySG3CoDnIj5walnL8y80ujgcOPGbt9gtFPJo4RgNcH
         mbORAI/X0sWEderrPiVxez07jJ6B0FHPD76FW5kQNv83hmt7kpwYd2vpHZ2RYQ6OEyqS
         RpwyrDj819C37/Di6cnR2BNsnnihCVk9EqAqFXVGdYZBlweGZHzoYWfkmDQSJqvcNTKS
         bRjnCsmBhmhe5yeX5vab8xHnB5ltbnv5Kj9N/FgKhmQ/8aswDw3gBvAjpmB0xPy9uZAG
         665Q==
X-Gm-Message-State: AOJu0YyyKV5uP/YwnpJai7gWHvUpKo9oFrqVBm5FZwiGDejTGaMZX/U5
	ZYuR18m5MYH0rmKkxbk8ZMuK2mIV7gplOS3UUS+7LWGa5GvBHwJjXQI4wbH8lyY=
X-Google-Smtp-Source: AGHT+IEZyZMQEkt7Qnf6sUaatu/d9B49PDHIW6yC+nBl9iPDLV0sIdkIE5KjQhJdhA9ZaivYbrSF5w==
X-Received: by 2002:adf:ffc3:0:b0:343:5cca:f7c7 with SMTP id x3-20020adfffc3000000b003435ccaf7c7mr11647674wrs.41.1714467012373;
        Tue, 30 Apr 2024 01:50:12 -0700 (PDT)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id p18-20020a05600c1d9200b0041bab13cd60sm14590670wms.3.2024.04.30.01.50.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Apr 2024 01:50:11 -0700 (PDT)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Viken Dadhaniya <quic_vdadhani@quicinc.com>,
	stable@vger.kernel.org,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 1/4] slimbus: qcom-ngd-ctrl: Add timeout for wait operation
Date: Tue, 30 Apr 2024 09:50:04 +0100
Message-Id: <20240430085007.33607-2-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
References: <20240430085007.33607-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1428; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=nY3vC2NApvFywCNrd7bStLnbD2rZAm4vIaxy7vAQZe8=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBmMLC8SxSURhzONPVff35OPZek/+kuuoZAp69aR UmySsZApu6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZjCwvAAKCRB6of1ZxzRV N3RVB/9+LfpdRucIlrq+JZtSTP2TjtKCnPXhPTQvLFsf3NK/9EU2mHVWKv4y+aBN83eoy2Ssg8Y /gkIlo6I4uxvVlXWnyJEfyZr3eJ2o3uFTOnWSjc/CzKJQBSfLhXfUjfuD+cMoSCpzgWE6O04Kw3 F6gQBP3lLrVVGXZpTGrTjsjOhJzxXXZElDJHI1W0wPkGTSPvLGiK4kIN0y5xOF1gEnYdIoxA6cr QTNRW6faVhXmscMIHC8UNEE1fRYlArKhkYFfHTt4L66oo03rWTKpKBPz/n0vcm9GjuxXjBoYtII BHMdCAnEZbnDpfHJcJSqhZHIRQHU2+QLuuiniI8hJMhJ0Syk
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


