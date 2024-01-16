Return-Path: <linux-kernel+bounces-26740-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BD2C782E5BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 01:52:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A0AEE280FD1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 00:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB39E2E3FE;
	Tue, 16 Jan 2024 00:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q6NVFs+w"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 045552E630;
	Tue, 16 Jan 2024 00:24:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0221AC43390;
	Tue, 16 Jan 2024 00:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705364693;
	bh=rxdra0NJtnEX6VQkow5tBh3w0FHp0VNjslkfq1f861Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Q6NVFs+wLFsNWqH3RbAZh0Ziv46dU8EarcOK0xhe8gcSdw15YQ8fEXj4ZlazAQM+t
	 aO6N639E45SmrafgQmzSD8ofLvMQUHj5NkJ5o4pzBB41v0EUblCSC019Rs6rWvZi6e
	 uCGiQUkwtJMQHe1ugvYD+75e7/ugAa9n9u8WF0ZnoAqSsvAL1Y/pi6NgGjVV9XZ7fU
	 rEM58DCNgKIiuEtslx+6bMqbFXjEyal6ey2E70NGpo7k9FtgYQHifqL4zv04qBxDti
	 wwQWN4BxZGLbhecxjCjuK3xPjt2KRd3V0Fyj4E9AOtzS/mi71DMw6TVZ4QB720+taI
	 U/GQRVS1Nu/JA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Andreas Gruenbacher <agruenba@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	gfs2@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 18/19] gfs2: Refcounting fix in gfs2_thaw_super
Date: Mon, 15 Jan 2024 19:23:53 -0500
Message-ID: <20240116002413.215163-18-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116002413.215163-1-sashal@kernel.org>
References: <20240116002413.215163-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Andreas Gruenbacher <agruenba@redhat.com>

[ Upstream commit 4e58543e7da4859c4ba61d15493e3522b6ad71fd ]

It turns out that the .freeze_super and .thaw_super operations require
the filesystem to manage the superblock refcount itself.  We are using
the freeze_super() and thaw_super() helpers to mostly take care of that
for us, but this means that the superblock may no longer be around by
when thaw_super() returns, and gfs2_thaw_super() will then access freed
memory.  Take an extra superblock reference in gfs2_thaw_super() to fix
that.

Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/gfs2/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
index 5f4ebe279aaa..8f229914c1e2 100644
--- a/fs/gfs2/super.c
+++ b/fs/gfs2/super.c
@@ -818,6 +818,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 	if (!test_bit(SDF_FREEZE_INITIATOR, &sdp->sd_flags))
 		goto out;
 
+	atomic_inc(&sb->s_active);
 	gfs2_freeze_unlock(&sdp->sd_freeze_gh);
 
 	error = gfs2_do_thaw(sdp);
@@ -828,6 +829,7 @@ static int gfs2_thaw_super(struct super_block *sb, enum freeze_holder who)
 	}
 out:
 	mutex_unlock(&sdp->sd_freeze_mutex);
+	deactivate_super(sb);
 	return error;
 }
 
-- 
2.43.0


