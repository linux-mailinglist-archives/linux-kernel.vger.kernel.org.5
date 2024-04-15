Return-Path: <linux-kernel+bounces-145146-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5098A501D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 15:01:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E7451F22F88
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 13:01:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71C2757FD;
	Mon, 15 Apr 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bQWCcfU5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 319AD12CD9B;
	Mon, 15 Apr 2024 12:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713185434; cv=none; b=Z2u/PZmLmoPwcI1fgJS+GDMaa2iar62vf8A9Y+nuIMKZHgyd+1WYlo/CIvryx20dIOd4i5dkqL8L6TOyQisCvPn5EoxUL6suo6mXjqfX1TPK2aLVsWpGqBcu3DbqAmt2ZhF+OREQgnKgt0p2XEDJ9CtXUkOCv/r8oyVBWL390OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713185434; c=relaxed/simple;
	bh=qJFLwLTWIkULEQF7YdcZkviaFR/ZQF8zdPoalJhmabs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TbnSB+hniQZnYJma+K8Hnhhr8pY/NyQh0UQH2zuh+1LuWdBxRHmIMVKDjuKHC03m7m1VDachXweJznjLgISrlkuGzHGk4n9EbC5Qy3ZBrWSltE4dbMJy6bcHU2OLfaKp0rwreSsYT1xcpyeh96SjPFWfQyWsFzeYyDx0qp5wZmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bQWCcfU5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F78FC3277B;
	Mon, 15 Apr 2024 12:50:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713185434;
	bh=qJFLwLTWIkULEQF7YdcZkviaFR/ZQF8zdPoalJhmabs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bQWCcfU50nY+70t3+VvDap2KO+Q6C1XrGn8XwONh62Sz5xebRe3K92BgQ1b1MmfQX
	 s21CLfknJ7UDIQMnIp/ezeO+b1uns7HB9y/wGidu8Q1g9WvaSNFsFJtJyEbgWSInra
	 OPd43fXJ2ysXgXIjo8B2q0OhTnu9ko8Mrb6BbVTHV5otjgGqi5k8YUrZPUcXeDLyP7
	 +xw3zbUVAZ+fU8iopHARtKS6uDQMGaltQ5Q3YbuJ+iCjAoI0W8vp5RqK5blUa1RAp0
	 BfmM4sp/KIAJR5zm3ntDBQAtGrhHvFzw2fY1rt3rAYt+LyYcYY2TvwWs4OQuIZ4kN6
	 bfaDd7QpmLA8Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Li Nan <linan122@huawei.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>,
	linux-block@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 3/6] block: fix overflow in blk_ioctl_discard()
Date: Mon, 15 Apr 2024 06:04:24 -0400
Message-ID: <20240415100433.3127434-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240415100433.3127434-1-sashal@kernel.org>
References: <20240415100433.3127434-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.86
Content-Transfer-Encoding: 8bit

From: Li Nan <linan122@huawei.com>

[ Upstream commit 22d24a544b0d49bbcbd61c8c0eaf77d3c9297155 ]

There is no check for overflow of 'start + len' in blk_ioctl_discard().
Hung task occurs if submit an discard ioctl with the following param:
  start = 0x80000000000ff000, len = 0x8000000000fff000;
Add the overflow validation now.

Signed-off-by: Li Nan <linan122@huawei.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/r/20240329012319.2034550-1-linan666@huaweicloud.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/ioctl.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 47567ba1185a6..99b8e2e448729 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -89,7 +89,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	uint64_t start, len;
+	uint64_t start, len, end;
 	struct inode *inode = bdev->bd_inode;
 	int err;
 
@@ -110,7 +110,8 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 	if (len & 511)
 		return -EINVAL;
 
-	if (start + len > bdev_nr_bytes(bdev))
+	if (check_add_overflow(start, len, &end) ||
+	    end > bdev_nr_bytes(bdev))
 		return -EINVAL;
 
 	filemap_invalidate_lock(inode->i_mapping);
-- 
2.43.0


