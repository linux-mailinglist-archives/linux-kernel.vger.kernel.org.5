Return-Path: <linux-kernel+bounces-15336-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3A62822A53
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 10:33:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 336A0B22B1A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Jan 2024 09:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CACA182DD;
	Wed,  3 Jan 2024 09:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WIo7r1gT"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7045118623;
	Wed,  3 Jan 2024 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 4038tSe4011438;
	Wed, 3 Jan 2024 09:33:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 subject : to : cc : references : from : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=u7vbuh9S5hS2XPx/rfCPO3a+vWqn15NPQT6wBmi/7FQ=;
 b=WIo7r1gTRRIMFeD2rt75K88j+11PYNW4c46Cd7XOHPEgBoBTR5v7PceCxYVRiV6iQ5Qr
 nvVqYWTi/yBcdkVSj+I6UqJ01pKT5IGJrPGHbkzhttPtucPVMCZCrarX+kYL7LeePWL7
 npzunjYIUGsZ6LecCBqV01PBEQ2PXb1gBzrYZW7gOxUe0hcbig7Ykpw0SFybnTujFpsf
 tNilEaKlQsj0RJzX9PslsFOI3aoKvxa1WEU0VkNOAji5Nw0K4R4rl3my/IvSzo7L8JpI
 cVZjfwMrFeZVXlysNH5TFop7E7w2Fb8V7kM/4DZDeEgu5NKOfz5ZtyV06EvBcjBGONOk ug== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd4821xdm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:33:31 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4038tWmc011861;
	Wed, 3 Jan 2024 09:33:31 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3vd4821xce-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:33:30 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 4036xkKh019345;
	Wed, 3 Jan 2024 09:33:29 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vc30sha9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Jan 2024 09:33:29 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 4039XT9N31326524
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Jan 2024 09:33:29 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0D0D45803F;
	Wed,  3 Jan 2024 09:33:29 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8759A58060;
	Wed,  3 Jan 2024 09:33:26 +0000 (GMT)
Received: from [9.171.87.115] (unknown [9.171.87.115])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Jan 2024 09:33:26 +0000 (GMT)
Message-ID: <0a501939-3361-428e-97c4-6f041a9ec1f9@linux.ibm.com>
Date: Wed, 3 Jan 2024 10:33:25 +0100
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net] net/smc: fix invalid link access in dumping SMC-R
 connections
To: Wen Gu <guwen@linux.alibaba.com>, jaka@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
        ubraun@linux.vnet.ibm.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>
Content-Language: en-GB
From: Wenjia Zhang <wenjia@linux.ibm.com>
In-Reply-To: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KJYL8MCvw3wW-NrXsAMilm66u5tPB0Tw
X-Proofpoint-ORIG-GUID: fus5OwQNizTGTLMwpikTYmnAsFDHQrKn
Content-Transfer-Encoding: 7bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-01-03_04,2024-01-02_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 clxscore=1011 mlxlogscore=784 malwarescore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 spamscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2401030078



On 27.12.23 08:40, Wen Gu wrote:
> A crash was found when dumping SMC-R connections. It can be reproduced
> by following steps:
> 
> - environment: two RNICs on both sides.
> - run SMC-R between two sides, now a SMC_LGR_SYMMETRIC type link group
>    will be created.
> - set the first RNIC down on either side and link group will turn to
>    SMC_LGR_ASYMMETRIC_LOCAL then.
> - run 'smcss -R' and the crash will be triggered.
> 
>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>   #PF: supervisor read access in kernel mode
>   #PF: error_code(0x0000) - not-present page
>   PGD 8000000101fdd067 P4D 8000000101fdd067 PUD 10ce46067 PMD 0
>   Oops: 0000 [#1] PREEMPT SMP PTI
>   CPU: 3 PID: 1810 Comm: smcss Kdump: loaded Tainted: G W   E      6.7.0-rc6+ #51
>   RIP: 0010:__smc_diag_dump.constprop.0+0x36e/0x620 [smc_diag]
>   Call Trace:
>    <TASK>
>    ? __die+0x24/0x70
>    ? page_fault_oops+0x66/0x150
>    ? exc_page_fault+0x69/0x140
>    ? asm_exc_page_fault+0x26/0x30
>    ? __smc_diag_dump.constprop.0+0x36e/0x620 [smc_diag]
>    smc_diag_dump_proto+0xd0/0xf0 [smc_diag]
>    smc_diag_dump+0x26/0x60 [smc_diag]
>    netlink_dump+0x19f/0x320
>    __netlink_dump_start+0x1dc/0x300
>    smc_diag_handler_dump+0x6a/0x80 [smc_diag]
>    ? __pfx_smc_diag_dump+0x10/0x10 [smc_diag]
>    sock_diag_rcv_msg+0x121/0x140
>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>    netlink_rcv_skb+0x5a/0x110
>    sock_diag_rcv+0x28/0x40
>    netlink_unicast+0x22a/0x330
>    netlink_sendmsg+0x240/0x4a0
>    __sock_sendmsg+0xb0/0xc0
>    ____sys_sendmsg+0x24e/0x300
>    ? copy_msghdr_from_user+0x62/0x80
>    ___sys_sendmsg+0x7c/0xd0
>    ? __do_fault+0x34/0x1a0
>    ? do_read_fault+0x5f/0x100
>    ? do_fault+0xb0/0x110
>    __sys_sendmsg+0x4d/0x80
>    do_syscall_64+0x45/0xf0
>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
> 
> When the first RNIC is set down, the lgr->lnk[0] will be cleared and an
> asymmetric link will be allocated in lgr->link[SMC_LINKS_PER_LGR_MAX - 1]
> by smc_llc_alloc_alt_link(). Then when we try to dump SMC-R connections
> in __smc_diag_dump(), the invalid lgr->lnk[0] will be accessed, resulting
> in this issue. So fix it by accessing the right link.
> 
> Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
> Reported-by: henaumars <henaumars@sina.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7616
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

That is really good catch and good description! Thank you, Wen Gu, for 
fixing it!

Reviewed-and-tested-by: Wenjia Zhang <wenjia@linux.ibm.com>

