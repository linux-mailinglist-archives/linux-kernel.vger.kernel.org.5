Return-Path: <linux-kernel+bounces-95952-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0943D875549
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC701F23ECB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:34:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E8B2131752;
	Thu,  7 Mar 2024 17:33:44 +0000 (UTC)
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1836B130AC4;
	Thu,  7 Mar 2024 17:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=93.241.18.167
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709832824; cv=none; b=ZRnoPGh7crU69lS29UVJ1fdO8pycTV2SXlq5DtsCeQK6ssiZr+p4EiN2o6yLpnu8U+8QkPzjWAlPK1SyMs+/I5kjqC79XK3nMLdYkKVr2HFgNm36ZQl4P6DensNu+PSj3ppyWOqMkJYVaopN6oHGd9Eld0JZmQCACGyOCH6j7e0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709832824; c=relaxed/simple;
	bh=AOxseAzx/mhHRMcaW+02RE9BF5vJ6cOgE9bQGk0LgG4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZaQH2Oc5sUo/nXveInp3ok1FY7I+CoEqIAlvHRffthtgQzKcCKe7vcgS6aKVA1Qo55l8vmnQhhVsqEi3KmguXHxXI5DcWgFBCHWt7fc2av8b72IXBgaC8uGOFzch8Oqh3hGDYwD4IsGXGfuRTgkh/go4Bql7o+rrKYNy0vclDbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com; spf=pass smtp.mailfrom=de.adit-jv.com; arc=none smtp.client-ip=93.241.18.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=de.adit-jv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=de.adit-jv.com
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
	by hi1smtp01.de.adit-jv.com (Postfix) with ESMTP id E8252520369;
	Thu,  7 Mar 2024 18:33:37 +0100 (CET)
Received: from vmlxhi-118.adit-jv.com (10.72.93.77) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 7 Mar
 2024 18:33:37 +0100
Date: Thu, 7 Mar 2024 18:33:27 +0100
From: Hardik Gajjar <hgajjar@de.adit-jv.com>
To: Greg KH <gregkh@linuxfoundation.org>
CC: Hardik Gajjar <hgajjar@de.adit-jv.com>, <quic_kriskura@quicinc.com>,
	<maze@google.com>, <quic_linyyuan@quicinc.com>, <linux-usb@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <guofeng.li@gm.com>,
	<hardik.gajjar@bosch.com>, <eugeniu.rosca@bosch.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of
 invalid gadget ptr
Message-ID: <20240307173327.GA14716@vmlxhi-118.adit-jv.com>
References: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
 <2024030736-racism-cornflake-63e9@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <2024030736-racism-cornflake-63e9@gregkh>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)

On Thu, Mar 07, 2024 at 04:45:13PM +0000, Greg KH wrote:
> On Thu, Mar 07, 2024 at 05:18:49PM +0100, Hardik Gajjar wrote:
> > In the scenario where the system enters suspend to RAM mode (STR) triggers
> > the disconnection of Dual Role USB Hub, and the UDC platform driver calls
> > usb_del_gadget_udc() to cleanup and delete the associated gadget.
> > 
> > However, at this point, the usb0 interface is not yet deleted, leading to
> > a race condition with the TCP/IP stack attempting to access the network
> > device parent (gadget pointer), through operations like the GETLINK net
> > message.
> > 
> > This patch addresses the issue by clearing the netdevice's parent device
> > pointer when the ncm unbinds, effectively preventing the race condition
> > during this critical phase.
> > 
> > Followinfg is the backtrace of such race condition
> > [ 3566.105792] Call trace:
> > [ 3566.105984] if_nlmsg_size+0x48/0x3b0
> > [ 3566.107497] rtnetlink_rcv_msg+0x1cc/0x408
> > [ 3566.107905] netlink_rcv_skb+0x12c/0x164
> > [ 3566.108264] rtnetlink_rcv+0x18/0x24
> > [ 3566.108851] netlink_unicast_kernel+0xc4/0x14c
> > [ 3566.109192] netlink_unicast+0x210/0x2b0
> > [ 3566.109606] netlink_sendmsg+0x2ec/0x360
> > [ 3566.110046] __sys_sendto+0x1b8/0x25c
> > [ 3566.111594] __arm64_sys_sendto+0x28/0x38
> > [ 3566.112599] el0_svc_common+0xb4/0x19c
> > [ 3566.112978] el0_svc_handler+0x74/0x98
> > [ 3566.113269] el0_svc+0x8/0xc
> > 
> > - code: if_nlmsg_size call the following function
> > 
> > static inline int rtnl_vfinfo_size(const struct net_device *dev,
> > 				   u32 ext_filter_mask)
> > {
> > 	// dev->dev.parent is not NULL
> > 	if (dev->dev.parent && (ext_filter_mask & RTEXT_FILTER_VF)) {
> > 		// dev_num_vf use the dev->dev.parent->bus lead to kernel panic.
> > 		int num_vfs = dev_num_vf(dev->dev.parent);
> > 		size_t size = nla_total_size(0);
> > 		size += num_vfs *
> > 			(nla_total_size(0) +
> > 			 nla_total_size(sizeof(struct ifla_vf_mac)) +
> > 			 nla_total_size(sizeof(struct ifla_vf_vlan)) +
> > 			 nla_total_size(0) + /* nest IFLA_VF_VLAN_LIST *
> > 
> > Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> > ---
> >  drivers/usb/gadget/function/f_ncm.c | 7 +++++++
> >  1 file changed, 7 insertions(+)
> 
> What commit id does this fix?
> 
> thanks,
> 
> greg k-h

Hi Greg,

The network device parent is not being properly cleaned up during unbind since the initial commit of the driver.
In that case, should I mention the First commit ID of the driver as broken commit or
would you advice to say, For example "Clean up netdev parent in unbind".

Thanks,
Hardik

