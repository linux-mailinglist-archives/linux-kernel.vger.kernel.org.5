Return-Path: <linux-kernel+bounces-60830-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5B7B8509FC
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:20:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BBB201C20D6A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:20:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2C785B670;
	Sun, 11 Feb 2024 15:20:16 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 755DD5B664
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:20:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664816; cv=none; b=T7QINqEmjpXmmUfal0bcT09A9TZIm4LyydTETVSER4Wgknd6EoPvgln+wU/ORmAUobsVDXnAtW4ckift50JuqvWN+CS7KFv3D88sV6ysSc95ZzeEl7aIQVSFXLXVJ807yM2HeQjSscUS1q2ibCau1BKT5gsTpAF1Yw7H3XpCP9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664816; c=relaxed/simple;
	bh=pqT/Yn/f95Jc51h+SeB+Tfid/Y0ml0JoyOXa8k+c3jI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nNjlqnoTimzVja3y753tbiEcQxNx2ZXn6lek8ST+0ybihNjITB9BptoZxEDheTaTyxoWYOE2ncCFR4Yj2NwaSnV314KAfO5KH3MKqdAIfi/B/TYC2SlgyyabTQSvMxaw+XTtVvVvIVJ+F+X50DO8eBAp1hvBtz+Poyi2AgL/WmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <linux-afs@lists.infradead.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Marc Dionne <marc.dionne@auristor.com>,
	David Howells <dhowells@redhat.com>, <linux-kernel@vger.kernel.org>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH] afs: Increase buffer size in afs_update_volume_status()
Date: Sun, 11 Feb 2024 07:04:42 -0800
Message-ID: <20240211150442.3416-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-03.aladdin.ru (192.168.1.103) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

The max length of volume->vid value is 20 characters.
So increase idbuf[] size up to 20 to avoid overflow.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: d2ddc776a458 ("afs: Overhaul volume and server record caching and fileserver rotation")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 fs/afs/volume.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/afs/volume.c b/fs/afs/volume.c
index f84194b791d3..9d0da38bbcf6 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -302,7 +302,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[19];
 	int ret, idsz;
 
 	_enter("");
-- 
2.25.1


