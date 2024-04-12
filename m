Return-Path: <linux-kernel+bounces-142046-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F02F48A26B4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 08:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2C3DC1C23BFC
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 06:37:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89DF64085A;
	Fri, 12 Apr 2024 06:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hxBIUjjb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB0A1BDCF;
	Fri, 12 Apr 2024 06:36:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712903815; cv=none; b=pdZVRwlb+ugr6qaogZIEsSf2/lHvxlq5QDuq/VUaMcVr6fSCXT1yFStU9rYsZfXE+1z7bVoYwlzN8LJRHBUiuYGRg6k4WoL/I7lhkNopK8/xp/ZtslMGC7HjwVcEGtUIbDrjpDdDIHKLdanPFoyY40d2VD54nLqT5SrloLbD/Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712903815; c=relaxed/simple;
	bh=NkGJwr7h3mbH6nk/AhjlXuCyRNAnQFgNgi7XccAHJjA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W0z+74nIwY9+32XxcxIhgrxOc9OhQKIr71zyM5rQrZsvW43uxf84wT1T5yAriPf6/7d3nzNmaqBlnTI++oJiS+0Yl41w6OBpf8gvos9WRIzRTVYLmR6DOiok1sqs+m83g1YSACR2+8Ny9p2paLUJfnaJB8WQddqPbZD2+fnhL1k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hxBIUjjb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC0FBC2BBFC;
	Fri, 12 Apr 2024 06:36:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712903815;
	bh=NkGJwr7h3mbH6nk/AhjlXuCyRNAnQFgNgi7XccAHJjA=;
	h=From:To:Cc:Subject:Date:From;
	b=hxBIUjjb3ul6O2R4GKwr3ab8w8qRzQXgp8kN9VwSnAgHX1JE8FIR9sr9ZO7P/chvY
	 cxAE614O32F4PonDUsO82x2sg4y25HdC0/QAhagqcqBY+zsVnswUfDfyUT/6wiBCuy
	 nXNR08z+sh1yCbiyYaUVyZJWA/TR7msaz0UVgMDz6Vjgjc1Mk5jLLLgm6tAaMHbGB5
	 Q4K5iyAd5mw789J9vg6x6k29L/SF80CiSxL6tFgUwucxdOkYINrEuPAxL2irMbmYc0
	 n0UDx0y0PwtikbPbe6hJ17T/+mxZK7P+TRIJE2GAoTu6d365IllHJ1h7N/ocfXwx5r
	 xlhXDGlIrQhMw==
From: Chao Yu <chao@kernel.org>
To: Kent Overstreet <kent.overstreet@linux.dev>,
	Brian Foster <bfoster@redhat.com>
Cc: linux-bcachefs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>
Subject: [PATCH v2] bcachefs: fix error path of __bch2_read_super()
Date: Fri, 12 Apr 2024 14:36:38 +0800
Message-Id: <20240412063638.2068524-1-chao@kernel.org>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In __bch2_read_super(), if kstrdup() fails, it needs to release memory
in sb->holder, fix to call bch2_free_super() in the error path.

Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- add error message in error path pointed out by Hongbo Li.
 fs/bcachefs/super-io.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/bcachefs/super-io.c b/fs/bcachefs/super-io.c
index ad28e370b640..cc80d7d30b8c 100644
--- a/fs/bcachefs/super-io.c
+++ b/fs/bcachefs/super-io.c
@@ -698,8 +698,11 @@ static int __bch2_read_super(const char *path, struct bch_opts *opts,
 		return -ENOMEM;
 
 	sb->sb_name = kstrdup(path, GFP_KERNEL);
-	if (!sb->sb_name)
-		return -ENOMEM;
+	if (!sb->sb_name) {
+		ret = -ENOMEM;
+		prt_printf(&err, "error allocating memory for sb_name");
+		goto err;
+	}
 
 #ifndef __KERNEL__
 	if (opt_get(*opts, direct_io) == false)
-- 
2.40.1


