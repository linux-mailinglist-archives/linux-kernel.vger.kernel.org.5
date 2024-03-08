Return-Path: <linux-kernel+bounces-96740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CD08760E0
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 10:25:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DF071F23317
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 09:25:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 195DD535A0;
	Fri,  8 Mar 2024 09:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UVlZ3s4o"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D093D524C3;
	Fri,  8 Mar 2024 09:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709889924; cv=none; b=RTQZin7JYY0AVK7sIawez6vtt02kra8o1Ik4vQib5BuKv/ao0R0LYXgMIAnE5rIpLABKYEimTehjHJ49C+VShA9hClFHGT1IzwjSnjvoAHlXXqpndFO+5+EKt2v14bkJzH3tHZZxxSkymQ8c4eLt0lRMBR6sd4lKhu8Ejwnf0TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709889924; c=relaxed/simple;
	bh=zfl+XX0JMuoIscs2sao+0SvrAb4my8UOhKqfP7P+2OQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=CHmcAv2Svvmt7nBJy6HgTp4eqjq6ndBXuRK2esvQo34djgucTFW4FXDT5it9Z0oo/KlcZ/rNzYfL3K3vqlmHmfAR0sSTv4eM8ovIhiSpaLJtHoAe1vLmVwVXyO1GuJF/TFfU30GMW5d5jMujzhYpCqnZAjkBAo61XvvLs6QxFLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UVlZ3s4o; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-33e2268ed96so620316f8f.3;
        Fri, 08 Mar 2024 01:25:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709889921; x=1710494721; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8g6G9JRlegwlqqFcwBhmFenh5XZ0r96ecCCneui4Q3M=;
        b=UVlZ3s4obZrr/NtGPFeIc8tngC08x9+PaSMVcQ86o7P44qQqpT01Aq7hyNCrn6h54q
         Zft9t0YYnBeg2TLgAYxxqEpX/3O4wyTiOCHKt50sFkAY97YDpVwG8Zb0N+5oQL5zKO6A
         SGsPfJeinwYUVEOfHiSdOfyeqFx20L3d3FUK9nWF4pU2HY/vyoTkjgr2zQ21WPBKjeAb
         BQRgsU5agM2l280xuqwo876fPyhJCCQ57n2dRhw06yBZhTUwBPadu42xQKwJqU5HCaGH
         r0inRo8vl2CeQcOecRjVMSOXj1OmTpKuu5LnpJ3TObJRAdivYcPIa9xB0n2C+rJSjm13
         i43Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709889921; x=1710494721;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8g6G9JRlegwlqqFcwBhmFenh5XZ0r96ecCCneui4Q3M=;
        b=py+10eMyTiVShJC62hiP9ruyyXVI7CFJCOj3OUUkvMET5o2RBTBd3FqIiX1WysLjqS
         lBtFpBu8Kw/+OehRr6X/cZOt+w7JJGQ1OVWyrLf+JCo1EY1/lWI14gTfHpCXWj/vDkMl
         HudW1MOyRkgrjIk3zsPsl8hlPJ9wNx3sTZuYBsGvVJniLbTor55Gskr0MTAlYqvuRVEj
         Dmtfb4h2N/qihQvRKsKm3FF4QBT5iKdIPl2KU/lXXQD6b3dcjsjZxUpZ2jLfPk73Ydhf
         MzlY2JH1HYMqR/4hByX6x1C5dHQ0VEI6fzXq5mwjRntT1nGhfXoLSiX3iTEZUmb4h2xx
         q9iw==
X-Forwarded-Encrypted: i=1; AJvYcCWgJQa4JJ5I9u+opEBSV1RzN0A7arCUxsml5Djfr7Iwx+/QyI+nJOgHvG7WSvbCI5FAkxvRG+ijnhThxs3BjjmA2v9ZSpG19zs84oIU
X-Gm-Message-State: AOJu0YwRqYQyN20GcgxPXcbchggR6hQ+qW49cXemzttf/ER0legWZ1Cv
	JG00R/HRxHEuCjk9yo+44CZwD+IgIsq7yx2vpSitSPuLBmGFQqoP
X-Google-Smtp-Source: AGHT+IGzzCKBqOSSu4nOvx/fDIREpSaEVriBC64RefWyqEsozWw9jeoXVANQYdtWJfYT/W/Qu+7shw==
X-Received: by 2002:a5d:6906:0:b0:33e:793b:a2aa with SMTP id t6-20020a5d6906000000b0033e793ba2aamr407319wru.47.1709889920853;
        Fri, 08 Mar 2024 01:25:20 -0800 (PST)
Received: from [192.168.20.102] (57657817.catv.pool.telekom.hu. [87.101.120.23])
        by smtp.googlemail.com with ESMTPSA id ce9-20020a5d5e09000000b0033e786abf84sm801289wrb.54.2024.03.08.01.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Mar 2024 01:25:20 -0800 (PST)
From: Gabor Juhos <j4g8y7@gmail.com>
Date: Fri, 08 Mar 2024 10:25:07 +0100
Subject: [PATCH] firmware: qcom_scm: remove IS_ERR() checks from
 qcom_scm_bw_{en,dis}able()
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240308-qcom_scm-is_err-check-v1-1-9c3e1ceefafe@gmail.com>
X-B4-Tracking: v=1; b=H4sIAHLZ6mUC/x3MTQqDQAxA4atI1gbG37ZepcggMdMJRa0JFGHw7
 g4uv8V7CYxV2GAoEij/xWRbM6qyAIrT+mGUORtqV7eucU/caVu80YJinlWRItMXX/3UEfWhelC
 A3P6Ugxz39z2e5wV9+r3iZwAAAA==
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Gabor Juhos <j4g8y7@gmail.com>
X-Mailer: b4 0.12.3

Since the qcom_scm_probe() function returns with an error if
__scm->path contains an error pointer, it is not needed to
verify that again in the qcom_scm_bw_{en,dis}able() functions
so remove the superfluous IS_ERR() checks.

Signed-off-by: Gabor Juhos <j4g8y7@gmail.com>
---
Based on v6.8-rc7.
---
 drivers/firmware/qcom/qcom_scm.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/drivers/firmware/qcom/qcom_scm.c b/drivers/firmware/qcom/qcom_scm.c
index 520de9b5633ab..a3bfe7de0bfd7 100644
--- a/drivers/firmware/qcom/qcom_scm.c
+++ b/drivers/firmware/qcom/qcom_scm.c
@@ -163,9 +163,6 @@ static int qcom_scm_bw_enable(void)
 	if (!__scm->path)
 		return 0;
 
-	if (IS_ERR(__scm->path))
-		return -EINVAL;
-
 	mutex_lock(&__scm->scm_bw_lock);
 	if (!__scm->scm_vote_count) {
 		ret = icc_set_bw(__scm->path, 0, UINT_MAX);
@@ -183,7 +180,7 @@ static int qcom_scm_bw_enable(void)
 
 static void qcom_scm_bw_disable(void)
 {
-	if (IS_ERR_OR_NULL(__scm->path))
+	if (!__scm->path)
 		return;
 
 	mutex_lock(&__scm->scm_bw_lock);

---
base-commit: 90d35da658da8cff0d4ecbb5113f5fac9d00eb72
change-id: 20240308-qcom_scm-is_err-check-96a5cc6f17cf

Best regards,
-- 
Gabor Juhos <j4g8y7@gmail.com>


