Return-Path: <linux-kernel+bounces-112929-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13FF7887FD4
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:45:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1C55281299
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2251373534;
	Sun, 24 Mar 2024 22:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MFO9Kd0x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5876D73509;
	Sun, 24 Mar 2024 22:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319741; cv=none; b=tqMV6Q5tSkuHjpDhx8BqiCCqSh2e7zXLWSYCpLhykOpopUBUJhnapoN6msfi8EFqZ0SRVSw+n/fGjB8DyEUCNjBtT7FgXN3hc/5I7Or+B8ANTw+UWXrcbiDn7hLsfYXseJ42iozXFq4gNM9SG199+faokCOuHm3k8hnoE9M+r80=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319741; c=relaxed/simple;
	bh=sISgqsba65O84SziZyljgb9eLMnknulilo+A5OuNOLc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U+qlGtWdOemoIV58EBbvLeUjPp+dkSZcIs5jEK3aQpzHGXifRfqpmlmmDtqxd6gz/Kv/QuQ7+/k5seHOKPfP9fjrEMby1CcNKoZKRstVVP7QNDa2eBIbwCc6GIUcNAdSRuQE9Bxo7AwYaC65gUXIpLl2aujUapn2Ve6kbiCa+YU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MFO9Kd0x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE74C433F1;
	Sun, 24 Mar 2024 22:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319741;
	bh=sISgqsba65O84SziZyljgb9eLMnknulilo+A5OuNOLc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MFO9Kd0xUclEX0iXZ4cRbxxxwWhMY5NHE9WlP4b90Sp4DqMfmDWHVxt+0FFlxvFJm
	 e81QY93aTfJtwzPz3nK9nP4GGt/uGf/RE/Qoyp0fe+7dZpoeQQhgUioQD/IrcQ163r
	 hUErhCy7P4jdV/wlYltRobFmY+gkBYuyKUDqgvo4iq8U6gZI4+Fm122K748+aYH/37
	 KX0lVIwePeDi8Ui7UZq3JW7Pr8omKt5GtBuKZjDOxVo8CHOMhH9c6mIKeHU3fwFrBC
	 iHRA56fbBJfAhwNoyI94rCGWSWulR50GjaGn+mGt4vfCaL8qhSugv7YRZYQrqZI2JA
	 5Y5dmM18z6xww==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	Daniel Wagner <dwagner@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 042/715] nvme: host: fix double-free of struct nvme_id_ns in ns_update_nuse()
Date: Sun, 24 Mar 2024 18:23:41 -0400
Message-ID: <20240324223455.1342824-43-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>

[ Upstream commit 8d0d2447394b13fb22a069f0330f9c49b7fff9d3 ]

When nvme_identify_ns() fails, it frees the pointer to the struct
nvme_id_ns before it returns. However, ns_update_nuse() calls kfree()
for the pointer even when nvme_identify_ns() fails. This results in
KASAN double-free, which was observed with blktests nvme/045 with
proposed patches [1] on the kernel v6.8-rc7. Fix the double-free by
skipping kfree() when nvme_identify_ns() fails.

Link: https://lore.kernel.org/linux-block/20240304161303.19681-1-dwagner@suse.de/ [1]
Fixes: a1a825ab6a60 ("nvme: add csi, ms and nuse to sysfs")
Signed-off-by: Shin'ichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Daniel Wagner <dwagner@suse.de>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/sysfs.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index f2832f70e7e0a..09fcaa519e5bc 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -221,14 +221,11 @@ static int ns_update_nuse(struct nvme_ns *ns)
 
 	ret = nvme_identify_ns(ns->ctrl, ns->head->ns_id, &id);
 	if (ret)
-		goto out_free_id;
+		return ret;
 
 	ns->head->nuse = le64_to_cpu(id->nuse);
-
-out_free_id:
 	kfree(id);
-
-	return ret;
+	return 0;
 }
 
 static ssize_t nuse_show(struct device *dev, struct device_attribute *attr,
-- 
2.43.0


