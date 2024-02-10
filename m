Return-Path: <linux-kernel+bounces-60597-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4A5850766
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:53:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 116201F21460
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E2460EC1;
	Sat, 10 Feb 2024 23:50:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="P0YfpGtR"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9831060DD8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609056; cv=none; b=LICE+LxI1DtWCo7H0vYfSFlhZAY/n1/UUXyQ+cKcQLqr/9LEOzgq+Ljex2j9NoM5K7bl+nNQY32r1BXl/qAIw/EDiN48EpjGrjaGHhBY85SrX6Gk6493uj+C+wKy/QaERXQvIKbTDcVbE8Z/VaDsLiXa6js/Vu2Xub3GztsrCIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609056; c=relaxed/simple;
	bh=svE0ydmRhksE61Jfxvr6jlgMjC0XYATtTVPi+1xPOKE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UMj1Exgd72kIgQ1WIDXDErtx9Eg9KfC4wX0EZKaZ2gCkoJc3AvFTp4ZklyARPxZcr4xs8G9QLQFxogQ2P+NUP11ft0yAfcL4p3EMUC4sSkXaw3TjMb5rJGEvn6mm5a6xu1Ou06uhXcu4/kKYLLw7JK5RLAz+yF76+LBslgkIOGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=P0YfpGtR; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5116b017503so2861643e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609052; x=1708213852; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=m0C7d9TR7oCLKiGX51PIEVgdXmMwdwdVpasUDDkUmDA=;
        b=P0YfpGtR2+eCi0IIqVbftRscTbJjJy9hrTF50DkXLhGDGBB8vXd2gzdGHxvwpq4ToS
         q3DcKqQhXCgHCKy77xnV10SoTTpvfB1PXBWeyimoyvLmmAezJNEJlW0loNLHzajq5hyl
         b3zwJ5zmuVuxYE5qPUr7eB/XBofXzUC5xHMr4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609052; x=1708213852;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=m0C7d9TR7oCLKiGX51PIEVgdXmMwdwdVpasUDDkUmDA=;
        b=ZXhV42CfC/una1z/IIdLmX9NtpH19g664nNPbmvTS60dmfjTWmnD29zKmBgvf3gy2C
         Xz8IP8NjK2qidh5fwaEscRPvko4E3QUvfWPSpOqLlputyvYPpcwK1MMCOBqnZQcJyqcs
         Vm/tgjxfDEEXmB2exJgn5+Vx2C6u/HtISQuJjQ8fFeOFnJkQ1g+74ua2t8kj0fbC2HiH
         kI3nBV6seJ5wlz7fwlEmZF7N9Ew2YjmaMqT/KYEupIYYErEd0zkaTjXae5jrx9qUoxyU
         FexfifUN9ZaF8vtUVSWwUXlLQCHcfXC8EM+huYQSHsYiijpQ9wbebQU/jwK2+C1ohvB6
         3FAw==
X-Gm-Message-State: AOJu0YzvresigdUUC1aNpW+/bH923tfwQsSZQCuKcB1THY04OjA/7CbW
	wIJbcPpQXoPhBK3qPLWmzJD8OSYt6cLwLGZ5LfoUDGKeBUG2DhK2Hw38ldyS
X-Google-Smtp-Source: AGHT+IEIbw/XCToXLpf+OkOAOuRLJfOBDrTKrkFy6DU+9DPONycq9b/4rur93hA5h94ftG6KWNVEDg==
X-Received: by 2002:ac2:5dc8:0:b0:511:62ab:5f03 with SMTP id x8-20020ac25dc8000000b0051162ab5f03mr1878907lfq.60.1707609052801;
        Sat, 10 Feb 2024 15:50:52 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWfdpieG7Xq0wJgEwvOp+MkQV8u/MwIyUikMGTNVVNK+dwp70vbTGfyuvR/QCLrvUxKN+egISXAcQRkIktfSY9x02li3nO+Dwlg91zKlh2LiY4awAbjA35s4xGLTsTJEZbZ4VfNHcstvRhRKHv1BmtBIWQx52FEDhNHxH7RqkhP5KOiEqGxzzKaIlovMvMkP+2clrjrnab/+TshTe0O6uT9G1FYmSRycqbWUwFmvSQmxXZVwtx8pBRi+rQGxtyT5yu4ksJ8Aj+zacXk7OU6VOgz6UFc+HC6klD7wtgOrSrFr0rBqPfXXoaC4rQeaKibU4+bnyahEvFkgoOJM61CzUqetuejAP0EQvH+iX7l/UuDlHYoUx7B1J72ndUNEGNtiUmDYbao2iG9+ibQF5RLGXzQnbZsYR5b3ZtRXDl39hdFtNfb6O/Pek8c0w9I9kvMMMDO5QLY4cNTWbZ7wf++Zh77gPd3LNye+3H/0gZUbgNs6/mzmkQ6LTD17bYozOMTJW2HPSYY/cuxfREu78CGiBqM3O9dVWdPYbH/6e1jvHD54Hj0CA1zXj+WNj3hP3KzBWk3cdPt6xTT+N+MqHZRUXz+/dXuq2xnnwoeax6k/NYcmpkAig==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:52 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <ukaszb@chromium.org>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Kees Cook <keescook@chromium.org>,
	Douglas Anderson <dianders@chromium.org>
Cc: Guenter Roeck <groeck@google.com>,
	Yaniv Tzoreff <yanivt@google.com>,
	Benson Leung <bleung@google.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Pekka Paalanen <ppaalanen@gmail.com>,
	Sean Paul <seanpaul@chromium.org>,
	Daniel Vetter <daniel@ffwll.ch>,
	Simon Ser <contact@emersion.fr>,
	John Ogness <john.ogness@linutronix.de>,
	Petr Mladek <pmladek@suse.com>,
	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
	linux-kernel@vger.kernel.org,
	upstream@semihalf.com
Subject: [PATCH v4 14/39] dyndbg: update default trace destination on reopen
Date: Sun, 11 Feb 2024 00:49:44 +0100
Message-ID: <20240210235009.2405808-15-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The change updates default trace destination when a user requests
to open '0' ('0' writes debug logs to global trace-events buffer
/sys/kernel/tracing/trace) or open an already opened trace instance.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 20 +++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f41b0b0c8b47..f91c51234456 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -354,10 +354,21 @@ static void update_tr_default_dst(int trace_dst)
 static int handle_trace_open_cmd(const char *arg)
 {
 	struct dd_private_tracebuf *buf;
-	int idx, ret = 0;
+	int idx = 0, ret = 0;
 
 	mutex_lock(&ddebug_lock);
 
+	/*
+	 * request to open '0' or an already opened trace instance
+	 * results in update of default trace destination
+	 */
+	if (!strcmp(arg, DD_TR_EVENT))
+		goto update;
+
+	idx = find_tr_instance(arg);
+	if (idx >= 0)
+		goto update;
+
 	/* bit 0 is not used, reserved for trace prdbg and devdbg events */
 	idx = find_next_zero_bit(trc_tbl.bmap, trc_tbl.bmap_size, 1);
 	if (idx == trc_tbl.bmap_size) {
@@ -371,12 +382,6 @@ static int handle_trace_open_cmd(const char *arg)
 		goto end;
 	}
 
-	if (find_tr_instance(arg) >= 0) {
-		pr_err("instance is already opened name:%s\n", arg);
-		ret = -EEXIST;
-		goto end;
-	}
-
 	buf = &trc_tbl.buf[idx];
 	buf->name = kstrdup(arg, GFP_KERNEL);
 	if (!buf->name) {
@@ -402,6 +407,7 @@ static int handle_trace_open_cmd(const char *arg)
 	buf->use_cnt = 0;
 	set_bit(idx, trc_tbl.bmap);
 	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
+update:
 	update_tr_default_dst(idx);
 end:
 	mutex_unlock(&ddebug_lock);
-- 
2.43.0.687.g38aa6559b0-goog


