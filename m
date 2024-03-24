Return-Path: <linux-kernel+bounces-115608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D9188A4D7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:41:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 65149B65408
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:28:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B218347C40;
	Mon, 25 Mar 2024 02:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvNzhyW3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7AA41FEC6E;
	Sun, 24 Mar 2024 23:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321363; cv=none; b=bouD3EjiUQsK2Yrow0QSqW6hT3ei8jyIgou2zpIJ+hOBY7cUJ249nJ8sm+bXuKfvieu//HXEBOY143Sw/MWLCBr9I7rKu1mm3ENU7jw269jYgRXcblKI+siNJbmCR34HKGyjZsSRPUlMYWY8nZSjft8GqDrgkgE6pQEG1c60taY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321363; c=relaxed/simple;
	bh=iuDJNO0DaCTOuSrMMwWIo+ZzkIKJPWt7rbgvtIBljgg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OKN8wfC0kdPUoZWIFQliLaHELCoRrmlHvMJ9o4Qmec+JvcpFszRdcgnhQ/IcMts4u16lR/5U7291htHCzGLWF3Ad8Gxh6wOdQGhTQm0nPZcYQB2OyYpjtQagttSMmML1Sdg9pANjhA6TTQ+E0Qhdg/odKVgnsjYqw4abBmfQOXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvNzhyW3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06592C43399;
	Sun, 24 Mar 2024 23:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321361;
	bh=iuDJNO0DaCTOuSrMMwWIo+ZzkIKJPWt7rbgvtIBljgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fvNzhyW3Dabwe7mtNNOidqXioHiYbFttaaet5xV7DdLkKz7DdDN8azGbJ/DJLdoJ1
	 AJp8O+bP+s8ohvVM8TaInKG+aD/w5Dta8y993sFIcrKqfOQ6xFQKzgyf9KV5v8lZBA
	 w23b4rauwrc+jNIJkieOInKm05xDFKmz/e5WwpakYkMVBPZpgE8Va43+02NtUmIqmC
	 PWkj/jI57bSllzdO1/PIJ1LNc0v+3/RPcOGUahsT3+LJIimknX3H4xlsASwQ4754tg
	 RnBwZQMGKF0Yn7+FjELjbVsqdV4URYTbj61lym9HtYWBYOxgJKtEJlcCxjCAZ79Qjz
	 SRFUDKGNa34oA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Navid Emamdoost <navid.emamdoost@gmail.com>,
	Michal Kubecek <mkubecek@suse.cz>,
	Kees Cook <keescook@chromium.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 086/638] nbd: null check for nla_nest_start
Date: Sun, 24 Mar 2024 18:52:03 -0400
Message-ID: <20240324230116.1348576-87-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324230116.1348576-1-sashal@kernel.org>
References: <20240324230116.1348576-1-sashal@kernel.org>
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
index aa65313aabb8d..df738eab02433 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -2437,6 +2437,12 @@ static int nbd_genl_status(struct sk_buff *skb, struct genl_info *info)
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


