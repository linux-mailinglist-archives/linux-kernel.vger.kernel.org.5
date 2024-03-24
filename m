Return-Path: <linux-kernel+bounces-115361-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B29E48893BB
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:36:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6EEA1298AD9
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:36:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F6BF1D697E;
	Mon, 25 Mar 2024 02:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Iw/fi6sh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51AD11D790A;
	Sun, 24 Mar 2024 22:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320602; cv=none; b=Kx3pjmczg4BJTWRYcxIyoDkLTUKixqUWinmqIdULJHxKgUxo4xy/axvtMi8DfTUOEf9xvwkmi0zCDTREo/FdHV7yzR/8il6qCjAPcDrVCF4x1z5ukqIcXGZo1c0vWNyRudAgzVPpoHk7l/2BhxaHo8SkrPUl1XSBFEbskT3H1rA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320602; c=relaxed/simple;
	bh=i/ETv3Z0+14MObVPjWUndDksu7lvCqc1LjL8w6W1XSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hU1VbFSBezBM2ZjOQzCVYVvyz9fCQGgdt2P9+uWEoN8uC6gd2f/YIKP7ICWSwEN36F5eVcsm8JjoWX/CIRwHb/aoOw5kE7J+UxD26UbTMI9zWcmjNbN0Jwpyw4Jt4hfsFBSsAdUY8wY/7jqN/YdVgS9wnuXZ1CwhB5itHKWYVp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Iw/fi6sh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BFFEC43390;
	Sun, 24 Mar 2024 22:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320602;
	bh=i/ETv3Z0+14MObVPjWUndDksu7lvCqc1LjL8w6W1XSQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Iw/fi6shBX+wHjW+PMmQAh1JmlXhfsrhc1uFES+Udtv3pzPZqXydoRLIbP3FUQdIc
	 wYHypBzRD3iTnOVqqzxuFmmq0wA6sAMoDIAvnoh2UlYncRO+Dmke6ZRQp31sLawqfL
	 a6J/4YCRJmzUyUmpOhyaOjzkhACThHNuRgV3GMWkA6x5wDhRUC2R/793NXc3YCBA1i
	 INYxJ9GSxiXdLd1l0lcPcXwR87EWhM6MMghJ8X7rLL1pFzGfrIJBZekV+j9Ulfk6s+
	 fGIj0C6bOqrXtqHTiUVfMcC0Of7EklHQceng+HiKgPZIrGLJhaL7dm+3N+t+E97WnF
	 icTXH3uWukPGg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kuniyuki Iwashima <kuniyu@amazon.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 163/713] af_unix: Annotate data-race of gc_in_progress in wait_for_unix_gc().
Date: Sun, 24 Mar 2024 18:38:09 -0400
Message-ID: <20240324224720.1345309-164-sashal@kernel.org>
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

From: Kuniyuki Iwashima <kuniyu@amazon.com>

[ Upstream commit 31e03207119a535d0b0e3b3a7f91983aeb2cb14d ]

gc_in_progress is changed under spin_lock(&unix_gc_lock),
but wait_for_unix_gc() reads it locklessly.

Let's use READ_ONCE().

Fixes: 5f23b734963e ("net: Fix soft lockups/OOM issues w/ unix garbage collector")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Link: https://lore.kernel.org/r/20240123170856.41348-2-kuniyu@amazon.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/unix/garbage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/garbage.c b/net/unix/garbage.c
index 2a81880dac7b7..027c86e804f8a 100644
--- a/net/unix/garbage.c
+++ b/net/unix/garbage.c
@@ -198,7 +198,7 @@ void wait_for_unix_gc(void)
 	if (READ_ONCE(unix_tot_inflight) > UNIX_INFLIGHT_TRIGGER_GC &&
 	    !READ_ONCE(gc_in_progress))
 		unix_gc();
-	wait_event(unix_gc_wait, gc_in_progress == false);
+	wait_event(unix_gc_wait, !READ_ONCE(gc_in_progress));
 }
 
 /* The external entry point: unix_gc() */
-- 
2.43.0


