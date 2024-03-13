Return-Path: <linux-kernel+bounces-101847-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA45287AC1B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 17:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DDA4B25164
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 16:58:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AFE073529;
	Wed, 13 Mar 2024 16:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKJhftxs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45FD160266;
	Wed, 13 Mar 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710347883; cv=none; b=rwIjlVXjMX5npVf4SengpyiRl1uToBDG7prZctlTSe6PbFMBLDH7Vvz3e5UPuHL1tLydGzIr6QsY2UZK5Ikm060arcuKQTWSwVbusO5aRGdznaRSmLdRkl4O3/H2LyBEZ++9QfH6o76nyJxfgx1HDY3Q9jEAHTKQ4FdNCkz45MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710347883; c=relaxed/simple;
	bh=Kg5CzTCI/aSwzwDb1CxVoo35KWkaaUVw8H6Vm7Z2kXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E0HlvUYQdHSBxvGrtq+cJYw011AIOQUnCk/gXZfVahQwSpPk7UjrTsIaMG4A571eZuIUZwnGPYSad/NpYgDhrt7l+SbJaugcA7ehnSCJ+1Lqqv65VHC7yOzgGf7ps/SocFgX/j9cdQQXXAGpzJ9pX8JFfZBATIkYakqUvAnHyaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKJhftxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 725E3C43390;
	Wed, 13 Mar 2024 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710347883;
	bh=Kg5CzTCI/aSwzwDb1CxVoo35KWkaaUVw8H6Vm7Z2kXY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VKJhftxsIqxDVORQLUNCupeFzjqjStaK1h7/0+QhhYxcOrFgD7VkhRCjxK5EUY4yq
	 iuQgWpxV0JvDX5yLKo3ApajcnN60MMNyCcrG/3U9NIbyYwQ1Y9UcC5dpWONMOUsEqs
	 uy022iq4+SuP6CvWMLvS+dFmxaEwQvYdG8I342UMrAlMrG1lV3ay+G5vlHQM9MwPMs
	 TxiV0S2d3dxtSixxjHlFnOWgXL1bJWXCDgz0NNWF8JosqYx2pOZcrelH8TKharptbc
	 WFMoIgUsaPyjaEpDW5aa1Et+A4wiWlOC5KFKfrhUwRINzBDiA6eSqmkGIpTI+9s27n
	 MfPKPHZ7paC/Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 44/60] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 12:36:51 -0400
Message-ID: <20240313163707.615000-45-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313163707.615000-1-sashal@kernel.org>
References: <20240313163707.615000-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.6.22-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-6.6.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 6.6.22-rc1
X-KernelTest-Deadline: 2024-03-15T16:36+00:00
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
index 474044072baf9..3aa52187cf982 100644
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


