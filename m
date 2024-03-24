Return-Path: <linux-kernel+bounces-114692-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2D88890B7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:25:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22BB5295E1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B284112B79;
	Mon, 25 Mar 2024 00:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O8n3/6su"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8258815F3FC;
	Sun, 24 Mar 2024 23:19:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322341; cv=none; b=oefQG3xPcXPXFgwxQjdLjBO3UF3tgg75Y7jwb9kySlEDlLDs2HwM42TahhLDu0kqwtsRPeHUjgqeqU+AdUwlga7p38RteOStcvsqInMchvjvy64dTR3mb4EGlxDjYZd0n1Pr9R4z7dD1SQ7kF3WUEIsM8RKSiW0IEZ3DlSTz1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322341; c=relaxed/simple;
	bh=+bn7YIToq/qGjY5BklOYSHACeH/nQXxhLSzEoDJAArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FOVLR/rn1HvYOUa+h6PpymYmoHCehOhWgBJOBdnS44IFuNAvnnDRoargm5Y1S8uegOTH3aSvyKXzy7vt5ppN6THwHvCiEJ+Opl3+kkjZ5Nqx1t0Q3As21hkMg5dxURG1+xB/QPiQMDaHdA91n2pCsRV/z9fLP3PV+4H8H8mb5rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O8n3/6su; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB6B5C433F1;
	Sun, 24 Mar 2024 23:18:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322340;
	bh=+bn7YIToq/qGjY5BklOYSHACeH/nQXxhLSzEoDJAArs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=O8n3/6suTC7uad9iARO6gqRRdppKq9rR6IOQx9xmI53ICN2yh1ipxMy9wAvhXQSSK
	 jlKMl7IKNVA/n/lldEUmBXhe2dP3l24ksC9nCkFZVF8Nh5AOhSf7HUTW/7QIclURr8
	 uYSsg8THOl+B2qDCHWYuN9TRU0A090UNAOZAE9jyjeQpzkns6s7KUiOUYa3IsRBoVA
	 KSZHjcQNU+hkpR6SLde1WnvSOVbRGKTw95S7tIpMu+aRv4jLztTBR9BWu3zvmCkF32
	 WC7AaPu0aytBaNtJU3gaEMBYq3Csdj5fez0KR+dLPcpOtk0NWyp4AyQIMCJq7JwodB
	 J6m14cJVZH5FA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Yewon Choi <woni9911@gmail.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 422/451] rds: introduce acquire/release ordering in acquire/release_in_xmit()
Date: Sun, 24 Mar 2024 19:11:38 -0400
Message-ID: <20240324231207.1351418-423-sashal@kernel.org>
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
index a4ba45c430d81..0005fb43f2dfa 100644
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


