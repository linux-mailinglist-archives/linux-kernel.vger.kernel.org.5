Return-Path: <linux-kernel+bounces-124751-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B7C1A891C22
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 14:41:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72C752896EE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143FC147C76;
	Fri, 29 Mar 2024 12:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g1VEWq0c"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EDBE17D239;
	Fri, 29 Mar 2024 12:41:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711716077; cv=none; b=i8tvaKDHIYDL2ZH5PZOWJu53zojXWTHNuZ8Dbir4JkEpDew0oOdI2DTl+0A3MfiFtgO5ffyoM/6pf9/AFGlefp9zKbJw1rPKDai9QIGQciTkMb6JopsN9DWk/0c1H4W5OU1rr6GE1cS8qoEhUI0Gjriy/bZkdTtfmOiqzzh1I9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711716077; c=relaxed/simple;
	bh=vb0jjHzqNS70LcUl5hKquujKz9wsGE1cdmbFIdupZAA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q6dYQXxMvZvCduRd7jUcC3/UnN5ug75Srb4KRhHT3/rRw+uSni4eYp503O0L4o3hBSrxAu8lMGMSiP2tmQszN1T9mmR1aj96kX91Zm6yrF5m7txE1YjIQd78WBxn9/RvmKb9LAodfGDLT5bZN/hc5FxjP8yM/FbSQGkTKL+DYtA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g1VEWq0c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 417FCC433B1;
	Fri, 29 Mar 2024 12:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711716076;
	bh=vb0jjHzqNS70LcUl5hKquujKz9wsGE1cdmbFIdupZAA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=g1VEWq0cPJyN7PmH6KPEHgaEtKmBFxbdLdCe96v7/JoYjWiQf8LIyOPwSUTwQEH17
	 OpUvy8DTGo2d8MExRrJPdJBRB9Ceoukp+v/XtydBR94x/94ficmQr4AVlQH0OrV2mL
	 r0M+aQCN23nEv5JllWBCLWOsrQKnWHH7E6pMM2Zx8NWFDK1XZt6LJr6cDmkh0pwiqe
	 3SmfmLig8tvMyoXxDyCunZ/EH0cIoY1IvHD245M2MumQqZykXzgMzhkmHcnNXnXuxc
	 eXURqnCS95e1U0d9jOTNfLzVd9/A6oszzuwzRadkMXh9JManyQPWDqZUtWMH/Ul3Dr
	 oPuoy68lonY2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Mike Marshall <hubcap@omnibond.com>,
	Sasha Levin <sashal@kernel.org>,
	devel@lists.orangefs.org
Subject: [PATCH AUTOSEL 6.8 42/98] Julia Lawall reported this null pointer dereference, this should fix it.
Date: Fri, 29 Mar 2024 08:37:13 -0400
Message-ID: <20240329123919.3087149-42-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240329123919.3087149-1-sashal@kernel.org>
References: <20240329123919.3087149-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.2
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


