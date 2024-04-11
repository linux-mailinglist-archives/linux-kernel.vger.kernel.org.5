Return-Path: <linux-kernel+bounces-141069-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CE5758A1A53
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 18:47:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F6B81F26032
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597511D42AE;
	Thu, 11 Apr 2024 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="BTZ17wky"
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 627231D4287
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 15:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712849989; cv=none; b=CN3dEf/d63TzR8GAy0rRdTletMZp466MHVxQK0ai1OJ9IEerwvQbnhLJvVNqIAtwuzgOdhyI5UBoI07c8Hh/XRCbDPtqRxO+a5JJ3kJsTyjFuTaNPTHimgIG2Uyf8F7nV04MUbzw2LHGV1BpUgANKbwNlAkQRfWU2y3JUp/vV2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712849989; c=relaxed/simple;
	bh=WjK5tt/lcF0gsGNNsa8rRdS16AVptBWg/Fhf3kHfxBM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oiFK0NruItuVDvkQHr9Oj8/fbZVGAixr81lqHumizixidk2IQ2LbKlexpT2A0aRwvOAHl683NnVzUZG+cLca8uWyTW6dV9SgSaKGmdFQYA+CM7DlKe9XzdMsjsFCgFoGR4VQnQ3RJ49BwtxJ+3zfLiQKXoylPnghY3xJ5S4ieyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=BTZ17wky; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-7d6812b37a6so9031339f.0
        for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 08:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1712849987; x=1713454787; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=btfIbjHEzJkQLorNtQGt+Q3lPeOfCGKan/kFhND/Ei8=;
        b=BTZ17wkyDFmWExYVarB6TOwTQLfGcrHnxc0ondUdivVTBaEdPntMYQwDBzv/am38or
         Zhm+J+7tZTjz7rC/7YcYlKImSvLfm/WxfiKEIU4P4Bi1Fm1pJY8ysAEZhWvoIhU9gLS0
         wzElawcZYBZ5jyG34BXcM1nsP9nUu4bvadX7MPDlAjna99t234bx/0j3rcfhN9EhVeBg
         dQwscS4bwKXtL4s3l6RZfgvLgvsKIv+xicp5AIBlg0IpVXthKK+CWcZDi7XUnNzSXe0I
         POEGykAqFRlL5iJFFps2P/IwG1k9JkVje5GpCMhn6OQwzf8J/fPagipgVwgiJSs3tZBS
         2heQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712849987; x=1713454787;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btfIbjHEzJkQLorNtQGt+Q3lPeOfCGKan/kFhND/Ei8=;
        b=fwH9mkHdfmBQRyHgfTE3kFxzl4dgH8pC11b4kK6CbK8QJVQ1pVqwYmLW1ontrDYQbL
         /lXGsgAol6WxNLC2uU2Xx2ZNE2AzUjwJvtrXn/3DrF4k/7d4gmZknV/KpxU+f7O0HSOb
         d0kjwsWm/4+Tw6lM22ajaiF8fZTnaf31beywXHIU/EPMKKykE9S1RlUKtvMmLyG8jVD3
         xYTdwnup82oNjPb5R9JfC1/N4t2tYd6cj9r7136akU9TSgxkd2J3PQ3kAIOaM+u+btuB
         eUFeZxY3T0pKZg5dpCJHk65MgyC/Bzk3T+7Q9O498hAnUb92ogBvtwJZ9bdmV7pM6oej
         uarw==
X-Gm-Message-State: AOJu0YxRC1hHZCe66lKeIwi4wiNVJGlpQeOq0KXdC+fZmBfu75dtb7tS
	pvHFoGtuoDH92upsycjMKn/cWq5pEnN4KcwcYUY1SZosJbAzKqeq8WPYPlJ6HPutbST8gd1IT1K
	O
X-Google-Smtp-Source: AGHT+IEB9YUjmtVH3xNUWJAGSMnshONGN3/FcQK1+z2FMRrHlSgDT6WHM0JjJmd6FHy9mIvsXmlBJA==
X-Received: by 2002:a5e:9907:0:b0:7d6:751f:192 with SMTP id t7-20020a5e9907000000b007d6751f0192mr190297ioj.2.1712849987075;
        Thu, 11 Apr 2024 08:39:47 -0700 (PDT)
Received: from localhost.localdomain ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id jc25-20020a056638891900b0047f14b7f6c0sm457056jab.5.2024.04.11.08.39.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Apr 2024 08:39:45 -0700 (PDT)
From: Jens Axboe <axboe@kernel.dk>
To: linux-kernel@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 294/437] openpromfs: convert to read/write iterators
Date: Thu, 11 Apr 2024 09:17:14 -0600
Message-ID: <20240411153126.16201-295-axboe@kernel.dk>
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
 fs/openpromfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/openpromfs/inode.c b/fs/openpromfs/inode.c
index e25eceac86f4..66667b55562b 100644
--- a/fs/openpromfs/inode.c
+++ b/fs/openpromfs/inode.c
@@ -159,7 +159,7 @@ static int property_open(struct inode *inode, struct file *file)
 
 static const struct file_operations openpromfs_prop_ops = {
 	.open		= property_open,
-	.read		= seq_read,
+	.read_iter	= seq_read_iter,
 	.llseek		= seq_lseek,
 	.release	= seq_release,
 };
-- 
2.43.0


