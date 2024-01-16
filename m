Return-Path: <linux-kernel+bounces-27383-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B8DE782EF16
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 13:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 48F27B20E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 12:34:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF231BC2C;
	Tue, 16 Jan 2024 12:34:20 +0000 (UTC)
Received: from mail114-241.sinamail.sina.com.cn (mail114-241.sinamail.sina.com.cn [218.30.114.241])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A481B295
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 12:34:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.65.196])
	by sina.com (172.16.235.24) with ESMTP
	id 65A67792000039E6; Tue, 16 Jan 2024 20:33:26 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 29234045089295
X-SMAIL-UIID: 77F30B6FDDA24C0E85023F9AC2B55923-20240116-203326-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+7ec955e36bb239bd720f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in dsa_user_prechangeupper
Date: Tue, 16 Jan 2024 20:33:14 +0800
Message-Id: <20240116123314.970-1-hdanton@sina.com>
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
@@ -2806,13 +2806,14 @@ EXPORT_SYMBOL_GPL(dsa_user_dev_check);
 static int dsa_user_changeupper(struct net_device *dev,
 				struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
+	struct dsa_port *dp;
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
 
 	if (!dsa_user_dev_check(dev))
 		return err;
 
+	dp = dsa_user_to_port(dev);
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	if (netif_is_bridge_master(info->upper_dev)) {
@@ -2865,11 +2866,13 @@ static int dsa_user_changeupper(struct n
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

