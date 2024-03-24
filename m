Return-Path: <linux-kernel+bounces-114753-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B578892A4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:10:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31549B32367
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:01:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1074C13D259;
	Mon, 25 Mar 2024 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mIjDvsZM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 374C62745E5;
	Sun, 24 Mar 2024 23:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323339; cv=none; b=WLBIqKWz/mHhYSNTP6wyW5+1mSb3u1fs3fUStq6kI3lNEg/+NuBIaqLD7zvIF3E3ZVcWdeGgGLMTKngcwEYGY+/SyRFLcQhSNwlysdhlWjVKWzECwSewqFoP9hmXmFKXtAsr5RGDfY3Y38cX346j2bQCqVU2MfPtG6G2UlZGgeY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323339; c=relaxed/simple;
	bh=FkizrhtMRdtl9haji7fZL+aV1FSNBAZUfsIZg0FBaI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+v+h8oYyYWBCG1xGzAmvzTqpRDBr7x6XNZslTRNDqASnlNu1m8OOeZyvIAwPNwrApzJkgI0629C9yTDKNTdWMBHY4d+qZmj8kiFP63Ws2BE2HKrF02GwK8qEhYVwsZRxHS2tDIrsSU5wYfPtpTTMGefHWNBCOO6PDvYkiCEg9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mIjDvsZM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D56BC433C7;
	Sun, 24 Mar 2024 23:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323339;
	bh=FkizrhtMRdtl9haji7fZL+aV1FSNBAZUfsIZg0FBaI0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mIjDvsZMvox5tLjCb4mYs78qvkwNH2iX4IFtQ1+mNXk5dhxYzaCjAKAl6+0P2vFy3
	 5zZw0EfKb8m0Kul7Klp7STPzgOrrFdekA8eCB165HEKIh3TwgKfhXvRSbylAes6sPv
	 31g/VMnbnys6/DFpSomlKSrZBJtyy4gKSU5F+KWawuwkABoJ1VJO9yOievX0eF6mA9
	 G2dA2A8pSPb2TvmX0S95Qmz6E9KcA/hYHrU6/87/4aP43p7UsZr0tn2kvO5kb17lrP
	 GtnPoCwf2zq8FoLBDPydDwN0mgQAwS9e6ig4THg2Zct2kRILG8tjLyN8NBZNBItAV8
	 OMljFvmCm3VFw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 039/317] nbd: null check for nla_nest_start
Date: Sun, 24 Mar 2024 19:30:19 -0400
Message-ID: <20240324233458.1352854-40-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: Navid Emamdoost <navid.emamdoost@gmail.com>

[ Upstream commit 31edf4bbe0ba27fd03ac7d87eb2ee3d2a231af6d ]

nla_nest_start() may fail and return NULL. Insert a check and set errno
based on other call sites within the same source code.

Signed-off-by: Navid Emamdoost <navid.emamdoost@gmail.com>
Reviewed-by: Michal Kubecek <mkubecek@suse.cz>
Fixes: 47d902b90a32 ("nbd: add a status netlink command")
Signed-off-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20240218042534.it.206-kees@kernel.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/block/nbd.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index d379a047d4273..d12e9f1721c8e 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2344,6 +2344,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
 	}
 
 	dev_list = nla_nest_start_noflag(reply, NBD_ATTR_DEVICE_LIST);
+	if (!dev_list) {
+		nlmsg_free(reply);
+		ret = -EMSGSIZE;
+		goto out;
+	}
+
 	if (index == -1) {
 		ret = idr_for_each(&nbd_index_idr, &status_cb, reply);
 		if (ret) {
-- 
2.43.0


