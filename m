Return-Path: <linux-kernel+bounces-39002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9B183C98B
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 18:13:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D5F3EB273D2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 17:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B88613E204;
	Thu, 25 Jan 2024 17:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SltX3Bu8"
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6EC513DB9F
	for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 17:06:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706202400; cv=none; b=qefLeuBQ9qOYSlyPwQ7fvO7HVtt72k/Ib6yMNnPIZnFlLu1lJJ17mE18ZgYrKGcp9FSdaNZD1BqrWLfej1OuWTy7ELNnqOqo1piywAUc7ndYVYbsLHARJNMFrtnfoHVsiToJhKWYM24KoehoRlX1YX/jKIgm6MoqWVd6i5HtZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706202400; c=relaxed/simple;
	bh=hED5zrI3UrH0UYfMBH7POtW6cuafV983xIchlmTIsO8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbYvtDN5OS/9J/rLT86wVrIxevmO0TZ3zw0W/lk4d6m5RgntyfBz9SJXWf9+mM/YDA1DvmzourRCSsdayeN4JkHmaSblCxtr7FekzSkr7iSrhFYiFS7BBtfxc9nwPy8ZLfqdvZx7r7riBK0C8702Zj+M+0uIiDLVWfsxQhWY2X8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SltX3Bu8; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-6ddb1115e82so1358197b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jan 2024 09:06:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706202398; x=1706807198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i22V5Ay/0Z0t7iq3fz0jQVVN6iBSQa9KI6LeZOPw1Yk=;
        b=SltX3Bu8cgBDI42r1yEp65jeLMFenAcma98Vyw7ydX5eZAaZf3kQSv+JO+O+ZIiSK3
         Zwv4IYUJdg028thXVIjJ8gHD5N4ap2RED88WKgU14VVPvGrq22JfouIdXCcHWOUDtTu/
         gv79tjMMj93WhOrpQ8p9Mh1EGeH2Ccx0kcK0Od8zAPUo0+fTttRW5ATHAIg+O9acWPI8
         MF0ffuAVp5MAJfL5UmwrWD8XZeiIhOmPDQwqRiO0wnhGezhLLZZFu5hlOmwr+QkoafaP
         BFwjx7twU80JWSzRIcp9pKCrR5iOsRYmgrayQmFOra5e3YKo4L8tYxOJh1kRUbb2u4K3
         oz7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706202398; x=1706807198;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:sender:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=i22V5Ay/0Z0t7iq3fz0jQVVN6iBSQa9KI6LeZOPw1Yk=;
        b=YIXfzyCraL4IL9l0OjKzNPtT2kK24NPT1YKpsvNZRsHV6IEdPM7dBcsR/ZoTLMbNes
         15una8Fci1eQDYZ31gfYhSeshnKtL5lZt51LXkiWV5xQSS2kxPh0nduasGO6TQIZvNoS
         9kkLVYcCz8L82nzLxUGOCCSofqsrlTkzLbXQf6Yp8C5rvrfpc2D1j8X9Wbjs5i7vQW8p
         ooQ64ueMmlv+RGmavvB6kC8b4nr8kvbo4cW3UGOa/zEcJw2YFWXzZQvU2Zc4OBqFUUK0
         PgPval23nfzG3v3kxxBEyToOBhdD+Ew9zOzNaVivYYanzvnbDWGLItL1ZZy7qPXkz26G
         HvfQ==
X-Gm-Message-State: AOJu0YwH3UQgb6v322GDWebPzATB64ERvsrL6IEtzS7Zv4M3C0nIbnNG
	5ECxHX38EsHBExzY6BlfO4wMFZLo6+hAUjf6HqXYKfUn9uZsDRdp
X-Google-Smtp-Source: AGHT+IHIhX/8MvL2ACEffitwLq5QmCF53YPogxuMDbG/YXK53M2laAmvEMEAni38xxf++M4+Iptkgw==
X-Received: by 2002:a05:6a00:87:b0:6d9:bbac:a34b with SMTP id c7-20020a056a00008700b006d9bbaca34bmr9798pfj.14.1706202398087;
        Thu, 25 Jan 2024 09:06:38 -0800 (PST)
Received: from localhost (dhcp-141-239-144-21.hawaiiantel.net. [141.239.144.21])
        by smtp.gmail.com with ESMTPSA id r24-20020a62e418000000b006ddc7de91e9sm1910091pfh.197.2024.01.25.09.06.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 09:06:37 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
From: Tejun Heo <tj@kernel.org>
To: jiangshanlai@gmail.com
Cc: linux-kernel@vger.kernel.org,
	Naohiro.Aota@wdc.com,
	kernel-team@meta.com,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH 05/10] workqueue: Make wq_adjust_max_active() round-robin pwqs while activating
Date: Thu, 25 Jan 2024 07:05:58 -1000
Message-ID: <20240125170628.2017784-6-tj@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240125170628.2017784-1-tj@kernel.org>
References: <20240125170628.2017784-1-tj@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

wq_adjust_max_active() needs to activate work items after max_active is
increased. Previously, it did that by visiting each pwq once activating all
that could be activated. While this makes sense with per-pwq nr_active,
nr_active will be shared across multiple pwqs for unbound wqs. Then, we'd
want to round-robin through pwqs to be fairer.

In preparation, this patch makes wq_adjust_max_active() round-robin pwqs
while activating. While the activation ordering changes, this shouldn't
cause user-noticeable behavior changes.

Signed-off-by: Tejun Heo <tj@kernel.org>
---
 kernel/workqueue.c | 31 +++++++++++++++++++------------
 1 file changed, 19 insertions(+), 12 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 6a0ce3a3cca2..bfb6e951852a 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -4707,7 +4707,7 @@ static int init_rescuer(struct workqueue_struct *wq)
  */
 static void wq_adjust_max_active(struct workqueue_struct *wq)
 {
-	struct pool_workqueue *pwq;
+	bool activated;
 
 	lockdep_assert_held(&wq->mutex);
 
@@ -4727,19 +4727,26 @@ static void wq_adjust_max_active(struct workqueue_struct *wq)
 	 */
 	WRITE_ONCE(wq->max_active, wq->saved_max_active);
 
-	for_each_pwq(pwq, wq) {
-		unsigned long flags;
-
-		/* this function can be called during early boot w/ irq disabled */
-		raw_spin_lock_irqsave(&pwq->pool->lock, flags);
-
-		while (pwq_activate_first_inactive(pwq))
-			;
+	/*
+	 * Round-robin through pwq's activating the first inactive work item
+	 * until max_active is filled.
+	 */
+	do {
+		struct pool_workqueue *pwq;
 
-		kick_pool(pwq->pool);
+		activated = false;
+		for_each_pwq(pwq, wq) {
+			unsigned long flags;
 
-		raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
-	}
+			/* can be called during early boot w/ irq disabled */
+			raw_spin_lock_irqsave(&pwq->pool->lock, flags);
+			if (pwq_activate_first_inactive(pwq)) {
+				activated = true;
+				kick_pool(pwq->pool);
+			}
+			raw_spin_unlock_irqrestore(&pwq->pool->lock, flags);
+		}
+	} while (activated);
 }
 
 __printf(1, 4)
-- 
2.43.0


