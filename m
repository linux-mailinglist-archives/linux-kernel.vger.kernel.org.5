Return-Path: <linux-kernel+bounces-102140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6ED187AEC1
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:07:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8748E1F30438
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:07:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618677172E;
	Wed, 13 Mar 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cYxwE0+7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1B3A71756;
	Wed, 13 Mar 2024 17:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349355; cv=none; b=jhYfDeVn7T+QTmDmGJHsIaUmaQmgLFLSLjg/Gk5omYjeit1Tuhq3QCs9GVeo+JL/astTnJUs2JI32zyAjZoK2mxuYE87kj19lQmyWT5uaWa8/9ahjNeEZ9tqgYkxaYa2AQRGAURJIw2IbfDTAORxFJ2xtUUIWrIp31fNbnxPhTY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349355; c=relaxed/simple;
	bh=0LJ2CWf8dZ+ux98zpD23ZC+0kzCfQP0p3T3DPZ2ji5I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XCHEK/NNGBw/OEn+hjZHCuBctnND3f+vReWzmUNzhs9r1+33HaZMnSN3vXKaX1L/4cPMorBEyRE3N+O+FaKUKzLi3wJY4XKZjbq62ZGmZKvYwWJ1ffb5jTHMAzFlGsO1P4vO4wboCmZaGMq5e+JfpoJrl3uTt1SfR8yjW997g8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cYxwE0+7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D2727C433F1;
	Wed, 13 Mar 2024 17:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349355;
	bh=0LJ2CWf8dZ+ux98zpD23ZC+0kzCfQP0p3T3DPZ2ji5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYxwE0+7rgbHZlEvQm3SRbRV3UPBI+Ma31gvlnG/IEglVqHddzHRpm+hq9b6/sH+Y
	 5be+MBwKUUkdhg2GMwEaC90tPowzhGyexgprfDH5u0FY6OeK+DugxYfQXV+dOYl/xr
	 pfvqZ74pWyzBDwNgAM5lqhoAvoRKIj9Wnl5fiZtNkwuFQlO3cAPtBEsP3pLLtNxLpx
	 g801MmCKIjDB1eUq21EdvxKzBI9GRJkWdRqJBZUSBR0b8Je6EO0PUbII4lQgw+t5Cv
	 pwt/ePb8200kpDrBc0cjU1bRwwJSW9VXRL/n3x9HF/ZeEYgf8+CliDKIqfcZOalXKR
	 USDF5l71Cfh/w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 19/51] netrom: Fix a data-race around sysctl_netrom_transport_busy_delay
Date: Wed, 13 Mar 2024 13:01:40 -0400
Message-ID: <20240313170212.616443-20-sashal@kernel.org>
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
index 97a13de007e12..d02db01edf2fd 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -437,7 +437,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
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


