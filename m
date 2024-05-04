Return-Path: <linux-kernel+bounces-168507-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF468BB962
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 05:24:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C9DF91F2341A
	for <lists+linux-kernel@lfdr.de>; Sat,  4 May 2024 03:24:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F159D107A6;
	Sat,  4 May 2024 03:24:13 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D715800
	for <linux-kernel@vger.kernel.org>; Sat,  4 May 2024 03:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714793053; cv=none; b=DrtTNMjo1TUbfy8mPbcjB+GvIYyESf74MnAZhY31HBUzdnAHTr8YbwszMo9Hccp4b2UMTK9+9sCm0CAp625cfhDwtW3/XNsBUfzoDQpZApFpyDMoyhTMgiucYyfCUJYnK9WKQHO57uCRkTy0rJuBnq/RX/UJpKJashALIFhQgfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714793053; c=relaxed/simple;
	bh=jQ4O/aEuFt08ngMxcl9D4KYRUsBeEcYRIRby+ba80+E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XrmdhrPuc7gpxp6mUJE6Z4MplbKAFqpE79NqnsoFAWCWI9pZ/WchJ5+CXRkmvKwNxxSL0SlSjBhBocPIxxKc05ojeNsnps6qPP99rb0iRS1M7ni8NdMdqeMapM8tKvkeDBdQspCNHOIMpD+eCTL96SiEtL6Vv0zSmc2ZUxiwDQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.66.195])
	by sina.com (172.16.235.24) with ESMTP
	id 6635AA4A00005356; Sat, 4 May 2024 11:23:56 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 42049345089161
X-SMAIL-UIID: F78DC521C8484564BC286F71B9261858-20240504-112356-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+045b454ab35fd82a35fb@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [fs?] [io-uring?] general protection fault in __ep_remove
Date: Sat,  4 May 2024 11:23:45 +0800
Message-Id: <20240504032345.1992-1-hdanton@sina.com>
In-Reply-To: <0000000000002d631f0615918f1e@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 08 Apr 2024 01:26:16 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10801175180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  480e035fc4c7

--- x/fs/eventpoll.c
+++ y/fs/eventpoll.c
@@ -991,9 +991,13 @@ static __poll_t ep_item_poll(const struc
 	__poll_t res;
 
 	pt->_key = epi->event.events;
-	if (!is_file_epoll(file))
-		res = vfs_poll(file, pt);
-	else
+	if (!is_file_epoll(file)) {
+		res = 0;
+		if (atomic_long_inc_not_zero(&file->f_count)) {
+			res = vfs_poll(file, pt);
+			fput(file);
+		}
+	} else
 		res = __ep_eventpoll_poll(file, pt, depth);
 	return res & epi->event.events;
 }
--

