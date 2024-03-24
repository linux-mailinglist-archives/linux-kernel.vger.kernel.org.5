Return-Path: <linux-kernel+bounces-113238-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 088AA88828D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 00:51:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A73D1C219BC
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 23:51:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2DDB132812;
	Sun, 24 Mar 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UtfoF4rF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19EA81327F7;
	Sun, 24 Mar 2024 22:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320039; cv=none; b=uqbhF4UqT5tPdhoyT2jInwrkr/CG1G9fHNfqi4C2o4SwF2SeZoiFjkWg8uvg+33Dnq6r2aLBkvqyaQxW5Tx/Y230bhONC48wXOvrfNJLREgiH5XDeakh+zzptr8PcxGRtSRcZXKRGCZUKh5cL8FV5Oxhr2muPIJ+pmQNbRiRrRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320039; c=relaxed/simple;
	bh=MPJsfCYG3IQN5G/QHQfx5aTxiuzR9zsnaOhfuWbMtVI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ThhH1HdLDxEdvmUC2dHvpKs9zOntY47ZeNotEL8Fg0DkQ1AmTKUnpEvn1hsgkTSPKmNJtLFXXb79xSMOnpbHring7UllijQIjYvz+HbaMcks8LAMi8GCGOfTmyB4KhmZ8fzRFbSKjPdMUli8ZddH589VDyOsQ7acPrv3NTkzJ2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UtfoF4rF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4238FC433A6;
	Sun, 24 Mar 2024 22:40:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320039;
	bh=MPJsfCYG3IQN5G/QHQfx5aTxiuzR9zsnaOhfuWbMtVI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UtfoF4rFgWMhsaC1bED+3EBLOYUl8QldKqPvBi7w/SBAwZGEniN2bKtgd7csW5SvS
	 VYEaJjglqfUKFPnevaamF1z6A/WyrUu9N3M+GcGm2GXpt38tz0sZG3N12Ny6K01HYo
	 GtmUjq2DuMKBNOliQKnFmHvbfxyl1tb/EjKLORF/qcGB4+O/lTLYumV9Uwd8kOMlKa
	 7kruMuoleVM13ZpC5Xv/swQ1oYHSRRfXbMB5BkaeRKuckHiliMJ+U0n6adkkbtRz2C
	 42e02Cdxib1e+N+R2kMmpP9+ghxOSbwVuy5YweQmWCGzABukE68QjvIbxY9SNDYxaL
	 CLMzCVzHhFF0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	Patrick Plenefisch <simonpatp@gmail.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 347/715] dm raid: fix false positive for requeue needed during reshape
Date: Sun, 24 Mar 2024 18:28:46 -0400
Message-ID: <20240324223455.1342824-348-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
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


