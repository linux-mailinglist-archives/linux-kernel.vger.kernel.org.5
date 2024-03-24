Return-Path: <linux-kernel+bounces-115774-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE758897AA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:19:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C7631C30A81
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6C436D0F8;
	Mon, 25 Mar 2024 03:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z+t3mM9d"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76283145B05;
	Sun, 24 Mar 2024 23:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321993; cv=none; b=lQLKnQQD7mANMP/2U005YvBeJPrCSnh01T2cx3y8mhJnksB+tu2dnVeaUB416i0+VOVJBkH4EbZL4inI5y2oIeQgz5jLDRy3ZkQkRxva0P7OQO1Mv7XEsUut/6QLHULLrpfRGdkZWhiVQHITIU73jWbrO81BkR/sGJvyJ4ycm3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321993; c=relaxed/simple;
	bh=AvB2jOdPf2snJyGE9H3oF9PY1mJQo3Q/t+9yru2FeY0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nOID53Fg6p1yxpCtzxFYAcCp+hvKjhenL1f7IH2yNL8UObQXwznzosRkpIFpTMMUfkeEr5dGIY5R5AY4qjlCzYFt5CTY/lMINx49OOcCYFVwmq0b69ovA+sKnzhJ8eEcXn4qECESHcrPLEKiohghKRf/bZz0k6HXv7cl2+1bZXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z+t3mM9d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 830ABC433B1;
	Sun, 24 Mar 2024 23:13:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321993;
	bh=AvB2jOdPf2snJyGE9H3oF9PY1mJQo3Q/t+9yru2FeY0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z+t3mM9dkGE0HboF7J0m3cSE7mL+a4N1vZIN/+Z2g2KwLp4hib5wLzwFHOkqtOcp/
	 rHA3w1JFaRuiPS82ANkafzYH7wA1h35Ycp9s871MQFX1i/cHCHSpZavgkyf3vjLwQd
	 a2NjYC4t5QwZrjG+0Yzl5bc13JYepE3N59CBhadbEnng0s7pWLNaOn674TazVykW4G
	 829Q3ujQo1mkKkwLiq/6XS8cMsS7oTzTn9vUH+VJ6TUEa9QdmEo7eNiNxLifzGXVtz
	 8ftWRqI6ZexyHTTN24RB1WSS5MBEX7/68C3dXPgWpIbxgC61gw1f7h3wbLvLU306Tu
	 51ELuG/pESSkg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 065/451] nbd: null check for nla_nest_start
Date: Sun, 24 Mar 2024 19:05:41 -0400
Message-ID: <20240324231207.1351418-66-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 9a53165de4cef..5c4be8dda253c 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2408,6 +2408,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
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


