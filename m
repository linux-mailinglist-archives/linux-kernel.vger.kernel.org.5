Return-Path: <linux-kernel+bounces-114697-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D76D38890BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:26:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 144581C2C84C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:26:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4458A13CC5A;
	Mon, 25 Mar 2024 00:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GEX9GsVu"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9084423A743;
	Sun, 24 Mar 2024 23:19:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322345; cv=none; b=FEfkBtegmqxgTdjSovYz6Y7a6MZ3mCXaxSlYd4UGUEgMFIEQbOHYtNyfD3TVbHvWfBtIC8vtWGE0BBeMTFfBUBB5ynwR2P2FnKtPCSanEd238EJ9wiOpSlRHUmzOx2BRxQP0dsnjNfAVcygCGEd/qC94mKPbDfkJWl2k6tJn7qA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322345; c=relaxed/simple;
	bh=etCd/8+W6gPvnD9AXqGD5UGgiFeB5peWXvvAeJfX9zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djg5Vn3pnMNPKHVMrXqVaLqmewauJAK5StaibSxi35vQH25C7Eg8STtndEcamxPNHumoyBhUm5/XtxP+AP5hyf5Qm2vg2/D1Zi7gG4XDuJTzXGN146vox7hS7spT1RjNhdR/BBEFgnOh6OVYpGNUJ5T7qWIx5aKGyoadgkk0oUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GEX9GsVu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9F5C43390;
	Sun, 24 Mar 2024 23:19:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322344;
	bh=etCd/8+W6gPvnD9AXqGD5UGgiFeB5peWXvvAeJfX9zQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEX9GsVuCaH9K487zpm/F2MsICiqA83cN+2ckAd3TkFBrGarXOeLW+1YeLdnWsHt9
	 RDKP4Rx0wDjj406ngvXDiTx8lcpWItbuF8/Xmhr4VE0hvHG8CYXASKbVj36Qn+T1pW
	 ajMJfRhNomCF0I7OmC5PGuxKTQMKKWXtNgl1L26OPICWNffIH/BJnc5Yj/GXcn426Q
	 PaI7257nyzo6GEOMPVoz/8/W9uvIuKtJ4xaiEd8T/2qoWZgC6aVL2QCwypLDZtPQC5
	 Fn3ffzO6NMHuf6NJn5kpfc1s7jWVc56sQfUoF2DHhefiiPKBJBSOha+4VSwTCyPQrZ
	 KibCXpEFVqW/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mikulas Patocka <mpatocka@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 426/451] dm-integrity: fix a memory leak when rechecking the data
Date: Sun, 24 Mar 2024 19:11:42 -0400
Message-ID: <20240324231207.1351418-427-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 3da4359f51645..e1bf91faa462b 100644
--- a/drivers/md/dm-integrity.c
+++ b/drivers/md/dm-integrity.c
@@ -1856,12 +1856,12 @@ static void integrity_metadata(struct work_struct *w)
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


