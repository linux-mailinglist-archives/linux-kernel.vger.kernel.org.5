Return-Path: <linux-kernel+bounces-13814-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 69DE08212D7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 03:28:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BBFFBB21BAE
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 02:28:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB3B180D;
	Mon,  1 Jan 2024 02:28:15 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail115-24.sinamail.sina.com.cn (mail115-24.sinamail.sina.com.cn [218.30.115.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31EEB7ED
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 02:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.70.64])
	by sina.com (10.75.12.45) with ESMTP
	id 6592229E0000611E; Mon, 1 Jan 2024 10:25:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 0876431457826
X-SMAIL-UIID: C39BE61ED4F7499D81D21A62A897F6D6-20240101-102537-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9b4adfed366b14496e7e@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [dri?] [media?] memory leak in get_sg_table
Date: Mon,  1 Jan 2024 10:25:25 +0800
Message-Id: <20240101022525.2537-1-hdanton@sina.com>
In-Reply-To: <0000000000009e6825060dd6c287@google.com>
References: <0000000000009e6825060dd6c287@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 Dec 2023 15:38:19 -0800
> HEAD commit:    fbafc3e621c3 Merge tag 'for_linus' of git://git.kernel.org..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e8171ae80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/drivers/dma-buf/udmabuf.c
+++ y/drivers/dma-buf/udmabuf.c
@@ -153,7 +153,12 @@ static int begin_cpu_udmabuf(struct dma_
 	int ret = 0;
 
 	if (!ubuf->sg) {
-		ubuf->sg = get_sg_table(dev, buf, direction);
+		static DEFINE_MUTEX(lock);
+
+		mutex_lock(&lock);
+		if (!ubuf->sg)
+			ubuf->sg = get_sg_table(dev, buf, direction);
+		mutex_unlock(&lock);
 		if (IS_ERR(ubuf->sg)) {
 			ret = PTR_ERR(ubuf->sg);
 			ubuf->sg = NULL;
--

