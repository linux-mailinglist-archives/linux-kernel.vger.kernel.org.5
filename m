Return-Path: <linux-kernel+bounces-42528-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 513978402B3
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 11:22:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E145DB20C96
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 10:22:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BDF5644E;
	Mon, 29 Jan 2024 10:22:49 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (unknown [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6437755E71
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 10:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706523768; cv=none; b=PFDGRE+kGr7+uB9RBKwQrmj7/Xfn7PQ0qCAhtlulbXrp57llB9XMCscJghbR2N/4jFewVF+k3qg4MrxXXnwv6wAZHO93fd/ACCuJO/OWwS1RkdEKhzIukTd7ucbXOXHosco5jdMHFWPHlBQ5zndvgivpCsHoo6TTJXuhCI2xucQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706523768; c=relaxed/simple;
	bh=NBbhsZaz19V96HRs9sSIIpn6TGJqcZVy49tBd7L4BPY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TkdS6oK7dkXnCknghBQT5zjG1SCxv5pOl/PICQSTt4kqQ/TFZFoP/TMeiVtQskRTluofNys0mKiPSNwvweXO9vN46QeiVepRgfs8MLviO+iff1065VRhHCuPzrRcf4zDO25n0N47ynQ+i5O7Y9eRBIhMBvEEJy/rwnMmmECS07o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 40TALmxZ021624;
	Mon, 29 Jan 2024 18:21:48 +0800 (+08)
	(envelope-from Zhiguo.Niu@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TNkfv3tnnz2R5Td1;
	Mon, 29 Jan 2024 18:14:15 +0800 (CST)
Received: from bj08434pcu.spreadtrum.com (10.0.73.87) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 29 Jan 2024 18:21:46 +0800
From: Zhiguo Niu <zhiguo.niu@unisoc.com>
To: <jaegeuk@kernel.org>, <chao@kernel.org>
CC: <linux-f2fs-devel@lists.sourceforge.net>, <linux-kernel@vger.kernel.org>,
        <niuzhiguo84@gmail.com>, <zhiguo.niu@unisoc.com>, <ke.wang@unisoc.com>,
        <hongyu.jin@unisoc.com>
Subject: [PATCH 0/3] f2fs: fix panic issue in small capacity device
Date: Mon, 29 Jan 2024 18:21:24 +0800
Message-ID: <1706523684-24540-1-git-send-email-zhiguo.niu@unisoc.com>
X-Mailer: git-send-email 1.9.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 40TALmxZ021624

A panic issue happened in a reboot test in small capacity device
as following:
1.The device size is 64MB, and main area has 24 segments, and
CONFIG_F2FS_CHECK_FS is not enabled.
2.There is no any free segments left shown in free_segmap_info,
then another write request cause get_new_segment get a out-of-bound
segment with segno 24.
3.panic happen in update_sit_entry because access invalid bitmap
pointer.

More detail shown in following three patches.
The three patches are splited here because the modifications are
relatively independent and more readable.

Zhiguo Niu (3):
  f2fs: correct counting methods of free_segments in __set_inuse
  f2fs: fix panic issue in update_sit_entry
  f2fs: enhance judgment conditions of GET_SEGNO

 fs/f2fs/file.c    | 7 ++++++-
 fs/f2fs/segment.c | 9 ++++++---
 fs/f2fs/segment.h | 7 ++++---
 3 files changed, 16 insertions(+), 7 deletions(-)

-- 
1.9.1


