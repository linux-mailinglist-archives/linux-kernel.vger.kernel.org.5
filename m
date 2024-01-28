Return-Path: <linux-kernel+bounces-41822-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B80283F816
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:48:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ADF321C22687
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:48:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FC43145B3A;
	Sun, 28 Jan 2024 16:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YJnFoJ13"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A243F524BB;
	Sun, 28 Jan 2024 16:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458612; cv=none; b=jZTBbazXgvnAIgv0IMipJnvSvHj6ikgGKHOfLQZDXbyDODvY7ynH7JRrl71tkaBMtCiLfA07UBzLmyt0+edY3vAVKgUUpo+bZHsC8vKIxRrzY5X0y5bUfej2v8KIke+XutrXjizSAUkxGWwRC4gY5bTqVWbn9wrU4+2kNmqgESM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458612; c=relaxed/simple;
	bh=17+TA5YRK2OnCwpOtW5/xDu4vsGekw4PjGMIc719mzk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oheTBEwXHk3yrIqIw8XuRsg7MI+JYT2WEmZt3TZazxbV1ecEvoGiGfujPksApaF5fc8CugjX1B9B42xh/wJONJdH+b1OYpgRfgxdV+qMRnlsq6a4iItFYTn+DydK2F8VqcA5S8yQVde57/2kkiti4SLNNKoY+Lz51M2iW2SVibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YJnFoJ13; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D36E3C43390;
	Sun, 28 Jan 2024 16:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458612;
	bh=17+TA5YRK2OnCwpOtW5/xDu4vsGekw4PjGMIc719mzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YJnFoJ13ITfd7/lIZcUb27UNtniCGQfVie7s2e+Fi3zbld0E1RkucROpBE+b2Z+UO
	 C3YM2HgBfLGk2qqbQDAN7L7MBdyw8oo2MNfbohK1LcXdN0gc+PFLYbS9FWpMlDQf5h
	 s1N8ClMsrWHtdez5HndBDvwNWxQ80LtKNdbwRZq0ATNquuDc2iNOITeBfFglHmv7/O
	 ol5sZUlX6oFgT/QT49aDo6E8PDr83/+t4ljB/G56KaRfZaOredzbP77H9qk9Kva9KX
	 XBywYXHXAdY/cThWFamk8Zm7sZzNk0F0Cv1uGvKfwC406JLRvgGoSgUVG/8b8iodnt
	 46FEqYKhjtRag==
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
Subject: [PATCH AUTOSEL 5.4 08/11] =?UTF-8?q?virtio=5Fnet:=20Fix=20"?= =?UTF-8?q?=E2=80=98%d=E2=80=99=20directive=20writing=20between=201=20and?= =?UTF-8?q?=2011=20bytes=20into=20a=20region=20of=20size=2010"=20warnings?=
Date: Sun, 28 Jan 2024 11:16:29 -0500
Message-ID: <20240128161637.205509-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161637.205509-1-sashal@kernel.org>
References: <20240128161637.205509-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index f6a6678f43b9..4faf3275b1f6 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2864,10 +2864,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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
@@ -2904,8 +2905,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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


