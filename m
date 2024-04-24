Return-Path: <linux-kernel+bounces-156699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E9B58B06FE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 12:11:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC131C233BE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 10:11:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5B615921C;
	Wed, 24 Apr 2024 10:11:52 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEBA1591F0;
	Wed, 24 Apr 2024 10:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713953512; cv=none; b=QdNdaOSzwHRGfkYxe4aauIkggNz8KvfzCGofjwIdrpcy0xKQpgdqwVB7GHO9Lr+ew6S63pzLqN3QcqzsSvqB7enrEEauoY/Zk/wLbsDLJxnvb/zwpN5WYX2I3VmBbM9iNWhx+jlugN78TAqvQxo/Q8+n2Qs73LVMdYkI/orXJFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713953512; c=relaxed/simple;
	bh=wMFLeAjrypTZM5NhXWmygbjozVdPJvrr5eHHRx7HwmU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GRvdAeDfqLE8A4/pG20b8MLeg+LfFgkRIiK1dEuN2Tc5jpgRSTheiZTroay9esF37K2gM1sjAkE+ZdF+E4+VE7Lixr6/2LhX9GCrc1VYaO/Px4IDL1HBz6xfNaq5eSZiQ+FNy9SOfnvcQpEQSRQL/p9YmdOImRHEuGnzaCheadg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from localhost.localdomain (84.18.126.32) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Wed, 24 Apr
 2024 13:11:36 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
CC: Roman Smirnov <r.smirnov@omp.ru>, <ntfs3@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, Sergey Shtylyov <s.shtylyov@omp.ru>,
	<lvc-project@linuxtesting.org>
Subject: [PATCH 6.1 0/1] fs: ntfs3: fix UBSAN: shift-out-of-bounds in ntfs_fill_super()
Date: Wed, 24 Apr 2024 13:11:13 +0300
Message-ID: <20240424101114.192681-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch01.omp.ru (10.188.4.12) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 04/24/2024 09:53:10
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 19
X-KSE-AntiSpam-Info: Lua profiles 184894 [Apr 24 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.4
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 18 0.3.18
 b9d6ada76958f07c6a68617a7ac8df800bc4166c
X-KSE-AntiSpam-Info: {rep_avail}
X-KSE-AntiSpam-Info: {Tracking_one_url, url3}
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info: {SMTP from is not routable}
X-KSE-AntiSpam-Info: {Found in DNSBL: 84.18.126.32 in (user)
 b.barracudacentral.org}
X-KSE-AntiSpam-Info:
	d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;syzkaller.appspot.com:7.1.1,5.0.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: ApMailHostAddress: 84.18.126.32
X-KSE-AntiSpam-Info: {DNS response errors}
X-KSE-AntiSpam-Info: Rate: 19
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dmarc=temperror header.from=omp.ru;spf=temperror
 smtp.mailfrom=omp.ru;dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 04/24/2024 09:58:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 4/24/2024 8:46:00 AM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Syzkaller reports out of bounds on shift in ntfs_init_from_boot(). The problem
was fixed in upstream with patch 91a4b1ee78cb100b19b70f077c247f211110348f.
This can be fixed in branch 6.1 with the following patch.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Link: https://syzkaller.appspot.com/bug?extid=010986becd65dbf9464b

Konstantin Komarov (1):
  fs/ntfs3: Fix shift-out-of-bounds in ntfs_fill_super

 fs/ntfs3/ntfs_fs.h |  2 ++
 fs/ntfs3/super.c   | 50 +++++++++++++++++++++++++++++-----------------
 2 files changed, 34 insertions(+), 18 deletions(-)

-- 
2.34.1


