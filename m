Return-Path: <linux-kernel+bounces-116251-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 83B1888992C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:04:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C4FB0B317A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:38:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BB12935D5;
	Mon, 25 Mar 2024 03:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tgH3HhFv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C9B31802AA;
	Sun, 24 Mar 2024 23:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324023; cv=none; b=dlCnO3j2MN9+ecdlsrzCDMCgIekyhf9qkGx2asjpQ3UdySDN/9L4VJ2GMvpqDZ4Yp6vyvcbGTT+ptYlCdDmT1f0AKAPr+SkcjuBUepQArNKHENhUSMiYQpCTyj+TNgkTuCowaa0vC1BWhMdcNRQYPXTZuz/ICkCXirtUCKCk6Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324023; c=relaxed/simple;
	bh=xKI0iG25BjEWQ1gvRDyg2KrUPAy82Y04LM+HtejJhYA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RDmiDjn5w7tN7h1O+ree8ToJ9jVhiEYnL2CUlpZ4xDvw2/vlRFBMonS5gXAeEsUFSypTIIQdjUwaupWFbagKSL72vPqdGJrb9fDDaDsWjEpoUAxi1KRTtxAaModFFv2buYQkzCgurqEKTwjFBjYuiQdbXnJr7dqbg+GrIHnyMkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tgH3HhFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BA54C43399;
	Sun, 24 Mar 2024 23:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324022;
	bh=xKI0iG25BjEWQ1gvRDyg2KrUPAy82Y04LM+HtejJhYA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tgH3HhFvUtPfnfdC+OJHNirsoN1VoD4aEDqgfs8LDIX+Xoqg64X2Ena06JdhQ03Bd
	 87o673uw3L9LiH9e9vqAz12nEmYdHS/f1//TCeSrJg4QlYQAgfkoZotnhajKz8RvC7
	 41ZsJw4is+BcUxeK0fHamb131S2EzhiLKWup8+6ozJUGpNdmzQGaIOwZsRTadThxwK
	 vWRJuzmSNTZKWHDrCn5HZPsZkcNC3lJifdtDw9YWz43rzuGyVfBUMoUCppGV51trUE
	 EOYYnK0hBX1xKHQlc82iZLzM37ANCeXF4lY32e8oi4Tdv52czg9SRO3lKEsTJVzKXk
	 9nCBujIWFkpdA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 023/183] nbd: null check for nla_nest_start
Date: Sun, 24 Mar 2024 19:43:56 -0400
Message-ID: <20240324234638.1355609-24-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 37994a7a1b6f4..f2d847ffcbc75 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2313,6 +2313,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
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


