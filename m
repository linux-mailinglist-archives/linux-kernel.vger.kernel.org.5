Return-Path: <linux-kernel+bounces-130374-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9D1897744
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 19:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 277361F31607
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 17:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7216156C4A;
	Wed,  3 Apr 2024 17:24:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="AH74z72t"
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD60153804;
	Wed,  3 Apr 2024 17:24:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712165090; cv=none; b=UTdbEC9XfD17VyOKC0pJv5f+JOs++h0+JBd9oNK8f9VL+/kXcxDIEWqWVSTlVpdDJnpLsnv34OSXwhcG2x3UHmiG3NtgF4ZKgNMTsJWFCu2E2QSsDTWN/vJzIXsv9AgC8D28Z2VTjreWx15fmqejWOEEpQ/dpejXwCbUvyXezas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712165090; c=relaxed/simple;
	bh=WSl2CWIioYtJLWZUU5CrGm4F+P0W6P1f7WrRIu4Xl+Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=LXyyXxPzV9QN0PHXvCx51ZvoRi156SnNkXRtHoxaxgw1Jl64aQr7sPR285yqF3DJr4FCTj7ZAq0mpwpm/jOF2BnBqwIAXAv3seRd4hkCuYT9ZqceB2oTtS06+/gCSTDh3/yeUzCRKBw0G9Bitcy0TVCeh9Ciag7Vq1taaB33f7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=AH74z72t; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353727.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 433GxsWX025271;
	Wed, 3 Apr 2024 17:24:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=EgsLd81nrFvAc2UOfRG3wkL5UTIq3fQxcwLsijO8Pps=;
 b=AH74z72tniQJjt0ZNSUfJakvXumtwiskiqCLvyVUA8ITSypIycWSRiP12qT2SWhXfdrf
 WYperHvKwuCWtrTU+APBbQTNMHTbAz6vhJaTVc5wFe4oXcWq1d7UIi6kHYLFoMpaTf9P
 a0x5wYs5y9jBufASCyBrrQdT/AGRgs4nMsrHeJB9h6eBkNvJIRaseheKI7z2inaU1g1w
 +MJPlwPyaHMaYkK83YkMX2knOzx0W0oN5UczzCx7PwLkvRthhDgMLOFhMF4Q++1Gjzka
 445Bdxhr4lIfd7k6BbzwAsGHb1TGZK36vaJSN1I5RAe/VJYt0sgpWa9kzjukoc5ckOZ8 fg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9ass8579-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:24:43 +0000
Received: from m0353727.ppops.net (m0353727.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 433HKcnT003882;
	Wed, 3 Apr 2024 17:20:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x9ass8571-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:20:38 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 433FjUFo029616;
	Wed, 3 Apr 2024 17:20:37 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3x6ys36baa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 03 Apr 2024 17:20:37 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 433HKW2i50987312
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 3 Apr 2024 17:20:34 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CD132004B;
	Wed,  3 Apr 2024 17:20:32 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 368E620040;
	Wed,  3 Apr 2024 17:20:31 +0000 (GMT)
Received: from [9.171.60.51] (unknown [9.171.60.51])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  3 Apr 2024 17:20:31 +0000 (GMT)
Message-ID: <9a17268d4046f99b30f3620079b5749a9ddc5cd9.camel@linux.ibm.com>
Subject: Re: [RFC PATCH net-next v5 05/11] net/smc: implement DMB-related
 operations of loopback-ism
From: Gerd Bayer <gbayer@linux.ibm.com>
To: Wen Gu <guwen@linux.alibaba.com>, wintera@linux.ibm.com,
        twinkler@linux.ibm.com, hca@linux.ibm.com, gor@linux.ibm.com,
        agordeev@linux.ibm.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, wenjia@linux.ibm.com,
        jaka@linux.ibm.com
Cc: borntraeger@linux.ibm.com, svens@linux.ibm.com, alibuda@linux.alibaba.com,
        tonylu@linux.alibaba.com, linux-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, netdev@vger.kernel.org
Date: Wed, 03 Apr 2024 19:20:30 +0200
In-Reply-To: <20240324135522.108564-6-guwen@linux.alibaba.com>
References: <20240324135522.108564-1-guwen@linux.alibaba.com>
	 <20240324135522.108564-6-guwen@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-2.fc39app4) 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _k7M7X341RIZlu6Ws_JCrzymVAeJc5bb
X-Proofpoint-ORIG-GUID: GGVGokz-tYaB_sbZebDOcMVEhJjtyg1y
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-03_18,2024-04-03_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 malwarescore=0 suspectscore=0 clxscore=1015 mlxlogscore=999
 impostorscore=0 priorityscore=1501 bulkscore=0 spamscore=0 phishscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403210000 definitions=main-2404030117

On Sun, 2024-03-24 at 21:55 +0800, Wen Gu wrote:

When I instrumented this to see, why I still see tons of my other
temporary instrumentation messages from the "ism" driver, I found that
in my setup loopback-ism is used rather infrequently.

I suspect this is due to how the SMC proposals are constructed in
net/smc/af_smc.c and net/smc/smc_pnet.c - and later evaluated in
smc_check_ism_v2_match() - where there is a first-come-first-serve
selection.

I wonder if one should change that to favour loopback-ism over "real"
ISM devices - and how this could be achieved elegantly.

Just some food for thought... Probably little you can do on x86.

Thanks,
Gerd

> +static int smc_lo_register_dmb(struct smcd_dev *smcd, struct
> smcd_dmb *dmb,
> +			=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 void *client_priv)
> +{
> +	struct smc_lo_dmb_node *dmb_node, *tmp_node;
> +	struct smc_lo_dev *ldev =3D smcd->priv;
> +	int sba_idx, rc;
> +
> +	/* check space for new dmb */
> +	for_each_clear_bit(sba_idx, ldev->sba_idx_mask,
> SMC_LO_MAX_DMBS) {
> +		if (!test_and_set_bit(sba_idx, ldev->sba_idx_mask))
> +			break;
> +	}
> +	if (sba_idx =3D=3D SMC_LO_MAX_DMBS)
> +		return -ENOSPC;
> +
> +	dmb_node =3D kzalloc(sizeof(*dmb_node), GFP_KERNEL);
> +	if (!dmb_node) {
> +		rc =3D -ENOMEM;
> +		goto err_bit;
> +	}
> +
> +	dmb_node->sba_idx =3D sba_idx;
> +	dmb_node->len =3D dmb->dmb_len;
> +	dmb_node->cpu_addr =3D kzalloc(dmb_node->len, GFP_KERNEL |
> +				=C2=A0=C2=A0=C2=A0=C2=A0 __GFP_NOWARN | __GFP_NORETRY |
> +				=C2=A0=C2=A0=C2=A0=C2=A0 __GFP_NOMEMALLOC);
> +	if (!dmb_node->cpu_addr) {
> +		rc =3D -ENOMEM;
> +		goto err_node;
> +	}
> +	dmb_node->dma_addr =3D SMC_DMA_ADDR_INVALID;
> +
> +again:
> +	/* add new dmb into hash table */
> +	get_random_bytes(&dmb_node->token, sizeof(dmb_node->token));
> +	write_lock_bh(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list,
> dmb_node->token) {
> +		if (tmp_node->token =3D=3D dmb_node->token) {
> +			write_unlock_bh(&ldev->dmb_ht_lock);
> +			goto again;
> +		}
> +	}
> +	hash_add(ldev->dmb_ht, &dmb_node->list, dmb_node->token);
> +	write_unlock_bh(&ldev->dmb_ht_lock);
> +
> +	dmb->sba_idx =3D dmb_node->sba_idx;
> +	dmb->dmb_tok =3D dmb_node->token;
> +	dmb->cpu_addr =3D dmb_node->cpu_addr;
> +	dmb->dma_addr =3D dmb_node->dma_addr;
> +	dmb->dmb_len =3D dmb_node->len;
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
> +static int smc_lo_unregister_dmb(struct smcd_dev *smcd, struct
> smcd_dmb *dmb)
> +{
> +	struct smc_lo_dmb_node *dmb_node =3D NULL, *tmp_node;
> +	struct smc_lo_dev *ldev =3D smcd->priv;
> +
> +	/* remove dmb from hash table */
> +	write_lock_bh(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list, dmb-
> >dmb_tok) {
> +		if (tmp_node->token =3D=3D dmb->dmb_tok) {
> +			dmb_node =3D tmp_node;
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
> =C2=A0static int smc_lo_add_vlan_id(struct smcd_dev *smcd, u64 vlan_id)
> =C2=A0{
> =C2=A0	return -EOPNOTSUPP;
> @@ -75,6 +164,38 @@ static int smc_lo_signal_event(struct smcd_dev
> *dev, struct smcd_gid *rgid,
> =C2=A0	return 0;
> =C2=A0}
> =C2=A0
> +static int smc_lo_move_data(struct smcd_dev *smcd, u64 dmb_tok,
> +			=C2=A0=C2=A0=C2=A0 unsigned int idx, bool sf, unsigned int
> offset,
> +			=C2=A0=C2=A0=C2=A0 void *data, unsigned int size)
> +{
> +	struct smc_lo_dmb_node *rmb_node =3D NULL, *tmp_node;
> +	struct smc_lo_dev *ldev =3D smcd->priv;
> +	struct smc_connection *conn;
> +
> +	read_lock_bh(&ldev->dmb_ht_lock);
> +	hash_for_each_possible(ldev->dmb_ht, tmp_node, list,
> dmb_tok) {
> +		if (tmp_node->token =3D=3D dmb_tok) {
> +			rmb_node =3D tmp_node;
> +			break;
> +		}
> +	}
> +	if (!rmb_node) {
> +		read_unlock_bh(&ldev->dmb_ht_lock);
> +		return -EINVAL;
> +	}
> +	memcpy((char *)rmb_node->cpu_addr + offset, data, size);
> +	read_unlock_bh(&ldev->dmb_ht_lock);
> +
> +	if (sf) {
> +		conn =3D smcd->conn[rmb_node->sba_idx];
> +		if (conn && !conn->killed)
> +			tasklet_schedule(&conn->rx_tsklet);
> +		else
> +			return -EPIPE;
> +	}
> +	return 0;
> +}
> +
> =C2=A0static int smc_lo_supports_v2(void)
> =C2=A0{
> =C2=A0	return SMC_LO_V2_CAPABLE;
> @@ -101,14 +222,14 @@ static struct device *smc_lo_get_dev(struct
> smcd_dev *smcd)
> =C2=A0
> =C2=A0static const struct smcd_ops lo_ops =3D {
> =C2=A0	.query_remote_gid =3D smc_lo_query_rgid,
> -	.register_dmb		=3D NULL,
> -	.unregister_dmb		=3D NULL,
> +	.register_dmb =3D smc_lo_register_dmb,
> +	.unregister_dmb =3D smc_lo_unregister_dmb,
> =C2=A0	.add_vlan_id =3D smc_lo_add_vlan_id,
> =C2=A0	.del_vlan_id =3D smc_lo_del_vlan_id,
> =C2=A0	.set_vlan_required =3D smc_lo_set_vlan_required,
> =C2=A0	.reset_vlan_required =3D smc_lo_reset_vlan_required,
> =C2=A0	.signal_event =3D smc_lo_signal_event,
> -	.move_data		=3D NULL,
> +	.move_data =3D smc_lo_move_data,
> =C2=A0	.supports_v2 =3D smc_lo_supports_v2,
> =C2=A0	.get_local_gid =3D smc_lo_get_local_gid,
> =C2=A0	.get_chid =3D smc_lo_get_chid,
> @@ -173,6 +294,8 @@ static void smcd_lo_unregister_dev(struct
> smc_lo_dev *ldev)
> =C2=A0static int smc_lo_dev_init(struct smc_lo_dev *ldev)
> =C2=A0{
> =C2=A0	smc_lo_generate_ids(ldev);
> +	rwlock_init(&ldev->dmb_ht_lock);
> +	hash_init(ldev->dmb_ht);
> =C2=A0	return smcd_lo_register_dev(ldev);
> =C2=A0}
> =C2=A0
> diff --git a/net/smc/smc_loopback.h b/net/smc/smc_loopback.h
> index 11868e5ac732..6c4a390430f3 100644
> --- a/net/smc/smc_loopback.h
> +++ b/net/smc/smc_loopback.h
> @@ -20,13 +20,26 @@
> =C2=A0
> =C2=A0#if IS_ENABLED(CONFIG_SMC_LO)
> =C2=A0#define SMC_LO_MAX_DMBS		5000
> +#define SMC_LO_DMBS_HASH_BITS	12
> =C2=A0#define SMC_LO_RESERVED_CHID	0xFFFF
> =C2=A0
> +struct smc_lo_dmb_node {
> +	struct hlist_node list;
> +	u64 token;
> +	u32 len;
> +	u32 sba_idx;
> +	void *cpu_addr;
> +	dma_addr_t dma_addr;
> +};
> +
> =C2=A0struct smc_lo_dev {
> =C2=A0	struct smcd_dev *smcd;
> =C2=A0	struct device dev;
> =C2=A0	u16 chid;
> =C2=A0	struct smcd_gid local_gid;
> +	rwlock_t dmb_ht_lock;
> +	DECLARE_BITMAP(sba_idx_mask, SMC_LO_MAX_DMBS);
> +	DECLARE_HASHTABLE(dmb_ht, SMC_LO_DMBS_HASH_BITS);
> =C2=A0};
> =C2=A0#endif
> =C2=A0


