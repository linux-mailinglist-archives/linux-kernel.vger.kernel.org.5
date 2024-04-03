Return-Path: <linux-kernel+bounces-130365-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DC58897813
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 20:21:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1F562B378CF
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E0816F84B;
	Wed,  3 Apr 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JXkA7Q8x"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1192316F833;
	Wed,  3 Apr 2024 17:20:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712164843; cv=none; b=tIB/0KHjhfDT9m8/j5QHqoFWwpuw4hTS+D+UbmkoiwvFjRm4Cu2G3FtkbP3ghO+LRDOOepnCsY+PPpbu/D2AWREhle7Ma5k7x0j+aTNfW/w3oCa8bn8BffhXCJOUunBxsu1Pqre4iugBsOayNHls2mpU6b911qM5PJ1xfyFqrL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712164843; c=relaxed/simple;
	bh=zZ5HKyl9SWi+r5ffTIvAaz8buaVqrBX/MaVE9PNjX+Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iP5CzVYihxOFBLDGRiepevBzcAF8VDkdGoytC6yr1Me/7N3VdOjlgvSy/WNFjCgjRmiBqvEaUPZNlvUwt4WA869iX4l0cuTcKq5ljpmMeTqSDxf9J4JkYuibGDdEB7CfbKUp+LisdxUM4kgh0RRVKAk++9HqnwQaN4AjxSrNhLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JXkA7Q8x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8D21C433F1;
	Wed,  3 Apr 2024 17:20:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712164842;
	bh=zZ5HKyl9SWi+r5ffTIvAaz8buaVqrBX/MaVE9PNjX+Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JXkA7Q8xNtVYCSKq24EJvbiG8lwFurmIfTrg4Mh/CEdmKh2pNkfcT26EaDjUPHGSd
	 TJ+L8nFQkxjJIWuPm9WKn+LgNcgad5t4z9IQ1OT4psoZq7oxWA8vDfc/9M5cNVBuwr
	 Xb+IlWBtjQl2tcuHSY3NFICzHCOGlewLvZOhaud+eUea58t39RhQJnox2CokqixX6n
	 jLaKU0rZzdDn90eUIVCvdYu73XmmnKH8MH37Ah9Yp+gMZS+ZjCBVl8ZTaToUSHD4W9
	 pdNLGOXntBxZeOuuMzVD5fe7xrdlDQeaM+BZfE4smT1y9g7Z6j9TvH8SXkNPKJrJIf
	 115ND60QpGouQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Karina Yankevich <k.yankevich@omp.ru>,
	Sergey Shtylyov <s.shtylyov@omp.ru>,
	Alan Stern <stern@rowland.harvard.edu>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-usb@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH AUTOSEL 4.19 2/5] usb: storage: sddr55: fix sloppy typing in sddr55_{read|write}_data()
Date: Wed,  3 Apr 2024 13:20:35 -0400
Message-ID: <20240403172041.354877-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240403172041.354877-1-sashal@kernel.org>
References: <20240403172041.354877-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 4.19.311
Content-Transfer-Encoding: 8bit

From: Karina Yankevich <k.yankevich@omp.ru>

[ Upstream commit d6429a3555fb29f380c5841a12f5ac3f7444af03 ]

In sddr55_{read|write}_data(), the address variables are needlessly typed
as *unsigned long* -- which is 32-bit type on the 32-bit arches and 64-bit
type on the 64-bit arches; those variables' value should fit into just 3
command bytes and consists of 10-bit block # (or at least the max block #
seems to be 1023) and 4-/5-bit page # within a block, so 32-bit *unsigned*
*int* type should be more than enough...

Found by Linux Verification Center (linuxtesting.org) with the Svace static
analysis tool.

[Sergey: rewrote the patch subject/description]

Signed-off-by: Karina Yankevich <k.yankevich@omp.ru>
Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
Reviewed-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/4c9485f2-0bfc-591b-bfe7-2059289b554e@omp.ru
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/storage/sddr55.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/storage/sddr55.c b/drivers/usb/storage/sddr55.c
index 35306c0559622..dddaac45a0455 100644
--- a/drivers/usb/storage/sddr55.c
+++ b/drivers/usb/storage/sddr55.c
@@ -195,7 +195,7 @@ static int sddr55_read_data(struct us_data *us,
 	unsigned char *buffer;
 
 	unsigned int pba;
-	unsigned long address;
+	unsigned int address;
 
 	unsigned short pages;
 	unsigned int len, offset;
@@ -315,7 +315,7 @@ static int sddr55_write_data(struct us_data *us,
 
 	unsigned int pba;
 	unsigned int new_pba;
-	unsigned long address;
+	unsigned int address;
 
 	unsigned short pages;
 	int i;
-- 
2.43.0


