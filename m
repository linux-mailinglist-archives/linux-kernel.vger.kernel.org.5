Return-Path: <linux-kernel+bounces-41696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F28E783F699
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 17:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9179F1F23FBC
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Jan 2024 16:15:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8502B4D11A;
	Sun, 28 Jan 2024 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nXhZSh6B"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2A6E4CDEB;
	Sun, 28 Jan 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706458317; cv=none; b=sOZdh+2qrlRZOZN3HjlMQfzvd8Z5Z1GflIXL9kyKqaNeiZHjcTLp/R/aTsKssCAkhoOZZPW2UDQoVCaMJeBRlat8U09my1P/xtepwwTuaZJpA4yajz4VysSD0kvmbqvusNWAyRsqAK746LGdPIfQVuJBnH764p9sc1Sy8095a1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706458317; c=relaxed/simple;
	bh=qt+N8RsM6CZzZE+LkE+2WmMAo5sR09PdsTCBWicgfD4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EPzkrHmDa670FWaQVHnymj4iMj5WOYl/p5KHsRrQYaurHxjDZ6db/VdLC2iaihjbLsAtnyE/Ri/ehftXX2QX3iv0GevUfuvxL67exSJeW5kKl5e+rdq70chYWPsAmuQUFpA1rHPdXpDpeCl7HpJkXQ5RWJzA9BfmfrzSu1WJJ3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nXhZSh6B; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86B8EC433F1;
	Sun, 28 Jan 2024 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706458317;
	bh=qt+N8RsM6CZzZE+LkE+2WmMAo5sR09PdsTCBWicgfD4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nXhZSh6BuGWQXLAwwCDSrpi4T8GvV35gXcHISEeeWKF/7UPA+yzwwnP6pS3kBfo0P
	 1sjEn70g8ioK0b2uqhNJlTGvYzCTb+WPbb6wy+Mqa6jRyWxomD0q+z7a9iJTNmXnhq
	 bHP7z5ZqiRPI1l4Gfn+wuRbuoVC1zjU+VqWBG/a8QIkQsth/3ECDIT1C16U4tjy3+y
	 RlHaPdpd61DYmdDmjcQi3XP9eA3hzD6BiYh0rSGqPlsZACl8XqWfystLjHpU7wAggf
	 Ku+b0mhQPgNWzNrnewK2AdKUZZnKWx66/Kw/jQZ1PymVsc7ce5nyw59P8BbKAK4w+E
	 jLuWgwU0pUq+w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Piro Yang <piroyangg@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	soumya.negi97@gmail.com,
	alexondunkan@gmail.com,
	andi.shyti@linux.intel.com,
	ruanjinjie@huawei.com,
	linux-staging@lists.linux.dev
Subject: [PATCH AUTOSEL 6.7 14/39] staging: vme_user: Fix the issue of return the wrong error code
Date: Sun, 28 Jan 2024 11:10:34 -0500
Message-ID: <20240128161130.200783-14-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240128161130.200783-1-sashal@kernel.org>
References: <20240128161130.200783-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.7.2
Content-Transfer-Encoding: 8bit

From: Piro Yang <piroyangg@gmail.com>

[ Upstream commit 5090a4bc2a2f04b7693b49500ad1287e8d0fb6c3 ]

Fix the issue of returning the -ENOSYS error code when an error occurs.

The error code of -ENOSYS indicates Invalid system call number, but
there is not system call error. So replace -ENOSYS error code by the
return -EINVAL error code.

Signed-off-by: Piro Yang <piroyangg@gmail.com>
Link: https://lore.kernel.org/r/20231219170447.51237-1-piroyangg@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/staging/vme_user/vme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme.c b/drivers/staging/vme_user/vme.c
index 5c416c31ec57..9bc2d35405af 100644
--- a/drivers/staging/vme_user/vme.c
+++ b/drivers/staging/vme_user/vme.c
@@ -341,7 +341,7 @@ int vme_slave_set(struct vme_resource *resource, int enabled,
 
 	if (!bridge->slave_set) {
 		dev_err(bridge->parent, "Function not supported\n");
-		return -ENOSYS;
+		return -EINVAL;
 	}
 
 	if (!(((image->address_attr & aspace) == aspace) &&
-- 
2.43.0


