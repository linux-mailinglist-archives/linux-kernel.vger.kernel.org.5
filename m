Return-Path: <linux-kernel+bounces-127961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B2208953B2
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 14:44:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8641F23545
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Apr 2024 12:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4F27E761;
	Tue,  2 Apr 2024 12:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="E9ALvRv3"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D7FF1DFD0;
	Tue,  2 Apr 2024 12:41:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712061710; cv=none; b=jifyGj8thYJWjDKbbnWsZBA1hJ34rFtRo3FJZqSwKVyrxr+YuJ4IGplE+ixAkwLSsu4SipXmoW5O3V9mPJjMdYjHmPB6qKt4fFbC5YWxv9UkoWOFMQbKXwoMI2Nqw82qOdJ8yyBb8y419SxHqq5KUaE2ifL0xzg4bC9SgxbmvaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712061710; c=relaxed/simple;
	bh=1sK+VypOcmid7qwbW8cHSt6aTLQKQQ5uOqH4Z2IWETA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cJYOzgzjy6NPb4zNyNkGSwnMB/i3joRZcvqyBPwjaTylnaC9N34x3AMehdsB8okKFa8LjhK2s7P7lepmTjDe/6Rqx99xjq/zxZKSJgrYNzF2EXiDxCOxVk38UZrzQll3vd/TJcKzTy8xTksLCHQCOv5e66l760N5tzPk1ENXFu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=E9ALvRv3; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 432CY4mL002252;
	Tue, 2 Apr 2024 12:41:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=JG8OlfkiM/82pPKQvl5RNdoa+aZbT05Y5kKD3vV3B5k=;
 b=E9ALvRv3/Pm23UJiv2p82vy4yN9qoVA0b2zs0D6X0PBBjlb44RiEk2qIy1D8fYnL49ju
 hdY2fnVuwYIAKPGqVdC2xJuo7xbn3WmxSbkZN9WzAB7Z7HyCIp15V1k/zYZw7fshFz+V
 D32X8oa5eD0UJPlbBjwaj9EI8Ez//pF7XEHXwY8zBxSNpSuucF9852YhnTOdjwEuN77a
 rUZVaSIg5YVc0AXfGRDdmflsGUrwXxYLieV5SeLGlmY+xxSRBSV0sOxjag4v44U7tbbL
 jY1lbxaERvCv81xPS40iYGmP6PFAMPIwGbRbmbDYz8BiqobQBS3Zd2/nxvctPU8xBBtF WQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8j4gr0tv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 12:41:30 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 432CeUKH012188;
	Tue, 2 Apr 2024 12:41:29 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x8j4gr0ts-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 12:41:29 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4329nZbw008463;
	Tue, 2 Apr 2024 12:41:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6w2txrf2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Apr 2024 12:41:28 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 432CfPLn39453118
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Apr 2024 12:41:27 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEC7A2004F;
	Tue,  2 Apr 2024 12:41:24 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A9FFF2004E;
	Tue,  2 Apr 2024 12:41:24 +0000 (GMT)
Received: from [9.152.224.141] (unknown [9.152.224.141])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Apr 2024 12:41:24 +0000 (GMT)
Message-ID: <4110b0fb-0005-45b6-9996-978b9bab8beb@linux.ibm.com>
Date: Tue, 2 Apr 2024 14:41:24 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 1/2] net/iucv: Avoid explicit cpumask var
 allocation on stack
To: Dawei Li <dawei.li@shingroup.cn>, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, ioana.ciornei@nxp.com,
        twinkler@linux.ibm.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org
References: <20240331053441.1276826-1-dawei.li@shingroup.cn>
 <20240331053441.1276826-2-dawei.li@shingroup.cn>
Content-Language: en-US
From: Alexandra Winter <wintera@linux.ibm.com>
In-Reply-To: <20240331053441.1276826-2-dawei.li@shingroup.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 3KCg2rCe30HM0RqJDpyETp1Dlk6yxmTC
X-Proofpoint-ORIG-GUID: 5wGrZzyAyOzRZBC_xPLjVLgE2LCnLnX-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-02_06,2024-04-01_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 priorityscore=1501 mlxlogscore=991 lowpriorityscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404020092



On 31.03.24 07:34, Dawei Li wrote:
> For CONFIG_CPUMASK_OFFSTACK=y kernel, explicit allocation of cpumask
> variable on stack is not recommended since it can cause potential stack
> overflow.
> 
> Instead, kernel code should always use *cpumask_var API(s) to allocate
> cpumask var in config-neutral way, leaving allocation strategy to
> CONFIG_CPUMASK_OFFSTACK.
> 
> Use *cpumask_var API(s) to address it.
> 
> Signed-off-by: Dawei Li <dawei.li@shingroup.cn>
> ---

LGTM; 
Thank you Eric for the comment and solution with the 'static' keyword.
Reviewed-by: Alexandra Winter <wintera@linux.ibm.com>


