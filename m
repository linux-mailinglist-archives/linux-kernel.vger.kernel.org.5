Return-Path: <linux-kernel+bounces-122250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 71A4288F43E
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A330C1C30486
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 00:57:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A756A18EAB;
	Thu, 28 Mar 2024 00:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="V1jiQerN"
Received: from mail-108-mta9.mxroute.com (mail-108-mta9.mxroute.com [136.175.108.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 211AF16423
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 00:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711587467; cv=none; b=UjohBDYdT3XIKCQbXbd/hWM2pDmXjO7ZcIAsemJ5/hYkU+H4CPV48Jq0yVzprqTfOD3sqA0O6w8D7Wq5gJPFvobaL+y0lQsRN1phCc1ikT4Ciw7F+BQm0wbqwQlVnurztt18TN0BtM4dPOMAQQIcUFWxU+8IIvJJCnO+e9ZyKE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711587467; c=relaxed/simple;
	bh=UGi039Yr9VIru+EzcW7+SRuzfrlsXJHjEtPplQLRzNI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ovxznHp9pgKfbeZFLJprADkzaevcIaZEYo9WjtROiQM1jFARUQLRNdt9WJRKmfwkzI04P0ktiNTqqqdvQbJhrYpK+JQuxJKOZ9EB5uTf0XJYoH+5C/a/j+1AKLKjY5Uw7G1uJCrxJH1r+c3xzXuFcuQyK1rhFMik4KB746jZ1b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=V1jiQerN; arc=none smtp.client-ip=136.175.108.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta9.mxroute.com (ZoneMTA) with ESMTPSA id 18e829008580003bea.011
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 00:57:41 +0000
X-Zone-Loop: 043ce4559a4169ea93ed71f10852384054ec571efdc0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=YN/HXFWBbXPY2y6jVJvIYP4giVWZZlqzsoV52j4CWnU=; b=V1jiQerN/klJS4WkCrSTMCHlvF
	vwLg9z+PHlBkLVpplPJjQPnt16ZgZGx0nA96y3RkQmNa5FgR5Y/+6Qvv8Vp85Lrc0PYnoZQ/TGR5U
	eJD2b+4r8g3iUedOfLFoWVN1Y+Z9P1TtZUWocv075X0oIkBRJayIqebctdb6C3oGJdrS0c+dcs1Ze
	fkyCI0BUX7sL75HFOjdDbcMrybGSmXJxh25O8o/yoIgu2fNk20MSiw81IXMmbwzHR6yQwObx7oDKg
	PKUdAiSXxWDyQHIHI6wE6iL2Pn4lx2fKKZu7TFhXLJYcspvYc2HukaOKJnSg0ak7Q4YZEqwrAHaTV
	8l2t+raw==;
Message-ID: <0e658ecc-38d2-4d6f-b0cf-f5f3ec32c1b8@luigi311.com>
Date: Wed, 27 Mar 2024 18:57:34 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 17/23] dt-bindings: media: imx258: Rename to include
 vendor prefix
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, Conor Dooley <conor.dooley@microchip.com>
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-18-git@luigi311.com>
 <20240327-ninth-tulip-77191ad10fdd@spud>
From: git@luigi311.com
In-Reply-To: <20240327-ninth-tulip-77191ad10fdd@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: personal@luigi311.com

On 3/27/24 17:47, Conor Dooley wrote:
> On Wed, Mar 27, 2024 at 05:17:03PM -0600, git@luigi311.com wrote:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> imx258.yaml doesn't include the vendor prefix of sony, so
>> rename to add it.
>> Update the id entry and MAINTAINERS to match.
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
> 
> This is a v1 with my ack, something has gone awry here. It's also
> missing your signoff. Did you pick up someone else's series?

Yes, this is a continuation of Dave's work. I contacted him directly,
and he mentioned that he is unable to submit a v2 any time soon and
was open to someone else continuing it in his stead. This is my first
time submitting a patch via a mailing list, so I'm not sure if I'm
missing something, but I only added my sign off for anything that
actually included work from my side and not just bringing his patch
forward to this patch series.

> 
>> ---
>>  .../bindings/media/i2c/{imx258.yaml => sony,imx258.yaml}        | 2 +-
>>  MAINTAINERS                                                     | 2 +-
>>  2 files changed, 2 insertions(+), 2 deletions(-)
>>  rename Documentation/devicetree/bindings/media/i2c/{imx258.yaml => sony,imx258.yaml} (97%)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> similarity index 97%
>> rename from Documentation/devicetree/bindings/media/i2c/imx258.yaml
>> rename to Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> index 80d24220baa0..bee61a443b23 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/imx258.yaml
>> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> @@ -1,7 +1,7 @@
>>  # SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>  %YAML 1.2
>>  ---
>> -$id: http://devicetree.org/schemas/media/i2c/imx258.yaml#
>> +$id: http://devicetree.org/schemas/media/i2c/sony,imx258.yaml#
>>  $schema: http://devicetree.org/meta-schemas/core.yaml#
>>  
>>  title: Sony IMX258 13 Mpixel CMOS Digital Image Sensor
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index aa3b947fb080..1f17f6734bf5 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -20464,7 +20464,7 @@ M:	Sakari Ailus <sakari.ailus@linux.intel.com>
>>  L:	linux-media@vger.kernel.org
>>  S:	Maintained
>>  T:	git git://linuxtv.org/media_tree.git
>> -F:	Documentation/devicetree/bindings/media/i2c/imx258.yaml
>> +F:	Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>>  F:	drivers/media/i2c/imx258.c
>>  
>>  SONY IMX274 SENSOR DRIVER
>> -- 
>> 2.42.0
>>


