Return-Path: <linux-kernel+bounces-115573-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419488942B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C09571C2ECC3
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44E35313E9F;
	Mon, 25 Mar 2024 02:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xp14ZP0J"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9EAC1F30AF;
	Sun, 24 Mar 2024 22:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321120; cv=none; b=iKilXud0+J+nNXLmjpyCyon8EbP8d32lLDEk9OBRRYscVohQUUyULGf8rUfI0+OW0RhMCzzsx1KugenlqRNoxIgC5X9THSFid4weS4B9NGY6eR+U8Fc7ZWaXwQJ2CfPuWkDliLvojyWSxpVUKrqXl5lwyey1mMjHTnGtAefg1UE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321120; c=relaxed/simple;
	bh=BjRnn2uAci+SuwZsSH8Z6eRxLJRWal9cId1CxlbJEoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iSK6NnkSFQz8GNtUtFjr2o8/YEaxxzlefYZdKB5xeuXcJz0dIYxxUYMXpPWgDoIot4ZZFL/uU/cmL/C4PspA7LqQ8y78NBexXDHEFo0xLQHaryZYgbtWQ4hrT15NSE8VPWX00MwHms2GEmabzfL7fDwcK4AEtr1KdIlUqEbyM3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xp14ZP0J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AFBEC433C7;
	Sun, 24 Mar 2024 22:58:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321119;
	bh=BjRnn2uAci+SuwZsSH8Z6eRxLJRWal9cId1CxlbJEoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xp14ZP0JOi4yeqIsJ4lmheeS0nfNKCyrlayaOBFzgKxUgVtjWTL7+QKoLtmeLASNE
	 xb8yr/Y4mlm3iFYWhehPfnBYfZFahmTigRzLdxvgSB7CzBoNIWX53CAy9Ya5DGV9Xr
	 e+XTDBrDdBeVJmHa3OYfjym8HEG1FXcDcwa8HKOcbDOG3mUPYDZDeqpKwlpBeJHdQ0
	 kqgjKhhjiduYg1ZMq+KhMFQUMkQT/7SGUXyk/Au0NzqN4eaMuuBHAixQA4ftY+ARS7
	 Q4NVe9dXT3DhiS/pDMVuyUAytMm7LF6Q+DWak+YTwUe4t6uoCfPdIFjmgn+S5irP+5
	 wFxUF4D3ws3jg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yewon Choi <woni9911@gmail.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 681/713] rds: introduce acquire/release ordering in acquire/release_in_xmit()
Date: Sun, 24 Mar 2024 18:46:47 -0400
Message-ID: <20240324224720.1345309-682-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Yewon Choi <woni9911@gmail.com>

[ Upstream commit 1422f28826d2a0c11e5240b3e951c9e214d8656e ]

acquire/release_in_xmit() work as bit lock in rds_send_xmit(), so they
are expected to ensure acquire/release memory ordering semantics.
However, test_and_set_bit/clear_bit() don't imply such semantics, on
top of this, following smp_mb__after_atomic() does not guarantee release
ordering (memory barrier actually should be placed before clear_bit()).

Instead, we use clear_bit_unlock/test_and_set_bit_lock() here.

Fixes: 0f4b1c7e89e6 ("rds: fix rds_send_xmit() serialization")
Fixes: 1f9ecd7eacfd ("RDS: Pass rds_conn_path to rds_send_xmit()")
Signed-off-by: Yewon Choi <woni9911@gmail.com>
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Link: https://lore.kernel.org/r/ZfQUxnNTO9AJmzwc@libra05
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/send.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 2899def23865f..09a2801106549 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -103,13 +103,12 @@ EXPORT_SYMBOL_GPL(rds_send_path_reset);
 
 static int acquire_in_xmit(struct rds_conn_path *cp)
 {
-	return test_and_set_bit(RDS_IN_XMIT, &cp->cp_flags) == 0;
+	return test_and_set_bit_lock(RDS_IN_XMIT, &cp->cp_flags) == 0;
 }
 
 static void release_in_xmit(struct rds_conn_path *cp)
 {
-	clear_bit(RDS_IN_XMIT, &cp->cp_flags);
-	smp_mb__after_atomic();
+	clear_bit_unlock(RDS_IN_XMIT, &cp->cp_flags);
 	/*
 	 * We don't use wait_on_bit()/wake_up_bit() because our waking is in a
 	 * hot path and finding waiters is very rare.  We don't want to walk
-- 
2.43.0


