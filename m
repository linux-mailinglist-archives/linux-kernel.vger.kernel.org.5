Return-Path: <linux-kernel+bounces-101895-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4579F87AC85
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:10:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0108D286491
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:10:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72F277F46F;
	Wed, 13 Mar 2024 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MlFikyNO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37527E78E;
	Wed, 13 Mar 2024 16:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348031; cv=none; b=mMAJISL7lvlusgvuHSFfxdyJihXuYPTgQFIIoHNPMIuKFNoFdi6ZcKfxU2+5sXTuYsDMU3Gxmv5O00U7Q4yjnUp+UhqVAlgzLAbxPNuJp8JcrDX1LsHN80WM1ARqUMn2U+S2fVLTfhQbJz++0HrFdLpPR4BBIvE3fxvFf4W64b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348031; c=relaxed/simple;
	bh=BC6KVXDWu6Ey0dpAWVn7vr06zLdc42BS7iPNwESSNac=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Wuqx7Ukcx19DuRd98gBA+iTjWQNpHG9Z/+3mCyTOhYT7BbXQHxl6HOA1kno54mRfALYFjMyLlrv/IOO9NPjHnFA2cL2b99gdWFn/EitGuOgjhKFHnnlgEBzo5x59/O2hX5FlqeHZyR76ggoZQWlm1s7PGzkVzIvPFuLG4CNSw5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MlFikyNO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C59CC433C7;
	Wed, 13 Mar 2024 16:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348030;
	bh=BC6KVXDWu6Ey0dpAWVn7vr06zLdc42BS7iPNwESSNac=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MlFikyNO5oirvPHiLbWCFpstQePG+coDg7JzSnYcYngrfz55NopTR17IiqUw4fT0m
	 zs6EO/KZ7Q6e8UMd0fxuTx7YLhSbEJt0cloxM4xpC3mM1/UkzD25Os30sUhCvomBM/
	 ox1wBZNalPX/Q1Ho2ekQ+nVZ+pjkNr8K6OuDnBUcurc+Sva09aISbSfjScsr6ll2kv
	 jg1EQ+v9IfCi9VASXe8u9jj6w9HZLkgxqNy71Q40sxvkQF3EH8iAH/ylJYjlGuK13p
	 wJbbtW4c+dJLL/QaNtUPEKrrg2YxMA38jIL5D7+MzVlNguXE+2MPIBSxVYxoAjOHcN
	 mm+f5yDzcmQ4Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 27/71] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 12:39:13 -0400
Message-ID: <20240313163957.615276-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163957.615276-1-sashal@kernel.org>
References: <20240313163957.615276-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.1.82-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.1.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.1.82-rc1
X-KernelTest-Deadline: 2024-03-15T16:39+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit f99b494b40431f0ca416859f2345746199398e2b ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/af_netrom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/af_netrom.c b/net/netrom/af_netrom.c
index 88941b66631fc..5472e79cde830 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -461,7 +461,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t4     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
-		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_no_activity_timeout));
 	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
-- 
2.43.0


