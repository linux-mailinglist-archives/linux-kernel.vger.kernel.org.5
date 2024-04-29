Return-Path: <linux-kernel+bounces-162925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFC5F8B624E
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 21:34:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D7F01C212D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 19:34:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9493140369;
	Mon, 29 Apr 2024 19:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tkp8mI7N"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C205A13D626;
	Mon, 29 Apr 2024 19:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714419149; cv=none; b=kZsW1+Ysd/8AoZuyCeBlcqLoYwF2c/6mtm7/+O6j/BJhI9ab3aacHPGMKlekXQ1y5t7R9t+5qRy3qYe/ULsVB8vP9IruRQlX85QcRM+cMlL8ciGUsf+OYm6lbTpl0niarVKY91GyStdDhv9RyN2rW8yurGUBZG+7guzPbcw2pZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714419149; c=relaxed/simple;
	bh=xTxcuHjqNWm3xcQLYImk5p4VmTm0gXC5NxLleU1cuu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdZxawFhwtGdazFO298E0wPY7QujkAEwA6S72Vhh1flLJVRTOgMcDH+wG8VUkBqSHVztMwq5lUz0HtptJFduQfeL1acthje39QyezO1RlWxvC8+lyIuTdolmv4q/XynOwC7HlVp1IhH29MzzARwuV0fzEWtgx+M/0cfbEKCcUhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tkp8mI7N; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7da42137c64so208157639f.1;
        Mon, 29 Apr 2024 12:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714419147; x=1715023947; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WWBvTZRK9iMyBsS29iq5uzOkpLKIJfBUxQQ9jj4Ilzo=;
        b=Tkp8mI7NFe29Klue6ZCxzQWbtL85BKyZsHZ0TodAzIgIAigiIiMlm/Szzjxld1T9k3
         2sU0gpnILcWdNycSk10ngXfeQJpGZsDYHuscM/GMOA34nnprHGshzu2cYO9G4cHW6XgM
         snYKxMDvRQKLcDt0GK1Rt1OlJY1elGXidEzFf04heS7o7I1wDlyij9oTGO+y/KRQ4ZgI
         vTaPuL0sn1grqTgg3YC+fygj5Tuj0FW/03MobURr935d9sbRCCNhmdO8wWq9nGNfh0WV
         zQ55IfIrjaHL2L6iHduzRec1LdzX3WAZdCM7rWsbpmY+Bqg6CajbNHGtu9u3Ya7wLLJ2
         Qq9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714419147; x=1715023947;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WWBvTZRK9iMyBsS29iq5uzOkpLKIJfBUxQQ9jj4Ilzo=;
        b=r7HXNzDNwe2y0a/M6NarzlEQJX5lRzTI32hiiZ2vEGidseWFYQiUsS8s5XNxFfKrrv
         71HcWoNcrezUgfbvrhMM4HcjzS6oD/KcLYNVlSCIZNgyEe3kTAyUVqdD/skCTiHBnNY3
         ecj+o6Phy2Q+HxvSvHAvyThA3J90X3/+FXm+0xCgK2dKSqznQkHlG1JThyYPQk2Oqmcq
         ZfnCxsyW0cfRUSxBxV9GZWU8H7HBLNtJU3TDFiU/p1eBoQiU2AmAWCjvxkaHKGUoNmR+
         UW/0YyD2axeiu8c1lcrgsfgF/rHzFVtXZHT3l+PKpBYZ9zg6R2rjH39JrcmAyOf7C4nz
         oVKg==
X-Forwarded-Encrypted: i=1; AJvYcCVOl22ul0tLqiQ83ircGeANRemN7VsbCVu7qkKQBDtLWeqayr04CwuliITJyMkl+BCCbQgovY+F6DgwKAdzR4zdSG6Bs9Zisnx8COrDxZw2vq5q0Z5BqSoJwlNMhEW7Fnf3u4j0fBC6
X-Gm-Message-State: AOJu0Yz2exBr8gEa/grjN+eW2wEGi63kqMw3cgQYqzBamoeTJzZYtceW
	Y+rrHyTbqvqgT6yasrN/AehgVTkWhvUL0rKI7x3sORIb3B2QljqW
X-Google-Smtp-Source: AGHT+IHBlACPw9dSF2W5n040FK0AJ2oPwC33WMQq24sMPJGaWDt3luGkDhtD59iMEf10zw56UprD2g==
X-Received: by 2002:a05:6602:4b0f:b0:7de:c308:76e2 with SMTP id eo15-20020a0566024b0f00b007dec30876e2mr960254iob.3.1714419146954;
        Mon, 29 Apr 2024 12:32:26 -0700 (PDT)
Received: from frodo.. (c-73-78-62-130.hsd1.co.comcast.net. [73.78.62.130])
        by smtp.googlemail.com with ESMTPSA id dq18-20020a0566021b9200b007d5ec9b77aesm5988402iob.51.2024.04.29.12.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 12:32:26 -0700 (PDT)
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
Subject: [PATCH v8 12/35] dyndbg: tighten ddebug_class_name() 1st arg type
Date: Mon, 29 Apr 2024 13:31:22 -0600
Message-ID: <20240429193145.66543-13-jim.cromie@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240429193145.66543-1-jim.cromie@gmail.com>
References: <20240429193145.66543-1-jim.cromie@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change function's 1st arg-type, and deref in the caller.
The fn doesn't need any other fields in the struct.

no functional change.

Signed-off-by: Jim Cromie <jim.cromie@gmail.com>
---
 lib/dynamic_debug.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/lib/dynamic_debug.c b/lib/dynamic_debug.c
index 8320cadeb251..882354e1e78f 100644
--- a/lib/dynamic_debug.c
+++ b/lib/dynamic_debug.c
@@ -1120,12 +1120,12 @@ static void *ddebug_proc_next(struct seq_file *m, void *p, loff_t *pos)
 #define class_in_range(class_id, map)					\
 	(class_id >= map->base && class_id < map->base + map->length)
 
-static const char *ddebug_class_name(struct ddebug_iter *iter, struct _ddebug *dp)
+static const char *ddebug_class_name(struct ddebug_table *dt, struct _ddebug *dp)
 {
-	struct ddebug_class_map *map = iter->table->classes;
-	int i, nc = iter->table->num_classes;
+	struct ddebug_class_map *map = dt->classes;
+	int i;
 
-	for (i = 0; i < nc; i++, map++)
+	for (i = 0; i < dt->num_classes; i++, map++)
 		if (class_in_range(dp->class_id, map))
 			return map->class_names[dp->class_id - map->base];
 
@@ -1159,7 +1159,7 @@ static int ddebug_proc_show(struct seq_file *m, void *p)
 	seq_puts(m, "\"");
 
 	if (dp->class_id != _DPRINTK_CLASS_DFLT) {
-		class = ddebug_class_name(iter, dp);
+		class = ddebug_class_name(iter->table, dp);
 		if (class)
 			seq_printf(m, " class:%s", class);
 		else
-- 
2.44.0


