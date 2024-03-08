Return-Path: <linux-kernel+bounces-97002-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F46E87644A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 13:28:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 352A91C2094A
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Mar 2024 12:28:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD5758230;
	Fri,  8 Mar 2024 12:27:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="olGzKuYi"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FED356471;
	Fri,  8 Mar 2024 12:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709900865; cv=none; b=Sfncki26jUM3nMoZ3MTChrYETZpESjgIorSPrBLLUll7pxvEebo2tEVziVU8wwP4MaEXx1r3EBwoDmBay8GTuXqHuua65ZrYElXfmDrdY+hmy4CLkJPH+rKapGOiQUYL4JrMXXi9qY2yK234wsWZvviDyEXmwVOmir6dmFD7pbY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709900865; c=relaxed/simple;
	bh=AyRUTxsNJoM9LOy8UJHhBRiCqyKp80DQLBW2d/wGOZs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ObRbm+o4qxdCdQa9PyyrLjqgfPvS1xZGUVLqqxD1fty8ELge8pmPAVWrTOy/XwijHtnHMBklupgPV0H1+u/whMTLdcMQEf+zlPQ+fHVUGaWvW2EMcYLyLJg2zeADkpSZtTtrehv1mNR0o6ztrb0ttIygoc6hh3bQPLSP3qMU2zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=olGzKuYi; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 428CRCB3001286;
	Fri, 8 Mar 2024 12:27:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=Bgy1fX+6dw1ClAdXU+4b413uxRMLqPuTW1wqaunHWRM=;
 b=olGzKuYiUEbImq0ARiVLC6C7/gE8Xfce6Bd3xHmvWHOHMAPK9V0VnmrWMkkXa9us7lid
 y64VXvUUwUpVnaDAXXbaKAA/EVieJnT5Aqg7IAiIm+5R88wnEhbs9KhZox1JvZLCzzP1
 dRR1DFP/ZLJoimpLn2wkyvBfehrvLnHjL+E6hanNxaKx8lAUAJ+joSUg31QfB08RXMA9
 V+jPfxQD+HJElcOpG35cZ/aDFXqcQBU3NDJ5pKJnWnLCEPCaQIAO2uO2RmhhQcXojEYQ
 UjWAnyUSKBbqWVE9AAcuQM6vj6DKGBf+S35JZzFvpnbQSPh79srzv1C1C2FvIF8lEpPS bQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr2pjg06v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:27:41 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 428CRePT002527;
	Fri, 8 Mar 2024 12:27:40 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wr2pjg06n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:27:40 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 428AQ3Ww010913;
	Fri, 8 Mar 2024 12:27:39 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wmh52uvs8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 08 Mar 2024 12:27:39 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 428CRY2u12124466
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 8 Mar 2024 12:27:36 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EF4AE20043;
	Fri,  8 Mar 2024 12:27:33 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB84E20040;
	Fri,  8 Mar 2024 12:27:32 +0000 (GMT)
Received: from [9.171.69.10] (unknown [9.171.69.10])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri,  8 Mar 2024 12:27:32 +0000 (GMT)
Message-ID: <1cf8649c-1c09-4076-8910-071cf6b5ea21@linux.ibm.com>
Date: Fri, 8 Mar 2024 13:27:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 01/11] net/smc: adapt SMC-D device dump for
 Emulated-ISM
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
 <20240307095536.29648-2-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240307095536.29648-2-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 9zMPj-8IX7Gwl6KK6wUdRdt6FVN4-oH_
X-Proofpoint-ORIG-GUID: iAZyowTdH1LK8RNJUsNpaXOFPWek6t9Y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-08_08,2024-03-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 mlxlogscore=999 mlxscore=0 spamscore=0 phishscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 impostorscore=0 adultscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2403080099



On 07/03/2024 10:55, Wen Gu wrote:
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

net/smc/smc_ism.c: In function ‘smc_nl_handle_smcd_dev’:
net/smc/smc_ism.c:318:13: error: implicit declaration of function 
‘smc_ism_is_emulated’ [-Werror=implicit-function-declaration]
   318 |         if (smc_ism_is_emulated(smcd)) {
       |             ^~~~~~~~~~~~~~~~~~~

> +		smc_pci_dev.pci_pchid = smc_ism_get_chid(smcd);
> +		if (!device->parent)
> +			snprintf(smc_pci_dev.pci_id, sizeof(smc_pci_dev.pci_id),
> +				 "%s", dev_name(device));
> +	}
>   	if (nla_put_u32(skb, SMC_NLA_DEV_PCI_FID, smc_pci_dev.pci_fid))
>   		goto errattr;
>   	if (nla_put_u16(skb, SMC_NLA_DEV_PCI_CHID, smc_pci_dev.pci_pchid))

