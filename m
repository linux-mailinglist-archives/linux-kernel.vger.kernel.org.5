Return-Path: <linux-kernel+bounces-60594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48BD2850763
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C834B1F216FA
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AC9E60DCE;
	Sat, 10 Feb 2024 23:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="M9RUtWqF"
Received: from mail-lf1-f65.google.com (mail-lf1-f65.google.com [209.85.167.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8405960B95
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609051; cv=none; b=Cwt9ksBEJJ6OPv3CbeVFJegy9szeXTJmwrmzCpm+qITI6NsuDXl+xQZ8zSydLhPlG9pgNPAoifjw4OyU0Dzc44Nt4OtGl/UklkMPuw+dc0ufs923KRnQOqlMI6W6WC3akeGzW1sGBxQ207vc6jlZGAtgtSKNPKcgqPkBTvklH0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609051; c=relaxed/simple;
	bh=Q12PHdJJNT6cHmzxSgqa8vX7kdu2nXbasdwo0iTu/C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=omRkYFqhbgsu0KlcttnZIu9SdBYz/oP56QYA6skxxXcTjk8Cvxr+3fwyo4Upe/CVpna0H0b8+Qsqyg5rLQxB2aEYCX2jB/Tjn/ByttyrrjkN7lpboDsWpihJvfXdyIzVWfkC3Qx0Ne5QU0tjUZzYFlUv89uT2ARj0UKm4tNkp2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=M9RUtWqF; arc=none smtp.client-ip=209.85.167.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f65.google.com with SMTP id 2adb3069b0e04-51167e470f7so2650892e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609047; x=1708213847; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=457Ak5D/cnjLkQBnQYpRWcf9B+gpaO4d0gKyEUhhPYE=;
        b=M9RUtWqFgbfNjL/ujjQKLYU58wc9EE6hmHq9m6CiyVWgKtD7VxiGti44i/3fPYLL16
         z8aLItMeLvn1Hyalj4fOX6uzq8ec8gmVYJndgdWmijAzCYBP6AYJKtXreeM/i2//DKcT
         eC4l2FQqoyeZZwewlVjoJszMHqcdfE4oNqwuo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609047; x=1708213847;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=457Ak5D/cnjLkQBnQYpRWcf9B+gpaO4d0gKyEUhhPYE=;
        b=qedTKKZcoR26edBZHrBnS78DJhb4oji+Ml2j0GCszOxPYR2EP/HpAP2EJWbXOA6QYI
         Ai5n8wOdmcMDRCiEtHB18crze/0Zq/kVsLGoWkETz7CKlllPVGbQWgL1D5se6mJIJBk+
         DLGvvDeBY2tRNau5wvO9YgoMxic5b3cAIohUwgMl96QsbZPb+76ss2R1jO163xQwS07A
         ENEXRCkONh4acwmyAntb1DGum24tQGU1A1G3wZ2yRMQ3Zst6IipAbQGO3c9V0BBDJ9XH
         OWt/7syBNUw2dWlTs5X/IRVli/q/Bc+GZKCf2XXnQdmYX7gFV7/klU9sEx5AE7qe8IRy
         Z2FA==
X-Gm-Message-State: AOJu0Yze5yprBJfTistUbzVxXSjGm3+tOX+YMz9X0ksXE+bL1zBT6DoE
	fafqME8sjmoSj39zBuinWWJSxawIyF5/lXiUP+UNTlQmMMoSzno5jCrNc5Sw
X-Google-Smtp-Source: AGHT+IF2WK1Sqffff5PRQjQ9LGF5zxyr3gIbv8QLdCy7WpmHqkqPSkC53Mu1MWGOy6JV6ZHSb0yKrQ==
X-Received: by 2002:a19:7506:0:b0:511:82a9:d1ba with SMTP id y6-20020a197506000000b0051182a9d1bamr1457500lfe.28.1707609047708;
        Sat, 10 Feb 2024 15:50:47 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW5raDEuSR4hlFmQbaPuUFU4U8r0QGr8yRF5A8pn4yL7EjCSmrvGldSg/Vy19lmZaBy+BKzxBQuiYTaQcreViEjFFImhUvmVpfNLo33gr2HMooqImQOycKUXFwISZAoC2LL+7cM/+fhFeJHpyrU/EU7rKzrnNl5wzuJzoY6JcM6qvi5eRe4E04nLrIKT6A42tPYtsL7po0+yrgEPnzx5enJ8Cncytm6iuw+bg120c8soKGLxAn0MCR2Pwjc16IxvIOsg0+z6BPbXWrkkDhN+WqZq58jZsYOedfiidvpEYQHz8Mw2uTpT8Rd0nnQaniDcPoRZRpXPCLY1jaoRoKVgPb1pijLsiL+k035seqfeWWl8JNSuZ4GYHSEZPtd9p4a8ZjpjKHfPJWDydaFJ5yqVMxZpj3BQ2F2GyV9TvgP0OEWXpxOv6Jexnof8/B929zA+MIlvy4GxbgUQWHAm1mvG+Te/e3zOcS+kgjENNNRKRG0WZFvLYzp1CqhAqFhdeCzM/MhwwUJK7roJu84fAuFrPvagLBcdLj3y0mE+vGIoiI9hxhLnPU4jzmSsZsT0SzShc9xEIPgmtn7FqGc7lXff2IjHezQbhOQgWKmhOj9aWewVW1vZw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:47 -0800 (PST)
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
Subject: [PATCH v4 11/39] dyndbg: don't close trace instance when in use
Date: Sun, 11 Feb 2024 00:49:41 +0100
Message-ID: <20240210235009.2405808-12-ukaszb@chromium.org>
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

Don't allow trace instance to be closed when it
is still being used by at least one callsite.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 35 +++++++++++++++++++++++++++++++++++
 1 file changed, 35 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index d0d1057911e8..6668f265f2c3 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -81,6 +81,7 @@ struct flag_settings {
 struct dd_private_tracebuf {
 	const char *name;
 	struct trace_array *arr;
+	int use_cnt;
 };
 
 /*
@@ -279,6 +280,7 @@ static int handle_trace_open_cmd(const char *arg)
 		goto end;
 	}
 
+	buf->use_cnt = 0;
 	set_bit(idx, trc_tbl.bmap);
 	v3pr_info("opened trace instance idx=%d, name=%s\n", idx, arg);
 end:
@@ -301,6 +303,14 @@ static int handle_trace_close_cmd(const char *arg)
 
 	buf = &trc_tbl.buf[idx];
 
+	WARN_ON(buf->use_cnt < 0);
+	if (buf->use_cnt) {
+		pr_err("trace instance is being used name=%s, use_cnt=%d\n",
+		       buf->name, buf->use_cnt);
+		ret = -EBUSY;
+		goto end;
+	}
+
 	trace_array_put(buf->arr);
 	/*
 	 * don't destroy trace instance but let user do it manually
@@ -321,6 +331,22 @@ static int handle_trace_close_cmd(const char *arg)
 	return ret;
 }
 
+static
+void update_tr_dst(const struct _ddebug *desc, const struct dd_ctrl *nctrl)
+{
+	int odst = get_trace_dst(desc);
+	int ndst = nctrl->trace_dst;
+
+	if (odst == ndst)
+		return;
+
+	if (odst)
+		trc_tbl.buf[odst].use_cnt--;
+
+	if (ndst)
+		trc_tbl.buf[ndst].use_cnt++;
+}
+
 static int ddebug_parse_cmd(char *words[], int nwords)
 {
 	if (nwords != 1)
@@ -447,6 +473,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(get_flags(dp), &fbuf),
 				  ddebug_describe_flags(nctrl.flags, &nbuf));
+			update_tr_dst(dp, &nctrl);
 			set_ctrl(dp, &nctrl);
 		}
 	}
@@ -1628,6 +1655,14 @@ int ddebug_dyndbg_module_param_cb(char *param, char *val, const char *module)
 
 static void ddebug_table_free(struct ddebug_table *dt)
 {
+	int dst, i;
+
+	for (i = 0; i < dt->num_ddebugs; i++) {
+		dst = get_trace_dst(&dt->ddebugs[i]);
+		if (dst)
+			trc_tbl.buf[dst].use_cnt--;
+	}
+
 	list_del_init(&dt->link);
 	kfree(dt);
 }
-- 
2.43.0.687.g38aa6559b0-goog


