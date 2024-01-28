Return-Path: <linux-kernel+bounces-41773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 247F083F78C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE2C91F24665
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24E70823D6;
	Sun, 28 Jan 2024 16:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FEljcN5H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 605FE81AD7;
	Sun, 28 Jan 2024 16:14:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458497; cv=none; b=AabAuLg0Ho2qPuGatVENPtS1tvjC1V+jnPe0d2ZXlY5Ugz2ksKDOMOY7YBdAvck7Cjp6Z0nWJLKCoyWdwT5O6NrDyiSBU9ZdbrTUMYG5LHLGrxSmAzvdzXdUUGzAEoA7XeSo7sHITPKLkmw8OngAaU8V6dbhObMQpP9FrUGCAtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458497; c=relaxed/simple;
	bh=3wnEuBYJIuAxOgJ0atveQdxSQORBkskoU+TVlblzDcY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UNEuaV9cftZ0blz0VlEa7sATBttirKy9VhTIYtAYoOVPCFFfZY/LXMedOv0Z76fRBfrSWQeDdrn7nXgM9jitFgumWl1DJmKkDxBnz2cVJNEn/IEeziB2XY6TWqum6V004g5PUfeek0cNDgMG7iHx1qyaKH3/QQcLt5QwetzZ4+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FEljcN5H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70B6CC433F1;
	Sun, 28 Jan 2024 16:14:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458496;
	bh=3wnEuBYJIuAxOgJ0atveQdxSQORBkskoU+TVlblzDcY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FEljcN5HZddlOQraN1M11H7JCughH/w6v2ZrLou0dMEYYG15TrO4tdmU/A13R8hjE
	 5iIq7FnFSE2YftV52ELelxJmsomC1QWAUHLFK9o5wE9FGmkow2uqR/s+28k+hkd5Y3
	 c83MhCyCeK4d/TCwYSh6QnFyVihCQblB/nNFJoGCKDuUoLk/+Eo9xC5Ll6gCPhXsMG
	 hKFcows3GPdCvJpSpQL4RzXS+E3U7X01kRHvbBV/MoFlUoEnJrngIqyWeKk+Az4nAY
	 JFQaPgpE7e2z9fYn+Z7DomoaVd3qtvpmb4y6EFgM2N1qKxjEBWeEovIB7uAoG/3qli
	 7jXCTibX9fHFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	mst@redhat.com,
	jasowang@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 18/27] =?UTF-8?q?virtio=5Fnet:=20Fix=20"?= =?UTF-8?q?=E2=80=98%d=E2=80=99=20directive=20writing=20between=201=20and?= =?UTF-8?q?=2011=20bytes=20into=20a=20region=20of=20size=2010"=20warnings?=
Date: Sun, 28 Jan 2024 11:14:03 -0500
Message-ID: <20240128161424.203600-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161424.203600-1-sashal@kernel.org>
References: <20240128161424.203600-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.75
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

[ Upstream commit e3fe8d28c67bf6c291e920c6d04fa22afa14e6e4 ]

Fix the warnings when building virtio_net driver.

"
drivers/net/virtio_net.c: In function ‘init_vqs’:
drivers/net/virtio_net.c:4551:48: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 10 [-Wformat-overflow=]
 4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
      |                                                ^~
In function ‘virtnet_find_vqs’,
    inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
drivers/net/virtio_net.c:4551:41: note: directive argument in the range [-2147483643, 65534]
 4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
      |                                         ^~~~~~~~~~
drivers/net/virtio_net.c:4551:17: note: ‘sprintf’ output between 8 and 18 bytes into a destination of size 16
 4551 |                 sprintf(vi->rq[i].name, "input.%d", i);
      |                 ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
drivers/net/virtio_net.c: In function ‘init_vqs’:
drivers/net/virtio_net.c:4552:49: warning: ‘%d’ directive writing between 1 and 11 bytes into a region of size 9 [-Wformat-overflow=]
 4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
      |                                                 ^~
In function ‘virtnet_find_vqs’,
    inlined from ‘init_vqs’ at drivers/net/virtio_net.c:4645:8:
drivers/net/virtio_net.c:4552:41: note: directive argument in the range [-2147483643, 65534]
 4552 |                 sprintf(vi->sq[i].name, "output.%d", i);
      |                                         ^~~~~~~~~~~
drivers/net/virtio_net.c:4552:17: note: ‘sprintf’ output between 9 and 19 bytes into a destination of size 16
 4552 |                 sprintf(vi->sq[i].name, "output.%d", i);

"

Reviewed-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
Link: https://lore.kernel.org/r/20240104020902.2753599-1-yanjun.zhu@intel.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/virtio_net.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
index 21d3461fb5d1..45f1a871b7da 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -3474,10 +3474,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 {
 	vq_callback_t **callbacks;
 	struct virtqueue **vqs;
-	int ret = -ENOMEM;
-	int i, total_vqs;
 	const char **names;
+	int ret = -ENOMEM;
+	int total_vqs;
 	bool *ctx;
+	u16 i;
 
 	/* We expect 1 RX virtqueue followed by 1 TX virtqueue, followed by
 	 * possible N-1 RX/TX queue pairs used in multiqueue mode, followed by
@@ -3514,8 +3515,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
 	for (i = 0; i < vi->max_queue_pairs; i++) {
 		callbacks[rxq2vq(i)] = skb_recv_done;
 		callbacks[txq2vq(i)] = skb_xmit_done;
-		sprintf(vi->rq[i].name, "input.%d", i);
-		sprintf(vi->sq[i].name, "output.%d", i);
+		sprintf(vi->rq[i].name, "input.%u", i);
+		sprintf(vi->sq[i].name, "output.%u", i);
 		names[rxq2vq(i)] = vi->rq[i].name;
 		names[txq2vq(i)] = vi->sq[i].name;
 		if (ctx)
-- 
2.43.0


