Return-Path: <linux-kernel+bounces-103114-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AD84E87BB31
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 11:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D149B1C21263
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 10:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587E16EB44;
	Thu, 14 Mar 2024 10:23:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="l8x5zZk4"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7820C6BB37;
	Thu, 14 Mar 2024 10:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710411814; cv=none; b=jaG0c94kl0DCf6LLBWn4NVUebOmNPAIGJlFlhq8Ot2LL3M2uJV7V5tCDp+4sfyuklc0Pq2fXi7fCrtQb28ZEh5O4SlG6fTTmvMSH94+KGz7Z7aqVkOeR7+ysIbbgnTY4NBoMqp7ArCgxPXGnW4mkjYfJVosDwwm/1YeJpbnjnfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710411814; c=relaxed/simple;
	bh=5wPDrmN6cu9x1bCdqz8DXqPYL7YSUk8hpryHCstTnFE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZhiOtYu+ogjp9LJfl8/DXZ8S+pQfgG3rQA3Ttykxp4JGAUW81iyeqKJMHRxQ3Q5jT3JYj/H5/QA/V3FYLB8qYRRKnb5P9FdboxUs5+eOWbL64OwjdLfRgsDJBjCnRr4Tfh1v+r1JtrR3AGEpH4/wMtwJpYbsfsyyDnJ9Dcn3bA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=l8x5zZk4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42EA0iog015160;
	Thu, 14 Mar 2024 10:23:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=DvBNskAxLoqsqCG/2Fpkv5K9t8pITrKn7B68jbgbvJA=;
 b=l8x5zZk4dhZ0LjQxoItFIqEuh/MkekY27DJfHxrQjugLvzTckln7X73nwYLdNXu0+6ec
 zcp1BaeIO6B15I89VZFnP7ZKETn1ennz8qSk1+lWia3mIGCztpA0IiJ/5DPk6Wot6v2E
 8nm4v1KkvrbV3sdOCVoUDLKxFdGRfrxacxF5f8BkMr5ANGGYUXgdAQvyiabHwHIxWYtH
 Xj9LxD5bd4tNUub2BDpOfQJh8mwidUzjWBiEMG4DmfGNMy1pJoKHhH/FtQdzZiTyuITk
 F/shOlfFu3xAvJ541cQjgitiToO9Y4UL4B3VjMBXmZP3ehkDMO54DY0Z7vWvpfz/xNbg lA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuxm60rc1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:23:21 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42EALrk0005638;
	Thu, 14 Mar 2024 10:23:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wuxm60rba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:23:20 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42E8DgOL013484;
	Thu, 14 Mar 2024 10:23:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ws4akkwdg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 14 Mar 2024 10:23:19 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42EANE1U32768488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Mar 2024 10:23:16 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AE7520043;
	Thu, 14 Mar 2024 10:23:14 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1285B20040;
	Thu, 14 Mar 2024 10:23:13 +0000 (GMT)
Received: from [9.171.77.106] (unknown [9.171.77.106])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 14 Mar 2024 10:23:12 +0000 (GMT)
Message-ID: <caab067b-f5c3-490f-9259-262624c236b4@linux.ibm.com>
Date: Thu, 14 Mar 2024 11:23:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 01/11] net/smc: adapt SMC-D device dump for
 Emulated-ISM
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240312142743.41406-1-guwen@linux.alibaba.com>
 <20240312142743.41406-2-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240312142743.41406-2-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: gbaUvl_hnFnGnA-Ov_FXC1VTTPGNJdyR
X-Proofpoint-ORIG-GUID: rXYW3pWjXFS85FSH9KC0bLPqfaVQG4Z1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-14_08,2024-03-13_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 impostorscore=0 priorityscore=1501 spamscore=0 malwarescore=0
 mlxlogscore=999 bulkscore=0 suspectscore=0 adultscore=0 phishscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403140073



On 12/03/2024 15:27, Wen Gu wrote:
> The introduction of Emulated-ISM requires adaptation of SMC-D device
> dump. Software implemented non-PCI device (loopback-ism) should be
> handled correctly and the CHID reserved for Emulated-ISM should be got
> from smcd_ops interface instead of PCI information.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_ism.c | 13 ++++++++++---
>   1 file changed, 10 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
> index ac88de2a06a0..b6eca4231913 100644
> --- a/net/smc/smc_ism.c
> +++ b/net/smc/smc_ism.c
> @@ -252,12 +252,11 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>   	char smc_pnet[SMC_MAX_PNETID_LEN + 1];
>   	struct smc_pci_dev smc_pci_dev;
>   	struct nlattr *port_attrs;
> +	struct device *device;
>   	struct nlattr *attrs;
> -	struct ism_dev *ism;
>   	int use_cnt = 0;
>   	void *nlh;
>   
> -	ism = smcd->priv;
>   	nlh = genlmsg_put(skb, NETLINK_CB(cb->skb).portid, cb->nlh->nlmsg_seq,
>   			  &smc_gen_nl_family, NLM_F_MULTI,
>   			  SMC_NETLINK_GET_DEV_SMCD);
> @@ -272,7 +271,15 @@ static int smc_nl_handle_smcd_dev(struct smcd_dev *smcd,
>   	if (nla_put_u8(skb, SMC_NLA_DEV_IS_CRIT, use_cnt > 0))
>   		goto errattr;
>   	memset(&smc_pci_dev, 0, sizeof(smc_pci_dev));
> -	smc_set_pci_values(to_pci_dev(ism->dev.parent), &smc_pci_dev);
> +	device = smcd->ops->get_dev(smcd);
> +	if (device->parent)
> +		smc_set_pci_values(to_pci_dev(device->parent), &smc_pci_dev);
> +	if (smc_ism_is_emulated(smcd)) {
> +		smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
> +		if (!device->parent)
> +			snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
> +				 "%s", dev_name(device));
> +	}

Hi Wen Gu,

playing around with the loopback-ism device and testing it, i developed 
some concerns regarding this exposure. Basically this enables us to see 
the loopback device in the `smcd device` tool without any changes.
E.g.:
```
# smcd device
FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
0000 0     loopback-ism  ffff   No        0
102a ISM   0000:00:00.0  07c2   No        0  NET1
```

Now the problem with this is that "loopback-ism" is no valid PCI-ID and 
should not be there. My first thought was to put an "n/a" instead, but 
that opens up another problem. Currently you could set - even if it does 
not make sense - a PNET_ID for the loopback device:
```
# smc_pnet -a -D loopback-ism NET1
# smcd device
FID  Type  PCI-ID        PCHID  InUse  #LGs  PNET-ID
0000 0     loopback-ism  ffff   No        0  *NET1
102a ISM   0000:00:00.0  07c2   No        0  NET1
```
If we would change the PCI-ID to "n/a" it would be a valid input 
parameter for the tooling which is... to put it nice... not so beautiful.
I brainstormed this with them team and the problem is more complex.
In theory there shouldn't be PCI information set for the loopback 
device. There should be a better abstraction in the netlink interface 
that creates this output and the tooling should be made aware of it.

Do you rely on the output currently? What are your thoughts about it?
If not I'd ask you to not fill the netlink interface for the loopback 
device and refactor it with the next stage when we create a right 
interface for it.

Since the Merge-Window is closed feel free to send new versions as RFC.
Thank you
- Jan

>   	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>   		goto errattr;
>   	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))

