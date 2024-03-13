Return-Path: <linux-kernel+bounces-101790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 66A2C87ABA0
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:44:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A2B161C20934
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:44:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E956F65BA8;
	Wed, 13 Mar 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="buv1WPMx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3B3657D2;
	Wed, 13 Mar 2024 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347626; cv=none; b=KXLe73R17wxHBwRe4H4RV8Xi1KsJxrzoOi8oS9qlmiNuT/94bhKxD7TaPa37KtjLpHnWEgVCboXf1dRShXHKLShBuOg6p9nfY3V1+Uievt7rngfix5POxtj0ZDsmlFSz1twGJae/ZOE7QxBDGgn0uRg6fQYfIKDN/C2Hbn/DaBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347626; c=relaxed/simple;
	bh=ZneRCSdAQVJnze/EOCWDRl9dd0JC9toWiIHu/9/VArs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OlNa42nRhR8ifvipXFgaSR7fJJL3nhyELTlFxFR0jSqP8Kv3olobHXe9yABT0VZ4pqj6gixUf+APsQq/xYTEYTJyqjlXujP4iW0cl/LivYGYLLJyG/Ll3nVZ3njyq/2NgrX+cCfpFrIPXAB24Om1MRN6JEt2cIvfW7XbRwxo2gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=buv1WPMx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2403C433C7;
	Wed, 13 Mar 2024 16:33:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347626;
	bh=ZneRCSdAQVJnze/EOCWDRl9dd0JC9toWiIHu/9/VArs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=buv1WPMxNbXs9R2C4dgLRSycmrBere6nslHnNVM9Pqr3zIeusyFJU4XGApFnq5boy
	 Zx7MBwdsEnoNwK3+ENs6U4MD9/FG8NeGrYUUU/Zp9SJmoikpgoq7Rz72pcDSSFIiLV
	 plNDnXKGwNdw9cHp+uXTeCsacqQGAlzx3BDy+TuXMixRZYHIzekbmWngmkYmX518Um
	 qyWh/ueailVz2YPNyGaJsE48mzvB374bG54oCBCNGiV2U1S9Xis40pUVZMs1CBxb42
	 B53alcSo5XGN4ipiilHxoP7FeD1IQljo2i3VL7YX8EAq7xVFqJJUiUUgFq3bjAsriL
	 +vmqaZZT4GXVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 51/61] netrom: Fix a data-race around sysctl_netrom_transport_no_activity_timeout
Date: Wed, 13 Mar 2024 12:32:26 -0400
Message-ID: <20240313163236.613880-52-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163236.613880-1-sashal@kernel.org>
References: <20240313163236.613880-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.7.10-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.7.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.7.10-rc1
X-KernelTest-Deadline: 2024-03-15T16:32+00:00
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
index e65418fb9d882..1671be042ffef 100644
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


