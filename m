Return-Path: <linux-kernel+bounces-70674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D8E1859AF6
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 04:28:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B264B21392
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 03:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C1373D7B;
	Mon, 19 Feb 2024 03:27:57 +0000 (UTC)
Received: from SHSQR01.spreadtrum.com (mx1.unisoc.com [222.66.158.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB1082103
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=222.66.158.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708313277; cv=none; b=Za5E1gJZs2yzM9Yp7lVA/EHOac+OfccqFFCmoPITh9eHzxtwoKVVXl9za9aoyHGoc7PH0REzBhFFigIxM03qvElEza4X1IwOCDsosAsrf0dDUPNHuKQJsUJZYiG4jh+uTLGrxpP/U1ZwU0uhX0FW1rmchliKeNKxJ/3UrS80F+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708313277; c=relaxed/simple;
	bh=r5WhQUGMY/9VKH1rt1wukmTW9vZu0Ig+mXDVnVjFgHU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=A93o2BVZRvx5CN1Q7nWJut+eIqgIOA6lwoR37a09x1YXb9WBfqO3s+xmbteS0RZl5bhw+1Hq6mJiLktgrdRoYw60fgFMf14cFfChYDi6HPoeagA/WV7hGKlwqL+PmfEKD+EkYFazRz7tEK4AaVSchUKM9pi5w3Ii/iyOnS1DDoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com; spf=pass smtp.mailfrom=unisoc.com; arc=none smtp.client-ip=222.66.158.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unisoc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unisoc.com
Received: from SHSQR01.spreadtrum.com (localhost [127.0.0.2] (may be forged))
	by SHSQR01.spreadtrum.com with ESMTP id 41J3K6GF006465
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:20:06 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from dlp.unisoc.com ([10.29.3.86])
	by SHSQR01.spreadtrum.com with ESMTP id 41J3JlGn005483;
	Mon, 19 Feb 2024 11:19:47 +0800 (+08)
	(envelope-from fangzheng.zhang@unisoc.com)
Received: from SHDLP.spreadtrum.com (bjmbx02.spreadtrum.com [10.0.64.8])
	by dlp.unisoc.com (SkyGuard) with ESMTPS id 4TdSSN4KKWz2KCV0Q;
	Mon, 19 Feb 2024 11:19:16 +0800 (CST)
Received: from bj10906pcu1.spreadtrum.com (10.0.73.72) by
 BJMBX02.spreadtrum.com (10.0.64.8) with Microsoft SMTP Server (TLS) id
 15.0.1497.23; Mon, 19 Feb 2024 11:19:44 +0800
From: Fangzheng Zhang <fangzheng.zhang@unisoc.com>
To: Christoph Lameter <cl@linux.com>, Pekka Enberg <penberg@kernel.org>,
        David
 Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew
 Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman
 Gushchin <roman.gushchin@linux.dev>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>
CC: <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>, <tkjos@google.com>,
        Fangzheng Zhang <fangzheng.zhang@unisoc.com>,
        Fangzheng Zhang
	<fangzheng.zhang1003@gmail.com>,
        Yuming Han <yuming.han@unisoc.com>,
        Chunyan
 Zhang <zhang.lyra@gmail.com>
Subject: [PATCH V2 0/2] Introduce slabinfo version 2.2
Date: Mon, 19 Feb 2024 11:19:09 +0800
Message-ID: <20240219031911.10372-1-fangzheng.zhang@unisoc.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: SHCAS01.spreadtrum.com (10.0.1.201) To
 BJMBX02.spreadtrum.com (10.0.64.8)
X-MAIL:SHSQR01.spreadtrum.com 41J3JlGn005483

Hi all,

This series introduces slabinfo version 2.2 to users.
In slabinfo V2.2, we added a slabreclaim column to
record whether each slab pool is of reclaim type.
This will be more conducive for users to obtain
the type of each slabdata more intuitively than through
the interface /sys/kernel/slab/$cache/reclaim_account.
And we have added an example of the output result
executing '> cat proc/slabinfo' in the file
Documentation/filesystems/proc.rst.

Changes in v2:
- Modify the slabinfo version number to 2.2.
- Add an example of slabinfo output and future works.

Changes in v1:
- Add a slabreclaim column to record type of each slab
  in file proc/slabinfo.

[1] https://lore.kernel.org/linux-mm/20240131094442.28834-1-fangzheng.zhang@unisoc.com/

Fangzheng Zhang (2):
  mm/slab: Add slabreclaim flag to slabinfo
  Documentation: filesystems: introduce proc/slabinfo to users

 Documentation/filesystems/proc.rst | 33 ++++++++++++++++++++++++++++++
 mm/slab_common.c                   |  9 ++++----
 2 files changed, 38 insertions(+), 4 deletions(-)

-- 
2.17.1


