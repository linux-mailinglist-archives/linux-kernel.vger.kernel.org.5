Return-Path: <linux-kernel+bounces-85413-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2C7D86B58F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 18:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22755286B6C
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 17:07:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CB443FB85;
	Wed, 28 Feb 2024 17:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MgOp8wHL"
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76408208D7
	for <linux-kernel@vger.kernel.org>; Wed, 28 Feb 2024 17:07:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709140037; cv=none; b=ikXoQlltowRycNsS7zs2MKvZdGpL3xfMxR9LmcGlRhtYnNNDwjtngCo8XW2NMMuV4cLJ+m2+HPuhv3cgqv9/rlnkZzdiifC5DQTJYQ55ZzCBuXJENIM/K7hv2qhmZXUuZktBLQ4EczS2onNgYb9X/LEFSpxct1SGLhEHwd9i0ps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709140037; c=relaxed/simple;
	bh=25WA/KGC6+NxC9e941m1BSh4Wu491ERU7Z/Fe/1dKrg=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lYqHYeq/H4ytc6G6dgOmSU3vOfoJ87RsVX66LC2aDHv7tNcI7u7NR+xjGZ2WdPNSyBPQ1EhIPJwzzIilziUCK/if8yANusF5jm7wys+P9oFj+YUr7V0eE33ULdeSNKVvzmKFdA5BRsjAN4nA8Pfs60qwyDIlmhq1h0nXDDWn1u4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MgOp8wHL; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41S9jBhI018659;
	Wed, 28 Feb 2024 17:06:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	message-id:date:mime-version:subject:to:cc:references:from
	:in-reply-to:content-type:content-transfer-encoding; s=
	qcppdkim1; bh=Dbjdw2jZv+ElDsujRgM/8mJ37g09FKuY4XziLRRu71Q=; b=Mg
	Op8wHLTGZIaVndhYX4M3w5M/xC7Idip9QrSR0fAOiufU/0q/MQO/otSmP9HMTSrf
	2YDKs8u5gXwH0tdvHHbuPowF1xdh/HLN985g7jAiYj33E3bhPitOIQoUki92gs3A
	8OckTWXXIuuOL1sqboOmvwm5TT49Ua99RMV/FUgfupFEQ3kdoOcoSt4GQHFkt4pa
	d7BGgBY5KrnBMmcg5FXavE6s+1ikhFouH46JHl7/ayXZPfElzc6rsj+MNLuW0N8p
	xFrpeXjGOlaGisSi3xPlHQ4SKl2rSDYB9B9iKIa1drLrD266WOoZ8SF+LCugQBpZ
	P9woAyABNKRKy+M9+aRg==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3whv1fsxw7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:06:51 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41SH6nCg029334
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 28 Feb 2024 17:06:50 GMT
Received: from [10.131.33.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 28 Feb
 2024 09:06:46 -0800
Message-ID: <4fa47411-225d-e8cd-c5c7-79ac2de2f52d@quicinc.com>
Date: Wed, 28 Feb 2024 22:36:43 +0530
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] firmware: arm_scmi: Add support for multiple vendors
 custom protocols
Content-Language: en-US
To: Cristian Marussi <cristian.marussi@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>
CC: <sudeep.holla@arm.com>, <james.quinlan@broadcom.com>,
        <f.fainelli@gmail.com>, <vincent.guittot@linaro.org>,
        <peng.fan@oss.nxp.com>, <michal.simek@amd.com>,
        <quic_nkela@quicinc.com>, <souvik.chakravarty@arm.com>
References: <20240221220426.1205146-1-cristian.marussi@arm.com>
From: Sibi Sankar <quic_sibis@quicinc.com>
In-Reply-To: <20240221220426.1205146-1-cristian.marussi@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 5o_aFzCZtAO9C2kjboPRVe-LkN2oJUpo
X-Proofpoint-ORIG-GUID: 5o_aFzCZtAO9C2kjboPRVe-LkN2oJUpo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-28_08,2024-02-27_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 mlxlogscore=999 impostorscore=0 malwarescore=0 mlxscore=0 suspectscore=0
 adultscore=0 lowpriorityscore=0 priorityscore=1501 spamscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402280134



On 2/22/24 03:34, Cristian Marussi wrote:
> Add a mechanism to be able to tag vendor protocol modules at compile-time
> with a vendor/sub_vendor string and an implementation version and then to
> choose to load, at run-time, only those vendor protocol modules matching
> as close as possible the vendor/subvendor identification advertised by
> the SCMI platform server.
> 
> In this way, any in-tree existent vendor protocol module can be build and
> shipped by default in a single kernel image, even when using the same
> clashing protocol identification numbers, since the SCMI core will take
> care at run-time to load only the ones pertinent to the running system.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

Cristian,

Thanks for the patch.


> ---
> Hi all,
> 
> this is meant to address the possibility of having multiple vendors
> implementing distinct SCMI vendor protocols with possibly the same
> overlapping protocol number without the need of crafting the Kconfig
> at compile time to include only wanted protos
> (and without the need for a lottery :P)
> 
> Basic idea is simple:
> 
> - vendor protos HAS to be 'tagged' at build time with a vendor_id
> - vendor protos COULD also optionally be tagged at build time with
> sub_vendor_id and implemetation version
> 
> - at init all the build vendor protos are registerd with the SCMI core
>    using a key derived from the above tags
> 
> - at SCMI probe time the platform is identified via Base protocol as
>    usual and all the required vendor protos (i.e. IDs defined in the DT
>    as usual) are loaded after a lookup process based on the following rules:
> 
>    + protocol DB is searched using the platform/Base runtime provided tags
> 
>    	<vendor> / <sub_vendor> / <impl_ver>
> 
>      using the the following search logic (keys), first match:
> 
>       1. proto_id / <vendor_id> / <sub_vendor_id> / <impl_ver>
> 
>       2. proto_id / <vendor_id> / <sub_vendor_id> / 0
> 
>       3. proto_id / <vendor_id> / NULL / 0
> 
>    IOW, closest match, depending on how much fine grained is your
>    protocol tuned (tagged) for the platform.
> 
>    I am doubtful about the usage of <impl_ver>, and tempted to drop it
>    since we have anyway protocol version and NEGOTIATE_PROTOCOL_VERSION
>    to deal with slight difference in fw revision...
> 
> Based on sudeep/for-linux-next on top of
> 
> 	1c2c88cfcb2b ("clk: scmi: Support get/set duty_cycle operations")
> 
> Minimally tested ....
> 
>    Any feedback welcome
> 
>    Thanks,
>    Cristian
> ---
>   drivers/firmware/arm_scmi/driver.c    | 166 ++++++++++++++++++++++----
>   drivers/firmware/arm_scmi/protocols.h |   5 +
>   2 files changed, 149 insertions(+), 22 deletions(-)
> 
> diff --git a/drivers/firmware/arm_scmi/driver.c b/drivers/firmware/arm_scmi/driver.c
> index 34d77802c990..8fb2903698c9 100644
> --- a/drivers/firmware/arm_scmi/driver.c
> +++ b/drivers/firmware/arm_scmi/driver.c
> @@ -33,6 +33,7 @@
>   #include <linux/processor.h>
>   #include <linux/refcount.h>
>   #include <linux/slab.h>
> +#include <linux/xarray.h>
>   
>   #include "common.h"
>   #include "notify.h"
> @@ -44,8 +45,7 @@
>   
>   static DEFINE_IDA(scmi_id);
>   
> -static DEFINE_IDR(scmi_protocols);
> -static DEFINE_SPINLOCK(protocol_lock);
> +static DEFINE_XARRAY(scmi_protocols);
>   
>   /* List of all SCMI devices active in system */
>   static LIST_HEAD(scmi_list);
> @@ -194,11 +194,90 @@ struct scmi_info {
>   #define bus_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, bus_nb)
>   #define req_nb_to_scmi_info(nb)	container_of(nb, struct scmi_info, dev_req_nb)
>   
> -static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
> +static unsigned long
> +scmi_vendor_protocol_signature(unsigned protocol_id, char *vendor_id,
> +			       char *sub_vendor_id, u32 impl_ver)
>   {
> -	const struct scmi_protocol *proto;
> +	char *signature, *p;
> +	unsigned long hash = 0;
>   
> -	proto = idr_find(&scmi_protocols, protocol_id);
> +	/* vendor_id/sub_vendor_id guaranteed <= SCMI_SHORT_NAME_MAX_SIZE */
> +	signature = kasprintf(GFP_KERNEL, "%02X|%s|%s|0x%08X", protocol_id,
> +			      vendor_id ?: "", sub_vendor_id ?: "", impl_ver);
> +	if (!signature)
> +		return 0;
> +
> +	p = signature;
> +	while (*p)
> +		hash = partial_name_hash(tolower(*p++), hash);
> +	hash = end_name_hash(hash);
> +
> +	kfree(signature);
> +
> +	return hash;
> +}
> +
> +static unsigned long
> +scmi_protocol_key_calculate(int protocol_id, char *vendor_id,
> +			    char *sub_vendor_id, u32 impl_ver)
> +{
> +	if (protocol_id < SCMI_PROTOCOL_VENDOR)
> +		return protocol_id;
> +	else
> +		return scmi_vendor_protocol_signature(protocol_id, vendor_id,
> +						      sub_vendor_id, impl_ver);
> +}
> +
> +static const struct scmi_protocol *
> +scmi_vendor_protocol_lookup(int protocol_id, char *vendor_id,
> +			    char *sub_vendor_id, u32 impl_ver)
> +{
> +	unsigned long key;
> +	struct scmi_protocol *proto = NULL;
> +
> +	/* Searching for closest match ...*/
> +	key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> +					  sub_vendor_id, impl_ver);
> +	if (key)
> +		proto = xa_load(&scmi_protocols, key);
> +
> +	if (proto)
> +		return proto;
> +
> +	/* Any match on vendor/sub_vendor ? */
> +	if (impl_ver) {
> +		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> +						  sub_vendor_id, 0);
> +		if (key)
> +			proto = xa_load(&scmi_protocols, key);
> +
> +		if (proto)
> +			return proto;
> +	}
> +
> +	/* Any match on just the vendor ? */
> +	if (sub_vendor_id) {
> +		key = scmi_protocol_key_calculate(protocol_id, vendor_id,
> +						  NULL, 0);
> +		if (key)
> +			proto = xa_load(&scmi_protocols, key);
> +	}
> +
> +	return proto;
> +}
> +
> +static const struct scmi_protocol *
> +scmi_protocol_get(int protocol_id, struct scmi_revision_info *version)
> +{
> +	const struct scmi_protocol *proto = NULL;
> +
> +	if (protocol_id < SCMI_PROTOCOL_VENDOR)
> +		proto = xa_load(&scmi_protocols, protocol_id);
> +	else
> +		proto = scmi_vendor_protocol_lookup(protocol_id,
> +						    version->vendor_id,
> +						    version->sub_vendor_id,
> +						    version->impl_ver);
>   	if (!proto || !try_module_get(proto->owner)) {
>   		pr_warn("SCMI Protocol 0x%x not found!\n", protocol_id);
>   		return NULL;
> @@ -206,21 +285,47 @@ static const struct scmi_protocol *scmi_protocol_get(int protocol_id)
>   
>   	pr_debug("Found SCMI Protocol 0x%x\n", protocol_id);
>   
> +	if (protocol_id >= SCMI_PROTOCOL_VENDOR)
> +		pr_info("Loaded SCMI Vendor Protocol 0x%x - %s %s %X\n",
> +			protocol_id, proto->vendor_id ?: "",
> +			proto->sub_vendor_id ?: "", proto->impl_ver);
> +
>   	return proto;
>   }
>   
> -static void scmi_protocol_put(int protocol_id)
> +static void scmi_protocol_put(const struct scmi_protocol *proto)
>   {
> -	const struct scmi_protocol *proto;
> -
> -	proto = idr_find(&scmi_protocols, protocol_id);
>   	if (proto)
>   		module_put(proto->owner);
>   }
>   
> +static int scmi_vendor_protocol_check(const struct scmi_protocol *proto)
> +{
> +	if (!proto->vendor_id) {
> +		pr_err("missing vendor_id for protocol 0x%x\n", proto->id);
> +		return -EINVAL;
> +	}
> +
> +	if (proto->vendor_id &&

You can drop ^^, since you've already checked for it.

Reviewed-and-Tested-by: Sibi Sankar <quic_sibis@quicinc.com>

> +	    strlen(proto->vendor_id) >= SCMI_SHORT_NAME_MAX_SIZE) {
> +		pr_err("malformed vendor_id for protocol 0x%x\n", proto->id);
> +		return -EINVAL;
> +	}
> +
> +	if (proto->sub_vendor_id &&
> +	    strlen(proto->sub_vendor_id) >= SCMI_SHORT_NAME_MAX_SIZE) {
> +		pr_err("malformed sub_vendor_id for protocol 0x%x\n",
> +		       proto->id);
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}
> +
>   int scmi_protocol_register(const struct scmi_protocol *proto)
>   {
>   	int ret;
> +	unsigned long key;
>   
>   	if (!proto) {
>   		pr_err("invalid protocol\n");
> @@ -232,12 +337,23 @@ int scmi_protocol_register(const struct scmi_protocol *proto)
>   		return -EINVAL;
>   	}
>   
> -	spin_lock(&protocol_lock);
> -	ret = idr_alloc(&scmi_protocols, (void *)proto,
> -			proto->id, proto->id + 1, GFP_ATOMIC);
> -	spin_unlock(&protocol_lock);
> -	if (ret != proto->id) {
> -		pr_err("unable to allocate SCMI idr slot for 0x%x - err %d\n",
> +	if (proto->id >= SCMI_PROTOCOL_VENDOR &&
> +	    scmi_vendor_protocol_check(proto))
> +		return -EINVAL;
> +
> +	/*
> +	 * Calculate a protocol key to register this protocol with the core;
> +	 * key value 0 is considered invalid.
> +	 */
> +	key = scmi_protocol_key_calculate(proto->id, proto->vendor_id,
> +					  proto->sub_vendor_id,
> +					  proto->impl_ver);
> +	if (!key)
> +		return -EINVAL;
> +
> +	ret = xa_insert(&scmi_protocols, key, (void *)proto, GFP_KERNEL);
> +	if (ret) {
> +		pr_err("unable to allocate SCMI protocol slot for 0x%x - err %d\n",
>   		       proto->id, ret);
>   		return ret;
>   	}
> @@ -250,9 +366,15 @@ EXPORT_SYMBOL_GPL(scmi_protocol_register);
>   
>   void scmi_protocol_unregister(const struct scmi_protocol *proto)
>   {
> -	spin_lock(&protocol_lock);
> -	idr_remove(&scmi_protocols, proto->id);
> -	spin_unlock(&protocol_lock);
> +	unsigned long key;
> +
> +	key = scmi_protocol_key_calculate(proto->id, proto->vendor_id,
> +					  proto->sub_vendor_id,
> +					  proto->impl_ver);
> +	if (!key)
> +		return;
> +
> +	xa_erase(&scmi_protocols, key);
>   
>   	pr_debug("Unregistered SCMI Protocol 0x%x\n", proto->id);
>   }
> @@ -1888,7 +2010,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
>   	/* Protocol specific devres group */
>   	gid = devres_open_group(handle->dev, NULL, GFP_KERNEL);
>   	if (!gid) {
> -		scmi_protocol_put(proto->id);
> +		scmi_protocol_put(pi->proto);
>   		goto out;
>   	}
>   
> @@ -1952,7 +2074,7 @@ scmi_alloc_init_protocol_instance(struct scmi_info *info,
>   
>   clean:
>   	/* Take care to put the protocol module's owner before releasing all */
> -	scmi_protocol_put(proto->id);
> +	scmi_protocol_put(proto);
>   	devres_release_group(handle->dev, gid);
>   out:
>   	return ERR_PTR(ret);
> @@ -1986,7 +2108,7 @@ scmi_get_protocol_instance(const struct scmi_handle *handle, u8 protocol_id)
>   		const struct scmi_protocol *proto;
>   
>   		/* Fails if protocol not registered on bus */
> -		proto = scmi_protocol_get(protocol_id);
> +		proto = scmi_protocol_get(protocol_id, &info->version);
>   		if (proto)
>   			pi = scmi_alloc_init_protocol_instance(info, proto);
>   		else
> @@ -2041,7 +2163,7 @@ void scmi_protocol_release(const struct scmi_handle *handle, u8 protocol_id)
>   
>   		idr_remove(&info->protocols, protocol_id);
>   
> -		scmi_protocol_put(protocol_id);
> +		scmi_protocol_put(pi->proto);
>   
>   		devres_release_group(handle->dev, gid);
>   		dev_dbg(handle->dev, "De-Initialized protocol: 0x%X\n",
> diff --git a/drivers/firmware/arm_scmi/protocols.h b/drivers/firmware/arm_scmi/protocols.h
> index 693019fff0f6..cb8dbc93584b 100644
> --- a/drivers/firmware/arm_scmi/protocols.h
> +++ b/drivers/firmware/arm_scmi/protocols.h
> @@ -29,6 +29,8 @@
>   #define PROTOCOL_REV_MAJOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MAJOR_MASK, (x))))
>   #define PROTOCOL_REV_MINOR(x)	((u16)(FIELD_GET(PROTOCOL_REV_MINOR_MASK, (x))))
>   
> +#define SCMI_PROTOCOL_VENDOR	0x80
> +
>   enum scmi_common_cmd {
>   	PROTOCOL_VERSION = 0x0,
>   	PROTOCOL_ATTRIBUTES = 0x1,
> @@ -330,6 +332,9 @@ struct scmi_protocol {
>   	const void				*ops;
>   	const struct scmi_protocol_events	*events;
>   	unsigned int				supported_version;
> +	u32					impl_ver;
> +	char					*vendor_id;
> +	char					*sub_vendor_id;
>   };
>   
>   #define DEFINE_SCMI_PROTOCOL_REGISTER_UNREGISTER(name, proto)	\

