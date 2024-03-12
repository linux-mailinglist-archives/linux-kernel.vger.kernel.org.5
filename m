Return-Path: <linux-kernel+bounces-100324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 121918795BB
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 15:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 358921C218F3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 14:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4B07AE44;
	Tue, 12 Mar 2024 14:11:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="K+/mmyJO"
Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 484D758AD4;
	Tue, 12 Mar 2024 14:11:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710252708; cv=none; b=GRRMMs6HwdS2bwY6ZiO0YnqWJufcOhbmCy9mllSMrMs1YAVt4JM3m3ma0mlLXznyyGIshM5gSYIce5pFLDNTR6JJ7pi5uroefCNOCX6bntOwSHzIafPQBiuOmmJzcolbSjMBk5vAb2wNiSdHCVmUj+HDbJS1tijnS6C0bLwUo9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710252708; c=relaxed/simple;
	bh=hpk/qMl6bJ8R4kXVvpMSCJMeC9KLpt9ro1qhKIzk9r4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FtMLO9epZcYPx3e40JoRj/5+45XSe2WuyzvL4pEv9VWx4NuQin5erY+yc5jJqZRRoD7vwQHWrY2/iWXINL/djxWq5DuhvudNpuA+GqUov/qGknBJJVURx3xS+qxiurXGbph2hLsEpvK1OdTDgMVxetAWiakuIcoPU4pE3AbUFfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=K+/mmyJO; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1710252702; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=hMXHxPYE/bFxI+Al/MR6iqYqKg8ejsTGgWPkQD/Dibk=;
	b=K+/mmyJO+ny/EUH679X5e7cHmsKxhjKV4r6U+o5FnEKlzL6cOvlLbgdaFXDHkIpoT6uJNLjmY59b18KmE2AyYzoJxu7CW2ETxOWOvtsf48wR0erpTfvEsql/9Y0wKn8XS90J9rEWnhT7Nn6ST89L1EUvNLU/25abEEqAZcyI5qI=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W2MAPD._1710252700;
Received: from 30.221.129.234(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W2MAPD._1710252700)
          by smtp.aliyun-inc.com;
          Tue, 12 Mar 2024 22:11:42 +0800
Message-ID: <d8d657d4-c55b-44bd-a234-4b9c7cdad7cf@linux.alibaba.com>
Date: Tue, 12 Mar 2024 22:11:40 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 11/11] net/smc: implement DMB-merged
 operations of loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240307095536.29648-1-guwen@linux.alibaba.com>
 <20240307095536.29648-12-guwen@linux.alibaba.com>
 <36141145-6838-45eb-a6d6-1c052b6fb076@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <36141145-6838-45eb-a6d6-1c052b6fb076@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/12 16:06, Jan Karcher wrote:
> 
> 
> On 07/03/2024 10:55, Wen Gu wrote:
>> This implements operations related to merging sndbuf with peer DMB in
>> loopback-ism. The DMB won't be freed until no sndbuf is attached to it.
> 
> Hi Wen Gu,
> 
> while I'm still reviewing let me drop a lockdep finding.
> 
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_loopback.c | 136 +++++++++++++++++++++++++++++++++++------
>>   net/smc/smc_loopback.h |   3 +
>>   2 files changed, 119 insertions(+), 20 deletions(-)
>>
>> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
>> index 6828e0ad3e90..7e772f3772de 100644
>> --- a/net/smc/smc_loopback.c
>> +++ b/net/smc/smc_loopback.c
> 
> [...]
> 
>> @@ -170,8 +249,22 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>>   {
>>       struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
>>       struct smc_lo_dev *ldev = smcd->priv;
>> -
>> -    read_lock(&ldev->dmb_ht_lock);
>> +    struct smc_connection *conn;
>> +
>> +    if (!sf)
>> +        /* since sndbuf is merged with peer DMB, there is
>> +         * no need to copy data from sndbuf to peer DMB.
>> +         */
>> +        return 0;
>> +
>> +    /* read_lock_bh() is used here just to make lockdep
>> +     * happy, because spin_(un)lock_bh(&conn->send_lock) wraps
>> +     * smc_lo_move_data() and if we use read_lock() here, lockdep
>> +     * will complain about SOFTIRQ-safe -> SOFTIRQ-unsafe lock
>> +     * order detected, but in fact ldev->dmb_ht_lock will never
>> +     * be held in bh context.
>> +     */
>> +    read_lock_bh(&ldev->dmb_ht_lock);
>>       hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>>           if (tmp_node->token == dmb_tok) {
>>               rmb_node = tmp_node;
>> @@ -182,19 +275,14 @@ static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>>           read_unlock(&ldev->dmb_ht_lock);
>>           return -EINVAL;
>>       }
>> -    read_unlock(&ldev->dmb_ht_lock);
>> +    read_unlock_bh(&ldev->dmb_ht_lock);
>>       memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>> -    if (sf) {
>> -        struct smc_connection *conn =
>> -            smcd->conn[rmb_node->sba_idx];
>> -
>> -        if (conn && !conn->killed)
>> -            smcd_cdc_rx_handler(conn);
>> -        else
>> -            return -EPIPE;
>> -    }
>> +    conn = smcd->conn[rmb_node->sba_idx];
>> +    if (!conn || conn->killed)
>> +        return -EPIPE;
>> +    smcd_cdc_rx_handler(conn);
> 
> [ 2385.528515] ============================================
> [ 2385.528517] WARNING: possible recursive locking detected
> [ 2385.528519] 6.8.0-loopback_ism-g30af186e8a18-dirty #12 Not tainted
> [ 2385.528521] --------------------------------------------
> [ 2385.528522] smcapp/51326 is trying to acquire lock:
> [ 2385.528524] 000000018707a128 (&smc->conn.send_lock){+...}-{2:2}, at: smc_tx_sndbuf_nonempty+0xba/0x1c0 [smc]
> [ 2385.528552]
>                 but task is already holding lock:
> [ 2385.528554] 0000000187078728 (&smc->conn.send_lock){+...}-{2:2}, at: smc_cdc_get_slot_and_msg_send+0x66/0xa0 [smc]
> [ 2385.528568]
>                 other info that might help us debug this:
> [ 2385.528570]  Possible unsafe locking scenario:
> 
> [ 2385.528572]        CPU0
> [ 2385.528573]        ----
> [ 2385.528574]   lock(&smc->conn.send_lock);
> [ 2385.528576]   lock(&smc->conn.send_lock);
> [ 2385.528579]
>                  *** DEADLOCK ***
> 
> [ 2385.528580]  May be due to missing lock nesting notation
> 
> [ 2385.528582] 3 locks held by smcapp/51326:
> [ 2385.528584]  #0: 0000000187078378 (sk_lock-AF_SMC){+.+.}-{0:0}, at: smc_recvmsg+0x3c/0x2b0 [smc]
> [ 2385.528598]  #1: 0000000187078728 (&smc->conn.send_lock){+...}-{2:2}, at: smc_cdc_get_slot_and_msg_send+0x66/0xa0 [smc]
> [ 2385.528613]  #2: 0000000187079ce8 (slock-AF_SMC){+...}-{2:2}, at: smc_cdc_msg_recv+0x56/0xe0 [smc]
> [ 2385.528627]
>                 stack backtrace:
> [ 2385.528660] CPU: 3 PID: 51326 Comm: smcapp Not tainted 6.8.0-loopback_ism-g30af186e8a18-dirty #12
> [ 2385.528663] Hardware name: IBM 3906 M04 704 (LPAR)
> [ 2385.528664] Call Trace:
> [ 2385.528666]  [<000000012db60788>] dump_stack_lvl+0x90/0x120
> [ 2385.528671]  [<000000012cc6d088>] validate_chain+0x560/0x960
> [ 2385.528677]  [<000000012cc6f644>] __lock_acquire+0x654/0xd58
> [ 2385.528680]  [<000000012cc70a04>] lock_acquire.part.0+0xec/0x260
> [ 2385.528683]  [<000000012cc70c24>] lock_acquire+0xac/0x170
> [ 2385.528687]  [<000000012dba4ccc>] _raw_spin_lock_bh+0x5c/0xb0
> [ 2385.528690]  [<000003ff80453b32>] smc_tx_sndbuf_nonempty+0xba/0x1c0 [smc]
> [ 2385.528702]  [<000003ff8045428a>] smc_tx_pending+0x32/0x60 [smc]
> [ 2385.528712]  [<000003ff80451f02>] smc_cdc_msg_recv_action+0x3c2/0x528 [smc]
> [ 2385.528723]  [<000003ff804520cc>] smc_cdc_msg_recv+0x64/0xe0 [smc]
> [ 2385.528734]  [<000003ff80452a4c>] smcd_cdc_rx_handler+0x64/0x70 [smc]
> [ 2385.528745]  [<000003ff80459f7e>] smc_lo_move_data+0xde/0x100 [smc]
> [ 2385.528755]  [<000003ff804533e0>] smcd_tx_ism_write+0x68/0x90 [smc]
> [ 2385.528766]  [<000003ff804528a4>] smcd_cdc_msg_send+0x74/0x118 [smc]
> [ 2385.528776]  [<000003ff804529b8>] smc_cdc_get_slot_and_msg_send+0x70/0xa0 [smc]
> [ 2385.528788]  [<000003ff804543ec>] smc_tx_consumer_update+0xe4/0x1b0 [smc]
> [ 2385.528798]  [<000003ff8045458e>] smc_rx_update_consumer+0x86/0x170 [smc]
> [ 2385.528809]  [<000003ff80455ba8>] smc_rx_recvmsg+0x3b8/0x6e8 [smc]
> [ 2385.528820]  [<000003ff804388a4>] smc_recvmsg+0xdc/0x2b0 [smc]
> [ 2385.528831]  [<000000012d8a6d58>] sock_recvmsg+0x70/0xb0
> [ 2385.528837]  [<000000012d8aa0c8>] __sys_recvfrom+0xa8/0x128
> [ 2385.528840]  [<000000012d8ab3ca>] __do_sys_socketcall+0x1ca/0x398
> [ 2385.528844]  [<000000012db8d4c4>] __do_syscall+0x244/0x308
> [ 2385.528847]  [<000000012dba6140>] system_call+0x70/0x98
> [ 2385.528850] INFO: lockdep is turned off.
> 
> 
> I did not investigate deeper, yet. Just an early heads up that there might be something broken.
> 

Thank you for reminding, Jan. I think it is because that I used smcd_cdc_rx_handler(),
which may acquire conn->send_lock, in smc_lo_move_data() where the send_lock has been
held. I reproduced this issue and will fix it in v3.

Thanks!

> Thank you
> - Jan
> 
> 
>>       return 0;
>>   }
>> @@ -226,6 +314,9 @@ static const struct smcd_ops lo_ops = {
>>       .query_remote_gid = smc_lo_query_rgid,
>>       .register_dmb = smc_lo_register_dmb,
>>       .unregister_dmb = smc_lo_unregister_dmb,
>> +    .support_dmb_nocopy = smc_lo_support_dmb_nocopy,
>> +    .attach_dmb = smc_lo_attach_dmb,
>> +    .detach_dmb = smc_lo_detach_dmb,
>>       .add_vlan_id = smc_lo_add_vlan_id,
>>       .del_vlan_id = smc_lo_del_vlan_id,
>>       .set_vlan_required = smc_lo_set_vlan_required,
>> @@ -304,12 +395,17 @@ static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>>       smc_lo_generate_id(ldev);
>>       rwlock_init(&ldev->dmb_ht_lock);
>>       hash_init(ldev->dmb_ht);
>> +    atomic_set(&ldev->dmb_cnt, 0);
>> +    init_waitqueue_head(&ldev->ldev_release);
>> +
>>       return smcd_lo_register_dev(ldev);
>>   }
>>   static void smc_lo_dev_exit(struct smc_lo_dev *ldev)
>>   {
>>       smcd_lo_unregister_dev(ldev);
>> +    if (atomic_read(&ldev->dmb_cnt))
>> +        wait_event(ldev->ldev_release, !atomic_read(&ldev->dmb_cnt));
>>   }
>>   static void smc_lo_dev_release(struct device *dev)
>> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
>> index 24ab9d747613..9156a6c37e65 100644
>> --- a/net/smc/smc_loopback.h
>> +++ b/net/smc/smc_loopback.h
>> @@ -30,6 +30,7 @@ struct smc_lo_dmb_node {
>>       u32 sba_idx;
>>       void *cpu_addr;
>>       dma_addr_t dma_addr;
>> +    refcount_t refcnt;
>>   };
>>   struct smc_lo_dev {
>> @@ -37,9 +38,11 @@ struct smc_lo_dev {
>>       struct device dev;
>>       u16 chid;
>>       struct smcd_gid local_gid;
>> +    atomic_t dmb_cnt;
>>       rwlock_t dmb_ht_lock;
>>       DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
>>       DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
>> +    wait_queue_head_t ldev_release;
>>   };
>>   #endif

