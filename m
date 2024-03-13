Return-Path: <linux-kernel+bounces-101792-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0ABA887ABA5
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B460BB23E19
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:45:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8025965BD8;
	Wed, 13 Mar 2024 16:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q0BOr6/2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4E965BC3;
	Wed, 13 Mar 2024 16:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347635; cv=none; b=DVKWIiRrHGyxdq1D9TEqvS1uqIgSLD4X0i3/DENjBN/UTUUm2jzS7lr5zlQQjfYdyveTB3JZPSXUxpVvpwActGW9UNP/gsibbrLJ2xOR86ENzM/iN56TfT5tWjvxuapXBexkVE2XljoZnQgsw3Yd5UvU52K3r011kBNk3vOR7OE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347635; c=relaxed/simple;
	bh=D4rW9sjI93khwkpaWq93aiNXmRpAIL3WWyb7UQAT1cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PZmtznt6xJwaeaNe5+KTOQ9JGvXDatDowsdJh4hl6xvK/hrBM97/Qoj27ZQUr1d3CWR61YShbUB04BvilD7Kgt+cIV2dsw+HOES0kmSVS9x83oHBbwKOoDisSINJjPku3wW9gTfPYIWpG8Rv+nVTH43fTs989BjB6JPdHxG/KBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q0BOr6/2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857C0C43399;
	Wed, 13 Mar 2024 16:33:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347635;
	bh=D4rW9sjI93khwkpaWq93aiNXmRpAIL3WWyb7UQAT1cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=q0BOr6/2xQvFksnD4J15mfuhCOY6ned+P49P/muMl6hsP6aNnnOE0kSl2dmbrrnOy
	 NKEwrjcz1b9bi+PGX2wc8K7wU6K4MCuUQK1RF9RwoIeZ5TzHi8TVr9pRGFHK0o4fAo
	 ky9s0P9I1EwFLzYUml9rNpWgNEkrsUI7e1+zwilu38aEeTU1tLxzlIelqoGN80aeec
	 cy5FQvAouVP8EmSVh2D5VpD1Lq6OMa1dQGATDatGZ79cWIkx2MbHqSyxh619sbVik2
	 466nmIfqH3PiYUkUHPSAHJjy1FOGtkfAN25F1PLROprn2UogHGBwnefPOTofp+C7Xr
	 Yue8fSJEeayrA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 53/61] netrom: Fix a data-race around sysctl_netrom_link_fails_count
Date: Wed, 13 Mar 2024 12:32:28 -0400
Message-ID: <20240313163236.613880-54-sashal@kernel.org>
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

[ Upstream commit bc76645ebdd01be9b9994dac39685a3d0f6f7985 ]

We need to protect the reader reading the sysctl value because the
value can be changed concurrently.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jason Xing <kernelxing@tencent.com>
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netrom/nr_route.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netrom/nr_route.c b/net/netrom/nr_route.c
index 89e12e6eea2ef..70480869ad1c5 100644
--- a/net/netrom/nr_route.c
+++ b/net/netrom/nr_route.c
@@ -728,7 +728,7 @@ void nr_link_failed(ax25_cb *ax25, int reason)
 	nr_neigh->ax25 = NULL;
 	ax25_cb_put(ax25);
 
-	if (++nr_neigh->failed < sysctl_netrom_link_fails_count) {
+	if (++nr_neigh->failed < READ_ONCE(sysctl_netrom_link_fails_count)) {
 		nr_neigh_put(nr_neigh);
 		return;
 	}
-- 
2.43.0


