Return-Path: <linux-kernel+bounces-116165-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3CB8899F5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 11:20:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 154E52A6C8C
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 10:20:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D283B484B;
	Mon, 25 Mar 2024 03:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sFCzHHe2"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 552E7282A60;
	Sun, 24 Mar 2024 23:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323738; cv=none; b=ITMem/HVdnKFyTabE9hM3kA6CymLSzOrzlhgfHZFfEqT+XEhWK/KN5Iasi4FJigIZLxTNFAHGfl5p6JPDPBW/0xLFQd7C4dVIKqh1fRfO8zmRPTuiLMMf0SKpcsie7IHwSFj2Xhk30pPnPd7u9wFMz6fzO7e8bFguHrZrEgaIHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323738; c=relaxed/simple;
	bh=KM87Xwe8+UKkpGiWc+ZVcMH17sbsmgKLsPwheUARK3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtH+bUyw5nlDlNcVsOqYXHhqyjCcOjcaacR8e7gQoQ1huaIgUecA0MUryIIAD06XPwXjDlGTkDmJkB+U6tm+3ROc1IoTF10dmowtWcRlJb57pU99wFboL17OzB0V8h/YPq6aZJkib1LvfErZiKBqSQxPutn6WpRCIMCh95U11ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sFCzHHe2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE87C43399;
	Sun, 24 Mar 2024 23:42:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323737;
	bh=KM87Xwe8+UKkpGiWc+ZVcMH17sbsmgKLsPwheUARK3g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sFCzHHe2fIairCOZEMwh8LSFWRuTtz84hJxz7HSSYVdT4unrj1/KDGIk8OERFB7dq
	 PHz358rPm2Oj7WJQ0EPGWWtOrn8NCuoLHukSU6oB3H3WTRTWV1Zlz+VKQm4rV+j+N1
	 ZZdYETq1Mh4VYeApslFjYdwgBTzvyjWeoxO+vjzvGV3xZtqabwb4nVcAngOVZinuZH
	 6Duiugh65D4gQcOjfjmjU5rb/QiJwmc6LMTkgObk4VrKZy9zzosonTn0VC8UZbK68+
	 MzimEjfQe7uXREX7i6WNk/EL9DuQgeIkOY+coKqJncBsz7vWodtKTzHYSJRXOYvUrY
	 878Mel1jAr6vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 111/238] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 19:38:19 -0400
Message-ID: <20240324234027.1354210-112-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234027.1354210-1-sashal@kernel.org>
References: <20240324234027.1354210-1-sashal@kernel.org>
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
index 140bdf2a6ee11..e523ecdf947f4 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3329,14 +3329,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
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


