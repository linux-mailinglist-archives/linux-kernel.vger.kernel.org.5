Return-Path: <linux-kernel+bounces-123235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 595418904E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 17:21:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8B37F1C2F5B4
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 16:21:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1063A12F5BE;
	Thu, 28 Mar 2024 16:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="aWfpoOad"
Received: from mail-108-mta57.mxroute.com (mail-108-mta57.mxroute.com [136.175.108.57])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACF9C54773
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 16:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711642862; cv=none; b=GMyBUn2j6zBxf6Yu6OiO8h/8wXx8VD2379uTxM1H5UrJULWS99TSHL5FYrxGa4nWlH98inVrpWn0Tb/NFp3r3I04yhNKult+E+FFg8v2+9UZ58Kh7anEdzRBkX6VMngQ8SmgDzP/WGNTXurnABOhWw0k9HZCV9vGvjKA8OICS0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711642862; c=relaxed/simple;
	bh=YGOEk9oKZHq64MKnhZtMmCLowNGolRXyvDgx+imDZ0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fbZx4PSaexnc3aZji6W5RMJ0ri0qsK5jPYrdksPT0UsUkz866+TU0iKKuU0jCRZJwWD4qYOQsJ/lQcnWKSKXFG0IN8sCpEKmZLaQgoMuR4jBsSjvG7FMQspxYOXeD1KV1QkBV5KR6HsrJrgN3bnobK8GAPLZSklzBcOvnGsfFhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=aWfpoOad; arc=none smtp.client-ip=136.175.108.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta57.mxroute.com (ZoneMTA) with ESMTPSA id 18e85d89b8a0003bea.012
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 16:15:49 +0000
X-Zone-Loop: 90de13ebbe6876d9f3d78f772ebbded1be22125cd2fb
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=cwugKwOI6owueldBI/qieNd7LO4DtJURj2EGZCG3x/k=; b=aWfpoOadUR4xHUIzRi70tTlv+/
	blWiooHO+TqI/ECwvXsh8bJODVu6QbL4BKXe1C/0ZJfJy5n3dOTuLRSto2iucUnQDeGicb4NRqZhp
	vnmvi7ImWm+XubSyGD2YuU95yIFWU5lQlhKb0xRzhsRXzbOV6BCXO8qCO/Tn4BxDqfij5fKEAavU2
	1QNVduCGxvYgYuwu3UJ3e5I55Xvqaj7RTLphjVIMjLnbpYS9qdG7w/QYTBZIB9gD635qDn+ZO3O25
	68ZljAx1ZIEIT7GuFZXS/9ZHQTgPcIP+HFyChMg7fvJ5ArbNtZ+7N7F8P14sqEgnDE4b/lpUI2Taq
	3Y8+M4KQ==;
Message-ID: <c6053c86-2ce9-412b-aaee-fbe1ac25b7c2@luigi311.com>
Date: Thu, 28 Mar 2024 10:15:42 -0600
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
To: Conor Dooley <conor.dooley@microchip.com>,
 Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc: Conor Dooley <conor@kernel.org>, git@luigi311.com,
 linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org, robh@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-18-git@luigi311.com>
 <20240327-ninth-tulip-77191ad10fdd@spud>
 <0e658ecc-38d2-4d6f-b0cf-f5f3ec32c1b8@luigi311.com>
 <171161592126.3072637.14564447281929105708@ping.linuxembedded.co.uk>
 <20240328-prideful-unopposed-e29fcee74c29@wendy>
From: Luigi311 <personal@luigi311.com>
In-Reply-To: <20240328-prideful-unopposed-e29fcee74c29@wendy>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: personal@luigi311.com

On 3/28/24 04:15, Conor Dooley wrote:
> On Thu, Mar 28, 2024 at 08:52:01AM +0000, Kieran Bingham wrote:
>> Quoting git@luigi311.com (2024-03-28 00:57:34)
>>> On 3/27/24 17:47, Conor Dooley wrote:
>>>> On Wed, Mar 27, 2024 at 05:17:03PM -0600, git@luigi311.com wrote:
>>>>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>>>>
>>>>> imx258.yaml doesn't include the vendor prefix of sony, so
>>>>> rename to add it.
>>>>> Update the id entry and MAINTAINERS to match.
>>>>>
>>>>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>>>
>>>> This is a v1 with my ack, something has gone awry here. It's also
>>>> missing your signoff. Did you pick up someone else's series?
>>>
>>> Yes, this is a continuation of Dave's work. I contacted him directly,
>>> and he mentioned that he is unable to submit a v2 any time soon and
>>> was open to someone else continuing it in his stead.
> 
> Ah okay. Unfortunately I see so many binding patches pass by that I
> sometimes forget about what I already reviewed, and I did not
> remember this one at all.

No worries I'm not surprised since i see constant things submitted
to upstream and v1 was actually sent a year ago so there would be no
shot that i would remember it either.

> 
>>> This is my first
>>> time submitting a patch via a mailing list, so I'm not sure if I'm
>>> missing something, but I only added my sign off for anything that
>>> actually included work from my side and not just bringing his patch
>>> forward to this patch series.
> 
> Right. The rules are that you need to add it when you send someone's
> work, like chain of custody type of thing.

Ohh i see, ok ill go ahead and add my sign off to all the patches then


> 
>> Your cover letter states v2, but the individual patches do not.
>>
>> Add the '-v2' (or, rather, next it will be '-v3') to git format-patch
>> when you save your series and it will add the version to each patch. You
>> can also add '-s' to that command I believe to add your SoB to each
>> patch.
> 
> or a rebase will do it with --signoff:
> https://git-scm.com/docs/git-rebase#Documentation/git-rebase.txt---signoff

Perfect thanks for the information you two! Ill be sure to use those 
for the next revision.

> 
> Cheers,
> Conor.


