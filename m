Return-Path: <linux-kernel+bounces-114947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D041888C21
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 05:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C9B10294BA8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 04:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEDF72DBDFB;
	Mon, 25 Mar 2024 00:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hSA/Cn3R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EAAF17A392;
	Sun, 24 Mar 2024 23:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323659; cv=none; b=JPgG6i/6LbPkAG8KGvhsQcbg3uhk5lu2yzrxrd1eI88e2KjBSuq9J3JKZgpF34N2SxJe9fdxe0Oaifji4br5kxBq+7TLhwPoe40bODX1qEDeieXpAgt0qQxeuZdIgvOyqhOfeVXzjK0oQvgTdAXx33qCKMcaGmwZFI+CDzxlT74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323659; c=relaxed/simple;
	bh=AcMANvlJML9SIuMbfJooYhS/xPwzVCuifP/AAL+ivoc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S01mcK/bPsR4OZ5u5BOwS+/nrDX6NJz5LVyunVrY5kJsAKVb5IpeXByTWViMM+QiSKvEnQwIoYmAVGloUoHAEO0UuJN7E7EHnt6TbK/y2Ldc/HBs4jXqnZNHqat344b0FhoUgSDt5ReBbAbZ/itplmkMrYqGWL/9lUQBO7vczM4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hSA/Cn3R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0BABC433C7;
	Sun, 24 Mar 2024 23:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323658;
	bh=AcMANvlJML9SIuMbfJooYhS/xPwzVCuifP/AAL+ivoc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hSA/Cn3ROBPFdbqq7NAb9Us3TZ3OX425mNnUuBAdx89UUkLAhd5aInXWnqq91feyX
	 8IQDds5tlvnmB/871W0DFTeyfQz2gimJIWZSS/5FHV+S5BTOS9g7VeERRffpQJq8Vl
	 dR6+LXldPZkr90M9hv+VuhzmenDTajHOnfM8WDxy/inyO+/5u5gUn1KHJEbFAbWdFl
	 l7yWzyk7EuYy7Cw9l4I8+N5Tvc65m7gc9lBOB3MpxlzKtx2O3bVyb0VQl+bUwXU4QM
	 BXqK4H8NXgQzE3K3qt8QPoYkZoGTvY+JF2NxFZlTYepAwebAA4JYL/j2w4qD4wfinX
	 zXNY4TweD7I+g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 030/238] nbd: null check for nla_nest_start
Date: Sun, 24 Mar 2024 19:36:58 -0400
Message-ID: <20240324234027.1354210-31-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index e0f805ca0e727..d6e3edb404748 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2339,6 +2339,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
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


