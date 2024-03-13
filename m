Return-Path: <linux-kernel+bounces-101294-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B1B8087A52D
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 10:49:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6EFA81F22319
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 09:49:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ECBF22636;
	Wed, 13 Mar 2024 09:49:04 +0000 (UTC)
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7203328374;
	Wed, 13 Mar 2024 09:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710323344; cv=none; b=BCioXS4l5hnoFPuspVvOdKAePK2LoVPVHP64gyy0xW3LDUTMjPE53ZQyena6R+VzWB5NGKTGYMX9jA+a9ph95Z5SwiqFEFkhSCmqNT009xB9EM34G4WvQkmgKfuvt60KozpUHQC8hLEPcSjnmCFbbzxWlgiiYNUwBsQua2KkU8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710323344; c=relaxed/simple;
	bh=qoj46jGRty6OpDKzuEvKMFt8BNfum+juBs3FEHcmUD4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=UW/vdOay5fQyCYvhIVOH7TsSHKYSYVDv+UzChELp84UF16omHIn5vZAdMpGi1pdxfK71em0jR2bejgSoxos+KeFtuCvhiJe37k4TYuimlzBQrBn00uivWAGPBaPk9qqPI1jj4vTdncbJqyI8W/7orAwz2JUKFEOdL422WyobE8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Tvm111Gblz1FMLC;
	Wed, 13 Mar 2024 17:48:37 +0800 (CST)
Received: from kwepemm600014.china.huawei.com (unknown [7.193.23.54])
	by mail.maildlp.com (Postfix) with ESMTPS id CC1B3140413;
	Wed, 13 Mar 2024 17:48:52 +0800 (CST)
Received: from huawei.com (10.67.174.78) by kwepemm600014.china.huawei.com
 (7.193.23.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 13 Mar
 2024 17:48:52 +0800
From: Yi Yang <yiyang13@huawei.com>
To: <gregkh@linuxfoundation.org>, <jirislaby@kernel.org>
CC: <linux-kernel@vger.kernel.org>, <linux-serial@vger.kernel.org>
Subject: [PATCH v2] tty: vt: selection: fix soft lockup in paste_selection()
Date: Wed, 13 Mar 2024 09:45:29 +0000
Message-ID: <20240313094529.679957-1-yiyang13@huawei.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemm600014.china.huawei.com (7.193.23.54)

Soft lockup occurs when vt device used n_null ldisc, n_null_receivebuf()
is not implemented in null_ldisc. So tty_ldisc_receive_buf always return
0 in paste_selection(), this cause deadloop and cause soft lockup.

This can be reproduced as follows:
  int ldisc = 0x1b; // 0x1b is n_null
  struct{
  	char subcode;
  	struct tiocl_selection sel;
  } data;
  date.subcode = TIOCL_SETSEL;
  data.sel.xs = 0;
  data.sel.xe = 1;
  data.sel.ys = 0;
  data.sel.ye = 1;
  data.sel.sel_mode = TIOCL_SELCHAR;
  char bytes[2] = {TIOCL_PASTESEL, 0};
  open("ttyxx", O_RDWR) // open a vt device
  ioctl(fd, TIOCSETD, &ldisc) // set ldisc to n_null
  ioctl(fd, TIOCLINUX, &data.subcode);
  ioctl(fd, TIOCLINUX, bytes); // cause deadloop

Fix soft lockup by check receive_buf() and receive_buf2() is NULL.

Signed-off-by: Yi Yang <yiyang13@huawei.com>
---

v2:Change Check Condition.

 drivers/tty/vt/selection.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/tty/vt/selection.c b/drivers/tty/vt/selection.c
index 564341f1a74f..715e111376a7 100644
--- a/drivers/tty/vt/selection.c
+++ b/drivers/tty/vt/selection.c
@@ -397,6 +397,12 @@ int paste_selection(struct tty_struct *tty)
 	ld = tty_ldisc_ref_wait(tty);
 	if (!ld)
 		return -EIO;	/* ldisc was hung up */
+
+	/*tty_ldisc_receive_buf() won't do anything and cause deadloop later*/
+	if (!ld->ops->receive_buf && !ld->ops->receive_buf2) {
+		tty_ldisc_deref(ld);
+		return -EIO;
+	}
 	tty_buffer_lock_exclusive(&vc->port);
 
 	add_wait_queue(&vc->paste_wait, &wait);
-- 
2.25.1


