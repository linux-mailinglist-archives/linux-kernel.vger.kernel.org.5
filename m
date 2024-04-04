Return-Path: <linux-kernel+bounces-131485-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F682898881
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 15:06:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53B1528CC5B
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 13:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D4F7126F3A;
	Thu,  4 Apr 2024 13:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="hZb9bTie"
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2C2763F4;
	Thu,  4 Apr 2024 13:06:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.167.242.64
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712236009; cv=none; b=MUnMD8YV76oSqWhSMI7xpjUv6MQzFhPSQK3e/FomZZd8tm+BkFOm3T9G0fCeK1iwKhtIxXD+bEXWSkLNVEeVRYKZSzbxWcDfdr6hHXCBGwzbBjrt6b0G1s9vraykPHRe4/ttIcLXAbEDcveQg62gyFf622LUc7teXrJw06+Nrdk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712236009; c=relaxed/simple;
	bh=VHskOTBOqICY1MwbN4wvhawfGTGgcbvKXeRdEiLLxXY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EhmF9KuSpDyJwt/hn8K9CG3NI2iF+UHhhIzOSnd3qmyUZYxWw/1RnjrtODWt4l6LY48v6fN/1KvtsNGx1yPpP9JQsIspR9Syhj3nnijAbcPKLAXdQREXgNYfbFu0I328BA1NHOt2Kiwb19zFBGbR4mJFV8BWqk0lChjWZ89c9TA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com; spf=pass smtp.mailfrom=ideasonboard.com; dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.b=hZb9bTie; arc=none smtp.client-ip=213.167.242.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ideasonboard.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ideasonboard.com
Received: from [192.168.88.20] (91-154-34-181.elisa-laajakaista.fi [91.154.34.181])
	by perceval.ideasonboard.com (Postfix) with ESMTPSA id 7EF0512D;
	Thu,  4 Apr 2024 15:06:08 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
	s=mail; t=1712235968;
	bh=VHskOTBOqICY1MwbN4wvhawfGTGgcbvKXeRdEiLLxXY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hZb9bTietCbCo5gxz1tor0WQFUdDmOBqAvVrDGNJ57LyQeagwmrqB+5dmysZR2MKF
	 6IkdijPs/HrzbUS87gsDtr1S9aR009XzJ7QLmnLQcnZaDUa9Unok0RAlEYkrcHCPrN
	 LSMVf6+Ir3pbtxBEd0lcjy5rRbti2PyY+H68YaRU=
Message-ID: <1d1d5631-4758-46ad-a62b-8fe767e2c681@ideasonboard.com>
Date: Thu, 4 Apr 2024 16:06:43 +0300
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] media: subdev: Fix use of sd->enabled_streams in
 call_s_stream()
To: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
 Hans Verkuil <hverkuil@xs4all.nl>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Umang Jain <umang.jain@ideasonboard.com>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240404-enable-streams-impro-v1-0-1017a35bbe07@ideasonboard.com>
 <20240404-enable-streams-impro-v1-2-1017a35bbe07@ideasonboard.com>
 <20240404130022.GQ23803@pendragon.ideasonboard.com>
Content-Language: en-US
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Autocrypt: addr=tomi.valkeinen@ideasonboard.com; keydata=
 xsFNBE6ms0cBEACyizowecZqXfMZtnBniOieTuFdErHAUyxVgtmr0f5ZfIi9Z4l+uUN4Zdw2
 wCEZjx3o0Z34diXBaMRJ3rAk9yB90UJAnLtb8A97Oq64DskLF81GCYB2P1i0qrG7UjpASgCA
 Ru0lVvxsWyIwSfoYoLrazbT1wkWRs8YBkkXQFfL7Mn3ZMoGPcpfwYH9O7bV1NslbmyJzRCMO
 eYV258gjCcwYlrkyIratlHCek4GrwV8Z9NQcjD5iLzrONjfafrWPwj6yn2RlL0mQEwt1lOvn
 LnI7QRtB3zxA3yB+FLsT1hx0va6xCHpX3QO2gBsyHCyVafFMrg3c/7IIWkDLngJxFgz6DLiA
 G4ld1QK/jsYqfP2GIMH1mFdjY+iagG4DqOsjip479HCWAptpNxSOCL6z3qxCU8MCz8iNOtZk
 DYXQWVscM5qgYSn+fmMM2qN+eoWlnCGVURZZLDjg387S2E1jT/dNTOsM/IqQj+ZROUZuRcF7
 0RTtuU5q1HnbRNwy+23xeoSGuwmLQ2UsUk7Q5CnrjYfiPo3wHze8avK95JBoSd+WIRmV3uoO
 rXCoYOIRlDhg9XJTrbnQ3Ot5zOa0Y9c4IpyAlut6mDtxtKXr4+8OzjSVFww7tIwadTK3wDQv
 Bus4jxHjS6dz1g2ypT65qnHen6mUUH63lhzewqO9peAHJ0SLrQARAQABzTBUb21pIFZhbGtl
 aW5lbiA8dG9taS52YWxrZWluZW5AaWRlYXNvbmJvYXJkLmNvbT7CwY4EEwEIADgWIQTEOAw+
 ll79gQef86f6PaqMvJYe9QUCX/HruAIbAwULCQgHAgYVCgkICwIEFgIDAQIeAQIXgAAKCRD6
 PaqMvJYe9WmFD/99NGoD5lBJhlFDHMZvO+Op8vCwnIRZdTsyrtGl72rVh9xRfcSgYPZUvBuT
 VDxE53mY9HaZyu1eGMccYRBaTLJSfCXl/g317CrMNdY0k40b9YeIX10feiRYEWoDIPQ3tMmA
 0nHDygzcnuPiPT68JYZ6tUOvAt7r6OX/litM+m2/E9mtp8xCoWOo/kYO4mOAIoMNvLB8vufi
 uBB4e/AvAjtny4ScuNV5c5q8MkfNIiOyag9QCiQ/JfoAqzXRjVb4VZG72AKaElwipiKCWEcU
 R4+Bu5Qbaxj7Cd36M/bI54OrbWWETJkVVSV1i0tghCd6HHyquTdFl7wYcz6cL1hn/6byVnD+
 sR3BLvSBHYp8WSwv0TCuf6tLiNgHAO1hWiQ1pOoXyMEsxZlgPXT+wb4dbNVunckwqFjGxRbl
 Rz7apFT/ZRwbazEzEzNyrBOfB55xdipG/2+SmFn0oMFqFOBEszXLQVslh64lI0CMJm2OYYe3
 PxHqYaztyeXsx13Bfnq9+bUynAQ4uW1P5DJ3OIRZWKmbQd/Me3Fq6TU57LsvwRgE0Le9PFQs
 dcP2071rMTpqTUteEgODJS4VDf4lXJfY91u32BJkiqM7/62Cqatcz5UWWHq5xeF03MIUTqdE
 qHWk3RJEoWHWQRzQfcx6Fn2fDAUKhAddvoopfcjAHfpAWJ+ENc7BTQROprNHARAAx0aat8GU
 hsusCLc4MIxOQwidecCTRc9Dz/7U2goUwhw2O5j9TPqLtp57VITmHILnvZf6q3QAho2QMQyE
 DDvHubrdtEoqaaSKxKkFie1uhWNNvXPhwkKLYieyL9m2JdU+b88HaDnpzdyTTR4uH7wk0bBa
 KbTSgIFDDe5lXInypewPO30TmYNkFSexnnM3n1PBCqiJXsJahE4ZQ+WnV5FbPUj8T2zXS2xk
 0LZ0+DwKmZ0ZDovvdEWRWrz3UzJ8DLHb7blPpGhmqj3ANXQXC7mb9qJ6J/VSl61GbxIO2Dwb
 xPNkHk8fwnxlUBCOyBti/uD2uSTgKHNdabhVm2dgFNVuS1y3bBHbI/qjC3J7rWE0WiaHWEqy
 UVPk8rsph4rqITsj2RiY70vEW0SKePrChvET7D8P1UPqmveBNNtSS7In+DdZ5kUqLV7rJnM9
 /4cwy+uZUt8cuCZlcA5u8IsBCNJudxEqBG10GHg1B6h1RZIz9Q9XfiBdaqa5+CjyFs8ua01c
 9HmyfkuhXG2OLjfQuK+Ygd56mV3lq0aFdwbaX16DG22c6flkkBSjyWXYepFtHz9KsBS0DaZb
 4IkLmZwEXpZcIOQjQ71fqlpiXkXSIaQ6YMEs8WjBbpP81h7QxWIfWtp+VnwNGc6nq5IQDESH
 mvQcsFS7d3eGVI6eyjCFdcAO8eMAEQEAAcLBXwQYAQIACQUCTqazRwIbDAAKCRD6PaqMvJYe
 9fA7EACS6exUedsBKmt4pT7nqXBcRsqm6YzT6DeCM8PWMTeaVGHiR4TnNFiT3otD5UpYQI7S
 suYxoTdHrrrBzdlKe5rUWpzoZkVK6p0s9OIvGzLT0lrb0HC9iNDWT3JgpYDnk4Z2mFi6tTbq
 xKMtpVFRA6FjviGDRsfkfoURZI51nf2RSAk/A8BEDDZ7lgJHskYoklSpwyrXhkp9FHGMaYII
 m9EKuUTX9JPDG2FTthCBrdsgWYPdJQvM+zscq09vFMQ9Fykbx5N8z/oFEUy3ACyPqW2oyfvU
 CH5WDpWBG0s5BALp1gBJPytIAd/pY/5ZdNoi0Cx3+Z7jaBFEyYJdWy1hGddpkgnMjyOfLI7B
 CFrdecTZbR5upjNSDvQ7RG85SnpYJTIin+SAUazAeA2nS6gTZzumgtdw8XmVXZwdBfF+ICof
 92UkbYcYNbzWO/GHgsNT1WnM4sa9lwCSWH8Fw1o/3bX1VVPEsnESOfxkNdu+gAF5S6+I6n3a
 ueeIlwJl5CpT5l8RpoZXEOVtXYn8zzOJ7oGZYINRV9Pf8qKGLf3Dft7zKBP832I3PQjeok7F
 yjt+9S+KgSFSHP3Pa4E7lsSdWhSlHYNdG/czhoUkSCN09C0rEK93wxACx3vtxPLjXu6RptBw
 3dRq7n+mQChEB1am0BueV1JZaBboIL0AGlSJkm23kw==
In-Reply-To: <20240404130022.GQ23803@pendragon.ideasonboard.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 04/04/2024 16:00, Laurent Pinchart wrote:
> Hi Tomi,
> 
> Thank you for the patch.
> 
> On Thu, Apr 04, 2024 at 01:50:01PM +0300, Tomi Valkeinen wrote:
>> call_s_stream() uses sd->enabled_streams to track whether streaming has
>> already been enabled. However,
>> v4l2_subdev_enable/disable_streams_fallback(), which was the original
>> user of this field, already uses it, and
>> v4l2_subdev_enable/disable_streams_fallback() will call call_s_stream().
>>
>> This leads to a conflict as both functions set the field. Afaics, both
>> functions set the field to the same value, so it won't cause a runtime
>> bug, but it's still wrong and if we, e.g., change how
>> v4l2_subdev_enable/disable_streams_fallback() operates we might easily
>> cause bugs.
>>
>> Fix this by adding a new field, 'streaming_enabled', for
>> call_s_stream().
>>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
>> ---
>>   drivers/media/v4l2-core/v4l2-subdev.c | 8 ++------
>>   include/media/v4l2-subdev.h           | 2 ++
>>   2 files changed, 4 insertions(+), 6 deletions(-)
>>
>> diff --git a/drivers/media/v4l2-core/v4l2-subdev.c b/drivers/media/v4l2-core/v4l2-subdev.c
>> index b90b5185e87f..3b3310bce5d4 100644
>> --- a/drivers/media/v4l2-core/v4l2-subdev.c
>> +++ b/drivers/media/v4l2-core/v4l2-subdev.c
>> @@ -404,12 +404,8 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>>   	 * The .s_stream() operation must never be called to start or stop an
>>   	 * already started or stopped subdev. Catch offenders but don't return
>>   	 * an error yet to avoid regressions.
>> -	 *
>> -	 * As .s_stream() is mutually exclusive with the .enable_streams() and
>> -	 * .disable_streams() operation, we can use the enabled_streams field
>> -	 * to store the subdev streaming state.
>>   	 */
>> -	if (WARN_ON(!!sd->enabled_streams == !!enable))
>> +	if (WARN_ON(!!sd->streaming_enabled == !!enable))
>>   		return 0;
>>   
>>   #if IS_REACHABLE(CONFIG_LEDS_CLASS)
>> @@ -429,7 +425,7 @@ static int call_s_stream(struct v4l2_subdev *sd, int enable)
>>   	}
>>   
>>   	if (!ret)
>> -		sd->enabled_streams = enable ? BIT(0) : 0;
>> +		sd->streaming_enabled = !!enable;
>>   
>>   	return ret;
>>   }
>> diff --git a/include/media/v4l2-subdev.h b/include/media/v4l2-subdev.h
>> index a9e6b8146279..8bd1e3c96d2b 100644
>> --- a/include/media/v4l2-subdev.h
>> +++ b/include/media/v4l2-subdev.h
>> @@ -1043,6 +1043,7 @@ struct v4l2_subdev_platform_data {
>>    *		     v4l2_subdev_enable_streams() and
>>    *		     v4l2_subdev_disable_streams() helper functions for fallback
>>    *		     cases.
>> + * @streaming_enabled: Tracks whether streaming has been enabled with s_stream.
> 
> Could you extend this to indicate this field can't be used by anything
> else than call_s_stream() ?

Yes, I'll add that.

> I'm also getting a bit concerned about having multiple fields with
> similar purposes. Another option would be to call the .s_stream()

I agree, it's getting slightly complex. The reason is that we support 
many ways for the subdev to implement these things.

> operation directly from the fallback handlers, instead of going through
> call_s_stream(). That may be considered as a bit of a hack though.

I thought about the same thing, but I felt it might just make things 
more complex. However, with my new unsent series, I add the privacy_led 
code also to the v4l2_subdev_enable_streams() function, so it's even 
more similar to the call_s_stream.

Maybe I'll try it out and see how it looks like if I call the op directly.

  Tomi

>>    *
>>    * Each instance of a subdev driver should create this struct, either
>>    * stand-alone or embedded in a larger struct.
>> @@ -1091,6 +1092,7 @@ struct v4l2_subdev {
>>   	 */
>>   	struct v4l2_subdev_state *active_state;
>>   	u64 enabled_streams;
>> +	bool streaming_enabled;
>>   };
>>   
>>   
> 


