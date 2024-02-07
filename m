Return-Path: <linux-kernel+bounces-57208-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAB6384D523
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:01:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 883BD1F23C83
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D64F763F3;
	Wed,  7 Feb 2024 21:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Esfgsvt4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8099F179A1B;
	Wed,  7 Feb 2024 21:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341231; cv=none; b=EW9aAewPOQbf2bAyQ1e2Qfm7vKFlY+9aDUfWa2q99cs04De6vO+NN3sjIg+KN2lRw2GHiWxMiQYNzVsQTPhpKtIDAcrzn4jcTFarrJ4g+gtkN8chJyb2td4r8lc1/VbvT4zS3hSQqP2M7f+A6DTlcfpSrO9hcTIF7Tvk/NMuZxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341231; c=relaxed/simple;
	bh=PtluBwb/hTPum/AkxPGIjQDPKHKLJXdNLqHDtulcw1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SqLpJ/LeZ8wgiOy9gFyvJ4LMH0Yk6rOAjoZGAeXovpR0OiSCT3ZLiyS8cS0htTzGpi4IeAcCN50PaUsmDb8T4kUsP7YPurtF2E951waHKf0M2Jf5Rm3qGRcO4Cmxg4R+Bfs2ejA+PWUwo55Oav0yzJHfaWdtJmD3gf4acBXhJVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Esfgsvt4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 275D4C433A6;
	Wed,  7 Feb 2024 21:27:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341231;
	bh=PtluBwb/hTPum/AkxPGIjQDPKHKLJXdNLqHDtulcw1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Esfgsvt47P4fJl4pTFUAfKeDhBRVZuk6+I0kg5LjssptfcRjeeYnazAppcwRCez6v
	 bmxsks1nnLyJxIB5mght8eZ5rXhNUsf+9mMdE65L+VJrcz85AqZNxco5iDE5JeLAk+
	 hP4X7kzqIYE28rwVSsRoFM8U5NL96mV0TswAFP4XW73h55kSdV+MBXTX3k6KhxA6gY
	 Auyt34cQ17/sv647UHsqp8YUAgrX6vYhqlUiEhd9UhOvYZnP9cqclvX1bq8b29QsAj
	 /ACXsACgYPooTCWauUVXPNbCZE+D/xMmGnQ5G54lJdApsfc5P+t9jk4Klq7ByqW/BD
	 RVoG9SEr3dvOg==
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
Subject: [PATCH AUTOSEL 5.10 06/16] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:26:46 -0500
Message-ID: <20240207212700.4287-6-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212700.4287-1-sashal@kernel.org>
References: <20240207212700.4287-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.209
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
index 116ae6fd35e2..d70a2fa4ba45 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1852,6 +1852,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


