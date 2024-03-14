Return-Path: <linux-kernel+bounces-103419-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC4A487BF28
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:42:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19DFB1C20F2E
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 299E770CCF;
	Thu, 14 Mar 2024 14:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fbMyShOX"
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C63CA5D8E1;
	Thu, 14 Mar 2024 14:41:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427311; cv=none; b=p51c6XappAXUFw0mMX8iHFy0FccTpwcdrksmXdasehHlTSMNGcz2vjY9Gy+DCXATQUuJNfdKFr9E9XdwbB38C27l2S1PUhUcCoxHxeNVMtl/f3ewFuVboXjqqgGcYKV5X0pl2DZIvkrT/5k051YiWsEi7kjOutNKsKBD4XgMGQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427311; c=relaxed/simple;
	bh=xCKos6m+qO/1NTZ2a29UZtZ7oTOa927jk2hKnM8gv0E=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lmN9ZPYANoArB/+hHIbIUDABjxcf7xK/ox0jDG/7BvbVZbMsHIrzFu+eMTPPQCucVmxYpgDL3mk/NAfG6LNZkmN5D+1c3mdkJVONg7B/eOVcWLdbuUZJ9ibwOIrL3Pitl+BfCWHU2yaTS2eQBu3PRnk7XjSw9l4M9vahlVVmMuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fbMyShOX; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-563c403719cso1378756a12.2;
        Thu, 14 Mar 2024 07:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710427308; x=1711032108; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=75BC6XDlPW+OQKaG6vOoT6p3GK8R3Ey/ersuUXrKyEo=;
        b=fbMyShOXCTunAT8LeozXoXpY+2OOlGdxywM9GiYMUAqEH5fJf7OR0STy0IWyxBnU3B
         glV8wyotVMCKAhaVso9EXazg4CJioFKnoKx/0x1okFB5p/Isr1AyzURmq34ySitG495B
         PY82a5WiyPUcRjO+O+vRvtV0XJgq57h1a3OewhawK/8d/f36RDB2p7t6UkfNOOZqCwbc
         fhi7YQHwf/b3YCDWWWFKmfW9MCboExb0E+Ayh3S0blWS3ukY3jIGwGbgCweC0SzVSYms
         2gtGD3ezOywukLcMhqkGDfBlEEF+e5UP5F3kGJM4WtEvOMK0+C5V5BGMtMWWRHBYYHNO
         hIXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710427308; x=1711032108;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=75BC6XDlPW+OQKaG6vOoT6p3GK8R3Ey/ersuUXrKyEo=;
        b=XU7XpGzsxOb672trzJuvDDpjVl66N5wTyhfyywGDoxXLf1a8dRtjdTYedumrdtkr6b
         jmpv08jbxoDMBVdc14IRNHmoC33XykYSBhwAxq3fKLyiTfs0IjsZEht4PDH+Ki09QRfc
         1jdxDAYouS+O/RylgMeiBH3myYdvm342+TZFsBUGOCVsChxyvE2Ri9P/Crh0XyZhpGFt
         F1ZszsNlGxocA0HxEiivi1Kh0iYiAMgH94+eMvfflu3e0D5Rz3M0rPTk0ERYKhZ7k6nO
         UURPOjC4rZh9jMRVOoIcRPhSlfk7eJhCcrI9tUU8M0y41TYrqeVo2LYMPqk8HKSLG7vg
         pr4w==
X-Forwarded-Encrypted: i=1; AJvYcCX3rR9imic7C26TrP0+Spc+0P4fFEEqVzVulXDv6JoctoaBP8ZI0im7BnnaUcS65L1DSwCmQm/GSNBOF/6VKsFd6+l14jYjRcuRYWW9vWNfpKJsAf9ebrUVozNozxNpWNwi/24DgI1X/H7iqfThjfCi6Bspb2BdSjUMyOQE7nzq45oVI1GkQ9ekbDGh
X-Gm-Message-State: AOJu0Yz4Wx6iT86o1H+oh5NgarihfIrV9ejaaOFQh+q1oY2GaJLQ6+35
	lRQ0lJqMbIPlFUYeKQ4+VprGLL31ruVggk/sJjIddZTfjHpNENuA
X-Google-Smtp-Source: AGHT+IHTqh9aG/rjW5FKqqfRc5+QuUQ4b1bMVoiK7Wo1Vj9FaO/R3di1Xw0hvyjU7Xs0/dNC6/c/7w==
X-Received: by 2002:aa7:d409:0:b0:568:9f10:7d33 with SMTP id z9-20020aa7d409000000b005689f107d33mr951979edq.42.1710427307921;
        Thu, 14 Mar 2024 07:41:47 -0700 (PDT)
Received: from localhost.localdomain ([213.55.225.17])
        by smtp.gmail.com with ESMTPSA id fg3-20020a056402548300b005682f47aea7sm769570edb.94.2024.03.14.07.41.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 07:41:47 -0700 (PDT)
From: Ali Zahraee <ahzahraee@gmail.com>
To: rostedt@goodmis.org,
	mhiramat@kernel.org,
	mathieu.desnoyers@efficios.com,
	corbet@lwn.net
Cc: Ali Zahraee <ahzahraee@gmail.com>,
	linux-kernel@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org,
	linux-doc@vger.kernel.org,
	skhan@linuxfoundation.org,
	javier.carrasco.cruz@gmail.com
Subject: [PATCH] Documentation: tracing: update format of sched_wakeup in example
Date: Thu, 14 Mar 2024 15:41:36 +0100
Message-Id: <20240314144136.19727-1-ahzahraee@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The format of the sched_wakeup event is used as an example in the
documentation. But the given format is obsolete. This patch updates the
format in the example to match the current format of this event.

Signed-off-by: Ali Zahraee <ahzahraee@gmail.com>
---
 Documentation/trace/events.rst | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 759907c20e75..65fe205c95e6 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -129,24 +129,25 @@ event::
 	# cat /sys/kernel/tracing/events/sched/sched_wakeup/format
 
 	name: sched_wakeup
-	ID: 60
+	ID: 70
 	format:
 		field:unsigned short common_type;	offset:0;	size:2;
+                	signed:0;
 		field:unsigned char common_flags;	offset:2;	size:1;
-		field:unsigned char common_preempt_count;	offset:3;	size:1;
-		field:int common_pid;	offset:4;	size:4;
-		field:int common_tgid;	offset:8;	size:4;
+                	signed:0;
+		field:unsigned char common_preempt_count;	offset:3;
+                	size:1; signed:0;
+		field:int common_pid;	offset:4;	size:4;	signed:1;
 
-		field:char comm[TASK_COMM_LEN];	offset:12;	size:16;
-		field:pid_t pid;	offset:28;	size:4;
-		field:int prio;	offset:32;	size:4;
-		field:int success;	offset:36;	size:4;
-		field:int cpu;	offset:40;	size:4;
+		field:char comm[16];	offset:8;	size:16;	signed:0;
+		field:pid_t pid;	offset:24;	size:4;	signed:1;
+		field:int prio;	offset:28;	size:4;	signed:1;
+		field:int target_cpu;	offset:32;	size:4;	signed:1;
 
-	print fmt: "task %s:%d [%d] success=%d [%03d]", REC->comm, REC->pid,
-		   REC->prio, REC->success, REC->cpu
+	print fmt: "comm=%s pid=%d prio=%d target_cpu=%03d", REC->comm, REC->pid,
+        	        REC->prio, REC->target_cpu
 
-This event contains 10 fields, the first 5 common and the remaining 5
+This event contains 8 fields, the first 4 common and the remaining 4
 event-specific.  All the fields for this event are numeric, except for
 'comm' which is a string, a distinction important for event filtering.
 
-- 
2.34.1


