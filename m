Return-Path: <linux-kernel+bounces-139506-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 351B98A03C5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 00:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D474A1F2B1E7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 22:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A95C13E49C;
	Wed, 10 Apr 2024 22:53:21 +0000 (UTC)
Received: from mail115-118.sinamail.sina.com.cn (mail115-118.sinamail.sina.com.cn [218.30.115.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CDB10A1D
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 22:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712789601; cv=none; b=j8R+8+da5556utb+tm+hIJ1n1d6qd1WiAp2K0lNvtwK5VTYCgJST/ytBrCm2sTvNfu8wxD8yfGfXyUz691B57I2cSMVgjck5qSFdgxrDiYG7wYhlILVImBIjNRqkzGbUYW5NXaP4X/6kuhY4egGCzNnXT/h3gFDoJ3CsBtqcv/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712789601; c=relaxed/simple;
	bh=RDUgMCW7ih6Zd7tHmeamaX5LBVNc3hBRTo2BT+4qARA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nLPulnKp6QzlpOtRKV37BD5wUj3/1szebFePG7T3u4hhs/nfIIS71rKSYtfhwGAy//YCGJGRAQHLLsZBUbbUeyER6hq65Vhtl/wj/R/WmcZf/WdAKYbz+oOQCn0u1s2mzrSuRhbD/oqdr4ZTTM4u6T3Vyke6ZCdtDZr4QDNMYYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.50.59])
	by sina.com (172.16.235.25) with ESMTP
	id 6617185000000D76; Wed, 11 Apr 2024 06:53:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 75703134210298
X-SMAIL-UIID: 9EE7AFC8FD6348368857EA04321C0100-20240411-065306-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+38b3aa8cd529958bd27a@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in unix_notinflight
Date: Thu, 11 Apr 2024 06:52:58 +0800
Message-Id: <20240410225258.631-1-hdanton@sina.com>
In-Reply-To: <0000000000005576ad0615c2710b@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Wed, 10 Apr 2024 11:45:29 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    443574b03387 riscv, bpf: Fix kfunc parameters incompatibil..
> git tree:       bpf
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=11aee305180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/bpf/bpf.git  443574b03387

--- x/net/unix/garbage.c
+++ y/net/unix/garbage.c
@@ -327,7 +327,7 @@ static void __unix_gc(struct work_struct
 
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (u->oob_skb) {
-			kfree_skb(u->oob_skb);
+			__skb_queue_tail(hitlist, u->oob_skb);
 			u->oob_skb = NULL;
 		}
 #endif
--

