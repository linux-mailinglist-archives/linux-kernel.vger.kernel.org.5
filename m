Return-Path: <linux-kernel+bounces-126699-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 63120893BBB
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 16:06:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 035291F20F12
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 14:06:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9378405E6;
	Mon,  1 Apr 2024 14:06:17 +0000 (UTC)
Received: from mta20.hihonor.com (mta20.honor.com [81.70.206.69])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FCE93FE52
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 14:06:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=81.70.206.69
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711980377; cv=none; b=neOsBQvrvqQuugqNH/O4+saqbe6/9Bsy2pGYEEy7IzMwQeV5i7LGIRUxiCqiSxWwY3mjPsLVeN9OFVNk/Xbf3+e2Pyq+5HfY+eGWkDH7PiiTzW72jpkdSBwqTIt+R9W761HKhkaX3BIGxVqGjGj4ajXUARJEuDk+6Y+m4v4fEDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711980377; c=relaxed/simple;
	bh=7Vn77MQaepkLiapMpfLmvvEmNQBRU3d+1tEdA4VbGUA=;
	h=From:To:CC:Subject:Date:Message-ID:Content-Type:MIME-Version; b=E7vU5pO19qKH1gdoikB4BgZGOOVb5o9Owi/3Qhs4CHUGWoFPrL1F+GXiS//QZe0rTL+evTMDmpDfOfLUphuFb9vkP7p22gefFZ8ia3uPaPuMhcVryb8HrTdgrGAJ24opBo5/cje3g6SQWxelaUIUjY+KSwuFf07DOFkrw/Ag1nI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=honor.com; spf=pass smtp.mailfrom=honor.com; arc=none smtp.client-ip=81.70.206.69
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=honor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=honor.com
Received: from w011.hihonor.com (unknown [10.68.20.122])
	by mta20.hihonor.com (SkyGuard) with ESMTPS id 4V7XQf2SNQzYxDsy;
	Mon,  1 Apr 2024 21:48:10 +0800 (CST)
Received: from a006.hihonor.com (10.68.23.242) by w011.hihonor.com
 (10.68.20.122) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Mon, 1 Apr
 2024 21:48:20 +0800
Received: from a011.hihonor.com (10.68.31.243) by a006.hihonor.com
 (10.68.23.242) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1258.25; Mon, 1 Apr
 2024 21:48:20 +0800
Received: from a011.hihonor.com ([fe80::78ac:4faf:25dd:3496]) by
 a011.hihonor.com ([fe80::78ac:4faf:25dd:3496%7]) with mapi id 15.02.1258.025;
 Mon, 1 Apr 2024 21:48:20 +0800
From: wangzijie <wangzijie1@honor.com>
To: "jaegeuk@kernel.org" <jaegeuk@kernel.org>, "chao@kernel.org"
	<chao@kernel.org>
CC: "linux-f2fs-devel@lists.sourceforge.net"
	<linux-f2fs-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "wangbintian(BintianWang)"
	<bintian.wang@honor.com>
Subject: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write inline
 data
Thread-Topic: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write
 inline data
Thread-Index: AdqEOdZMrsI3iA2JQyKLGLQGeOfhFw==
Date: Mon, 1 Apr 2024 13:48:20 +0000
Message-ID: <2073e8995f5444aeaf7133b87ec07de8@honor.com>
Accept-Language: zh-CN, en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

From: Zijie Wang <wangzijie1@honor.com>
Date: Mon, 1 Apr 2024 21:24:08 +0800
Subject: [PATCH] [f2fs-dev] f2fs: use f2fs_get_node_page when write inline =
data

We just need inode page when write inline data, use
f2fs_get_node_page() to get it instead of using dnode_of_data,
which can eliminate unnecessary struct use.

Signed-off-by: Zijie Wang <wangzijie1@honor.com>
---
 fs/f2fs/inline.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
index ac00423f117b..6e20d8e7affc 100644
--- a/fs/f2fs/inline.c
+++ b/fs/f2fs/inline.c
@@ -242,33 +242,32 @@ int f2fs_convert_inline_inode(struct inode *inode)
=20
 int f2fs_write_inline_data(struct inode *inode, struct page *page)
 {
-	struct dnode_of_data dn;
-	int err;
+	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
+	struct page *ipage;
=20
-	set_new_dnode(&dn, inode, NULL, NULL, 0);
-	err =3D f2fs_get_dnode_of_data(&dn, 0, LOOKUP_NODE);
-	if (err)
-		return err;
+	ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
+	if (IS_ERR(ipage))
+		return PTR_ERR(ipage);
=20
 	if (!f2fs_has_inline_data(inode)) {
-		f2fs_put_dnode(&dn);
+		f2fs_put_page(ipage, 1);
 		return -EAGAIN;
 	}
=20
 	f2fs_bug_on(F2FS_I_SB(inode), page->index);
=20
-	f2fs_wait_on_page_writeback(dn.inode_page, NODE, true, true);
-	memcpy_from_page(inline_data_addr(inode, dn.inode_page),
+	f2fs_wait_on_page_writeback(ipage, NODE, true, true);
+	memcpy_from_page(inline_data_addr(inode, ipage),
 			 page, 0, MAX_INLINE_DATA(inode));
-	set_page_dirty(dn.inode_page);
+	set_page_dirty(ipage);
=20
 	f2fs_clear_page_cache_dirty_tag(page);
=20
 	set_inode_flag(inode, FI_APPEND_WRITE);
 	set_inode_flag(inode, FI_DATA_EXIST);
=20
-	clear_page_private_inline(dn.inode_page);
-	f2fs_put_dnode(&dn);
+	clear_page_private_inline(ipage);
+	f2fs_put_page(ipage, 1);
 	return 0;
 }
=20
--=20
2.25.1


