Return-Path: <linux-kernel+bounces-50764-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8B0847DAC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 01:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F2817282767
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 00:16:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A43D7EC;
	Sat,  3 Feb 2024 00:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YWDvwAaq"
Received: from mail-qk1-f182.google.com (mail-qk1-f182.google.com [209.85.222.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7C5636;
	Sat,  3 Feb 2024 00:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706919404; cv=none; b=mBazjiH5SZeeoP8QdAnhQmQ+WUA+yGmXUw7E2KZv4TvBecokI5BjBwM/u/dq8aWRrvb3QpAIdb1bHfhcs97SbKrrACeFu9UJvJ54ZzcNVmrF+o6AUabK513Rq4QdcQ0bcEG9vw/d+ZS7M7TlpK4OmSBsFn3CYa0l+4twpc4lYRo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706919404; c=relaxed/simple;
	bh=epzm4rKSoQDNoRiuIWpvjBk55Qy8kCJ5CzoSRUbMMws=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FcDbnq4boN3LvD1yI5gD+/Bmsncc/meIvvILezBBGNQ7i+QhvpHtJdU0r+PbZQX/5ir6vdFZEfbTKoZ7GOBVXs8afPOnusvtAZscMcyFBAV+UXS4OGmJJjfQKlIyZBTVfF5oEMq8CZNAUxCXt+Q9HpnHbXUW4CFKuo6Es8dvfhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YWDvwAaq; arc=none smtp.client-ip=209.85.222.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f182.google.com with SMTP id af79cd13be357-783cd9ca29eso116801285a.1;
        Fri, 02 Feb 2024 16:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706919401; x=1707524201; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:from:to:cc:subject:date:message-id:reply-to;
        bh=YE+GQEi4WgLdT6Ksz+vs2z8SJMiDC0kWDo1/vTv5WNc=;
        b=YWDvwAaqWD0EcVaRjvS5Me4ikUVYEX42c+0D8hV9Qz/djz6l5SWsr7q9gw91zf4BCe
         dc0uSddAhUFMEGI6Rzr7ZIcw8wemrkyVFDCmJx/xXueufdjMvOAa6YU4QV0y4GZ72NY2
         6uygO3xt8iYEfXXwAFinf/PHgJj1GnvKnyby5wYDqULgK2/yIKMpBtKq6wiYOFVu+dA5
         kAaugYDgrOagdwSG6fwcdsWmyMlAkPGw437n/dTE3w8o+RbbafY6IEgnCw+t5+6T93zc
         NyhQCUIkD+m7O0IDEg0R7XjeVEXln2gfRhe9NTpVOev2G0K5w5NCggjGELPyY4MHkTeg
         i/gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706919401; x=1707524201;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:sender:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YE+GQEi4WgLdT6Ksz+vs2z8SJMiDC0kWDo1/vTv5WNc=;
        b=tKL3ZxEZzc8+T2qWrnAWi7mW84P1YdEeJBzRbcy45mbkIh0Ng47O0VBmDaj51s8lrQ
         nnO8yFzJ3flwQTtSzeJ021n4iyFYHE2h3exfVbXwkgfiRJjiYR0wqcuDKgSLrUvWzsHt
         qkmXBEURupA9dmYGyTWJ+Sd4DeiduMAXlM0YWqlPsuf4o1zxygiA1OnUmtZdg4MJvgHn
         jfuXyYu7XPVl0hJY7MkrcoVnTomO86/yCsm3E+Wr4vzL4r5mqijT3IVQCFbJTzSu/1KV
         +2i81eox0/IZW6NN73s+WrG6oU8ugPsYCcNyNgUeF3/7akN5UJL9muvQZxQAudWXJmtL
         RU6Q==
X-Gm-Message-State: AOJu0YxvSFGJmxgsIdsd05ahckvTE1rhBZl1WgpglgVSBnilR/1DtiyH
	paqdWC+dimS3q+WsTJuN6ieFp0LEdP0eaeJ9ZUsPG2B4DZNroW6betoitTF+7wg=
X-Google-Smtp-Source: AGHT+IEYgVRNZuQLJBlvxrjIwwkRNvRtBu/hLY6Ty1rwXqR6IjCnZxdYY0Tba4ughyz+cC16uF9wfw==
X-Received: by 2002:a05:620a:1793:b0:785:5f4f:ac11 with SMTP id ay19-20020a05620a179300b007855f4fac11mr2061734qkb.48.1706919400696;
        Fri, 02 Feb 2024 16:16:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU4XFUDz0mGvcqhN1/c30v6kTI5dCkzFfvoWe+as2YoEGZDpDQwT52NFR3S4/TIMEvyhrY8gEQmzBVABw5SJqSkAZo57ZWuJdtz7NZrwoUv53KXfJUYOFaRs8NdEKspoVVGQPkAEpm2MM0EggyMLgFArYWZed8=
Received: from fionn.home ([174.88.88.13])
        by smtp.gmail.com with ESMTPSA id vq25-20020a05620a559900b0078553970530sm967422qkn.89.2024.02.02.16.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Feb 2024 16:16:39 -0800 (PST)
Sender: John Kacur <jkacur@gmail.com>
From: John Kacur <jkacur@redhat.com>
To: linux-trace-devel@vger.kernel.org,
	lkml <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Daniel Bristot de Oliveria <bristot@kernel.org>
Cc: John Kacur <jkacur@redhat.com>
Subject: [PATCH] rtla: osnoise: timerlat: exit with EXIT_SUCCESS when help is invoked
Date: Fri,  2 Feb 2024 19:16:07 -0500
Message-ID: <20240203001607.69703-1-jkacur@redhat.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix rtla so that the following commands exit with 0 when help is invoked

rtla osnoise top -h
rtla osnoise hist -h
rtla timerlat top -h
rtla timerlat hist -h

Signed-off-by: John Kacur <jkacur@redhat.com>
---
 tools/tracing/rtla/src/osnoise_hist.c  | 6 +++++-
 tools/tracing/rtla/src/osnoise_top.c   | 6 +++++-
 tools/tracing/rtla/src/timerlat_hist.c | 6 +++++-
 tools/tracing/rtla/src/timerlat_top.c  | 6 +++++-
 4 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 8f81fa007364..839257e5925d 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -480,7 +480,11 @@ static void osnoise_hist_usage(char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index f7c959be8677..457360db0767 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -331,7 +331,11 @@ static void osnoise_top_usage(struct osnoise_top_params *params, char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 47d3d8b53cb2..81c6160d1757 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -546,7 +546,11 @@ static void timerlat_hist_usage(char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
diff --git a/tools/tracing/rtla/src/timerlat_top.c b/tools/tracing/rtla/src/timerlat_top.c
index 1640f121baca..3e9af2c38688 100644
--- a/tools/tracing/rtla/src/timerlat_top.c
+++ b/tools/tracing/rtla/src/timerlat_top.c
@@ -375,7 +375,11 @@ static void timerlat_top_usage(char *usage)
 
 	for (i = 0; msg[i]; i++)
 		fprintf(stderr, "%s\n", msg[i]);
-	exit(1);
+
+	if (usage)
+		exit(EXIT_FAILURE);
+
+	exit(EXIT_SUCCESS);
 }
 
 /*
-- 
2.43.0


