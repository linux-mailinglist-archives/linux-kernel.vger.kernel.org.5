Return-Path: <linux-kernel+bounces-34556-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F224837F3D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100201C20CDC
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DD3F5129A9C;
	Tue, 23 Jan 2024 00:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="PqnwYr0+"
Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82CE129A86
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971014; cv=none; b=tpLw/nlkpE0l5bjBefeDtAmpbgdCND2cjsXN0FA7w9eiubqy5KIjafgX29zMVNj+9F8Q2CdOiRLZfy7l2ibQ02+lXJINBKDjhmoYTs+SG45zKLHg3F9ragDfXb+h/wnz6eepNsHMML7JGvC6tEIpkEV7XaUzmKgzZeERU86zvFk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971014; c=relaxed/simple;
	bh=sL4bxvnrXWPZkUyOQMK2D+DPl/Ah5bGRWYZLBAO9F2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScxZ0d7xMbztFPhbuvQBOMbD3ubwj5pWEwgEjlC0ouK0CpS509Zs+0hy+ctKVZQs3nJa908ad/A/hUcOBptioTb+dzdNYuxZDWM6MNSgrFl//g1o7tDblbFOkHRtNlht+67CVzlMlmAVj5SfR7MWQHlZFb1meuLRSTzxLBQ8UME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=PqnwYr0+; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-3bbbc6b4ed1so2617655b6e.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:50:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971012; x=1706575812; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gcI3IZKj7A7EP+PZYroCXqSoSDvWd+f5jhzLQV1RU3E=;
        b=PqnwYr0+OR5sI/TadHmxg50AWg+LUQtxDu5UiI6C7Al9kg7HZg16R7jXjRMF0SxSkc
         obly3qJjZIm9VGxW/jGpy6OYJ6EMzUu5pvHYq16C049HS1Fbo0WUE+c6yU5SlzJNdleA
         nqX5U3edXWN4J5LzAyhwxuoIkVGExdB5f7bJA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971012; x=1706575812;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gcI3IZKj7A7EP+PZYroCXqSoSDvWd+f5jhzLQV1RU3E=;
        b=l1zAW4TYz7qqk+QKQqgvCVynSaPVnVrdG+BKmct29f4w/MbZ1nzTncin2krk+CDiX+
         LCMdq5aJLYQHQDhfPlnwuWI03HepFseI8dCnWtWuPMt7wRR6tLCnVKy1kDR4wig/iaNE
         NOvKMxzzovw3rOOq4Ln0ocDar7subNdDYaTIghCAZvFR/c1Di/PriI31dBvtPaky7rDu
         F0JcrZRTghqTg0Nau8muOa7kvTldGgfCqGtjWsLTme2rpGkCZ1iFjq1u45qt0T0ERBBQ
         QDFMbbP75FO2VdFpYkN9mliGULr2RxitOOMxRa+ZI/IC+AL/8z/OfRtrt+cLOqFuO/35
         owWw==
X-Gm-Message-State: AOJu0YwqjiPy4+pK9anJQ/MLi5cA5RLXITjCeyHMDzrCr9IbIIBq8fkN
	+OCrOVHAcxS3/td1fG3Zt/Sw8fLB2z5YVhjQyaYtmAY7GF6di0jwSEvBNCqckjmaasoMhZQdocy
	rph+2
X-Google-Smtp-Source: AGHT+IEj5oN1tZ5nq/1AssMHsp4hfJxyqt8VRwDbHjaYxdV25yIawlpMpMUefTaT89ICwWqHXaUWbA==
X-Received: by 2002:a05:6808:1a08:b0:3bd:c4ce:a87b with SMTP id bk8-20020a0568081a0800b003bdc4cea87bmr252245oib.43.1705971011765;
        Mon, 22 Jan 2024 16:50:11 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:6e04:285a:ab4d:3428])
        by smtp.gmail.com with ESMTPSA id y5-20020aa79e05000000b006d9ef76732esm10190912pfq.213.2024.01.22.16.50.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:50:10 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] lkdtm/bugs: Adjust lkdtm_HUNG_TASK() to avoid tail call optimization
Date: Mon, 22 Jan 2024 16:49:35 -0800
Message-ID: <20240122164935.2.I26e8f68c312824fcc80c19d4e91de2d2bef958f0@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240122164935.1.I345e485f36babad76370c59659a706723750d950@changeid>
References: <20240122164935.1.I345e485f36babad76370c59659a706723750d950@changeid>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When testing with lkdtm_HUNG_TASK() and looking at the output, I
expected to see lkdtm_HUNG_TASK() in the stack crawl but it wasn't
there. Instead, the top function on at least some devices was
schedule() due to tail call optimization.

Let's do two things to help here:
1. We'll mark this as "__noreturn". On GCC at least this is documented
   to prevent tail call optimization. The docs [1] say "In order to
   preserve backtraces, GCC will never turn calls to noreturn
   functions into tail calls."
2. We'll add a BUG_ON(1) at the end which means that schedule() is no
   longer a tail call. Note that this is potentially important because
   if we _did_ end up returning from schedule() due to some weird
   issue then we'd potentially be violating the "noreturn" that we
   told the compiler about. BUG is the right thing to do here.

[1] https://gcc.gnu.org/onlinedocs/gcc/Common-Function-Attributes.html

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/misc/lkdtm/bugs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index b080eb2335eb..d1222d3eda2f 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -294,10 +294,11 @@ static void lkdtm_SPINLOCKUP(void)
 	__release(&lock_me_up);
 }
 
-static void lkdtm_HUNG_TASK(void)
+static void __noreturn lkdtm_HUNG_TASK(void)
 {
 	set_current_state(TASK_UNINTERRUPTIBLE);
 	schedule();
+	BUG_ON(1);
 }
 
 static volatile unsigned int huge = INT_MAX - 2;
-- 
2.43.0.429.g432eaa2c6b-goog


