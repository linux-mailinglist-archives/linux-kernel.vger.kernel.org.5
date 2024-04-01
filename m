Return-Path: <linux-kernel+bounces-127147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E603A894771
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 00:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23DBA1C21EB8
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Apr 2024 22:44:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3C1255C3B;
	Mon,  1 Apr 2024 22:44:45 +0000 (UTC)
Received: from mail78-58.sinamail.sina.com.cn (mail78-58.sinamail.sina.com.cn [219.142.78.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB568F6F
	for <linux-kernel@vger.kernel.org>; Mon,  1 Apr 2024 22:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=219.142.78.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712011485; cv=none; b=PoqpI5jWgL/uvKv59nW7xjZMTOmOJ72m5KlttY8xcqDcvqJ4y1XJZo+deJpC9dcL1mfgOCNwDLGozC/E++oUWbZPGzt2EjoFsg+ZzHySaeQBsSlEAxXCrnt8CZ4CrvY7blBtYH9/CCEd06RP58C0GsHFlVbJ001ph7k+hzqxyqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712011485; c=relaxed/simple;
	bh=BN41TiMUof/vzEn8Zcps2uobhDyLps0occ8y/R4YGKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TJtVizCf58IqCBN2mFU2qYgLGPUr8KBcvBE+QCecHI9hiWpyWJkdc2volXQhPNMxSEHrHbTTNehrqzKH1iZjKENqddWnX5Sh9z3RHDQfubdFiCyLjBQW57MXoC1u4qs7A9y7L0PNh6G5m5B27Nza6Wh5z3M+ppTgGSC9uDiybLw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=219.142.78.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([116.24.9.84])
	by sina.com (172.16.235.25) with ESMTP
	id 660B38CB00006A37; Mon, 2 Apr 2024 06:44:29 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 46685634210238
X-SMAIL-UIID: DD47F5E67B9F467E9D2D755F83738CA5-20240402-064429-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+fbf74291c3b7e753b481@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] possible deadlock in hsr_dev_xmit (2)
Date: Tue,  2 Apr 2024 06:44:17 +0800
Message-Id: <20240401224417.3584-1-hdanton@sina.com>
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
@@ -220,15 +220,19 @@ static netdev_tx_t hsr_dev_xmit(struct s
 {
 	struct hsr_priv *hsr = netdev_priv(dev);
 	struct hsr_port *master;
+	static int depth = 0;
 
 	master = hsr_port_get_hsr(hsr, HSR_PT_MASTER);
 	if (master) {
 		skb->dev = master->dev;
 		skb_reset_mac_header(skb);
 		skb_reset_mac_len(skb);
-		spin_lock_bh(&hsr->seqnr_lock);
+		local_bh_disable();
+		spin_lock_nested(&hsr->seqnr_lock, ++depth);
 		hsr_forward_skb(skb, master);
-		spin_unlock_bh(&hsr->seqnr_lock);
+		--depth;
+		spin_unlock(&hsr->seqnr_lock);
+		local_bh_enable();
 	} else {
 		dev_core_stats_tx_dropped_inc(dev);
 		dev_kfree_skb_any(skb);
--

