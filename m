Return-Path: <linux-kernel+bounces-12602-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67FFD81F77B
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 12:03:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E30B281558
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 11:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 738D17494;
	Thu, 28 Dec 2023 11:02:45 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C0A56FDF;
	Thu, 28 Dec 2023 11:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0VzOHWBq_1703761352;
Received: from 30.221.131.93(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0VzOHWBq_1703761352)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 19:02:34 +0800
Message-ID: <c7b8017b-2234-92f5-de3a-f189d52f4da8@linux.alibaba.com>
Date: Thu, 28 Dec 2023 19:02:31 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.1
Subject: Re: [PATCH net] net/smc: fix invalid link access in dumping SMC-R
 connections
To: Tony Lu <tonylu@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 alibuda@linux.alibaba.com, ubraun@linux.vnet.ibm.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>
 <ZY1AssRgaWjLVXuN@TONYMAC-ALIBABA.local>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <ZY1AssRgaWjLVXuN@TONYMAC-ALIBABA.local>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 2023/12/28 17:32, Tony Lu wrote:
> On Wed, Dec 27, 2023 at 03:40:35PM +0800, Wen Gu wrote:
>> A crash was found when dumping SMC-R connections. It can be reproduced
>> by following steps:
>>
>> - environment: two RNICs on both sides.
>> - run SMC-R between two sides, now a SMC_LGR_SYMMETRIC type link group
>>    will be created.
>> - set the first RNIC down on either side and link group will turn to
>>    SMC_LGR_ASYMMETRIC_LOCAL then.
>> - run 'smcss -R' and the crash will be triggered.
>>
>>   BUG: kernel NULL pointer dereference, address: 0000000000000010
>>   #PF: supervisor read access in kernel mode
>>   #PF: error_code(0x0000) - not-present page
>>   PGD 8000000101fdd067 P4D 8000000101fdd067 PUD 10ce46067 PMD 0
>>   Oops: 0000 [#1] PREEMPT SMP PTI
>>   CPU: 3 PID: 1810 Comm: smcss Kdump: loaded Tainted: G W   E      6.7.0-rc6+ #51
>>   RIP: 0010:__smc_diag_dump.constprop.0+0x36e/0x620 [smc_diag]
>>   Call Trace:
>>    <TASK>
>>    ? __die+0x24/0x70
>>    ? page_fault_oops+0x66/0x150
>>    ? exc_page_fault+0x69/0x140
>>    ? asm_exc_page_fault+0x26/0x30
>>    ? __smc_diag_dump.constprop.0+0x36e/0x620 [smc_diag]
>>    smc_diag_dump_proto+0xd0/0xf0 [smc_diag]
>>    smc_diag_dump+0x26/0x60 [smc_diag]
>>    netlink_dump+0x19f/0x320
>>    __netlink_dump_start+0x1dc/0x300
>>    smc_diag_handler_dump+0x6a/0x80 [smc_diag]
>>    ? __pfx_smc_diag_dump+0x10/0x10 [smc_diag]
>>    sock_diag_rcv_msg+0x121/0x140
>>    ? __pfx_sock_diag_rcv_msg+0x10/0x10
>>    netlink_rcv_skb+0x5a/0x110
>>    sock_diag_rcv+0x28/0x40
>>    netlink_unicast+0x22a/0x330
>>    netlink_sendmsg+0x240/0x4a0
>>    __sock_sendmsg+0xb0/0xc0
>>    ____sys_sendmsg+0x24e/0x300
>>    ? copy_msghdr_from_user+0x62/0x80
>>    ___sys_sendmsg+0x7c/0xd0
>>    ? __do_fault+0x34/0x1a0
>>    ? do_read_fault+0x5f/0x100
>>    ? do_fault+0xb0/0x110
>>    __sys_sendmsg+0x4d/0x80
>>    do_syscall_64+0x45/0xf0
>>    entry_SYSCALL_64_after_hwframe+0x6e/0x76
>>
>> When the first RNIC is set down, the lgr->lnk[0] will be cleared and an
>> asymmetric link will be allocated in lgr->link[SMC_LINKS_PER_LGR_MAX - 1]
>> by smc_llc_alloc_alt_link(). Then when we try to dump SMC-R connections
>> in __smc_diag_dump(), the invalid lgr->lnk[0] will be accessed, resulting
>> in this issue. So fix it by accessing the right link.
>>
>> Fixes: f16a7dd5cf27 ("smc: netlink interface for SMC sockets")
>> Reported-by: henaumars <henaumars@sina.com>
>> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=7616
> 
> What about using Link: http... here?
> 

Thank you, Tony.

According to [1],

"
The Reported-by tag gives credit to people who find bugs and report them and it
hopefully inspires them to help us again in the future. The tag is intended for
bugs; please do not use it to credit feature requests. The tag should be followed
by a Closes: tag pointing to the report, unless the report is not available on
the web. The Link: tag can be used instead of Closes: if the patch fixes a part
of the issue(s) being reported.
"

So I guess the Closes: tag is fine here.

[1] https://docs.kernel.org/process/submitting-patches.html

>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> 
> Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>
> 
>> ---
>>   net/smc/smc_diag.c | 3 +--
>>   1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>> index a584613aca12..5cc376834c57 100644
>> --- a/net/smc/smc_diag.c
>> +++ b/net/smc/smc_diag.c
>> @@ -153,8 +153,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>>   			.lnk[0].link_id = link->link_id,
>>   		};
>>   
>> -		memcpy(linfo.lnk[0].ibname,
>> -		       smc->conn.lgr->lnk[0].smcibdev->ibdev->name,
>> +		memcpy(linfo.lnk[0].ibname, link->smcibdev->ibdev->name,
>>   		       sizeof(link->smcibdev->ibdev->name));
>>   		smc_gid_be16_convert(linfo.lnk[0].gid, link->gid);
>>   		smc_gid_be16_convert(linfo.lnk[0].peer_gid, link->peer_gid);
>> -- 
>> 2.43.0

