Return-Path: <linux-kernel+bounces-41830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E684683F82C
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:50:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1BB328AF8E
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9947148FE4;
	Sun, 28 Jan 2024 16:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T58wxG9Q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE51B1487E7;
	Sun, 28 Jan 2024 16:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458635; cv=none; b=lKPNV+l41Y9TTIMRnriuYT0J+AFICHLqIm7CzFZnEEFdlDxGl4ZcK5HXYIFjnqTUtFJvA3/XGhcvP4YVaedyPm5qEp6tnoVy+5XzYeo5f69kc30t2o6CoeRrdmKabFxEepwfw5nbIgcfXO46RfMebXdSnEPBGSXwUPMg38I+k48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458635; c=relaxed/simple;
	bh=haGh8Qmcx85n7azvNjbxI55Ci4P3GMvux9C2S8J/pjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=E0PKeE4F1uDjQHl1i18f5WvgHM+99TnQGnt/mnwpWUc/YqVvqpxRrt6+lnzrf+bpIT3E/u1Gqw5d49EJamsjtRRGxjQdY8n5mhJ7TFNk3fZq/DCreD+BFRsdC6uMMNh1TckEhXmjQf7ZSozX2B0UAi2tQJHbS/zgx7CvcWJkZu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T58wxG9Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57F02C433F1;
	Sun, 28 Jan 2024 16:17:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458634;
	bh=haGh8Qmcx85n7azvNjbxI55Ci4P3GMvux9C2S8J/pjQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T58wxG9QfKMk9bLXOUVYgvAZbmlVh+cUpcFp0+NQdMmEsXI9rsCh6cfOM8oq6c9NK
	 kG23YRcpmW3ZBdG6c+sV/O3ScK4x36s/pyJaXpTXBQni+ssNW3j+Ua/NN3Ilm7zuTW
	 cG8ZZ3lFZcCExje6Ca55EG5ODfc+Wo6NMiuHEVbHxKdaopoQ+awS4Xs2mX4iZJigjb
	 b2QFyCOmPiv75AzFIdPxgVJg6hastcmP3Z+roVDPHPV86qnPPFjDOvBg+gM+SX2sSg
	 2ypgMWmLsPUJInUIqz1vRi2bFZpjrrPqzImd9PVtNkud87aSzPHZK7T39+IXJbuJdd
	 X4luBQNdEq4kQ==
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
Subject: [PATCH AUTOSEL 4.19 5/8] =?UTF-8?q?virtio=5Fnet:=20Fix=20"?= =?UTF-8?q?=E2=80=98%d=E2=80=99=20directive=20writing=20between=201=20and?= =?UTF-8?q?=2011=20bytes=20into=20a=20region=20of=20size=2010"=20warnings?=
Date: Sun, 28 Jan 2024 11:16:56 -0500
Message-ID: <20240128161704.205756-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161704.205756-1-sashal@kernel.org>
References: <20240128161704.205756-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.306
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
index 331d74f9281b..2b012d7165cd 100644
--- a/drivers/net/virtio_net.c
+++ b/drivers/net/virtio_net.c
@@ -2727,10 +2727,11 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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
@@ -2767,8 +2768,8 @@ static int virtnet_find_vqs(struct virtnet_info *vi)
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


