Return-Path: <linux-kernel+bounces-101892-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC0887AC7E
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:09:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0ECFA1C20DFC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:09:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C32A7D08A;
	Wed, 13 Mar 2024 16:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ksZ3dFTy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D17AD7CF34;
	Wed, 13 Mar 2024 16:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348027; cv=none; b=qNdmL0rnCM68NzOtm2Rpl6AXLRBW8z93U2BMavU+Z09+hJnNtq6Y8JywnJfVbShq72DT5bxke0dXHckVi2Bah27mbJDFbWJM5hieAxASbTQQA4Xu8FSurbHMpndWDjKOX2FrelE963cS4MjGKItrQzYI+Rm+ZHwyT2UtbUCOTZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348027; c=relaxed/simple;
	bh=GcH5QUvbTQiO6Czf4SU3qMrte6G4xaocdAdcNnMpM9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I8EW5Wddy00my0RwAA6ifws2PIyEYeXHzyzMB4JxN5/OFPYXAVXqjlLaYNjiSFd9D813Uud+UHrQezfsFwRaffSIU9TOH0BQ982vNORj4UmlQ2UxgcR9ATeE3wXGGZCIw/eCiRCtTead6B+zvrdUK+K33bGWUsXFro5+1bmCFUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ksZ3dFTy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 054C6C433C7;
	Wed, 13 Mar 2024 16:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348027;
	bh=GcH5QUvbTQiO6Czf4SU3qMrte6G4xaocdAdcNnMpM9A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ksZ3dFTyd4n+ift42QMwG/gJ8uRTIZHGtc0iNxRgkWm/C71qmXFxKAlG7TYIoPJzk
	 S9qFsAxj6b0dlacbecBcAOa02BH09n/NK4KtKtUuVxO/ofylfw3ZEo7DlX5XCvsehu
	 nDkmjpCtqkdHCzkPztEr5AoAysn512Gjr6Ish7hhhWYVvnUKkb7HOerbahMiCVZjuP
	 Kq8s2oMkcB2+xzZgafdd53kSF92bbfFdCMgIWEMbOrqolPWhYRaJ6dmk54A9FnFbB9
	 +RO8ncGTcD2Q6B+Ew27v7hKRBaNsn3icM58GVUypLqFOxpS/e9wU2RvAZWB37Q5p3m
	 CXmkvVEo4+lQg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 24/71] netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
Date: Wed, 13 Mar 2024 12:39:10 -0400
Message-ID: <20240313163957.615276-25-sashal@kernel.org>
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

[ Upstream commit 806f462ba9029d41aadf8ec93f2f99c5305deada ]

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
index be404ace98786..7428ea436e318 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -455,7 +455,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t1     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-- 
2.43.0


