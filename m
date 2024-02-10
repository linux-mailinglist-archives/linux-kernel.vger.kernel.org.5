Return-Path: <linux-kernel+bounces-60596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8149A850765
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:53:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55011C217BD
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:53:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D632E60ED4;
	Sat, 10 Feb 2024 23:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RPIx63a4"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB1860DDE
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609055; cv=none; b=p8w+kqPb5+Ml4woWBwO3+vQLhI6DWd19TM4ozKJxo2I34tbDz34zJfi+ggIBaOYP75QEhgRZUi87bG/QJbTAoY1GXfD9i7Jee9mFFrniDVWqEAIZz2BQFWapHeUWsw5zCUhjeZaw8gBnI7ezkBac3y3hMUTJIrEfz2LQAFbBJEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609055; c=relaxed/simple;
	bh=u2qVSn/FGDyWuMOo3N00MhELB4fJ8yoJ1hYXCFG65Mc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nfZQN9IfnQJdSEhWDVIDzql7sRKog9X2lrQGNPBNmDHb6WM1NeBrYHJf6F83XBymZcnbTJEb/zzHNL+59Kdf4odng80gBjgvvpZJG2Lc72WsFqT1zOOkCMH8UEWmkr+bn2UmtWsX9U45C7T3BqIJ3ut9xK7BF1wP9Fse0bdp61Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RPIx63a4; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-51185c33626so552146e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609051; x=1708213851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EK4jXgQTQp2lbOreR5SqRb2MAnJAgwo9xsz57it33Vs=;
        b=RPIx63a4o2BwKHCauRs0zajXqZzO05H87Cf197Aznr5wRPT9O11Fybmhyg29gUWolY
         YhutaMRuh+AfO3t5Uhrml1yY6WbA1DBPuJcz1y+QXqEMNzskS8fzZIyFHHWFIotVC3ex
         RTQ4rsOXdSE5Dr2mu5LW+YBu5PkdSbO4DATxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609051; x=1708213851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EK4jXgQTQp2lbOreR5SqRb2MAnJAgwo9xsz57it33Vs=;
        b=uwiqmM8j9Ntf3t0d4t+fSdrmiJyQdLq6CkKHCpGhe6nz4cMw+kEPGpVrmiec9aIcFl
         UTI70GeebWoDMfgYkTNkIBjN24ICQnTsmQxzpkEQ+uGS1qzr+sktaXVFJWncRziFCKbB
         hCELKDNgwkRQb6aNJoPNZzMcS2JkQm5r0CyFCgagygFpX7LquOLNgZJHxgegnQSdHHci
         SLnHY1K/7omhRI2R3vlfj7MuArHanrh1j7FqgC1Abn9iSUG5qaUidoQR7LWYEeOFWCra
         c15KH5vU1k65joiJe8z5/e4Js8v36CTFHdTkNcyH1JNnmwPMhCXhMb9GxBj4xs+vegWH
         T8tg==
X-Forwarded-Encrypted: i=1; AJvYcCXl7K9UygliWZpjECmNXGU1a0ReNbQ9Tpe+q5M+rYZtlOgOXZQ42ajESlwnmK3AeGoNJBBWZZY4nbyuOahTO1zL4Z4pO/cdhsCEBj3P
X-Gm-Message-State: AOJu0YzolMMSCgLU2vp5/sl8DKHHaymksmohi1jAI8u+ep/hYyU+9fJR
	v27owCWfEMLUNaX2iPXzUvsz3OJwzYTxDZFfn1v0ypERdiit+UuIUFq/kJ4y
X-Google-Smtp-Source: AGHT+IEstMixyEwWqeSZQ/X3zEh3uqpp8edbWB1NLAA+j80NFhwYDA2Z08WzFiZGNgSlObYsvjHjnA==
X-Received: by 2002:ac2:5dce:0:b0:511:6256:3b8d with SMTP id x14-20020ac25dce000000b0051162563b8dmr1861642lfq.5.1707609050996;
        Sat, 10 Feb 2024 15:50:50 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWz64HlI6AGfZ/sg9YFNQ4r9IRaz51l0COS2ktSKlNFhr7W0V+57It/68zPPZYOi3b+T58YayTS4SGlyBG2nUEe1Y21Sh8Bm0zI9Ha8QNRXWiywXUNoOKG9N2kk2sNiiqYyKuB2OxNEzcPftzzcsAWQbtVDX5duGKoxDPm74OqHlR7F1OU7IugwqXLroTdXyaGsPRxS08HfjuN5OsLMJAUy2baG3/pJmFxrtEVjTMoBrO0ackMCCE8PczEQM/dRT/sod0ZnpyQrnaxRmd5UcU/8EiWyY0FcAnFAreJ0WZOZlZIOOn+zIgy7k2XdoT00gSXbUnlFynhWTWYLnHMy8vEQOcneSeY9zJmqcI2bEDTz4p2yJwth2RC5648GHfWjc6IqsH03B1+7GZF9jBwZbWfD5M5b+nLxoIMQ3+97eEthTT6aS6jRXoz0gkiMuNz9eirm4heAEWkxcWSEgW/c7QVgvbRjhFyk/y5URbsZXHFSDHViwXIoXfdGo6KYYA7ZYm4jjaiw9v4BxpBrVFOeWqD+eF/zxISMwPR0mDJ8yb3yabnjEahZApNyoIVD1bDG/7xDgtBBwx8Q7NYgUbMyBHL1+EZiU7/Dg1kzXBGelg1+im5bFw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:50 -0800 (PST)
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
Subject: [PATCH v4 13/39] dyndbg: add support for default trace destination
Date: Sun, 11 Feb 2024 00:49:43 +0100
Message-ID: <20240210235009.2405808-14-ukaszb@chromium.org>
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

Instead of repeating trace destination name explicitly for each
command (e.g. +T:thunderbolt), this change saves trace destination
provided to last successful open command as default and consecutive
commands which don't provide trace destination explicitly will use
the saved trace destination.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 69 ++++++++++++++++++++++++++++++++++++---------
 1 file changed, 55 insertions(+), 14 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8a81356c52b3..f41b0b0c8b47 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -72,7 +72,7 @@ struct ddebug_iter {
 struct flag_settings {
 	unsigned int flags;
 	unsigned int mask;
-	unsigned int trace_dst;
+	int trace_dst;
 };
 
 #define DD_OPEN_CMD	"open"
@@ -85,8 +85,6 @@ struct dd_private_tracebuf {
 	int use_cnt;
 };
 
-#define DST_NOT_SET    (-1)
-
 /*
  * When trace is enabled (T flag is set) and trace destination field
  * value is in range [1..63] then debug logs will be written to trace
@@ -101,6 +99,9 @@ struct dd_tracebuf_tbl_info {
 	struct dd_private_tracebuf buf[TRACE_DST_LAST];
 	DECLARE_BITMAP(bmap, TRACE_DST_LAST);
 	int bmap_size;
+#define DST_NOT_SET	(-1)
+#define DST_TR_EVENT	0
+	int default_dst;
 };
 
 static DEFINE_MUTEX(ddebug_lock);
@@ -111,7 +112,8 @@ MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
 static struct
-dd_tracebuf_tbl_info trc_tbl = { .bmap_size = TRACE_DST_LAST };
+dd_tracebuf_tbl_info trc_tbl = { .bmap_size = TRACE_DST_LAST,
+				 .default_dst = DST_TR_EVENT, };
 
 static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
 {
@@ -147,7 +149,7 @@ static int find_tr_instance(const char *name)
 static const
 char *read_colon_args(const char *str, struct flag_settings *modifiers)
 {
-	int len, idx = 0;
+	int len, idx = DST_TR_EVENT;
 	char *end;
 
 	/* Check if trace destination was already set */
@@ -331,6 +333,24 @@ static bool dd_good_trace_name(const char *str)
 	return true;
 }
 
+static const char *get_tr_default_dst_str(void)
+{
+	if (trc_tbl.default_dst == DST_TR_EVENT)
+		return DD_TR_EVENT;
+	else
+		return trc_tbl.buf[trc_tbl.default_dst].name;
+}
+
+static void update_tr_default_dst(int trace_dst)
+{
+	if (trace_dst == trc_tbl.default_dst)
+		return;
+
+	trc_tbl.default_dst = trace_dst;
+	v3pr_info("set default trace dst to idx=%d, name=%s\n", trace_dst,
+		  get_tr_default_dst_str());
+}
+
 static int handle_trace_open_cmd(const char *arg)
 {
 	struct dd_private_tracebuf *buf;
@@ -382,6 +402,7 @@ static int handle_trace_open_cmd(const char *arg)
 	buf->use_cnt = 0;
 	set_bit(idx, trc_tbl.bmap);
 	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
+	update_tr_default_dst(idx);
 end:
 	mutex_unlock(&ddebug_lock);
 	return ret;
@@ -410,6 +431,13 @@ static int handle_trace_close_cmd(const char *arg)
 		goto end;
 	}
 
+	/*
+	 * check if default trace instance is being closed,
+	 * if yes then update default destination to '0'
+	 */
+	if (trc_tbl.default_dst == idx)
+		trc_tbl.default_dst = DST_TR_EVENT;
+
 	trace_array_put(buf->arr);
 	/*
 	 * don't destroy trace instance but let user do it manually
@@ -556,7 +584,8 @@ static int ddebug_change(const struct ddebug_query *query,
 			nfound++;
 
 			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			nctrl.trace_dst = modifiers->trace_dst;
+			nctrl.trace_dst = modifiers->trace_dst == DST_NOT_SET ?
+				get_trace_dst(dp) : modifiers->trace_dst;
 			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(nctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
@@ -845,7 +874,13 @@ static int ddebug_parse_flags(const char *str, struct flag_settings *modifiers)
 		modifiers->flags = 0;
 		break;
 	}
-	v3pr_info("*flagsp=0x%x *maskp=0x%x\n", modifiers->flags, modifiers->mask);
+
+	if (modifiers->flags & _DPRINTK_FLAGS_TRACE &&
+	    modifiers->trace_dst == DST_NOT_SET)
+		modifiers->trace_dst = trc_tbl.default_dst;
+
+	v3pr_info("flags=0x%x mask=0x%x, trace_dest=0x%x\n",
+		  modifiers->flags, modifiers->mask, modifiers->trace_dst);
 
 	return 0;
 }
@@ -1614,15 +1649,21 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	}
 	seq_puts(m, "\n");
 
-	if (ddebug_iter_is_last(iter) &&
-	    !bitmap_empty(trc_tbl.bmap, trc_tbl.bmap_size)) {
-		int idx = 1;
+	if (ddebug_iter_is_last(iter)) {
 
 		seq_puts(m, "\n");
-		seq_puts(m, "#: Opened trace instances:");
-		for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
-			seq_printf(m, " %s", trc_tbl.buf[idx].name);
-		seq_puts(m, "\n");
+		seq_printf(m, "#: Default trace destination: %s\n",
+			   get_tr_default_dst_str());
+
+		if (!bitmap_empty(trc_tbl.bmap, trc_tbl.bmap_size)) {
+			int idx = 1;
+
+			seq_puts(m, "\n");
+			seq_puts(m, "#: Opened trace instances:");
+			for_each_set_bit_from(idx, trc_tbl.bmap, trc_tbl.bmap_size)
+				seq_printf(m, " %s", trc_tbl.buf[idx].name);
+			seq_puts(m, "\n");
+		}
 	}
 
 	return 0;
-- 
2.43.0.687.g38aa6559b0-goog


