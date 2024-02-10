Return-Path: <linux-kernel+bounces-60604-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4589485076D
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 00:55:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F050328732C
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Feb 2024 23:55:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A4A9627F8;
	Sat, 10 Feb 2024 23:51:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="A/nIjTre"
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D452626C7
	for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 23:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707609068; cv=none; b=tdcCsBvK9Rv+MFAmi1n1Lz22NX6qwwUh0uxBtKzJWpsjpIxCeO9+ugh+T0Tw3O2zhjL7la0ze6YAlGuW3f/Xo+E3YZsuAZNY+t868qD5K0anxOSCue2Hn0G8XYenUhjo4nqZqS2wvkpuWTM4SZbNcXjDZxukx6tQY4uEXaTSCpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707609068; c=relaxed/simple;
	bh=wAxPq0zBe7IpEyDOvpmRO5TFTuGXvH5YMnkbzDZC4fo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OU6XmyQAf6nxU2BFDJ7SUtkwKuM5m5D5V5cXrQuY3tfik1zOz+WbcucSw8W/9WaVm18ZzC2q0GC11XbIGjwzTWjUMXeg0HXZRB0DzQZxn8W9uqoEMpg7solh63a7YhrL/bgPt6/EoEPRh8zoJfYeA3H7pnW73DHBfPoAmE7L0Xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=A/nIjTre; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2d094bc2244so24261021fa.1
        for <linux-kernel@vger.kernel.org>; Sat, 10 Feb 2024 15:51:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707609065; x=1708213865; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T8V9Re3rorVQytgMEZlbpA/2LnF/BQwNBihKNd98pUw=;
        b=A/nIjTrepdalZmxzQPGEhAsrVjU1YoSqVbLilfcwHP4kBC4rdwwQZFQuoG7EVCsikb
         z7gOL959TxhgZgyyYVQx0eYzFag9hhJZtvwGRdAQP51ER6rleAmBE1ddlghEkG1ZPOKD
         xfFztFEgS3xtGHJVll8HTqg4FxpNIA3MmhPaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707609065; x=1708213865;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T8V9Re3rorVQytgMEZlbpA/2LnF/BQwNBihKNd98pUw=;
        b=rE397TVEmaeU0RNQvOtNaN011tTQJ42dGsG6rCdKUWdNvwRuFakum4wByzh/pbKLHz
         qfC1hZmQ/3vq3usjbwXWbn74RT43D39ytybMrNsZ+ILSCKhY0hqg4F3jgsJGsxgV3+Ip
         phwuRItzqFYO4cGdajc9Tr+VEJNjexAP7PpOtJR2FC2UTM8UKs5+TmD4pOm9cDuO8+IM
         cNW9SaIWYaWe8aOMDc2aa5mIkRrEs4IfPBWCiNSxvRwl8vqgv80LZM8lUXP0wxqJHryt
         x3JIysJPDT1bv/QR6gCd2ueT3ZrDw7QH3MQGdYri5OHF2mhvpw3DWrvIaxwyzja+uQ6s
         gLKQ==
X-Gm-Message-State: AOJu0YyL1pdaIqTyGvYInAj/0bZnRc/cLpjuZjXlshjVv1DckcdQ7L/7
	TT0+TBGQluQ0DNIspxlrnWEhESmvGYrP2iH1QBW61KkwP60Qs5XONMf/3clb
X-Google-Smtp-Source: AGHT+IHP/vMFgzjTpgySXFjNLMbGaqSZC3cy2UmuEzH92yYKybw5ZQzsYSs2Uxj0gmElHyf10qaPow==
X-Received: by 2002:ac2:4315:0:b0:511:4dac:f1ab with SMTP id l21-20020ac24315000000b005114dacf1abmr1671617lfh.40.1707609064808;
        Sat, 10 Feb 2024 15:51:04 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW0HS+00HYoxQiogyr9WBwa1uNU3+Oy3nx55i3YZhKZAHCXUgScNtcchyYsVTu6aQdITZI3UN8DjYpzIMWvemBBq8+8pI2G3z/xvDtxlbYDwZDZU3KkXoAvUQ5B0rRwYDxFZjiZ8mDgcDkIHaYNSHdqQGGVLf162YypA+RZS36OBUf05ynuMAaNEI8JYomOPqd+qDajC6q66LlG7Kt8FvyGtY1f2Ydi/vLASFek/r4PmF1EjiZmIZdwLFmJPwn5HBG17Vco3nK+wmv6FA7Dy7vJWvMF897vGI3ry1swlBfoL8mcN46FG4HdXPiPkfR+F8tMFGeJv4jAt2T8YaTEU1QKq3ai9djg5HsSmWzf0u1IjcqvYSxZ6XBc7cNztIJhdLGc+Ahxw5HmGYdMQGlfeTv4dpKjSvzgxGqNrQyAFcWBYlM8+kjZRdO11WXfstQCUOfVTNIf+6W6leCzsQeTt3TfV1mEk9WUuFAfzR+emn1zUvVcbIibJHUTdKJMhjh9jWnVm6BdcbyqbfX13B8KCDXQcB3fMploK4bjyMmtVmrzNN+v8sKVJE7ujybBppbuT4+1IhLiBR7Uc/XUkVUtt98Ag9eNdvi1mqjO/dgfTyN7j0LErg==
Received: from ukaszb-l.roam.corp.google.com (alfa56.extreme-net.one.pl. [213.77.89.56])
        by smtp.gmail.com with ESMTPSA id o27-20020a056512051b00b0051179ae1846sm365561lfb.280.2024.02.10.15.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Feb 2024 15:51:04 -0800 (PST)
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
Subject: [PATCH v4 21/39] dyndbg: split multi-query strings with %
Date: Sun, 11 Feb 2024 00:49:51 +0100
Message-ID: <20240210235009.2405808-22-ukaszb@chromium.org>
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

Multi-query strings have long allowed:

  modprobe drm dyndbg="class DRM_UT_CORE +p; class DRM_UT_KMS +p"
  modprobe drm dyndbg=<<EOX
     class DRM_UT_CORE +pmf
     class DRM_UT_KMS  +pmf
  EOX

More recently, the need for quoting was avoided by treating a comma
like a space/token-terminator:

  modprobe drm dyndbg=class,DRM_UT_CORE,+p\;class,DRM_UT_KMS,+p

But that leaves unfinished business; that semi-colon needs escaping,
and thats not robust to further string interpolation.  In particular,
it fails when passed to vng (virtme-ng).

So this patch adds '%' to the existing ';' and '\n' multi-cmd
separators, which is more shell-friendly, and avoids quoting and
escaping hassles.

  modprobe drm dyndbg=class,DRM_UT_CORE,+p%class,DRM_UT_KMS,+p

NOTE: it does alter/break this (ill conceived) search:

[root@v6 lx]# ddcmd format %s +p
[   38.170998] dyndbg: read 13 bytes from userspace
[   38.171542] dyndbg: query 0: "format " mod:*
[   38.172011] dyndbg: bad flag-op f, at start of format
[   38.172487] dyndbg: flags parse failed
[   38.172839] dyndbg: query 1: "s +p" mod:*
[   38.173285] dyndbg: expecting pairs of match-spec <value>
[   38.173791] dyndbg: query parse failed
[   38.174141] dyndbg: processed 2 queries, with 0 matches, 2 errs
bash: echo: write error: Invalid argument

In trade for that minor format selection limitation, we get to do:

  vng -v --user root -p 4 \
      -a dynamic_debug.verbose=3 \
      -a drm.debug=0x15 \
      -a i915.dyndbg=class,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfml
  modprobe drm
  modprobe i915

NOTES/TLDR:

In this example, using both drm.debug & drm.dyndbg is mostly for
testing.  Using drm.debug is preferred, because the drivers all
explicitly depend on that input/control-point, so settings there are
propagated to drivers.

But more to the point, drm.dyndbg explicitly limits the query to drm.
In fact, you could pass a module wildcard in the above, and achieve
the same thing:

vng -v --user root -p 4 \
-a dynamic_debug.verbose=3 \
-a \*.dyndbg=class,DRM_UT_CORE,+pfmlt_%class,DRM_UT_KMS,+pfm%class, \
DRM_UT_ATOMIC,+pf

':' would be a more natural multi-cmd separator, but is reserved
for +T:<trace_buf> to designate separate tracebuf instances.

If '%' is distasteful, the backup plan is ",_,", since that would
never appear in a useful <format "$foo"> cmd.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 78b06a617918..a6c6392cde3e 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1001,7 +1001,7 @@ static int ddebug_exec_queries(char *query, const char *modname)
 	int i, errs = 0, exitcode = 0, rc, nfound = 0;
 
 	for (i = 0; query; query = split) {
-		split = strpbrk(query, ";\n");
+		split = strpbrk(query, "%;\n");
 		if (split)
 			*split++ = '\0';
 
-- 
2.43.0.687.g38aa6559b0-goog


