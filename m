Return-Path: <linux-kernel+bounces-12533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A4CD81F64C
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 10:32:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E02D1F22F26
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Dec 2023 09:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA2BA63D6;
	Thu, 28 Dec 2023 09:32:41 +0000 (UTC)
X-Original-To: linux-kernel@vger.kernel.org
Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B226863A8;
	Thu, 28 Dec 2023 09:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=tonylu@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0VzO1T68_1703755955;
Received: from localhost(mailfrom:tonylu@linux.alibaba.com fp:SMTPD_---0VzO1T68_1703755955)
          by smtp.aliyun-inc.com;
          Thu, 28 Dec 2023 17:32:36 +0800
Date: Thu, 28 Dec 2023 17:32:34 +0800
From: Tony Lu <tonylu@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>
Cc: wenjia@linux.ibm.com, jaka@linux.ibm.com, davem@davemloft.net,
	edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
	alibuda@linux.alibaba.com, ubraun@linux.vnet.ibm.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix invalid link access in dumping SMC-R
 connections
Message-ID: <ZY1AssRgaWjLVXuN@TONYMAC-ALIBABA.local>
Reply-To: Tony Lu <tonylu@linux.alibaba.com>
References: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1703662835-53416-1-git-send-email-guwen@linux.alibaba.com>

On Wed, Dec 27, 2023 at 03:40:35PM +0800, Wen Gu wrote:
> A crash was found when dumping SMC-R connections. It can be reproduced
> by following steps:
> 
> - environment: two RNICs on both sides.
> - run SMC-R between two sides, now a SMC_LGR_SYMMETRIC type link group
>   will be created.
> - set the first RNIC down on either side and link group will turn to
>   SMC_LGR_ASYMMETRIC_LOCAL then.
> - run 'smcss -R' and the crash will be triggered.
> 
>  BUG: kernel NULL pointer dereference, address: 0000000000000010
>  #PF: supervisor read access in kernel mode
>  #PF: error_code(0x0000) - not-present page
>  PGD 8000000101fdd067 P4D 8000000101fdd067 PUD 10ce46067 PMD 0
>  Oops: 0000 [#1] PREEMPT SMP PTI
>  CPU: 3 PID: 1810 Comm: smcss Kdump: loaded Tainted: G W   E      6.7.0-rc6+ #51
>  RIP: 0010:__smc_diag_dump.constprop.0+0x36e/0x620 [smc_diag]
>  Call Trace:
>   <TASK>
>   ? __die+0x24/0x70
>   ? page_fault_oops+0x66/0x150
>   ? exc_page_fault+0x69/0x140
>   ? asm_exc_page_fault+0x26/0x30
>   ? __smc_diag_dump.constprop.0+0x36e/0x620 [smc_diag]
>   smc_diag_dump_proto+0xd0/0xf0 [smc_diag]
>   smc_diag_dump+0x26/0x60 [smc_diag]
>   netlink_dump+0x19f/0x320
>   __netlink_dump_start+0x1dc/0x300
>   smc_diag_handler_dump+0x6a/0x80 [smc_diag]
>   ? __pfx_smc_diag_dump+0x10/0x10 [smc_diag]
>   sock_diag_rcv_msg+0x121/0x140
>   ? __pfx_sock_diag_rcv_msg+0x10/0x10
>   netlink_rcv_skb+0x5a/0x110
>   sock_diag_rcv+0x28/0x40
>   netlink_unicast+0x22a/0x330
>   netlink_sendmsg+0x240/0x4a0
>   __sock_sendmsg+0xb0/0xc0
>   ____sys_sendmsg+0x24e/0x300
>   ? copy_msghdr_from_user+0x62/0x80
>   ___sys_sendmsg+0x7c/0xd0
>   ? __do_fault+0x34/0x1a0
>   ? do_read_fault+0x5f/0x100
>   ? do_fault+0xb0/0x110
>   __sys_sendmsg+0x4d/0x80
>   do_syscall_64+0x45/0xf0
>   entry_SYSCALL_64_after_hwframe+0x6e/0x76
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

What about using Link: http... here?

> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>

Reviewed-by: Tony Lu <tonylu@linux.alibaba.com>

> ---
>  net/smc/smc_diag.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
> index a584613aca12..5cc376834c57 100644
> --- a/net/smc/smc_diag.c
> +++ b/net/smc/smc_diag.c
> @@ -153,8 +153,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
>  			.lnk[0].link_id = link->link_id,
>  		};
>  
> -		memcpy(linfo.lnk[0].ibname,
> -		       smc->conn.lgr->lnk[0].smcibdev->ibdev->name,
> +		memcpy(linfo.lnk[0].ibname, link->smcibdev->ibdev->name,
>  		       sizeof(link->smcibdev->ibdev->name));
>  		smc_gid_be16_convert(linfo.lnk[0].gid, link->gid);
>  		smc_gid_be16_convert(linfo.lnk[0].peer_gid, link->peer_gid);
> -- 
> 2.43.0

