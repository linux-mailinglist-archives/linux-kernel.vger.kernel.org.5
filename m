Return-Path: <linux-kernel+bounces-113803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AE478886AD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 02:40:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04026290F2D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 01:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1093F12FB1A;
	Sun, 24 Mar 2024 23:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YuvKfvdY"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BF9B128810;
	Sun, 24 Mar 2024 22:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320823; cv=none; b=hq0EWLBuCX1l0CVeaIBf/9o877OqCs95uMti+zZFCzzY6zImkbgr2PL/5lRsYeQvmtr9bFv/Xp1JQRb6jFagQ/214KG88rEXfwboEA9vxgP/y+HzuDpOY4ZuGxvYWJAJMJruwNdlFH27Kc04Vx3AE66t8OAgPGZdRQZvgev9lvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320823; c=relaxed/simple;
	bh=MPJsfCYG3IQN5G/QHQfx5aTxiuzR9zsnaOhfuWbMtVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bpvuxh17otKAYF9tmXxLiWHichiP84qy2DQCdHaonkrc5/csWdjtCoGNXPGgzRSn2G/TG17CJuPbHNbY9nwpm4Due7Jxx8AeOCerUkr+1a8no3Lz3ak/uKzOVMYXtYomkGrrcU9X6JPhknCsjcrX0OfKXx+tmbrEWY4B9WRz9/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YuvKfvdY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3413FC433F1;
	Sun, 24 Mar 2024 22:53:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320822;
	bh=MPJsfCYG3IQN5G/QHQfx5aTxiuzR9zsnaOhfuWbMtVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YuvKfvdY9qZtV80jvdjVCmtKdF0wibxSqA4eRNXcca+o04U8pHJOgTIAsfQZJb4od
	 ma5JonfOUGouUe1vL0Kk9Y8snPadm1HuLQFkdUrCUzd++nokKZwcXDHpUio1U1o37D
	 MJrPkqpxCZR/pptoH6ZIu3d33ec3RUePB37azQf7v4/k5ihNK6mU6+7tdsbo0i2aqC
	 cZeY3qREa8rC5ARKvdqLdBdMzh0Fd1a2l+bixzpV4bOBJe204ehBbw/CR37AQc75yW
	 CxAPssmhztKS4OJEdlCC9jj4J7uNTaep4zG8EClt8mus75MlCFqZVamlfxX+DQro0u
	 kxsNBGtSW5uCg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.7 387/713] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 18:41:53 -0400
Message-ID: <20240324224720.1345309-388-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324224720.1345309-1-sashal@kernel.org>
References: <20240324224720.1345309-1-sashal@kernel.org>
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
index eb009d6bb03a1..13eb47b997f94 100644
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


