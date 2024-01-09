Return-Path: <linux-kernel+bounces-21316-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 43BA6828D76
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:33:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63D48B24FCB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 19:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EF03D54E;
	Tue,  9 Jan 2024 19:33:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsUVHAPy"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6B543D3B6;
	Tue,  9 Jan 2024 19:33:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40d4f5d902dso35231155e9.2;
        Tue, 09 Jan 2024 11:33:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704828787; x=1705433587; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=g1G0A/YfTYiLiKWGTkj6aPS5hgGaKzLW8glmoI95kh0=;
        b=IsUVHAPyU0rHFAU0a/NedvxGrZ73jV0mnEZWQ7tityNGyYuGIvblXxo31HplA0QTBp
         TIyR0GWJDKZpMxcEiNZVEMluWTkpICylSN+l/pskKGV4vqytISaETjFHsrgq/kpy6zCf
         KfjlfL7p/t/MYOIT1x50+KNJluYPhLwdNI81ykHKaZQGp1f4PV48lfaNGxeQy4M9+ZX/
         ZDT0cb8lc7Fdz8vn6i1YB4mvpJXxUwZ57WRzWz/sppWjI7g6iiebrkqcVoP7auIwZojX
         BgEE2L8VhrLgPYoHwGoeCB9y1kA2GxuUxcSgjsomixKPhQAJmIohv/ymaxbY16J+V7I0
         JzXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704828787; x=1705433587;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=g1G0A/YfTYiLiKWGTkj6aPS5hgGaKzLW8glmoI95kh0=;
        b=VkzTxdjl93ECOb5Jt1I7X9qc4pj3YDWaNvkbidzXHKv+hobOQV2PMTn/2JnvhT2avt
         6xn0DPPF/VDOUzi3aIBFrd57+B7FEGV2Lr3YbavBMqCRohOBjw7SZnSsySRK/+TSRN3y
         QZWFR1rM0NtmlMhZMhJGRG3z7Z8JMlvcLAD/1Uyfh6QtwnOf2FTTY0mQJXG5BF8xdMAZ
         VcB4khKEbC9yplZHnYkiqWf17BsvW0s29euXhe3LVo9d/iWMKAfFjDsF1N5xVczQo1vD
         SK7SpUlrBf3K1+EoN5+8PUjMzc/DRK6ZzOPm5Vc/2i7qxHdO+TRp4JD7IYQHr8hi4dK0
         wDQA==
X-Gm-Message-State: AOJu0YxF1D6js5TMNVf28YmozLpVfz7c49awKabLdW6NbCFG9qcNXeiZ
	92XSiNpsF1rYSSG+8VU3XgM=
X-Google-Smtp-Source: AGHT+IHzb0Cdi0RtZRejV72faIzrL4gTbpcOak1BZQAlkEev25hj6tXe8F0uEw8qio0fBgdIr4j9ug==
X-Received: by 2002:a05:600c:3c84:b0:40d:609d:d65e with SMTP id bg4-20020a05600c3c8400b0040d609dd65emr2932367wmb.177.1704828786833;
        Tue, 09 Jan 2024 11:33:06 -0800 (PST)
Received: from skbuf ([188.25.255.36])
        by smtp.gmail.com with ESMTPSA id c4-20020a05600c0a4400b0040e39cbf2a4sm15628352wmq.42.2024.01.09.11.33.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jan 2024 11:33:06 -0800 (PST)
Date: Tue, 9 Jan 2024 21:33:04 +0200
From: Vladimir Oltean <olteanv@gmail.com>
To: syzbot <syzbot+d81bcd883824180500c8@syzkaller.appspotmail.com>
Cc: andrew@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
	edumazet@google.com, f.fainelli@gmail.com, kuba@kernel.org,
	linux-kernel@vger.kernel.org, lixiaoyan@google.com,
	netdev@vger.kernel.org, pabeni@redhat.com,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [net?] KASAN: slab-out-of-bounds Read in
 dsa_user_changeupper
Message-ID: <20240109193304.7pc27uzwm5dtudk6@skbuf>
References: <0000000000001d4255060e87545c@google.com>
 <0000000000001d4255060e87545c@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dyerce6ewzunaw5i"
Content-Disposition: inline
In-Reply-To: <0000000000001d4255060e87545c@google.com>
 <0000000000001d4255060e87545c@google.com>


--dyerce6ewzunaw5i
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jan 09, 2024 at 10:17:34AM -0800, syzbot wrote:
> ==================================================================
> BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
> BUG: KASAN: slab-out-of-bounds in dsa_user_changeupper+0x61a/0x6e0 net/dsa/user.c:2809
> Read of size 8 at addr ffff888015ebecf0 by task syz-executor278/5066
> 
> CPU: 1 PID: 5066 Comm: syz-executor278 Not tainted 6.7.0-rc6-syzkaller-01740-g9fb3dc1e9af2 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 11/17/2023
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xd9/0x1b0 lib/dump_stack.c:106
>  print_address_description mm/kasan/report.c:364 [inline]
>  print_report+0xc4/0x620 mm/kasan/report.c:475
>  kasan_report+0xda/0x110 mm/kasan/report.c:588
>  dsa_user_to_port net/dsa/user.h:58 [inline]
>  dsa_user_changeupper+0x61a/0x6e0 net/dsa/user.c:2809
>  dsa_user_netdevice_event+0xd04/0x3480 net/dsa/user.c:3345
>  notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
>  call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1967
>  __netdev_upper_dev_link+0x439/0x850 net/core/dev.c:7760
>  netdev_upper_dev_link+0x92/0xc0 net/core/dev.c:7801
>  register_vlan_dev+0x396/0x940 net/8021q/vlan.c:183
>  register_vlan_device net/8021q/vlan.c:277 [inline]
>  vlan_ioctl_handler+0x8dd/0xa70 net/8021q/vlan.c:621
>  sock_ioctl+0x4bd/0x6b0 net/socket.c:1303

#syz test

--dyerce6ewzunaw5i
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-net-dsa-fix-bad-dsa_user_to_port-calls-on-non-DSA-ne.patch"

From e3b8e714f152a8fbdc72d501d3839a6350be70a0 Mon Sep 17 00:00:00 2001
From: Vladimir Oltean <vladimir.oltean@nxp.com>
Date: Tue, 9 Jan 2024 20:51:57 +0200
Subject: [PATCH] net: dsa: fix bad dsa_user_to_port() calls on non-DSA
 netdevice events

After the blamed commit, we started doing this dereference for every
NETDEV_CHANGEUPPER and NETDEV_PRECHANGEUPPER in the system.

static inline struct dsa_port *dsa_user_to_port(const struct net_device *dev)
{
	struct dsa_user_priv *p = netdev_priv(dev);

	return p->dp;
}

Syzbot unfairly blames this on commit 43a71cd66b9c ("net-device:
reorganize net_device fast path variables"), which probably changed
sizeof(struct net_device), vaguely relevant below.

static inline void *netdev_priv(const struct net_device *dev)
{
	return (char *)dev + ALIGN(sizeof(struct net_device), NETDEV_ALIGN);
}

What we see now is:

BUG: KASAN: slab-out-of-bounds in dsa_user_to_port net/dsa/user.h:58 [inline]
BUG: KASAN: slab-out-of-bounds in dsa_user_changeupper+0x61a/0x6e0 net/dsa/user.c:2809
Read of size 8 at addr ffff888015ebecf0 by task syz-executor278/5066

Call Trace:
 kasan_report+0xda/0x110 mm/kasan/report.c:588
 dsa_user_to_port net/dsa/user.h:58 [inline]
 dsa_user_changeupper+0x61a/0x6e0 net/dsa/user.c:2809
 dsa_user_netdevice_event+0xd04/0x3480 net/dsa/user.c:3345
 notifier_call_chain+0xb6/0x3b0 kernel/notifier.c:93
 call_netdevice_notifiers_info+0xbe/0x130 net/core/dev.c:1967
 __netdev_upper_dev_link+0x439/0x850 net/core/dev.c:7760
 netdev_upper_dev_link+0x92/0xc0 net/core/dev.c:7801
 register_vlan_dev+0x396/0x940 net/8021q/vlan.c:183
 register_vlan_device net/8021q/vlan.c:277 [inline]
 vlan_ioctl_handler+0x8dd/0xa70 net/8021q/vlan.c:621
 sock_ioctl+0x4bd/0x6b0 net/socket.c:1303

Full analysis of why we're seeing this just now is pending.

Fixes: 4c3f80d22b2e ("net: dsa: walk through all changeupper notifier functions")
Signed-off-by: Vladimir Oltean <vladimir.oltean@nxp.com>
---
 net/dsa/user.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/dsa/user.c b/net/dsa/user.c
index b738a466e2dc..b15e71cc342c 100644
--- a/net/dsa/user.c
+++ b/net/dsa/user.c
@@ -2806,13 +2806,14 @@ EXPORT_SYMBOL_GPL(dsa_user_dev_check);
 static int dsa_user_changeupper(struct net_device *dev,
 				struct netdev_notifier_changeupper_info *info)
 {
-	struct dsa_port *dp = dsa_user_to_port(dev);
 	struct netlink_ext_ack *extack;
 	int err = NOTIFY_DONE;
+	struct dsa_port *dp;
 
 	if (!dsa_user_dev_check(dev))
 		return err;
 
+	dp = dsa_user_to_port(dev);
 	extack = netdev_notifier_info_to_extack(&info->info);
 
 	if (netif_is_bridge_master(info->upper_dev)) {
@@ -2865,11 +2866,13 @@ static int dsa_user_changeupper(struct net_device *dev,
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
2.34.1


--dyerce6ewzunaw5i--

