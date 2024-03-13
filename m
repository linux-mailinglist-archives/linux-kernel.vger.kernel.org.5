Return-Path: <linux-kernel+bounces-101960-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1293C87AD1A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C20462853B2
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:26:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1092C13C9E0;
	Wed, 13 Mar 2024 16:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iRnL/H2x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D3813D2E6;
	Wed, 13 Mar 2024 16:42:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710348169; cv=none; b=dEh4oV7kvenDmI3OLhz1EVRQ8F2vMcYkWFjK86Sx57dTMRXRCceLitlrrRtLZVa6mwAuxdg1deUzbgNJoBPbDERAxccP8sfxy02ZFXx9W544WqLS6lkM74KXLWRmA4VkUu+p7SOrH6R+xMBrxuwwrQBZXA2lPWmXwptlucODylo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710348169; c=relaxed/simple;
	bh=was6sneh7FZD+9dPqJzYCOv8b8gK1yrXIKN6t46lAZA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VMJOQRmyle+BqPAuS1uhBJG9mOyIHBya6xWpxeCy19Vy/tbMG3P+OBvQf9GUbnSOwUi1fDDpcIPRMUxEHi9GnRGlIo/r8jnqT7htoUMoNq0DW8Jx+x8c3cSlCTlfcDwmNyrEB7v3zUUw8N4R6rdLdth4OsI1w8aPNubknRHtTVs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iRnL/H2x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48702C433F1;
	Wed, 13 Mar 2024 16:42:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710348169;
	bh=was6sneh7FZD+9dPqJzYCOv8b8gK1yrXIKN6t46lAZA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iRnL/H2x4HOPgIuKXtreAVHav5RX4+ZBgCFgeQKpty/QIGtfQc3lJ9VLgDzaFC3Eq
	 SnloBzhathjFiE+pIzmQLNRQOv3UBqKVvkqJ0RNgm4EcorLnrEbnaLnwc2TJMJzVyt
	 0DNdiS2VVy5bTrc73Cj9MrF4MOZB78rAasNbBZWQBvwtxvPcZLN/4qExHDLBAOKXmZ
	 8PZmC+heo1MR44hCU6CEzqOdw1GZrKl5SxjGYvA0j+yCBkcdlXKzXAOM4zXqmQ/tK9
	 e09z5NgOv2za78nWxQhXjv8MU5EfwADdw/T+Uj0fKxErt/ObkWYwnSV54MfmqqCD4s
	 sVn0dlk6i5NHA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 20/76] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 12:41:27 -0400
Message-ID: <20240313164223.615640-21-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313164223.615640-1-sashal@kernel.org>
References: <20240313164223.615640-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.152-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.15.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.15.152-rc1
X-KernelTest-Deadline: 2024-03-15T16:42+00:00
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

[ Upstream commit e799299aafed417cc1f32adccb2a0e5268b3f6d5 ]

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
index 6857510967448..678a7bbd84bf2 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -457,7 +457,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t2     =
 		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
 	nr->n2     =
-		msecs_to_jiffies(sysctl_netrom_transport_maximum_tries);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
 		msecs_to_jiffies(sysctl_netrom_transport_busy_delay);
 	nr->idle   =
-- 
2.43.0


