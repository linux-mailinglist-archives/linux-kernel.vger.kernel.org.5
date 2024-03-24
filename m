Return-Path: <linux-kernel+bounces-114259-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6528889A0
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 03:59:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 427A0B2735C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 654AF25999E;
	Sun, 24 Mar 2024 23:25:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oGZs9ssf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C976315250B;
	Sun, 24 Mar 2024 23:06:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711321611; cv=none; b=s3PMZhz+l/YI/hL4QkZ5qXjMi1u5xqacjR1Fc6bTA218mbZCnrdDUpi41bhOU2YJhYEjVis21ZaXh3iXu2oMBX99WndKpJG8jXBykEogP+Z7yqWlJuMr0RGCEuAwnoWIsh8nZKgbwIBqkqTA2LLtaa5Jrt3+cGL3Uk7ATNFsWF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711321611; c=relaxed/simple;
	bh=UGaxFGHhiCU1ABKGD20RSDZbKphjf0z3i99sFcOZKJI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TI/APd8QriOVz5PDrdqihvZueLb4jfju+D0f+YK1/XfD4eqOl0bE2yr4l9GKlp06YTwGCgyxnxAYeaeVX4C2YLKi6AmngA/W1htWODK21c/36zrjfwg2HGEHJi+On8qNMKVvUl3tdW+xiwv9PqZ/gsqprVq4y6l4cOsPPMb46lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oGZs9ssf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF901C433A6;
	Sun, 24 Mar 2024 23:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711321611;
	bh=UGaxFGHhiCU1ABKGD20RSDZbKphjf0z3i99sFcOZKJI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oGZs9ssfUc/r3dp1d4jhbILpdJh8blJ9kQjuTAF/vQ8Ub1vUzbtE1213WZZrnFCWw
	 Co3rv/HEDNud4/syIdWcKq6JaTAhja9f9GuB6ojzsE+7q9S56BiXWXXfRcdl4E6lxq
	 vBDtd/G8p2rc8lurXnKXZ7inXEF7+mhMvvGlAxmgQ/9JKZJ6yPEXhGFY3CtCEDc25P
	 KPGi9RpJsrd+VTpocmfOPaKx69ShWXm8QaQG559CKfCYTC2U2cJpad43IPmCIuZH8/
	 qRgfN6Zc3RDiLss04zBlvDAKgiswdXdGghtmNT9g5yEQV1VfkPUu6aFKASeUOMCRoG
	 Va45Q8uZhvuAQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 341/638] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 18:56:18 -0400
Message-ID: <20240324230116.1348576-342-sashal@kernel.org>
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

From: Ming Lei <ming.lei@redhat.com>

[ Upstream commit b25b8f4b8ecef0f48c05f0c3572daeabefe16526 ]

An empty flush doesn't have a payload, so it should never be looked at
when considering to possibly requeue a bio for the case when a reshape
is in progress.

Fixes: 9dbd1aa3a81c ("dm raid: add reshaping support to the target")
Reported-by: Patrick Plenefisch <simonpatp@gmail.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/dm-raid.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/dm-raid.c b/drivers/md/dm-raid.c
index 5f9991765f270..3d8ee9eb59ea6 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3322,14 +3322,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
 	struct mddev *mddev = &rs->md;
 
 	/*
-	 * If we're reshaping to add disk(s)), ti->len and
+	 * If we're reshaping to add disk(s), ti->len and
 	 * mddev->array_sectors will differ during the process
 	 * (ti->len > mddev->array_sectors), so we have to requeue
 	 * bios with addresses > mddev->array_sectors here or
 	 * there will occur accesses past EOD of the component
 	 * data images thus erroring the raid set.
 	 */
-	if (unlikely(bio_end_sector(bio) > mddev->array_sectors))
+	if (unlikely(bio_has_data(bio) && bio_end_sector(bio) > mddev->array_sectors))
 		return DM_MAPIO_REQUEUE;
 
 	md_handle_request(mddev, bio);
-- 
2.43.0


