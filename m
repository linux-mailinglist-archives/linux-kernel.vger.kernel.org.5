Return-Path: <linux-kernel+bounces-57123-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 056DD84D440
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3A1E28707F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:39:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0016714A08D;
	Wed,  7 Feb 2024 21:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IO1kAHKL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FC9314A0AA;
	Wed,  7 Feb 2024 21:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341043; cv=none; b=Wujpjak8axyfAXh6Vo/JXuWFiRXl/D7VVbn5qt4J8sid8sHDChdtl76DaxTCa+gdTAQRPRjat6YlYFomnKljagzfivcC9qcn5IsYMbOtdxOu9tl/YZdq0D815obKNSYSy8Z81Sxvdpi+qs+ECQTaz72fZiYDWRffR1OZ3S0/uiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341043; c=relaxed/simple;
	bh=i/lCxb5N+Eu7fAfBjRlrdAQLF4uSmeZXYbLchKgQDRg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fw6oJTqmJJ6Dd8G4yQWCEceyhKUzuYy4VyfAEmmBJEcDZapZAchnxVM8ZS4X8fywqkjMmbCk4T379N9Gydj4BdBau82nRrjPSwiAyvwx9XxGTxRxuk6lYhpl2r8iMt1NLsTqMVYfo9LhO/9z9SZjfC0GouAWpJjxJomXyyYXPeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IO1kAHKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69148C43390;
	Wed,  7 Feb 2024 21:24:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341042;
	bh=i/lCxb5N+Eu7fAfBjRlrdAQLF4uSmeZXYbLchKgQDRg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IO1kAHKLSS/kJwx0ynhpGqiXHSM8ELWM94BuxsSxlOkURoK9c6iaQTyAQpDKHk4d+
	 KJ756LK59TQLq9uS930gJjpxTYqe7FciAXHBTWGuLJUj22SRMNNiYM+sn08+Mcraei
	 xbU2vHr8dWIRvZGlP+jzcPpOXECsjv4pPBpxE09WDA0r8hEyNPn16d0cC/m82NccXR
	 pThTx4pQ4oL//APHG2zE5SnDlB8XE607mH2Kuu81ZANOINfAoR8mAF8UVhl548N24k
	 c1kXO1NUTtJUP/kiLXn0bkEWg7HNU+8kBmpUM/O5CIhLKcJ5zu1pYwGZusYgsMZ/sO
	 gZU53S7e+Vf1A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Guixin Liu <kanie@linux.alibaba.com>,
	Christoph Hellwig <hch@lst.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 13/38] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:22:59 -0500
Message-ID: <20240207212337.2351-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212337.2351-1-sashal@kernel.org>
References: <20240207212337.2351-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Guixin Liu <kanie@linux.alibaba.com>

[ Upstream commit 47c5dd66c1840524572dcdd956f4af2bdb6fbdff ]

The nvmet_tcp_queue_ida should be destroy when the nvmet-tcp module
exit.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/tcp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index a4f802790ca0..8e5d547aa16c 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1927,6 +1927,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


