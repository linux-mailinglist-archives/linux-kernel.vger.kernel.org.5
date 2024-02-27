Return-Path: <linux-kernel+bounces-83122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 52EE9868EB9
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 12:25:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 654AFB239C0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 11:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BF613959B;
	Tue, 27 Feb 2024 11:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="QoEZRPfN"
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E75139580
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 11:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709033141; cv=none; b=lplfQls6rGYuM6u9iwUFQPNoxmnXmbNgNSE/GUiL1umZ1s7WQAlia3wfH5POiq7R0p+39mGU8r+2kSdA997L14f9klIgn+mieBsH+s8tRo0hSODVZom5OVMBIZH6RxhARcauOCeMNKeP1traFtmPQVHVHph85l8tVgTbWKE/t/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709033141; c=relaxed/simple;
	bh=C7BovUgZxD1vPO2Pt0Fk5S5FcxhE6gMOTFf3j8+GrvA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Xy1v+/ZAgCQDyH/0oyZQZcHZNP8RiXNRnLxDZYKcfn9xvvF81HAaCRKNMmy0d3QJGOdQ1FHCBPOufwMfuXGL7nercW6JY8D3MffKk9/bGCwfQkPnDJvLPQUmvCu+Yy5IBNSnvbEgV4LPHUIEuNGhznN+qefhT3z3xA+x7xWsK1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=QoEZRPfN; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-563d32ee33aso5404164a12.2
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 03:25:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1709033138; x=1709637938; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KI5eG390ffSqx8RaN+jlA/4cItpLtfyutTUFjdeBTiI=;
        b=QoEZRPfNncNPzTQsKNwex2/f4j18vpCXq0Z3O4BWCq3P58Rn4yhSieZs8myCeF37Gj
         UPnfFmBApgWKOet7zpT1EKPMXUhHOm5BYKxPMNDke/AFt4g8Kma/yXlPTn/HUQJKau2/
         /+nCTrkC0YvkpyKEXNtplikMzR/GKWZ+ztyTCgGIVoggYgsv+vGzQctK+8cIG4m67ksT
         yC0a0aXZIyGICWIH8YJyAdC0025qzXzZmWxPVqGqQiIfylZUKJUuNIR+3FVzm3bY0xmR
         Mhr5xU2jkcVsFOQTIBU/IeJQSrV6Uc2tN8YfmsD9iRgy4M6TkFaoX+eRBOQyt2ltYcnb
         Kqvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709033138; x=1709637938;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KI5eG390ffSqx8RaN+jlA/4cItpLtfyutTUFjdeBTiI=;
        b=wPuI//aoo81Nlj+UkKr/+7e+XB7B4JGlN3SjdsbCDOzDDAxnVDT++HtYRbVCfyqHfN
         NKD+E7Zq2iMMsVBHHALoTHb5u/lQmEp+8FSRDF83igEq/wFuLgPCOZiDt5mmqOUbAW7U
         jkWQ/Y1w8EFvOqtN3dxpPDWDxKoirgazZl37+JXAcDVRV7Wp6HdsAnsbJunX8cPomZwd
         ZvFbZXLFEn+wkiWj5LTiRxtpTEqwJVeawnEKbieiEM742ikXb40nDYlj/eQyFlrJkyIf
         FnuyxbYtXoG/zc5d5tnkHDpCofZByBT3qoM/rCLfWfcoCYMpkpWo0aTZjwUcZedWqDqH
         3cPw==
X-Forwarded-Encrypted: i=1; AJvYcCVR1KA/KSAUmzYPUS1evyLMIxUf7I77vEgF2k2HI19EKWuhj0gGZPOb+1/aoVlYYfEP5uDauPjmNRhSvDw+Q1zc+OD81LJWKmADedVq
X-Gm-Message-State: AOJu0Yy3SF2lYsJw7zkEZEGlJPZKrfqSDPTqpz1jiUKgw/n2aOMTk/N/
	U16Rxm7qbCtijXEonXdFr0GuI1EeA3WCYbH6FiLabklW5JGIx1mwrYJ6wbej0KY=
X-Google-Smtp-Source: AGHT+IFy4uluv/VsL/2WcZACDpFxBiKsa+fEDJaw3YIafNxBNEfprH/FeAO/eRyK8+8jt8Od93ofMQ==
X-Received: by 2002:a05:6402:2050:b0:565:e360:aee4 with SMTP id bc16-20020a056402205000b00565e360aee4mr3484699edb.18.1709033137467;
        Tue, 27 Feb 2024 03:25:37 -0800 (PST)
Received: from [192.168.0.106] (176.111.183.96.kyiv.volia.net. [176.111.183.96])
        by smtp.gmail.com with ESMTPSA id c5-20020a0564021f8500b005653439cadcsm672933edc.25.2024.02.27.03.25.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 03:25:37 -0800 (PST)
Message-ID: <2e8c704f-e6a6-40b8-8d4b-7c3a987c4839@blackwall.org>
Date: Tue, 27 Feb 2024 13:25:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v1] rtnetlink: fix error logic of IFLA_BRIDGE_FLAGS
 writing back
Content-Language: en-US
To: Lin Ma <linma@zju.edu.cn>, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, idosch@nvidia.com, jiri@resnulli.us,
 lucien.xin@gmail.com, edwin.peer@broadcom.com, amcohen@nvidia.com,
 pctammela@mojatatu.com, liuhangbin@gmail.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240227110113.573334-1-linma@zju.edu.cn>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240227110113.573334-1-linma@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/27/24 13:01, Lin Ma wrote:
> In the commit d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks
> IFLA_BRIDGE_MODE length"), an adjustment was made to the old loop logic
> in the function `rtnl_bridge_setlink` to enable the loop to also check
> the length of the IFLA_BRIDGE_MODE attribute. However, this adjustment
> removed the `break` statement and led to an error logic of the flags
> writing back at the end of this function.
> 
> if (have_flags)
>      memcpy(nla_data(attr), &flags, sizeof(flags));
>      // attr should point to IFLA_BRIDGE_FLAGS NLA !!!
> 
> Before the mentioned commit, the `attr` is granted to be IFLA_BRIDGE_FLAGS.
> However, this is not necessarily true fow now as the updated loop will let
> the attr point to the last NLA, even an invalid NLA which could cause
> overflow writes.
> 
> This patch introduces a new variable `br_flag` to save the NLA pointer
> that points to IFLA_BRIDGE_FLAGS and uses it to resolve the mentioned
> error logic.
> 
> Fixes: d73ef2d69c0d ("rtnetlink: let rtnl_bridge_setlink checks IFLA_BRIDGE_MODE length")
> Signed-off-by: Lin Ma <linma@zju.edu.cn>
> ---

That fix is obviously broken, I don't know how I missed it back then.
One comment below,

>   net/core/rtnetlink.c | 11 +++++------
>   1 file changed, 5 insertions(+), 6 deletions(-)
> 
> diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
> index 9c4f427f3a50..e9f16e5e3515 100644
> --- a/net/core/rtnetlink.c
> +++ b/net/core/rtnetlink.c
> @@ -5169,10 +5169,9 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	struct net *net = sock_net(skb->sk);
>   	struct ifinfomsg *ifm;
>   	struct net_device *dev;
> -	struct nlattr *br_spec, *attr = NULL;
> +	struct nlattr *br_spec, *attr, *br_flag = NULL;

Please name the variable to something that describes it better, like
br_flags_attr.

>   	int rem, err = -EOPNOTSUPP;
>   	u16 flags = 0;
> -	bool have_flags = false;
>   
>   	if (nlmsg_len(nlh) < sizeof(*ifm))
>   		return -EINVAL;
> @@ -5190,11 +5189,11 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   	br_spec = nlmsg_find_attr(nlh, sizeof(struct ifinfomsg), IFLA_AF_SPEC);
>   	if (br_spec) {
>   		nla_for_each_nested(attr, br_spec, rem) {
> -			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !have_flags) {
> +			if (nla_type(attr) == IFLA_BRIDGE_FLAGS && !br_flag) {
>   				if (nla_len(attr) < sizeof(flags))
>   					return -EINVAL;
>   
> -				have_flags = true;
> +				br_flag = attr;
>   				flags = nla_get_u16(attr);
>   			}
>   
> @@ -5238,8 +5237,8 @@ static int rtnl_bridge_setlink(struct sk_buff *skb, struct nlmsghdr *nlh,
>   		}
>   	}
>   
> -	if (have_flags)
> -		memcpy(nla_data(attr), &flags, sizeof(flags));
> +	if (br_flag)
> +		memcpy(nla_data(br_flag), &flags, sizeof(flags));
>   out:
>   	return err;
>   }


