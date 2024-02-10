Return-Path: <linux-kernel+bounces-60621-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1501D85077E
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 01:00:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 639BFB2326D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10C4560278;
	Sat, 10 Feb 2024 23:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="gFU5ZT5g"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A63560BB8
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609096; cv=none; b=Z10A8zL1y5tlZIlQwPLZ4T+KA9amm48vwQrJl6pv5B7Xn1frs0XKRSQxviNer5u/BQaWG73Owjh/8RB7e42DEMS3g/gyP34G0WeYluIRccH3IT1qor/5upz/SnEWXN6mQT0DCytYxaX6dZodIrfOHvLp8Li79zyHHThwVJkxbLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609096; c=relaxed/simple;
	bh=E7G661369JAfDA2I7DCIVeqKZzJMxADI3GduPA8jgOU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UDHVDFHdOIdQwNH5BNLS5+PjuM3S0zLyEyviUD36aTTSomrCx6qdXJK3hZt8IavHb53OAgjCZNtsynrGJAAJkdoJlXzyvC1fs6e2KMxXw0gemW7OYfByylk8vrpA2WWAmJNKsio2Xe3PXH7FNJSkbXBMdrRKnCRO0ursbgp3fTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=gFU5ZT5g; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-5101cd91017so2348731e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609092; x=1708213892; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dd8YxOHav2NIBiOCgFEkoV0Anep5oU6J4bZR+Xm4AWg=;
        b=gFU5ZT5gpa7jZy6s7QOlgS92nUSSJctmlb+pOdh8dUzSf/FqhiPyVRn4LQY1yj29bO
         4HyLsD6NvPss7SqNfrjK7IdPccBbelfkCJD4HbLNVF+lUibqrQcsmu8qzHE3SBLrhanO
         GfVGrBVk1dzWuSp6FW2A9gwZknNOIhu0ML7nc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609092; x=1708213892;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dd8YxOHav2NIBiOCgFEkoV0Anep5oU6J4bZR+Xm4AWg=;
        b=uBbOiLJAXpfuhn+PC7eO29ln3aa+XDOzp1pWvWBcY35ROtgK4gLvdt92cigNofpB0a
         WmuR1WNSRVYl2I5xrk6qLiymvFVnvBp4GK0FZBHCpxX2p4Z0q4hneO08o+rbIpG+gGMY
         HO5dyYxAfyLb5NfeHc8IcuZo/ufyyxoyJ8IQhTplP1z14cBG/OCq9tTSDb2c+CYZBLv7
         U38+h/mksqkIczHWJeFCfXx9/tpX13AY1X73aFqir0WjW4Vhlkktml46Y4jPZ/Bmxys4
         b2nG8OoZOUfriK+4XMVEIgdyPAXUySEOG3N6GcOXfedYN6P0aXlyUCCa0eObZq1ZPbZp
         OUuQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG7OTyWFbXsTKngG15le6VZcGw7sYinTVQKCMNQAp5coHBizCnInyTUE+258eD+uPmcV78nI/mSK5/KrSo5CHF//dWyARPzUWTeOA0
X-Gm-Message-State: AOJu0Yy6DOv5NQuDdHxyTkxCFdBo1NR0Y1vhFmWNr/KRlfPI0saOxyz4
	+xdiHP1fLrwJD6LxV+rN4saROZo/TkDp1anPALqtPLRtradhmoUQ8RwBJQig
X-Google-Smtp-Source: AGHT+IHNpPgMm6BZ5MOph876RyUldOJ5TEgYUC5jUHT9Q4V/vp3Wrca8RyorGtDzCMd3guWrgH+WeA==
X-Received: by 2002:a05:6512:3daa:b0:511:3a32:4e4f with SMTP id k42-20020a0565123daa00b005113a324e4fmr2117458lfv.18.1707609092754;
        Sat, 10 Feb 2024 15:51:32 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVlaws3E7ysFmGoE+aYY8dL18c+FtxDH2nNX6KYz5MWHRf8pG4RMVxy0NShH3yVJWzE914hPswMarERotJ10Zgx4sU8E0l9N50xHOfE+fWwMmcrDvD+g19t4PYN1iV0V2vIk7m0sW+bAs3RKQsvjmDyuwXQDGpE1NytnCoIV0UJIPqga2SKHXDf7tFlXRZtWZhRsa0YaLZnNK5B4dRfy462i3psuwpv2Yli6DmGRsEHKQYFAK7uvskTppDQi9UXoMJGUy10L8tJmUkrBKWWrPH9RK71lkKy6xbr+sIBSWb5f/wWYAtYV7YeU7gtUu3gbu1f0KgY5gs6iWtAplZYSVovCibjwwFzqR3zoVcSQ5D9fDvwnpobaZG38814bfeeZOlqJK4W+l1i/S/nPQOLzxEqmxbLVOHYuYdl43ZWkQg5fAfhVFuUqHW1lGYOcop6WQ44Jm+LKUYupw8YAakSx9jJfEmdcjNIPyZV/vTES6u8mfJOq+e/ckfdLFZGz9z6+hR8Yn3loreULw5hUZ3Cs3Gi17vTghIxym1hZn53L7rmv8BKnIh8U42Iq+ak2iCoNbqLtjpO61HSutpajwtRQz3VN421sjRbyOWBVdBuYnWTlNkMNw==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:32 -0800 (PST)
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
Subject: [PATCH v4 38/39] docs/dyndbg: explain new delimiters: comma, percent
Date: Sun, 11 Feb 2024 00:50:08 +0100
Message-ID: <20240210235009.2405808-39-ukaszb@chromium.org>
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

Add mention of comma and percent in their respective paragraphs.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 .../admin-guide/dynamic-debug-howto.rst        | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 4d681c37e074..2d7ee4e558c8 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -73,16 +73,18 @@ Command Language Reference
 ==========================
 
 At the basic lexical level, a command is a sequence of words separated
-by spaces or tabs.  So these are all equivalent::
+by spaces, tabs, or commas.  So these are all equivalent::
 
   :#> ddcmd file svcsock.c line 1603 +p
   :#> ddcmd "file svcsock.c line 1603 +p"
   :#> ddcmd '  file   svcsock.c     line  1603 +p  '
+  :#> ddcmd file,svcsock.c,line,1603,+p
 
-Command submissions are bounded by a write() system call.
-Multiple commands can be written together, separated by ``;`` or ``\n``::
+Command submissions are bounded by a write() system call.  Multiple
+commands can be written together, separated by ``%``, ``;`` or ``\n``::
 
-  :#> ddcmd "func pnpacpi_get_resources +p; func pnp_assign_mem +p"
+  :#> ddcmd func foo +p % func bar +p
+  :#> ddcmd func foo +p \; func bar +p
   :#> ddcmd <<"EOC"
   func pnpacpi_get_resources +p
   func pnp_assign_mem +p
@@ -104,7 +106,6 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
-
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
@@ -128,7 +129,6 @@ keywords are:::
   ``line-range`` cannot contain space, e.g.
   "1-30" is valid range but "1 - 30" is not.
 
-
 The meanings of each keyword are:
 
 func
@@ -153,9 +153,11 @@ module
     The given string is compared against the module name
     of each callsite.  The module name is the string as
     seen in ``lsmod``, i.e. without the directory or the ``.ko``
-    suffix and with ``-`` changed to ``_``.  Examples::
+    suffix and with ``-`` changed to ``_``.
+
+    Examples::
 
-	module sunrpc
+	module,sunrpc	# with ',' as token separator
 	module nfsd
 	module drm*	# both drm, drm_kms_helper
 
-- 
2.43.0.687.g38aa6559b0-goog


