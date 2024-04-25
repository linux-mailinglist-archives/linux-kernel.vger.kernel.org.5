Return-Path: <linux-kernel+bounces-158120-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5512E8B1BD6
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 09:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81F8EB21420
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 07:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40706D1A7;
	Thu, 25 Apr 2024 07:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ea40uqhb"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335723A268
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 07:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714029841; cv=none; b=kIO8Hg/B+vF/le3BtlCuvpp7rfTtJUhWKcj+DMoFrLXeDiSaASHJp8PH2R608tsYoiqCoMH9AaHCypWl7HFZJ9smx0STWVtaOBoowLiw2cLaU0vmztntEUq0CszOIuXhPWzgTyx7hM03R8ghr6DV4rKdLuT77gfcwzBEn9t9X40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714029841; c=relaxed/simple;
	bh=XdTPNqZDq+ziNwqJB8EliwXYFYvP8QmiviT9n15AnqY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osZg3oroI1sY3c0XnXidSN9Z7IGTtjPUXq/AXOawjk1jvvB78DftNS9Sfw72IxMXdcWP+W7v6Cmw0Hw6It6TZnsFIT+kt8AIk31TpuwnNZ5tgxSCZ+wbkD9AR7L5/h/FDyi+oTb5YHxCzkkcpBSzTw8W57I49gufs4DeCE6cYao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ea40uqhb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714029838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IJ3Elwx6Y0fVYWKFfRMc1k14/K5qrk+7EMiwAoGT64Y=;
	b=ea40uqhbav8ah4gHohapspMRM4kLR4fs8TtyV0iTPiQcL0pvjgScYm4fes8QYpRLMylP3F
	2h2PKg8Fg8xuDkFEVj3OkJEE+0mFnRbMi85wNMQXAx2VqS7RAUZt3eA2T2Qgkd6qQUTSmN
	UEuEAu4VL20UZ9TsUhfcHuu84VCOUY8=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-4pH6kL4OMzmswOKwJ0Dcpg-1; Thu, 25 Apr 2024 03:23:56 -0400
X-MC-Unique: 4pH6kL4OMzmswOKwJ0Dcpg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6a0a0eb9cd9so2943846d6.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 00:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714029835; x=1714634635;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IJ3Elwx6Y0fVYWKFfRMc1k14/K5qrk+7EMiwAoGT64Y=;
        b=wYd8p0jPzTOaj8AxePwFbAWs6jCicDbff9Xl+kMK6TxedDfhutdWsS3ZyrQuNmOvha
         5U3ZMPME8eY+63vXYfAyAVFhyLKLqjUb73GS9O4+G324evZU0ZBnafDsXnnAHBDHx1gU
         NlTBAWRXaj8P1w8EZDlzjI7GE2Gp8ZD8QxaTLfV7Eosn5BmlXZK8UWHpipKsFn7uar7y
         zEdcs86tpeJuzXfJgQ/Pvo29DT/+FofwGYhNn5pW/aPkN5UUwrrVnHQSAxnQCM/pqd0S
         Dkw4OQR/C3Arh+1AiLW72zXrsqlXzT/mzRDixbSVDGM7+qAvOZ+LOPgRa7gNP1AsDZMQ
         rPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCURQNmdjEm7czkQ2PInlYi0RlimIddU4mc9A7r9WA46n2TNdifBg32B19bVyp8h6w5/pcULYzcDus72lr8ExP5XHgB2VZVuxDZM670S
X-Gm-Message-State: AOJu0YzpwWYOqg3nx8n1VzGJYwC5z4F1cjllqTrv1GZFLf3J9whbF0sU
	hVt1fn+xJolqZBZuuStkh9B9fJMKNPMcAt2j7t7Xv3smo/riy/qEjXj3gnd8rC479yzpawruJZQ
	FvAXox/DuPMLyCJl3Zk/La8bbc4R0k1cPvTr0L/zQMGzS6SvV5uWvE+WZM2alyaerkB591g==
X-Received: by 2002:a05:6214:2469:b0:6a0:919d:e3e4 with SMTP id im9-20020a056214246900b006a0919de3e4mr6818326qvb.21.1714029835262;
        Thu, 25 Apr 2024 00:23:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGzGtm//0CSWG48f1++BMvqfqT4o41XHdOjEhDYnuL+9J3A0be/e1vdfYhUUn52t3VJlr/GNg==
X-Received: by 2002:a05:6214:2469:b0:6a0:919d:e3e4 with SMTP id im9-20020a056214246900b006a0919de3e4mr6818304qvb.21.1714029834913;
        Thu, 25 Apr 2024 00:23:54 -0700 (PDT)
Received: from [192.168.1.132] ([193.177.210.114])
        by smtp.gmail.com with ESMTPSA id t10-20020a0ca68a000000b0069b432df140sm4315704qva.121.2024.04.25.00.23.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 00:23:54 -0700 (PDT)
Message-ID: <3878c16b-d6be-4935-a1ca-7f37dc677c59@redhat.com>
Date: Thu, 25 Apr 2024 09:23:50 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/8] net: psample: add multicast filtering on
 group_id
To: Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org, aconole@redhat.com, echaudro@redhat.com,
 horms@kernel.org, i.maximets@ovn.org, Yotam Gigi <yotam.gi@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 linux-kernel@vger.kernel.org
References: <20240424135109.3524355-1-amorenoz@redhat.com>
 <20240424135109.3524355-3-amorenoz@redhat.com> <ZikdFbmAbT5bWNxa@nanopsycho>
Content-Language: en-US
From: Adrian Moreno <amorenoz@redhat.com>
In-Reply-To: <ZikdFbmAbT5bWNxa@nanopsycho>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 4/24/24 16:54, Jiri Pirko wrote:
> Wed, Apr 24, 2024 at 03:50:49PM CEST, amorenoz@redhat.com wrote:
>> Packet samples can come from several places (e.g: different tc sample
>> actions), typically using the sample group (PSAMPLE_ATTR_SAMPLE_GROUP)
>> to differentiate them.
>>
>> Likewise, sample consumers that listen on the multicast group may only
>> be interested on a single group. However, they are currently forced to
>> receive all samples and discard the ones that are not relevant, causing
>> unnecessary overhead.
>>
>> Allow users to filter on the desired group_id by adding a new command
>> PSAMPLE_SET_FILTER that can be used to pass the desired group id.
>> Store this filter on the per-socket private pointer and use it for
>> filtering multicasted samples.
>>
>> Signed-off-by: Adrian Moreno <amorenoz@redhat.com>
>> ---
>> include/uapi/linux/psample.h |   1 +
>> net/psample/psample.c        | 110 +++++++++++++++++++++++++++++++++--
>> 2 files changed, 105 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/uapi/linux/psample.h b/include/uapi/linux/psample.h
>> index e585db5bf2d2..9d62983af0a4 100644
>> --- a/include/uapi/linux/psample.h
>> +++ b/include/uapi/linux/psample.h
>> @@ -28,6 +28,7 @@ enum psample_command {
>> 	PSAMPLE_CMD_GET_GROUP,
>> 	PSAMPLE_CMD_NEW_GROUP,
>> 	PSAMPLE_CMD_DEL_GROUP,
>> +	PSAMPLE_CMD_SET_FILTER,
>> };
>>
>> enum psample_tunnel_key_attr {
>> diff --git a/net/psample/psample.c b/net/psample/psample.c
>> index a5d9b8446f77..f5f77515b969 100644
>> --- a/net/psample/psample.c
>> +++ b/net/psample/psample.c
>> @@ -98,13 +98,77 @@ static int psample_nl_cmd_get_group_dumpit(struct sk_buff *msg,
>> 	return msg->len;
>> }
>>
>> -static const struct genl_small_ops psample_nl_ops[] = {
>> +struct psample_obj_desc {
>> +	struct rcu_head rcu;
>> +	u32 group_num;
>> +};
>> +
>> +struct psample_nl_sock_priv {
>> +	struct psample_obj_desc __rcu *filter;
>> +	spinlock_t filter_lock; /* Protects filter. */
>> +};
>> +
>> +static void psample_nl_sock_priv_init(void *priv)
>> +{
>> +	struct psample_nl_sock_priv *sk_priv = priv;
>> +
>> +	spin_lock_init(&sk_priv->filter_lock);
>> +}
>> +
>> +static void psample_nl_sock_priv_destroy(void *priv)
>> +{
>> +	struct psample_nl_sock_priv *sk_priv = priv;
>> +	struct psample_obj_desc *filter;
>> +
>> +	filter = rcu_dereference_protected(sk_priv->filter, true);
>> +	kfree_rcu(filter, rcu);
>> +}
>> +
>> +static int psample_nl_set_filter_doit(struct sk_buff *skb,
>> +				      struct genl_info *info)
>> +{
>> +	struct psample_obj_desc *filter = NULL;
>> +	struct psample_nl_sock_priv *sk_priv;
>> +	struct nlattr **attrs = info->attrs;
>> +
>> +	if (attrs[PSAMPLE_ATTR_SAMPLE_GROUP]) {
>> +		filter = kzalloc(sizeof(*filter), GFP_KERNEL);
>> +		filter->group_num =
>> +			nla_get_u32(attrs[PSAMPLE_ATTR_SAMPLE_GROUP]);
>> +	}
>> +
>> +	sk_priv = genl_sk_priv_get(&psample_nl_family, NETLINK_CB(skb).sk);
>> +	if (IS_ERR(sk_priv)) {
>> +		kfree(filter);
>> +		return PTR_ERR(sk_priv);
>> +	}
>> +
>> +	spin_lock(&sk_priv->filter_lock);
>> +	filter = rcu_replace_pointer(sk_priv->filter, filter,
>> +				     lockdep_is_held(&sk_priv->filter_lock));
>> +	spin_unlock(&sk_priv->filter_lock);
>> +	kfree_rcu(filter, rcu);
>> +	return 0;
>> +}
>> +
>> +static const struct nla_policy
>> +psample_set_filter_policy[PSAMPLE_ATTR_SAMPLE_GROUP + 1] = {
>> +	[PSAMPLE_ATTR_SAMPLE_GROUP] = { .type = NLA_U32, },
>> +};
>> +
>> +static const struct genl_ops psample_nl_ops[] = {
>> 	{
>> 		.cmd = PSAMPLE_CMD_GET_GROUP,
>> 		.validate = GENL_DONT_VALIDATE_STRICT | GENL_DONT_VALIDATE_DUMP,
>> 		.dumpit = psample_nl_cmd_get_group_dumpit,
>> 		/* can be retrieved by unprivileged users */
>> -	}
>> +	},
>> +	{
>> +		.cmd		= PSAMPLE_CMD_SET_FILTER,
>> +		.doit		= psample_nl_set_filter_doit,
>> +		.policy		= psample_set_filter_policy,
>> +		.flags		= 0,
>> +	},
> 
> Sidenote:
> Did you think about converting psample to split ops and to introcude
> ynl spec file for it?
>  

If split opts are preferred then sure, I can do that.

Thanks.

>> };
>>
>> static struct genl_family psample_nl_family __ro_after_init = {
>> @@ -114,10 +178,13 @@ static struct genl_family psample_nl_family __ro_after_init = {
>> 	.netnsok	= true,
>> 	.module		= THIS_MODULE,
>> 	.mcgrps		= psample_nl_mcgrps,
>> -	.small_ops	= psample_nl_ops,
>> -	.n_small_ops	= ARRAY_SIZE(psample_nl_ops),
>> +	.ops		= psample_nl_ops,
>> +	.n_ops		= ARRAY_SIZE(psample_nl_ops),
>> 	.resv_start_op	= PSAMPLE_CMD_GET_GROUP + 1,
>> 	.n_mcgrps	= ARRAY_SIZE(psample_nl_mcgrps),
>> +	.sock_priv_size		= sizeof(struct psample_nl_sock_priv),
>> +	.sock_priv_init		= psample_nl_sock_priv_init,
>> +	.sock_priv_destroy	= psample_nl_sock_priv_destroy,
>> };
>>
>> static void psample_group_notify(struct psample_group *group,
>> @@ -360,6 +427,32 @@ static int psample_tunnel_meta_len(struct ip_tunnel_info *tun_info)
>> }
>> #endif
>>
>> +static inline void psample_nl_obj_desc_init(struct psample_obj_desc *desc,
>> +					    u32 group_num)
>> +{
>> +	memset(desc, 0, sizeof(*desc));
>> +	desc->group_num = group_num;
>> +}
>> +
>> +static int psample_nl_sample_filter(struct sock *dsk, struct sk_buff *skb,
>> +				    void *data)
>> +{
>> +	struct psample_obj_desc *desc = data;
>> +	struct psample_nl_sock_priv *sk_priv;
>> +	struct psample_obj_desc *filter;
>> +	int ret = 0;
>> +
>> +	rcu_read_lock();
>> +	sk_priv = __genl_sk_priv_get(&psample_nl_family, dsk);
>> +	if (!IS_ERR_OR_NULL(sk_priv)) {
>> +		filter = rcu_dereference(sk_priv->filter);
>> +		if (filter && desc)
>> +			ret = (filter->group_num != desc->group_num);
>> +	}
>> +	rcu_read_unlock();
>> +	return ret;
>> +}
>> +
>> void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>> 			   u32 sample_rate, const struct psample_metadata *md)
>> {
>> @@ -370,6 +463,7 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>> #ifdef CONFIG_INET
>> 	struct ip_tunnel_info *tun_info;
>> #endif
>> +	struct psample_obj_desc desc;
>> 	struct sk_buff *nl_skb;
>> 	int data_len;
>> 	int meta_len;
>> @@ -487,8 +581,12 @@ void psample_sample_packet(struct psample_group *group, struct sk_buff *skb,
>> #endif
>>
>> 	genlmsg_end(nl_skb, data);
>> -	genlmsg_multicast_netns(&psample_nl_family, group->net, nl_skb, 0,
>> -				PSAMPLE_NL_MCGRP_SAMPLE, GFP_ATOMIC);
>> +	psample_nl_obj_desc_init(&desc, group->group_num);
>> +	genlmsg_multicast_netns_filtered(&psample_nl_family,
>> +					 group->net, nl_skb, 0,
>> +					 PSAMPLE_NL_MCGRP_SAMPLE,
>> +					 GFP_ATOMIC, psample_nl_sample_filter,
>> +					 &desc);
>>
>> 	return;
>> error:
>> -- 
>> 2.44.0
>>
>>
> 


