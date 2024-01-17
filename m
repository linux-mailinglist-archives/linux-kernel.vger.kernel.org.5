Return-Path: <linux-kernel+bounces-28850-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41DAF8303BE
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:39:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 43B581C249A3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EDD1C2BB;
	Wed, 17 Jan 2024 10:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="faEJulbl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tC9vERqN"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6451401E;
	Wed, 17 Jan 2024 10:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705487935; cv=none; b=fk5VZa9mapGmhLCHKFg4vs6SIXNrpjt52MO4d+oTFE7d8BYnl1s2OHZPnsSKuSG5KoUr5ju3sRj7wf9SsIYm6uYO0BakUQd1oH3l08f2xUIq5ThpzsU3XqCWuc2AZnwMI2AVazXpcNlUVHJDD5pBDUruFDmN7eyKvFBMHr1iaU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705487935; c=relaxed/simple;
	bh=mf/LgDzPmmMMtNNh/VBYDY3PGPoYy0VK5gqECakKYjg=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=aQNxN30liFoQwVekOiJSndVOGgYg5d/HZ9wQb9iD9wOGwbTrwNEbXogWZk4edrtrfJfgu8BslORHYOXHl6giF80jjfuDJBZQFaK2xHE9G1NT0EiSGRT+5TtsPdrZWVfvy6xVW00mVq3iMe3G6kzVbIdcekY6lBmVQhR3I3292ZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=faEJulbl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tC9vERqN; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id A98EB5C00ED;
	Wed, 17 Jan 2024 05:38:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 17 Jan 2024 05:38:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705487930; x=1705574330; bh=uolH2UdRL07ElTMV+uuSFDyj48n5KuNI
	MWZAR7W0Hxk=; b=faEJulbl67/3OnEjloNCbjp0YStn1XYqpVDgdnt28vyc9tiy
	wc9hQygC5k2CHFF7+LCLniCJ2fvX9nghb8VxDJPLtMJXi9m+j3tf7dlSCyNfuXgh
	+5Ke+fUR4dYaoYIGRoJo4cPP9Uj+eP3LTN1ocW/kAqVfOy4Wx2f6JzUClNWFcFci
	JbPFWa/ZY/B6bxPOg+jK11Z8e1NQisXLqFLUkQvMnMXVsNB0yQjrIpZRvFuyLjO7
	Tz5UyUo4082D8c0cO/fLFMYFCK3+QdoZ6LfhkHFe/u6KU+1HUCXTkJGjCKT7iFaJ
	cpx+07Do55AWgODtilqprPBPnGxDPD1KUD8oFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705487930; x=
	1705574330; bh=uolH2UdRL07ElTMV+uuSFDyj48n5KuNIMWZAR7W0Hxk=; b=t
	C9vERqN5XufAnBn9DxrHpwt0P8R+puxtcJvAwb5zab0AE+9YDvzG8T3TxYANVEmj
	aFmhKsKicdx0MBxkF/eQNh8tA1v669Btf7vzeUDUvGu21SUoswbD2isyELvoCK1E
	FBv3/Ln2bsipndxyWeLpQXhmk993TUJiex1/X9g8+/Rc91H3msLHj2WVNj1VPkPJ
	8H36WEK3cH0ua0RvOG8TjhBlqURbu8NgMJ3s4JwXwvStRu7WOzdygadt6PcvdzlE
	n/RPG/4GWcinMaYci4qd9+VgQ/xr+0OWShB6QW1LfCjx9W7JJhM/kLd7MfYDzXoz
	kiSaBecDa/kq+WfR6u6Tw==
X-ME-Sender: <xms:Oa6nZUVN9RYuSE9eAe7QwAaYajN9YdnS0K6jERQkU6ykVhzRXHxCiQ>
    <xme:Oa6nZYkAcINjSr7ETRsuZ8WXTUcKPw6mD8xWdLyTGeLH86QcrZGm0i6L-h_dsZo-w
    aKuwKaJxw>
X-ME-Received: <xmr:Oa6nZYao19oobgALfvy-OeLBIxFrvdxurqkFWlBxscFVmAJ-vMjhdcYSYe_CVuL_jG_nbp_U1E7yxskceLEjgIN0GcWv9E8GXVTtlw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgudeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepueegfefgveeuiedtheffgfefveejkeetiefhhfdvjeevlefhueekudeuleeghfek
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:Oa6nZTWRpsOeVayEubkl0CX7sAiD8xTjYy3-4TZ0OWNXNNtT4evYpw>
    <xmx:Oa6nZek1gQNJUuaFbS5FxllSgTBt-6rmCJPAWTY8NiiSZRYNkzyklg>
    <xmx:Oa6nZYfmJdY4UJSn-lVMtv6mcEaJ6ktYL4_JpeAkeuQ3QxwvHMSSBw>
    <xmx:Oq6nZXcUNUQi3vp_xnMvJUYdhOLGtUG7RHl0tygElt_Rmrklvnth8w>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 05:38:45 -0500 (EST)
Message-ID: <6d828e2d-a25b-4784-9905-4a264b7d78fe@feathertop.org>
Date: Wed, 17 Jan 2024 21:38:42 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: rockchip: Add rk809 support for rk817
 audio codec
Content-Language: en-US
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-2-tim@feathertop.org>
 <20240116193701.GA286794-robh@kernel.org>
 <64bce36c-468a-43b6-9d8d-0c20fbd53939@feathertop.org>
 <71413ca3-1a14-4eda-ad29-dc5fcbe5afb3@linaro.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <71413ca3-1a14-4eda-ad29-dc5fcbe5afb3@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/24 21:12, Krzysztof Kozlowski wrote:
> On 17/01/2024 10:37, Tim Lunn wrote:
>>> You can drop the description.
>> Yes just 1 clock, i will fix this.
>>>> +
>>>> +  clock-names:
>>>> +    description:
>>>> +      The clock name for the codec clock.
>>> Drop.
>> Just drop the description? I dont think can drop the clock names as the
>> driver use the name to lookup clock:
> Description. But anyway the problem is that adding clocks should be
> separate patch with its own explanation.
>
Right, but I am not actually adding any clocks, just documenting what is 
already there.
There are already boards using this codec with rk809 in dts files and is 
working fine from driver side.
>
>
>> devm_clk_get(pdev->dev.parent, "mclk");
>>>> +    items:
>>>> +      - const: mclk
>>>> +
>>>> +  '#sound-dai-cells':
>>>> +    description:
>>>> +      Needed for the interpretation of sound dais.
>>> Common property, don't need the description.
>> Ok
>>>> +    const: 0
>>>> +
>>>> +  codec:
>>>> +    description: |
>>>> +      The child node for the codec to hold additional properties. If no
>>>> +      additional properties are required for the codec, this node can be
>>>> +      omitted.
>>> Why do you need a child node here? Just put the 1 property in the parent
>>> node.
>> This is how the existing rk817 codec driver was setup. I suppose it was
>> copied from downstream, where there are more properties than just the
>> one. I don't know if there was any intention (or need) to implement
>> those other properties.
> You need to clearly express ABI requirements in the commit msg.
> Otherwise you will get a review like for new bindings.
Got it, I will clarify this and future commit messages

Regards
    Tim
>
> Best regards,
> Krzysztof
>

