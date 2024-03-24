Return-Path: <linux-kernel+bounces-114530-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A73D1889048
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 07:15:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 453DB1F2B5C7
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 06:15:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC42C22B6A0;
	Sun, 24 Mar 2024 23:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VmYQJlS3"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD7922ABA9;
	Sun, 24 Mar 2024 23:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711322155; cv=none; b=nlWDE85XecBdq1mJeT5eAbb4hoLCt7oyju4rl+vNCxSZECOAMayhCDukc4IjWqIyiZVbhczpNMHWN/B6iBcwRqGTILb8GX1cK6rzB6fnCXjCMiO37ur2noL2Tl84pA63RkvD297koJs2tz9TFcA5FZMfyOB8OnTUpZqp2JVblR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711322155; c=relaxed/simple;
	bh=jWb1taSDWnnlYNcsDY4Fytf5GGYRBq3hGAnoWhXCiNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JdgCgxxMoA9k714xvjW1o5e8HLtsb2SgZzwZFkUtPWyMTCohA+mbkmhdIbh98q/hf074Kglc1FYwakd3B7j/AkbkbFvAtmE6rqhibVPMgcgbQL1fum/24+MZpAbb7H6o5kFmPtBWZTHb+ZU7OnB+1e2KuxAfBKWsIyYibDLxf3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VmYQJlS3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 600E9C43390;
	Sun, 24 Mar 2024 23:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711322155;
	bh=jWb1taSDWnnlYNcsDY4Fytf5GGYRBq3hGAnoWhXCiNo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VmYQJlS3kAaS4F7h6KFpC4RLa1WBlLAegL7mSZ7dq+mZXVZMj/2AzncsvjAUMuXkX
	 g/MXbKPRK300lI4dHHqs8kkqdlr/FQaSPJf67wgCWfmdWg1hplG4HcfiTMHEDkX+WG
	 5+OlZ6E5aOtYyAfgyZGqjulmc73mM0McwxzcgieKLA82Ht03lUtNqxpdR/vL2cQWeS
	 tIxXOya//bdtqSkXKkyw4RwlHibxJK+kLICDiTnCNF+hz/DTAJLEv+3Z436w9QTZew
	 rjYcH8kBHnQfHjKtAMcbo+Zeko9p0atwc8ZzhX9p8xfSNK7tVQFKRP8vX+NDLMzCrl
	 kDqcFNxkTIfWg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 232/451] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 19:08:28 -0400
Message-ID: <20240324231207.1351418-233-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324231207.1351418-1-sashal@kernel.org>
References: <20240324231207.1351418-1-sashal@kernel.org>
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
index 4b7528dc2fd08..7fbce214e00f5 100644
--- a/drivers/md/dm-raid.c
+++ b/drivers/md/dm-raid.c
@@ -3325,14 +3325,14 @@ static int raid_map(struct dm_target *ti, struct bio *bio)
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


