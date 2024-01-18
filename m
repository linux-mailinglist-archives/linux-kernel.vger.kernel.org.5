Return-Path: <linux-kernel+bounces-30598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C8863832177
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 23:16:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 594511F2651E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 679F032193;
	Thu, 18 Jan 2024 22:16:15 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DD8F250F7
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 22:16:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705616175; cv=none; b=qZTvDVeWW8ViP3pHC3xgswfNguiQioDgDCnUNwglLKnYoK0NV/MGS1koe2rKhnf+e0D8uDIKeyZrgcGmWGFQGUeDSSrBnVa6DfyKRrRR+acxMh77v4NzuWx/ih9NVApj43QNjJU3xNum+gtE4AelrfKBOgSV74KhXm7+DZqtIw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705616175; c=relaxed/simple;
	bh=mdW8/uyoRWJLNvzuoFtv1hbqtX8oYkV/wIr4zaSTATU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TcdpvVzP4J3pmLjTAfYnfNWnjoMLvo0E9mY/3NW0IOxCxtDlLz1wN1k01qccHrYOVgQOWy0KBUJqvPvj+zjCtjFBn798GgIeaTh+BYWs91NDb/IdAgjAxrAassqZCymYWfQCu+JxANmra2Y4Qetww7019IHzOmQQXgLvTFzqGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.10.220])
	by sina.com (172.16.235.25) with ESMTP
	id 65A9A32300000D16; Thu, 19 Jan 2024 06:16:06 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 27104634210572
X-SMAIL-UIID: 080A8B68410A41D18B4BA858570DF158-20240119-061606-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+bfde3bef047a81b8fde6@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: use-after-free Read in __skb_flow_dissect (3)
Date: Fri, 19 Jan 2024 06:15:54 +0800
Message-Id: <20240118221554.1749-1-hdanton@sina.com>
In-Reply-To: <000000000000498a02060de59162@google.com>
References: <000000000000498a02060de59162@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 01 Jan 2024 09:18:16 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    f5837722ffec Merge tag 'mm-hotfixes-stable-2023-12-27-15-0..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=122dfc65e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/core/filter.c
+++ y/net/core/filter.c
@@ -2148,17 +2148,6 @@ static int __bpf_redirect_no_mac(struct
 		return -ERANGE;
 	}
 
-	if (mlen) {
-		__skb_pull(skb, mlen);
-
-		/* At ingress, the mac header has already been pulled once.
-		 * At egress, skb_pospull_rcsum has to be done in case that
-		 * the skb is originated from ingress (i.e. a forwarded skb)
-		 * to ensure that rcsum starts at net header.
-		 */
-		if (!skb_at_tc_ingress(skb))
-			skb_postpull_rcsum(skb, skb_mac_header(skb), mlen);
-	}
 	skb_pop_mac_header(skb);
 	skb_reset_mac_len(skb);
 	return flags & BPF_F_INGRESS ?
--

