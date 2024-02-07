Return-Path: <linux-kernel+bounces-55827-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDE284C230
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:02:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6D21CB2959C
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95488DDCA;
	Wed,  7 Feb 2024 02:02:07 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC3DDDDB3
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271327; cv=none; b=HJuCjuYuMDABPUc2GVzTpMZ0vqsaI4PDqqW7X+LBIFuIbV8s5iwOWCs3l/iOdOy9Wt2KjGMsKU+05DU9g7YlxpiGSA3EX0wnUDxpsgt9Q+J2Mj8JwdLpJJZHzEezfyyByomypwu+JNXPauZUAVYOGd2UxR58VvgD7Zrgfjy3pGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271327; c=relaxed/simple;
	bh=dqkBJAgvOf54M17NAgC2bdZdD8Q1alVaZw9A7jwQE4Y=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bSpliixB2MA72MADrhBhktGSaFWbM8Z9VCeFNmQJ/MhZ0/KXtWUZpW1dYbcwyhkZJRdOtjk09ia06+3aISy4A7F6biam4fMdjza4esa93B23yGMAz6wu24dpD1uegEF+fLYx9wZeO4w806763bgnFhv+oTvkLJfxIBDmxyGfHp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41721Nq0075264;
	Wed, 7 Feb 2024 10:01:23 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TV3Hv3prTz2K4cJ2;
	Wed,  7 Feb 2024 10:01:15 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Wed, 7 Feb 2024 10:01:20 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH v2 0/4] f2fs: fix panic issue in small capacity device
Date: Wed, 7 Feb 2024 10:01:00 +0800
Message-ID: <1707271264-5551-1-git-send-email-zhiguo.niu@unisoc.com>
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
X-MAIL:SHSQR01.spreadtrum.com 41721Nq0075264

A panic issue happened in a reboot test in small capacity device
as following:
1.The device size is 64MB, and main area has 24 segments, and
CONFIG_F2FS_CHECK_FS is not enabled.
2.There is no any free segments left shown in free_segmap_info,
then another write request cause get_new_segment get a out-of-bound
segment with segno 24.
3.panic happen in update_sit_entry because access invalid bitmap
pointer.

More detail shown in following patch sets.
The three patches are splited here because the modifications are
relatively independent and more readable.

---
Changes of v2: stop checkpoint when get a out-of-bound segment
---

Zhiguo Niu (4):
  f2fs: correct counting methods of free_segments in __set_inuse
  f2fs: fix panic issue in update_sit_entry
  f2fs: enhance judgment conditions of GET_SEGNO
  f2fs: stop checkpoint when get a out-of-bounds segment

 fs/f2fs/file.c          |  7 ++++++-
 fs/f2fs/segment.c       | 21 ++++++++++++++++-----
 fs/f2fs/segment.h       |  7 ++++---
 include/linux/f2fs_fs.h |  1 +
 4 files changed, 27 insertions(+), 9 deletions(-)

-- 
1.9.1


