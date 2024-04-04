Return-Path: <linux-kernel+bounces-131233-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 51D7C8984EA
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 12:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB767B21830
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 10:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 449C7762D0;
	Thu,  4 Apr 2024 10:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="m9xKy0de"
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A902757F8;
	Thu,  4 Apr 2024 10:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712226019; cv=none; b=r4lYgSyKVKiKpzUKltRvF38B2nIa9+iv/9AKDk5jAYIh8ywQYgW5JC6d5/DApFOZEDgVrwqsk22YEbhlwyXVlIrIFs7LLI1Kx+YSo+OylAvaIKAw97+xeDuHhLbJLEKNCPaPIvtCTGSCqVvqcC9ishbJJME1giOcqJlpTyVEmYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712226019; c=relaxed/simple;
	bh=BAPVa3NVo6Kr8sk7knUSnmxSoHBW01uwIxL7h5bdjE0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QSpp0NMLXZttcSFDfcfybvcT5wvv2msAz4qgmIVyEAugt7FMnVZzNn6TFZw9+H4eyYA7yC0qT8r+fKmA87JB1RVqGN9ggjmTj1/LFfHqRHO3oBdmW0n6yMq1xk3J+IXkSoj2EYEEtJXdfgvNuomqFwP+zF3R4MWPpjy8DCKD8r4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=m9xKy0de; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1712226011; h=Message-ID:Date:MIME-Version:Subject:To:From:Content-Type;
	bh=TjUfd7RilgvfZhU4La7YH6PmF7zOYhA3lxAH/dOWJIE=;
	b=m9xKy0deOo4U9JJi6sgKLbh5MpYfqWCfGKEFDr77NjS/WTu7JDJ+id+fNaaTQSoS2P24frrh5w04VoR5gU7yx7rtR6PQ+wKss4XXc6ZlEUpDqj5WQqmQKunjOSJSVdWuSnlaGPSy+bI+/nqoK42DxaNDDHoHFS5j70/vTKxgyq0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0W3uBsM5_1712226009;
Received: from 30.39.185.155(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0W3uBsM5_1712226009)
          by smtp.aliyun-inc.com;
          Thu, 04 Apr 2024 18:20:11 +0800
Message-ID: <92b0c4b1-4844-4adf-a15a-a9323fb859e1@linux.alibaba.com>
Date: Thu, 4 Apr 2024 18:20:09 +0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v5 05/11] net/smc: implement DMB-related
 operations of loopback-ism
To: Gerd Bayer <gbayer@linux.ibm.com>, wintera@linux.ibm.com,
 twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
 agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com, jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com,
 alibuda@linux.alibaba.com, tonylu@linux.alibaba.com,
 linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
 <20240324135522.108564-6-guwen@linux.alibaba.com>
 <9a17268d4046f99b30f3620079b5749a9ddc5cd9.camel@linux.ibm.com>
From: Wen Gu <guwen@linux.alibaba.com>
In-Reply-To: <9a17268d4046f99b30f3620079b5749a9ddc5cd9.camel@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



On 2024/4/4 01:20, Gerd Bayer wrote:
> On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:
> 
> When I instrumented this to see, why I still see tons of my other
> temporary instrumentation messages from the "ism" driver, I found that
> in my setup loopback-ism is used rather infrequently.
> 
> I suspect this is due to how the SMC proposals are constructed in
> net/smc/af_smc.c and net/smc/smc_pnet.c - and later evaluated in
> smc_check_ism_v2_match() - where there is a first-come-first-serve
> selection.
> 
> I wonder if one should change that to favour loopback-ism over "real"
> ISM devices - and how this could be achieved elegantly.
> 
> Just some food for thought... Probably little you can do on x86.
> 

Yes, it is about the priority of available ISM devices, and now it
is decided by their order in the smcd_dev_list. The later registered
ISMv2 devices(without pnetid) will be added to the beginning of the
list (see smcd_register_dev()). So there is a probability that
loopback-ism will not be ranked first, since it is added into list
earlier during smc_init().

If we have the runtime switch of loopback-ism, we can re-active the
loopback-ism, that make it be re-added into the beginning of the dev
list and be chosen first. Or a new netlink command to adjust the slot
order of available ISM devices in the list. As we discussed before,
that could be tasks in stage 1 or stage 2.

Thanks!

> Thanks,
> Gerd
> 
>> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct
>> smcd_dmb *dmb,
>> +			       void *client_priv)
>> +{
>> +	struct smc_lo_dmb_node *dmb_node, *tmp_node;
>> +	struct smc_lo_dev *ldev = smcd->priv;
>> +	int sba_idx, rc;
>> +
>> +	/* check space for new dmb */
>> +	for_each_clear_bit(sba_idx, ldev->sba_idx_mask,
>> SMC_LO_MAX_DMBS) {
>> +		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
>> +			break;
>> +	}
>> +	if (sba_idx == SMC_LO_MAX_DMBS)
>> +		return -ENOSPC;
>> +
>> +	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
>> +	if (!dmb_node) {
>> +		rc = -ENOMEM;
>> +		goto err_bit;
>> +	}
>> +
>> +	dmb_node->sba_idx = sba_idx;
>> +	dmb_node->len = dmb->dmb_len;
>> +	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
>> +				     __GFP_NOWARN | __GFP_NORETRY |
>> +				     __GFP_NOMEMALLOC);
>> +	if (!dmb_node->cpu_addr) {
>> +		rc = -ENOMEM;
>> +		goto err_node;
>> +	}
>> +	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
>> +
>> +again:
>> +	/* add new dmb into hash table */
>> +	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
>> +	write_lock_bh(&ldev->dmb_ht_lock);
>> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list,
>> dmb_node->token) {
>> +		if (tmp_node->token == dmb_node->token) {
>> +			write_unlock_bh(&ldev->dmb_ht_lock);
>> +			goto again;
>> +		}
>> +	}
>> +	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
>> +	write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +	dmb->sba_idx = dmb_node->sba_idx;
>> +	dmb->dmb_tok = dmb_node->token;
>> +	dmb->cpu_addr = dmb_node->cpu_addr;
>> +	dmb->dma_addr = dmb_node->dma_addr;
>> +	dmb->dmb_len = dmb_node->len;
>> +
>> +	return 0;
>> +
>> +err_node:
>> +	kfree(dmb_node);
>> +err_bit:
>> +	clear_bit(sba_idx, ldev->sba_idx_mask);
>> +	return rc;
>> +}
>> +
>> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct
>> smcd_dmb *dmb)
>> +{
>> +	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
>> +	struct smc_lo_dev *ldev = smcd->priv;
>> +
>> +	/* remove dmb from hash table */
>> +	write_lock_bh(&ldev->dmb_ht_lock);
>> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb-
>>> dmb_tok) {
>> +		if (tmp_node->token == dmb->dmb_tok) {
>> +			dmb_node = tmp_node;
>> +			break;
>> +		}
>> +	}
>> +	if (!dmb_node) {
>> +		write_unlock_bh(&ldev->dmb_ht_lock);
>> +		return -EINVAL;
>> +	}
>> +	hash_del(&dmb_node->list);
>> +	write_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
>> +	kfree(dmb_node->cpu_addr);
>> +	kfree(dmb_node);
>> +
>> +	return 0;
>> +}
>> +
>>   static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>>   {
>>   	return -EOPNOTSUPP;
>> @@ -75,6 +164,38 @@ static int smc_lo_signal_event(struct smcd_dev
>> *dev, struct smcd_gid *rgid,
>>   	return 0;
>>   }
>>   
>> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
>> +			    unsigned int idx, bool sf, unsigned int
>> offset,
>> +			    void *data, unsigned int size)
>> +{
>> +	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
>> +	struct smc_lo_dev *ldev = smcd->priv;
>> +	struct smc_connection *conn;
>> +
>> +	read_lock_bh(&ldev->dmb_ht_lock);
>> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list,
>> dmb_tok) {
>> +		if (tmp_node->token == dmb_tok) {
>> +			rmb_node = tmp_node;
>> +			break;
>> +		}
>> +	}
>> +	if (!rmb_node) {
>> +		read_unlock_bh(&ldev->dmb_ht_lock);
>> +		return -EINVAL;
>> +	}
>> +	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
>> +	read_unlock_bh(&ldev->dmb_ht_lock);
>> +
>> +	if (sf) {
>> +		conn = smcd->conn[rmb_node->sba_idx];
>> +		if (conn && !conn->killed)
>> +			tasklet_schedule(&conn->rx_tsklet);
>> +		else
>> +			return -EPIPE;
>> +	}
>> +	return 0;
>> +}
>> +
>>   static int smc_lo_supports_v2(void)
>>   {
>>   	return SMC_LO_V2_CAPABLE;
>> @@ -101,14 +222,14 @@ static struct device *smc_lo_get_dev(struct
>> smcd_dev *smcd)
>>   
>>   static const struct smcd_ops lo_ops = {
>>   	.query_remote_gid = smc_lo_query_rgid,
>> -	.register_dmb		= NULL,
>> -	.unregister_dmb		= NULL,
>> +	.register_dmb = smc_lo_register_dmb,
>> +	.unregister_dmb = smc_lo_unregister_dmb,
>>   	.add_vlan_id = smc_lo_add_vlan_id,
>>   	.del_vlan_id = smc_lo_del_vlan_id,
>>   	.set_vlan_required = smc_lo_set_vlan_required,
>>   	.reset_vlan_required = smc_lo_reset_vlan_required,
>>   	.signal_event = smc_lo_signal_event,
>> -	.move_data		= NULL,
>> +	.move_data = smc_lo_move_data,
>>   	.supports_v2 = smc_lo_supports_v2,
>>   	.get_local_gid = smc_lo_get_local_gid,
>>   	.get_chid = smc_lo_get_chid,
>> @@ -173,6 +294,8 @@ static void smcd_lo_unregister_dev(struct
>> smc_lo_dev *ldev)
>>   static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>>   {
>>   	smc_lo_generate_ids(ldev);
>> +	rwlock_init(&ldev->dmb_ht_lock);
>> +	hash_init(ldev->dmb_ht);
>>   	return smcd_lo_register_dev(ldev);
>>   }
>>   
>> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
>> index 11868e5ac732..6c4a390430f3 100644
>> --- a/net/smc/smc_loopback.h
>> +++ b/net/smc/smc_loopback.h
>> @@ -20,13 +20,26 @@
>>   
>>   #if IS_ENABLED(CONFIG_SMC_LO)
>>   #define SMC_LO_MAX_DMBS		5000
>> +#define SMC_LO_DMBS_HASH_BITS	12
>>   #define SMC_LO_RESERVED_CHID	0xFFFF
>>   
>> +struct smc_lo_dmb_node {
>> +	struct hlist_node list;
>> +	u64 token;
>> +	u32 len;
>> +	u32 sba_idx;
>> +	void *cpu_addr;
>> +	dma_addr_t dma_addr;
>> +};
>> +
>>   struct smc_lo_dev {
>>   	struct smcd_dev *smcd;
>>   	struct device dev;
>>   	u16 chid;
>>   	struct smcd_gid local_gid;
>> +	rwlock_t dmb_ht_lock;
>> +	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
>> +	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
>>   };
>>   #endif
>>   

