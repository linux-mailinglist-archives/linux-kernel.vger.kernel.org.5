Return-Path: <linux-kernel+bounces-124839-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D6353891D38
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 15:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5EEE9B2CB58
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:06:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD1BF137934;
	Fri, 29 Mar 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nj8oiWKn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0713E1BAC2C;
	Fri, 29 Mar 2024 12:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716266; cv=none; b=iT3RM5qPN6vOGdL/4M0Ia9YRoZ2nu9b2Oc6sX9vcHP8qnazxgMgI1aV8WXKlBqVNPpnWQ/0Mg1nhXOR+YDUL7dqRGluvIn3iOooFOyGFEY+AVbuZ9rg0DObbRmTo5GvgkJ8lv+TkfrwCcAPTFRWgUdeuh5oToUgDsbQEUY5XhWU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716266; c=relaxed/simple;
	bh=vb0jjHzqNS70LcUl5hKquujKz9wsGE1cdmbFIdupZAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XDTtdrM9B3evkLxBQ4sfELNSE3EPmGHRtdgF39RzJq0qxt/rRIPp9rK4ht0wCOY0rl6bpMdiZwCd33yarT1K9Ijxp9wtgtSewFCGTstlXmr9D2e7ryXdz/n6CdmJd+UXCpSUkZqRaANIYZv4Ugw1jNB0e+EiWRaUky8ZNb13CKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nj8oiWKn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 344E3C433B1;
	Fri, 29 Mar 2024 12:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716265;
	bh=vb0jjHzqNS70LcUl5hKquujKz9wsGE1cdmbFIdupZAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nj8oiWKn4VYZHbHkQcS5tXOJrnOSGO8Bg13Jv0KicxO03loslE5VhG6eJ1K8G1LVZ
	 6SNRKLkHvKv1p4P4gSX85zUGT/qWVMJynHUy0bOYGkfts/nxp8R44xm/Zac4tzwwrI
	 540Una68i3zD32Z6COnsYb98smwke/lqMaIE6bedtSqcnXhly/+eD3qRmPpJyOHVly
	 jA75GLX5OIN1nFdZkMUgKoRoghu2kjWC6QbSRxNpBFMuuEHMbKodC/qiHL+FlPSXID
	 Ia7D68w/B9FANNGe4MUX83rZZDrNUa2D84/p7efFMijtigR2+hWGQtECQdwRN4XeHj
	 9WGlUWSHJkIMA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.6 30/75] Julia Lawall reported this null pointer dereference, this should fix it.
Date: Fri, 29 Mar 2024 08:42:11 -0400
Message-ID: <20240329124330.3089520-30-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329124330.3089520-1-sashal@kernel.org>
References: <20240329124330.3089520-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.23
Content-Transfer-Encoding: 8bit

From: Mike Marshall <hubcap@omnibond.com>

[ Upstream commit 9bf93dcfc453fae192fe5d7874b89699e8f800ac ]

Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/orangefs/super.c b/fs/orangefs/super.c
index 5254256a224d7..4ca8ed410c3cf 100644
--- a/fs/orangefs/super.c
+++ b/fs/orangefs/super.c
@@ -527,7 +527,7 @@ struct dentry *orangefs_mount(struct file_system_type *fst,
 	sb->s_fs_info = kzalloc(sizeof(struct orangefs_sb_info_s), GFP_KERNEL);
 	if (!ORANGEFS_SB(sb)) {
 		d = ERR_PTR(-ENOMEM);
-		goto free_sb_and_op;
+		goto free_op;
 	}
 
 	ret = orangefs_fill_sb(sb,
-- 
2.43.0


