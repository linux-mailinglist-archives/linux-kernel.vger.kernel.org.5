Return-Path: <linux-kernel+bounces-140899-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B636F8A1977
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E14D61C2336A
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B065815DBD1;
	Thu, 11 Apr 2024 15:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="PyFaYsFw"
Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC5E15CD7E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:35:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849730; cv=none; b=kcd5l8F7WQ9pI6ekPRmcLIo0gZW0W46PlLxNh0jM4mIm/6FrG/Ddkf54opWdtaU+gm4UDn5uwA1qhCfVldUoMFBBP7CI1WBdcG/6eo5zdB5v6FgrHwFjIkSyR++HTjYsg5EBW2qlEG2YltQuqdFXnKrLpzOyVJp3sfYTM7dP8gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849730; c=relaxed/simple;
	bh=hLULojXi2IM52qf7CXXJXO6GRH4vl6JLQfzNiql+XCo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iKdKSvj2IRw1fnXfykfBpjOM9R8yUWSn9x/LnYFkJnAyC8trF6lSRK6i+b7RzYeKc2GxuTmVrrkLrT9P+MzSJOBpsZxLj9U184EHoDIn6Q8UtZj8+xfqJowYp8vANan8/3pvfGSF4MlCKYFgeMWu/upeWYf2rya9A+R4uSaZ6XA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=PyFaYsFw; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-7d6112ba6baso58049739f.1
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849727; x=1713454527; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mUkAf1+OBf+yGe/VzApEZjfPh2gbVfNKY1ge8fZZPGY=;
        b=PyFaYsFwC/gMX/g9Ku3LRgPB4S1suRZ+8LmTElb/Ngne0DCY0XiIrlbt1QZd/qWMNU
         LYA2/z+RSPOkwVMmFfoE4f+UDltgx8V8AZyjabNxbfuJn8RMWmqsuCFne6hRhMcOF3nc
         oAIVQ/9LpnV18XkXk/dckAXeAJ4wEXd3pyi5eiKEYkxqgFyufTT2qdm2j7XHQVTCEElP
         aZTBbN21rzrwJTg/twc4agvtBZajtJqubfzu1f8350xPA2wb1hKiTzT9BZMAgk6kYuGF
         dsl+WB27/kQouuLxbUwL08GPgtRxUdTOFhnuLoqdjAp1FDwLin7n2AQ+BCl2jZjr3nrY
         o4Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849727; x=1713454527;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mUkAf1+OBf+yGe/VzApEZjfPh2gbVfNKY1ge8fZZPGY=;
        b=NfzhoTbBZ0xyk16Y2S3Rv4aNwGrmbOAACLRW7jrmEUmGe4oQKmHfgHITlDO7yRKKwA
         I0vIXMRQsQ6a6eqD3hPUqDpHIC96sMReZ45L/dF2Kb+h8NvPgoGn6FPDQMjY9SV+JObQ
         HxLJglzxUWJky/qlS2kjn0yH9tzcdwIMIYP1Hk74LkNJZLxFgcJMTqZOAwH3OVUjm0xZ
         Ir44dbWoxJOJ36DL6Xp1UytY5QfScFrbiey7ep4cowvYjU96iLK9VmHGIHdX5WdcK+2h
         DcwkU8BAT3b4o5hjApb58JOmjGR+xBHnB/ewigW7q9bv89GjeD8bxoMpFr0xvaAFvf1N
         dhNw==
X-Gm-Message-State: AOJu0YzE8G2eo1FZSQEK31YmVHZ2ZUW/sMAXImmcYGK3orbB1n0gu0GR
	ib3+upNjlyo4bLxROZq5lt0uzfH5jWrQEUbEd/t4iV4oerbEV0GlCtMU3DnVuAM/kJ7Tik6umRJ
	p
X-Google-Smtp-Source: AGHT+IHdSBGEx9c+KGSUWdxyv/iVHbgbODx2N7GJSLklX14JaW0lw2/k+U2YQF2EmyIiA9bprZ6/XQ==
X-Received: by 2002:a05:6602:38d:b0:7d6:513b:254 with SMTP id f13-20020a056602038d00b007d6513b0254mr181666iov.2.1712849727634;
        Thu, 11 Apr 2024 08:35:27 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.35.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:35:26 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 135/437] fs/notify: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:14:35 -0600
Message-ID: <20240411153126.16201-136-axboe@kernel.dk>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240411153126.16201-1-axboe@kernel.dk>
References: <20240411153126.16201-1-axboe@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/notify/fanotify/fanotify_user.c | 6 ++++--
 fs/notify/inotify/inotify_user.c   | 3 ++-
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/fs/notify/fanotify/fanotify_user.c b/fs/notify/fanotify/fanotify_user.c
index fbdc63cc10d9..52b97f6c2285 100644
--- a/fs/notify/fanotify/fanotify_user.c
+++ b/fs/notify/fanotify/fanotify_user.c
@@ -868,6 +868,7 @@ static ssize_t fanotify_read(struct file *file, char __user *buf,
 		ret = buf - start;
 	return ret;
 }
+FOPS_READ_ITER_HELPER(fanotify_read);
 
 static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t count, loff_t *pos)
 {
@@ -900,6 +901,7 @@ static ssize_t fanotify_write(struct file *file, const char __user *buf, size_t
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(fanotify_write);
 
 static int fanotify_release(struct inode *ignored, struct file *file)
 {
@@ -984,8 +986,8 @@ static long fanotify_ioctl(struct file *file, unsigned int cmd, unsigned long ar
 static const struct file_operations fanotify_fops = {
 	.show_fdinfo	= fanotify_show_fdinfo,
 	.poll		= fanotify_poll,
-	.read		= fanotify_read,
-	.write		= fanotify_write,
+	.read_iter	= fanotify_read_iter,
+	.write_iter	= fanotify_write_iter,
 	.fasync		= NULL,
 	.release	= fanotify_release,
 	.unlocked_ioctl	= fanotify_ioctl,
diff --git a/fs/notify/inotify/inotify_user.c b/fs/notify/inotify/inotify_user.c
index 85d8fdd55329..bdc424a79e3c 100644
--- a/fs/notify/inotify/inotify_user.c
+++ b/fs/notify/inotify/inotify_user.c
@@ -297,6 +297,7 @@ static ssize_t inotify_read(struct file *file, char __user *buf,
 		ret = buf - start;
 	return ret;
 }
+FOPS_READ_ITER_HELPER(inotify_read);
 
 static int inotify_release(struct inode *ignored, struct file *file)
 {
@@ -357,7 +358,7 @@ static long inotify_ioctl(struct file *file, unsigned int cmd,
 static const struct file_operations inotify_fops = {
 	.show_fdinfo	= inotify_show_fdinfo,
 	.poll		= inotify_poll,
-	.read		= inotify_read,
+	.read_iter	= inotify_read_iter,
 	.fasync		= fsnotify_fasync,
 	.release	= inotify_release,
 	.unlocked_ioctl	= inotify_ioctl,
-- 
2.43.0


