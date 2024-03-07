Return-Path: <linux-kernel+bounces-95966-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2463B875567
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 18:42:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A52081F252D4
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 17:42:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DD7D13172E;
	Thu,  7 Mar 2024 17:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JAySESgK"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB96130E37;
	Thu,  7 Mar 2024 17:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833351; cv=none; b=fN1F9lEaYXYOCMPvO2HJQKygwzVOyT4Bam7giEEpSnj5Wy7AeBwT9pHRcirK3bijLh46BDsajFmcQRor2aVQbDCa0ny1jNJyS0ggOLFe2gQprrilygqUmgExJpuy0bMZjUWmry/2U6q7rXV5X7ADFuImLafAQXuynqFhm2hLUJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833351; c=relaxed/simple;
	bh=rcS6Qb1iAdmoaUDsY1AkppY6xcP3J+F7UT1lTvJnAsQ=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:CC:References:
	 In-Reply-To:Content-Type; b=hZiw0g0tJjXplPDvqarZ9J37QZiezqvrdnguJCoSI+QjvnCl0QQ3fLcXMWNZmnhlSvlhqO/ed7/60mXnEM76Y64gaHf4j3KHD2M4+jKw4UTrCI33YjxrvYNUxd0zD6IFTZFfPsED3tCqXQ7pwU+n/QDPz8gGwjhyhX5gXuMc2Rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JAySESgK; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 427BqWb0007131;
	Thu, 7 Mar 2024 17:42:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:from:subject:to:cc:references
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=6tytZN+Jvas8ICYoVjV57LGv3E3MfEwt8PMUekDlsOU=; b=JA
	ySESgKUT9Y+t0woRXQC0FN0gsmBkj34ps1UAGXiHT8KLfpOzceag9du6ZA/7pLsb
	EFxhJ7FI6Mu1CJ/p8wfZVAInTtwk/mH+SddUYd7Oey1PnL+JW0e+HLBcvsyris2w
	7L4eoRcqK1rJFF47QmlQ7YsjH1CyoCrEa8Md/8L51Lrvflw0L0q0zxuTOGLs5/JF
	B6vUY5vOoqEjgXAkemWHlMqMhwFZGhs5l9ViIegXS4JgChilE81ghp95BuSSbD3o
	JBCsOcey8m1ypJZMMnV/n1fowO2d3C7uaTVS3yitWuzGtXY2rfXMPPxGLikX+gPs
	MKJuW/Rv02Jc7t+Fg6qg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wqd3d1e4d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 07 Mar 2024 17:42:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 427HgF6h017800
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 7 Mar 2024 17:42:15 GMT
Received: from [10.216.40.188] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Thu, 7 Mar
 2024 09:42:11 -0800
Message-ID: <8d116b78-9227-4e48-8d37-3a0cb0465dfd@quicinc.com>
Date: Thu, 7 Mar 2024 23:12:07 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH] usb: gadget: f_ncm: Fix Kernel Panic due to access of
 invalid gadget ptr
To: Hardik Gajjar <hgajjar@de.adit-jv.com>, <gregkh@linuxfoundation.org>,
        <maze@google.com>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <guofeng.li@gm.com>, <hardik.gajjar@bosch.com>,
        <eugeniu.rosca@bosch.com>
References: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
Content-Language: en-US
In-Reply-To: <20240307161849.9145-1-hgajjar@de.adit-jv.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: nAAxPz4vFHtFXojGMdWl9T0sHR8G-dlV
X-Proofpoint-GUID: nAAxPz4vFHtFXojGMdWl9T0sHR8G-dlV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-07_14,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxscore=0 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 impostorscore=0 lowpriorityscore=0 mlxlogscore=812 classifier=spam
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2402120000
 definitions=main-2403070121


On 3/7/2024 9:48 PM, Hardik Gajjar wrote:
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

Hi Hardik,

  Would this the case be same with other network functions as well ? I 
see that for all gadget functions, the network interface exists although 
the unbind is done and deleted only upon function instance removal. 
Should we move the gether_cleanup at unbind as a reverse operation of 
what we do on first bind ? If we do so, I think this current problem too 
would be gone.

Greg, if you have idea why we don't destroy the network interface upon 
unbind and keep it till the lifetime of the function instance, can you 
help with that info. I was trying to see if we can move the 
gether_cleanup call to unbind, but I don't know why it was kept in 
free_inst to begin with, so I didn't touch that part of code so far.

Regards,
Krishna,

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
>   drivers/usb/gadget/function/f_ncm.c | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/usb/gadget/function/f_ncm.c b/drivers/usb/gadget/function/f_ncm.c
> index e2a059cfda2c..fdfb5b3460c7 100644
> --- a/drivers/usb/gadget/function/f_ncm.c
> +++ b/drivers/usb/gadget/function/f_ncm.c
> @@ -1728,9 +1728,12 @@ static void ncm_free(struct usb_function *f)
>   static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
>   {
>   	struct f_ncm *ncm = func_to_ncm(f);
> +	struct f_ncm_opts   *ncm_opts;
>   
>   	DBG(c->cdev, "ncm unbind\n");
>   
> +	ncm_opts = container_of(f->fi, struct f_ncm_opts, func_inst);
> +
>   	hrtimer_cancel(&ncm->task_timer);
>   
>   	kfree(f->os_desc_table);
> @@ -1746,6 +1749,10 @@ static void ncm_unbind(struct usb_configuration *c, struct usb_function *f)
>   
>   	kfree(ncm->notify_req->buf);
>   	usb_ep_free_request(ncm->notify, ncm->notify_req);
> +
> +	mutex_lock(&ncm_opts->lock);
> +	SET_NETDEV_DEV(ncm_opts->net, NULL);
> +	mutex_unlock(&ncm_opts->lock);
>   }
>   
>   static struct usb_function *ncm_alloc(struct usb_function_instance *fi)

