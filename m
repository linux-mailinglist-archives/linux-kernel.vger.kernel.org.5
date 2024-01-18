Return-Path: <linux-kernel+bounces-30530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CBFC831FF6
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 20:54:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 90EC91C22429
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 19:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E812E85A;
	Thu, 18 Jan 2024 19:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="DCEdkRnP"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D952E83A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 19:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705607618; cv=none; b=a5TCmIC+CLA2V1V+C3YA/DuTpUegVE4+/017yZT4gaB4uxo7IYZBUw/pkH+zlImys5z0ApTnYDsaewSp94tcyOHkN7ovhg8KtnzCEA7yvujhW5G9HSVVNYh4nhkrt74xg4Wy7ZvyGrD1RoLECKwbrOaeDdoVnRUSPzLczgcgvn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705607618; c=relaxed/simple;
	bh=TJ0HS9DsmpIK3Lc89zTlK7cbKY5l8+Fb4v4FOr6pRxc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uZ/0/E5RKyuoebSEG81vHFdw8xGmvbUtko56T5eF0Q9oGKCIodqRG88O+QCp8DPlUo/W6YcfbqKmQ5cvqJyFvfRxJhbkN++KFPZ+pIK9sRsoXGUJ4jjhaVNvDMwIwgslA/tAqA04kCjwIJSW6rs5hMmuVHI3e+E+M0NyYu9NQKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=DCEdkRnP; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2ccb4adbffbso783861fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 11:53:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705607615; x=1706212415; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oAiOdmemfs++EaElh/QkCQxHrKK1nXdTbeGxucqp/W4=;
        b=DCEdkRnPJcYRGsVC1akc8QKlqgmuk0TJIBRhO05kOxoaHkTrRgCjlK5dmiZDDERzVq
         NHeSJSkwXBBIaYW8oFG0ipPzYeqhlALLU+dMppExs4sNn2zXEPI2sOysWAWrykAZZORD
         aOoUdqja7eFPWExmPkPDtxoXwgWn9J8pkePjU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705607615; x=1706212415;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oAiOdmemfs++EaElh/QkCQxHrKK1nXdTbeGxucqp/W4=;
        b=BRegwWm3hOp7JXT51PMC1jLP6IrTM5okS0fEw9xnK+ubRglccwxF+ckOFt3ZtQ6niD
         hNYadr+hERaMKqixlaeoSXeBruSqyuAVnJYkfguiLZ6Z45hU0fvecEZjkhP5Z8uHgs1T
         CfBVnuRbCBU93Zuf8xPJjHCSZ9iD6RUalt3Og5yfeQ4ahVgQHo/foj5M10sbrlpaGYnS
         ZEnlL5Ro5DU8QUMiuYI17I6cZtRFSAUED8sxu5BGNbSBrKDCmjkSuZ0evfL/UjDR5UaP
         aC2ONnz/7tZzmzGpo9brrY9LtJTlyc0BDfThdyI3aJWDgC7/yqXrGnhuCLJfh8NLt/2O
         fPMw==
X-Gm-Message-State: AOJu0YzF59YPhS7GQfVEEcWmv8THveZhByZW8WbjoY3xHCzSNN4v6D/i
	xBLXhodT+zhlAnLjO6vIgFaKV7Xc9xcRGTPfUzwtqNiFXKMztAOauhECqrKQuA==
X-Google-Smtp-Source: AGHT+IEy33EOIoM9A41TAqaa5BgK/M3wGgbb3sgYuQYOQsgSDzkgvy6rte8dlH1jvozcsJ8pHI/OXw==
X-Received: by 2002:a2e:b708:0:b0:2cd:2606:70e2 with SMTP id j8-20020a2eb708000000b002cd260670e2mr807557ljo.20.1705607614870;
        Thu, 18 Jan 2024 11:53:34 -0800 (PST)
Received: from cracow.c.googlers.com.com (138.58.228.35.bc.googleusercontent.com. [35.228.58.138])
        by smtp.gmail.com with ESMTPSA id 2-20020a05651c00c200b002ccd3e8a59esm2333345ljr.121.2024.01.18.11.53.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jan 2024 11:53:34 -0800 (PST)
From: Lukasz Majczak <lma@chromium.org>
To: Gwendal Grignou <gwendal@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>,
	Radoslaw Biernacki <biernacki@google.com>,
	Wim Van Sebroeck <wim@linux-watchdog.org>,
	Lee Jones <lee@kernel.org>,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Krzysztof Kozlowski <krzk@kernel.org>,
	linux-watchdog@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	chrome-platform@lists.linux.dev
Cc: Lukasz Majczak <lma@chromium.org>
Subject: [PATCH v2 3/3] mfd: cros_ec: Register EC-based watchdog subdevice
Date: Thu, 18 Jan 2024 19:53:24 +0000
Message-ID: <20240118195325.2964918-4-lma@chromium.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240118195325.2964918-1-lma@chromium.org>
References: <20240118195325.2964918-1-lma@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add ChromeOS EC-based watchdog as EC subdevice.

Signed-off-by: Lukasz Majczak <lma@chromium.org>
---
 drivers/mfd/cros_ec_dev.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/drivers/mfd/cros_ec_dev.c b/drivers/mfd/cros_ec_dev.c
index 603b1cd52785..d0140a285f69 100644
--- a/drivers/mfd/cros_ec_dev.c
+++ b/drivers/mfd/cros_ec_dev.c
@@ -91,6 +91,10 @@ static const struct mfd_cell cros_usbpd_notify_cells[] = {
 	{ .name = "cros-usbpd-notify", },
 };
 
+static const struct mfd_cell cros_ec_wdt_cells[] = {
+	{ .name = "cros-ec-wdt-drv", }
+};
+
 static const struct cros_feature_to_cells cros_subdevices[] = {
 	{
 		.id		= EC_FEATURE_CEC,
@@ -107,6 +111,11 @@ static const struct cros_feature_to_cells cros_subdevices[] = {
 		.mfd_cells	= cros_usbpd_charger_cells,
 		.num_cells	= ARRAY_SIZE(cros_usbpd_charger_cells),
 	},
+	{
+		.id		= EC_FEATURE_HANG_DETECT,
+		.mfd_cells	= cros_ec_wdt_cells,
+		.num_cells	= ARRAY_SIZE(cros_ec_wdt_cells),
+	},
 };
 
 static const struct mfd_cell cros_ec_platform_cells[] = {
-- 
2.43.0.429.g432eaa2c6b-goog


