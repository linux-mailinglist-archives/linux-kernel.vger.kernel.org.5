Return-Path: <linux-kernel+bounces-57222-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02BED84D549
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 23:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B30BD28E979
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:05:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B25AE139958;
	Wed,  7 Feb 2024 21:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hB2ngZyR"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13A2139943;
	Wed,  7 Feb 2024 21:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707341260; cv=none; b=FUhd9PJWy5XDdll7GsPxZ5775ssCZA/pvEzBPjzJBsXHmtu7rUnNTFVtAChczQ2LZ7t+QpssXn+WO3Jw9IEMuxr/1l0SB3Q1hKXmbNqh0IfEqefXbEY3hjKBqhDAwDUztXirEAWkqLtzN29TOsS5JSRAR/FZYEPtKrCNGmZQ4A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707341260; c=relaxed/simple;
	bh=vxyIEZwKCT6rz43a/AYtVYVP8Bndf5FuZkBUysk32bU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mzDHoYUbVJObkP+hGmPrwCV4HTOrRDrRMfDN6dG86Jup+AOVFEon95zveFW6e1V1kLxsTbz6ziK/0Ar2A4eWn1rELKYWx3JNoL3rFmA11X4S3JtfURV9JousvkouWPXjTIodChfwtJ1zpk/7sNBaTZzrtblFp+jUdhCuWBRUMKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hB2ngZyR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA575C433C7;
	Wed,  7 Feb 2024 21:27:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707341259;
	bh=vxyIEZwKCT6rz43a/AYtVYVP8Bndf5FuZkBUysk32bU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hB2ngZyRCWiNLUBaucNS5J/bTKiBOKxOKXM+4Rvh2yBpaHABNq/xRHCxYT7sUiAs+
	 6OuoBJcIsJbDzuhTK3mC6aPLk7UxcjkZGdGKyUFd6TZUOeiVHoxzgFJMaVvEvG+gTF
	 kv73ghESdGX5rNhQZaCA7Px/BjJb84bVQA4jD1zsfE1TyA34QiNyIvBGuF7IhP0zyj
	 L9E0SxuJc2yAHzhqNsFaraa51Ep40D2F86jgR8d1tH5QI8/Emrg8v6hMlVnTEQKfmV
	 76QGMAz1hDKd2nAz9t5xQiB3JDT1ZC31FqWJ6JCCaPp8aASfxVqjL130ALObkyZrZN
	 ULOsyyfPoJ36Q==
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
Subject: [PATCH AUTOSEL 5.4 4/7] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:27:28 -0500
Message-ID: <20240207212732.4627-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212732.4627-1-sashal@kernel.org>
References: <20240207212732.4627-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.268
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
index be9e97657557..d40bd57537ba 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -1817,6 +1817,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_scheduled_work();
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


