Return-Path: <linux-kernel+bounces-61204-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FA17850EE8
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 09:34:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D1D921C20F2B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 08:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6D9BDDB1;
	Mon, 12 Feb 2024 08:34:09 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61B4B101C1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 08:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707726849; cv=none; b=t8AXb8DYIZY2BhEXXD5HckfyiVJTtOtIMwl9dYr/UyCrJ4G8o6wqr9WD5XVJNzvCt1Zs+h4gqTBfrly1g6Hd+8wAJF4eeDkUwl/q1bH/eQHa8VYvbxZTDUjTvCVYYvee62LiDEr/wue2mQwKruJg3vJ7tG+9hhIg1k5Q5ZJgFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707726849; c=relaxed/simple;
	bh=Ppw/szsqkGDaYnrWnVR/G4gm/cVWMG7SAB9kfoPViIc=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ULTeK0nOi+6GsNLQKR1KCRFsf8TIalyTF82KJlBj63B7JHG1T9TM3buXKm3MIo29oi05RxFLTedbhQbTiTgdIfgaqQ1zxA3UGUdYC8+iBRzxCFvIx8/mGKe88oo7Ocd7L+ODstZSyH0IE8V3r4ANL5e9n0cHCusru9VqrglitRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Jeffrey E Altman <jaltman@auristor.com>
CC: Daniil Dulov <d.dulov@aladdin.ru>, <linux-afs@lists.infradead.org>, Marc
 Dionne <marc.dionne@auristor.com>, David Howells <dhowells@redhat.com>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH v2] afs: Increase buffer size in afs_update_volume_status()
Date: Mon, 12 Feb 2024 00:33:47 -0800
Message-ID: <20240212083347.10742-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
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
index 020ecd45e476..d4a379bfd54e 100644
--- a/fs/afs/volume.c
+++ b/fs/afs/volume.c
@@ -353,7 +353,7 @@ static int afs_update_volume_status(struct afs_volume *volume, struct key *key)
 {
 	struct afs_server_list *new, *old, *discard;
 	struct afs_vldb_entry *vldb;
-	char idbuf[16];
+	char idbuf[20];
 	int ret, idsz;
 
 	_enter("");
-- 
2.25.1


