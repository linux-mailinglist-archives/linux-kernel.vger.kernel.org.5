Return-Path: <linux-kernel+bounces-115097-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A40B5889308
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:19:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F8DB296CAD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:19:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294242F9F3C;
	Mon, 25 Mar 2024 01:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uzpbaXl7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB58628BD41;
	Sun, 24 Mar 2024 23:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324084; cv=none; b=a/RKY9ZupltgAUDW511Fo3ISCZG9ghXXzu6wfn1D/WYH30zkwYMmqi8O+UDwMiHeJyXIjG7fRoU2xZDz/RqbAarFv3loy7+oniHUndp4647YuEnEGppK6xzKt2qtd+Z6IgEu27oCqatAAYNvQ5vC7y9yDwnP7p6ZRM98k5qOWz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324084; c=relaxed/simple;
	bh=JHlJe7dynY8RwxF97K0HHSqIimBBSR+N9Lxy8Bd9G48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3VjT1llgwtgG1B4GqaG2oLtSnCq8/mNzsqf85Ml6bkSVdvhWR5g/zEsjtDfMneSoj7aEBTpRFdxNBF2rjy/OZxCzgleKYS7dCEkwMM5yXOXTzqia2xiNALAff0NUa564lxiPW/ZnzDiQkl0eQKfWZJI0ljc3ksSvvL6Jw8GC9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uzpbaXl7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D8DDC433F1;
	Sun, 24 Mar 2024 23:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324083;
	bh=JHlJe7dynY8RwxF97K0HHSqIimBBSR+N9Lxy8Bd9G48=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uzpbaXl7I4riUuyO7AOB8SQSp6GnuM1YNc4xbAtsS+J8ScPiQZ66xesA6hW566EzT
	 DLOdIw+5aY+OsAIOV0dgBEEVOIoWHY153mPjnIeRLNjip+NhMHMWb0HNOhU+VPfuqB
	 CxcN/jjluZWEFrC6tGGHbF0942ig9BPjTXp6geeIfepWYxFUv7YELWIq2neI10huXZ
	 qf1g1OUl5jAdfqV9ojdbY0g+qj6/bq6aHYIj5W2wWdynB+SpGXapQ6qXfw30BBzK+F
	 zaeoVtbtVhr6SQoB+vA0DnGL3U1UAHa6GL96gDQk2UXcUTeymRMC2z2LTDa8pDgeSg
	 6DqsSoslhfs5g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 083/183] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 19:44:56 -0400
Message-ID: <20240324234638.1355609-84-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324234638.1355609-1-sashal@kernel.org>
References: <20240324234638.1355609-1-sashal@kernel.org>
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
index 9f05ae2b90191..1ccd765fad938 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3343,14 +3343,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
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


