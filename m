Return-Path: <linux-kernel+bounces-36703-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4968683A53E
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 10:23:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D4781C248FC
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E3218AED;
	Wed, 24 Jan 2024 09:21:21 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B79F1802A;
	Wed, 24 Jan 2024 09:21:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706088081; cv=none; b=WjpxeaOQdPrjRSMcfYaC5LkND6ER2szqJgJ4uPjsBqBzKESfpx7Fx1ew746ox4CXeFTIAsp21WwbNf7lS3RxtpVAGyQS8HRloa1/jOz3/au3idYHk3Y5/73FUj5r5rwFF2RstQ/O27KlUY1ekm1Koks6ZXfEaH3zGsHUtbT0Prg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706088081; c=relaxed/simple;
	bh=OjTLjsUJhe++o4k4q8rXR78UKSsq+HIdp9Bt7hXT8n0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pGIDQnXJtmbu7/DrAxjdEDL/3ONeGY9g+ltb0MlOtu7l0ny57ze84yjoImCFjzi6YWgtpvnHAcsuMZOot8SkqmlWy9H7JO6gYbJEAVgKRmGcDX0zSZCpzcvqkEQ68AjIN0UpAfAE8I573c5RbP1rL4yroNUnVGID9kf544zqcGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.214])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4TKdd42v6nz1FJkT;
	Wed, 24 Jan 2024 17:16:56 +0800 (CST)
Received: from kwepemm600009.china.huawei.com (unknown [7.193.23.164])
	by mail.maildlp.com (Postfix) with ESMTPS id DAFFD1A016F;
	Wed, 24 Jan 2024 17:21:02 +0800 (CST)
Received: from huawei.com (10.175.104.67) by kwepemm600009.china.huawei.com
 (7.193.23.164) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.35; Wed, 24 Jan
 2024 17:18:27 +0800
From: Yu Kuai <yukuai3@huawei.com>
To: <agk@redhat.com>, <snitzer@kernel.org>, <mpatocka@redhat.com>,
	<dm-devel@lists.linux.dev>, <xni@redhat.com>, <song@kernel.org>,
	<yukuai3@huawei.com>, <jbrassow@f14.redhat.com>, <neilb@suse.de>,
	<heinzm@redhat.com>, <shli@fb.com>, <akpm@osdl.org>
CC: <linux-kernel@vger.kernel.org>, <linux-raid@vger.kernel.org>,
	<yukuai1@huaweicloud.com>, <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: [PATCH v2 10/11] md: export helper md_is_rdwr()
Date: Wed, 24 Jan 2024 17:14:20 +0800
Message-ID: <20240124091421.1261579-11-yukuai3@huawei.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240124091421.1261579-1-yukuai3@huawei.com>
References: <20240124091421.1261579-1-yukuai3@huawei.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600009.china.huawei.com (7.193.23.164)

There are no functional changes for now, prepare to fix a deadlock for
dm-raid456.

Signed-off-by: Yu Kuai <yukuai3@huawei.com>
---
 drivers/md/md.c | 12 ------------
 drivers/md/md.h | 12 ++++++++++++
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/md/md.c b/drivers/md/md.c
index 90cf31b53804..c803a805ea0d 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -99,18 +99,6 @@ static void mddev_detach(struct mddev *mddev);
 static void export_rdev(struct md_rdev *rdev, struct mddev *mddev);
 static void md_wakeup_thread_directly(struct md_thread __rcu *thread);
 
-enum md_ro_state {
-	MD_RDWR,
-	MD_RDONLY,
-	MD_AUTO_READ,
-	MD_MAX_STATE
-};
-
-static bool md_is_rdwr(struct mddev *mddev)
-{
-	return (mddev->ro == MD_RDWR);
-}
-
 /*
  * Default number of read corrections we'll attempt on an rdev
  * before ejecting it from the array. We divide the read error
diff --git a/drivers/md/md.h b/drivers/md/md.h
index 29b476ff3b9f..98da86d38ba8 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -558,6 +558,18 @@ enum recovery_flags {
 	MD_RESYNCING_REMOTE,	/* remote node is running resync thread */
 };
 
+enum md_ro_state {
+	MD_RDWR,
+	MD_RDONLY,
+	MD_AUTO_READ,
+	MD_MAX_STATE
+};
+
+static bool md_is_rdwr(struct mddev *mddev)
+{
+	return (mddev->ro == MD_RDWR);
+}
+
 static inline int __must_check mddev_lock(struct mddev *mddev)
 {
 	return mutex_lock_interruptible(&mddev->reconfig_mutex);
-- 
2.39.2


