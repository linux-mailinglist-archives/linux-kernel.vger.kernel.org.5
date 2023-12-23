Return-Path: <linux-kernel+bounces-10171-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 044A281D108
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 02:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 255321C210A9
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 01:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF7DDD9;
	Sat, 23 Dec 2023 01:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=semihalf.com header.i=@semihalf.com header.b="E7pFhVrk"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE742D314
	for <linux-kernel@vger.kernel.org>; Sat, 23 Dec 2023 01:52:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=semihalf.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=semihalf.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-55322dbabf6so2522428a12.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 17:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google; t=1703296329; x=1703901129; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Un40+94h5VRdMg5VfaQgh05to2gMxKh526dXQbalmzg=;
        b=E7pFhVrkyu9eIMpbSSlk2mTtmqTh3/3/SSb9v9+MVWNxZ6YTROuwHn4DmeEiB1G5dz
         m8ly8rkIdgSYwZBNcJoSWI3JzL5S4qXWiXi4rtMcuRoNVsQbTG3+vjY1fLvwLQYcllG+
         drXm9Tev2wU5D/nwQ4Bh7sD3j7vyXVD5DyX9TANggARtJVl0kKoMAYJwuzKD0VyVbp1Y
         6K5/SUT1b7UKfPm4FbY5zJkd7oWMtNqbQ+UbC2DunLCV3Y64igdUtu/hXeDtmmXQPZRt
         cSxEjrRpX7J8ry2G7SsNHOnA/wl4tS/rzd05LAN3nF9jcDp2Q/4igvuP5B4KQdSipvBH
         rmgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703296329; x=1703901129;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Un40+94h5VRdMg5VfaQgh05to2gMxKh526dXQbalmzg=;
        b=gtmOKvDEsv157apnjvPsjXOtS4VmAghuw1WTJqxjs3bxWmujJ8eG16uXi5yjFESaSL
         w76CxtMjkHeJT5bzykNnzzL/U6vmcwXPwUH/IOUxybGlm/LMb1WYh72EEoElDiFIqXH9
         sY2IVk69uK9Pqv5TBE5FQC68dvv4RQU94ypfu1vJwrzw3PcTBm27mw4Qofv+r24uSDiJ
         b7hpANL8mElGmptZEM2C+4XuTAg/Tu6E4h9Xm8Yb85Qv7zHfLmz3rKerw8msFRuk9nSq
         M+W48SJGZJdezm8SmpLBVnryHSczf4dB+oX81Ihq4Hhn8rdbqwCALKXSfoZ+g7As5B12
         vWSw==
X-Gm-Message-State: AOJu0Yxo1juWsWfiX1yn4xJg0urXqganCgOmEpcTXurrKED6GSW2N56I
	fhm5ugw7Tzw8M5NgD1em1ySc+UeDj3Bh
X-Google-Smtp-Source: AGHT+IE9n1NheClx7UD5YVGfJ+ZQ+Eu2FCoQOTC1SlSd6haTVb072VksFHZ1rLN51WIORMPRcEdrww==
X-Received: by 2002:a50:9992:0:b0:553:6348:7360 with SMTP id m18-20020a509992000000b0055363487360mr1173719edb.4.1703296329211;
        Fri, 22 Dec 2023 17:52:09 -0800 (PST)
Received: from ukaszb-l.semihalf.net (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id h2-20020a0564020e8200b005532a337d51sm3288494eda.44.2023.12.22.17.52.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 17:52:08 -0800 (PST)
From: =?UTF-8?q?=C5=81ukasz=20Bartosik?= <lb@semihalf.com>
To: Jason Baron <jbaron@akamai.com>,
	Jim Cromie <jim.cromie@gmail.com>,
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
Subject: [PATCH v3 11/22] dyndbg: don't close trace instance when in use
Date: Sat, 23 Dec 2023 02:51:20 +0100
Message-ID: <20231223015131.2836090-12-lb@semihalf.com>
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
In-Reply-To: <20231223015131.2836090-1-lb@semihalf.com>
References: <20231223015131.2836090-1-lb@semihalf.com>
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

Signed-off-by: Łukasz Bartosik <lb@semihalf.com>
---
 lib/dynamic_debug.c | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index dd4510ad124e..59682729ed3a 100644
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
@@ -321,6 +331,24 @@ static int handle_trace_close_cmd(const char *arg)
 	return ret;
 }
 
+static
+void update_tr_dst(const struct _ddebug *desc, const struct dd_ctrl *nctrl)
+{
+	int oflags = get_flags(desc), odst = get_trace_dst(desc);
+	int nflags = nctrl->flags, ndst = nctrl->trace_dst;
+
+	if (oflags & _DPRINTK_FLAGS_TRACE &&
+	    nflags & _DPRINTK_FLAGS_TRACE &&
+	    odst == ndst)
+		return;
+
+	if (odst && (oflags & _DPRINTK_FLAGS_TRACE))
+		trc_tbl.buf[odst].use_cnt--;
+
+	if (ndst && (nflags & _DPRINTK_FLAGS_TRACE))
+		trc_tbl.buf[ndst].use_cnt++;
+}
+
 static int ddebug_parse_cmd(char *words[], int nwords)
 {
 	if (nwords != 1)
@@ -447,6 +475,7 @@ static int ddebug_change(const struct ddebug_query *query,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(get_flags(dp), &fbuf),
 				  ddebug_describe_flags(nctrl.flags, &nbuf));
+			update_tr_dst(dp, &nctrl);
 			set_ctrl(dp, &nctrl);
 		}
 	}
@@ -1628,6 +1657,15 @@ int ddebug_dyndbg_module_param_cb(char *param, char *val, const char *module)
 
 static void ddebug_table_free(struct ddebug_table *dt)
 {
+
+	int dst, i;
+
+	for (i = 0; i < dt->num_ddebugs; i++) {
+		dst = get_trace_dst(&dt->ddebugs[i]);
+		if (dst && (get_flags(&dt->ddebugs[i]) & _DPRINTK_FLAGS_TRACE))
+			trc_tbl.buf[dst].use_cnt--;
+	}
+
 	list_del_init(&dt->link);
 	kfree(dt);
 }
-- 
2.43.0.472.g3155946c3a-goog


