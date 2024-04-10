Return-Path: <linux-kernel+bounces-138660-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9F6C89F8C6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 15:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB67E1C26EDA
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 13:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80005175559;
	Wed, 10 Apr 2024 13:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Sijbo0wB"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA1172BBA
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 13:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712756482; cv=none; b=AUQYddQo3fPtIKnOXWjBJz7SR4NzhhAhn6ytHEIFltWHgBobsAyve/eZOhwNl4wdSwHF3wZl1NXKX0+mFPxfUb4fZAnyxThr3Xz09u/UfH1UZNl5HXdtsOGOhwdOk6WxpDqe4V2hKIE0AvSnp/6UfroQ8OLVgwjRa46TkDgCJ2A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712756482; c=relaxed/simple;
	bh=k0CH/a1jNKnCDIQuOguNEBZ9OLWpbwWqoxiSC22YPsc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tyIw1NU1+yyQT3f6xjTKHMDcptZrGNGqinG+5ke/UP2tVGfqEGlW3OFpd/Vkd1R1J8dmurwviyudLItoLc9vdDRlm0G4nPg0JShrDOtcpCzMVtdN/9zGCRaJ1e+T7BSpgGcFkK0yLhEA5yQuepw97aGb+D/B3kwAk+9e6eY3T9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Sijbo0wB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712756479;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ab619jrMzt5I3ibFPcgw5mCCVGGcuTpmLYw+UMQ/Irk=;
	b=Sijbo0wBznl7AgRPgBRNMkwjDvyo1zcy96GDNrjcpmG0fWbqGIhZZKk2MV47WynwusEE4+
	NBjiOQGwEJoN/DABUWOO0pr797pDJz3nd0CyFDCZ1gE/E6vwbmg+hxdCINKnyDjbS4q33k
	r92uWl00A4/nmsdYUKKxcHKIwwNBeI0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-453-bw0j1vINM-CMfNCMxC9nHA-1; Wed, 10 Apr 2024 09:41:17 -0400
X-MC-Unique: bw0j1vINM-CMfNCMxC9nHA-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a51c03c9b8bso173924566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 06:41:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712756476; x=1713361276;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ab619jrMzt5I3ibFPcgw5mCCVGGcuTpmLYw+UMQ/Irk=;
        b=B+hVfeibrpRVm4OA0v+QkPfsdecTM3LkMFNxa9sNCWFdledCyIEQ5EqVj4erIR42/v
         FV4N5xAa7K7doGrFYC8Fwhr0e6IM4C5e+N3FoHVh74outGm3fSNvaTdLZszkMtty+CeE
         7ZNeTr6LiRAiQB0KXx2hP9cY3vscFPUESWHkD9io2eF7H3dwStiFHQimWoo6BgklLug5
         yGb+Vr6pVjiN4aJiDx7zLZG5RUrqeuyptP0/T93Rc9P4T0Oqq+I92DY3NqITcPpfTAcp
         +i5urJPpYF4HtT7saQPCBZmrBrOSXqo3tmXMQnduhdkYrFzyQZBR9JsosRbi9FwJmyQS
         nGpA==
X-Forwarded-Encrypted: i=1; AJvYcCXBSdQzD7bHe1pHBIa5YFpdNkmp46KlEF4DO/cYzMMlMSRx1BwnROLy57YlgJWyducoTNVePN+s0aNcFAAXP+gaWJnOi8ckoOQvPVnn
X-Gm-Message-State: AOJu0YwU1OJPjA9LHOOpLzCwDBgKR9QDykEdxNLwXsxiK+F6aYqV+rMA
	N6atx2S+5JBUC1xNwoHOD68/go4ce0MQVmlLbk3x/ImoCO5F4PFuOlMw2251Mwf5E2FlQsHfFwB
	hOeWaB8taYqWzy5Z8LzLJA149rfOXRSe80lIQEw5wgKUM6oZKxuvFbmrlGGN0Cw==
X-Received: by 2002:a17:906:af1b:b0:a51:9304:19fa with SMTP id lx27-20020a170906af1b00b00a51930419famr1415215ejb.70.1712756476590;
        Wed, 10 Apr 2024 06:41:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEdjpMtdgVHK4SQs/9xte3kBf7W5yLaCB8xMVEkp4VrQrxxyFyhsuMGpRk8TEtW9ItXtZpaGQ==
X-Received: by 2002:a17:906:af1b:b0:a51:9304:19fa with SMTP id lx27-20020a170906af1b00b00a51930419famr1415206ejb.70.1712756476292;
        Wed, 10 Apr 2024 06:41:16 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id h1-20020a170906718100b00a51bd3bfec3sm5553700ejk.121.2024.04.10.06.41.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Apr 2024 06:41:15 -0700 (PDT)
Message-ID: <911d84a7-cb3b-4ca5-86a1-334e7b3f85c6@redhat.com>
Date: Wed, 10 Apr 2024 15:41:15 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] media: atomisp: Replace open-coded
 i2c_find_device_by_fwnode()
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
 linux-kernel@vger.kernel.org, Mauro Carvalho Chehab <mchehab@kernel.org>,
 Sakari Ailus <sakari.ailus@linux.intel.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20240326202813.1425431-1-andriy.shevchenko@linux.intel.com>
 <20240326202813.1425431-3-andriy.shevchenko@linux.intel.com>
 <c9741df0-6c12-4ff5-90b4-5a13f0bd9b51@redhat.com>
 <ZhaVnYtFoTaFOKD-@smile.fi.intel.com>
Content-Language: en-US, nl
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <ZhaVnYtFoTaFOKD-@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi Andy,

On 4/10/24 3:35 PM, Andy Shevchenko wrote:
> On Wed, Apr 10, 2024 at 12:35:29PM +0200, Hans de Goede wrote:
>> On 3/26/24 9:27 PM, Andy Shevchenko wrote:
> 
> ...
> 
>> I'm going to merge this variant into my media-atomisp branch
>> instead of the orignal.
> 
> Thanks!
> 
> This explains why changelog made the commit message.
> Was it done deliberately?

Oops, no that was by accident. I normally git send-email
+ git am my patches and then git am cuts it off...

I just send out a pull-request with this minor wart in it
(after testing), so unless there are other reasons to respin
I guess we'll have to live with it.

Regards,

Hans



