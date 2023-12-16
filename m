Return-Path: <linux-kernel+bounces-2120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B9A5981581C
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 08:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F277B1C24600
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 07:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313FA14280;
	Sat, 16 Dec 2023 07:01:11 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail78-36.sinamail.sina.com.cn (mail78-36.sinamail.sina.com.cn [219.142.78.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE34538A
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 07:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.121])
	by sina.com (172.16.235.25) with ESMTP
	id 657D4B02000027FC; Sat, 16 Dec 2023 15:00:22 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 26798234210339
X-SMAIL-UIID: 842C397B445B4A34B5D3BFE1D08B24C0-20231216-150022-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+8b23309d5788a79d3eea@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [block?] general protection fault in bio_first_folio
Date: Sat, 16 Dec 2023 15:00:12 +0800
Message-Id: <20231216070012.1643-1-hdanton@sina.com>
In-Reply-To: <0000000000006c14cd060c99ac12@google.com>
References: <0000000000006c14cd060c99ac12@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Fri, 15 Dec 2023 21:20:22 -0800
> HEAD commit:    abb240f7a2bd Add linux-next specific files for 20231212
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=13274512e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  abb240f7a2bd

--- x/block/blk-map.c
+++ y/block/blk-map.c
@@ -269,6 +269,7 @@ static int bio_map_user_iov(struct reque
 	unsigned int max_sectors = queue_max_hw_sectors(rq->q);
 	unsigned int nr_vecs = iov_iter_npages(iter, BIO_MAX_VECS);
 	struct bio *bio;
+	int add_pg = 0;
 	int ret;
 	int j;
 
@@ -322,6 +323,7 @@ static int bio_map_user_iov(struct reque
 					bio_release_page(bio, page);
 				bytes -= n;
 				offs = 0;
+				add_pg = 1;
 			}
 		}
 		/*
@@ -344,7 +346,8 @@ static int bio_map_user_iov(struct reque
 	return 0;
 
  out_unmap:
-	bio_release_pages(bio, false);
+	if (add_pg)
+		bio_release_pages(bio, false);
 	blk_mq_map_bio_put(bio);
 	return ret;
 }
--

