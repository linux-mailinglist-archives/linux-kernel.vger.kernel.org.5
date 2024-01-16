Return-Path: <linux-kernel+bounces-27320-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16AA782EDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:35:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 252481C23287
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 11:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56FBF1B806;
	Tue, 16 Jan 2024 11:34:53 +0000 (UTC)
Received: from mail115-76.sinamail.sina.com.cn (mail115-76.sinamail.sina.com.cn [218.30.115.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5801B7F3
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 11:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (10.75.12.45) with ESMTP
	id 65A669CA00007314; Tue, 16 Jan 2024 19:34:37 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 35475331457846
X-SMAIL-UIID: 70886D29B86C41BA9E7105BCE90A56F4-20240116-193437-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
Date: Tue, 16 Jan 2024 19:34:26 +0800
Message-Id: <20240116113426.909-1-hdanton@sina.com>
In-Reply-To: <00000000000002faa2060f02e766@google.com>
References: <00000000000002faa2060f02e766@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 15 Jan 2024 13:43:20 -0800
> syzbot found the following issue on:
> 
> HEAD commit:    3e7aeb78ab01 Merge tag 'net-next-6.8' of git://git.kernel...
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12995b33e80000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  master

--- x/net/dsa/user.c
+++ y/net/dsa/user.c
@@ -2865,11 +2865,13 @@ static int dsa_user_changeupper(struct n
 static int dsa_user_prechangeupper(struct net_device *dev,
 				   struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_port *dp;
 
 	if (!dsa_user_dev_check(dev))
 		return NOTIFY_DONE;
 
+	dp = dsa_user_to_port(dev);
+
 	if (netif_is_bridge_master(info->upper_dev) && !info->linking)
 		dsa_port_pre_bridge_leave(dp, info->upper_dev);
 	else if (netif_is_lag_master(info->upper_dev) && !info->linking)
--

