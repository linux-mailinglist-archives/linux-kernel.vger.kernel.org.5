Return-Path: <linux-kernel+bounces-126664-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4087893B2F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 15:04:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E6D1281EAA
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 13:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2920D3EA68;
	Mon,  1 Apr 2024 13:04:31 +0000 (UTC)
Received: from mail115-63.sinamail.sina.com.cn (mail115-63.sinamail.sina.com.cn [218.30.115.63])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0496921A0A
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 13:04:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.63
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711976670; cv=none; b=qLH2+sfCWYH+ws41uFiUc4LOuuJeaNfE3xfrAKJGFrD9tMwCCosRfwqDTc56D52h09JeEO8CkZ0sWQ4YvoOQZ1FkllqvlPmkY+1MoP4H0kDDB7DQy21sEBbRZ4wY+bQhdo9F4e70np1a8BMy6MZUxMzkr/tzy2Heyhlklc5daQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711976670; c=relaxed/simple;
	bh=WOf1t5/kLTuMP0vqmrlw4HwW7o7C0/4Q8Dfs/g7PJ5I=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Pm0mx/RlDTL9/zpsAG2BiXSjNCplb/hXURPQmYMg4bmlWnznsk1VAmz/PvyKQtz4lolhSvdSNIupQRNMb+Cw+LaEX7CuknertFxEZ6Cw7/VAOb9k/R8qn20dl2mMo3S9uAL/jhf6wO9//nL+BYJ9rqi4GcP3hawHd3CQE5pMZlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.63
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.88.49.36])
	by sina.com (10.75.12.45) with ESMTP
	id 660AB0A800007332; Mon, 1 Apr 2024 21:03:42 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 55674131457705
X-SMAIL-UIID: 6CF2D06D852B4E73966546F7E98388BD-20240401-210342-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
Date: Mon,  1 Apr 2024 21:03:28 +0800
Message-Id: <20240401130328.3529-1-hdanton@sina.com>
In-Reply-To: <00000000000022c6b2061502dcbb@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Sun, 31 Mar 2024 23:11:27 -0700
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    480e035fc4c7 Merge tag 'drm-next-2024-03-13' of https://gi..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=15e0f5c3180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  480e035fc4c7

--- x/net/hsr/hsr_device.c
+++ y/net/hsr/hsr_device.c
@@ -226,9 +226,11 @@ static netdev_tx_t hsr_dev_xmit(struct s
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
+		local_bh_disable();
+		spin_lock_nested(&hsr->seqnr_lock, 1);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
+		spin_unlock(&hsr->seqnr_lock);
+		local_bh_enable();
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
--

