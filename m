Return-Path: <linux-kernel+bounces-99678-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24972878BB0
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:59:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CEBF81F21A36
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CD0D59170;
	Mon, 11 Mar 2024 23:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="APiIOfam"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25D0158AC5
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 23:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710201567; cv=none; b=hUqQEisRN6BrnRqQ4i1Yu5f3i6NbLkNgHU3AgIRHxe+m3qb6vloK2nw6LGmz2uNwT7/lkEXjuMHmuFA+FSgVVctJV0P/lojxqyQH3g8Xc5qYVw5SNavani32OvIcGQp2a0sxJsnONdEF1mPw/Ihpa1SJB12PgYRpJVywW2G//qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710201567; c=relaxed/simple;
	bh=rIUUZcn7u9X1l8vy3qZ/KrxnhM49qrQh0SyhLbwntzs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=pxlHqrKO4+9vsoAwuRRiKjKZN5lUDm4z5JFQ0wKhsSzDoQRJZgksonKbe+qQy6vwaxbJ+wlw0M7rIL8Wmdfl58pu6f7JCq933uZx13/DodBvqkduYJrJRVJ/G2pmXb95wrJwgWhl8LGrHyv+450Qs3o83vOML2/XH9j//Ba/owk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=APiIOfam; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d944e8f367so38660225ad.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 16:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710201565; x=1710806365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bqpi+pK0eQZfpPuAwyq71F3S97nx5NBT8dYXZNYP/vo=;
        b=APiIOfampZVQrLVxEYypGMkG6vDW0xnkiqycYohM1iBR8HptgfBRZ+lu7J/GVyxcHm
         s0jep0Iwi6dNfLc3JhVE5yw7rJnXogzxFdfp5G+vXkPR0Y8w7mvmwzHAQcJhJ0ssuhZK
         JTZ/6yvb4wkjwtTWGoGTndzzg3SIqIigthaLu26daCva4d8K7RR7u59fz8sI3Z+piVL1
         A4FjhArz8P74uANkDpXpnDgNvP4zjhqEup+cSS9x2JqA8MLYk311NsHmMXSDK0Xe9BA7
         5zxYuzyUylhMNs1QVT7aZ2urd4jscZRhQcc9Hgn+Y8GMMym6kcxuS07QSO9xqnbN559Z
         WbKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710201565; x=1710806365;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bqpi+pK0eQZfpPuAwyq71F3S97nx5NBT8dYXZNYP/vo=;
        b=VXNmH1pylYg24UmqSjElw0GIhiGuCJRPdlMas6O43ftY87gqbVbE3Loyv6YNGRlKXi
         Ul+lHO/bL/Ma8DRcWnCOfhmGnD1sXw1PRTqmgRML6/LDeucybOPWBY+OshDj4Uc+RFdG
         hkDVhKyA8hKg41gdrSqJLxzu5yonc4BaM4dq6BBoWr2FO66J/ytsmIvZvUgNZY+o06PJ
         3SdahG6CYAPY20Cz4gEb2Jgqqh7zx1cmlSPNYP+gfqJTrUQukZwFnH5WsuNcAGES8xhS
         odrsyN3LgkxxZflddWw9z2EJgtLTX2d0JUJXjkB/MV0ITat00uRupRy6EftFyx1cjYEk
         ZGSw==
X-Gm-Message-State: AOJu0YwKmWHrpKHh7PBLZr/zHqQuHVegzFOPfLCVqDRtGkzCVo2sdc68
	g5+7N1Rq0k11k95eyw+78uO7OCvh4LaP6Rhs+okz4JTgXwPeH3F7j9sk4n+G
X-Google-Smtp-Source: AGHT+IHn75XVEeeY8/1CG7cnADq6V0jic+dEdxIKLujyLw/Dffes5RFhnhz2xzg1f3QKb1JYtA3MzQ==
X-Received: by 2002:a17:902:e801:b0:1dd:5872:386a with SMTP id u1-20020a170902e80100b001dd5872386amr8937023plg.59.1710201565055;
        Mon, 11 Mar 2024 16:59:25 -0700 (PDT)
Received: from daehojeong-desktop.mtv.corp.google.com ([2620:0:1000:8411:d706:f56a:f0d2:75d])
        by smtp.gmail.com with ESMTPSA id n5-20020a170902d2c500b001dc8f8730f3sm3473272plc.285.2024.03.11.16.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Mar 2024 16:59:24 -0700 (PDT)
From: Daeho Jeong <daeho43@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	kernel-team@android.com
Cc: Daeho Jeong <daehojeong@google.com>
Subject: [PATCH 1/2] f2fs: prevent atomic write on pinned file
Date: Mon, 11 Mar 2024 16:59:19 -0700
Message-ID: <20240311235921.1832684-1-daeho43@gmail.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daeho Jeong <daehojeong@google.com>

Since atomic write way was changed to out-place-update, we should
prevent it on pinned files.

Signed-off-by: Daeho Jeong <daehojeong@google.com>
---
 fs/f2fs/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index 1c044fb19c87..82277e95c88f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2085,7 +2085,8 @@ static int f2fs_ioc_start_atomic_write(struct file *filp, bool truncate)
 
 	inode_lock(inode);
 
-	if (!f2fs_disable_compressed_file(inode)) {
+	if (!f2fs_disable_compressed_file(inode) ||
+			f2fs_is_pinned_file(inode)) {
 		ret = -EINVAL;
 		goto out;
 	}
-- 
2.44.0.278.ge034bb2e1d-goog


