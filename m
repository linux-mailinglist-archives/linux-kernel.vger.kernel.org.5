Return-Path: <linux-kernel+bounces-112909-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52E67887FAB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:40:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 152AF28135E
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 22:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C57DC5FB83;
	Sun, 24 Mar 2024 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tjAYMapN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AFCE5D8E1;
	Sun, 24 Mar 2024 22:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711319720; cv=none; b=KZhSmkUAGsVFgr5pKcyoLdct5SBQr8FZUv7d+c8mSH5vVj0xwVjNrCeRVT4antIyo1ub+NlaThSHNz01Wpc4rpk5ym7hOccIQJO1vi7CzS7Bb89AXmdXLtXpZ/Ha1mnYY+1ro2Cg8jb5474PsG9z6suQ+5ve8lQ4PTtUcLPL3L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711319720; c=relaxed/simple;
	bh=6alEoGO6nr4EhRoVtIgT4k+syFQEq+PbxvG/g+gpRtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=px8M99ssIk4x6dEkY3LJAxNc7Dzdy8GPQ8jm/nopuifZUDg1WWRN5v2RIlUYkVteGnIhEbYG6FAVK/QuEXM3U7KG7FRn1qZNgwSUYDKOwkzA/ifmgCvlcvgLSvCtftuLnXRdEjZ5vTfduOg58jseW/xdLuUpcLb4Y0USDeoTMeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tjAYMapN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E182C43330;
	Sun, 24 Mar 2024 22:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711319719;
	bh=6alEoGO6nr4EhRoVtIgT4k+syFQEq+PbxvG/g+gpRtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tjAYMapNswU1PIExmjPGLhRuvWkh/HjxqDqyTIVbpOQcA3A7kTZ1Qid/Hya8YyFAg
	 2wZcNUElFH3UFvESexGK2AfW81fygh1dcZ/lLY46inAHuejE55Fo2+e/ZsxrcEXNrZ
	 9xzMFcdU8KrwgB0EBXjzHrKBxEKrwVmqsWniGaJNL1popSE1wGUm39I6pfl2Jc1dr0
	 cSl1Jg4sGoBpYxHjStcBWtdw2gARPAtchwJGJR3vfnR34Ph0tnyrP8Cwo8gfieuCrV
	 VG7r4Zw6JKsK8eRQJEWMb13GM5ZPD3CzeyRRYLDzu4k8Bt8qWd9gjblddm/hFxxanf
	 HploNJDTj7mVw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 022/715] nbd: null check for nla_nest_start
Date: Sun, 24 Mar 2024 18:23:21 -0400
Message-ID: <20240324223455.1342824-23-sashal@kernel.org>
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
index 33a8f37bb6a1f..b7c332528ed7a 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2433,6 +2433,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
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


