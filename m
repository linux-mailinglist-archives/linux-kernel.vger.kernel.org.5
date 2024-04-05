Return-Path: <linux-kernel+bounces-132871-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E551899B7D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 13:01:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D1CD0B22F8F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4289F16ABED;
	Fri,  5 Apr 2024 11:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b="gCaMtLDw"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD0114F9D3
	for <linux-kernel@vger.kernel.org>; Fri,  5 Apr 2024 11:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712314842; cv=none; b=DSUFxljrEuGVxYPkJ+VhFWUwIYuEmFwv5OpUr9+jvs5FwoUuLiGj8FRkAkBrwD09Dbj2BqMc1KRmEEPZI9WogeFcUy5mxpURBaYsR5AFCyohwidecsFnP7Vr+IMHF8yQmn0QMfiGuJY+c/qoRbNtQrj//DjqIBW9zRfSusMlrKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712314842; c=relaxed/simple;
	bh=8rZDGF1iD9i2x0a8J1PHWsjcy9nOihuEXXdBaAOHovw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UFIDQ94pN1Ag+XEREpkmmMrWLyajpkEsyEbWAmMadvgKLqE1RGuPYnWxDL/+Q5zkatpD+xmF2tlokRijGriaZZzoNDWyLtJxfKbvgECgVe1+TSeRGV5ri9hTjZQEaXVyfntqtvRa3uvBRRMoDoieoW1ITnUS4LcD9+X5yW0tn00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org; spf=none smtp.mailfrom=blackwall.org; dkim=pass (2048-bit key) header.d=blackwall-org.20230601.gappssmtp.com header.i=@blackwall-org.20230601.gappssmtp.com header.b=gCaMtLDw; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=blackwall.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=blackwall.org
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-4162f7eb479so3266795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 05 Apr 2024 04:00:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=blackwall-org.20230601.gappssmtp.com; s=20230601; t=1712314839; x=1712919639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=h2SNOpfKhYOTvQjVb100qkElwlfRDNRRIOGKWqHxTVc=;
        b=gCaMtLDwM0wLVM5p6H/gr8NM+liGJTGrkQTlFobaiYc3gcamma9WmHO2/6ieK6Dwj4
         CW8WZIETMXeBsUXLN+km2yNC7Zk+VEqOeyfO3eFniZ3JUnh0I2A7JghdkPAQSd7N4RzH
         XhUdR3VLQYv9y8PUYl7bfEOhvdmknXv+4FL+Hv9zIihIOj7/GUaAiX7X2VbMFZhjM4YJ
         zLJWx+SlNdgP52hbc3RJUZjWJEE+naeXwlpAJJ6E8vGfOP124AJuRXPrayc9ymg5fMuI
         mfLQR2MZfIV9Q/rtTIVdI0i79Czd8Rw2UmjO4C3nbd7PV+dyiDqohnI6/QTxZGjPxsv3
         AW1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712314839; x=1712919639;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h2SNOpfKhYOTvQjVb100qkElwlfRDNRRIOGKWqHxTVc=;
        b=glMjXZWfBNM2runG2+X8kXP27IhEYc145RgFleMfaJqM2V1NEDXsDAKOHClutfXm//
         UDqFHYfQVEduRek0gr0uTz6Y6dbfhhJcn3cjmMKHFypx6F6glCUGizu1shQSsdmZFARm
         Pe1fAWqdqeWWDzhdvP5bgaNj00LNhmUt+7ElZNSRE2rx739GE4j8llUmXYW0YhnauH7k
         NO8LfJEDakfyVLf8BUKLzxB1X2fnNQPXAO/oqcGsizV7IicbNBwfVmJ8WzFpZzArv0L9
         CWY6RJdONb+x0TK2NsAOTs/czGiSgEJwLfSjAsgZdUDb+Yoftkv+jVqZRNYLUsltvJ9r
         nOrg==
X-Forwarded-Encrypted: i=1; AJvYcCUJSdIvf628AzD1J+2Lq6/AukskMAfnrj774do49kXf6s2B8ZS15xY0BwQRnxa7KlI+R+lAZy2GjHmEj28ki8tQ+90ti7di8KBcOuMg
X-Gm-Message-State: AOJu0YxGn5ZCSduGycIxgzLszvAD6GkGkKMcshEFpVD8WL1qqXfmfVQ/
	2VYzfztcp+Ini7nLghnBx2P9AA6jIuWWDq7maVJgj161GNZyEKgMHcbsPG326Pg=
X-Google-Smtp-Source: AGHT+IGSfAxS2rw+zL4MNyDCrX6ZE179qSgiR2IP9OlAizBrSQvuiEh5snBhCoUFA8KtT30gDd6sqA==
X-Received: by 2002:a05:600c:46d0:b0:415:6b9a:326d with SMTP id q16-20020a05600c46d000b004156b9a326dmr975063wmo.4.1712314838680;
        Fri, 05 Apr 2024 04:00:38 -0700 (PDT)
Received: from [192.168.0.106] (176.111.182.227.kyiv.volia.net. [176.111.182.227])
        by smtp.gmail.com with ESMTPSA id m17-20020adfa3d1000000b0034355b7e995sm1794676wrb.13.2024.04.05.04.00.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Apr 2024 04:00:38 -0700 (PDT)
Message-ID: <935c18c1-7736-416c-b5c5-13ca42035b1f@blackwall.org>
Date: Fri, 5 Apr 2024 14:00:31 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC net-next 00/10] MC Flood disable and snooping
Content-Language: en-US
To: Vladimir Oltean <olteanv@gmail.com>,
 Joseph Huang <joseph.huang.2024@gmail.com>
Cc: Joseph Huang <Joseph.Huang@garmin.com>, netdev@vger.kernel.org,
 Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Roopa Prabhu <roopa@nvidia.com>, =?UTF-8?Q?Linus_L=C3=BCssing?=
 <linus.luessing@c0d3.blue>, linux-kernel@vger.kernel.org,
 bridge@lists.linux.dev
References: <20240402001137.2980589-1-Joseph.Huang@garmin.com>
 <7fc8264a-a383-4682-a144-8d91fe3971d9@blackwall.org>
 <20240402174348.wosc37adyub5o7xu@skbuf>
 <a8968719-a63b-4969-a971-173c010d708f@blackwall.org>
 <20240402204600.5ep4xlzrhleqzw7k@skbuf>
 <065b803f-14a9-4013-8f11-712bb8d54848@blackwall.org>
 <804b7bf3-1b29-42c4-be42-4c23f1355aaf@gmail.com>
 <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
From: Nikolay Aleksandrov <razor@blackwall.org>
In-Reply-To: <20240405102033.vjkkoc3wy2i3vdvg@skbuf>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/5/24 13:20, Vladimir Oltean wrote:
> On Thu, Apr 04, 2024 at 06:16:12PM -0400, Joseph Huang wrote:
>>>> mcast_flood == off:
>>>> - mcast_ipv4_ctrl_flood: don't care (maybe can force to "off")
>>>> - mcast_ipv4_data_flood: don't care
>>>> - mcast_ipv6_ctrl_flood: don't care
>>>> - mcast_ipv6_data_flood: don't care
>>>> - mcast_l2_flood: don't care
>>>> mcast_flood == on:
>>>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>>>> - Flood all other IPv4 multicast according to mcast_ipv4_data_flood
>>>> - Flood ff02::/16 according to mcast_ipv6_ctrl_flood
>>>> - Flood all other IPv6 multicast according to mcast_ipv6_data_flood
>>>> - Flood L2 according to mcast_l2_flood
>>
>> Did you mean
>>
>> if mcast_flood == on (meaning mcast_flood is ENABLED)
>> - mcast_ipv4_ctrl_flood: don't care (since 224.0.0.x will be flooded anyway)
>> ...
>>
>> if mcast_flood == off (meaning mcast_flood is DISABLED)
>> - Flood 224.0.0.x according to mcast_ipv4_ctrl_flood
>> ...
>>
>> ? Otherwise the problem is still not solved when mcast_flood is disabled.
> 
> No, I mean exactly as I said. My goal was not to "solve the problem"
> when mcast_flood is disabled, but to give you an option to configure the
> bridge to achieve what you want, in a way which I think is more acceptable.
> 
> AFAIU, there is not really any "problem" - the bridge behaves exactly as
> instructed given the limited language available to instruct it ("mcast_flood"
> covers all multicast). So the other knobs have the role of fine-tuning
> what gets flooded when mcast_flood is on. Like "yes, but..."
> 
> You can't "solve the problem" when it involves changing an established
> behavior that somebody probably depended on to be just like that.
> 
>>> Yep, sounds good to me. I was thinking about something in these lines
>>> as well if doing a kernel solution in order to make it simpler and more
>>> generic. The ctrl flood bits need to be handled more carefully to make
>>> sure they match only control traffic and not link-local data.
>>
>> Do we consider 224.0.0.251 (mDNS) to be control or data? What qualifies as
>> control I guess that's my question.
> 
> Well, as I said, I'm proposing that 224.0.0.x qualifies as control and
> the rest of IPv4 multicast as data. Which means that, applied to your
> case, "mcast_flood on mcast_ipv4_ctrl_flood on mcast_ipv4_data_flood off"
> will "force flood" mDNS just like the IGMP traffic from your patches.
> I'm not aware if this could be considered problematic (I don't think so).
> 
> The reason behind this proposal is that, AFAIU, endpoints may choose to
> join IGMP groups in the 224.0.0.x range or not, but RFC4541 says that
> switches shouldn't prune the destinations towards endpoints that don't
> join this range anyway: https://www.rfc-editor.org/rfc/rfc4541#page-6
> 
> Whereas for IP multicast traffic towards an address outside 224.0.0.x,
> pruning will happen as per the IGMP join tracking mechanism.

+1, non-IGMP traffic to 224.0.0.x must be flooded to all anyway
so this should allow for a better control over it, but perhaps
the naming should be link_local instead because control usually
means IGMP, maybe something like mcast_ip_link_local_flood


