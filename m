Return-Path: <linux-kernel+bounces-28627-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 74A868300EA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63C95B22EE7
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 08:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 557F4C8CE;
	Wed, 17 Jan 2024 08:01:20 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE823C121
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 08:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705478479; cv=none; b=r1DajZAjXiUfLWIZJJLjMRn7Nm85PhiQZVkwy8Z99qxT1ozma80ebr/pP0xNaw3TN9TPFS/aXSGlmQNUCO5zamOwh9LJtHuWxj1N74BSjYxsoz8zww/ay6fJllLr75JgA9nvvqIf6fTlABPdt2eESfa5vRlJUyMwNaOWLIwKmgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705478479; c=relaxed/simple;
	bh=vwhxEp2wpjBY8CexZazYe+X4/DLWJyxdJA8fDyNFxYc=;
	h=Received:Received:Received:From:To:CC:Subject:Date:Message-ID:
	 X-Mailer:MIME-Version:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-MAIL; b=adEMujPON42lbW8xiBJ+sJ6WQ1NxdSES3QVCWmDHXl8HJdGGaL+9TEeomqcnsKHyVSduASfPO9ur4rVqWbNIi0XZllF4xad3HGZmc/wuxFblWXDii+iTSqqogR3wQLj38VX45ALvpttWsQjnknQHS9G2+oln16ANgSaX8p8dRwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40H80Onq001047;
	Wed, 17 Jan 2024 16:00:24 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TFJ5k6lPYz2RN15k;
	Wed, 17 Jan 2024 15:53:14 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 17 Jan 2024 16:00:22 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>
Subject: [PATCH] f2fs: use IS_INODE replace IS_DNODE in f2fs_flush_inline_data
Date: Wed, 17 Jan 2024 15:59:58 +0800
Message-ID: <1705478398-10890-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS03.spreadtrum.com (10.0.1.207) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40H80Onq001047

Now IS_DNODE is used in f2fs_flush_inline_data and it has some problems:
1. Just only inodes may include inline data,not all direct nodes
2. When system IO is busy, it is inefficient to lock a direct node page
but not an inode page. Besides, if this direct node page is being
locked by others for IO, f2fs_flush_inline_data will be blocked here,
which will affects the checkpoint process, this is unreasonable.

So IS_INODE should be used in f2fs_flush_inline_data.

Signed-off-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
---
 fs/f2fs/node.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 541c4ad..a8fe49a3 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1919,7 +1919,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 		for (i = 0; i < nr_folios; i++) {
 			struct page *page = &fbatch.folios[i]->page;
 
-			if (!IS_DNODE(page))
+			if (!IS_INODE(page))
 				continue;
 
 			lock_page(page);
-- 
1.9.1


