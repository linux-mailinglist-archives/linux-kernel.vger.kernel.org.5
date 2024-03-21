Return-Path: <linux-kernel+bounces-109758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 02810885555
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 09:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 845861F21A37
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 08:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEBB6994F;
	Thu, 21 Mar 2024 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CC0ycmjB"
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D9D1657A7;
	Thu, 21 Mar 2024 08:12:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711008756; cv=none; b=gjVREC6hE0s/Ix2H151nmADyFz+cSOmxpOqN+MXHI4GPAE7qg0QT0xz7DwTP3i25exAM/8h/AH7Hx+KNBKss2sI1cIWEQI9PeqxUjStDFuHbQdLr6ZdGdHyNxMTO9cpAgJ1JM+/kur4MFcJCGcX71Mhnn85pLcRv2j9H4BHsGsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711008756; c=relaxed/simple;
	bh=ulZcNxacmm26CF/WfLIisxNMedtoiLDZDm6+cfLgFlw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IURDkzLtQRMYRTb0gjDm2tNN1NoSl/7ktCzTwYqbzr+HpRwEq7145z2/2c5r2G/DD+XnEkCMhSmEFW3VF7BdCidw3vMsSocu8Fp12r5A5h30+EJ/sH9kfDwwtBvAGXGdF963eI3wD5kTgVgv7deaiQa4Ek9aoIdjDrF1Qm9b9bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CC0ycmjB; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42L6xVG3008807;
	Thu, 21 Mar 2024 08:12:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=pp1;
 bh=zQpDeWpsbr1lyB8Akwl4m/QrbtdZE0mflxyFeUTS66w=;
 b=CC0ycmjBRmWiExJjGyrkuccY2ZYQv854ByBhCoPq75P2U+8BoxWfe9Dxc2HKL2hJI/Yv
 nO26hlbsLdNfsTAD4pS9GrQnE/FQgEGAqi2uu2roLhrYTWaBfoJfHrFrpLBOhNMGG/4l
 7npRnJGMMbiNNEOy8D+2mPwTgvhn4C+em+8K3kZ605oTR88O8+ftEyqCR8r5+qknKFNu
 Z8t+lRbpKL0wS72jucjUY44DTM5gfjnBaaW1Lu1UJ+EDWRDUQver4HZN0uoT9A7G/ccX
 rW4gInouuc60sHEpHsrjO62q9Xvp732lA93lqzgrlQ28s/mReHtu8XOxvL6zrqyALlL0 Jg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0cq6gfqq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:29 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42L89awG016609;
	Thu, 21 Mar 2024 08:12:29 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0cq6gfqk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:29 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42L52T5d010045;
	Thu, 21 Mar 2024 08:12:28 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3wxvav8rsy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 21 Mar 2024 08:12:28 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42L8CL9851446088
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 Mar 2024 08:12:23 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 52EB320043;
	Thu, 21 Mar 2024 08:12:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4FB9B2004E;
	Thu, 21 Mar 2024 08:12:20 +0000 (GMT)
Received: from [9.179.15.41] (unknown [9.179.15.41])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 21 Mar 2024 08:12:20 +0000 (GMT)
Message-ID: <da8a60f1-dadf-4ab4-89b3-77e1ee45be03@linux.ibm.com>
Date: Thu, 21 Mar 2024 09:12:14 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH net-next v4 05/11] net/smc: implement DMB-related
 operations of loopback-ism
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
References: <20240317100545.96663-1-guwen@linux.alibaba.com>
 <20240317100545.96663-6-guwen@linux.alibaba.com>
From: Jan Karcher <jaka@linux.ibm.com>
Organization: IBM - Network Linux on Z
In-Reply-To: <20240317100545.96663-6-guwen@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: vtxk98kz1_kckuk6foL7eHfxCJ6Wc21p
X-Proofpoint-GUID: ihZV8HK6M3dnK_faoPQzZoNFz5mFXs2M
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_05,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 mlxlogscore=999 clxscore=1015 malwarescore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210054



On 17/03/2024 11:05, Wen Gu wrote:
> This implements DMB (un)registration and data move operations of
> loopback-ism device.
> 
> Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
> ---
>   net/smc/smc_loopback.c | 131 ++++++++++++++++++++++++++++++++++++++++-
>   net/smc/smc_loopback.h |  13 ++++
>   2 files changed, 141 insertions(+), 3 deletions(-)
> 
> diff --git a/net/smc/smc_loopback.c b/net/smc/smc_loopback.c
> index 253128c77208..7335acb03920 100644
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
> @@ -49,6 +51,93 @@ static int smc_lo_query_rgid(struct smcd_dev *smcd, struct smcd_gid *rgid,
>   	return 0;
>   }
>   
> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct smcd_dmb *dmb,
> +			       void *client_priv)
> +{
> +	struct smc_lo_dmb_node *dmb_node, *tmp_node;
> +	struct smc_lo_dev *ldev = smcd->priv;
> +	int sba_idx, rc;
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
> +	dmb_node->len = dmb->dmb_len;
> +	dmb_node->cpu_addr = kzalloc(dmb_node->len, GFP_KERNEL |
> +				     __GFP_NOWARN | __GFP_NORETRY |
> +				     __GFP_NOMEMALLOC);
> +	if (!dmb_node->cpu_addr) {
> +		rc = -ENOMEM;
> +		goto err_node;
> +	}
> +	dmb_node->dma_addr = SMC_DMA_ADDR_INVALID;
> +
> +again:
> +	/* add new dmb into hash table */
> +	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
> +	write_lock_bh(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_node->token) {
> +		if (tmp_node->token == dmb_node->token) {
> +			write_unlock_bh(&ldev->dmb_ht_lock);
> +			goto again;
> +		}
> +	}
> +	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
> +	write_unlock_bh(&ldev->dmb_ht_lock);
> +
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
> +	write_lock_bh(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb->dmb_tok) {
> +		if (tmp_node->token == dmb->dmb_tok) {
> +			dmb_node = tmp_node;
> +			break;
> +		}
> +	}
> +	if (!dmb_node) {
> +		write_unlock_bh(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	hash_del(&dmb_node->list);
> +	write_unlock_bh(&ldev->dmb_ht_lock);
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
> @@ -75,6 +164,40 @@ static int smc_lo_signal_event(struct smcd_dev *dev, struct smcd_gid *rgid,
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
> +	read_lock_bh(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb_tok) {
> +		if (tmp_node->token == dmb_tok) {
> +			rmb_node = tmp_node;
> +			break;
> +		}
> +	}
> +	if (!rmb_node) {
> +		read_unlock_bh(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	read_unlock_bh(&ldev->dmb_ht_lock);
> +
> +	memcpy((char *)rmb_node->cpu_addr + offset, data, size);

Hi Wen Gu,

Could we get into use after free trouble here if the dmb gets 
unregistered between the read_unlock and memcpy?


> +
> +	if (sf) {
> +		struct smc_connection *conn =
> +			smcd->conn[rmb_node->sba_idx];

Please put the `struct smc_connection *conn = NULL` at the top of the 
function and assign the value here.

Thanks
- Jan

> +
> +		if (conn && !conn->killed)
> +			tasklet_schedule(&conn->rx_tsklet);
> +		else
> +			return -EPIPE;
> +	}
> +	return 0;
> +}
> +
>   static int smc_lo_supports_v2(void)
>   {
>   	return SMC_LO_V2_CAPABLE;
> @@ -101,14 +224,14 @@ static struct device *smc_lo_get_dev(struct smcd_dev *smcd)
>   
>   static const struct smcd_ops lo_ops = {
>   	.query_remote_gid = smc_lo_query_rgid,
> -	.register_dmb		= NULL,
> -	.unregister_dmb		= NULL,
> +	.register_dmb = smc_lo_register_dmb,
> +	.unregister_dmb = smc_lo_unregister_dmb,
>   	.add_vlan_id = smc_lo_add_vlan_id,
>   	.del_vlan_id = smc_lo_del_vlan_id,
>   	.set_vlan_required = smc_lo_set_vlan_required,
>   	.reset_vlan_required = smc_lo_reset_vlan_required,
>   	.signal_event = smc_lo_signal_event,
> -	.move_data		= NULL,
> +	.move_data = smc_lo_move_data,
>   	.supports_v2 = smc_lo_supports_v2,
>   	.get_local_gid = smc_lo_get_local_gid,
>   	.get_chid = smc_lo_get_chid,
> @@ -173,6 +296,8 @@ static void smcd_lo_unregister_dev(struct smc_lo_dev *ldev)
>   static int smc_lo_dev_init(struct smc_lo_dev *ldev)
>   {
>   	smc_lo_generate_id(ldev);
> +	rwlock_init(&ldev->dmb_ht_lock);
> +	hash_init(ldev->dmb_ht);
>   	return smcd_lo_register_dev(ldev);
>   }
>   
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> index 55b41133a97f..24ab9d747613 100644
> --- a/net/smc/smc_loopback.h
> +++ b/net/smc/smc_loopback.h
> @@ -20,13 +20,26 @@
>   
>   #if IS_ENABLED(CONFIG_SMC_LO)
>   #define SMC_LO_MAX_DMBS		5000
> +#define SMC_LO_DMBS_HASH_BITS	12
>   #define SMC_LO_CHID		0xFFFF
>   
> +struct smc_lo_dmb_node {
> +	struct hlist_node list;
> +	u64 token;
> +	u32 len;
> +	u32 sba_idx;
> +	void *cpu_addr;
> +	dma_addr_t dma_addr;
> +};
> +
>   struct smc_lo_dev {
>   	struct smcd_dev *smcd;
>   	struct device dev;
>   	u16 chid;
>   	struct smcd_gid local_gid;
> +	rwlock_t dmb_ht_lock;
> +	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
> +	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
>   };
>   #endif
>   

