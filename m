Return-Path: <linux-kernel+bounces-60584-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6ECA850759
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:50:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 837B02838CB
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A00F5FF17;
	Sat, 10 Feb 2024 23:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ef7c526k"
Received: from mail-lf1-f66.google.com (mail-lf1-f66.google.com [209.85.167.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF2055F84C
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609034; cv=none; b=adjrgO9eBTGrcC7rYTR1llpH7S52EVhBwZqvwAxQ0JDbEAqefpsRez2CW67HC9M4CxNTMiHoZtseGj46ov4IoyvfH6ydYu6/YrQq+Arh4mfiH/gJL98UWAQQ6CgEVShpaYp5oUvYE8PBFYS5wtNS1zxkBofIT8cn7hyIvIQ/foU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609034; c=relaxed/simple;
	bh=6bHuuhuQD8TDY9jao7qw7tzXO/CI+YZs/Ximv6+tRdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dUmCo6B0CZdD8kWjQxqSIqSenVKfgmybi+r7qgb6HIXZZJ6EmlGtok6a7cCnGbMnUzkqksiz+P6boiUIdKWnZXajxbrUcpKbsjJnQOcUibsb+79z+S4tBCg4h28xNObRb8i+82HIgEMLU6ZegMJknrEx10Ij1PpQNKjbRI9imwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ef7c526k; arc=none smtp.client-ip=209.85.167.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f66.google.com with SMTP id 2adb3069b0e04-5112bd13a4fso3358750e87.0
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609031; x=1708213831; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QOoJLafFWulnfY+ABLHJKXgTr+y2AravVLoCN2Eukac=;
        b=ef7c526kiZoUj+TKVbq0nWQE+UX2arGsQweYBLfZrOXdCITuSh1WmjVzg87g0nBAE1
         ptK05nt0PCcsbiGSRnhEv3OrU45s2gLZb3OO0USzbLdzAwusBqpNhzQFsFAAkM25T6Dj
         B7f6/mSP1s9nOrXwFOIVoBczPEUh9xwlJO/e8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609031; x=1708213831;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QOoJLafFWulnfY+ABLHJKXgTr+y2AravVLoCN2Eukac=;
        b=cLlJDqPTJtFh3FiafmVQxIb0q74GSvtfq/p6Zqcg2K4l+DBdb0cxUsL1pMcgOKwljO
         qijxd0dmbr5sOKld3cgRwd+1Y94YUsDyd1Ul7GpkrRbgPgrG8Vqd1hmntFXURQzr0KWv
         gfYHaDdSRLQ3BjBnCuAeQX5KV39Sxlm/WmTQND9z9TEXwhMyMYBj1GvU0wu5eRnloIh7
         JhWaF2JdQGKwHirwgKg7ppNShs58wLbikGlDs4RRrqj01bWC83MtYWQoF4VO6CxRlvSv
         +e3R8IZCHY1M/QTHPfzJt/UahFeoscmPP50MLZDvMqvZ3ke/MPdU3C/q+KX7bhucJEIC
         xC+A==
X-Gm-Message-State: AOJu0Yxbb4Pot16wp67aC8BG6y6WGUKHWHjbZIZSP+cC6NND5fv2IXqa
	FiMCkg+cpGpOQtjTN6bSeIC5QTmlJchjz+MzcLgwQP7dl5z66p4yEwxU/YUL
X-Google-Smtp-Source: AGHT+IH56fKoupzdFYKX5nvP1SrMBeSC5O3RzuCKGxfNyi5V3RrWouJbr/DyVtG6sHRQbHwJO97ulQ==
X-Received: by 2002:a19:7509:0:b0:50e:9354:67d0 with SMTP id y9-20020a197509000000b0050e935467d0mr931410lfe.14.1707609030596;
        Sat, 10 Feb 2024 15:50:30 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWR1qliCHrb/rw1JVufMqRw0VLKJMt3eslGm0V9/888+GwXZ5PctKlXXItIoQB5G1V3UFozdKQffcB1NyquT7C6LWZ9iaCE1QLGGNLYueU8jnUpO/uImR+shjBignDqqIIDtTjIdBuLl4MWW6dvY3YAoH/lb6XFkGKk66aSEJwhUK8WujMSNZVSPl8VahxrrXiH4IUHrJ2LjVa+mcsd+eAlGCeML64ZkiOi4BxMxrT7Bd0dijoDWqsqvNtH22eMax4Rq32fRjbNEm0ReZc9JrjJuOmanDaER0rFH9NLXNLO42p5qOTLTx4bYw5ZmlcqspB8pYaqg6T3XH6e9jM7ZgbAZtfbm6a2yIWcjHCO/a58BMkgXkrnabwbAErSInZBRqbbUQk4RSUQTx6oRF/vvj0uvAfGd3YeZE6rwd3NUg4mq6FnncFEpeVJAm3yS5TKT84tbhduNo84syjqyMnPeRYcfe5y6OicMhBywYzbyTzYrC56UDMaugehQBguTnz2DtN8ORFUlC/f9zkXCLh7ojF59y227OnFdtblqR5oLaxv4fhX+Ml2r3+wPV+3cuFg3/fZA0nV2l92gV8X+IIfgrocINe1qQfJoVNhd0xqfLPcVrDnig==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:30 -0800 (PST)
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
Subject: [PATCH v4 01/39] dyndbg: add _DPRINTK_FLAGS_ENABLED
Date: Sun, 11 Feb 2024 00:49:31 +0100
Message-ID: <20240210235009.2405808-2-ukaszb@chromium.org>
X-Mailer: git-send-email 2.43.0.687.g38aa6559b0-goog
In-Reply-To: <20240210235009.2405808-1-ukaszb@chromium.org>
References: <20240210235009.2405808-1-ukaszb@chromium.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jim Cromie <jim.cromie@gmail.com>

Distinguish the condition: _DPRINTK_FLAGS_ENABLED from the bit:
_DPRINTK_FLAGS_PRINT, and re-define former in terms of latter, in
preparation to add a 2nd bit: _DPRINTK_FLAGS_TRACE

Update JUMP_LABEL code block to check _DPRINTK_FLAGS_ENABLED symbol.
Also add a 'K' to get new symbol _DPRINTK_FLAGS_PRINTK, in order to
break any stale uses.

CC: vincent.whitchurch@axis.com
Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 10 ++++++----
 lib/dynamic_debug.c           |  8 ++++----
 2 files changed, 10 insertions(+), 8 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 4fcbf4d4fd0a..7be791af7cf1 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -32,7 +32,7 @@ struct _ddebug {
 	 * writes commands to <debugfs>/dynamic_debug/control
 	 */
 #define _DPRINTK_FLAGS_NONE	0
-#define _DPRINTK_FLAGS_PRINT	(1<<0) /* printk() a message using the format */
+#define _DPRINTK_FLAGS_PRINTK	(1 << 0) /* printk() a message using the format */
 #define _DPRINTK_FLAGS_INCL_MODNAME	(1<<1)
 #define _DPRINTK_FLAGS_INCL_FUNCNAME	(1<<2)
 #define _DPRINTK_FLAGS_INCL_LINENO	(1<<3)
@@ -44,8 +44,10 @@ struct _ddebug {
 	 _DPRINTK_FLAGS_INCL_LINENO  | _DPRINTK_FLAGS_INCL_TID |\
 	 _DPRINTK_FLAGS_INCL_SOURCENAME)
 
+#define _DPRINTK_FLAGS_ENABLED		_DPRINTK_FLAGS_PRINTK
+
 #if defined DEBUG
-#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINT
+#define _DPRINTK_FLAGS_DEFAULT _DPRINTK_FLAGS_PRINTK
 #else
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
@@ -199,10 +201,10 @@ void __dynamic_ibdev_dbg(struct _ddebug *descriptor,
 
 #ifdef DEBUG
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	likely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	likely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
 #else
 #define DYNAMIC_DEBUG_BRANCH(descriptor) \
-	unlikely(descriptor.flags & _DPRINTK_FLAGS_PRINT)
+	unlikely(descriptor.flags & _DPRINTK_FLAGS_ENABLED)
 #endif
 
 #endif /* CONFIG_JUMP_LABEL */
diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 6fba6423cc10..ee0cb37153ef 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -89,7 +89,7 @@ static inline const char *trim_prefix(const char *path)
 }
 
 static const struct { unsigned flag:8; char opt_char; } opt_array[] = {
-	{ _DPRINTK_FLAGS_PRINT, 'p' },
+	{ _DPRINTK_FLAGS_PRINTK, 'p' },
 	{ _DPRINTK_FLAGS_INCL_MODNAME, 'm' },
 	{ _DPRINTK_FLAGS_INCL_FUNCNAME, 'f' },
 	{ _DPRINTK_FLAGS_INCL_SOURCENAME, 's' },
@@ -247,10 +247,10 @@ static int ddebug_change(const struct ddebug_query *query,
 			if (newflags == dp->flags)
 				continue;
 #ifdef CONFIG_JUMP_LABEL
-			if (dp->flags & _DPRINTK_FLAGS_PRINT) {
-				if (!(newflags & _DPRINTK_FLAGS_PRINT))
+			if (dp->flags & _DPRINTK_FLAGS_ENABLED) {
+				if (!(newflags & _DPRINTK_FLAGS_ENABLED))
 					static_branch_disable(&dp->key.dd_key_true);
-			} else if (newflags & _DPRINTK_FLAGS_PRINT) {
+			} else if (newflags & _DPRINTK_FLAGS_ENABLED) {
 				static_branch_enable(&dp->key.dd_key_true);
 			}
 #endif
-- 
2.43.0.687.g38aa6559b0-goog


