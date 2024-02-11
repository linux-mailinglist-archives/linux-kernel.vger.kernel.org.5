Return-Path: <linux-kernel+bounces-60828-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C728509F5
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 16:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 048D61F21CE2
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 15:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8361B5BACE;
	Sun, 11 Feb 2024 15:11:27 +0000 (UTC)
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4111B5A4C2
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 15:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707664287; cv=none; b=X1bM5krCRkLTPrVChORw2pqXUA/C5hgyM+eOb2fYLhbxbxJ6HpkPN5nl/EZfBm2UtgTmmRI7BYaPtvU74ouSFMaMlh00nLCw0mmI7FIzlSGS5a7I5uv6/qnRg00Y8Yiw2AVzZomXl49/7MVHa1dA0lZVga4W/srnwSBXPMahlzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707664287; c=relaxed/simple;
	bh=DjNQ0iQFYVh5G4R2oz7xLYC1ecakN7+K1vihLv5zVwk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=MK8WzkBVRyE4vJ/F/rhTQi1i2RQ0TggS+5qG6xrnJOSO2P8ILN2BisGyJokkelLf8oGJ6mVOPO/j5MBvunyfiGitTooi+UlZCwnP6P9o19IO5lubNXZRKhWHE0n5ZU8I1DwSxXXzYFIbH3WT0GxU/xEWZfjqZhBcIqlv2mTnXoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
From: Daniil Dulov <d.dulov@aladdin.ru>
To: Evgeniy Polyakov <zbr@ioremap.net>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, David Fries <David@Fries.net>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>
Subject: [PATCH] w1: remove redundant NULL check
Date: Sun, 11 Feb 2024 07:11:13 -0800
Message-ID: <20240211151113.4171-1-d.dulov@aladdin.ru>
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

cmd cannot be null in w1_process_cb, thus remove redundant NULL check

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: 9fcbbac5ded4 ("w1: process w1 netlink commands in w1_process thread")
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
 drivers/w1/w1_netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/w1/w1_netlink.c b/drivers/w1/w1_netlink.c
index fa490aa4407c..402065a0432d 100644
--- a/drivers/w1/w1_netlink.c
+++ b/drivers/w1/w1_netlink.c
@@ -475,7 +475,7 @@ static void w1_process_cb(struct w1_master *dev, struct w1_async_cmd *async_cmd)
 		mlen -= len;
 	}
 
-	if (!cmd || err)
+	if (err)
 		w1_netlink_queue_status(node->block, node->msg, cmd, err);
 
 	/* ref taken in w1_search_slave or w1_search_master_id when building
-- 
2.25.1


