Return-Path: <linux-kernel+bounces-165855-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92D4F8B9268
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 01:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 48F2E1F21D88
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 23:37:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8C9168B1A;
	Wed,  1 May 2024 23:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kuMxEqdL"
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E2DD43AC3;
	Wed,  1 May 2024 23:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714606633; cv=none; b=LiU/sefeT5hKB7ERyi9XT9qRp7JUh3E7cRAMrslq7Z58AHldMlcn59rE42NBSumKAulXRhUm5zQsmIlc1EHMazsqd6vz3J6yq8SUWkRzsldsLzjrbGDbSX8rjd/eut35ql1pbsy2pT77VlTJzXqiiqtH+g/yBov+NaNNCBOwmz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714606633; c=relaxed/simple;
	bh=rnl3c4G/tQscwHdO1WvhkGb3RuY0yplXQv/UgVy5H2I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Z3W4cClLWDvwRW1Hm/h8VY8mk9tIRbNDXfyNsWO5ACRsfeagu5guSLGC1NFxmHMDl0boqxIweHHzmvVbrvJ98NZVorvkW6wALh8cK4dryWoJ0gYTzcSalZwAVOIOYnIOZjpUU6wBtZLa0IhagGtA9ZQvdJZVTW6DwigFC1oehOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kuMxEqdL; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6f42924ca64so696020b3a.2;
        Wed, 01 May 2024 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714606632; x=1715211432; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WKj4Cu5JwcGHu7MqkGml23dMliHgLjGgTV4e25b7pDA=;
        b=kuMxEqdLpWUTtZrl5mL9DvNgY8qhPYD9aEWYf5yJdycT68THMNJ3zCTA4PUMhzaFDJ
         C4wH/wZHkqDG8C4yJDxGLjjLnmHn1OqxxllWAYgA4sicUXSRnbzR486McM4uwUZbR6+7
         K7gavl0PxqFTIF5Z8pJvP2OOs3cySXMqwS6lEVTfgoV+SwpHx1KFWI5Z4MAO5EPT1Zbe
         Y1JOboj4I11nOOdtSlV6u0G6Py5/QYS6jIsyqXOz4OM9/j71Sxs5aHxAhw4/mgNvaogO
         EzUfOb9c2VyomMGIaGIqITuvloQgQKa9M11eXDuWjw8eESBz2Lk2lNH1F6B/ypnlvXT4
         fcgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714606632; x=1715211432;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WKj4Cu5JwcGHu7MqkGml23dMliHgLjGgTV4e25b7pDA=;
        b=E+AgGiA/yTwJ2qCCjyYmQe9Ygr2FteIjkNVQhj1773xJ4M+pOav8PoLkvN85e1D01/
         36SDmLzPoCpIOyujzsCZuPtY5VyfGl3RKVA5aLEOOqcQ15d1vzDRmV1N1pn8h18OUTst
         oUyb4bEoN/hcfVjJ6RAJb5S5FcmEBgug/C1dPBKTaJ+ySdrsWEOjgYO/KNFn7+H2MBom
         0rhsVaz00ZIElDj0LB8dWvPHbLVoIrZBXdhibEU2ml1h3mMOEiBssN3ReWvryqpAnGcr
         2qVImwBsEYg83UoqNBRPC6LFN/meo8/MpNTfa7qSDV6gKdIcymrvxK63xTOgyufzUHwR
         SJSA==
X-Forwarded-Encrypted: i=1; AJvYcCWu2Pc2e+TS8j2WKc0MJ/uJR61mpT45wG6x3BFwEk+jNFaMzKgX0pf0LnGz/o7JOFfIoLCxwT+CYuFFe2HCRVvo/w4UkTPs6NFhXvnrZzrbtZF3oxY10c9KkMt9BqfsOZeyZM6OQ8Z47aISrYCgFE7ChkvV/O2Twl4J69eF2rJ7wvilPuKXqs1bCgBm
X-Gm-Message-State: AOJu0Yw/CIR8V2iZTy+m//bQ9D7E1HrUZ+eMHjtRLXnxSDMstf13UFVv
	gZEp9tm33VyzMwpwAGeLa6Pt+hW51ONv0SDllokmIdE4ufnBzMUZ
X-Google-Smtp-Source: AGHT+IGFR8pm1CNFzIVNLm94eUZlW4x5k9oMkl+Qqu09gm0jdDYqmsno4wWdEkryf2l3k56EpgQfqA==
X-Received: by 2002:a05:6a21:2d86:b0:1af:66e6:bfdf with SMTP id ty6-20020a056a212d8600b001af66e6bfdfmr5105308pzb.15.1714606631351;
        Wed, 01 May 2024 16:37:11 -0700 (PDT)
Received: from kerneldev.. ([171.76.83.90])
        by smtp.gmail.com with ESMTPSA id r12-20020aa7988c000000b006f41798fde5sm3075463pfl.214.2024.05.01.16.37.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 16:37:10 -0700 (PDT)
From: Saurav Shah <sauravshah.31@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	mark.rutland@arm.com,
	corbet@lwn.net
Cc: Saurav Shah <sauravshah.31@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org
Subject: [PATCH] Documentation: tracing: Fix spelling mistakes
Date: Thu,  2 May 2024 05:06:59 +0530
Message-Id: <20240501233659.25441-1-sauravshah.31@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix spelling mistakes in the documentation.

Signed-off-by: Saurav Shah <sauravshah.31@gmail.com>
---
 Documentation/trace/fprobetrace.rst | 4 ++--
 Documentation/trace/ftrace.rst      | 2 +-
 Documentation/trace/kprobetrace.rst | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/trace/fprobetrace.rst b/Documentation/trace/fprobetrace.rst
index 0f187e3796e4..b4c2ca3d02c1 100644
--- a/Documentation/trace/fprobetrace.rst
+++ b/Documentation/trace/fprobetrace.rst
@@ -74,7 +74,7 @@ Function arguments at exit
 --------------------------
 Function arguments can be accessed at exit probe using $arg<N> fetcharg. This
 is useful to record the function parameter and return value at once, and
-trace the difference of structure fields (for debuging a function whether it
+trace the difference of structure fields (for debugging a function whether it
 correctly updates the given data structure or not)
 See the :ref:`sample<fprobetrace_exit_args_sample>` below for how it works.
 
@@ -248,4 +248,4 @@ mode. You can trace that changes with return probe.
              cat-143     [007] ...1.  1945.720616: vfs_open__entry: (vfs_open+0x4/0x40) mode=0x1 inode=0x0
              cat-143     [007] ...1.  1945.728263: vfs_open__exit: (do_open+0x274/0x3d0 <- vfs_open) mode=0xa800d inode=0xffff888004ada8d8
 
-You can see the `file::f_mode` and `file::f_inode` are upated in `vfs_open()`.
+You can see the `file::f_mode` and `file::f_inode` are updated in `vfs_open()`.
diff --git a/Documentation/trace/ftrace.rst b/Documentation/trace/ftrace.rst
index 7e7b8ec17934..5aba74872ba7 100644
--- a/Documentation/trace/ftrace.rst
+++ b/Documentation/trace/ftrace.rst
@@ -1968,7 +1968,7 @@ wakeup
 One common case that people are interested in tracing is the
 time it takes for a task that is woken to actually wake up.
 Now for non Real-Time tasks, this can be arbitrary. But tracing
-it none the less can be interesting. 
+it nonetheless can be interesting. 
 
 Without function tracing::
 
diff --git a/Documentation/trace/kprobetrace.rst b/Documentation/trace/kprobetrace.rst
index a49662ccd53c..69cb7776ae99 100644
--- a/Documentation/trace/kprobetrace.rst
+++ b/Documentation/trace/kprobetrace.rst
@@ -74,7 +74,7 @@ Function arguments at kretprobe
 -------------------------------
 Function arguments can be accessed at kretprobe using $arg<N> fetcharg. This
 is useful to record the function parameter and return value at once, and
-trace the difference of structure fields (for debuging a function whether it
+trace the difference of structure fields (for debugging a function whether it
 correctly updates the given data structure or not).
 See the :ref:`sample<fprobetrace_exit_args_sample>` in fprobe event for how
 it works.
-- 
2.34.1


