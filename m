Return-Path: <linux-kernel+bounces-48630-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D545C845F0B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 19:00:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2BA81C2645B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 18:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4412E7C6D4;
	Thu,  1 Feb 2024 18:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b="UTyMtvPB"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08BB082C9B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 18:00:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706810409; cv=none; b=FA3ag8v5QNfriqJRQPIvzloveH4KIYC2EENQxirdMf/PBJsTuV7QzcWe2zeO7Zd+K0wKC4N3JMhhkBqAMyB4G1HW6frg+IRur0zzmxW6bvwXBrqx40I9xzHZRjmIIzI2+WUGHWx3E59qdfbauUc2pf5fEy2+SMziGU9w8HyxtaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706810409; c=relaxed/simple;
	bh=xZ8ZbcaUe7yTmRh6cDXF56X3uexRJQOkIt96gRLqres=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iWE5S5wgQirEiOnXRUSC+7mdw3MAqE9X465nCNoojE8Z/W8sboSaCTzBVjwXy1vxpw6WMpGYcg9NvXGBCPui6+H8t5Bv64zVXUa3nhhDv+06bqTUl8Kq9uce1CK1aua9IqAYmokfbznhh9KjssRf0Xr2MU5Q/kxmo/RGPO8Exqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us; spf=none smtp.mailfrom=resnulli.us; dkim=pass (2048-bit key) header.d=resnulli-us.20230601.gappssmtp.com header.i=@resnulli-us.20230601.gappssmtp.com header.b=UTyMtvPB; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=resnulli.us
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=resnulli.us
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51032e62171so1606385e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 10:00:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=resnulli-us.20230601.gappssmtp.com; s=20230601; t=1706810405; x=1707415205; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=l9l/Ks3FwSNvLM2hMCm48ItF6y1Oypj1xpaB/2U4Xsw=;
        b=UTyMtvPB0UsVkiQ1rX6YVu5FceTwn+NP/sKM5POsETLx6OgNJ4cdRRkJBhqMY+Qtt8
         ++VDUUCnh3kczoqyR3hWNRmlPSgnmKwU5A1PhncdAdHsQEpyUQixj1S5FLtD8eTCLSEh
         tCDjvn9j65aKcx8PqqTU+/pCdsJiJ+nN0XSaWIhFE/bktX34XWHw7g8ItpGFFC04dx8g
         L/K2O0TjrXxKf6T0E6Xy/AhzuE17zut1iZzjDXgt2Wd+WzN5qzObXr4fNBJLwrqipUEg
         vTHG/2zaYDsxAm4B9pV6fdI1mLOiXCoK/OtrGjdI9qgrz6hJ85v4K1QT6vBCU3JVRZ/2
         08Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706810405; x=1707415205;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l9l/Ks3FwSNvLM2hMCm48ItF6y1Oypj1xpaB/2U4Xsw=;
        b=rOCwaA8nYsojZrUFRfCbQgaJ6SVf4hm4qTXrF8nrJwMlpuYmvc0SPkhga8ZrngU0oU
         KBFccpqvgmEVGPSd+FChxELnVaRLFmJeWxY1x+wSJQB5NocGfPMQRX0JqYppptTVAmWI
         3KoG/m1FBI7AUP1Oxjbf0d9SdIJPUqPVkAsOjqrYc1txJ2MJdRvcKlqRWLkmYAKJ7+hP
         SP2bIMzUcX0gv51anfSbWNtKyupXkqYjTDC0eVCVxxjli2SvHpbR7sB97kSgIl08oN0B
         TmOzF3f4Wo92s8HOfgS+Li4PZT/LxHeVwlHwZIeahNbJ3PZDAtGXZHATH3YnORhihqZT
         QxbA==
X-Gm-Message-State: AOJu0Ywj4t96oXnIMsAQaK1Ac4xaVuxzS3avMqmTkao2PTTcM4XCooix
	l726zsPR7HSfEaagu+477swwUIgXX4Oo0Rj+kKmknEhGA0P64irnoqzN/J5UMpQ=
X-Google-Smtp-Source: AGHT+IHqkjvgizfg/wSq8y5wB8kbAG3my4pfExqVeZaVW9f+BpF6RTU5E4om88VOGadI+ka8teM8UA==
X-Received: by 2002:a05:6512:23a5:b0:511:32f8:6ee2 with SMTP id c37-20020a05651223a500b0051132f86ee2mr626335lfv.63.1706810404746;
        Thu, 01 Feb 2024 10:00:04 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWipTU60Yl3k6PAhDBOth7KFLe7semj5iOH0FepVVF0fj72v9uXgOJUnCHqyidi6OBVp9GUTHfNXgiYQhYukTO342v3xYTXlHg5R7lFqMNz/0CCDOO5VCWAVMmNZCeFVd/etOuP9JhRQ7u0C6BU/043ttYdmZv5MVSCXXiS4/jIaRHqlHmMgHBvVpZJBEVf6QG2xHJgQeB7hSeI07Utd5p4H64kMldibvPE5Sc4TaI4dtoBF1VT0+X6hc7PZpCgi7smnw5HShJjavvb/nmwNA==
Received: from localhost ([193.47.165.251])
        by smtp.gmail.com with ESMTPSA id z11-20020a5d4d0b000000b0033ae6e9faebsm33859wrt.4.2024.02.01.10.00.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Feb 2024 10:00:03 -0800 (PST)
Date: Thu, 1 Feb 2024 19:00:00 +0100
From: Jiri Pirko <jiri@resnulli.us>
To: "David E. Box" <david.e.box@linux.intel.com>
Cc: netdev@vger.kernel.org, ilpo.jarvinen@linux.intel.com,
	sathyanarayanan.kuppuswamy@linux.intel.com,
	linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH 4/8] platform/x86/intel/sdsi: Add netlink SPDM transport
Message-ID: <ZbvcICGKGcD3IHTs@nanopsycho>
References: <20240201010747.471141-1-david.e.box@linux.intel.com>
 <20240201010747.471141-5-david.e.box@linux.intel.com>
 <ZbtjyOBHzVKXu_4H@nanopsycho>
 <94a61858ac82ceaac1ef8ae41067ae7356512d7d.camel@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <94a61858ac82ceaac1ef8ae41067ae7356512d7d.camel@linux.intel.com>

Thu, Feb 01, 2024 at 05:42:33PM CET, david.e.box@linux.intel.com wrote:
>Hi Jiro,
>
>Thanks for your comments.
>
>On Thu, 2024-02-01 at 10:26 +0100, Jiri Pirko wrote:
>> Thu, Feb 01, 2024 at 02:07:43AM CET, david.e.box@linux.intel.com wrote:
>> 
>> [...]
>> 
>> 
>> > +      -
>> > +        name: spdm-req
>> > +        type: binary
>> > +      -
>> > +        name: spdm-rsp
>> > +        type: binary
>> 
>> I don't understand the need to use netlink for this. Basically what you
>> do is you just use it to pass binary blobs to and from FW.
>> Advantages, like well-defined attributes, notifications etc, for which
>> it makes sense to use Netlink are not utilized at all.
>
>SPDM supports the setup of a secure channel between the responder and requestor
>using TLS based encryption algorthms. While this is just a transport for those
>blobs, netlink seemed an appropriate interface for this type of communication.
>The binary blobs can instead be broken out into the SPDM protocol messages,
>right out of the spec. But for our needs this would still just define the
>protocol. The algorithms themselves are not handled by the driver.

If that is a standard, break it from blob into well-defined attributes
and push it out of your driver to some common code.


>
>> Also, I don't thing it is good idea to have hw-driver-specific genl
>> family. I'm not aware of anything like that so far. Leave netlink
>> for use of generic and abstracted APIs.
>
>Sounds like an implied rule. If so should it be documented somewhere?
>
>> 
>> Can't you just have a simple misc device for this?
>
>It wouldn't be too much work to convert it.
>
>David

