Return-Path: <linux-kernel+bounces-110863-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F5838864E9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 02:49:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A88B2138C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 01:49:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64C5F1854;
	Fri, 22 Mar 2024 01:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="LPo6Xk3Q"
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 845CE138C;
	Fri, 22 Mar 2024 01:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711072154; cv=none; b=uId5V3ye3KLZyNBk4gAX7TxZwpo8pbsk3/v7axk/Umelpofn95C7TRq22FfSXVpIrHXzCTzVlaTP1ank126kS+CNDeqGkHPmSv6yNOH2lYLLFUAf16cxS5YWJXk2+8RL/jGlmBxRkHNAdP0gd3cNkrq2f/5ECH5g3MWZ2cq5ldo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711072154; c=relaxed/simple;
	bh=UqN/yfNOXwKT4NVcYzXi8R8X48xWk+ND6B1m2XoGl+Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bMhkxUf4jlA0fNk8UNWBpdthv+7YiybAqB1rLqlCp8ocu15yLAFg2mWpvoAijUHGPTNxAO7mHwnIbflVpEDzKDVI0s1er7wcCcblSjyFlSUQTN/8gU5lHStnkWAtidWr/QzNacnUiRLePoiumY41gEWsXlBFOXDzneys0jOz5ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=LPo6Xk3Q; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711072143; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=tl0g3t6iyeTsDwpuIM6N3LQiVg9Wq/mZ3K6RYFJMlCc=;
	b=LPo6Xk3QzOoWzDC5Tq/uVlEtOvUXX8RKeNMNV+DfkZa+KoSZHZxO6EYnfBk2FusJxOJuPF4lGN0AtaWO1X4ng1HnJ4KSDWtk9Uexj+62xHg3OPjRhs6qQFAIRfpa+cP8uoP+MD783RRrMwK3KhsKN8+ZzhtQLsb/Tweurnx3nyQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R271e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W305wuV_1711072141;
Received: from 30.221.130.60(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W305wuV_1711072141)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 09:49:02 +0800
Message-ID: <72c046f3-1eb5-44f8-b32b-1ff6471943a2@linux.alibaba.com>
Date: Fri, 22 Mar 2024 09:49:00 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 10/11] net/smc: adapt cursor update when
 sndbuf and peer DMB are merged
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-11-guwen@linux.alibaba.com>
 <1b3428f6-1fcc-4aba-80a0-0743c7c0c138@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <1b3428f6-1fcc-4aba-80a0-0743c7c0c138@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/21 16:12, Jan Karcher wrote:
> 
> 
> On 17/03/2024 11:05, Wen Gu wrote:
>> Since ghost sndbuf shares the same physical memory with peer DMB,
>> the cursor update processing needs to be adapted to ensure that the
>> data to be consumed won't be overwritten.
>>
>> So in this case, the fin_curs and sndbuf_space that were originally
>> updated after sending the CDC message should be modified to not be
>> update until the peer updates cons_curs.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_cdc.c | 52 +++++++++++++++++++++++++++++++++++++----------
>>   1 file changed, 41 insertions(+), 11 deletions(-)
>>
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 3c06625ceb20..bf5b214ec15a 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -18,6 +18,7 @@
>>   #include "smc_tx.h"
>>   #include "smc_rx.h"
>>   #include "smc_close.h"
>> +#include "smc_ism.h"
>>   /********************************** send *************************************/
>> @@ -255,17 +256,25 @@ int smcd_cdc_msg_send(struct smc_connection *conn)
>>           return rc;
>>       smc_curs_copy(&conn->rx_curs_confirmed, &curs, conn);
>>       conn->local_rx_ctrl.prod_flags.cons_curs_upd_req = 0;
>> -    /* Calculate transmitted data and increment free send buffer space */
>> -    diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
>> -                 &conn->tx_curs_sent);
>> -    /* increased by confirmed number of bytes */
>> -    smp_mb__before_atomic();
>> -    atomic_add(diff, &conn->sndbuf_space);
>> -    /* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
>> -    smp_mb__after_atomic();
>> -    smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
>> +    if (!smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
>> +        /* Ghost sndbuf shares the same memory region with
>> +         * peer DMB, so don't update the tx_curs_fin and
>> +         * sndbuf_space until peer has consumed the data.
>> +         */
> 
> Hi Wen Gu,
> 
> move this comment above the if please. Two consecutive multiline comments are difficult to read here.
> 

OK, will move comments above the if. Thanks!

>> +        /* Calculate transmitted data and increment free
>> +         * send buffer space
>> +         */
>> +        diff = smc_curs_diff(conn->sndbuf_desc->len, &conn->tx_curs_fin,
>> +                     &conn->tx_curs_sent);
>> +        /* increased by confirmed number of bytes */
>> +        smp_mb__before_atomic();
>> +        atomic_add(diff, &conn->sndbuf_space);
>> +        /* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
>> +        smp_mb__after_atomic();
>> +        smc_curs_copy(&conn->tx_curs_fin, &conn->tx_curs_sent, conn);
>> -    smc_tx_sndbuf_nonfull(smc);
>> +        smc_tx_sndbuf_nonfull(smc);
>> +    }
>>       return rc;
>>   }
>> @@ -323,7 +332,7 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>>   {
>>       union smc_host_cursor cons_old, prod_old;
>>       struct smc_connection *conn = &smc->conn;
>> -    int diff_cons, diff_prod;
>> +    int diff_cons, diff_prod, diff_tx;
>>       smc_curs_copy(&prod_old, &conn->local_rx_ctrl.prod, conn);
>>       smc_curs_copy(&cons_old, &conn->local_rx_ctrl.cons, conn);
>> @@ -339,6 +348,27 @@ static void smc_cdc_msg_recv_action(struct smc_sock *smc,
>>           atomic_add(diff_cons, &conn->peer_rmbe_space);
>>           /* guarantee 0 <= peer_rmbe_space <= peer_rmbe_size */
>>           smp_mb__after_atomic();
>> +
>> +        if (conn->lgr->is_smcd &&
>> +            smc_ism_support_dmb_nocopy(conn->lgr->smcd)) {
>> +            /* Ghost sndbuf shares the same memory region with
>> +             * peer RMB, so update tx_curs_fin and sndbuf_space
>> +             * when peer has consumed the data.
>> +             */
> 
> Same as above.
> 

OK, will do. Thanks!

> Thanks
> - Jan
> 
>> +            /* calculate peer rmb consumed data */
>> +            diff_tx = smc_curs_diff(conn->sndbuf_desc->len,
>> +                        &conn->tx_curs_fin,
>> +                        &conn->local_rx_ctrl.cons);
>> +            /* increase local sndbuf space and fin_curs */
>> +            smp_mb__before_atomic();
>> +            atomic_add(diff_tx, &conn->sndbuf_space);
>> +            /* guarantee 0 <= sndbuf_space <= sndbuf_desc->len */
>> +            smp_mb__after_atomic();
>> +            smc_curs_copy(&conn->tx_curs_fin,
>> +                      &conn->local_rx_ctrl.cons, conn);
>> +
>> +            smc_tx_sndbuf_nonfull(smc);
>> +        }
>>       }
>>       diff_prod = smc_curs_diff(conn->rmb_desc->len, &prod_old,

