Return-Path: <linux-kernel+bounces-60592-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10B3E850761
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BAD172838C5
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B0DF60B8C;
	Sat, 10 Feb 2024 23:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Ztvr1j+v"
Received: from mail-lf1-f68.google.com (mail-lf1-f68.google.com [209.85.167.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6481160881
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609048; cv=none; b=O3OU/Ga1kldKsHv+rR1TKH51yXTDZmTQSXdnDV1y6x+t0105CPp4/VgZEb4LwUfhxvTn+Ft0r1CNx2/msZSVLPSoqjqeyV3ltWm9Eh5koiIkk85RxNOeDXLqdbaQ2mseMvHW9U350edytidnEYY9m6A+oWP5ag20MLEWPUWxQmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609048; c=relaxed/simple;
	bh=Yix+pbfpxiUDW0+LvNlKGlFsd39VDWqixPWRM9lIlGU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jwxfRkm0NhcFfG4cMzwMFeFAZ//NY76PDS8WO7AYEYowXn34Hd8Ec0oEs95sz93X0BAfUzZBw2k7g8zJ8bhu37xuMp8/EgtD0hPskywIeYRtUI8TuGxGYZ6EQka5YmLvzZAiBeT6JPZq03REkT3MkZr3vd61IbjZqqyL+9vdRRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Ztvr1j+v; arc=none smtp.client-ip=209.85.167.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f68.google.com with SMTP id 2adb3069b0e04-51147d0abd1so2384481e87.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609044; x=1708213844; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nULGoBvrjPazMaReX9FXf3uprPHVFqensPMgM7zd3J0=;
        b=Ztvr1j+vWq8KHrlGO+JrHCEpW+dj5020sOzySAlrFPWkL7I2/KDSAg5hlfTp8ykMm6
         feA3ej0NTV7gURHhjWF/kNwYWqOlGHm7FYkg8zeN+44Fri21U+AL3b+Jtn8VejHUDUhz
         ivtACn2mmKNm3pi16Is88SBzOsKkxdbSqaod8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609044; x=1708213844;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nULGoBvrjPazMaReX9FXf3uprPHVFqensPMgM7zd3J0=;
        b=HxRjkDUXtRFTcwNIHGKZ/qP1Ext7lQKywg5lpzMJwqXHpMoS+uLsl3tT9reXooFpwT
         w+sD//WgkkZbqLaWEkR/JGhWTaWevxOVHUKV3Moc2znBkthihAikxiWTaoINWKfI+jKa
         +oPCshGKYk0d+j+pDxnQgRs3De1iMBe64yIS21CpiqGTEs2lJrsfjOTSa7SBnoQ5MVSm
         ml1LuY7Dx5dmyMsYQ3quaK4E+VdF4AwUiPhdTY3UKesjpGUNzIaCP7epZnTPSriTJDK3
         IBoOM0lF/ea3EpUYv2TPEooNGp8Ft26vSPMwn6wvb13xNcHiGdSS4qtKPypKbspP7jwg
         Jv4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJUPIa0GkjApL3sm1+1lNWccbAK28TDfj4KI8JdhwDbbPWs5jAvoeRd7+4c0uVOJFz6KpXD08VPbtnvhYqYuuzW4gdjJwgl/IiWX+S
X-Gm-Message-State: AOJu0Yz/6ePEZY79WMwHzXO9jPQ+czy280zMXZlJGEZqJ4519bYQn7gs
	ABvuCBIsqY0bfRqpsUQO/ubxjRbQ4RVFaRjlMVa1PGok3zij7brBH5ww5mP7
X-Google-Smtp-Source: AGHT+IH9Jz9goMpzOU5N74maDWBFb2Fsr0JIUy4m4DNWY9NXEblbSg69vo9fNVLQBzh56rpO/q40DA==
X-Received: by 2002:a05:6512:2e9:b0:511:2e97:add2 with SMTP id m9-20020a05651202e900b005112e97add2mr1854012lfq.66.1707609044477;
        Sat, 10 Feb 2024 15:50:44 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXQzzEwiN58SQb8vBfDQPtFpNaKYkBecdyHyEUZb8tbv73P3Ah9jV2pyLh9mjjU9J+ku92PzDwu4vY3zbwQOmObLeROtbnDLn6ep0xGE4s/a4Tg1UhwiRouuWZSgMtt3jOEowM51QT1+OR6BpPstnDsZDoCL3SSFOvQAeEOPwGlxuXwHt5bl5r9h+dNVVWs4hlnzobgTEEvLU+0/XRRM1IIEthZjcYc1i/p/Q+ay7r4ECMi7QVM75haNQIrhf7uMB2KeZ+J+tju2ZzF29fxrqTxLbnt0PZWnxeW7LbR4xaAcQvvU8nNKCjbk7SH6bcTcDMkPL2UtQM1zlPit6SPeSU6eGo1NtDibmR28maW1wmPwvyWkSKswNeQOslO5P9DnXdvpuSDV2bjoopPHZWG/5skswr1uRUkNNVsVkQIcqCxl+hjjcSDM2AlMucPFMOSVwxZfCRM6IGBihRYsGtDo0K9bOSl2Mxmy4Byl7spbFhAqayILLNjiVm5iSKYMXFSPtDRHQN7NzDEYFncM4leytKlBzazpsxaw1egd0usYZ75c+NsMylO4yH7hcx2/s+rcxbbZtOc6Aw0vWiW851AZ0n0djmYsd+kHtgXh8CiWN9mPlJXMg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:44 -0800 (PST)
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
Subject: [PATCH v4 09/39] dyndbg: add trace destination field to _ddebug
Date: Sun, 11 Feb 2024 00:49:39 +0100
Message-ID: <20240210235009.2405808-10-ukaszb@chromium.org>
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

The trace destination field is used to determine output of debug
logs when +T is set. Setting trace_dst value to 0 enables output
to prdbg and devdbg trace events. Setting trace_dst value to a
value in range of [1..63] enables output to trace instance.

Signed-off-by: Łukasz Bartosik <ukaszb@chromium.org>
---
 include/linux/dynamic_debug.h | 13 +++++++++++--
 lib/dynamic_debug.c           | 28 +++++++++++++++++++---------
 2 files changed, 30 insertions(+), 11 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index a551b2967cb8..dc10c7535f13 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -60,9 +60,18 @@ struct _ddebug {
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
-	struct {
+	struct dd_ctrl {
 		unsigned int flags:8;
-		unsigned unused:24;
+	/*
+	 * The trace destination field is used to determine output of debug
+	 * logs when +T is set. Setting trace_dst value to 0 enables output
+	 * to prdbg and devdbg trace events. Setting trace_dst value to a
+	 * value in range of [1..63] enables output to trace instance.
+	 */
+#define TRACE_DST_BITS 6
+		unsigned int trace_dst:TRACE_DST_BITS;
+#define TRACE_DST_LAST	(1 << TRACE_DST_BITS)
+		unsigned unused:18;
 	} ctrl;
 } __attribute__((aligned(8)));
 
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index f47cb76e0e3d..0dc9ec76b867 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -80,14 +80,24 @@ module_param(verbose, int, 0644);
 MODULE_PARM_DESC(verbose, " dynamic_debug/control processing "
 		 "( 0 = off (default), 1 = module add/rm, 2 = >control summary, 3 = parsing, 4 = per-site changes)");
 
+static inline struct dd_ctrl *get_ctrl(struct _ddebug *desc)
+{
+	return &desc->ctrl;
+}
+
+static inline void set_ctrl(struct _ddebug *desc, struct dd_ctrl *ctrl)
+{
+	desc->ctrl = *ctrl;
+}
+
 static inline unsigned int get_flags(const struct _ddebug *desc)
 {
 	return desc->ctrl.flags;
 }
 
-static inline void set_flags(struct _ddebug *desc, unsigned int val)
+static inline unsigned int get_trace_dst(const struct _ddebug *desc)
 {
-	desc->ctrl.flags = val;
+	return desc->ctrl.trace_dst;
 }
 
 /* Return the path relative to source root */
@@ -190,8 +200,8 @@ static int ddebug_change(const struct ddebug_query *query,
 {
 	int i;
 	struct ddebug_table *dt;
-	unsigned int newflags;
 	unsigned int nfound = 0;
+	struct dd_ctrl nctrl = {0};
 	struct flagsbuf fbuf, nbuf;
 	struct ddebug_class_map *map = NULL;
 	int __outvar valid_class;
@@ -257,14 +267,14 @@ static int ddebug_change(const struct ddebug_query *query,
 
 			nfound++;
 
-			newflags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
-			if (newflags == get_flags(dp))
+			nctrl.flags = (get_flags(dp) & modifiers->mask) | modifiers->flags;
+			if (!memcmp(&nctrl, get_ctrl(dp), sizeof(struct dd_ctrl)))
 				continue;
 #ifdef CONFIG_JUMP_LABEL
 			if (get_flags(dp) & _DPRINTK_FLAGS_ENABLED) {
-				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
+				if (!(nctrl.flags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
+			} else if (nctrl.flags & _DPRINTK_FLAGS_ENABLED) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
@@ -272,8 +282,8 @@ static int ddebug_change(const struct ddebug_query *query,
 				  trim_prefix(dp->filename), dp->lineno,
 				  dt->mod_name, dp->function,
 				  ddebug_describe_flags(get_flags(dp), &fbuf),
-				  ddebug_describe_flags(newflags, &nbuf));
-			set_flags(dp, newflags);
+				  ddebug_describe_flags(nctrl.flags, &nbuf));
+			set_ctrl(dp, &nctrl);
 		}
 	}
 	mutex_unlock(&ddebug_lock);
-- 
2.43.0.687.g38aa6559b0-goog


