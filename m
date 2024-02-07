Return-Path: <linux-kernel+bounces-57156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EC1284D492
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:48:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1BC21C228FB
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:48:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A812F156968;
	Wed,  7 Feb 2024 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOc+r8aF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81091350C4;
	Wed,  7 Feb 2024 21:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341119; cv=none; b=awe7GbUzqBZsSceE29GVeiUnjbrWvw19AQz65xgAjKyGWRIxaZAGhsWSSMirZ7zw/e9HZ9d3EC5GOwdTx982/1ZRFRFZ2tRLCHDFIgs/9UXv994uOW54znKTtja8NwsdwRZXe3sr2SWEg6kwUHhJt6r3SQ0bL8LIl1MowY9pvC8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341119; c=relaxed/simple;
	bh=puyYeSo2l4KlFnf4mF8m+ZlwEJOPxG5a5Ms/4Hho2Q4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=I1un4wBm3KNpY6ZzekD6wTdJ48UuGThwk15xfa0CVLtho84FkpuefzBDF7jq9ztgOmyGN7f39OlWRPHvQn8VfVkypU6XDguysBwoUNbvrfjyG2jdrPzQJeoYvDXq0XjxYPa5Vh5LueTi4LjfEkF/9IfkTBePplrwfxRWL/ut97c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOc+r8aF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84B92C433C7;
	Wed,  7 Feb 2024 21:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341118;
	bh=puyYeSo2l4KlFnf4mF8m+ZlwEJOPxG5a5Ms/4Hho2Q4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOc+r8aFoEh2xdcecRSDybQz1c2PzM0Fg63cZD6a9YV3sOKkRxYaPh7fHIRluckWi
	 VUMvw4NQjKVtsGY5sNQGBnPYeq2TXucDQEmsIdgS3aVwaEPW2CSFOcZkK1RzxPcDIJ
	 RdoPS1S7kP2COGkCDRYM3phShA4aES169nFBAsihAMmVSrJFqnqFMM0uMWcrBqvf7o
	 mBUQIlVPcFBmM8STwmyuzOqCn7Agi8YtZZRlDuMH2P1DRJhcGNoWl2GAlWbhrYEZSm
	 mzCGLuSzvAIVulZCCbjo/3fLKooum2VGjBReq7RQ9I2BQ/A/h8bf/K1SV5sfPGsj4G
	 8WBI3JXgvb7+w==
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
Subject: [PATCH AUTOSEL 6.1 08/29] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:24:33 -0500
Message-ID: <20240207212505.3169-8-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212505.3169-1-sashal@kernel.org>
References: <20240207212505.3169-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
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
index ce42afe8f64e..348076827469 100644
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


