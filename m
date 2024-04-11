Return-Path: <linux-kernel+bounces-140807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2C98A190B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 964EE1F219F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:49:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3534C5EE97;
	Thu, 11 Apr 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="QyYyMrEK"
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 438C15B5BE
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849583; cv=none; b=AErvm48h26F1vuVHcsgCEt2OT07D6+5LcFIkrBVUHt29DxuWnQ0exa1Bje9twl7q2l/4n6Hb5/xEaNt00w4S8jqkpWYkcR7xv74DXn1dciKgRDSakqP8ETnaMrvV8aZr89O6W1YIAduptJKiiwmURqp439l0KJua48QJlyF/Oss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849583; c=relaxed/simple;
	bh=VYdHrQPHjHk6TOg8Bd0CL+/UEVjJJ17BEwTYJLTtitQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R1sz7MGwhEfkgFKmDiRIXvHN+qFXpGi0GHSEhzgwGAulk/7UMl1e/u+qoW2SzZvhvMNSB+f/UnrRbsmXo5ZXpAKZIDFIWMGvHI7ESG5qeFbj7niDmvKiezp4YCNebsQZH1IbCzv8389YacjEN1b8ukxop9F2xUQQ07N99GbA6g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=QyYyMrEK; arc=none smtp.client-ip=209.85.166.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7d5ed700c2dso16110339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849581; x=1713454381; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iZXIzxEuADUwq6kTEiiPPm2btK30iW121DAZDPyFE4s=;
        b=QyYyMrEKvgb0j+lvq23A72xS8rmQMQbfCFqo4bYgbDXENyL0P9c0G747WTbA75PGoC
         3OmVbD7GE0BAxfYMPch3EypcMPfT2mzzd71mjzqiHkjrKX2SWVA1Dw+g8U070jk9/Wpt
         S8MS7y/V5VcGjKSULrduDtFmHtdK+dTp/v/IczUrLmwvtGFdjl4zFlDeRHWj7i4iFQPe
         oqYKqgK108KFULZYpQwDIgZ9Wu+y/rReRFgrdumgkwfkN7Kq749foRY4+MN8bwMMPEQt
         3bm2zH1JGMTfHvQ60T9bMkzaWPuA0jFaXI9afHrEz2YC/TgwIIHh8Figza5rYf5c+B4D
         ta6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849581; x=1713454381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iZXIzxEuADUwq6kTEiiPPm2btK30iW121DAZDPyFE4s=;
        b=NxLr5cFHPhx9ydVkUJbyBZyOD/fLK5v/tUF3SXwM5Zlka34ZD7lZeSljUhu0Z5Tf1E
         B8Qlti4Otj2PJASGYTJ0dmr5o9sd7j4vMgTpOEUgHxYcSWJ4RVXioA33TgDZAbfG2m5E
         8plfLNaYGsLkrnRELuhvisHQMc5jPplV/CKVVPGfiZ/F0MflILfH3cQRP3euvzBkC6Jl
         ORXcgryQn5HLbrKyHnmQDiyeFNL4CK9gzZv69IcZ7IRPiot2iZ8Uml0SDv7JsIsEmx4z
         MNTfSX++exzNBsZrDzdCORdoAnoUfnKq4tA+VtCFYhhbat+JpbLfV8FDgsowSlB1Wrrs
         Ujeg==
X-Gm-Message-State: AOJu0Yxi0+wgKmP31wQ5ChFvLWJ109opraLuu2sVwHtscHevS1MkUIPa
	fug75P0ImT3ZuOFCc1Rw+ms8Ty2f3kvcisi2FVa4THcy4hHgUDjllR6BZmHpfUiIRkOzAWD6vQM
	n
X-Google-Smtp-Source: AGHT+IEaTaSNAkf6w73kY7rrd2sogk5dWCpmbVi/gQTNQu+tf0zhdnoEnKRhPJQFGVd7sfOJ5iyQ+A==
X-Received: by 2002:a05:6e02:1fcb:b0:368:efa4:be12 with SMTP id dj11-20020a056e021fcb00b00368efa4be12mr7838420ilb.3.1712849581015;
        Thu, 11 Apr 2024 08:33:01 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.32.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:32:59 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 047/437] tracefs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:07 -0600
Message-ID: <20240411153126.16201-48-axboe@kernel.dk>
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
 fs/tracefs/inode.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index 5545e6bf7d26..b1a9b5f10581 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -46,21 +46,19 @@ static void tracefs_free_inode(struct inode *inode)
 	kmem_cache_free(tracefs_inode_cachep, get_tracefs(inode));
 }
 
-static ssize_t default_read_file(struct file *file, char __user *buf,
-				 size_t count, loff_t *ppos)
+static ssize_t default_read_file_iter(struct kiocb *iocb, struct iov_iter *to)
 {
 	return 0;
 }
 
-static ssize_t default_write_file(struct file *file, const char __user *buf,
-				   size_t count, loff_t *ppos)
+static ssize_t default_write_file_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	return count;
+	return iov_iter_count(from);
 }
 
 static const struct file_operations tracefs_file_operations = {
-	.read =		default_read_file,
-	.write =	default_write_file,
+	.read_iter =	default_read_file_iter,
+	.write_iter =	default_write_file_iter,
 	.open =		simple_open,
 	.llseek =	noop_llseek,
 };
-- 
2.43.0


