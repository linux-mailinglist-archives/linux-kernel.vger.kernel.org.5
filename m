Return-Path: <linux-kernel+bounces-140808-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA6688A190C
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 17:50:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1017B1C214CF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 15:50:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E73626215F;
	Thu, 11 Apr 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="e6pZAw7z"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BA585EE78
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849585; cv=none; b=gr44LS6dPHbredPaLy9NzP7u1m0wK0z+wsEIxIXamP1JXPcGY0BEwk3STIQn5Sipw8R23ARpc8UQAoVgr2A4aJVWiQowO8gd5h4MrHj1GliatkNd3yW03sIo7Q5KFAZbfIzCDuZjfSk6RF4ghHZccIWZC2xoF5tE2ZwuUf+Xgag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849585; c=relaxed/simple;
	bh=eEDszxx90e01yTgxIruX4KzqPdDS75YhCXkv6EuBqi0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qKdIXNqke6W//Fk5rWm6ZKXmf46uR6L92/cjqLfChdM7e8nEZnnNUAZgQTeob2uEdlprzRT+wuIKLy/7xmQRTBiVwRXK7UcCnDloIye+mYhxTVLAwRB8WEUyWxH2DKWK1hV/ali2C7UdzTx+GLk71qMZiGJeOPPX15A8vJFFPCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=e6pZAw7z; arc=none smtp.client-ip=209.85.166.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7d0772bb5ffso180606939f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849583; x=1713454383; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UJJ4D05S2wvbc3NuqE+NgrEAsI3iKLR+9IYZJ85rzug=;
        b=e6pZAw7z4YMDXHut91EJ1/FXliUL4YkEJ+nr+Bh/Aq90VEimvDUZgGquU6Cc1fxtHA
         qwmmjPut382ahpkSEQIpkVDXTc1GnrfvM7uglFSJsIXB7QcLxAJEUUMP91YyUKh5KxlP
         OuMrAah1qeq3+TVvj/0elcY60i0v6L2fy3m4Vj59nFjYu175kQiZeBPyjmyIiB/3Kcoe
         2fiP9UXOgWgBBmqcehOTQp7LnzbiJF77Emtse2U72diFsoH2VlNIGMhsfXPROBnNuDaM
         TU7/Yd5n6zfz0OxzfEcYTQ8EFFZATpbBhQHgS1iEsahWVbrUCfXGNIm8rzmYeqGf343h
         gqkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849583; x=1713454383;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UJJ4D05S2wvbc3NuqE+NgrEAsI3iKLR+9IYZJ85rzug=;
        b=tpjVUHAIuWpxiz0nElsU6GQMDiSrYgiVdaXRVlBphcZYM29e954ptznTVkjg9m8oRT
         G+qaE1ga1HJHdjsNh6Ehg5OiweRfhMhBpw3F3OA6EAfGbGHvSyXRqNjmkWXK57W7RwMj
         ym78DjAfEHpAeQwkBWcAW6cQvAufLst6115RnDGgboXmythFr0eQPw+BU77YY3cs7lcs
         rggdVF6ES5oHFohA/00sXCURu+H0bXoCCciaGQwnULEJFYzCoskF511lQnoszeov0jMA
         xhS5hgb15NZ2z1fWexJ9RN6MKKOncUrxC1fJtKO894vILK1EGkTy+x3DMgCtc91vilpW
         m/5Q==
X-Gm-Message-State: AOJu0Ywz+Smvf5fUZDjgxs4wy1HJ5Grzi3Uw/rmJxUQ4sbFXunNlSlRd
	i8sbPuHg642xk2xb45XMmdrJ+WF6BipcmSF8iTRMsvF1Lqwwi+Acmads5ecN5/foXvyWipjaTYs
	i
X-Google-Smtp-Source: AGHT+IEBXluKVIcgYEXMNqhn8o98ctkqvjHt3mNorwGjYRNT/NJ+u70P6y5LlaRfMJ7Pee7O5rdP2A==
X-Received: by 2002:a05:6602:4ed7:b0:7d5:ddc8:504d with SMTP id gk23-20020a0566024ed700b007d5ddc8504dmr180218iob.0.1712849582880;
        Thu, 11 Apr 2024 08:33:02 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.33.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:33:01 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 048/437] ubifs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:13:08 -0600
Message-ID: <20240411153126.16201-49-axboe@kernel.dk>
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
 fs/ubifs/debug.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/ubifs/debug.c b/fs/ubifs/debug.c
index ac77ac1fd73e..2d63f57aca6f 100644
--- a/fs/ubifs/debug.c
+++ b/fs/ubifs/debug.c
@@ -2728,6 +2728,7 @@ static ssize_t dfs_file_read(struct file *file, char __user *u, size_t count,
 
 	return provide_user_output(val, u, count, ppos);
 }
+FOPS_READ_ITER_HELPER(dfs_file_read);
 
 /**
  * interpret_user_input - interpret user debugfs file input.
@@ -2801,11 +2802,12 @@ static ssize_t dfs_file_write(struct file *file, const char __user *u,
 
 	return count;
 }
+FOPS_WRITE_ITER_HELPER(dfs_file_write);
 
 static const struct file_operations dfs_fops = {
 	.open = dfs_file_open,
-	.read = dfs_file_read,
-	.write = dfs_file_write,
+	.read_iter = dfs_file_read_iter,
+	.write_iter = dfs_file_write_iter,
 	.owner = THIS_MODULE,
 	.llseek = no_llseek,
 };
-- 
2.43.0


