Return-Path: <linux-kernel+bounces-60590-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C54785075F
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:52:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF83F1F21140
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:52:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C2FE6086D;
	Sat, 10 Feb 2024 23:50:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="XXrkXuw5"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0BF5605AB
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609044; cv=none; b=BnN7rdJAZAV4cEm8gZs173LEg7Qb8QqMbzce4TDKIbNKkkCJTDGZchTyXz+q9Ceq+wAxSAjKvznEUJ+3ZMwHyz0aSbaW9PZFGeVsYq6l4CYndtAYP4TIro3egzEKFFDcWOcFuIggYE9QgpejUxcuigJ6Flj2j0v7eiXr9Lq1HuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609044; c=relaxed/simple;
	bh=PKIPCdVpIuUn/00YwCRKhljNgiSyRdjJyytN1tq9BaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=W6Fx+IE6vNO5YvRXQqN9b0tJg0afyK1LhwMloK4qHRRQbcU88fotetBbSJZIh8VdZkuaKT/yCUdMWoe8AGRwoho1bB/sYs74vs2Han3QPohNniWWz5tJR8wVEhkY0kBTyut88xK8KIwyaegcsX8iIpGrIm7YxEf6h/pyTW2B0YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=XXrkXuw5; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5101cd91017so2348452e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:50:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609041; x=1708213841; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHpG276MmElKepXhunEl7bkyaSWvxSiZXup8NnNdSuc=;
        b=XXrkXuw5amxDB1i/GGDQsUqAAlmsPklnIIoxdJYS3v2b7eottwGsfgsRPdpq3g/Hgn
         UGJ78SKGREnDpwObfm5yCjp5AV32mgAo2xtSRAiV2b038MnEjasuovWUdrBGFmVFGC+5
         teN4oCZ1IWrulbn2xgVLC1dI6WCgiVlTXTQuA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609041; x=1708213841;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wHpG276MmElKepXhunEl7bkyaSWvxSiZXup8NnNdSuc=;
        b=CPnCPTbzodaacQzi26ZcUOi4VSBrOieXuOdqElFjYe6+vM7jZKYRmjVYNLFUf1MFi3
         7FeIn+vyXhg4Cgzj2Y8I5zRDacxCjrMhQkG1LrBIU0cyNoVlDyDfXfeTHmRYCkh4CMZp
         DVHffz4BHjHjaFiEoRBXwLtJ9vVKMojBvtytW9bRc6EQwFE/KDETltLKolgiVb3udhfZ
         O+uuaAyJ0FyF6yqFovwLhmokMbYRVVWxn7923AumhDW+h/pZBJ0vdbKHOy353c/tRj9h
         SZ8w3D65XrqKFla0aJRygwd3MNPMJTEgMB2VhaWgGIATZvBuw70fjTBWf20klJ0OKlr7
         EsLg==
X-Gm-Message-State: AOJu0YyjFGc7/F93VBOGiCmVAwncQYjcJB2HVSFA+nwzrJ8l34DoSBs6
	rmRrgS4Q16tIE+znYpp8lNJGRQviX2VMvndFN4mV1CAksmiSFStS1qM+Bf+S
X-Google-Smtp-Source: AGHT+IHz+0gL0xM1fOcsFa/yd/LCrmiJcdGR4nG8muhDEguWlff0lFrYHY7jsR7tg0CMcnORGQrEJQ==
X-Received: by 2002:a05:6512:3246:b0:511:882e:aa2f with SMTP id c6-20020a056512324600b00511882eaa2fmr249269lfr.50.1707609041040;
        Sat, 10 Feb 2024 15:50:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVXzcfxvl53b0KUr1AgxRUitK73QLnppDlhHkKvnYnab4XlZzdLWCQtiWNZTYX4A42GkbmGlrcniR/8P9q9qsEfn5rnazlCjGxZ/7GZ12O3O7hHnIetYy+tHDPpZWSkRdAF5LGaz9p1aSZi1NwR6pRUq8VdmvotG8GZ+nFvPdc7wHduqJbYT7MpMjfz2E4YKzn6X/JFh9qgWcm/tO2BQYHs7QM+9nsK0KxXA0BTFqZit1tt2d0Ucftula3JtEJPHSXiffMXkeAEId7sF6lSGVsHXSEOE5XcWFnnwNo3CIpLB1CiLs0wh79FheTZivU2sASNqFuDMzszhOH2rpWy2aMx6fDsmIN68V+MLmEOcfQzAqBUegcMlfV0NEFW/44q9cqHla+NQuJZUbi/6dHGkSqSlKIhkoVjfhIZeNoF8EZ4ALwrOR9kCjxXMrTyG5D6BA+59BZXkaYVzqzIHFlHupE3DCLtEcs8Cttack5ZOZpHdgEg91o79IUTbfMHMYjG+gl1uXliMCJAcsevu4KzWWKJ+U36DbxTZE9kWRnYZC8FuRWU8Yf6oOZU/vGU8pVxS5FQsBKTDr1mgLhGyiWyb1JjeTkakLsk2B9EJX7djmTZFOY50Q==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.50.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:50:40 -0800 (PST)
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
Subject: [PATCH v4 07/39] dyndbg: repack _ddebug structure
Date: Sun, 11 Feb 2024 00:49:37 +0100
Message-ID: <20240210235009.2405808-8-ukaszb@chromium.org>
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

Move the JUMP_LABEL to the top of the struct, since they're both
align(8) and this closes a pahole (unfortunately trading for padding,
but still).

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 include/linux/dynamic_debug.h | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/dynamic_debug.h b/include/linux/dynamic_debug.h
index 497130816e9c..b9237e4ecd1b 100644
--- a/include/linux/dynamic_debug.h
+++ b/include/linux/dynamic_debug.h
@@ -14,6 +14,12 @@
  * the special section is treated as an array of these.
  */
 struct _ddebug {
+#ifdef CONFIG_JUMP_LABEL
+	union {
+		struct static_key_true dd_key_true;
+		struct static_key_false dd_key_false;
+	} key;
+#endif
 	/*
 	 * These fields are used to drive the user interface
 	 * for selecting and displaying debug callsites.
@@ -53,12 +59,6 @@ struct _ddebug {
 #define _DPRINTK_FLAGS_DEFAULT 0
 #endif
 	unsigned int flags:8;
-#ifdef CONFIG_JUMP_LABEL
-	union {
-		struct static_key_true dd_key_true;
-		struct static_key_false dd_key_false;
-	} key;
-#endif
 } __attribute__((aligned(8)));
 
 enum class_map_type {
-- 
2.43.0.687.g38aa6559b0-goog


