Return-Path: <linux-kernel+bounces-57078-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D79A84D3CF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 22:25:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D0204283434
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C30E81292DA;
	Wed,  7 Feb 2024 21:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWCSPIPG"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0351350C5;
	Wed,  7 Feb 2024 21:22:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707340928; cv=none; b=auihSKW5W4vt/JO2coC4LdIu6YkOMaPTJY0BCFq4hiKAGt5DfvwTjy24tfbFmO8jUZ/v7QD3999lhpOWgydQUXc6JRMuE1Y9OJdJmnsIrSInk3QK2xei7EqHsYuw2TvgDThf2LaBmtY1lgwSnx7iXP7QaPVc75gnqWxrVKAVnJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707340928; c=relaxed/simple;
	bh=lZyhELCGofUNRqQmKhsc0dA6pzAI1lJzPtX2LcPIwsQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eFDFE5TNXOaQ9TP7I9WYbFQuMYbqRKzSixTKTEkRnF7KP9oARhEOv05xj97Q95DAtgRTUQM9ava7C+CcxALcl6hjaUX+yV6blrNkjc35jhexE5JnstsWmJp0KiB44Y5xe9dX00lkEuG0R134OBVCx1ft+Hwy0I18u1GMWjJ0YeY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWCSPIPG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B57CC433C7;
	Wed,  7 Feb 2024 21:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707340927;
	bh=lZyhELCGofUNRqQmKhsc0dA6pzAI1lJzPtX2LcPIwsQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bWCSPIPGT8knF9Qq0Sy4N71HGH8cCfYhIWbSuNmJOlkOyg27MuNpfuRjyrQzGkZjB
	 sGDesl5LHwSvM6AJ1pGLLcJuI/bvBHTn1AUCL5GynIbwrAOeR5WDoHrfF2NlaamB6p
	 1waIcGeA4C4HS74J2SG/9+HKHPQ7iaI/VFKpiNP9WC7ieorPgi92IBh7M4gmKq/78K
	 QsF4pHE/3dvBMkDKjKcbL0UcJZvd6IkAQcYKZ5KRV5wByppHuSilx6VIT1fi4Tiw6s
	 5d9guY5h+yTCxdGldq0W2eoCBuj9N9GgnfdY7RnlabeAS5q8pGyVuS/5+udhS4EBlq
	 b4HvYrs6Apefg==
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
Subject: [PATCH AUTOSEL 6.7 13/44] nvmet-tcp: fix nvme tcp ida memory leak
Date: Wed,  7 Feb 2024 16:20:40 -0500
Message-ID: <20240207212142.1399-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240207212142.1399-1-sashal@kernel.org>
References: <20240207212142.1399-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.4
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
index 80db64a4b09f..bb42ae42b1c6 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -2204,6 +2204,7 @@ static void __exit nvmet_tcp_exit(void)
 	flush_workqueue(nvmet_wq);
 
 	destroy_workqueue(nvmet_tcp_wq);
+	ida_destroy(&nvmet_tcp_queue_ida);
 }
 
 module_init(nvmet_tcp_init);
-- 
2.43.0


