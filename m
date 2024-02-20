Return-Path: <linux-kernel+bounces-72193-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF8F85B0A5
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 02:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7BA7F1C217EA
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 01:55:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 621103A8FA;
	Tue, 20 Feb 2024 01:55:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="w/GlcZhW"
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E85C11CA1;
	Tue, 20 Feb 2024 01:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.111
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708394131; cv=none; b=cJcaJOADxNIqbEcUTECI6kofWawG0cXiedeKxz8TosNzQY6TtKN19nu06fjrYR9aQwtaF5bhp7j+FmvQpbRb6q7BOii3JefgHZudtkPSQyODMlqcnqC3dRuMGO349nGSBAcKgBGc55esmjLZHhytqRYb2lv7eum+i+Rbz7NvtQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708394131; c=relaxed/simple;
	bh=bRUVcLp0mVBd3IHB74HQVByUPb0l0kuvm2r+vEVwZYc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=X4vLTmZ7O4R3NDtn2aUhAFP4faKLVl6sDsdwkysS5Ii8aanqBQlXAYOB5Z0fHBg3N0k0QA4pO/RoUXvLycO7GWx7cO46U+WgSZtwK6GCdNGMBanJAu5xRSCT7i2OtQaLTGn4wFn7AZZjNMqaa3I3eBKFLlkvHAjNWK21S6LlTDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=w/GlcZhW; arc=none smtp.client-ip=115.124.30.111
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1708394119; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=PZKp5Almpu55EEXLxa5YMez+rRWeNGVSQ+CadfPuu7s=;
	b=w/GlcZhWXlH6BF38RelJrJUyUtUFANfJZQ9BEiSrb1T+Tdkx/oUgUvdibil10EGsKapukdXFhpzs2B4C+120enIEJeeDykW8Pra7dHkNDtZBiQV7S3KzHh97Y545rEJtdVVT0k/Ve98ZOXHyt22LZ5tFI6c/VstjwnC0ekggh78=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R591e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=18;SR=0;TI=SMTPD_---0W0uqlG1_1708394117;
Received: from 30.221.128.233(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W0uqlG1_1708394117)
          by smtp.aliyun-inc.com;
          Tue, 20 Feb 2024 09:55:18 +0800
Message-ID: <a06cdb50-591b-4984-b7d5-7ab758569d21@linux.alibaba.com>
Date: Tue, 20 Feb 2024 09:55:16 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 06/15] net/smc: implement DMB-related operations
 of loopback-ism
To: Wenjia Zhang <wenjia@linux.ibm.com>, wintera@linux.ibm.com,
 hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-s390@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-7-guwen@linux.alibaba.com>
 <b5b4b96f-e512-4c1a-b749-f9fc3e7c2fcf@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <b5b4b96f-e512-4c1a-b749-f9fc3e7c2fcf@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/2/16 22:13, Wenjia Zhang wrote:
> 
> 
> On 11.01.24 13:00, Wen Gu wrote:
>> This implements DMB (un)registration and data move operations of
>> loopback-ism device.
>>
>> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
>> ---
>>   net/smc/smc_cdc.c      |   6 ++
>>   net/smc/smc_cdc.h      |   1 +
>>   net/smc/smc_loopback.c | 133 ++++++++++++++++++++++++++++++++++++++++-
>>   net/smc/smc_loopback.h |  13 ++++
>>   4 files changed, 150 insertions(+), 3 deletions(-)
>>
>> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
>> index 3c06625ceb20..c820ef197610 100644
>> --- a/net/smc/smc_cdc.c
>> +++ b/net/smc/smc_cdc.c
>> @@ -410,6 +410,12 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
>>   static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
>>   {
>>       struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
>> +
>> +    smcd_cdc_rx_handler(conn);
>> +}
>> +
>> +void smcd_cdc_rx_handler(struct smc_connection *conn)
>> +{
>>       struct smcd_cdc_msg *data_cdc;
>>       struct smcd_cdc_msg cdc;
>>       struct smc_sock *smc;
>> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
>> index 696cc11f2303..11559d4ebf2b 100644
>> --- a/net/smc/smc_cdc.h
>> +++ b/net/smc/smc_cdc.h
>> @@ -301,5 +301,6 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
>>                    struct smc_wr_buf *wr_buf);
>>   int smc_cdc_init(void) __init;
>>   void smcd_cdc_rx_init(struct smc_connection *conn);
>> +void smcd_cdc_rx_handler(struct smc_connection *conn);
>>   #endif /* SMC_CDC_H */
>> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
>> index 353d4a2d69a1..f72e7b24fc1a 100644
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
>> @@ -50,6 +52,97 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>>       return 0;
>>   }
>> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
>> +                   void *client_priv)
>> +{
>> +    struct smc_lo_dmb_node *dmb_node, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +    int sba_idx, order, rc;
>> +    struct page *pages;
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
>> +    order = get_order(dmb->dmb_len);
>> +    pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
>> +                __GFP_NOMEMALLOC | __GFP_COMP |
>> +                __GFP_NORETRY | __GFP_ZERO,
>> +                order);
>> +    if (!pages) {
>> +        rc = -ENOMEM;
>> +        goto err_node;
>> +    }
>> +    dmb_node->cpu_addr = (void *)page_address(pages);
>> +    dmb_node->len = dmb->dmb_len;
>> +    dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
>> +
>> +again:
>> +    /* add new dmb into hash table */
>> +    get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>> +    write_lock(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
>> +        if (tmp_node->token == dmb_node->token) {
>> +            write_unlock(&ldev->dmb_ht_lock);
>> +            goto again;
>> +        }
>> +    }
>> +    hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>> +    write_unlock(&ldev->dmb_ht_lock);
>> +
> The write_lock_irqsave()/write_unlock_irqrestore() and read_lock_irqsave()/read_unlock_irqrestore()should be used 
> instead of write_lock()/write_unlock() and read_lock()/read_unlock() in order to keep the lock irq-safe.
> 

dmb_ht_lock won't be hold in an interrupt or sockirq context. The dmb_{register|unregister},
dmb_{attach|detach} and data_move are all on the process context. So I think write_(un)lock
and read_(un)lock is safe here.

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
>> +    write_lock(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
>> +        if (tmp_node->token == dmb->dmb_tok) {
>> +            dmb_node = tmp_node;
>> +            break;
>> +        }
>> +    }
>> +    if (!dmb_node) {
>> +        write_unlock(&ldev->dmb_ht_lock);
>> +        return -EINVAL;
>> +    }
>> +    hash_del(&dmb_node->list);
>> +    write_unlock(&ldev->dmb_ht_lock);
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
>> @@ -76,6 +169,38 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
>>       return 0;
>>   }
>> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>> +                unsigned int idx, bool sf, unsigned int offset,
>> +                void *data, unsigned int size)
>> +{
>> +    struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
>> +    struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +    read_lock(&ldev->dmb_ht_lock);
>> +    hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
>> +        if (tmp_node->token == dmb_tok) {
>> +            rmb_node = tmp_node;
>> +            break;
>> +        }
>> +    }
>> +    if (!rmb_node) {
>> +        read_unlock(&ldev->dmb_ht_lock);
>> +        return -EINVAL;
>> +    }
>> +    read_unlock(&ldev->dmb_ht_lock);
>> +
>> +    memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>> +
> 
> Should this read_unlock be placed behind memcpy()?
> 

dmb_ht_lock is used to ensure safe access to the DMB hash table of loopback-ism.
The DMB hash table could be accessed by all the connections on loopback-ism, so
it should be protected.

But a certain DMB is only used by one connection, and the move_data process is
protected by conn->send_lock (see smcd_tx_sndbuf_nonempty()), so the memcpy(rmb_node)
here is safe and no race with other.

Thanks!

> <...>

