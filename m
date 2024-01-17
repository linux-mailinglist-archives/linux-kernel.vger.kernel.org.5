Return-Path: <linux-kernel+bounces-28807-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EFE67830334
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 11:06:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A73A287318
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:06:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D9F1DDCF;
	Wed, 17 Jan 2024 10:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="U9geoNM4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="O0pyRdVR"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 005081DA39;
	Wed, 17 Jan 2024 10:03:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705485818; cv=none; b=hqHfa2uFImIbfGne0SXdk5bKqkfs6y7HekFRk3rD0SE+VA1SKwDUZY/H81QJnVy2+jh1ZyCgswsjWpA4uucuwD8KK3BF59ktE6rA515NX+dWnUixGyRHmbSRTU11rjwNi2AXIX7JPV21rlDqiFlfDomUudPVu/usp8v5Heb91Jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705485818; c=relaxed/simple;
	bh=/3K1exgyH0rXoqLgqi/ZtzuiVMq1yT/uqIgIQyu/v/U=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=mJPKHML8EVmvNBG/bLif7FoO4NnVHTVPb+rhjw/CAU1IshIpRr/SjjWsJkErH/QVZuw7F4pQNV5gTb3VON0TwzebQqrQ8XSX1Ap5gdBtjsHiR6E3xZ7xlMXvl5IMolow/xYXYVHk42iIfMp7bWhylUPdonsrsSZvfdi2Y9Ysncw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=U9geoNM4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=O0pyRdVR; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
	by mailout.nyi.internal (Postfix) with ESMTP id 0B5FA5C021F;
	Wed, 17 Jan 2024 05:03:36 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Wed, 17 Jan 2024 05:03:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705485816; x=1705572216; bh=m8YCl/DsxOv6tOduhm9ZJbpzuJtc7eeY
	qEvwM2UP98I=; b=U9geoNM4TmjOaP7FHrXiFNTnvXrFekZt5T+D/M7pLJCmubM5
	RF0WoHltfxXJGmzWjAD69JR6KzAYwpizj7TpT4+DhhhcMsccK2hGKvAEdRa8P7hR
	tMGXaHb7COpO9R2PDO0oJk+cIGyJaRFW/xchN6f7tJWmUZ0OqHROfzeOa2olWSdT
	9fryGd9Xrnp+ihhAnZNXOluf49zN4R820UNmb6JPubOTlLTZ4WFn+ziC5LNs3QYq
	jbc3NZnhm5aeUbBDNIMs7E9xEMH7mQZgFRXGSdOSYj5gkCCBDKK9TkfS96oUW+sg
	KuUlQJHTq5kFX3Dzvs8dPlGG193K/oYVhdw9ig==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705485816; x=
	1705572216; bh=m8YCl/DsxOv6tOduhm9ZJbpzuJtc7eeYqEvwM2UP98I=; b=O
	0pyRdVRU1WJIsj1+h8N4o7T4aFGFmPWpk1GPzN+TxRbcI2RcO++F/JZ2atmwGo93
	Q62cGDXWaZqBC60RndtYPCd1nH5SKVZMdz5jgn8FMKuMS6DJ3iNAu0uWOsNpDeVt
	FcXqYFz2XnrFn5o4MMYvxcldk/fBxYZY4yvmwVBXI0rs+yzucN7CU4PCjV1n29WA
	CpKEfEWNSX6j3K/XYmLu9Zh8xE56Ivo65PX/GNrdCil8Tlc4u/cfdiqdqLitTDx8
	BPpJMPY9E48thy3/H1ERTYenrtM36jBztBi1Oq2UyBfIzNsimbtbDjkQ8DQ5b5iL
	ibblWf+U9PfwuG0+0zJCQ==
X-ME-Sender: <xms:96WnZfLy8wzl_LRvuQeQ8wO1Y3FQWqmRJMzqTGXgYtn9MeD5gKZIuw>
    <xme:96WnZTL5McuYG26aZyQgkBo_LRmIApxWrE9zKJ-O3Lp3e0sa-4TU20XpO8YOmU4BQ
    iGX7vs8qg>
X-ME-Received: <xmr:96WnZXteonf3sdMeTJ05_hc7JSci2xb8M016WN0oA7hNi5NuYwobdhi8LzwyEPuE514nPJ7xBWuAaFbAAhQVpbwfgVH7Pmg1FQUwHA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtkeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepteeffeehtedtffehgeeghfdtgeefledtkeejieetvedtfeeiveevtdehjeefvdet
    necuffhomhgrihhnpehlihhnrghrohdrohhrghenucevlhhushhtvghrufhiiigvpedtne
    curfgrrhgrmhepmhgrihhlfhhrohhmpehtihhmsehfvggrthhhvghrthhophdrohhrgh
X-ME-Proxy: <xmx:96WnZYYoTNkuoqlj661wh9nPTln-zvAK9mGFNQiwztgldxG4ZDY5rQ>
    <xmx:96WnZWZpob31qnwf7q1J06JEobncUtJLfQG6Bi7HtT-wwGNzbCozGA>
    <xmx:96WnZcAgWuHoblsPaIB09p_99maRbIr98FAQQgqLFZwVJPFrkdnyPw>
    <xmx:-KWnZeovMlaJYRkZ1RhE2_wG2njyiQswhpStLSmsn3tiILWdIxnsCA>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 05:03:28 -0500 (EST)
Message-ID: <194a0894-a9f9-4c5e-b304-e7278104d8e7@feathertop.org>
Date: Wed, 17 Jan 2024 21:03:26 +1100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: rockchip: Fix Hardkernel ODROID-M1 board
 bindings
Content-Language: en-US
To: =?UTF-8?Q?Heiko_St=C3=BCbner?= <heiko@sntech.de>,
 Rob Herring <robh@kernel.org>
Cc: KyuHyuk Lee <lee@kyuhyuk.kr>,
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chris Morgan <macromorgan@hotmail.com>,
 Tianling Shen <cnsztl@gmail.com>, Jagan Teki <jagan@edgeble.ai>,
 Ondrej Jirman <megi@xff.cz>, Andy Yan <andyshrk@163.com>,
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240115145142.6292-1-lee@kyuhyuk.kr> <2421144.zToM8qfIzz@diego>
 <20240116192605.GA274661-robh@kernel.org> <47795047.XUcTiDjVJD@diego>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <47795047.XUcTiDjVJD@diego>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 1/17/24 06:55, Heiko Stübner wrote:
> Am Dienstag, 16. Januar 2024, 20:26:05 CET schrieb Rob Herring:
>> On Tue, Jan 16, 2024 at 09:31:35AM +0100, Heiko Stübner wrote:
>>> Am Dienstag, 16. Januar 2024, 08:24:44 CET schrieb Krzysztof Kozlowski:
>>>> On 16/01/2024 03:00, Tim Lunn wrote:
>>>>> On 1/16/24 01:58, Krzysztof Kozlowski wrote:
>>>>>> On 15/01/2024 15:51, KyuHyuk Lee wrote:
>>>>>>> The vendor in ODROID-M1 is hardkernel, but it was incorrectly written
>>>>>>> as rockchip. Fixed the vendor prefix correctly.
>>>>>>>
>>>>>>> Signed-off-by: KyuHyuk Lee <lee@kyuhyuk.kr>
>>>>>>> ---
>>>>>>>    Documentation/devicetree/bindings/arm/rockchip.yaml | 2 +-
>>>>>>>    1 file changed, 1 insertion(+), 1 deletion(-)
>>>>>> You need to start testing your patches. Your last M1 fails as well in
>>>>>> multiple places.
>>>>>>
>>>>>> It does not look like you tested the DTS against bindings. Please run
>>>>>> `make dtbs_check W=1` (see
>>>>>> Documentation/devicetree/bindings/writing-schema.rst or
>>>>>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>>>>>> for instructions).
>>>>>>
>>>>>> The DTS change will break the users, so would be nice to mention this in
>>>>>> its commit msg.
>>>>> I notice there are a couple of other boards that incorrectly use
>>>>> rockchip as the vendor also:
>>>>>
>>>>>             - const: rockchip,rk3399-orangepi
>>>>>             - const: rockchip,rk3568-bpi-r2pro
>>>>>
>>>>> Perhaps these should also be fixed at the same time?
>>>> What is happening with rockchip boards?
>>> Copy-paste stuff ... boards using rockchip,boardname instead of
>>> vendor,boardname for their compatible.
>>>
>>> I do remember us noticing this a number of times on some boards
>>> and requesting fixes, but looks like some slipped through.
>>>
>>> So I guess Tim is suggesting changing the compatible, but with boards
>>> being merged a while ago, this would break backwards compatibility.
>>> So I guess both the Orange and Banana Pies will need to live with that.
>> You may get away with it because we generally don't use the names...
>>
>> Though there are some discussions to start using them to select dtbs by
>> bootloaders.
> Ah, that's good to know (both points) ... so essentially right now would be
> a good time to do what Tim suggested, before the names get actual usage.
>
> @Tim: is that something you'd want to do?
>
Sure, I will prepare patches and send them out soon.
> Thanks
> Heiko
>
>
>

