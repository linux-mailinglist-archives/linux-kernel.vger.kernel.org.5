Return-Path: <linux-kernel+bounces-115260-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D68F888937A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:29:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13AA71C2E385
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:29:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B0C81CEDD8;
	Mon, 25 Mar 2024 01:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MJFOu9Nm"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E54213C9B2;
	Sun, 24 Mar 2024 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324379; cv=none; b=jswZEn8cbZ64KhIzPJFvysfUUextnwlfaqth8pCrdQCntDEY9JfDQ2TcDYWv6j0aOd9O81sPtvfplMRz68X3s7aGR2ckJvEJpxcegqYmaOivSbeuePfrPlsvAWOEyzOu8VB/2H9H9cce5iQg3FlWjNaeZAlm/pp1b1SQPnBfa3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324379; c=relaxed/simple;
	bh=NXGz5zQ1cIN41gQxmUZc+/iBhIw/1/8LD1rvp3eyCDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ghff4G1VxEJvI2dvcZdrzOm0b7kMAYxdEZ7Bc5n2uFQGG4xkx3LdRqQUN1tXFpfq17iXT/ApJfJIXY7TCK9FChSsUAfkViMFFOPPeGKV4FnTktaXb4S4fd679CLdAcNFhbX7Fi8MLDvQF6mKQhTmTaS596yx5QczbJRc43baed4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MJFOu9Nm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6485C43394;
	Sun, 24 Mar 2024 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324378;
	bh=NXGz5zQ1cIN41gQxmUZc+/iBhIw/1/8LD1rvp3eyCDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MJFOu9Nm0ibwdsdirFQ1nIUpVmAl0ixAcNz6gx2HVdAZNAfZliEfihoy4w74rB3c6
	 UWpjRNAqB3//uYczw3cYeUe2PV2BniTZ4hKJTbr1OJu2HevzIsgcCpwMKg0Akc99PQ
	 ygy+aiP66+lBkN51shnPlsSW1jmhRpiS+N9z4Og0Go5dV3TeF6AHTPXbJxBOnRqvIX
	 gV++jXNf+CSarVp2gZ+93uE8xv3rMLONjDAGa+ptkc4Xz16B6J9ucmaq80mCVvyxWq
	 pKydGmC/VDQcL7z06cKdoVxZk6uicbmizwH+0gUiGybItLNU9Wb+9OP8sboOAz6T1q
	 7Hn9hCB60fB8w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yewon Choi <woni9911@gmail.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 144/148] rds: introduce acquire/release ordering in acquire/release_in_xmit()
Date: Sun, 24 Mar 2024 19:50:08 -0400
Message-ID: <20240324235012.1356413-145-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index c856e6c963af9..dcb338339b717 100644
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


