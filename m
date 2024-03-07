Return-Path: <linux-kernel+bounces-95852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95062875415
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:19:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C766B1C2130C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CA212FB12;
	Thu,  7 Mar 2024 16:19:17 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5684812F5AE;
	Thu,  7 Mar 2024 16:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709828357; cv=none; b=u0xkZ8GmSuKD3coqisYdjuuRwQMr9vtEQs5wvo1a0CDSD1HOIjXVOep6A8ec4UXWVpsBkNf+9MJ3DKG6+faYZc+mfOMQeKfkzcX4uxoVEGKCNqny3pnS86ePPOFdZ+9im2uUOn/JldZpGIt1HFrBfBEOGizMm1BHdN3T/dx2+GY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709828357; c=relaxed/simple;
	bh=wkiTOsXoIX4LFXBExDAi0YiMCiTavv3BcfFKVDYFrbA=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Tdi0s/ztDRBnYGa9s3P5+uYkyKeJvee+r1jSE6MMUktSjVujwSmkVcYhnqRuxwI6GWMpe3RCWPHrmcLBMrlWrtg82sUFPrqJSFb+B4N0DDq6FSaw3HzlHbzKRQkNeh6UJ+Ufj+VBZyMkTV0Iz82R2T1cawQ042SwKoOCnxwg2jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id A9789520363;
	Thu,  7 Mar 2024 17:19:03 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 17:19:03 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: <gregkh@linuxfoundation.org>, <quic_kriskura@quicinc.com>,
	<maze@google.com>, <quic_linyyuan@quicinc.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<guofeng.li@gm.com>, <hardik.gajjar@bosch.com>, <eugeniu.rosca@bosch.com>
Subject: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of invalid gadget ptr
Date: Thu, 7 Mar 2024 17:18:49 +0100
Message-ID: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

In the scenario where the system enters suspend to RAM mode (STR) triggers
the disconnection of Dual Role USB Hub, and the UDC platform driver calls
usb_del_gadget_udc() to cleanup and delete the associated gadget.

However, at this point, the usb0 interface is not yet deleted, leading to
a race condition with the TCP/IP stack attempting to access the network
device parent (gadget pointer), through operations like the GETLINK net
message.

This patch addresses the issue by clearing the netdevice's parent device
pointer when the ncm unbinds, effectively preventing the race condition
during this critical phase.

Followinfg is the backtrace of such race condition
[ 3566.105792] Call trace:
[ 3566.105984] if_nlmsg_size+0x48/0x3b0
[ 3566.107497] rtnetlink_rcv_msg+0x1cc/0x408
[ 3566.107905] netlink_rcv_skb+0x12c/0x164
[ 3566.108264] rtnetlink_rcv+0x18/0x24
[ 3566.108851] netlink_unicast_kernel+0xc4/0x14c
[ 3566.109192] netlink_unicast+0x210/0x2b0
[ 3566.109606] netlink_sendmsg+0x2ec/0x360
[ 3566.110046] __sys_sendto+0x1b8/0x25c
[ 3566.111594] __arm64_sys_sendto+0x28/0x38
[ 3566.112599] el0_svc_common+0xb4/0x19c
[ 3566.112978] el0_svc_handler+0x74/0x98
[ 3566.113269] el0_svc+0x8/0xc

- code: if_nlmsg_size call the following function

static inline int rtnl_vfinfo_size(const struct net_device *dev,
				   u32 ext_filter_mask)
{
	// dev->dev.parent is not NULL
	if (dev->dev.parent && (ext_filter_mask & RTEXT_FILTER_VF)) {
		// dev_num_vf use the dev->dev.parent->bus lead to kernel panic.
		int num_vfs = dev_num_vf(dev->dev.parent);
		size_t size = nla_total_size(0);
		size += num_vfs *
			(nla_total_size(0) +
			 nla_total_size(sizeof(struct ifla_vf_mac)) +
			 nla_total_size(sizeof(struct ifla_vf_vlan)) +
			 nla_total_size(0) + /* nest IFLA_VF_VLAN_LIST *

Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
---
 drivers/usb/gadget/function/f_ncm.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
index e2a059cfda2c..fdfb5b3460c7 100644
--- a/drivers/usb/gadget/function/f_ncm.c
+++ b/drivers/usb/gadget/function/f_ncm.c
@@ -1728,9 +1728,12 @@ static void ncm_free(struct usb_function *f)
 static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 {
 	struct f_ncm *ncm = func_to_ncm(f);
+	struct f_ncm_opts   *ncm_opts;
 
 	DBG(c->cdev, "ncm unbind\n");
 
+	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
+
 	hrtimer_cancel(&ncm->task_timer);
 
 	kfree(f->os_desc_table);
@@ -1746,6 +1749,10 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
 
 	kfree(ncm->notify_req->buf);
 	usb_ep_free_request(ncm->notify, ncm->notify_req);
+
+	mutex_lock(&ncm_opts->lock);
+	SET_NETDEV_DEV(ncm_opts->net, NULL);
+	mutex_unlock(&ncm_opts->lock);
 }
 
 static struct usb_function *ncm_alloc(struct usb_function_instance *fi)
-- 
2.17.1


