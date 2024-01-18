Return-Path: <linux-kernel+bounces-29635-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7389683111B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 02:51:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 03B32B25972
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 01:51:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A2F5395;
	Thu, 18 Jan 2024 01:50:31 +0000 (UTC)
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C73523D8;
	Thu, 18 Jan 2024 01:50:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705542631; cv=none; b=Rq9wl1LriHC2J17YtiHe839XJBNauTJTxL7eG6wXyS4FLQAHiA+7rG6fiYM0lgJlYalm+EDmdA6NufM27avF7DML+9xM29xAj4+Ckdc6EDD60s8KE7E+3c76qLJeO4USafzx6I/hyh4cypRrGHZOyi9bbcLCj/Ciklb7bysHQI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705542631; c=relaxed/simple;
	bh=YdX5G24CXnDLogY+5UtvR6u9a94ZuekG0rXEedpL2tU=;
	h=X-Alimail-AntiSpam:Received:Date:From:To:Cc:Subject:Message-ID:
	 Reply-To:References:MIME-Version:Content-Type:Content-Disposition:
	 In-Reply-To; b=QqWxUw23/TaOWXstNUjSHQg48aMDJ31dlfnGGYMrx46POSLCJT+i8kDE7QpXipwvdANqBR1YQmfD8n3vbO7/nWAPi/N9wjrXFCaAYhlAy8udISAflPyQOJxIMe+XspkKsNJ8KRodoWcx31278C08oAw/KC+SxvFTT6cBJJP/iH4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R751e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046060;MF=dust.li@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0W-qr2Zh_1705542618;
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0W-qr2Zh_1705542618)
          by smtp.aliyun-inc.com;
          Thu, 18 Jan 2024 09:50:19 +0800
Date: Thu, 18 Jan 2024 09:50:18 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Wen Gu <guwen@linux.alibaba.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
	kuba@kernel.org, pabeni@redhat.com
Cc: alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
	yepeilin.cs@gmail.com, ubraun@linux.ibm.com,
	linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net/smc: fix illegal rmb_desc access in SMC-D
 connection dump
Message-ID: <20240118015018.GB89692@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20240117122749.63785-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240117122749.63785-1-guwen@linux.alibaba.com>

On Wed, Jan 17, 2024 at 08:27:49PM +0800, Wen Gu wrote:
>A crash was found when dumping SMC-D connections. It can be reproduced
>by following steps:
>
>- run nginx/wrk test:
>  smc_run nginx
>  smc_run wrk -t 16 -c 1000 -d <duration> -H 'Connection: Close' <URL>
>
>- continuously dump SMC-D connections in parallel:
>  watch -n 1 'smcss -D'
>
> BUG: kernel NULL pointer dereference, address: 0000000000000030
> CPU: 2 PID: 7204 Comm: smcss Kdump: loaded Tainted: G	E      6.7.0+ #55
> RIP: 0010:__smc_diag_dump.constprop.0+0x5e5/0x620 [smc_diag]
> Call Trace:
>  <TASK>
>  ? __die+0x24/0x70
>  ? page_fault_oops+0x66/0x150
>  ? exc_page_fault+0x69/0x140
>  ? asm_exc_page_fault+0x26/0x30
>  ? __smc_diag_dump.constprop.0+0x5e5/0x620 [smc_diag]
>  ? __kmalloc_node_track_caller+0x35d/0x430
>  ? __alloc_skb+0x77/0x170
>  smc_diag_dump_proto+0xd0/0xf0 [smc_diag]
>  smc_diag_dump+0x26/0x60 [smc_diag]
>  netlink_dump+0x19f/0x320
>  __netlink_dump_start+0x1dc/0x300
>  smc_diag_handler_dump+0x6a/0x80 [smc_diag]
>  ? __pfx_smc_diag_dump+0x10/0x10 [smc_diag]
>  sock_diag_rcv_msg+0x121/0x140
>  ? __pfx_sock_diag_rcv_msg+0x10/0x10
>  netlink_rcv_skb+0x5a/0x110
>  sock_diag_rcv+0x28/0x40
>  netlink_unicast+0x22a/0x330
>  netlink_sendmsg+0x1f8/0x420
>  __sock_sendmsg+0xb0/0xc0
>  ____sys_sendmsg+0x24e/0x300
>  ? copy_msghdr_from_user+0x62/0x80
>  ___sys_sendmsg+0x7c/0xd0
>  ? __do_fault+0x34/0x160
>  ? do_read_fault+0x5f/0x100
>  ? do_fault+0xb0/0x110
>  ? __handle_mm_fault+0x2b0/0x6c0
>  __sys_sendmsg+0x4d/0x80
>  do_syscall_64+0x69/0x180
>  entry_SYSCALL_64_after_hwframe+0x6e/0x76
>
>It is possible that the connection is in process of being established
>when we dump it. Assumed that the connection has been registered in a
>link group by smc_conn_create() but the rmb_desc has not yet been
>initialized by smc_buf_create(), thus causing the illegal access to
>conn->rmb_desc. So fix it by checking before dump.
>
>Fixes: ce51f63e63c5 ("net/smc: Prevent kernel-infoleak in __smc_diag_dump()")

ce51f63e63c5 ("net/smc: Prevent kernel-infoleak in __smc_diag_dump()")
only add a memset() of 'struct smcd_diag_dmbinfo dinfo', which I don't
think is not the real cause of the bug.

>Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>---
> net/smc/smc_diag.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
>index 52f7c4f1e767..5a33908015f3 100644
>--- a/net/smc/smc_diag.c
>+++ b/net/smc/smc_diag.c
>@@ -164,7 +164,7 @@ static int __smc_diag_dump(struct sock *sk, struct sk_buff *skb,
> 	}
> 	if (smc_conn_lgr_valid(&smc->conn) && smc->conn.lgr->is_smcd &&
> 	    (req->diag_ext & (1 << (SMC_DIAG_DMBINFO - 1))) &&
>-	    !list_empty(&smc->conn.lgr->list)) {
>+	    !list_empty(&smc->conn.lgr->list) && smc->conn.rmb_desc) {
> 		struct smc_connection *conn = &smc->conn;
> 		struct smcd_diag_dmbinfo dinfo;
> 		struct smcd_dev *smcd = conn->lgr->smcd;
>-- 
>2.43.0

