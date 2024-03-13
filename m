Return-Path: <linux-kernel+bounces-102139-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 61C0587AEBE
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1C7D2281AA9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A701471B2F;
	Wed, 13 Mar 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nE67Y3+1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF767173C;
	Wed, 13 Mar 2024 17:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349354; cv=none; b=YUdzzNDxsiueglfYEyDyRWiPyzexJYqXrVoz8JkkNj2cjmf4n5VizuFAlN0RVwSi2fXzREPmRAX0NLRXoiZiaRdQmX9dswoDf5+93qBOOo2TXXzftMSFXbK5q/dI490g906PYhHx2s+rD4KNJOTHbOUSSHy44rZ0unss4+AyNns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349354; c=relaxed/simple;
	bh=erNC/8qzS6O1NIyTUrabCWi/ATbBM6EvcFvhgaL+SbQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oAn+kxknEYu4yE3nZk6bKMBSkpLBTqz7zIFMt5SMb5dNGMRMNqOP6ABjm62ufmk5k0ZnPCSHpLdizBh8GN5j+u3PTmVc1vKV6ibwflmqXBFj7rDGDgN0QWMDsZM4LMOgaO35e1+PbuHsqZTWRXQ9441tiw1xHlP1brttXdn0sWo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nE67Y3+1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80CEC433A6;
	Wed, 13 Mar 2024 17:02:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349354;
	bh=erNC/8qzS6O1NIyTUrabCWi/ATbBM6EvcFvhgaL+SbQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nE67Y3+1Prf0316g43fFK7iNSUmNwEj/ClJTub7qRJeUGAW+jlswMoKBG39TpAg5S
	 6il3BI80Er3Vram7XHTYjyKXk9+b1CL2BflKHVDGpt79TeX1+aSwJ2mjTYyErf/eAT
	 eXx83ZctY46xKQd6VkcDtKdq9Dq28HwgRcRPDU9vRvW6voE3FVDgh/VMizOIJXQy0Z
	 5R/yH5t0KzbNbW+exg12y/QcBKKElsHoRFnMg8eXkeCd8yBQJ9pSAaSk33Rv1wCDYv
	 NPHxQfAOhy0szebvPxk0/xRmrzhOB/RS3cV+kNBQNdNFgM+Pbq6Kw/v6eCpZxd9A8r
	 Iw0TrZjvgGqAw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 18/51] netrom: Fix a data-race around sysctl_netrom_transport_acknowledge_delay
Date: Wed, 13 Mar 2024 13:01:39 -0400
Message-ID: <20240313170212.616443-19-sashal@kernel.org>
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

[ Upstream commit 806f462ba9029d41aadf8ec93f2f99c5305deada ]

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
index d05d56cb9c660..97a13de007e12 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -433,7 +433,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 	nr->t1     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_timeout));
 	nr->t2     =
-		msecs_to_jiffies(sysctl_netrom_transport_acknowledge_delay);
+		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_acknowledge_delay));
 	nr->n2     =
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_maximum_tries));
 	nr->t4     =
-- 
2.43.0


