Return-Path: <linux-kernel+bounces-112905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64077887FA3
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:39:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C446FB21651
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EB425B5D6;
	Sun, 24 Mar 2024 22:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="slrtTsP2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8C295A4D4;
	Sun, 24 Mar 2024 22:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319715; cv=none; b=E/1Y6Ic5EPd6qnf3fLd690Kbvi2ZmyYqtxCZcgK6H6gps7awqY2nYgvUEWV0ssvvuyvTVFSEfRZVpkGndEU7/8kzWfjzjKMFr1my6JpCZYFvFR/vZ8+pBFDOxdk/9zsT4B+GevGCZZVaQ1vjH1FSsJqOvt3hu+277Ssq6WpiOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319715; c=relaxed/simple;
	bh=RY4fZ8mZCRjC1hfMfgy2It3O12J1jbt/aQFzDaDY7RI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I9Xh3HdAchI7Ih/7Yx2MJtDkepjKdKiMN8htCO66dRXaZ3qEViYFNf6POUy0/lMgsZlVmtYetOEwirLJzkBLGmpvubGzAndcwrgRScFHR3uhyUEFcEsatho4QzyfKTaQpZdsOEc137yUNp0Nl86Nz4DpQv9VwuCEOT9VPnOyqKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=slrtTsP2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C63AFC433C7;
	Sun, 24 Mar 2024 22:35:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319715;
	bh=RY4fZ8mZCRjC1hfMfgy2It3O12J1jbt/aQFzDaDY7RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=slrtTsP2IL1xGSzbWKSumjbrARGbXEBkhExv4vzLeHL+DDKOghehQnRImJwoVr62m
	 4KvMCKGkIDVT3jMMaZV62icZ82WwpvWRu2WJaIRS0wWC4BDeKUpt79pLtiPOD2i12x
	 ZwTf3zZ68w1JKqY3KW8VDfSsLEjeIydHWnhiRdPZiydy86gfIhFWnomIue4L6VKSn7
	 S+F44vZQdZnzWIwL0wOYRLq8xl62v2468jEb1KvLSeXiPhKp57D6Fm41fT3BdiLWpl
	 ymp594Cl+JqWe/jaK6qPUsee81JG4AxwWT1sCmJ3gC2qUC+yP4XKyKtsay7dae+evB
	 p7e5GNgsl2I7A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Bart Van Assche <bvanassche@acm.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 018/715] fs/hfsplus: use better @opf description
Date: Sun, 24 Mar 2024 18:23:17 -0400
Message-ID: <20240324223455.1342824-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit cf12445daec01aaa2d27bb34bd7c796a53442c42 ]

Use a more descriptive explanation of the @opf function parameter,
more in line with <linux/blk_types.h>.

Fixes: 02105f18a26c ("fs/hfsplus: wrapper.c: fix kernel-doc warnings")
Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20240210050606.9182-1-rdunlap@infradead.org
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Christian Brauner <brauner@kernel.org>
Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/hfsplus/wrapper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfsplus/wrapper.c b/fs/hfsplus/wrapper.c
index b0cb704009963..ce9346099c72d 100644
--- a/fs/hfsplus/wrapper.c
+++ b/fs/hfsplus/wrapper.c
@@ -30,7 +30,7 @@ struct hfsplus_wd {
  * @sector: block to read or write, for blocks of HFSPLUS_SECTOR_SIZE bytes
  * @buf: buffer for I/O
  * @data: output pointer for location of requested data
- * @opf: request op flags
+ * @opf: I/O operation type and flags
  *
  * The unit of I/O is hfsplus_min_io_size(sb), which may be bigger than
  * HFSPLUS_SECTOR_SIZE, and @buf must be sized accordingly. On reads
-- 
2.43.0


