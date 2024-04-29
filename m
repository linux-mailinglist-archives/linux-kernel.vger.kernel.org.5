Return-Path: <linux-kernel+bounces-162949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22D7D8B62A4
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:41:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5470E1C21C04
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C8B413D28B;
	Mon, 29 Apr 2024 19:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B7CU3nDV"
Received: from mail-io1-f41.google.com (mail-io1-f41.google.com [209.85.166.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E09613BAEE;
	Mon, 29 Apr 2024 19:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419579; cv=none; b=qD/Mbtwnw/PraB9ZkjeGcicag0/6bijEBxvJm/w5aX5ePtAAcLNB+9ioeGHG+fq3ah/8pNtC5JmoeN/wE0FNvv7HDxDmNBXcHj85aFBJqMbZYQxudAYkfUrMzE5oexcIN+1LuhgNwDOxh452A/70fdgfP6waxAljvs/2rtlYyJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419579; c=relaxed/simple;
	bh=hDuGJYbSCuq3w/gVpmXJ6pwkCmpr+qtFTnd3/EzNJNk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lo9bH6iAh/TsHwtydsc/RE3+VzWftSOcuiqbzAfrnnsvCWeCtKh/3eWT+6mbzLIlS88lLH7hp9rmkamLKugBWDdr31B9Rs+YKRuw07Bg6jNKeAG09DievpNsFOibSBJy+3dc2hVpgzyqjQ38v4mGkwyChRuyKX3LM//iJ3ou2wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B7CU3nDV; arc=none smtp.client-ip=209.85.166.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f41.google.com with SMTP id ca18e2360f4ac-7da3ec3e044so232698739f.2;
        Mon, 29 Apr 2024 12:39:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419577; x=1715024377; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8dgWj2cFA2MU3UxaMwN/AH6DmAyC9gLaTAViD4Tt0Ck=;
        b=B7CU3nDV2a5VcNgMakmzUo5JBGVd+xiUhz1qyD52BzSEmUEPHreJwIiWsDVpyOou3o
         kWSG3GOwZ5mGKFm4fuVayjoxe/1lZOxl9TEfJeLNVYgOz67IsT9JOmRnlKEm4FuhojFa
         +kuWws718f1D23ovpskipV+yEJb9UFwH053h06nK/3fVg7hdHAESxwvLX6ovYI7rdfsM
         ZCd1tWZIwlIlujmOCKXj3XGslhnfWTU+oWEEP10+jQBFooIx+XRmgFJyVcWmiRWbYzbx
         O37TI3SyICUXc9GRHAG5nEqaR/t9bM5yYot6IhmP9RVlNBgnh3SMdor6baUUmnSnvB7J
         SWIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419577; x=1715024377;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8dgWj2cFA2MU3UxaMwN/AH6DmAyC9gLaTAViD4Tt0Ck=;
        b=oBzN1bU73IG3YmrmoaGkoz1dreFe2KTdNgUXnwTjP+tCQKEm6I8tSTBlYZx7Nx2bku
         6+e2E8G+S/vl0uQLe1PTPVkRWwyncRYvEzpnlmzihyoW5l5kKpHJFYPLXBNSbUaqz4Bk
         eh2w39TTIf8SXOAmAbYQlMvy9W8Skj3BHG7V4DaSg4Ow2k3wqs24mpAXUcfrpA43kKgB
         SmzspKefGUNHvYumj2lxKq+1BMxZxy22SdkQPZB4Sh8nP96Hafh0/kJxy+FJlIQNaVLC
         MH+Kaq3Df/n91bd+PmUACPpXjXKzcSZBN34bdXZmsbOnziOmxTbWcR6hPOYuA4FSi7MF
         z0rA==
X-Forwarded-Encrypted: i=1; AJvYcCVDNqrRRwX0w1++HLZNZ4I823EngH3Qz4D+f8d3BLRqZA6NpKOfYYHDtNcNEcgNVsyLtjgEZ2aOuPI5rDwRADEV4Qe3/ctucMuzw7imQ0PfdqRxG8J5iVCOKLrNLQVOeVfnTj/b4TWH
X-Gm-Message-State: AOJu0YzqQbS2tmk/MMq3/IOwliznOffcGOTWmvQOINlvExAVlaqbg4qy
	bdeF3ApcrtSmnGo+1DXHvopxvvJnicZFSy6fk3iIbLmqUeWfjv5w
X-Google-Smtp-Source: AGHT+IEs24YTwILUt5MHKr0F0OyxCq+SxhIGz3ARX0AwMIA0GR+8INeYUiHTkHCKHU43qMQt+OxxMA==
X-Received: by 2002:a05:6602:4b0f:b0:7de:c308:76e2 with SMTP id eo15-20020a0566024b0f00b007dec30876e2mr976745iob.3.1714419577342;
        Mon, 29 Apr 2024 12:39:37 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id y16-20020a056602165000b007de9f92dc57sm2325105iow.16.2024.04.29.12.39.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:39:36 -0700 (PDT)
From: Jim Cromie <jim.cromie@gmail.com>
To: jbaron@akamai.com,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	amd-gfx@lists.freedesktop.org,
	intel-gvt-dev@lists.freedesktop.org,
	intel-gfx@lists.freedesktop.org
Cc: ukaszb@chromium.org,
	linux-doc@vger.kernel.org,
	daniel.vetter@ffwll.ch,
	tvrtko.ursulin@linux.intel.com,
	jani.nikula@intel.com,
	ville.syrjala@linux.intel.com,
	seanpaul@chromium.org,
	robdclark@gmail.com,
	groeck@google.com,
	yanivt@google.com,
	bleung@google.com,
	Jim Cromie <jim.cromie@gmail.com>
Subject: [PATCH v8 28/35] dyndbg-doc: explain flags parse 1st
Date: Mon, 29 Apr 2024 13:39:14 -0600
Message-ID: <20240429193921.66648-9-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193921.66648-1-jim.cromie@gmail.com>
References: <20240429193921.66648-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When writing queries to >control, flags are parsed 1st, since they are
the only required field.  So if the flags draw an error, then keyword
errors aren't reported.  This can be mildly confusing/annoying, so
explain it instead.

This note could be moved up to just after the grammar id's the flags,
and before the match-spec is detailed.  Opinions ?

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 Documentation/admin-guide/dynamic-debug-howto.rst | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/Documentation/admin-guide/dynamic-debug-howto.rst b/Documentation/admin-guide/dynamic-debug-howto.rst
index 7b570f29ae98..ccf3704f2143 100644
--- a/Documentation/admin-guide/dynamic-debug-howto.rst
+++ b/Documentation/admin-guide/dynamic-debug-howto.rst
@@ -106,6 +106,16 @@ The match-spec's select *prdbgs* from the catalog, upon which to apply
 the flags-spec, all constraints are ANDed together.  An absent keyword
 is the same as keyword "*".
 
+Note: because the match-spec can be empty, the flags are checked 1st,
+then the pairs of keyword values.  Flag errs will hide keyword errs:
+
+  bash-5.2# ddcmd mod bar +foo
+  dyndbg: read 13 bytes from userspace
+  dyndbg: query 0: "mod bar +foo" mod:*
+  dyndbg: unknown flag 'o'
+  dyndbg: flags parse failed
+  dyndbg: processed 1 queries, with 0 matches, 1 errs
+
 A match specification is a keyword, which selects the attribute of
 the callsite to be compared, and a value to compare against.  Possible
 keywords are:::
-- 
2.44.0


