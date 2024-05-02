Return-Path: <linux-kernel+bounces-167056-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 253AD8BA3F0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:23:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ED04B23469
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 23:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E691D55D;
	Thu,  2 May 2024 23:23:43 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D3DE1C2AD
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 23:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714692223; cv=none; b=LJbsmUuGx+oD+rS7AlfHsgWinb94XqxKifA84xsuOkTTrDCsnOPSskBuLQEALUcoTOtGOzbUx1gY+19OtuUbIcfJqwKIZtLstmZbmHHWiHl2xUNfDS9aszpzZkf17ZTgPL3GptHD2YbSOP25vnwXzLViZyO6MyGJusz8MUTN6H0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714692223; c=relaxed/simple;
	bh=qxv6eLTXJ08RHAn4M74hEmlNHmGTF7pZkSb0aNw1mBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dQulmHqTWjH5Z6IXb39wIMavdQc35odwlu3vDq+khQhg5NfCkgzXePIrDCGiYI8ytCj6lSkTkYZDuNgOqo3expyEZSxkCRWPaT5qhaTg2pWaMEwe89yCEJM5B4ObP8qwrG5fBBBs02Kt4SBCzp93gVvhqGh8b/engnQzFMvKthU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.64.31])
	by sina.com (10.75.12.45) with ESMTP
	id 6634205100005E4F; Thu, 3 May 2024 07:22:59 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 65011531457717
X-SMAIL-UIID: D436D9FE715F47DC8A982E0EA16D3A41-20240503-072259-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9e39ac154d8781441e60@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [btrfs?] kernel BUG in folio_unlock (2)
Date: Fri,  3 May 2024 07:22:47 +0800
Message-Id: <20240502232247.1845-1-hdanton@sina.com>
In-Reply-To: <0000000000009e614206177b0968@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 02 May 2024 09:24:30 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    9c6ecb3cb6e2 Add linux-next specific files for 20240502
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10efe5f8980000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  9c6ecb3cb6e2

--- x/fs/btrfs/extent_io.c
+++ y/fs/btrfs/extent_io.c
@@ -1516,7 +1516,8 @@ done:
 					       PAGE_SIZE, !ret);
 		mapping_set_error(page->mapping, ret);
 	}
-	unlock_page(page);
+	if (PageLocked(page))
+		unlock_page(page);
 	ASSERT(ret <= 0);
 	return ret;
 }
--

