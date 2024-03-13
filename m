Return-Path: <linux-kernel+bounces-102205-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 223D787AF68
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 60A25B22971
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5D5976C8A;
	Wed, 13 Mar 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hcdtVgDX"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2362D19F343;
	Wed, 13 Mar 2024 17:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349499; cv=none; b=EznuNwcm4fxC4gcQsTqrouXec6OwboMpEUqZZ9F3VtYYms2K/hF/ji4pBJuA9FhFAzNEVTsFtTurqKsP0NubpraUqWqdZ+xvYcYz0nhNNOwss1lyX0BP26YcpgAtEbQBEarbAaCQEhJ1T/4GBueX1c2UQEOG7fcfU/yG3UbBDX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349499; c=relaxed/simple;
	bh=VZRHEwnL/WzaJVkTZ8hBltol3g1MonXyJluGvB+l+Uo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lJDAbx5FNW8R0O9us9KOkFo1LiN//dcpIVhyKJbFDw8H5Ab1IRxQ3J+g1076UiRmEM4xSYARwuvIyftcn6h+ci5GU9PTbeJPKrr0AeLS3es2vyRHtb35GFNfnar4deQZbjSHb8ULQWoG7PcU09M6NHHHLzOZULWPACTGc7k/VwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hcdtVgDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51827C433F1;
	Wed, 13 Mar 2024 17:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349499;
	bh=VZRHEwnL/WzaJVkTZ8hBltol3g1MonXyJluGvB+l+Uo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hcdtVgDX/MduDDPor2XXYzDwcOKZcAk/xkkZShcXTnUW7s8iYMEINXmzjs4AF15OG
	 kCddxyXEJpnpJah9oTWFImBIqxpfNaxmmyHzBHBIdWBHDroSIOgM0cwJU9nny/2PKm
	 b0cD3rEfhtiC+OJgRINDMlzML1f8cSnLYiRPm+l0DgyM4y8iBHDj/w99PrYbS+j8W4
	 ICIha9kdnqehzeaVyqxqLmLbvZdxJD5yBqIhYS+/HcX78VPjc1tpiA+RKja8acC/n/
	 r9iUf1VjomnMdqsdGFnO39QOjniGym4z7I5XI6Kcds7oZ/mvk/H3c73VBnC39QAKml
	 8nyda2wKc8NjQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 19/41] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 13:04:13 -0400
Message-ID: <20240313170435.616724-20-sashal@kernel.org>
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
index 5769fe9c111ed..1d4b4d228ca0b 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -465,7 +465,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
-- 
2.43.0


