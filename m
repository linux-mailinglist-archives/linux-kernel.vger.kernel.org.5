Return-Path: <linux-kernel+bounces-61502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 090068512F6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:06:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E1361C224E1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 12:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D62183B296;
	Mon, 12 Feb 2024 12:01:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C9MT3fud"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAAAC3AC01
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 12:01:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707739298; cv=none; b=nIF5crDK5CQwqMHPv8D+3cCjijEspb32G7PAaDVo+bR5Wq6jRQ83XxoORW5JbXXMqBoZNEN0fKE1cUe+6LvkFT/L5Rj0wfJqKguAt8MQ9Gzzo1MnUdyLuVy1DFUK5Fvo/Aj7QGr3lyEOCXwq6N4ckv5GW018H1X0IDcbKthj1Ls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707739298; c=relaxed/simple;
	bh=w3rORuWTMKgPaBFzu1c48yBjhOeuhNYDjtGcd5hqMtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lzJOWmkAkgD7qw6eeZoa7mcXz8FnW3aRDjXxIE77bKPMvtmK0At0Xuxzna6dMBCzgpASt+V7Z+NoFsPiWtnKhy8mEOpGKKk5skfritt5LV4KKF6fluPhausUMD36iSq5xzADAmL6j9Mju4kRD5bvxwbAYKhHfpy7iC8zES7bawk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C9MT3fud; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56001b47285so4106345a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 04:01:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707739294; x=1708344094; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/SJbIRpwzF2ctEEKD5A8Zx9RKqrUsd1zHiNl04248IY=;
        b=C9MT3fuduffWAS73UjZiSp+su1O/DyfxAna8hqjGgY0AABCJHmGqnVAcprxJAforE9
         9HZZ8A3v2erSUTo2QAyFDK/GaqKSbcvCYVkyB6F0A+DxcSqUPnYFRa7K5pr3f4iHMxfl
         kOH90W9eI2k9V6DSePw31Hy9aC9YJ30rrjawlDUzTz0zoFK7VLqGChmHQwyUJahIQA24
         Zh/0Mz3JlWEIOOcg20fAB6BnsbdyzORt5tlk8/IeAvSps0D4UPIXCjhYbpEmK2W5QI13
         K4Fx3HfrISLJQ/DWMLo3KIgamp/hSUN/An6maSNE2wjhVIsvX2SHUCXuVG/TCHBIjZGI
         QG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707739294; x=1708344094;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/SJbIRpwzF2ctEEKD5A8Zx9RKqrUsd1zHiNl04248IY=;
        b=lF3rAiHgKxAQkW8LdST07SRR+hWrLUtV7nCxK7Hgpj9ST4FcV3EPHKZ0lAszS60/CX
         J3m4F+VrluXnEmMa6c5PZpZK+BVss2DREwldEKDWuKBZQT+iYWRdR8ugeUsfiLJu5lOj
         rvqX9RsQ9juXYMqjaEcMSLXcDf0wMZ+uw7eqFaHtwnsPrFBzSitEadSWShItAqsmPyE1
         FbXWflgo0FN2I8emEU3zQTM+Ltb8n1Q172V5uC7vNyuEbuQoFn85tt0RWSO1G89dJ6lH
         IPguila3xqu1B8x4oc5bu3crMQ3m/j2n0vO/R9eYgXzzxsaP9/fNNuIxU86o1iP5iu2w
         J35g==
X-Gm-Message-State: AOJu0YzvF9ZN20k/Z9mWQZuNsNLCrIr43sLLnU/eCVaQ72C7GtR+GPDl
	MF4pLibgaisK0jNDj5Iivym7iqVo4pJHjwc7FViLQaYZCKpbpFH6t1/BW8j2TGvb+tM5nTLxxYk
	j
X-Google-Smtp-Source: AGHT+IF2464+drFBZhUca4wqgE5z9c1DNZxpEJo1kOm0tk1J4kagCGZLwUCHOkmr10gvf1PgGISnIA==
X-Received: by 2002:a17:906:5648:b0:a3b:d35a:8d4 with SMTP id v8-20020a170906564800b00a3bd35a08d4mr4426207ejr.59.1707739294087;
        Mon, 12 Feb 2024 04:01:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUB58XJ1bEZipxO3mDOpCDQz34W0vlyLcN4FOBYt7YK9G4zEX4SGYBVfnydByUrTXvjDR1hWGsuE6bebKBitS4Mk/84ktWLpZlpG2kbzqfYj3omvmSpoCwNz1T/SKapF+yfG0uJ0HPw2JwJsfMvFWBQnT67Qm5TSC5FsYhMebZ30BPvMhjkzAOMWITpIOpHJyH+Uc9HkSGpBmvklGWm6w624f0Uybm51pFdw1AKF+G1VncwNQ==
Received: from [10.167.154.1] (037008245233.garwolin.vectranet.pl. [37.8.245.233])
        by smtp.gmail.com with ESMTPSA id h3-20020a1709063c0300b00a3895de6d53sm140177ejg.140.2024.02.12.04.01.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 04:01:33 -0800 (PST)
From: Konrad Dybcio <konrad.dybcio@linaro.org>
Date: Mon, 12 Feb 2024 13:01:30 +0100
Subject: [PATCH] usb: typec: fsa4480: Check if the chip is really there
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240212-topic-fs4480_check-v1-1-d9969e4d6f9a@linaro.org>
X-B4-Tracking: v=1; b=H4sIAJkIymUC/x2N0QrCMAwAf2Xk2UJSioi/IiJpTG1wdKNVEcb+3
 eDjHRy3wdBuOuA8bdD1Y8OW5kCHCaRye2iwuzNEjAkjxfBaVpNQRkonvElVeQZhRjpiyYQEHmY
 eGnLnJtXT9p5nl2vXYt//6XLd9x+GGoPqeQAAAA==
To: Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Bjorn Andersson <andersson@kernel.org>
Cc: Marijn Suijten <marijn.suijten@somainline.org>, 
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1707739293; l=2388;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=w3rORuWTMKgPaBFzu1c48yBjhOeuhNYDjtGcd5hqMtY=;
 b=FIXvcvvrvrYhdu80jCG+hBtqar2dn/CYKJvH1olJwfZBbgmXatgGgudjug5rDPDGzzSA5mQhN
 PuA9NGzWGeMBhHf4puLX5p4rPWD5znEY7jOz/5z+BOervwKS/iP5t5F
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=

Currently, the driver will happily register the switch/mux devices, and
so long as the i2c master doesn't complain, the user would never know
there's something wrong.

Add a device id check (based on [1]) and return -ENODEV if the read
fails or returns nonsense.

Checking the value on a Qualcomm SM6115P-based Lenovo Tab P11 tablet,
the ID mentioned in the datasheet does indeed show up:
 fsa4480 1-0042: Found FSA4480 v1.1 (Vendor ID = 0)

[1] https://www.onsemi.com/pdf/datasheet/fsa4480-d.pdf

Fixes: 1dc246320c6b ("usb: typec: mux: Add On Semi fsa4480 driver")
Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
 drivers/usb/typec/mux/fsa4480.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/usb/typec/mux/fsa4480.c b/drivers/usb/typec/mux/fsa4480.c
index cb7cdf90cb0a..d622f4f3bd54 100644
--- a/drivers/usb/typec/mux/fsa4480.c
+++ b/drivers/usb/typec/mux/fsa4480.c
@@ -13,6 +13,10 @@
 #include <linux/usb/typec_dp.h>
 #include <linux/usb/typec_mux.h>
 
+#define FSA4480_DEVICE_ID	0x00
+ #define DEVICE_ID_VENDOR_ID	GENMASK(7, 6)
+ #define DEVICE_ID_VERSION_ID	GENMASK(5, 3)
+ #define DEVICE_ID_REV_ID	GENMASK(2, 0)
 #define FSA4480_SWITCH_ENABLE	0x04
 #define FSA4480_SWITCH_SELECT	0x05
 #define FSA4480_SWITCH_STATUS1	0x07
@@ -251,6 +255,7 @@ static int fsa4480_probe(struct i2c_client *client)
 	struct typec_switch_desc sw_desc = { };
 	struct typec_mux_desc mux_desc = { };
 	struct fsa4480 *fsa;
+	int val = 0;
 	int ret;
 
 	fsa = devm_kzalloc(dev, sizeof(*fsa), GFP_KERNEL);
@@ -268,6 +273,15 @@ static int fsa4480_probe(struct i2c_client *client)
 	if (IS_ERR(fsa->regmap))
 		return dev_err_probe(dev, PTR_ERR(fsa->regmap), "failed to initialize regmap\n");
 
+	ret = regmap_read(fsa->regmap, FSA4480_DEVICE_ID, &val);
+	if (ret || !val)
+		return dev_err_probe(dev, -ENODEV, "FSA4480 not found\n");
+
+	dev_dbg(dev, "Found FSA4480 v%lu.%lu (Vendor ID = %lu)\n",
+		FIELD_GET(DEVICE_ID_VERSION_ID, val),
+		FIELD_GET(DEVICE_ID_REV_ID, val),
+		FIELD_GET(DEVICE_ID_VENDOR_ID, val));
+
 	/* Safe mode */
 	fsa->cur_enable = FSA4480_ENABLE_DEVICE | FSA4480_ENABLE_USB;
 	fsa->mode = TYPEC_STATE_SAFE;

---
base-commit: ae00c445390b349e070a64dc62f08aa878db7248
change-id: 20240212-topic-fs4480_check-caa0160fb101

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>


