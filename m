Return-Path: <linux-kernel+bounces-136068-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49C5589CFB2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 03:16:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0260628570C
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 01:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A289C63B9;
	Tue,  9 Apr 2024 01:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="CoNRVvzQ"
Received: from out203-205-221-205.mail.qq.com (out203-205-221-205.mail.qq.com [203.205.221.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD0F64B
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 01:16:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712625394; cv=none; b=gE0c3bk+osSvWoL1wmTAGHJu6OGm17J0FWa7mcv0ayA9rDGe21efT7ZwyTAwq/MPWdepnZyyxd8l/qHl1xCGnH47UKhSYazUGes8hzk1JiSokFPT+aFT5l91RwLcL81Q99r5gxHdntn5c6IUOmw7Q2u0BYV7fW3lLB1aaHpN3vo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712625394; c=relaxed/simple;
	bh=G91tSLM8pM+/C8VZJvDCyOlNemRmdVzykjJeKQl2Y7Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=CftR517fKVYk4bN7AazylX/ZZoiS79qby7KR7yLrELo9UoaF2gR9Zx4nxE+0oVQUdmeSdNmn3qDFSs//9f99Z+XXtclVmrAe5AzKH5BwwN5W0QUGWfX5JQLlA3NhWkB3uE80oz+KbmtvH2eHqF4eti2jOEW97TNf6SEKa306dAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com; spf=pass smtp.mailfrom=qq.com; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=CoNRVvzQ; arc=none smtp.client-ip=203.205.221.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=qq.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qq.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1712625382; bh=wcmpugXpfqEgnKAK4si+cf4yNM1bZAjI3/SR1gfTx+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CoNRVvzQb4kvqGpzWxFM7Y4FUpOWGtT6h4IbSMTso41lacckdzrRYT3Yxry3SysvA
	 G9O+cUUP5GjDrRBfTmmI+ImOMNpVtgJrKijXM8rfUadwrgYV940ok/9SJm8zT0nXHn
	 j0E5rjbP+u9Wz0yuDOwx4uh/zbuKcCw4hE+yFgck=
Received: from pek-lxu-l1.wrs.com ([111.198.228.153])
	by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
	id 4140CEF2; Tue, 09 Apr 2024 09:16:20 +0800
X-QQ-mid: xmsmtpt1712625380trbqxn46h
Message-ID: <tencent_12296C83BC04535760577A26D4336AA36005@qq.com>
X-QQ-XMAILINFO: M58CI+QHpTsk+p8j1J7qr7E1MQWMCS2P/ozjh92fNn4QkLGKe4I3PJIsqOt4su
	 DKWl4nCp7waHOL/ar3EFDD/vs8pO0CGBPDBNuihbFVk9d7IMuMCghIAfmndconKd93Z3bkcvF2JD
	 ofWhMRCvDxsnV+bnrqsJF1MYlHkPT4DHmSIDDSjb3fxIskMS5rjEWu0OYC+QxUGmQT69MnCOkxkg
	 0saQ+gBH0QrX6osKvoyppJCXforBd0tV+FgUF4u7/rV1H1tafnE8Iw+Y9S4LYLgswz/tHVLLhX5b
	 0xALn9is0zDAI1fWfJ//OzAseGrS3Z1efCxB1ikIJwGWBC01Vx4jBt3OOJNjZIEGCDzGdkeSc68O
	 eNs1uE3aHoldoQIQvK+zaIZewwNPdxCztOFUV5oat6m4N20DFUp6LC++85/cPq++xlF13+v3U7cl
	 TXEmqyv8aw2OE12ORHR4/A8tbmmBllzCQNFfUQ5yLJkEEtpyrm5pEYjRLM68+rCwT4EErxuWggEC
	 m7mInI/Q9VIxrbVuiWQtCewnDhKgEuzQg87K6tCYT5F5XacWW8CPK7ejlTALFYWhI0U0iIBiM39o
	 JTiS1ctw1Io0kAwXVV4cLNidb+Udn/9UOMAGCElSztr2cqNbZ5jM5a64gm7TJnn/9GBNsOs7FBcU
	 eZlArARFz3pG2zqY9CV+oHFgos0PPAMlU6PFmev1XyFhquqe0PscQgn+1zYwRhohUwwJNm9+ggTq
	 1Nd2SSD1RASbuWNm6ImPYCKoGHTwwIj5MmSMYPwI63BxQKwyTYohyy1a1LlZlCZjrv/qpHXMhlhs
	 Y1yxQujW+/mDlrXZRClR8PH+5yZAiL16P+x+0AoEhCK0SUZ3Etsr9uIp4H7jSkjHiUbUXR/or7ua
	 mIv6uTxXDjJn0vz9YxZXOHbRwAtUa4UQSgklLB2fyLKYNEVOyIpiTi+vZq6w3Tdg==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From: Edward Adam Davis <eadavis@qq.com>
To: syzbot+27cc650ef45b379dfe5a@syzkaller.appspotmail.com
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: [syzbot] [erofs?] BUG: using smp_processor_id() in preemptible code in z_erofs_get_gbuf
Date: Tue,  9 Apr 2024 09:16:21 +0800
X-OQ-MSGID: <20240409011620.3427776-2-eadavis@qq.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000084b9dd061599e789@google.com>
References: <00000000000084b9dd061599e789@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

please test wrong context using smp_processor_id

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 2b3d5988ae2c

diff --git a/fs/erofs/zutil.c b/fs/erofs/zutil.c
index 9687cad8be96..0a3d9eecbf16 100644
--- a/fs/erofs/zutil.c
+++ b/fs/erofs/zutil.c
@@ -35,8 +35,11 @@ void *z_erofs_get_gbuf(unsigned int requiredpages)
 	__acquires(gbuf->lock)
 {
 	struct z_erofs_gbuf *gbuf;
+	unsigned long flags;
 
+	local_irq_save(flags);
 	gbuf = &z_erofs_gbufpool[z_erofs_gbuf_id()];
+	local_irq_restore(flags);
 	spin_lock(&gbuf->lock);
 	/* check if the buffer is too small */
 	if (requiredpages > gbuf->nrpages) {


