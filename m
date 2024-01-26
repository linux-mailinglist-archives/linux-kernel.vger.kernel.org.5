Return-Path: <linux-kernel+bounces-39760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE85B83D5D0
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:16:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D6ED1C25FE9
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 09:16:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D452617727;
	Fri, 26 Jan 2024 08:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XU8lejyh"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801FE14002
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 08:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706257603; cv=none; b=NY3r81CWLQad1tsFXcDGMunB49i1oFwb5akvcHNd3ACWNwni1Z/VAox00mJgUM5elSm06+FHXWbMtIQ5Ua0HP2rN/70DFWO18GxpnkrxU+ZMQfb5S1p13Y3gh1pZCyZWziSTax1831xJRBH5NIt9ierh9bxkspHppM14xA5SuLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706257603; c=relaxed/simple;
	bh=6kk2NV9c1w0zaIhQxICS7x6KdWKZlgKcu7npsv2cmFI=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=HuY0Vy+HkQ/5Y59RmoVQzSNk2pAKDiz1PIVspxvtonp8HQeN3Vi8y6QcUzKTekH/YHZi2ZZvbNc5m9hj+5of5o+reIjo2qWN1bzW+BiRsnJ4R2a4grFr8WJn+HtFHeU6tXQuwCxAqjgzMlBeUB/PuKOEzx0MnaugTwVMkYHj+IQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XU8lejyh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706257600;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9ICXYGdieB3cj+aSe9CTQA4za3WFBWxWm5agm/epnCY=;
	b=XU8lejyhmY67W2lGykpG9pmqdKN22zAgCWizQ1UWji33bPHe8FiAKHjj/BLpcUHOVlH74u
	+puEYIN3VfbtlMrpaU/IqMrO7S5f7quX4aLaqvLtCU/WAEVDNF0o9SVXTBNat+Ug3RlRfD
	wbZskmti2u1/Fl4pWaI8pUmrSGfO7D8=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-644-SRGwGH8kOdO1nJS-Jxzxqg-1; Fri, 26 Jan 2024 03:26:37 -0500
X-MC-Unique: SRGwGH8kOdO1nJS-Jxzxqg-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a309495ba10so12254866b.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 00:26:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706257596; x=1706862396;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9ICXYGdieB3cj+aSe9CTQA4za3WFBWxWm5agm/epnCY=;
        b=bEHxtcoS+/NQuJq9+nCtEaOit2/ryHO3t9MW3HkTPUtIU1My9TK/xGRs2e/rSX4Nf4
         NB9PkMNQiZ8Xcp/H6F9M4aUqU7UX2OaI8Vx+9mlbbl+yU51ohrU9HcdzXroH6zvkv4zQ
         qPTStw9Ov7u3uqvsdHF6bWU+4/GkQtT/EUE1DtI5wOguEsx4XcEOvJMeHo6RJvS/qzWj
         8OFWN0c/+EQXLxgtvP15j0ofb0YfjRknEGLpY5nwShFE0P7KpQNwzP65X6qJoNQFeXQz
         S7OyaJfQTOFQH9A+3TSjsOahaANkRqXSQa0C8+SlZOKTzL6fG0vHb4mwyhULSTLb394B
         BhHg==
X-Gm-Message-State: AOJu0YxV+PEEp81SvIkuS3YYwc4kD4MHGJhjuTJXeog38nT1CQZLxxcU
	QxIXtArmbcIS+YyI4Koc87NDNQVVI4AYNdRDbYaMhagq8fXmZepeY15LrMZ1oiCmdmgoHwlhBpa
	OByTT7hsQQ3is41GhnoRjAElyIG3Ygzt84rVYzAWfAB2zaZukbT/pGf7sOU7yG6yv7Gd/Yw==
X-Received: by 2002:a17:906:5a87:b0:a31:7af3:f46f with SMTP id l7-20020a1709065a8700b00a317af3f46fmr811711ejq.77.1706257596405;
        Fri, 26 Jan 2024 00:26:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFkZxD9Na6c2lO4c1GObQdCLpT2U1GzwO/hh+eFyNuV/lcsO6jk5qSA9Qp193zhvIikvZ2Sjg==
X-Received: by 2002:a17:906:5a87:b0:a31:7af3:f46f with SMTP id l7-20020a1709065a8700b00a317af3f46fmr811700ejq.77.1706257596091;
        Fri, 26 Jan 2024 00:26:36 -0800 (PST)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id kt13-20020a170906aacd00b00a3407760e89sm366323ejb.222.2024.01.26.00.26.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 00:26:35 -0800 (PST)
Message-ID: <b9e8afdb-531d-41c8-9b5c-6556d8a6a6de@redhat.com>
Date: Fri, 26 Jan 2024 09:26:34 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: add Luke Jones as maintainer for asus
 notebooks
To: Luke Jones <luke@ljones.dev>, linux-kernel@vger.kernel.org
References: <20240115211829.48251-1-luke@ljones.dev>
 <da062d7e-c06c-40f8-b2ad-9dd5e82ff596@redhat.com>
 <9db5a3c1-40b1-43fb-9c31-53c28d2b63c6@app.fastmail.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <9db5a3c1-40b1-43fb-9c31-53c28d2b63c6@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi,

On 1/26/24 09:10, Luke Jones wrote:
> 
> 
> On Tue, 16 Jan 2024, at 11:45 PM, Hans de Goede wrote:
>> Hi,
>>
>> On 1/15/24 22:18, Luke D. Jones wrote:
>>> Add myself as maintainer for "ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS
>>> DRIVERS" as suggested by Hans de Goede based on my history of
>>> contributions.
>>>
>>> Signed-off-by: Luke D. Jones <luke@ljones.dev>
>>> ---
>>>  MAINTAINERS | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/MAINTAINERS b/MAINTAINERS
>>> index f5c2450fa4ec..e7843beaa589 100644
>>> --- a/MAINTAINERS
>>> +++ b/MAINTAINERS
>>> @@ -3147,6 +3147,7 @@ F: drivers/hwmon/asus-ec-sensors.c
>>>  
>>>  ASUS NOTEBOOKS AND EEEPC ACPI/WMI EXTRAS DRIVERS
>>>  M: Corentin Chary <corentin.chary@gmail.com>
>>> +M: Luke D. Jones <luke@lones.dev>
>>
>> heh there is a typo there that should be @ljones.dev ,
>> I have fixed this up now in my review-hans branch.
> 
> Thanks for spotting that. The laptop I have been testing has issues with key presses sometimes.

I "spotted" it because I used the email from MAINTAINERS for
another email I was sending you and that got me a bounce
message :)

Regards,

Hans



