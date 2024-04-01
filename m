Return-Path: <linux-kernel+bounces-127156-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6B2894786
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 01:02:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ABC81C21FE5
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 23:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84B0D56B64;
	Mon,  1 Apr 2024 23:02:48 +0000 (UTC)
Received: from mail115-80.sinamail.sina.com.cn (mail115-80.sinamail.sina.com.cn [218.30.115.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B180B1C2E
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 23:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712012568; cv=none; b=ilA0FziqFtOpyyMVH0s9UAXBuM6PwCwRGpIBXzp2c8OrLwzBVoVQttkmbM/+U+bGGyMKAcZtDlCxAEvIeILw4dVqA2+OmEw1nzuuh+CGheD0WPRBcDlcawkZhtQnG8c+vBKumTA3FUFRhWxMGxO4Bz84AwZskqWhW+Qt4bMopyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712012568; c=relaxed/simple;
	bh=Q1ucLBVGqzyWyAE/e2DyN+HhC6RmP37x/c//Fb1quzs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=oJbicesCFhBk3ZXUBpr1v96f9EeLXmsvZgMZM6DOXyVC4JKaN7ivwEVfbXjtQm5g6AcCgN84bgRkUrGx6/gcciALyVsnK2V8qygvJK15blunjexv5IDwZVtnOYEIy3PTfZMjM58ySSfqypO6aimJXHSePeqB4ByJXqqdvuHzpk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.84])
	by sina.com (10.75.12.45) with ESMTP
	id 660B3CE200009A66; Mon, 2 Apr 2024 07:02:00 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 82986431457901
X-SMAIL-UIID: 454ABA119ABB47F89829EC02BE1A2E89-20240402-070200-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+9a3c54f52bd1edbd975f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [usb?] KASAN: slab-use-after-free Write in usb_anchor_suspend_wakeups (2)
Date: Tue,  2 Apr 2024 07:01:44 +0800
Message-Id: <20240401230144.3642-1-hdanton@sina.com>
In-Reply-To: <000000000000ac924c06150bc9eb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Apr 2024 09:50:32 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1244fe29180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  480e035fc4c7

--- x/drivers/usb/class/usbtmc.c
+++ y/drivers/usb/class/usbtmc.c
@@ -256,6 +256,7 @@ static int usbtmc_release(struct inode *
 	spin_unlock_irq(&file_data->data->dev_lock);
 	mutex_unlock(&file_data->data->io_mutex);
 
+	usb_kill_anchored_urbs(&file_data->submitted);
 	kref_put(&file_data->data->kref, usbtmc_delete);
 	file_data->data = NULL;
 	kfree(file_data);
--

