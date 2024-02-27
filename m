Return-Path: <linux-kernel+bounces-83598-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43A50869C15
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44BF41C21ACB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 16:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95AE51487EB;
	Tue, 27 Feb 2024 16:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PALDXWLI"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28942145321;
	Tue, 27 Feb 2024 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709051279; cv=none; b=ITURFkYBmI3AdTjsQljs8r7U4sf0Z34blO9nr4qfH96aepwW8WPt6d9wPfkBIX3nsydCgrrvHsGsYAG7hxQzi1UEmoixu4KZS4Yv1fPOR6BPBNjRUyXzbPwMPAuFn5a21/xYTruMav2v0CK25R9xEQ5A6rmDpg68oH9CGv3hIh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709051279; c=relaxed/simple;
	bh=YktS9dxlM50RHOnP7vVul3eD1UdiPaSXTO3fwBv+RJg=;
	h=From:Subject:To:Cc:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=uGc/MglIYMKBcZfD9MwKdWpdp9CNs27xVCGTaCsW4FLD0Az0Gd557el3bKgmlUqrFjGxqwxYBNpxCX8MRkQG80r5VxN+iDBQVXnzdI7/yklqm8BhoIl8zUX6yQrDHs5WxIlHufmZOnVXuH3Erx3R9FjKsOZtWJhQmXqT2YRZB6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PALDXWLI; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-512f5484a37so4138754e87.3;
        Tue, 27 Feb 2024 08:27:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709051276; x=1709656076; darn=vger.kernel.org;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pAD8RHKxb4G97R9G/dSDm2p0nboqUuatq3J8Tyt7hHw=;
        b=PALDXWLIETybPoknflqESM5QvOpIpGLxCr3cBGDtPy2BkJapPLqxdUm7BJep6oDxkI
         Awl+uY9X1T1TQl/mSPaKotoTgxBnGnVgZ0/l9jvCt7/u9AzjUp4UprLgIq/yZNYIjNul
         ZZJFa45fxrJoTy6+z1fovd3ltn6AKnATmVtHoEmAHbO7crxK0kl9gpSMHU+RpXpTFjzK
         J4p8amYiec9Idoew74mmwmNBZDGk9zRdGsUnTTJG/a8lJyh8jvmCAAY6eW270O3MfoDj
         QpBaq2LfM6+5kIm2wpA/PKYNlPTGgGs1Vduf2P67tuGITlJbzG/j3YLW6+dpklSXrO/h
         gMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709051276; x=1709656076;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:references:cc:to:subject:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pAD8RHKxb4G97R9G/dSDm2p0nboqUuatq3J8Tyt7hHw=;
        b=duDVZ95sHaijtatfduZMJSgg7mLUsL53yOMobd9xfb7qcQeRLGsytGHirUqmHd3tEl
         jtSHs32H99DET1/GKj1nN9jyQdIGT7hIgwHSRk5V9NSn588+iGj2LHusVKoQ05UklTBl
         jZmOdZ8+/dJv/K53Rpez6lWSWVxLy/yKtU75JJNOSsp4F2iGiA8pmeNQ2lD/yVBnn1TO
         sPtjl67yMC2h+PHlkvHbmPOidLA1oHHS8YIX3SaAc1PiqjNwLbKOv+tQb22i5dpDyBjt
         84gfzdkhzkHOOGrfBvWws6N5c8OAnD0UeYoOLFsKOXGxPrv2ObcALrFedrzL2fpIi7BX
         zH3Q==
X-Forwarded-Encrypted: i=1; AJvYcCVJIa3drgi/vXKANhdOhA022m8fLwLx4VyB7adNauGKKm/8Q6cDI2H8EO89ZHwv62WdsFAZPpGBvsj1GseyJ/VSMld5F6mCszWWlhfwF85g1NVfPMNU3bpwzCEKw/Vl1yRuj49YLA5RVD5XsMMbimNkMevfnNm98aa1utaZS53eDuWfgg==
X-Gm-Message-State: AOJu0YzYois/TsvxG5dFPj3jTBCXzaMnV39IEg3qzjS2xvtrc+BRUnUI
	q49ksPNDOZjTQOD/rjHMCFgOfmCtYwGH7p/MLElQ3c8kc9jl1vHK
X-Google-Smtp-Source: AGHT+IFpwoAicjquFREyBDbKYQUFCXwCwdKRl7/9LNLPcrPsJ5bojUYGEl8JJyGvR0rQSkxAnasFMw==
X-Received: by 2002:a05:6512:1317:b0:512:f59e:f425 with SMTP id x23-20020a056512131700b00512f59ef425mr7507569lfu.10.1709051276022;
        Tue, 27 Feb 2024 08:27:56 -0800 (PST)
Received: from [192.168.1.105] ([178.176.72.204])
        by smtp.gmail.com with ESMTPSA id v15-20020a056512096f00b005129994f013sm1236235lft.184.2024.02.27.08.27.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Feb 2024 08:27:55 -0800 (PST)
From: Sergei Shtylyov <sergei.shtylyov@gmail.com>
Subject: Re: [PATCH v3 4/8] usb: cdns3-ti: support reset-on-resume behavior
To: =?UTF-8?Q?Th=c3=a9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Roger Quadros <rogerq@kernel.org>,
 Peter Chen <peter.chen@kernel.org>, Pawel Laszczak <pawell@cadence.com>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 =?UTF-8?Q?Gr=c3=a9gory_Clement?= <gregory.clement@bootlin.com>,
 Kevin Hilman <khilman@kernel.org>, Alan Stern <stern@rowland.harvard.edu>,
 linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240223-j7200-usb-suspend-v3-0-b41c9893a130@bootlin.com>
 <20240223-j7200-usb-suspend-v3-4-b41c9893a130@bootlin.com>
 <b778d2e8-3fcf-afe4-2e48-0348be19a085@gmail.com>
 <CZEXIZWQO1XB.1YY4P72A2K1HJ@bootlin.com>
Message-ID: <20c29fee-691d-686c-83c9-578e15b5ba79@gmail.com>
Date: Tue, 27 Feb 2024 19:27:53 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <CZEXIZWQO1XB.1YY4P72A2K1HJ@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2/26/24 1:13 PM, Théo Lebrun wrote:
[...]

>>> Add match data support, with one boolean to indicate whether the
>>> hardware resets after a system-wide suspend. If hardware resets, we
>>> force execute ->runtime_resume() at system-wide resume to run the
>>> hardware init sequence.
>>>
>>> No compatible exploits this functionality, just yet.
>>>
>>> Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
>>> ---
>>>  drivers/usb/cdns3/cdns3-ti.c | 27 +++++++++++++++++++++++++++
>>>  1 file changed, 27 insertions(+)
>>>
>>> diff --git a/drivers/usb/cdns3/cdns3-ti.c b/drivers/usb/cdns3/cdns3-ti.c
>>> index 4c8a557e6a6f..f76327566798 100644
>>> --- a/drivers/usb/cdns3/cdns3-ti.c
>>> +++ b/drivers/usb/cdns3/cdns3-ti.c
>> [...]
>>> @@ -220,8 +226,29 @@ static int cdns_ti_runtime_resume(struct device *dev)
>>>  	return 0;
>>>  }
>>>  
>>> +static int cdns_ti_suspend(struct device *dev)
>>> +{
>>> +	struct cdns_ti *data = dev_get_drvdata(dev);
>>> +
>>> +	if (data->match_data && data->match_data->reset_on_resume)
>>> +		return pm_runtime_force_suspend(dev);
>>> +	else
>>
>>    Pointless *else* after *return*...
> 
> Indeed! I used this form explicitely as it reads nicely: "if reset on
> reset, force suspend, else do nothing". It also prevents the error of

   s/reset/resume/ here? :-)

> adding behavior below the if-statement without seeing that it won't
> apply to both cases.

   You were going to add stuff after the final *return*? :-)

> If you do believe it would make the code better I'll happily change it
> for the next revision, I do not mind.

   Up to you!
   This is a thing people usually complain about when reviewing
patches. I even thought checkpatch.pl would complain as well, but it
didn't... :-)

> Thanks for the review Sergey!
> 
> --
> Théo Lebrun, Bootlin
> Embedded Linux and Kernel engineering
> https://bootlin.com

MBR, Swrgey

