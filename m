Return-Path: <linux-kernel+bounces-123468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BC89890909
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:21:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 201C61F272BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 19:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FF83137C31;
	Thu, 28 Mar 2024 19:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b="qwCXm9BF"
Received: from mail-108-mta37.mxroute.com (mail-108-mta37.mxroute.com [136.175.108.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C4C657C6
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 19:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=136.175.108.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711653701; cv=none; b=jEgQL764HgQ7/F5B83mUdS4G20G3k42tlSROt7zMp3vmE9A3WIdL/V9E4Oqnn22i4TL2dx2rk7ycUereqw15mqOn30ryhkypzbTOwZcZy2gIlMKZz34YIe5Y5VGNCP1BPksMoB8yFTtjYWe+L6YQniqaCzEx+CpnqN4kXESh64c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711653701; c=relaxed/simple;
	bh=+P6JDdjJ1Ex7kuwioyIjjSETZSNuTHoLH51U4FVMcjg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=u0e6jvtewsS/oPQab6o+xPS0+vTPw18xgzlCB9NuUYCCblZ5hoBG+uVSy+U/2+1IxnrlVxJdy9g6qWRjM0O9E0DPdUQt1LVH6Qf/Jj8q6nh6jrE14jdVJbbUohGI5Sf/WCofozmlT9/uhjFxDoRTwBxQePLovHLBVQ1l/xJQSWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com; spf=pass smtp.mailfrom=luigi311.com; dkim=pass (2048-bit key) header.d=luigi311.com header.i=@luigi311.com header.b=qwCXm9BF; arc=none smtp.client-ip=136.175.108.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=luigi311.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=luigi311.com
Received: from filter006.mxroute.com ([136.175.111.2] filter006.mxroute.com)
 (Authenticated sender: mN4UYu2MZsgR)
 by mail-108-mta37.mxroute.com (ZoneMTA) with ESMTPSA id 18e867e00920003bea.00f
 for <linux-kernel@vger.kernel.org>
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384);
 Thu, 28 Mar 2024 19:16:28 +0000
X-Zone-Loop: a9895551fbf5b6096aa45139c742d6e239e08287b159
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=luigi311.com; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
	From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=tQJb1jl0+k5VWPtDnFdvdOzbEiK5LWRoPsu+EFTE44M=; b=qwCXm9BF5B/BKG1LMbYhN94yUV
	rAc3/t4oTkVHcORDV9B8HrlemSm+v5kD/t39rjI6ws/L1XXVKQc+i7KbjwCBB3NAAxMyt6oXQ1EfD
	IlhlxeC1iAParASXRSIBb+oE/zna2MuWrkPKPO3l9gROf39Fs21jOlpBJqFu10PqisHRKMl6kjNEs
	Jahj+QjNfU9EwqGze4OsIvNSOts0YMcTLDSyvubePtWWK2F9R9GVJI0nuN0jtfVHViTaIo6lOu3qn
	aRtavdTKoklJWGZYZx6JUB9w2wB3k9wPEXoOAViWsskP1Jok9Yibg6Z30Qwhewbeb2ybGBRRe9khs
	pEyvc0EQ==;
Message-ID: <76f999a7-55e0-4676-aa75-8fcd466e046b@luigi311.com>
Date: Thu, 28 Mar 2024 13:16:22 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/23] dt-bindings: media: imx258: Add alternate
 compatible strings
Content-Language: en-US
To: Rob Herring <robh@kernel.org>
Cc: linux-media@vger.kernel.org, dave.stevenson@raspberrypi.com,
 jacopo.mondi@ideasonboard.com, mchehab@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org,
 s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
 sakari.ailus@linux.intel.com, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240327231710.53188-1-git@luigi311.com>
 <20240327231710.53188-19-git@luigi311.com>
 <20240328185526.GA88354-robh@kernel.org>
From: Luigi311 <git@luigi311.com>
In-Reply-To: <20240328185526.GA88354-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Authenticated-Id: git@luigi311.com

On 3/28/24 12:55, Rob Herring wrote:
> On Wed, Mar 27, 2024 at 05:17:04PM -0600, git@luigi311.com wrote:
>> From: Dave Stevenson <dave.stevenson@raspberrypi.com>
>>
>> There are a number of variants of the imx258 modules that can not
>> be differentiated at runtime, so add compatible strings for them.
>> But you are only adding 1 variant.

I can not speak for Dave but as to why this was added here but looking
at the imx296 yaml that has something similar where there are multiple
variants that may not be detectable at run time but does not include
similar verbiage in the main description. Should I drop this from the
description so it matches the imx296?

> 
>>
>> Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
>> Signed-off-by: Luigi311 <git@luigi311.com>
>> ---
>>  .../devicetree/bindings/media/i2c/sony,imx258.yaml          | 6 +++++-
>>  1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> index bee61a443b23..c7856de15ba3 100644
>> --- a/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> +++ b/Documentation/devicetree/bindings/media/i2c/sony,imx258.yaml
>> @@ -14,10 +14,14 @@ description: |-
>>    type stacked image sensor with a square pixel array of size 4208 x 3120. It
>>    is programmable through I2C interface.  Image data is sent through MIPI
>>    CSI-2.
>> +  There are a number of variants of the sensor which cannot be detected at
>> +  runtime, so multiple compatible strings are required to differentiate these.
> 
> That's more reasoning/why for the patch than description of the h/w.
> 
>>  properties:
>>    compatible:
>> -    const: sony,imx258
>> +    - enum:
>> +        - sony,imx258
>> +        - sony,imx258-pdaf
> 
> How do I know which one to use? Please define what PDAF means somewhere 
> as well as perhaps what the original/default variant is or isn't.

Would it make sense to change the properties to include a description like so

properties:
  compatible:
    enum:
      - sony,imx258
      - sony,imx258-pdaf
    description:
      The IMX258 sensor exists in two different models, a standard variant
      (IMX258) and a variant with phase detection autofocus (IMX258-PDAF).
      The camera module does not expose the model through registers, so the
      exact model needs to be specified.

> 
>>  
>>    assigned-clocks: true
>>    assigned-clock-parents: true
>> -- 
>> 2.42.0
>>


