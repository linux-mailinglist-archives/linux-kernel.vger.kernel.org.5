Return-Path: <linux-kernel+bounces-67001-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 499908564A1
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:41:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BF7C1C21275
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3017E131723;
	Thu, 15 Feb 2024 13:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fdRiLU63"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A5A612F5BB;
	Thu, 15 Feb 2024 13:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708004475; cv=none; b=iq8sWj3cB/XhssynJ63EZ5JTNFYngrYB9QniRRDWk55hNgOEA3IQv3sxK84FO9p+vprTfdjP8dFHmEl9RbqPPIOqcJhBP10lnRjJv4bgUIVzgvGxLdXBlj4MZrbATkFxj+v2J/lKc8CJYj0G8s4+fzJsf4vkzce+1tGYfWu7h8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708004475; c=relaxed/simple;
	bh=ERzAARGdkYek7a8RWsQHxBtyT1ON3LOa2GCXXf3xHmI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Scye8cDeruaDHXfW9auMlXMSD/jE/YcI6yzD+zOyyZsnIyGfcHZXyym303TIzhVslSJugnBlfCwPdgqKjcgOm68Z/nMfqExEYnAuHz4FzybardGKhUE/3z1dn1tf6g18rd2vBFf+Qfi5Mqq3t/AklyMnjRmdiH7NNjeuIK0k2gc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fdRiLU63; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41FCgX0N028489;
	Thu, 15 Feb 2024 13:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=RRmyacOzbnm8G8/TfM9F5VaEBokOpdiiuqMXlQmyfIM=;
 b=fdRiLU63FohITYvxkf0yViHroj8cH4iEqyVkU4NrR+uh5Ds+FfPoQoi6VXAKkOdmRUQP
 f9r5Juj76v5bDOfEIlQY/tbI7VEI9FcevL/qwQP+h+/S+mbttu3ahoiyIhoJHJael9XG
 jeRWbmH7tJvZrV/hlWvmnoCKWosIj1HgvnoYeF3HieYcOQhpNMU/pcDhA2AQrG/oSRoO
 UuRs+7vIBrRIEbLtZZ65y8nirClAR5LfCEgPQzUmRmROomIuCFajkMaroMtYK8TK98Ew
 ZN/uvTOi55YozQpdZQFNrprHciGlJtITiy/njIHd8r2hMDZP0X1MbOxlBhIP4JXVvY/M uw== 
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w9jut1hwr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:41:12 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41FCfYEr009886;
	Thu, 15 Feb 2024 13:37:04 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6p634gf8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Feb 2024 13:37:04 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41FDawfB62915008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Feb 2024 13:37:01 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB2C52004B;
	Thu, 15 Feb 2024 13:36:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B2F602005A;
	Thu, 15 Feb 2024 13:36:57 +0000 (GMT)
Received: from [9.152.224.128] (unknown [9.152.224.128])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 15 Feb 2024 13:36:57 +0000 (GMT)
Message-ID: <47789946-0ffe-462e-9e2e-43b03ea41fe0@linux.ibm.com>
Date: Thu, 15 Feb 2024 14:36:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net/af_iucv: fix virtual vs physical address confusion
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Thorsten Winkler <twinkler@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20240215080500.2616848-1-agordeev@linux.ibm.com>
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240215080500.2616848-1-agordeev@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 6Wyj8PHle2IkM-Ef66rK71eMEPS9-5_N
X-Proofpoint-GUID: 6Wyj8PHle2IkM-Ef66rK71eMEPS9-5_N
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-15_12,2024-02-14_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1015 mlxscore=0 mlxlogscore=999 malwarescore=0
 priorityscore=1501 adultscore=0 bulkscore=0 impostorscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2402150109



On 15.02.24 09:05, Alexander Gordeev wrote:
> Fix virtual vs physical address confusion. This does not fix a bug
> since virtual and physical address spaces are currently the same.
> 
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> ---
>  net/iucv/af_iucv.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 498a0c35b7bb..4aa1c72e6c49 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c
> @@ -1060,13 +1060,12 @@ static int iucv_sock_sendmsg(struct socket *sock, struct msghdr *msg,
>  			int i;
>  
>  			/* skip iucv_array lying in the headroom */
> -			iba[0].address = (u32)(addr_t)skb->data;
> +			iba[0].address = (u32)virt_to_phys(skb->data);
>  			iba[0].length = (u32)skb_headlen(skb);
>  			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>  				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
>  
> -				iba[i + 1].address =
> -					(u32)(addr_t)skb_frag_address(frag);
> +				iba[i + 1].address = (u32)virt_to_phys(skb_frag_address(frag));
>  				iba[i + 1].length = (u32)skb_frag_size(frag);
>  			}
>  			err = pr_iucv->message_send(iucv->path, &txmsg,
> @@ -1162,13 +1161,12 @@ static void iucv_process_message(struct sock *sk, struct sk_buff *skb,
>  			struct iucv_array *iba = (struct iucv_array *)skb->head;
>  			int i;
>  
> -			iba[0].address = (u32)(addr_t)skb->data;
> +			iba[0].address = (u32)virt_to_phys(skb->data);
>  			iba[0].length = (u32)skb_headlen(skb);
>  			for (i = 0; i < skb_shinfo(skb)->nr_frags; i++) {
>  				skb_frag_t *frag = &skb_shinfo(skb)->frags[i];
>  
> -				iba[i + 1].address =
> -					(u32)(addr_t)skb_frag_address(frag);
> +				iba[i + 1].address = (u32)virt_to_phys(skb_frag_address(frag));
>  				iba[i + 1].length = (u32)skb_frag_size(frag);
>  			}
>  			rc = pr_iucv->message_receive(path, msg,


Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>

I would have preferred to do all the translations in __iucv_* functions in iucv.c,
but I understand that for __iucv_message_receive() this would mean significant changes. 

