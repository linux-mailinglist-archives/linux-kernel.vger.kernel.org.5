Return-Path: <linux-kernel+bounces-102137-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7298287AEB9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1E3F9B2490B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A356B7173A;
	Wed, 13 Mar 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kA7EDuXN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C01EC70CCC;
	Wed, 13 Mar 2024 17:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349353; cv=none; b=tjCJIHzlSYHejBubxi23wXU8ZXSuAQk9RJKbLopAHM1CWXvG5ePZPdmbUU/Ic7wt+OJJcUuXAq+hG4S5gW0Px2Bx16MbjyCz4OrH86mz/HIBMrudkpefRlFGnUMUrCcgSCt1RxH87/8q5cA7+Ud3w+R3XpWYCKLzipCmaTxsCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349353; c=relaxed/simple;
	bh=dxSDHYZ0NxYmU2ijrygEvgRz4Pt2IxLssXFRTn+O8pA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S9JaTaZWuNgaBsFAYT2yp7msFcNzaSAt/A83n98W/EKKpl7ysaNeJ5FpJ3DQgmGcGcWk0rfmfOzMtjDolUFjjL54E3RI8IXrY4L5CbWoSQw3q5v2/RGrRk0OeS+cgjmu4V0neQUKzobIb8+8aHEJsF3HnSvQ09n7YiHnSl4xBsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kA7EDuXN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8C22C433B1;
	Wed, 13 Mar 2024 17:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349353;
	bh=dxSDHYZ0NxYmU2ijrygEvgRz4Pt2IxLssXFRTn+O8pA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kA7EDuXNgd5qQVgYeTXljenr2c78bXb/WOaeFERCQchelz5fCsaaIGm9y/yA4Dkcm
	 zcGRyVa+oMQgoNPNFIq8pyEWGP7gFYWLm6USrZwmhyYD8APOGiVYg5/2v40uFqrzoy
	 a9pUZwx5GFVmKDrirhgiKfX3AaHqeJP06fYv5lwRI5AIeqhxYEtGd070XbADcKZuAe
	 WQWuPxqcfakMfHman2GQCbE3JC7OTbaLKayv09rjnyt3fnjgOKlHN8hahsgV9x1hWm
	 ITX32XHk5b7Lb3iJ8m2VXZdnKfd9eOvmC1S50B2prKb1hPz0rqYm3/4ACULFpBxUaj
	 oIuC+SQwEO8MA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 17/51] netrom: Fix a data-race around sysctl_netrom_transport_maximum_tries
Date: Wed, 13 Mar 2024 13:01:38 -0400
Message-ID: <20240313170212.616443-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240313170212.616443-1-sashal@kernel.org>
References: <20240313170212.616443-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KernelTest-Patch: http://kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.4.272-rc1.gz
X-KernelTest-Tree: git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git
X-KernelTest-Branch: linux-5.4.y
X-KernelTest-Patches: git://git.kernel.org/pub/scm/linux/kernel/git/stable/stable-queue.git
X-KernelTest-Version: 5.4.272-rc1
X-KernelTest-Deadline: 2024-03-15T17:02+00:00
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
index 097f4f3b4929f..d05d56cb9c660 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -435,7 +435,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
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


