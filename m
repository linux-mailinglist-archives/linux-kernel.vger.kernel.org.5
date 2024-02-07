Return-Path: <linux-kernel+bounces-57186-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CE1584D4DD
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:55:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E46C91F232F4
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:55:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772BF16DC71;
	Wed,  7 Feb 2024 21:26:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mrc5cFTG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA0B316DC67;
	Wed,  7 Feb 2024 21:26:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341183; cv=none; b=p5XL/lw+Jw1SFkBrpt/XBRBEsgRJq/zEjyNeAH/9nA3l6w5QzjGRIoRGYGRb6x1qRMrK/7NZtOH4vd5BIjNv2U3ayE/vvrWJ7ATpMx2wNitUdTs9E5EOxx3Zs2IVmI644yKzWrKuw4tUFqoy3GWFf5EJu+6nbqlnr5d4qw8Nz/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341183; c=relaxed/simple;
	bh=imuON0HVbiYuzTa5eEKSxtopIt0kcfoSoaAmegeTGEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K8XZIuyETuf1UymrqpJyx2nk6QIC4iuhnQGrL1l1pLSpKoaUT7P5RAoebjNokmlllx/ttZSnWur6nOPmaThL1kFfFoNxzWwSqEDIkT31SBqT8A3ORsEv34D0y0RvXHYDgGa3YcYpZEJhfZFabD8rF3n+Sns3l47R4hsKXp+Ef80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mrc5cFTG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19520C43399;
	Wed,  7 Feb 2024 21:26:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341183;
	bh=imuON0HVbiYuzTa5eEKSxtopIt0kcfoSoaAmegeTGEo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Mrc5cFTGtnmKa9IFYVh97EfK8MnK9uhP+A4zqJhtJ4R0hsS39DIBOR6Xaj4ULywCb
	 hyODUrbg/HW7ahAQkaHgvgZpM9Irlfnjt0OQAc/+ZpjFhSIFpuT4W49OFeos2TJTGH
	 e10DTX9iq7S+tcbzrGiTciH7ui5S50dPfW1NjRPDtuuSvjG9o7xDrd0pZs4lqu+Dm2
	 A6hekCQS7Necxj8KJe7Vm2StiZ8LESaj+QSRyL046gx/traCZCQ1xLvq3Lvhmgoj7Y
	 HLmlCPf/FDI0F3WloiLvXbqACnFlVVLuuL+Dih+RBvUsy2bbx5iw7pOIO0UCoZdxvV
	 7Wf+ZeqY2iNag==
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
Subject: [PATCH AUTOSEL 5.15 07/23] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:25:48 -0500
Message-ID: <20240207212611.3793-7-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212611.3793-1-sashal@kernel.org>
References: <20240207212611.3793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.148
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
index 4f2164a3f466..8468a41322f2 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1884,6 +1884,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


