Return-Path: <linux-kernel+bounces-159150-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 866918B29FC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 22:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B80951C214CC
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:37:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65F272E642;
	Thu, 25 Apr 2024 20:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="VG7U1V8a"
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2241C12C7F7
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 20:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714077468; cv=none; b=dc3obx27d4AnVHbrtPV0+JPL8CGSqQV8BrXe7ABI/85al58rUOXtL498fVdWYsp7jV7Wmby1wJ4qngBxnmLX+5N8N8aPheyuL0XfaJ+NLA1+tu1+XHUM0M7q1LJsntkLAwhY/xHzSq/41/PZfx74lMRl2mR8yl3WSmqpcsiAb88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714077468; c=relaxed/simple;
	bh=jAg2VLHgH1tgYvqdC05z+fR+GClul15yoSWcnQ41OgA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lDf3TSev2z9G+FFAQ1yx/N0a/9+Jxg12XkAOqlApO0m7UxH6eRZxTMBfMsnsT1iUIHymKp/6yWoAfBxAY0FT+IoFYjjdwpL1Wmqk9wTLUMTib2GVtoB+Gn8xgNyWAL3E5VuVAxvby7cWxCpPPIQbRvcLWAKzdl+8/0S5OPUzKD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=VG7U1V8a; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-6184acc1ef3so14249147b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 13:37:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1714077465; x=1714682265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=7H8fihR3flAk+5cySZQjU2neMKCr+gYXjQpgANOY1yo=;
        b=VG7U1V8aCclK4i6un3SrmcMp/odlODPFRSAZPIEyLKVjl4dnFZDD3LLfU9l8EylEkc
         og7vmoG1RYsX0taGjQWpwRpvs/Oe0rwI/ziyZhg8dDlaJxrbyvzupnofq+ooSBZ7Pmb0
         ts8P4Qkcu+70pdciV3B57JZ7PTynPD2o/pJes=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714077465; x=1714682265;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7H8fihR3flAk+5cySZQjU2neMKCr+gYXjQpgANOY1yo=;
        b=DCUAM1FhZeC8xgoO9M7O0H84gXZ1rAVYfHWpOPj54vLmQJTByOwprwDkZ1WgWZRlUv
         nTN+IysWw6FfgrgM/1hL2+Ay9lDhT4oJ6kY5p+NOm/2Ku+Z3Kf/+zrvj1jWuPf6S32lI
         dCWj0HuUppT3vgaTjos8Dd2Q4B7YrXrnHBzKLz8k50t0hBTjNWw9nrgu04hRaJsvJkiM
         4n2imoiVBva63vlJDVSso2rI96oupu4mWeCv/9eLcc71EojjDBzzCNwlNmzJQgCJ3+w3
         0IUOS34eVtWCfS9LYPiE9LU5hkGzKErDvuvpswYGwsqXI6IOdyqguIVjS6c7REZIh2cv
         Z/FQ==
X-Gm-Message-State: AOJu0YxGJOj+PzqUpX5S8tdn7+IZUmVvqLv9FOkHbkVaT+dtoAtZJX2l
	S1h21qfJQbPTpJ1u/za1Jbl5IP6LzEaeACwxCgMtjYDPr/lrEszcxxEOGL1GqTEzQQhN81kvQxQ
	=
X-Google-Smtp-Source: AGHT+IHwwnnESpL5zc9UPq7mHXuKXY1TvTit2/7r6Skwh8KurCpi5AxNCfahS7Bg/lfE9pI15hgY1A==
X-Received: by 2002:a05:690c:6803:b0:61b:1e30:6362 with SMTP id id3-20020a05690c680300b0061b1e306362mr783742ywb.6.1714077465404;
        Thu, 25 Apr 2024 13:37:45 -0700 (PDT)
Received: from kramasub2.cros.corp.google.com ([100.107.108.189])
        by smtp.gmail.com with ESMTPSA id s31-20020a81451f000000b0061adfb01cc2sm3751113ywa.90.2024.04.25.13.37.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Apr 2024 13:37:44 -0700 (PDT)
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Karthikeyan Ramasubramanian <kramasub@chromium.org>,
	stable@vger.kernel.org,
	Lalith Rajendran <lalithkraj@chromium.org>,
	chrome-platform@lists.linux.dev,
	Benson Leung <bleung@chromium.org>,
	Guenter Roeck <groeck@chromium.org>,
	Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH v1] chrome/cros_ec: Handle events during suspend after resume completion
Date: Thu, 25 Apr 2024 14:37:11 -0600
Message-ID: <20240425143710.v1.1.If2e0cef959f1f6df9f4d1ab53a97c54aa54208af@changeid>
X-Mailer: git-send-email 2.44.0.769.g3c40516874-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On boards where EC IRQ is not wake capable, EC does not trigger IRQ to
signal any non-wake events until EC receives host resume event.
Commit 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host
command and irq disable") separated enabling IRQ and sending resume
event host command into early_resume and resume_complete stages
respectively. This separation leads to host not handling certain events
posted during a small time window between early_resume and
resume_complete stages. This change moves handling all events that
happened during suspend after sending host resume event.

Fixes: 47ea0ddb1f56 ("platform/chrome: cros_ec_lpc: Separate host command and irq disable")
Cc: stable@vger.kernel.org
Cc: Lalith Rajendran <lalithkraj@chromium.org>
Cc: chrome-platform@lists.linux.dev
Signed-off-by: Karthikeyan Ramasubramanian <kramasub@chromium.org>
---

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


