Return-Path: <linux-kernel+bounces-837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8858146E1
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 12:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02DF51F233DD
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 11:28:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7549C24B57;
	Fri, 15 Dec 2023 11:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gOwWQGOf"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A27F2C681;
	Fri, 15 Dec 2023 11:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c55872d80so9638915e9.1;
        Fri, 15 Dec 2023 03:27:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702639668; x=1703244468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yeQwlKBI2SF/Ztq9EJVcE7+HTMb8ecHbVMx3S5Ftdmo=;
        b=gOwWQGOfP9E2xP/aDHVGN0s0hV7sXd3geYrgM/fXt8iWa/EEE+dLgl6jtD0gQfWGNy
         7vOEuA9HnyuJRl+7Yxn23hQp6rZLy6wPWPNdIvMscsZVrbhvmd8t7wFR/6mklEHbYoe+
         YcY2TmkQy+bhrsZPlkKluQcHxZtrVVwt1Zk2uhgTTPb/geyz+4vMx4x6YU5xDLPayxVY
         6qlTKtK+ZKAvc90MvDc4zZgaqN4HF5QBo44o27rpkHzOt5BnIymkpskco9MDhHNiN9az
         5LN/ay4FGQuVHAALON2OtBJ3bOMZP1njlmXOM8//Ukn5EZIGxMFgoP99NLJNC38HWE1R
         EmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702639668; x=1703244468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yeQwlKBI2SF/Ztq9EJVcE7+HTMb8ecHbVMx3S5Ftdmo=;
        b=MMP1UPsZiQVXrUKZZ9fC5/VbTmoYXHiBbXVqJXOpKVY++YrnG/4AqUzXa0IRSAY1db
         YygkVSgVvJNKG03AaK/pueMGd4+LPZ5UntI6RWFFzTQXps+mPYC2wpE1WV3/cDs07XYP
         3O+G4m50XRUryF+K6GllPxF1jhn8xF97615nTLMs37VJ02W9f7DOz2jTI6EdAJL7Ab9r
         06XXS3pUp7l8ErYa/6FAKFdb/TD3gyEMfTnQutKuzcgqSes7XXXKYaj8DIWftBWCWfI/
         THXDYN58KuLh9LuSuC7k1WsJrJivd7zOofHEYQnNUi5Qjscrs5NmGD9XlpWZouFUYlck
         YpKA==
X-Gm-Message-State: AOJu0Yy55HQICDAoFCJpGpRngt5K7Ohq6YfQg2NnMgHSJyz7Y9VN487H
	iYTCA1ujCHEQ829A61HPJtKtZH7thUXrSA==
X-Google-Smtp-Source: AGHT+IFYcOWPBrbaJdOtLFfNHfilk3y+Se26A0GqU9cninD9SdsjcKfZkMPovTzZNFMPhwyNYpbWZQ==
X-Received: by 2002:a05:600c:4749:b0:40b:5e4a:233f with SMTP id w9-20020a05600c474900b0040b5e4a233fmr5497697wmo.65.1702639668195;
        Fri, 15 Dec 2023 03:27:48 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id bi11-20020a05600c3d8b00b0040c2963e5f3sm28532074wmb.38.2023.12.15.03.27.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 03:27:47 -0800 (PST)
From: Colin Ian King <colin.i.king@gmail.com>
To: Henry Shi <henryshi2018@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	platform-driver-x86@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH][next] platform/x86: silicom-platform: Fix spelling mistake "platfomr" -> "platform"
Date: Fri, 15 Dec 2023 11:27:46 +0000
Message-Id: <20231215112746.13752-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit

There is a spelling mistake in a literal string. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/platform/x86/silicom-platform.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/silicom-platform.c b/drivers/platform/x86/silicom-platform.c
index 84b92b3f9f4b..6ce43ccb3112 100644
--- a/drivers/platform/x86/silicom-platform.c
+++ b/drivers/platform/x86/silicom-platform.c
@@ -866,7 +866,7 @@ static int silicom_fan_control_read_labels(struct device *dev,
 {
 	switch (type) {
 	case hwmon_fan:
-		*str = "Silicom_platfomr: Fan Speed";
+		*str = "Silicom_platform: Fan Speed";
 		return 0;
 	case hwmon_temp:
 		*str = "Silicom_platform: Thermostat Sensor";
-- 
2.39.2


