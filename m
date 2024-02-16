Return-Path: <linux-kernel+bounces-68727-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 089F5857F15
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F25283D7B
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:14:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2B7012CD9D;
	Fri, 16 Feb 2024 14:14:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SoOHKGRO"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA50129A98;
	Fri, 16 Feb 2024 14:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708092871; cv=none; b=bAiFXD+Ffj/Eu5zHHhyBGAOF+08M7DhEgJVVc0i++etlvvBrkdGkhN2ysiPm+ZkVWnJtH/X+fR23lboLeAEOqK/4LeQ1xv7grd9fVuYh46/upTNV5Hd31HF/dZoq1ESv93wjOAjeumiOM/pZQlgIbkZ3qniYUZBZY94tPKlRM2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708092871; c=relaxed/simple;
	bh=0DqZIZHCyw37CznOHuuQBBPm2knyTsgO3ybdXR4J6Rk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=Glf0V0mebr/aYkR3TB48U+Wwb8MIjeq6ughyzqr4l7Udb+dpMHXWd1SHSyEox9rTMKP+f1WDx3x+8zxYM+KvUGoO15+TBJ1LDPZwt53ckwIvitUkysqrckQJknFBttb2AjvUvjf0l119IRWfnjvGISwi2ZWy0FAg3DhSS1hP0/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SoOHKGRO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41GDtogG027227;
	Fri, 16 Feb 2024 14:14:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : from : subject : to : cc : references : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=5TaaxpvaIyTm/2Fq/sH2S2Epctk3SOdQQKZF4H+VL2g=;
 b=SoOHKGROqzeveKXkhdKVif4g/Ns561HN2iW8wa+I56ZQqq1ZQNBID/x0DSmjVLiA42OM
 XEq/+VfisyUcglTvUEMv6xb23CSSVvkfZ/CvvpH0eahYen7f/6CCFN543qCKwRFDwsWD
 Rm254y4Wql+GHbKk6bCFWhVQskz5F9VcMgnlIajLnsH4UTqZRApb2/43bZP+NmrFpCaC
 FZP2OozPKmWlW4r4c/DueAEpHC+9/QXwotE25+TBKO7UY60+EN/AvGBWUyUTZPf254T7
 P8DZOKaY9r3tQXWpnw9/pdUgr8qFgH84GiWKyL11GYrJaNHvAvHkFFI7lFVB2L2vOLaA Ng== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7ehaudu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:14:22 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41GDwaTs002938;
	Fri, 16 Feb 2024 14:14:14 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wa7ehau1c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:14:14 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41GCv5Uj024762;
	Fri, 16 Feb 2024 14:13:31 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3w6mfpupcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 16 Feb 2024 14:13:31 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41GEDRaw27263410
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 16 Feb 2024 14:13:30 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C3E6058054;
	Fri, 16 Feb 2024 14:13:27 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4B3F958056;
	Fri, 16 Feb 2024 14:13:24 +0000 (GMT)
Received: from [9.171.40.55] (unknown [9.171.40.55])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 16 Feb 2024 14:13:24 +0000 (GMT)
Message-ID: <b5b4b96f-e512-4c1a-b749-f9fc3e7c2fcf@linux.ibm.com>
Date: Fri, 16 Feb 2024 15:13:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Wenjia Zhang <wenjia@linux.ibm.com>
Subject: Re: [PATCH net-next 06/15] net/smc: implement DMB-related operations
 of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com, hca@linux.ibm.com,
        gor@linux.ibm.com, agordeev@linux.ibm.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        jaka@linux.ibm.com, Gerd Bayer <gbayer@linux.ibm.com>
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240111120036.109903-1-guwen@linux.alibaba.com>
 <20240111120036.109903-7-guwen@linux.alibaba.com>
Content-Language: en-GB
In-Reply-To: <20240111120036.109903-7-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WQu8ihA1UWodao4lxfcBXZLMyYfMxF5S
X-Proofpoint-GUID: ml7wwRW1CB4IXsT77ekHFR2q0uUxhWIo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-16_13,2024-02-16_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 priorityscore=1501 lowpriorityscore=0 phishscore=0
 adultscore=0 bulkscore=0 mlxscore=0 suspectscore=0 mlxlogscore=999
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402160114



On 11.01.24 13:00, Wen Gu wrote:
> This implements DMB (un)registration and data move operations of
> loopback-ism device.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_cdc.c      |   6 ++
>   net/smc/smc_cdc.h      |   1 +
>   net/smc/smc_loopback.c | 133 ++++++++++++++++++++++++++++++++++++++++-
>   net/smc/smc_loopback.h |  13 ++++
>   4 files changed, 150 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_cdc.c b/net/smc/smc_cdc.c
> index 3c06625ceb20..c820ef197610 100644
> --- a/net/smc/smc_cdc.c
> +++ b/net/smc/smc_cdc.c
> @@ -410,6 +410,12 @@ static void smc_cdc_msg_recv(struct smc_sock *smc, struct smc_cdc_msg *cdc)
>   static void smcd_cdc_rx_tsklet(struct tasklet_struct *t)
>   {
>   	struct smc_connection *conn = from_tasklet(conn, t, rx_tsklet);
> +
> +	smcd_cdc_rx_handler(conn);
> +}
> +
> +void smcd_cdc_rx_handler(struct smc_connection *conn)
> +{
>   	struct smcd_cdc_msg *data_cdc;
>   	struct smcd_cdc_msg cdc;
>   	struct smc_sock *smc;
> diff --git a/net/smc/smc_cdc.h b/net/smc/smc_cdc.h
> index 696cc11f2303..11559d4ebf2b 100644
> --- a/net/smc/smc_cdc.h
> +++ b/net/smc/smc_cdc.h
> @@ -301,5 +301,6 @@ int smcr_cdc_msg_send_validation(struct smc_connection *conn,
>   				 struct smc_wr_buf *wr_buf);
>   int smc_cdc_init(void) __init;
>   void smcd_cdc_rx_init(struct smc_connection *conn);
> +void smcd_cdc_rx_handler(struct smc_connection *conn);
>   
>   #endif /* SMC_CDC_H */
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 353d4a2d69a1..f72e7b24fc1a 100644
> --- a/net/smc/smc_loopback.c
> +++ b/net/smc/smc_loopback.c
> @@ -15,11 +15,13 @@
>   #include <linux/types.h>
>   #include <net/smc.h>
>   
> +#include "smc_cdc.h"
>   #include "smc_ism.h"
>   #include "smc_loopback.h"
>   
>   #if IS_ENABLED(CONFIG_SMC_LO)
>   #define SMC_LO_V2_CAPABLE	0x1 /* loopback-ism acts as ISMv2 */
> +#define SMC_DMA_ADDR_INVALID	(~(dma_addr_t)0)
>   
>   static const char smc_lo_dev_name[] = "loopback-ism";
>   static struct smc_lo_dev *lo_dev;
> @@ -50,6 +52,97 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>   	return 0;
>   }
>   
> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
> +			       void *client_priv)
> +{
> +	struct smc_lo_dmb_node *dmb_node, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +	int sba_idx, order, rc;
> +	struct page *pages;
> +
> +	/* check space for new dmb */
> +	for_each_clear_bit(sba_idx, ldev->sba_idx_mask, SMC_LO_MAX_DMBS) {
> +		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
> +			break;
> +	}
> +	if (sba_idx == SMC_LO_MAX_DMBS)
> +		return -ENOSPC;
> +
> +	dmb_node = kzalloc(sizeof(*dmb_node), GFP_KERNEL);
> +	if (!dmb_node) {
> +		rc = -ENOMEM;
> +		goto err_bit;
> +	}
> +
> +	dmb_node->sba_idx = sba_idx;
> +	order = get_order(dmb->dmb_len);
> +	pages = alloc_pages(GFP_KERNEL | __GFP_NOWARN |
> +			    __GFP_NOMEMALLOC | __GFP_COMP |
> +			    __GFP_NORETRY | __GFP_ZERO,
> +			    order);
> +	if (!pages) {
> +		rc = -ENOMEM;
> +		goto err_node;
> +	}
> +	dmb_node->cpu_addr = (void *)page_address(pages);
> +	dmb_node->len = dmb->dmb_len;
> +	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
> +
> +again:
> +	/* add new dmb into hash table */
> +	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
> +	write_lock(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
> +		if (tmp_node->token == dmb_node->token) {
> +			write_unlock(&ldev->dmb_ht_lock);
> +			goto again;
> +		}
> +	}
> +	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
> +	write_unlock(&ldev->dmb_ht_lock);
> +
The write_lock_irqsave()/write_unlock_irqrestore() and 
read_lock_irqsave()/read_unlock_irqrestore()should be used instead of 
write_lock()/write_unlock() and read_lock()/read_unlock() in order to 
keep the lock irq-safe.

> +	dmb->sba_idx = dmb_node->sba_idx;
> +	dmb->dmb_tok = dmb_node->token;
> +	dmb->cpu_addr = dmb_node->cpu_addr;
> +	dmb->dma_addr = dmb_node->dma_addr;
> +	dmb->dmb_len = dmb_node->len;
> +
> +	return 0;
> +
> +err_node:
> +	kfree(dmb_node);
> +err_bit:
> +	clear_bit(sba_idx, ldev->sba_idx_mask);
> +	return rc;
> +}
> +
> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb)
> +{
> +	struct smc_lo_dmb_node *dmb_node = NULL, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +
> +	/* remove dmb from hash table */
> +	write_lock(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
> +		if (tmp_node->token == dmb->dmb_tok) {
> +			dmb_node = tmp_node;
> +			break;
> +		}
> +	}
> +	if (!dmb_node) {
> +		write_unlock(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	hash_del(&dmb_node->list);
> +	write_unlock(&ldev->dmb_ht_lock);
> +
> +	clear_bit(dmb_node->sba_idx, ldev->sba_idx_mask);
> +	kfree(dmb_node->cpu_addr);
> +	kfree(dmb_node);
> +
> +	return 0;
> +}
> +
>   static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
>   {
>   	return -EOPNOTSUPP;
> @@ -76,6 +169,38 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
>   	return 0;
>   }
>   
> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
> +			    unsigned int idx, bool sf, unsigned int offset,
> +			    void *data, unsigned int size)
> +{
> +	struct smc_lo_dmb_node *rmb_node = NULL, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +
> +	read_lock(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
> +		if (tmp_node->token == dmb_tok) {
> +			rmb_node = tmp_node;
> +			break;
> +		}
> +	}
> +	if (!rmb_node) {
> +		read_unlock(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	read_unlock(&ldev->dmb_ht_lock);
> +
> +	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
> +

Should this read_unlock be placed behind memcpy()?

<...>

