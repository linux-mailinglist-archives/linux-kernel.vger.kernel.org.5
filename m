Return-Path: <linux-kernel+bounces-113580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CAD0888575
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:08:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C8FC12831D2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:08:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35CB1C9ECB;
	Sun, 24 Mar 2024 22:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="njw8ca5x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FBCD1C9EB1;
	Sun, 24 Mar 2024 22:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320384; cv=none; b=tOtNzxlQDL21enzF0hCDLWh26c9cBsm7nvccgzHDoMd1nyh7B6767ZMc5hoWREVyWMRJ89hdpYjhdT6C45TJn4zDXzWlULbF8h1qXbbTN2omPfClN/PTn8Z5RkcGZGKSjufBGTsP/B2wUdHB70YduxeaLJ3eOoX5AvC9wIBQ7MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320384; c=relaxed/simple;
	bh=qPqRV2EP6kpC6/451Xi6W2Alk4HTibFzdN5q6rAgiqw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BNp+IwE6KqaLbGOzBUxCRFLTGEKQXfbZmX0ggOypNb+K83Vxd0ehJj7JJustw+zllBBxOvK1jeJfrO7xTCXHBHQyhOXA+FGQDgyXxf3nMktVRs8AJw5aQivXck+q+dpJHm1D6DXYAM8l7oMyKXKofCJ4UOWVyLQwSts94IYR/iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=njw8ca5x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01A77C43390;
	Sun, 24 Mar 2024 22:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320383;
	bh=qPqRV2EP6kpC6/451Xi6W2Alk4HTibFzdN5q6rAgiqw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=njw8ca5xSVXWPXWrIpmGL6/spAV/81oJCtXKd8Id0M36NR3vplhnKou+ZDxUlIzAR
	 ed8e/+eHrq3AXz/RhnEAmmwQ1jgrK2tvOZco/tI3ocwt2Uu6qbtUM3cYM4pwiD+i1r
	 ZsLKQjxzzOFNw6bF87s39bT4hhFl45svhCuB3VDt566HTX2NnvvMKL5CvKFjto9peU
	 2AZggU/dyOPbfyiZcuYjXTWDXMIKt2NczSBaPCotdv5wvDV4MsC4cyP3WlPizNAV1I
	 3JPEDbiShWw1Oh7Cb2qr21xGIWv/gGZvnapl90fH7jX5TKrgHocT/eOivsJNIKv3lt
	 OX6b/+VGrqtMQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 689/715] dm-integrity: fix a memory leak when rechecking the data
Date: Sun, 24 Mar 2024 18:34:28 -0400
Message-ID: <20240324223455.1342824-690-sashal@kernel.org>
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

From: Mikulas Patocka <mpatocka@redhat.com>

[ Upstream commit 55e565c42dce81a4e49c13262d5bc4eb4c2e588a ]

Memory for the "checksums" pointer will leak if the data is rechecked
after checksum failure (because the associated kfree won't happen due
to 'goto skip_io').

Fix this by freeing the checksums memory before recheck, and just use
the "checksum_onstack" memory for storing checksum during recheck.

Fixes: c88f5e553fe3 ("dm-integrity: recheck the integrity tag after a failure")
Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-integrity.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/dm-integrity.c b/drivers/md/dm-integrity.c
index 1fc901df84eb1..f194ce6bfacb5 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1848,12 +1848,12 @@ static void integrity_metadata(struct work_struct *w)
 			r = dm_integrity_rw_tag(ic, checksums, &dio->metadata_block, &dio->metadata_offset,
 						checksums_ptr - checksums, dio->op == REQ_OP_READ ? TAG_CMP : TAG_WRITE);
 			if (unlikely(r)) {
+				if (likely(checksums != checksums_onstack))
+					kfree(checksums);
 				if (r > 0) {
-					integrity_recheck(dio, checksums);
+					integrity_recheck(dio, checksums_onstack);
 					goto skip_io;
 				}
-				if (likely(checksums != checksums_onstack))
-					kfree(checksums);
 				goto error;
 			}
 
-- 
2.43.0


