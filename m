Return-Path: <linux-kernel+bounces-111420-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FFA5886C16
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 13:30:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F8971F24563
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 12:30:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581E8446A2;
	Fri, 22 Mar 2024 12:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="U/0v5Z3Y"
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001329475;
	Fri, 22 Mar 2024 12:30:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711110618; cv=none; b=aCDfTkG7iO7myefkwvDqoN1heTyqUyvHEUdp89JKoEm1pQ9/L+lUpO3zJyW0k9COW3Zoo9ItL/JTxAMMWGMMVskdd5kgkHm4NeRYw2jFf5CQYDoXnxdouzsINEBYxc/Lel2ZrXa0M7H51dZNO5Z7SGob6WNJJtTBF5WNKnLG7iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711110618; c=relaxed/simple;
	bh=fEfFlBr4ugsPaCueHsYIH4SSAkF3+xAFPa2Sh0wjXT4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r5TUimGUqJ0PCsAWiIxw1tN266nS3CrFE9THIEpq2aRVK4Rvq4m6WDiit4/fAcahDFYDtac2i0djL2RZo25Y4pGBS4uxjLf/Gf8FTpfU75dT7WnfVtOvV+Oq7cK4tfGcsdB5qR9Id7TadGUgkWvoh5ejW45d+erX0UwHw643ccw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=U/0v5Z3Y; arc=none smtp.client-ip=115.124.30.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1711110605; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=mYTbCPy1WTTUyflrWQMEy9SpU9P1T1WTxZVaPvhJG5M=;
	b=U/0v5Z3YUpYg90VVjyeDI0m/O9FhprTbR+H6CTCfqWeIqASq4CSuFV/tNA1386u2ONQAErYd3tjCCKlv38BGgFEfBJjbcJunQtA8nAw+nriL5ei9G505pqJFIlMj9P9uFHlcwCdyYwWlIcm+b52rvCtCOjAgRNj7ME3mz0vCRXE=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R531e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W329hih_1711110603;
Received: from 30.221.130.60(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W329hih_1711110603)
          by smtp.aliyun-inc.com;
          Fri, 22 Mar 2024 20:30:05 +0800
Message-ID: <a5566d49-db9e-48ca-801b-37bfa1134748@linux.alibaba.com>
Date: Fri, 22 Mar 2024 20:30:03 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 05/11] net/smc: implement DMB-related
 operations of loopback-ism
To: Jan Karcher <jaka@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-6-guwen@linux.alibaba.com>
 <da8a60f1-dadf-4ab4-89b3-77e1ee45be03@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <da8a60f1-dadf-4ab4-89b3-77e1ee45be03@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/3/21 16:12, Jan Karcher wrote:
> 
> 
> On 17/03/2024 11:05, Wen Gu wrote:
>> This implements DMB (un)registration and data move operations of
>> loopback-ism device.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_loopback.c | 131 ++++++++++++++++++++++++++++++++++++++++-
>>   net/smc/smc_loopback.h |  13 ++++
>>   2 files changed, 141 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
>> index 253128c77208..7335acb03920 100644
>> --- a/net/smc/smc_loopback.c
>> +++ b/net/smc/smc_loopback.c
>> @@ -15,11 +15,13 @@
>>   #include <linux/types.h>
>>   #include <net/smc.h>
>> +#include "smc_cdc.h"
>>   #include "smc_ism.h"
>>   #include "smc_loopback.h"
>>   #if IS_ENABLED(CONFIG_SMC_LO)
>>   #define SMC_LO_V2_CAPABLE    0x1 /* loopback-ism acts as ISMv2 */
>> +#define SMC_DMA_ADDR_INVALID    (~(dma_addr_t)0)
>>   static const char smc_lo_dev_name[] = "loopback-ism";
>>   static struct smc_lo_dev *lo_dev;
>> @@ -49,6 +51,93 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>>       return 0;
>>   }
>> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>> +                   void *client_priv)
>> +{
>> +    struct smc_lo_dmb_node *dmb_node, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +    int sba_idx, rc;
>> +
>> +    /* check space for new dmb */
>> +    for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LO_MAX_DMBS) {
>> +        if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>> +            break;
>> +    }
>> +    if (sba_idx == SMC_LO_MAX_DMBS)
>> +        return -ENOSPC;
>> +
>> +    dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>> +    if (!dmb_node) {
>> +        rc = -ENOMEM;
>> +        goto err_bit;
>> +    }
>> +
>> +    dmb_node->sba_idx = sba_idx;
>> +    dmb_node->len = dmb->dmb_len;
>> +    dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
>> +                     __GFP_NOWARN | __GFP_NORETRY |
>> +                     __GFP_NOMEMALLOC);
>> +    if (!dmb_node->cpu_addr) {
>> +        rc = -ENOMEM;
>> +        goto err_node;
>> +    }
>> +    dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
>> +
>> +again:
>> +    /* add new dmb into hash table */
>> +    get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>> +    write_lock_bh(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
>> +        if (tmp_node->token == dmb_node->token) {
>> +            write_unlock_bh(&ldev->dmb_ht_lock);
>> +            goto again;
>> +        }
>> +    }
>> +    hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>> +    write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +    dmb->sba_idx = dmb_node->sba_idx;
>> +    dmb->dmb_tok = dmb_node->token;
>> +    dmb->cpu_addr = dmb_node->cpu_addr;
>> +    dmb->dma_addr = dmb_node->dma_addr;
>> +    dmb->dmb_len = dmb_node->len;
>> +
>> +    return 0;
>> +
>> +err_node:
>> +    kfree(dmb_node);
>> +err_bit:
>> +    clear_bit(sba_idx, ldev->sba_idx_mask);
>> +    return rc;
>> +}
>> +
>> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
>> +{
>> +    struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +    /* remove dmb from hash table */
>> +    write_lock_bh(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
>> +        if (tmp_node->token == dmb->dmb_tok) {
>> +            dmb_node = tmp_node;
>> +            break;
>> +        }
>> +    }
>> +    if (!dmb_node) {
>> +        write_unlock_bh(&ldev->dmb_ht_lock);
>> +        return -EINVAL;
>> +    }
>> +    hash_del(&dmb_node->list);
>> +    write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +    clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>> +    kfree(dmb_node->cpu_addr);
>> +    kfree(dmb_node);
>> +
>> +    return 0;
>> +}
>> +
>>   static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>>   {
>>       return -EOPNOTSUPP;
>> @@ -75,6 +164,40 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
>>       return 0;
>>   }
>> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>> +                unsigned int idx, bool sf, unsigned int offset,
>> +                void *data, unsigned int size)
>> +{
>> +    struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +    read_lock_bh(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>> +        if (tmp_node->token == dmb_tok) {
>> +            rmb_node = tmp_node;
>> +            break;
>> +        }
>> +    }
>> +    if (!rmb_node) {
>> +        read_unlock_bh(&ldev->dmb_ht_lock);
>> +        return -EINVAL;
>> +    }
>> +    read_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +    memcpy((char *)rmb_node->cpu_addr + offset, data, size);
> 
> Hi Wen Gu,
> 
> Could we get into use after free trouble here if the dmb gets unregistered between the read_unlock and memcpy?
> 

rmb_node won't be unregistered until smc_lgr_free_bufs() in __smc_lgr_free(). At
that time, the connections on this lgr should be all freed (smc_conn_free() and
then lgr->refcnt == 0), so I think there will be no move data operation at that
point. But in case there is something unforeseen, I will put memcpy between dmb_ht_lock.

Thanks!

> 
>> +
>> +    if (sf) {
>> +        struct smc_connection *conn =
>> +            smcd->conn[rmb_node->sba_idx];
> 
> Please put the `struct smc_connection *conn = NULL` at the top of the function and assign the value here.
> 

OK, I will put it at the top. Thanks!

> Thanks
> - Jan
> 
>> +
>> +        if (conn && !conn->killed)
>> +            tasklet_schedule(&conn->rx_tsklet);
>> +        else
>> +            return -EPIPE;
>> +    }
>> +    return 0;
>> +}
>> +
>>   static int smc_lo_supports_v2(void)
>>   {
>>       return SMC_LO_V2_CAPABLE;
>> @@ -101,14 +224,14 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
>>   static const struct smcd_ops lo_ops = {
>>       .query_remote_gid = smc_lo_query_rgid,
>> -    .register_dmb        = NULL,
>> -    .unregister_dmb        = NULL,
>> +    .register_dmb = smc_lo_register_dmb,
>> +    .unregister_dmb = smc_lo_unregister_dmb,
>>       .add_vlan_id = smc_lo_add_vlan_id,
>>       .del_vlan_id = smc_lo_del_vlan_id,
>>       .set_vlan_required = smc_lo_set_vlan_required,
>>       .reset_vlan_required = smc_lo_reset_vlan_required,
>>       .signal_event = smc_lo_signal_event,
>> -    .move_data        = NULL,
>> +    .move_data = smc_lo_move_data,
>>       .supports_v2 = smc_lo_supports_v2,
>>       .get_local_gid = smc_lo_get_local_gid,
>>       .get_chid = smc_lo_get_chid,
>> @@ -173,6 +296,8 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
>>   static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>>   {
>>       smc_lo_generate_id(ldev);
>> +    rwlock_init(&ldev->dmb_ht_lock);
>> +    hash_init(ldev->dmb_ht);
>>       return smcd_lo_register_dev(ldev);
>>   }
>> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
>> index 55b41133a97f..24ab9d747613 100644
>> --- a/net/smc/smc_loopback.h
>> +++ b/net/smc/smc_loopback.h
>> @@ -20,13 +20,26 @@
>>   #if IS_ENABLED(CONFIG_SMC_LO)
>>   #define SMC_LO_MAX_DMBS        5000
>> +#define SMC_LO_DMBS_HASH_BITS    12
>>   #define SMC_LO_CHID        0xFFFF
>> +struct smc_lo_dmb_node {
>> +    struct hlist_node list;
>> +    u64 token;
>> +    u32 len;
>> +    u32 sba_idx;
>> +    void *cpu_addr;
>> +    dma_addr_t dma_addr;
>> +};
>> +
>>   struct smc_lo_dev {
>>       struct smcd_dev *smcd;
>>       struct device dev;
>>       u16 chid;
>>       struct smcd_gid local_gid;
>> +    rwlock_t dmb_ht_lock;
>> +    DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
>> +    DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
>>   };
>>   #endif

