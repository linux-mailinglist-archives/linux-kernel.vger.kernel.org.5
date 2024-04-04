Return-Path: <linux-kernel+bounces-132274-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F1810899253
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:57:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E86011C2207C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE75B13C69D;
	Thu,  4 Apr 2024 23:57:07 +0000 (UTC)
Received: from mail114-240.sinamail.sina.com.cn (mail114-240.sinamail.sina.com.cn [218.30.114.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB8E6FE1A
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.114.240
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712275027; cv=none; b=mE0dXVRKeQC2gFhCOBqT3xGz2/EJeVCkDmzaJXSB1tWqm/+Lx84ESH/AEcIgepymdgkM83efwy5Rp2LpwaPnjE54jnjKw7ke3oXBLtJMioS97ZjrmjFf/bWGc8Ne/Gvo32/vYPPFlgsqfygxHYUEDrtLjEtSCm4OLAG4w+mm/pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712275027; c=relaxed/simple;
	bh=tiR0dWhX/RAb/Jzq06KY+ti0WH3crAYGNjpl1P5V7JE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hoAS0VC6uHzZ/pEqdczMdI6xeZ28wwsEc1NIlflP7Vn6JibzqO0PbiM0MrCtZVTkAXEU0FjEFZMfnAOSyZRXPULy7MUBJwROMwuJ/GnJzun2wMLoZyuamHQEN2mmO1ctg6FlpIznxAc6/X2bkCccQbSb/xob8Hha4LF6Td7serw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.114.240
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.172])
	by sina.com (172.16.235.24) with ESMTP
	id 660F3E3F0000459C; Thu, 5 Apr 2024 07:56:52 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 6179345089537
X-SMAIL-UIID: 1348F282FC554D269D623240BBF186E8-20240405-075652-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7f7f201cc2668a8fd169@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in unix_del_edges
Date: Fri,  5 Apr 2024 07:56:38 +0800
Message-Id: <20240404235638.771-1-hdanton@sina.com>
In-Reply-To: <00000000000083ca480615479e79@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Thu, 04 Apr 2024 09:13:26 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    2b3d5988ae2c Add linux-next specific files for 20240404
> git tree:       linux-next
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1133aaa9180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git  2b3d5988ae2c

--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -358,7 +358,7 @@ static void unix_collect_skb(struct list
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 			if (u->oob_skb) {
-				kfree_skb(u->oob_skb);
+				__skb_queue_tail(hitlist, u->oob_skb);
 				u->oob_skb = NULL;
 			}
 #endif
--

