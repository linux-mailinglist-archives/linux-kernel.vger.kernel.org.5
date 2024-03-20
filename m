Return-Path: <linux-kernel+bounces-108803-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 200A9881036
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 11:46:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 961DAB2118C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 10:46:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B657938DF9;
	Wed, 20 Mar 2024 10:46:18 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A766A1DDD6
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.241
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710931578; cv=none; b=NjoTjshnLjgVNUzkn1y2RkATvIrAhmEGzqMKo4ueiJ+h1LAHJ/2v+0Nkx/QvC7TQ9V2mwnyRZ0+AGoy43gf3nZhVy/3t2MvcxcnrNtfHtjckaC2YDrn78PQR9YUo+gwq8FHh4CvIq7rgIzelm9IF9ui5bspgMqKorhu8nqGd6pg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710931578; c=relaxed/simple;
	bh=XFP69njHEvwpCrVuHfK2Gpp2Du/R2uLGkLuOeWklu0k=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=T61TvYG2ZONl9gdmWvTu3scxkNhv4IpNR1QIHhSKDwd+oKPw6SaQcBMiTiTjoPO+OIdlw9kJHQMV78GzU5NAc5bZzcj3XkREmu9GcL0pMo1GOTJ5TcVVoZ1kf8AFiqywPNoHT9Ww8sDreh6kHFuQTIGcXJYc+OQ0yCpDG6Iipvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.241
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.11.154])
	by sina.com (172.16.235.24) with ESMTP
	id 65FABE6700001FFC; Wed, 20 Mar 2024 18:46:02 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 57787345089132
X-SMAIL-UIID: 6106B5FB6AB142D794C797D03C17790D-20240320-184602-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+49056626fe41e01f2ba7@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] possible deadlock in move_pages
Date: Wed, 20 Mar 2024 18:45:54 +0800
Message-Id: <20240320104554.2181-1-hdanton@sina.com>
In-Reply-To: <000000000000e97f090614006d76@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Tue, 19 Mar 2024 02:52:16 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-09-36' ..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=173b7ac9180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  e5eb28f6d1af

--- x/mm/userfaultfd.c
+++ y/mm/userfaultfd.c
@@ -1442,9 +1442,9 @@ static int uffd_move_lock(struct mm_stru
 		 * See comment in lock_vma() as to why not using
 		 * vma_start_read() here.
 		 */
-		down_read(&(*dst_vmap)->vm_lock->lock);
+		down_read_nested(&(*dst_vmap)->vm_lock->lock, 1);
 		if (*dst_vmap != *src_vmap)
-			down_read(&(*src_vmap)->vm_lock->lock);
+			down_read_nested(&(*src_vmap)->vm_lock->lock, 2);
 	}
 	mmap_read_unlock(mm);
 	return err;
--

