Return-Path: <linux-kernel+bounces-28738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22CFB830270
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 10:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C057B281F56
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 09:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0EDB14015;
	Wed, 17 Jan 2024 09:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b="i0OKTCc7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="t813JLYI"
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 636D113FFA;
	Wed, 17 Jan 2024 09:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=66.111.4.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705484274; cv=none; b=WLL8nPhzRU0WP1NdMjEeIINUMyp86KkNurIdazc/FE02oIsYCoZBINSbsTnrAOTTpZhNDfkW1xNke0KKKMXeDrlDiM136pd0iun7XYqnay+eupuai1GF+kbq1kE1eQJN6PH6AtLFeJO15AqQQ00mfq+vdwX00QlD/ZvxcNzPado=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705484274; c=relaxed/simple;
	bh=5EGyMKG9E+GsOkjgt4V+Shwmf865yRckjxW3+DFJBsA=;
	h=Received:Received:DKIM-Signature:DKIM-Signature:X-ME-Sender:
	 X-ME-Received:X-ME-Proxy-Cause:X-ME-Proxy:Feedback-ID:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=LxosFaBKjaEXjiDbF3FB0Sk2uY22j7XSjjeHNX3QCzdUkXLROatY8GgIWLVeOWMtNw7tW6NdqAnyJWez9t2fOYFBHyPlcWSbvmKf4IAc3TC7zcg9Z72PIcQ4n2OeXQCnO6N2tlK6l4060X/YWEUnpxAjScwWFJkyjZWx6FnEY+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org; spf=pass smtp.mailfrom=feathertop.org; dkim=pass (2048-bit key) header.d=feathertop.org header.i=@feathertop.org header.b=i0OKTCc7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=t813JLYI; arc=none smtp.client-ip=66.111.4.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=feathertop.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=feathertop.org
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
	by mailout.nyi.internal (Postfix) with ESMTP id 6D1605C0135;
	Wed, 17 Jan 2024 04:37:52 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Wed, 17 Jan 2024 04:37:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=feathertop.org;
	 h=cc:cc:content-transfer-encoding:content-type:content-type
	:date:date:from:from:in-reply-to:in-reply-to:message-id
	:mime-version:references:reply-to:subject:subject:to:to; s=fm2;
	 t=1705484272; x=1705570672; bh=EqoG1X993nKQll/W/WElOVnpmAA1bRw9
	scZWSKLC9hY=; b=i0OKTCc7UUWorXS51DW3NpLSH4C4hTdE8mOvVq7j8LlJQDP0
	PBCVXmF1Y0zPbSRLPc0t+GS4l1vBMd2Z6fhzl0f/2H/VggZsLmAU9e5gxZgyY5T5
	TDpp4ULy+zwUqU88V7XAx6isiOd8HOzzsUpzUEa53B7T2tArkwtzTPVc9rpM3J2t
	o2OlSN5MK1sA/r27KJAq+owpxpqw1oC99db8Xfj5Nw3rQV+hSgxMBiDHyzqYY5Z0
	KJZjJ1o2ybVax9/GfbRoj64Rfr5uzcV5N4ephWnAd9SDktHlhjwfnhppyWfXUzIF
	LtHbU8QFyj8bdo/HeuZsU3kKBzas3DZyB3QiqQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1705484272; x=
	1705570672; bh=EqoG1X993nKQll/W/WElOVnpmAA1bRw9scZWSKLC9hY=; b=t
	813JLYI8Bx4VI4Gwak44Oz8zyBYxPmLK+loKEXgI30f+ggoxchL9aHnUvDxz5q29
	GdvkXJgaoZA0MTDSGokS6QKrMn8KaQ/0PZnoAePyyO2PGptoQZQ8f9YJMMEs5XDH
	Jwg/dYwR2+CO4x+7meXg8vFX8cfkYiP6uFoOd3AWU16r0GjpwiuLzN6k2+3UqpP1
	KC9cMdWRpKXYM/p4N1hdwKMbTV1hgdXA+tvBWA3DoBgbL0VRhl1q6H/CWB0JEuJ5
	wQ9NBICMT1043Cgtsea6ySa9MHP9po3aB2d/PvVs8/Xg9hHV6ja4zRgc7gNgoHyL
	+gFDUI+bbQOY2gFL5KGvA==
X-ME-Sender: <xms:8J-nZSb-hpldiAaYglXFcIUmyvqOweJBgW7GwGfXQj0lnz88wqqNgQ>
    <xme:8J-nZVZ2zi25ZOWY6uKcMrV6mKeWroaKWet4muV6Cw4hn_ZmmFtBvLA22wLHRJpjc
    iJXsi9_Yg>
X-ME-Received: <xmr:8J-nZc_-4aFTXUwvgF14q4ZA5dLs7SVQC5QUfLBwjk4QHLr1EWWDvUMwbS21i7AB2T7IsNmxlZ7oPf5l-PksHw01ZIufOessVtFAWQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrvdejhedgtdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtvdejnecuhfhrohhmpefvihhm
    ucfnuhhnnhcuoehtihhmsehfvggrthhhvghrthhophdrohhrgheqnecuggftrfgrthhtvg
    hrnhepheehgfelhfffgeefkefgjeelkeduleefvefhgfekgfetfeetvdeigeekjedvffeh
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhimh
    esfhgvrghthhgvrhhtohhprdhorhhg
X-ME-Proxy: <xmx:8J-nZUrk3qU74OECSeysdhR2SlGbF0T9AmpolkiveP3Mz9o_-fA7DQ>
    <xmx:8J-nZdpzfb0ohQKi7BrP4_yW3ZqNNZsBbaR6eIYeJUHSpnivY8nhBA>
    <xmx:8J-nZSTMXr6gSJXZlcKo_KIUGATE2VLB10DtPzOlZbe0rxDygIZTpQ>
    <xmx:8J-nZY2r_SmjYrNhVhTtSGf71pfpSXuPPwHOtJGSULhXSIwnH4vpzg>
Feedback-ID: i1f8241ce:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Jan 2024 04:37:48 -0500 (EST)
Message-ID: <64bce36c-468a-43b6-9d8d-0c20fbd53939@feathertop.org>
Date: Wed, 17 Jan 2024 20:37:45 +1100
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
To: Rob Herring <robh@kernel.org>
Cc: linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240116084618.3112410-1-tim@feathertop.org>
 <20240116084618.3112410-2-tim@feathertop.org>
 <20240116193701.GA286794-robh@kernel.org>
From: Tim Lunn <tim@feathertop.org>
In-Reply-To: <20240116193701.GA286794-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Rob,

On 1/17/24 06:37, Rob Herring wrote:
> On Tue, Jan 16, 2024 at 07:46:16PM +1100, Tim Lunn wrote:
>> Rockchip RK809 shares the same audio codec as the rk817 mfd, it is also
>> using the same rk817_codec driver. However it is missing from the
>> bindings.
>>
>> Update dt-binding documentation for rk809 to include the audio codec
>> properties. This fixes the following warning from dtb check:
>>
>> pmic@20: '#sound-dai-cells', 'assigned-clock-parents', 'assigned-clocks',
>>     'clock-names', 'clocks', 'codec' do not match any of the regexes:
>>     'pinctrl-[0-9]+'
>>
>> Signed-off-by: Tim Lunn <tim@feathertop.org>
>> ---
>>
>>   .../bindings/mfd/rockchip,rk809.yaml          | 30 ++++++++++++++++++-
>>   1 file changed, 29 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> index 839c0521f1e5..bac2e751e2f2 100644
>> --- a/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> +++ b/Documentation/devicetree/bindings/mfd/rockchip,rk809.yaml
>> @@ -12,7 +12,7 @@ maintainers:
>>   
>>   description: |
>>     Rockchip RK809 series PMIC. This device consists of an i2c controlled MFD
>> -  that includes regulators, an RTC, and power button.
>> +  that includes regulators, an RTC, a power button, and an audio codec.
>>   
>>   properties:
>>     compatible:
>> @@ -93,6 +93,34 @@ properties:
>>           unevaluatedProperties: false
>>       unevaluatedProperties: false
>>   
>> +  clocks:
>> +    description:
>> +      The input clock for the audio codec.
> How many clocks? (maxItems: 1)
>
> You can drop the description.
Yes just 1 clock, i will fix this.
>
>> +
>> +  clock-names:
>> +    description:
>> +      The clock name for the codec clock.
> Drop.
Just drop the description? I dont think can drop the clock names as the 
driver use the name to lookup clock:

devm_clk_get(pdev->dev.parent, "mclk");
>
>> +    items:
>> +      - const: mclk
>> +
>> +  '#sound-dai-cells':
>> +    description:
>> +      Needed for the interpretation of sound dais.
> Common property, don't need the description.
Ok
>
>> +    const: 0
>> +
>> +  codec:
>> +    description: |
>> +      The child node for the codec to hold additional properties. If no
>> +      additional properties are required for the codec, this node can be
>> +      omitted.
> Why do you need a child node here? Just put the 1 property in the parent
> node.
This is how the existing rk817 codec driver was setup. I suppose it was 
copied from downstream, where there are more properties than just the 
one. I don't know if there was any intention (or need) to implement 
those other properties.
>
>> +    type: object
>> +    additionalProperties: false
>> +    properties:
>> +      rockchip,mic-in-differential:
>> +        type: boolean
>> +        description:
>> +          Describes if the microphone uses differential mode.
>> +
>>   allOf:
>>     - if:
>>         properties:
>> -- 
>> 2.40.1
>>

