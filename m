Return-Path: <linux-kernel+bounces-102051-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 873D587ADFD
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA2A81C220C6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D14B154BEB;
	Wed, 13 Mar 2024 16:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g88jpvLR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675E915444D;
	Wed, 13 Mar 2024 16:47:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348430; cv=none; b=BKqQaXj/iARePecWcPhn/gdML7aL2yGkDQEZlOPfYhl2QIZ+YWJiDNiV8sql4SeYRanMtLGKCi5htexDMp2zw368R1aNYgjuOvPzWyd6iq3dY/Hf/eIs7DFn4X7sxkYLO7gF2cHs/zvel0jpzjGJ3+ZgdA+nNSgVTs4K40Vl9o0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348430; c=relaxed/simple;
	bh=A45mpmaNrioN7F+79MkqmOhHiGCPFpIHmheKJHJxoKk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rsSIwtXZuq/tllNNlnU+5KSqSKGmWbZ+82XSFPSupKru1Rb30wfdI1o6joVT+vEL5HlqtcXA2XVMr3856cZPo3bZ0G1iInr+cp01Zx2IZC3Pf8wRbmMXHJ5oaQx1mb+guYNrPbHaVVXjLhDVXGoBNfZndAhesmkcgmNJVXjUbjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g88jpvLR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59681C43390;
	Wed, 13 Mar 2024 16:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348430;
	bh=A45mpmaNrioN7F+79MkqmOhHiGCPFpIHmheKJHJxoKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g88jpvLR6tKhTBWbGNgFF2hbEGjp4KX2srpjz65cWW/+AwdWa4kvAGavczDW5tkkw
	 GTYhh+KCjEr6e/wU6Yqsd0E49VIYJydLKpgiq+7AxzU5ZEd4c6YiAB35ZE7zqOUIwc
	 R8A0IbluzpJQyvyWia+Cy1pqvcbwMakXrjtxfhfsLEacv3P13KQaAX+ezWPXNLsKzB
	 ANEXAzRT5+z0PJ1b0MD2QpaNvtoKvhQGg1L9oPTDyvJYTNdKzuwT/kLt52LyIheWC8
	 ah/4pX2l52E/lNkpngep5h1TEWTgIkg/D2MhPpacuJe7Uc5/yUpbs7cKek7JRY6Y7O
	 ntxVORayo2hxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 25/73] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 12:45:52 -0400
Message-ID: <20240313164640.616049-26-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164640.616049-1-sashal@kernel.org>
References: <20240313164640.616049-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.213-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.10.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.10.213-rc1
X-KernelTest-Deadline: 2024-03-15T16:46+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit a2e706841488f474c06e9b33f71afc947fb3bf56 ]

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
index 76d66eb0de255..d780adf54e19e 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -462,7 +462,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
-- 
2.43.0


