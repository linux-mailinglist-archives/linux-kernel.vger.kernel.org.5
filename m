Return-Path: <linux-kernel+bounces-102204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FC287AF66
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 542D11C22048
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E012219F33C;
	Wed, 13 Mar 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YqIGAStA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23CEA1509DC;
	Wed, 13 Mar 2024 17:04:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349498; cv=none; b=ZnL27t1ippFCUSa9+Q0b95PJWYjDRwmunFBG0tI1yC9gchUXyf6HWa+yWCAlEZLx+Fqt7MoxOgvyV17EN50MuR4cnKdX5faLDcIGh0Bu87gIG4ffkZBzr79m3nOIA/p6Yk/+za5Ewe/vgynkywXLapCn2+DG3nRq/653AuaorSE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349498; c=relaxed/simple;
	bh=hEAE0UN2GfWd1ilwLQhthHYCVqVdXAg860B5DXqMi/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y6HjHdSvvlNKl47embyNJ2JPZzobM1mMGuuY8GwOWe4QK2kv1CFl8hGyYMIR0Qi3Ez2jqzRK9nJ3ede+42hIRIa4AyVSeuFntWQtciFf5wFn+krsT48mbRR/mu4HUquhgoDaejw73rrHMpvhGkp8HTiD53NugjlPH/rQkpyFve4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YqIGAStA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C501C43390;
	Wed, 13 Mar 2024 17:04:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349498;
	bh=hEAE0UN2GfWd1ilwLQhthHYCVqVdXAg860B5DXqMi/Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YqIGAStAHvldlwsJzFG5QynPwIKzlgVohnmP4T1F0gVlnYTTnodbyWyYv9c5lM6Qj
	 xzANUDHcL90zFV6Bl3u3S/Id1kH1qPhvSmjZ+RvmIUzWOkFp7Jix2yY7E+2m8agwSM
	 j7eHmImIJ4d34eIsgfqrEIXE41HTjKbAKkJBvrxbc/q6NIjlf6f8DuVrxkLhImHkHr
	 gYPePnPvTmCX7aK7ZuxKO1rtzuZNpY5ZQ+LIQxw5pwe5/Vb/q2jZHQ59kyro2x4kNh
	 kJrBoUx80cVP7HxT9tfVF7qEk3nfuTEuE9p705jtCwmbine4oOPSiQjnDBYCpghf9M
	 ilEiEBFWQDixA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 18/41] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 13:04:12 -0400
Message-ID: <20240313170435.616724-19-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170435.616724-1-sashal@kernel.org>
References: <20240313170435.616724-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v4.x/stable-review/patch-4.19.310-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-4.19.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 4.19.310-rc1
X-KernelTest-Deadline: 2024-03-15T17:04+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit 43547d8699439a67b78d6bb39015113f7aa360fd ]

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
index 05235768566a3..5769fe9c111ed 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -462,7 +462,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
 	nr->window = sysctl_netrom_transport_requested_window_size;
-- 
2.43.0


