Return-Path: <linux-kernel+bounces-34555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 80292837F3B
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 02:51:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3A021C266ED
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 01:51:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7940129A85;
	Tue, 23 Jan 2024 00:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P+Mnl9nA"
Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4601292FC
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 00:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705971012; cv=none; b=ppih/Mx0nb1TkHq6HOwr7ptVNEsHGrrKjul9xz4sLdK7T41Diju7UtD3DVYlPMdC5pmHECyOMcEUbieWsysPb2YaWWvAFGJTZKK4JtBvAi9gysDJGc3U999J6zAILOIpugE70aDOwW5L8H+FA1gLVy26LmLIsk2xfHhnx7PgeWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705971012; c=relaxed/simple;
	bh=z1zpB2qqR0IBjDwv2KLwS6K9nwmw0h+fbzHKVoKHyN4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=diNpI01qGNLkls0vA+VN6c8hAIYRwrymYtzPoILk2/YTpHOwDt6WBpXvGJH64SwEeGh5j+gW//9Qt/waI7UwstML7n8Ojy52AE72KoPES+P5AAYVnZL7XHKKPEmE8bwdLyCS8+x/4SLTb3H+ubf6iKPvX7SdB33MpVRlc3LZKDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P+Mnl9nA; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-6dc6f47302bso628151b3a.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 16:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1705971010; x=1706575810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UvBYWd8ctJzu4aNLGaHJim5X1ADrbbpkxcKvf49QESc=;
        b=P+Mnl9nAFonmD0jfc0w3dDtc+L9WYZDzUQOMtrI5Bb8GIfQMI9LK+wrQGNuV6sh1Wi
         /r87+UOFOL8xwMTjE/2R1307nDbeQzPT4Y+iunsBP4AuAYZpIXtX1bb66RDDmJBZzclz
         CM+SOE7ZqmkFWTZ6hKJN331GHw5GrGKWjJCIk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705971010; x=1706575810;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UvBYWd8ctJzu4aNLGaHJim5X1ADrbbpkxcKvf49QESc=;
        b=lmrGvJ67C3elruoyXh2VJgGxt14zvMz3oAHRkLUCjstYdqQLmqNsBw0MM44EvHUhPb
         k5fVZ2cV2EaF5b//MY5zqxb9eC60kic+bNfccy+HTbZ2Au3FKzxVswydVzHqV3U9moEM
         GL10Ty1pj/yCa4s/iyilqNif4DcnUMCarPjfH4O9cYk5LB/+qNGSWrZteUt8L8lTarjF
         qsPGg6RvhEKEHo9oce3bcvY+TD5XjJ1tRL2VXvyS/V78nPUTYooXuONDx5yrT+DjdQcD
         CseI5R2lst9ImJCvxplhldzB3gzQaTdXIub1hVwgftlYhxRrMf8lzppUjpexk4y3HixW
         t3Eg==
X-Gm-Message-State: AOJu0YwCCvgPD4nrB3XRDx55k0MXD0GuiwsGDwolwD/0b93e7kTTnl4X
	KRu8YQfJLjqzy0Ca2zEztDOQE/QZkzCrbWVdGsILHVoJSAWzLhBEhtg7z6eLqg==
X-Google-Smtp-Source: AGHT+IFUSLU0pxz3z4sApet/3eeNisee40ljlMilHmT/v3uycphSqYcf1tjZIF+1gv19PBZ63Oi9LA==
X-Received: by 2002:a05:6a00:2e2a:b0:6db:b355:892d with SMTP id fc42-20020a056a002e2a00b006dbb355892dmr7718013pfb.2.1705971009946;
        Mon, 22 Jan 2024 16:50:09 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:6e04:285a:ab4d:3428])
        by smtp.gmail.com with ESMTPSA id y5-20020aa79e05000000b006d9ef76732esm10190912pfq.213.2024.01.22.16.50.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jan 2024 16:50:09 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Kees Cook <keescook@chromium.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Douglas Anderson <dianders@chromium.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] lkdtm: Make lkdtm_do_action() return to avoid tail call optimization
Date: Mon, 22 Jan 2024 16:49:34 -0800
Message-ID: <20240122164935.1.I345e485f36babad76370c59659a706723750d950@changeid>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The comments for lkdtm_do_action() explicitly call out that it
shouldn't be inlined because we want it to show up in stack
crawls. However, at least with some compilers / options it's still
vanishing due to tail call optimization. Let's add a return value to
the function to make it harder for the compiler to do tail call
optimization here.

Now that we have a return value, we can actually use it in the
callers, which is a minor improvement in the code.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

 drivers/misc/lkdtm/core.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index 0772e4a4757e..5732fd59a227 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -153,12 +153,17 @@ static const struct crashtype *find_crashtype(const char *name)
 /*
  * This is forced noinline just so it distinctly shows up in the stackdump
  * which makes validation of expected lkdtm crashes easier.
+ *
+ * NOTE: having a valid return value helps prevent the compiler from doing
+ * tail call optimizations and taking this out of the stack trace.
  */
-static noinline void lkdtm_do_action(const struct crashtype *crashtype)
+static noinline int lkdtm_do_action(const struct crashtype *crashtype)
 {
 	if (WARN_ON(!crashtype || !crashtype->func))
-		return;
+		return -EINVAL;
 	crashtype->func();
+
+	return 0;
 }
 
 static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
@@ -167,10 +172,8 @@ static int lkdtm_register_cpoint(struct crashpoint *crashpoint,
 	int ret;
 
 	/* If this doesn't have a symbol, just call immediately. */
-	if (!crashpoint->kprobe.symbol_name) {
-		lkdtm_do_action(crashtype);
-		return 0;
-	}
+	if (!crashpoint->kprobe.symbol_name)
+		return lkdtm_do_action(crashtype);
 
 	if (lkdtm_kprobe != NULL)
 		unregister_kprobe(lkdtm_kprobe);
@@ -216,7 +219,7 @@ static int lkdtm_kprobe_handler(struct kprobe *kp, struct pt_regs *regs)
 	spin_unlock_irqrestore(&crash_count_lock, flags);
 
 	if (do_it)
-		lkdtm_do_action(lkdtm_crashtype);
+		return lkdtm_do_action(lkdtm_crashtype);
 
 	return 0;
 }
@@ -303,6 +306,7 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
 {
 	const struct crashtype *crashtype;
 	char *buf;
+	int err;
 
 	if (count >= PAGE_SIZE)
 		return -EINVAL;
@@ -326,9 +330,11 @@ static ssize_t direct_entry(struct file *f, const char __user *user_buf,
 		return -EINVAL;
 
 	pr_info("Performing direct entry %s\n", crashtype->name);
-	lkdtm_do_action(crashtype);
+	err = lkdtm_do_action(crashtype);
 	*off += count;
 
+	if (err)
+		return err;
 	return count;
 }
 
-- 
2.43.0.429.g432eaa2c6b-goog


