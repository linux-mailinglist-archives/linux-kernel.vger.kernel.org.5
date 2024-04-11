Return-Path: <linux-kernel+bounces-141103-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2478A1AFC
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 19:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 64BEAB2CE0B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:55:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A9731635AB;
	Thu, 11 Apr 2024 15:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="mFnasMKk"
Received: from mail-io1-f42.google.com (mail-io1-f42.google.com [209.85.166.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208224C629
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712850040; cv=none; b=XYPbFNEaQNPPEYm8Z/deX93L5AXsAze6WYTL9adwstZ632lFGsBj/ZCZtoIxQ80g+TDQGeCtQzx60AYyG//0jyuysjzJbTntxvjp1bXaMTGut5HSDyMeRcOdzfvfipMqt/hpqoUFqDPB1gZBWFc82q3Z5txEXNfVbh6E9ANHWBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712850040; c=relaxed/simple;
	bh=AwZXzKiJTYRdXaYdXL0N+5qs7IS58CqVmTMpxbbdZaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gk3uUQ9uC3Bkr51IjpAQzhPtKFyHzDZNcKSwkC67NTJGpozy5rft0KbcnCS4OfTg2UP0M5NrRrYjr979G4Qm5tO9rHw685YQXvTYfoOCq0358W/x/89CjppItYp3wGCRZBpOLdh4SUsuL8So1NHyHC9nf9SdvHNqVMCW6Op67LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=mFnasMKk; arc=none smtp.client-ip=209.85.166.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f42.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9054339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:40:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712850038; x=1713454838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3b8H2/mDLiAhX37cZSYPDjNbHw29AJDHtMyBA0JRgZc=;
        b=mFnasMKky60oAJVkFsp87uOj+S336QaUrkbM9guUFFNxGRvLonPFZi0Y+0mxGfM1zr
         xZCtgBb3zEmQ9uyu3QeXOavy235KDAPsfZqwefo8Q2WzWH6M1SC7qe2WEZl9JBZuMh9W
         LPpHmB6++qtp+EHtqH+yi5pKhHDZu2BLqM2+kI+zzOXhuPSmF3wzso8QKpCAgBHvqVpU
         M/kvTw0iQokKhdKoEB1GdwgyfI6i51K+lSX+t48nbid7WHuKlXNXHRUxEIY3mK6PvYPC
         REdfSgucgDL+9UOA3wcuVmlxyL/WF11vb1zyD+jRx573+hZXvK2VOmVi33b/QfilXtYJ
         vjHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712850038; x=1713454838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3b8H2/mDLiAhX37cZSYPDjNbHw29AJDHtMyBA0JRgZc=;
        b=jfC48eA5vRKKy/IeE7DqC7hw4J07eBibhGNZfIpWU4a9Q0c8lSmSBjE218AAjlWAw0
         zaurU/O9KRLN247YYghwHIuRWUcp1I/QymnhkoTB+3a3x+cbR3KmRidgC4ZCn0czxlpk
         l9YUG13fgRL9sxBF1rOlmH4bs/Cm/RBdaD0Ik3RKRwjbUhwhXM9uTsq6SzNeZV+BKjp3
         IoItdlxSyAiY3rJ5MeWA/J9We2KT8FkppemgdvtNQ8h/yK+yfsw+uVoSfG0VblD64j/u
         MHYzsW5HmAGhY7jZiyj9kC/iDnEZFMPhI3skQx1PKs3tw2NwfKeIiqpKgxAjLWzzhghC
         x8rA==
X-Gm-Message-State: AOJu0YxU1egjzY+YHkz5WvJT5XEhMuxLfGG+Rv7fDq1xBlN0xb+ON5Ls
	IBteRDOAy1kmgBpS9znG4d7Ji5blfbVgBKleKPrHq2nTbNdMEmrbXZH7XwPlhegdRuIOzdi6bC7
	Z
X-Google-Smtp-Source: AGHT+IGHs7bJvGdPqJOq2+aO4KrAh02ZIW+nmTYfdMU0CaErq8ymPLXcayxdXoWJ/ANllrLIUlMeNw==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr192471ioj.2.1712850037856;
        Thu, 11 Apr 2024 08:40:37 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:40:36 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Bui Quang Minh <minhquangbui99@gmail.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 325/437] drivers/net/ethernet/hisilicon: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:45 -0600
Message-ID: <20240411153126.16201-326-axboe@kernel.dk>
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

From: Bui Quang Minh <minhquangbui99@gmail.com>

Signed-off-by: Bui Quang Minh <minhquangbui99@gmail.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 .../net/ethernet/hisilicon/hns3/hns3_debugfs.c    | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
index 807eb3bbb11c..0ea141e12655 100644
--- a/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
+++ b/drivers/net/ethernet/hisilicon/hns3/hns3_debugfs.c
@@ -1257,10 +1257,9 @@ static int hns3_dbg_read_cmd(struct hns3_dbg_data *dbg_data,
 	return ops->dbg_read_cmd(dbg_data->handle, cmd, buf, len);
 }
 
-static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
-			     size_t count, loff_t *ppos)
+static ssize_t hns3_dbg_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct hns3_dbg_data *dbg_data = filp->private_data;
+	struct hns3_dbg_data *dbg_data = iocb->ki_filp->private_data;
 	struct hnae3_handle *handle = dbg_data->handle;
 	struct hns3_nic_priv *priv = handle->priv;
 	ssize_t size = 0;
@@ -1301,8 +1300,8 @@ static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
 			goto out;
 	}
 
-	size = simple_read_from_buffer(buffer, count, ppos, read_buf,
-				       strlen(read_buf));
+	size = simple_copy_to_iter(read_buf, &iocb->ki_pos, strlen(read_buf),
+				   to);
 	if (size > 0) {
 		mutex_unlock(&handle->dbgfs_lock);
 		return size;
@@ -1320,9 +1319,9 @@ static ssize_t hns3_dbg_read(struct file *filp, char __user *buffer,
 }
 
 static const struct file_operations hns3_dbg_fops = {
-	.owner = THIS_MODULE,
-	.open  = simple_open,
-	.read  = hns3_dbg_read,
+	.owner     = THIS_MODULE,
+	.open      = simple_open,
+	.read_iter = hns3_dbg_read_iter,
 };
 
 static int hns3_dbg_bd_file_init(struct hnae3_handle *handle, u32 cmd)
-- 
2.43.0


