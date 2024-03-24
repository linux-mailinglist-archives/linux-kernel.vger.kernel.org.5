Return-Path: <linux-kernel+bounces-116325-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 894518895EF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 09:43:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA69D1C2ED1A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 08:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F6973D52B4;
	Mon, 25 Mar 2024 03:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GlqL+7y6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94256184325;
	Sun, 24 Mar 2024 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711324288; cv=none; b=X79RfVa2cwrBEVjgh7IqbTIq3vRb/fuyqcA9CcQPFkhwPw8M32cRFdKtqBjAc1N4qi9fuapJ2Wkw4SgkuKSOxPhjHvaPO1MG8bMYf9yrsoVD/7sXDrgho+gNzjxWLp7CTk0+Wfn1363zaAYuj9wLnutHZkcJ2SXjIXJpmhD+RVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711324288; c=relaxed/simple;
	bh=bk37W52OwdXA5m+3hvBG8EWN0UixpIkRNLuOL4i2+U4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eyu7nHzfQD3nflr8Cp4hjrdgszpKtd3YLm+MAhYWke42DU0BFMPKqY2MR69kSEhlbQ/+J+237Y8/sp4w4zvb9T5BBW0bOmioiXh46uXNdQf6ef64ei1HzZVjl1lkqQqt/f/P9MYf/X4DolDjC9K/ZwGZrGLuH3b3dzc+3CY5hzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GlqL+7y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1D6C433A6;
	Sun, 24 Mar 2024 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711324288;
	bh=bk37W52OwdXA5m+3hvBG8EWN0UixpIkRNLuOL4i2+U4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GlqL+7y6Oi1py71VcjY10KU4xndR6LfOOs2sFfVbFa3v5nUnnGnUHe3paC98R/nDp
	 g8XdvsP1OcgPRKXgfOWwpesNpOh2tKG4qZGhMEFf/tFeIKhaQjCvlO9I728RjECBPG
	 FOFd5AfD6ZkWfq+HGq+PTLEsro7DntRA+/CLelvsz9cmoq+40KtuTQ2YtowFEe2jeO
	 pW9zhbHd7Z/QbRpUvlNvr0SnNEx9PYTgyI3Cm0WuvFz0Ytn2mf7xM/I6WWal3FeIQ7
	 KWaifDm6Kp0RUZFuHRcaBwNyI4IFwkAHYckv5PgzOuBoowkEJiKSmBfdLDZq84Py0B
	 tc24MQHy1Bk9w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 064/148] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 19:48:48 -0400
Message-ID: <20240324235012.1356413-65-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324235012.1356413-1-sashal@kernel.org>
References: <20240324235012.1356413-1-sashal@kernel.org>
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
index 72aa5097b68ff..1759134fce824 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3348,14 +3348,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
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


