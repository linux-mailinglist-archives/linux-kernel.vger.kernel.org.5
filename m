Return-Path: <linux-kernel+bounces-95879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1D7C87546C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3D9D1C22D99
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 16:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1440E12FF6E;
	Thu,  7 Mar 2024 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e3FRSlb8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 217627AE43;
	Thu,  7 Mar 2024 16:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709829916; cv=none; b=iYogCMliURU6ChtX3Po2JTAGIlxVHOvGwMWFEw5422jfodiWSHpih7bTijhYNDH9IT6X00S1/HCbNH1EMTG2jZL4oGgVzX+mIIn6IglImFFFgQbpEVDFYvUomRUptS3qAefLvp55x1ECnFKPDoBAHl2voVHfeGCRp9HmpL9nvTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709829916; c=relaxed/simple;
	bh=jxxknMt2uyiAxMDOvBrYg92hTC4bK3O5IyG3V1Kaq/c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NYa9xgdSG3ZMf2wqEG2/rHJPF4j91B/oIJ9KRSPAvCGejbfeVafopCQhJXkpfAPNX68Dku34a7i4h9EJKwuvXVMBjeAkeQk4udVNsD/PT5sspqeMsez/XZHWoI89wOD5GJ1UB6sfTCxaJIdtvAwSd5Gy3fj+TLtzTboeQeWvJOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e3FRSlb8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA4C433F1;
	Thu,  7 Mar 2024 16:45:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709829915;
	bh=jxxknMt2uyiAxMDOvBrYg92hTC4bK3O5IyG3V1Kaq/c=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e3FRSlb8M1qg21a1FOKSGlsVk/ZW7Ea+ktipGMWT2MGPoCYmAoSu0eEcQOHv7580v
	 gyLuzNXAzBpOgw58Fv8b3nq0c4AGUP6KzgFn9gaWI0VLIqJlWnXGbTD5PPCEQw8O3q
	 KUZXold7/UyL2smD4mZS/dVM2Q5mEKtqQg/g+h9k=
Date: Thu, 7 Mar 2024 16:45:13 +0000
From: Greg KH <gregkh@linuxfoundation.org>
To: Hardik Gajjar <hgajjar@de.adit-jv.com>
Cc: quic_kriskura@quicinc.com, maze@google.com, quic_linyyuan@quicinc.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	guofeng.li@gm.com, hardik.gajjar@bosch.com, eugeniu.rosca@bosch.com
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of
 invalid gadget ptr
Message-ID: <2024030736-racism-cornflake-63e9@gregkh>
References: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240307161849.9145-1-hgajjar@de.adit-jv.com>

On Thu, Mar 07, 2024 at 05:18:49PM +0100, Hardik Gajjar wrote:
> In the scenario where the system enters suspend to RAM mode (STR) triggers
> the disconnection of Dual Role USB Hub, and the UDC platform driver calls
> usb_del_gadget_udc() to cleanup and delete the associated gadget.
> 
> However, at this point, the usb0 interface is not yet deleted, leading to
> a race condition with the TCP/IP stack attempting to access the network
> device parent (gadget pointer), through operations like the GETLINK net
> message.
> 
> This patch addresses the issue by clearing the netdevice's parent device
> pointer when the ncm unbinds, effectively preventing the race condition
> during this critical phase.
> 
> Followinfg is the backtrace of such race condition
> [ 3566.105792] Call trace:
> [ 3566.105984] if_nlmsg_size+0x48/0x3b0
> [ 3566.107497] rtnetlink_rcv_msg+0x1cc/0x408
> [ 3566.107905] netlink_rcv_skb+0x12c/0x164
> [ 3566.108264] rtnetlink_rcv+0x18/0x24
> [ 3566.108851] netlink_unicast_kernel+0xc4/0x14c
> [ 3566.109192] netlink_unicast+0x210/0x2b0
> [ 3566.109606] netlink_sendmsg+0x2ec/0x360
> [ 3566.110046] __sys_sendto+0x1b8/0x25c
> [ 3566.111594] __arm64_sys_sendto+0x28/0x38
> [ 3566.112599] el0_svc_common+0xb4/0x19c
> [ 3566.112978] el0_svc_handler+0x74/0x98
> [ 3566.113269] el0_svc+0x8/0xc
> 
> - code: if_nlmsg_size call the following function
> 
> static inline int rtnl_vfinfo_size(const struct net_device *dev,
> 				   u32 ext_filter_mask)
> {
> 	// dev->dev.parent is not NULL
> 	if (dev->dev.parent && (ext_filter_mask & RTEXT_FILTER_VF)) {
> 		// dev_num_vf use the dev->dev.parent->bus lead to kernel panic.
> 		int num_vfs = dev_num_vf(dev->dev.parent);
> 		size_t size = nla_total_size(0);
> 		size += num_vfs *
> 			(nla_total_size(0) +
> 			 nla_total_size(sizeof(struct ifla_vf_mac)) +
> 			 nla_total_size(sizeof(struct ifla_vf_vlan)) +
> 			 nla_total_size(0) + /* nest IFLA_VF_VLAN_LIST *
> 
> Signed-off-by: Hardik Gajjar <hgajjar@de.adit-jv.com>
> ---
>  drivers/usb/gadget/function/f_ncm.c | 7 +++++++
>  1 file changed, 7 insertions(+)

What commit id does this fix?

thanks,

greg k-h

