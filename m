Return-Path: <linux-kernel+bounces-102141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BEED87AEC3
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:08:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC2BB1F3087B
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 18:08:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E8D70CCC;
	Wed, 13 Mar 2024 17:02:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QrQggCwH"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A97A573167;
	Wed, 13 Mar 2024 17:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710349356; cv=none; b=MPjxiUe0WsB8Fe8RSFhCe9bsTvlrBbIHvsigXFOmbKlIiSnWmHKzO6YoFhSYOPJ8oS2WoMIQRi0WhagEzfsijmaqfM/QTzvhogqFDogjDuubTULNCCigjB9Fao5hHjO2J5zXR+y6A9Py5BuKcTu4LBxhHaTPjnqucPWZHXS/u9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710349356; c=relaxed/simple;
	bh=UGTS1l72uXNu6ldUQ6JlOoZmBkgNjDDfy824JbPUXKs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WO2FZ1YbGQGBtj7gWo6750DqH+1xnSoBJTpaiXmnJ8Sog1NkQRcYgykTO24WqNI14B1uHZ7MMC4J/Qm+8MNECm1k5uXzBj5tR7DheuKTb9CWPSr2EKYJlzC7CYNaVjvoaMV8+JoJ+Jj9cnx3nQmjfmDGIpv0OFbNh8M8khfxpJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QrQggCwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0F2C43390;
	Wed, 13 Mar 2024 17:02:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710349356;
	bh=UGTS1l72uXNu6ldUQ6JlOoZmBkgNjDDfy824JbPUXKs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QrQggCwHIXWUXh7GDf7PcNfARkmaXFWN5g20NqcdYcz6sgKPQp7mBBPDLgqTY6bhY
	 snVlX/2PCtwN80AQ91VvFcMkmZfNPUlmO9+VcDC8/OMq9tyqggoDOwyO5bbUWrOCmR
	 5x44z7tFG5o4uDKS0DbxNo5N9WsMzYaTyHbqJyzRsSrDmilfmguNNLL67ifPO1ipTr
	 GEul0Yg4DCA0cEmyhf9FLE4jOlWdOB/5w69skQ3O3ef4ftQPCtuVnHuVd05sSPJENx
	 JsQFIC2e3c8ko3pzPB+iwODONxEkBdu8Rrdm70vhuxLPyESfko4gWgcznEk9lZp/M2
	 t7xbqZ3htGa4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jason Xing <kernelxing@tencent.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 20/51] netrom: Fix a data-race around sysctl_netrom_transport_requested_window_size
Date: Wed, 13 Mar 2024 13:01:41 -0400
Message-ID: <20240313170212.616443-21-sashal@kernel.org>
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
index d02db01edf2fd..bf29260f6e52a 100644
--- a/net/netrom/af_netrom.c
+++ b/net/netrom/af_netrom.c
@@ -440,7 +440,7 @@ static int nr_create(struct net *net, struct socket *sock, int protocol,
 		msecs_to_jiffies(READ_ONCE(sysctl_netrom_transport_busy_delay));
 	nr->idle   =
 		msecs_to_jiffies(sysctl_netrom_transport_no_activity_timeout);
-	nr->window = sysctl_netrom_transport_requested_window_size;
+	nr->window = READ_ONCE(sysctl_netrom_transport_requested_window_size);
 
 	nr->bpqext = 1;
 	nr->state  = NR_STATE_0;
-- 
2.43.0


