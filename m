Return-Path: <linux-kernel+bounces-162817-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32C778B60EE
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 20:14:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 918AE282615
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 18:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467FF128801;
	Mon, 29 Apr 2024 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Eje0KCDt"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E9E127E2A
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 18:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714414458; cv=none; b=rqvxQmFdwDYjDlaAWOjyCC66jROMNxDqu9Nvn+i7bg2s0CCWVTnvU0bFJYaOcnDYEEkxywM3tTZrr0QNReY3h+Zp3qtkSaotx6pd9xFw3lgY1gRYAeQH6kiqNMF9wl7RCgfzPSOofgtqX6pzlsKpwdNwM8n7Jr92X9G/PCPYJoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714414458; c=relaxed/simple;
	bh=YCowSaEVxz5Th4+eEyP+ngkS+IVErBSdGo7rFV+gYM4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UH4btOrzuunelBNwgH9JOUiYU28+gBO1lhP7SPYUMBGg1qoetJFGZtENFnXkrox6T2gyOnMj6hKdRt3gLU2rAZTOWiYTuib1S/BsJLrUcFUUm05lbac23nLeoCGQ2RP3Yg94kLQAVEsKmcagykGTDLb3pwo/yxPnGEbKlVSDWV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Eje0KCDt; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7da3ec3e044so228350539f.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 11:14:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714414455; x=1715019255; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5U5Ovsd+M0JJ1E5zOP2YrAXuvUNDgcSQFNzhJAAl8DQ=;
        b=Eje0KCDtLkm5WDDkWq9uwedzpjwICh7ENWTFN3b+Ffd28RNHm3F4djae9mTfFUDR6v
         hcvaVu3KYE2UgcYF2DYOfIwcFfmLh/sqFhvh4AJfo0jw66xyV6lwqVRyrs7TO6ZcAB+B
         eMniB5z2L2P/4mkVEWJ/YEl9hfKGpeoafDAJQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714414455; x=1715019255;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5U5Ovsd+M0JJ1E5zOP2YrAXuvUNDgcSQFNzhJAAl8DQ=;
        b=KSqavuPiw1AnqLJOwtVuxU5L/wo2txpnZHHCE+NYRiovnR7p2xk/y1fjJYR0cj9pQ4
         yTKqDtuPv4fdDLYR9x+vxn+tbgx9BuH+tIh5qU92YYUgrzQ5ufJXQN5pRTsJHPRpMQ4G
         1p4vvA98AFEb0u4HSddfxMh6wzunSQBSPct0b5uB94HjykFrlnX9Gk/KVYcIc2zGwaH3
         QuKm/BtJoCabVqGCcexnLXT3PLao5JNjUI5ouk8/kSVMPgnugBmCuy8RHaTC+ZTK4FCm
         M/3YUWsSfh9ZWGXu3SK8Q+6EEowm77rrG9uLOhdBj8jeWcdY8ZuEQ9RR06UjHB6rMcGq
         vL/w==
X-Gm-Message-State: AOJu0Yy1sr4SJhYcHPSP3q9GrLKAlqn+BJHzXjuFSAIp9kc6N1p5fLGr
	hCWOKgl/66f5v4SpBpko5bmz8C69QltS3/wGKnJF92CD1SiG/UatRDQ7uE4OrWjZm4XLhfVNO9w
	=
X-Google-Smtp-Source: AGHT+IELaJ8zCPU56vHLqlO0m0JFHKddtNX1XApb9dDhvl4jX4rekMtYaF/Fr00J+p1noZD9iNJccw==
X-Received: by 2002:a6b:5814:0:b0:7d5:c00a:7d30 with SMTP id m20-20020a6b5814000000b007d5c00a7d30mr768321iob.8.1714414455464;
        Mon, 29 Apr 2024 11:14:15 -0700 (PDT)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id n21-20020a6b4115000000b007d05927cb31sm6068548ioa.45.2024.04.29.11.14.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 11:14:14 -0700 (PDT)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	stable@vger.kernel.org,
	Lalith Rajendran <lalithkraj@chromium.org>,
	chrome-platform@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v2] chrome/cros_ec: Handle events during suspend after resume completion
Date: Mon, 29 Apr 2024 12:13:45 -0600
Message-ID: <20240429121343.v2.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
command and irq disable") re-ordered the resume sequence. Before that
change, cros_ec resume sequence is:
1) Enable IRQ
2) Send resume event
3) Handle events during suspend

After commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
command and irq disable"), cros_ec resume sequence is:
1) Enable IRQ
2) Handle events during suspend
3) Send resume event.

This re-ordering leads to delayed handling of any events queued between
items 2) and 3) with the updated sequence. Also in certain platforms, EC
skips triggering interrupt for certain events eg. mkbp events until the
resume event is received. Such events are stuck in the host event queue
indefinitely. This change puts back the original order to avoid any
delay in handling the pending events.

Fixes: 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host command and irq disable")
Cc: stable@vger.kernel.org
Cc: Lalith Rajendran <lalithkraj@chromium.org>
Cc: chrome-platform@lists.linux.dev
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

Changes in v2:
- Updated the commit message with the right problem description

 drivers/platform/chrome/cros_ec.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/platform/chrome/cros_ec.c b/drivers/platform/chrome/cros_ec.c
index badc68bbae8cc..41714df053916 100644
--- a/drivers/platform/chrome/cros_ec.c
+++ b/drivers/platform/chrome/cros_ec.c
@@ -432,6 +432,12 @@ static void cros_ec_send_resume_event(struct cros_ec_device *ec_dev)
 void cros_ec_resume_complete(struct cros_ec_device *ec_dev)
 {
 	cros_ec_send_resume_event(ec_dev);
+	/*
+	 * Let the mfd devices know about events that occur during
+	 * suspend. This way the clients know what to do with them.
+	 */
+	cros_ec_report_events_during_suspend(ec_dev);
+
 }
 EXPORT_SYMBOL(cros_ec_resume_complete);
 
@@ -442,12 +448,6 @@ static void cros_ec_enable_irq(struct cros_ec_device *ec_dev)
 
 	if (ec_dev->wake_enabled)
 		disable_irq_wake(ec_dev->irq);
-
-	/*
-	 * Let the mfd devices know about events that occur during
-	 * suspend. This way the clients know what to do with them.
-	 */
-	cros_ec_report_events_during_suspend(ec_dev);
 }
 
 /**
@@ -475,8 +475,9 @@ EXPORT_SYMBOL(cros_ec_resume_early);
  */
 int cros_ec_resume(struct cros_ec_device *ec_dev)
 {
-	cros_ec_enable_irq(ec_dev);
-	cros_ec_send_resume_event(ec_dev);
+	cros_ec_resume_early(ec_dev);
+	cros_ec_resume_complete(ec_dev);
+
 	return 0;
 }
 EXPORT_SYMBOL(cros_ec_resume);
-- 
2.44.0.769.g3c40516874-goog


