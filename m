Return-Path: <linux-kernel+bounces-8549-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C499881B944
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 15:07:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 02F521C259FF
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:07:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D84E8360B8;
	Thu, 21 Dec 2023 14:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uC6jk/c5"
X-Original-To: linux-kernel@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B332360A1
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 14:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=eIaYI0ct3kzN+uIpwX8VkuvulkFIVBzGuvKucGJ7sP4=; t=1703167522; x=1704377122; 
	b=uC6jk/c5VTe/lfpbjdwn22RBn3Gm5TRTVHsQLt05glL6bWWIcFClVPkLM/CoxhJ3tXFee0olggL
	mIuVKxLoFRHtO6Poxwf0nG4tJ2W73a0kl+zsAWlHnpejdZAcL7V4JA0AiS66o+ovjlMJ74PqUAk9w
	nGiST2/FXLC7qGLyyz0vcNWfF6I0nilGz2B4mI7GtPUMDe5zZfnyaS6brCS+LQgQF88r8WmrM8X5j
	NU/EV1QkApn7Y7IiGWNhsYMZaqB9GZgNsBTDpx3dq4hV1uaypZd6rjIkAGjVfa4ac4+vnY1usGmRU
	b7eyjjFAy/Fhlz6h6IZPDpn5JDEBIJA0FBcA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rGJfk-00000002t3A-20p8;
	Thu, 21 Dec 2023 15:05:12 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Subject: [PATCH] debugfs: initialize cancellations earlier
Date: Thu, 21 Dec 2023 15:04:45 +0100
Message-ID: <20231221150444.1e47a0377f80.If7e8ba721ba2956f12c6e8405e7d61e154aa7ae7@changeid>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johannes Berg <johannes.berg@intel.com>

Tetsuo Handa pointed out that in the (now reverted)
lockdep commit I initialized the data too late. The
same is true for the cancellation data, it must be
initialized before the cmpxchg(), otherwise it may
be done twice and possibly even overwriting data in
there already when there's a race. Fix that, which
also requires destroying the mutex in case we lost
the race.

Fixes: 8c88a474357e ("debugfs: add API to allow debugfs operations cancellation")
Reported-by: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 fs/debugfs/file.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/fs/debugfs/file.c b/fs/debugfs/file.c
index 5063434be0fc..6d7c1a49581f 100644
--- a/fs/debugfs/file.c
+++ b/fs/debugfs/file.c
@@ -104,12 +104,14 @@ int debugfs_file_get(struct dentry *dentry)
 					~DEBUGFS_FSDATA_IS_REAL_FOPS_BIT);
 		refcount_set(&fsd->active_users, 1);
 		init_completion(&fsd->active_users_drained);
+		INIT_LIST_HEAD(&fsd->cancellations);
+		mutex_init(&fsd->cancellations_mtx);
+
 		if (cmpxchg(&dentry->d_fsdata, d_fsd, fsd) != d_fsd) {
+			mutex_destroy(&fsd->cancellations_mtx);
 			kfree(fsd);
 			fsd = READ_ONCE(dentry->d_fsdata);
 		}
-		INIT_LIST_HEAD(&fsd->cancellations);
-		mutex_init(&fsd->cancellations_mtx);
 	}
 
 	/*
-- 
2.43.0


