Return-Path: <linux-kernel+bounces-116055-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF4B889532
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D4C31C2DB50
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403392789B8;
	Mon, 25 Mar 2024 03:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Se9Ote8G"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47FE227898D;
	Sun, 24 Mar 2024 23:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711323451; cv=none; b=rqD5G9s+Wlk+mAGkzAQpxtbq4apnCRImZ8A1oYl9YROo2aJs1mh0dlIAdoyeJlw2ZRBYCS/a2nfVF6ne6IeprHB8t2xZA0k9gF6Mo7PgPbPU0M4oOAfIVOmYNGgPbPJIoeNQ93XRLf9DzVj7PM4+rZe8oqIylbOsdjs//uuq0rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711323451; c=relaxed/simple;
	bh=1iglNrylsU2Jo217moQ36heLo5ehGv/yQsgFmZHd4EQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tr++4zWHnuZWfoubFxIL+fA9QTcK43d8hzJ53nq7DrB7kuWQm6zhT1BBjj6Jn4+1NXQ8c5LKSFAnkTukJoTMurZ5z2Ihvbx+eDAIp21qZ54SNS6ddkVo/ZXOJAIvTn5a/3y3CQJohGSF50xGZgGrmPJc5PyBlxebzNEc2zR9e38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Se9Ote8G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F9B3C433F1;
	Sun, 24 Mar 2024 23:37:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711323451;
	bh=1iglNrylsU2Jo217moQ36heLo5ehGv/yQsgFmZHd4EQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Se9Ote8Gt1p/Pd+X+xJdHA8U1VYFlVQDVwsxQtLAg18xW6+DVEZQ+LwflaoRjE2x9
	 IgFzQRjVYwY/wFVfw/wC5pW3lP2no/V7ecIssdJylDETqKG5XFfZyYTvXKaGZvZWR7
	 hmuc1/RaBFHtHhYqs0oAEidFJw36hvcL1/vH59CNpm8FNH9eWlR6Q2REE+/a96vtzx
	 THFNVWmjXtWJ1boTrpZmAsUXE6wgcijU4T0JxA8EtEr5m8bQSHukd636ICHGUmkOO8
	 wzRcfqcpeQ4Iav7VX7qB30pe1CIHbaKT2e4IMrq/uiJKf1PHyU3ccVULzfhmGnaYCa
	 sw3X5J89ubM6w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 154/317] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 19:32:14 -0400
Message-ID: <20240324233458.1352854-155-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324233458.1352854-1-sashal@kernel.org>
References: <20240324233458.1352854-1-sashal@kernel.org>
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
index 8d489933d5792..04769fb20cf7f 100644
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


