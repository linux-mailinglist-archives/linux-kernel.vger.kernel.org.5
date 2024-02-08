Return-Path: <linux-kernel+bounces-58243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B4DA184E35C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 15:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 45E86B24B72
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 14:42:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8BDD79DD8;
	Thu,  8 Feb 2024 14:42:50 +0000 (UTC)
Received: from mx01.omp.ru (mx01.omp.ru [90.154.21.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65E9378B75;
	Thu,  8 Feb 2024 14:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.154.21.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707403370; cv=none; b=q54TBzPCVA3BFD7wIwv3MHsNfTeXqxbRNDdogPlpOrM+pPbEhPg0dWNaIGZox/+kRgYNjCMQ1JAROCTj/pk+mgSa8OSsO6DSsCb/xoq8ToAaD0GJKHkzFJddxZ7GmxMoIAXgAuJhcWbSJImRL38CitZjiwFXLvQHwcbJgmR4LCc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707403370; c=relaxed/simple;
	bh=jTC7Yl8CGI3zJJ9sjNzV4WysyTmtlbJK/KOW6mryqbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=PcRThTjdpU+mq0rDmDbRPDcQmz9D6GVIdHDe/reLr/4TwIqcrJKvDZp6JoqRTQ28vC7BCZbQG0igxSGnvHYnn3u1ByXFkkvTvPHIQjyoMFxI5bETBc0jZHPdLq58QHzZr1/ppALbRNQmMMAf8hOEmj2v+j0WOF81D9tQd1jjOVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru; spf=pass smtp.mailfrom=omp.ru; arc=none smtp.client-ip=90.154.21.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=omp.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=omp.ru
Received: from r.smirnovsmtp.omp.ru (10.189.215.22) by msexch01.omp.ru
 (10.188.4.12) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.1258.12; Thu, 8 Feb
 2024 17:42:41 +0300
From: Roman Smirnov <r.smirnov@omp.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Roman Smirnov <r.smirnov@omp.ru>, Ryusuke Konishi
	<konishi.ryusuke@gmail.com>, <linux-nilfs@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, Alexey Khoroshilov <khoroshilov@ispras.ru>,
	<lvc-project@linuxtesting.org>, Sergey Shtylyov <s.shtylyov@omp.ru>, Karina
 Yankevich <k.yankevich@omp.ru>, Andrey Rusalin <a.rusalin@omp.ru>, Sergey
 Yudin <s.yudin@omp.ru>, Valentin Perevozchikov <v.perevozchikov@omp.ru>
Subject: [PATCH 5.10/5.15/6.1 0/1] nilfs2: fix WARNING in nilfs_dat_prepare_end()
Date: Thu, 8 Feb 2024 14:42:23 +0000
Message-ID: <20240208144224.438146-1-r.smirnov@omp.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: msexch02.omp.ru (10.188.4.13) To msexch01.omp.ru
 (10.188.4.12)
X-KSE-ServerInfo: msexch01.omp.ru, 9
X-KSE-AntiSpam-Interceptor-Info: scan successful
X-KSE-AntiSpam-Version: 6.1.0, Database issued on: 02/08/2024 14:27:39
X-KSE-AntiSpam-Status: KAS_STATUS_NOT_DETECTED
X-KSE-AntiSpam-Method: none
X-KSE-AntiSpam-Rate: 0
X-KSE-AntiSpam-Info: Lua profiles 183298 [Feb 08 2024]
X-KSE-AntiSpam-Info: Version: 6.1.0.3
X-KSE-AntiSpam-Info: Envelope from: r.smirnov@omp.ru
X-KSE-AntiSpam-Info: LuaCore: 7 0.3.7 6d6bf5bd8eea7373134f756a2fd73e9456bb7d1a
X-KSE-AntiSpam-Info: {Tracking_uf_ne_domains}
X-KSE-AntiSpam-Info: {Tracking_from_domain_doesnt_match_to}
X-KSE-AntiSpam-Info:
	syzkaller.appspot.com:5.0.1,7.1.1;r.smirnovsmtp.omp.ru:7.1.1;d41d8cd98f00b204e9800998ecf8427e.com:7.1.1;127.0.0.199:7.1.2;omp.ru:7.1.1
X-KSE-AntiSpam-Info: FromAlignment: s
X-KSE-AntiSpam-Info: Rate: 0
X-KSE-AntiSpam-Info: Status: not_detected
X-KSE-AntiSpam-Info: Method: none
X-KSE-AntiSpam-Info: Auth:dkim=none
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Heuristic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 02/08/2024 14:32:00
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: Clean, bases: 2/8/2024 12:48:00 PM
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: InTheLimit

Syzkaller reports WARNING in nilfs_dat_prepare_end() in 5.10, 5.15 and 6.1
stable releases. The problem has been fixed in upstream:
https://syzkaller.appspot.com/bug?extid=5d5d25f90f195a3cfcb4

The problem can also be fixed in versions 5.10, 5.15 and 6.1 by the
following patch.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Link: https://syzkaller.appspot.com/bug?extid=325e6b0a1e7cf9035cc0
Link: https://syzkaller.appspot.com/bug?extid=bebf30d67ea2569f0fd3

Ryusuke Konishi (1):
  nilfs2: replace WARN_ONs for invalid DAT metadata block requests

 fs/nilfs2/dat.c | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

-- 
2.34.1

