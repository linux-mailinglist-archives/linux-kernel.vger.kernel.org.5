Return-Path: <linux-kernel+bounces-126237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AAAF89341C
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 18:56:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B84BD1F233F7
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Mar 2024 16:56:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0758C158DAB;
	Sun, 31 Mar 2024 16:41:01 +0000 (UTC)
Received: from a.mx.secunet.com (a.mx.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF2CC1474D1;
	Sun, 31 Mar 2024 16:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=62.96.220.36
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711903260; cv=fail; b=VCm/AH6Qm55VjKOyX8ja3g0yV2Hu7pVUrNsrQtgfoHame5iq5CS7nF91WjGvTHiO0FFhDWmat6TR8lzLMbyFoM2NV71+Jm13EmVmXf6Ouqi0Rjqpz9urZY6hS1BnUT+3qnj1JVhZR/0bUkTEE5/bF/GOwkTF1e+jdBL9zGy8V4I=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711903260; c=relaxed/simple;
	bh=Sfv61GuqN9EjrEx8j81lakykRn8nhWIo5beb5aUP+Mk=;
	h=Date:From:To:CC:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=moVrkPu1fw+D5Mgid0rml3Sb7s8bKUCwEglCLIYwMN6dRWvpI+mTaFWffTsb+wXA8Dn7sHgSQ01ZJSiKHKyUqVN4qrtcksZIJoYLATB6Hz9X5ECTLKUb2CUE8rYGx9ifgP2wrjidLKK1gwi6AVwzXLfjvQOMxvBE0zQuZb2tWSA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com; spf=fail smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=fail smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=arm.com
Received: from localhost (localhost [127.0.0.1])
	by a.mx.secunet.com (Postfix) with ESMTP id 423CA207E4;
	Sun, 31 Mar 2024 18:40:56 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from a.mx.secunet.com ([127.0.0.1])
	by localhost (a.mx.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RoABDqTHBZ5U; Sun, 31 Mar 2024 18:40:55 +0200 (CEST)
Received: from mailout1.secunet.com (mailout1.secunet.com [62.96.220.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by a.mx.secunet.com (Postfix) with ESMTPS id 7DE67201E5;
	Sun, 31 Mar 2024 18:40:55 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 7DE67201E5
Received: from cas-essen-01.secunet.de (unknown [10.53.40.201])
	by mailout1.secunet.com (Postfix) with ESMTP id 6EB6D80005E;
	Sun, 31 Mar 2024 18:40:55 +0200 (CEST)
Received: from mbx-essen-01.secunet.de (10.53.40.197) by
 cas-essen-01.secunet.de (10.53.40.201) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Sun, 31 Mar 2024 18:40:55 +0200
Received: from Pickup by mbx-essen-01.secunet.de with Microsoft SMTP Server id
 15.1.2507.17; Sun, 31 Mar 2024 16:37:05 +0000
X-sender: <linux-kernel+bounces-125898-steffen.klassert=secunet.com@vger.kernel.org>
X-Receiver: <steffen.klassert@secunet.com> ORCPT=rfc822;steffen.klassert@secunet.com
X-CreatedBy: MSExchange15
X-HeloDomain: mbx-essen-01.secunet.de
X-ExtendedProps: BQBjAAoA1mQFfe5Q3AgFADcAAgAADwA8AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5NYWlsUmVjaXBpZW50Lk9yZ2FuaXphdGlvblNjb3BlEQAAAAAAAAAAAAAAAAAAAAAADwA/AAAATWljcm9zb2Z0LkV4Y2hhbmdlLlRyYW5zcG9ydC5EaXJlY3RvcnlEYXRhLk1haWxEZWxpdmVyeVByaW9yaXR5DwADAAAATG93
X-Source: SMTP:Default MBX-ESSEN-02
X-SourceIPAddress: 10.53.40.197
X-EndOfInjectedXHeaders: 8542
X-Virus-Scanned: by secunet
Received-SPF: Pass (sender SPF authorized) identity=mailfrom; client-ip=147.75.80.249; helo=am.mirrors.kernel.org; envelope-from=linux-kernel+bounces-125898-steffen.klassert=secunet.com@vger.kernel.org; receiver=steffen.klassert@secunet.com 
DKIM-Filter: OpenDKIM Filter v2.11.0 a.mx.secunet.com 4E0B02076B
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal: i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711834844; cv=none; b=T16REM/JeJLpoXc7ElgL45TTWtiTMgynPrFBf46tlGF8vXCCm43+k5UkrSBfltzvdOj6XZjQGnnl38I8eOJmUER9LEmKMlrOcJ5UtCFoT2G2GqfSJEMd1AQnU2cmd+F/xgql5JQa5/FsWa14+2Xmv9mwG03Jta4Uudu6R246STw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711834844; c=relaxed/simple;
	bh=Sfv61GuqN9EjrEx8j81lakykRn8nhWIo5beb5aUP+Mk=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eWiqO4Ji2EjrulhkN2iHrQdRuXu/yWIUA6mtsi+f+X6Ke/TUpqBVJ58ftB0LVu0Xd1QNYulCWla19cKKMW8iJ+xEhB3K/hdVeD0yV3Bd0Bhs+HPKulDrlxDl5gS5Yztast1Bs9ZVDRIUg8SD/Zahm92liwU2qYbZOMQJltrxgJ0=
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Date: Sat, 30 Mar 2024 21:40:22 +0000
From: Andre Przywara <andre.przywara@arm.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC: Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>, Liam Girdwood
	<lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, Rob Herring
	<robh@kernel.org>, Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-sunxi@lists.linux.dev>, Jernej Skrabec
	<jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, "Ryan
 Walklin" <ryan@testtoast.com>, Chris Morgan <macroalpha82@gmail.com>
Subject: Re: [PATCH 2/4] dt-bindings: mfd: x-powers,axp152: add boost
 regulator
Message-ID: <20240330213331.68a2c145@minigeek.lan>
In-Reply-To: <0b53cf44-b5ca-4ccc-9912-777b85f1bcbd@linaro.org>
References: <20240329235033.25309-1-andre.przywara@arm.com>
	<20240329235033.25309-3-andre.przywara@arm.com>
	<0b53cf44-b5ca-4ccc-9912-777b85f1bcbd@linaro.org>
Organization: Arm Ltd.
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.31; x86_64-slackware-linux-gnu)
Precedence: bulk
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: 2c86f778-e09b-4440-8b15-867914633a10

On Sat, 30 Mar 2024 10:30:05 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

Hi,

> On 30/03/2024 00:50, Andre Przywara wrote:
> > The X-Powers AXP717 contains a boost regulator, that it meant to provide
> > the 5V USB VBUS voltage when the devices operates on battery.
> > 
> > Add the name "boost" to the regexp describing the allowed node names,
> > to allow the regulator to be described in the devicetree.
> > 
> > Signed-off-by: Andre Przywara <andre.przywara@arm.com>
> > ---
> >  Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > index b8e8db0d58e9c..14ab367fc8871 100644
> > --- a/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > +++ b/Documentation/devicetree/bindings/mfd/x-powers,axp152.yaml
> > @@ -274,7 +274,7 @@ properties:
> >            Defines the work frequency of DC-DC in kHz.
> >  
> >      patternProperties:
> > -      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo)$":
> > +      "^(([a-f])?ldo[0-9]|dcdc[0-7a-e]|ldo(_|-)io(0|1)|(dc1)?sw|rtc(_|-)ldo|cpusldo|drivevbus|dc5ldo|boost)$":  
> 
> That's not an easy to read regex...

TBH regexps are the least of my problems when reading bindings ;-)

> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks!

> If driver does not depend on _, please consider dropping (_|-).

The drivers (checked both Linux and FreeBSD) do look for a specific
string, but it's the real old regulators that used ldo_io[01] and
rtc_ldo, all the "newer" ones use a dash. Since this binding covers all
of them, we can't drop this from this regexp, but rest assured we only
go with dashes for new and upcoming devices.

Thanks,
Andre


