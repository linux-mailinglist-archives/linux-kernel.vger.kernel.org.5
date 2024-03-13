Return-Path: <linux-kernel+bounces-102203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3547C87AF64
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:23:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8F7A1F28BD6
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:23:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3A6083BBF;
	Wed, 13 Mar 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FTiwGdNg"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23EE683B9F;
	Wed, 13 Mar 2024 17:04:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349497; cv=none; b=eqEQsMjl7/gBZ15FadMW1tGXeL0F+yOaZdyy0Gzr5bOEABIRtu6Fgq98iMs4QbuY3CL2/IK09rpNXuArD9prJV8d7Depacf70A2WBLrdIK0Uh3p25hl3tUOyrch5dOSbF0AJ/dbMEPadDpWo/I4eqhtnuSkXp5Su1ugKFRFCJrk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349497; c=relaxed/simple;
	bh=OFt2AK4sm0UN+QKcUjhK2BKulkrdelyvyPllg+vS3PU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJEzcuzADjJ+xHzakl71Hi02LOa/QkPu5ToHuUfiy0mBy8fCYDP6StzTTiGp62izQ3Wke+/Gb28MOEws/m4VDs95RCHc262LKrmZjZTmYd2d/il8/csqG7Fqbnjt9jOrKDX5K6HbcoxZdgP+YJ9M42MgTP99a9DwMN/YrDzXPbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FTiwGdNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A4B3C433C7;
	Wed, 13 Mar 2024 17:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349497;
	bh=OFt2AK4sm0UN+QKcUjhK2BKulkrdelyvyPllg+vS3PU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FTiwGdNg6jRb0H5laaj8TObyfpWNK100P7XWetZ458aFB8JyALnY/Uye6h2LTx9Fe
	 iGpTrzmDMaWYkxSFPb2zdJvlN6T+1SJ6qb1Oh3KqJned39TKSUJ91iRWz17u1MorRc
	 Ri9VKXeEgFjmIQoHizNpnwRBSNvAApJ+8ushqwXcxrNAAgDpG49WqivrX+DfrazRuU
	 jA2J9tPMiT/6oR0rtN221gppy7sxJ7JTKo9kRF9zdSBxbfJSRJ0VXPtUI9ZRHFD1cS
	 5qEfxg3+pGvB3coxyqWsa0qJNj9cGfql1hIYtTG8vmT10Xu14sin+24Uq72KstqzrL
	 q6VBLqMBJIAag==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 17/41] netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
Date: Wed, 13 Mar 2024 13:04:11 -0400
Message-ID: <20240313170435.616724-18-sashal@kernel.org>
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
index 9d4a1d56badc8..05235768566a3 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -458,7 +458,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
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


