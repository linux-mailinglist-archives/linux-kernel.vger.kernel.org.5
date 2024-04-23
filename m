Return-Path: <linux-kernel+bounces-154888-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE9C8AE281
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:43:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 087FF1C21A61
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 10:43:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4DD56311D;
	Tue, 23 Apr 2024 10:43:19 +0000 (UTC)
Received: from mail115-95.sinamail.sina.com.cn (mail115-95.sinamail.sina.com.cn [218.30.115.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E22B54BE7
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 10:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=218.30.115.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713868999; cv=none; b=A9Sou23oa9oOQUiCa5AoQj3J9Vgh71oywvnrl506HOJH7K8fGrL6r+guuI7VgQcpdjKgQtC/i0rsANTpS52BGqpRzQf3qwHp2TxETThagrKShLQEfpO9SvlCfRoftoZKbS3oK2eFwb5Ey7giXYksIpAdP8sraWsPFxwXhN7Ty8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713868999; c=relaxed/simple;
	bh=uKd01BIu/Go5FLXZOeKXWFa9K6xpO1dWhn7pnKocbYE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WpiPBSZ8k1OGrPf+t1U3fnZEpBLLrggLwbI8JrWuQVMMazIUk6VPB0h+NAH4pzMkq77x7WHsclKD+u+InoGPxFHEoMtmmQVvbzgqJzxhM9ZQoxPPWIa49xfBUYiddDNz/d+erHdGp8SzqElFNwM41KHG+tGewCofa5ONmdB4yhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com; spf=pass smtp.mailfrom=sina.com; arc=none smtp.client-ip=218.30.115.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sina.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sina.com
X-SMAIL-HELO: localhost.localdomain
Received: from unknown (HELO localhost.localdomain)([113.118.69.188])
	by sina.com (172.16.235.24) with ESMTP
	id 6627909700000DB7; Tue, 23 Apr 2024 18:42:33 +0800 (CST)
X-Sender: hdanton@sina.com
X-Auth-ID: hdanton@sina.com
Authentication-Results: sina.com;
	 spf=none smtp.mailfrom=hdanton@sina.com;
	 dkim=none header.i=none;
	 dmarc=none action=none header.from=hdanton@sina.com
X-SMAIL-MID: 95549345089283
X-SMAIL-UIID: 9FED4A761A0840E3B80B1FD9FFC93A17-20240423-184233-1
From: Hillf Danton <hdanton@sina.com>
To: syzbot <syzbot+6cf5652d3df49fae2e3f@syzkaller.appspotmail.com>
Cc: linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [pm?] KASAN: use-after-free Read in netdev_unregister_kobject
Date: Tue, 23 Apr 2024 18:42:32 +0800
Message-Id: <20240423104232.2984-1-hdanton@sina.com>
In-Reply-To: <000000000000afab690616b12f99@google.com>
References: 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Mon, 22 Apr 2024 08:35:25 -0700
> syzbot found the following issue on:
> 
> HEAD commit:    3cdb45594619 Merge tag 's390-6.9-4' of git://git.kernel.or..
> git tree:       upstream
> C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=144067cb180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git  3cdb45594619

--- x/net/bluetooth/bnep/core.c
+++ y/net/bluetooth/bnep/core.c
@@ -535,6 +535,7 @@ static int bnep_session(void *arg)
 	__bnep_unlink_session(s);
 
 	up_write(&bnep_session_sem);
+	put_device(dev->dev.parent);
 	free_netdev(dev);
 	module_put_and_kthread_exit(0);
 	return 0;
@@ -618,7 +619,7 @@ int bnep_add_connection(struct bnep_conn
 	bnep_set_default_proto_filter(s);
 #endif
 
-	SET_NETDEV_DEV(dev, bnep_get_device(s));
+	SET_NETDEV_DEV(dev, get_device(bnep_get_device(s)));
 	SET_NETDEV_DEVTYPE(dev, &bnep_type);
 
 	err = register_netdev(dev);
--

