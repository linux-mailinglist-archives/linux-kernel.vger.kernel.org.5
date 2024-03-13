Return-Path: <linux-kernel+bounces-102050-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3CB487ADFB
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:46:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5F5B5B23E59
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD8B15443F;
	Wed, 13 Mar 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgNmSR1i"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A12E154421;
	Wed, 13 Mar 2024 16:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348429; cv=none; b=O5zlMItr2TjqtizjU4p18oWdk48BGWjdbkX5hKzx/GbG79GUZWDjC9tNxJCPx7FdehHHDTXK2rhp9+dggIP8PDHZdAxqEi5G3MZ7AOfjhr5l+Tanbvdobvn8JSbUGqfr9mYzLr3xzl/hcG1uZT+sgVBwDZnBAE4eHvFRLEpweZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348429; c=relaxed/simple;
	bh=JupO535FDJs874LcX2bRQiX9YuUvDP4z5KRR1MTFWag=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NdV97I+LNHRGLppQwryBQo3kuJa4oFIUvPbY8Fvg6nkWvXMVzCT7WhQ7h1YqxNX2301jhhh6KInpevg/l8zKZU4Pqq2Dxuph6ikaOqy40P6zr1Wxu8Wyzws4H3NUqGyJOBNAn1RSajKlv8cbNtnkOS9G76PZB/0hNuEL4LURhXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgNmSR1i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BD23C433F1;
	Wed, 13 Mar 2024 16:47:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348429;
	bh=JupO535FDJs874LcX2bRQiX9YuUvDP4z5KRR1MTFWag=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgNmSR1iCAoTr7kcLbJ0/r63BV28vty0uTZEbVDvvqpGWu4znHlvOVarTXNk7alD3
	 8Ow/3aAxuLqAoIeOEqCFL903xIT1Pok1IZLbUVfOlRh8y3QHQpSysIF1GQUQ/flq9H
	 HwtpjC9ZWiLoHiY80VcMpyhbo8AsUBwDHD8unqlHyJH37gHb6r2EfgiSH4FAA38kNS
	 z8oaSGJl3YFHxt9dEqefw6Hjhc+cU/ARpux82kgRBuNi0FS02Wu1gU0ngFKGwnKEwr
	 wbhKc8sQOJEeKJM9Yx6rRCWJsIX8gMNLAwh9aLvcuD0NBq8Z5uLrtur1WuQtHISnRD
	 R2QLlLCVqM/sw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 24/73] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 12:45:51 -0400
Message-ID: <20240313164640.616049-25-sashal@kernel.org>
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
index 5a5cca18ae0c6..76d66eb0de255 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -459,7 +459,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
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


