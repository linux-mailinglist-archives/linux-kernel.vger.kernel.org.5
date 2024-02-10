Return-Path: <linux-kernel+bounces-60611-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 91D54850774
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:57:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EDFD1F27006
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C02A3634F9;
	Sat, 10 Feb 2024 23:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="RtKhxnT6"
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B38633F3
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609079; cv=none; b=u5kbh2y8QCd+B7k/rhXvwDRGE9Q0FliBdO05iuetzFI+vYoBq48dYCt8bAwbG5H+qjJ0XUvBlPe0N59iK9KLx1C53ijC2rj53EdyPIU70AubiYYxgJ2O+7yWBdbP1WaWKEOgmA36gITjpoGZsoGrl2lerxDzDKd3uCGwmT9kx+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609079; c=relaxed/simple;
	bh=FuN66CZSydycpxaPkHziB/8EQgmXEAxnWh9g9K7464g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=sE0zrkYRhLQr6qh9UnKJI2/6UC1fBCQfVIrsiOSfTXrNxxvOtitcdK+UcFmV8RwZ6FEHpQ+kwahLpC5EBMgs92oZhz5PTuQf3alv4sWULdy2Kyon4rLq95TizR+cGgC7iu3YswseT3OOhJb1u7QRyxqfP17dc2NEg7dI3xH56p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=RtKhxnT6; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5116063585aso2569882e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609076; x=1708213876; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FzjDrvjZBOO3Ae0afAeNQTFezeRo3IOGyPT+C9MECDg=;
        b=RtKhxnT6i/F9DJos6tftVY3CEjIChgSLfdPNyukUETgqm5lvGovsPOytz7wivz8kM1
         Jiwj/JmyFG0IOoyZLai0CJ658V8ychVlGeN+ndb8AQvpT5iQJTz1gmf6Db9ff1QtIiez
         rKW7P3nCQwuLq7mYbpH4xDYfFvipkmJqKTtv0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609076; x=1708213876;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FzjDrvjZBOO3Ae0afAeNQTFezeRo3IOGyPT+C9MECDg=;
        b=stzo9gRCfeKpq/4Ozu/hvxyFl83RGbkybjAYeQaU16OOXXYjWOQGzFomFAgjRZgDeW
         0+lVPAcPdJEy6SFbW8HGF+RSbvDiQrQcjgdLwNtRfL+YD0+rSQh6LLap2EFEY9HNcw/V
         UULjwVG703gHp5gv31Eag7H0GhUFiA5Jv1BacDbVYwnK6O2NmCG5KqKUHM/YFov/OPcM
         VBekgwjQO2W9cb4QxxyIipY2vii4sD+jl1B2jPkSCeeot3A9WR59XV7Gq64XGzh6jRTc
         lBiA6EpfeLIZb72BihjUQdhqaSESamVve5oMPtj8uqei5IzGVadGal+aPSuuVJrOvlzZ
         lVmA==
X-Gm-Message-State: AOJu0YxSI6ani3kXSLaZY2LaicAYl39y3XpBL/0fCU4saJx/KTOasS+T
	AWC8qyAvEfnZDOTlVbknfyWpfHq03kl9K5OH+n5GpAFKHo4ZnmNCbiCna1ly
X-Google-Smtp-Source: AGHT+IH8zFicPxH2DIR90Y9j02WHcWFIOE03Wb0ZdrlgXCc8UgfuaSaOPBBG4yd50BmFTV2xe7BeMA==
X-Received: by 2002:ac2:48a3:0:b0:511:642e:de27 with SMTP id u3-20020ac248a3000000b00511642ede27mr1857319lfg.14.1707609076176;
        Sat, 10 Feb 2024 15:51:16 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXvBNAjOAAMs6b9nrQc2M52srT2vyuYMzljYzCtLJuClZoOrgTrKB5Z7M8cNv3LVfN/g2seUVlfYq5VMu7aTOXI0+fpSOX24ztJoFa8Vpjyx0bXDjt3pPpDcB+cuRQ8omv+umajnEsUMIpHG8+CnZqi9bwM095y3LS74ZXKcYAX4oy7LhQ/K8E1cGqVcEeoEiX5M7uDWm2h1qVSuqqSadWthnF/0tCSdeOEcnuTuw2S7+TbEn5YLj3YV4m6MpObxCtODbVxV8r6aQKYAVCYonsus30Z3l1V+GKO+A9YXWWzcn+YZt0qQCgj23OeEQfyWge2RpBQJzrPygWAnfK0hvQgKv44S0NEVbw9RyWoozCYb857P1N9W4u8qxRk9pwGVKWwQb295DQg4lTK1jPhams55J5LXANaukDMy13N+aXp9b6w0dm6JgMW9Rw4lwjTyIXz1pB8oPsXGNmOvbU5hIqBqDtkbU01ffipXZFf4z+gLClukn4kjrnLxfX36pZ7eteaQYHf8mUl1fpd8uDH4kTOG7WcCL0BafOAh+OiklAAsb0GYjNLkOiPXon5vR0heElUKXLN5I/COCJmQveEQjS+bjhG1oz/aiDpjsHsoUUqh4EDEQ==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:15 -0800 (PST)
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
Subject: [PATCH v4 28/39] dyndbg: don't show default trace destination "0"
Date: Sun, 11 Feb 2024 00:49:58 +0100
Message-ID: <20240210235009.2405808-29-ukaszb@chromium.org>
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

When a callsite's trace destination is set to "0"
(default after boot) then don't show this trace
destination in /proc/dynamic_debug/control.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 lib/dynamic_debug.c | 20 ++++++++++++++++----
 1 file changed, 16 insertions(+), 4 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 7723bb7dfc46..d6d797830be4 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -188,6 +188,12 @@ char *read_colon_args(const char *str, struct flag_settings *modifiers)
 	return end ? end : str + len;
 }
 
+static bool is_colon_show_args(struct dd_ctrl *ctrl)
+{
+	/* don't show trace destination when it is set to default "0" */
+	return ctrl->trace_dst;
+}
+
 /*
  * Maximum number of characters which are being displayed when
  * printing trace instance name, longer names are truncated
@@ -223,14 +229,15 @@ static inline const char *trim_prefix(const char *path)
 }
 
 typedef const char* (*read_flag_args_f)(const char *, struct flag_settings *);
+typedef bool (*is_show_args_f)(struct dd_ctrl *);
 typedef char* (*show_flag_args_f)(struct dd_ctrl *, char *);
 
 static const struct
 {
 	unsigned flag:8;
 	char opt_char;
-	bool always_show;
 	read_flag_args_f read_args;
+	is_show_args_f is_show_args;
 	show_flag_args_f show_args;
 } opt_array[] = {
 	{ _DPRINTK_FLAGS_PRINTK, 'p' },
@@ -243,7 +250,8 @@ static const struct
 	 * future use. When both T flag and ':'are provided together then
 	 * ':' has to follow T flag in the form of 'T:'.
 	 */
-	{ _DPRINTK_FLAGS_NONE, ':', true, read_colon_args, show_colon_args },
+	{ _DPRINTK_FLAGS_NONE, ':', read_colon_args, is_colon_show_args,
+				    show_colon_args },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -258,12 +266,15 @@ struct ctrlbuf { char buf[ARRAY_SIZE(opt_array)+FLAG_COLON_ARG_LEN+1]; };
 static char *ddebug_describe_ctrl(struct dd_ctrl *ctrl, struct ctrlbuf *cb)
 {
 	show_flag_args_f show_args = NULL;
+	is_show_args_f is_show_args;
 	char *p = cb->buf;
 	int i;
 
-	for (i = 0; i < ARRAY_SIZE(opt_array); ++i)
+	for (i = 0; i < ARRAY_SIZE(opt_array); ++i) {
+		is_show_args = opt_array[i].is_show_args;
+
 		if (ctrl->flags & opt_array[i].flag ||
-		    opt_array[i].always_show) {
+		    (is_show_args && is_show_args(ctrl))) {
 			if (show_args)
 				*p++ = '.';
 			*p++ = opt_array[i].opt_char;
@@ -271,6 +282,7 @@ static char *ddebug_describe_ctrl(struct dd_ctrl *ctrl, struct ctrlbuf *cb)
 			if (show_args)
 				p = show_args(ctrl, p);
 		}
+	}
 
 	if (p == cb->buf)
 		*p++ = '_';
-- 
2.43.0.687.g38aa6559b0-goog


