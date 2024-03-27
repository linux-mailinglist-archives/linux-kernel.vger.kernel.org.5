Return-Path: <linux-kernel+bounces-120673-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BFE0A88DB50
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 11:36:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7890129BAEB
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 10:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B6032EAE6;
	Wed, 27 Mar 2024 10:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d+l9uXIP"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063718C31
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 10:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711535769; cv=none; b=F42TSNC5ShzMQGaNhWH3UkfGbUxWuhP2wbLcVuS2LmFayzcWOapwRVM1GsF677X6de6Pl+8bcQTW+kBtHwRpI1SzfwLKJ2DiUx0MH8DDUMjfeCMSdmMx2uVVvFWjwBcwCYJhd+DfKG3N34au/Zm2Cm9EoniWBVMs7kjxE62pkfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711535769; c=relaxed/simple;
	bh=xqorqSSQcCa57WDHswkGBO57lmShWDt+11TKMdzLhfY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ndrKR8fqwgCtK2+zNyGdgF7p9N7nLRygqI3zPrhi45+Q2E8Z8w0ToUXldHVcMz1JJru8dvm5IbwO4QDl4h3CiY3l8X9tuD/b5PXBjxgQdtFGzocar2pu83JCKsNixKxnFkTx6twD2dQXVJ+WcWAGUwyyyA+JyRFHAANkKR+GcRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d+l9uXIP; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711535766;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kf0Xa0I3oo6j0q/YyccFGyxt0Y4pFFj4J4v02xp8sgw=;
	b=d+l9uXIPx93qI1HoSfquy2ayx8QUQN9EQNE0xFm1A4SeN6SUX1kudrkHgEsCPVPCztO7Tw
	m8qPzG7jmcS40opMaNi8dPYPjaoOPc3vdOolreMrsXg6/8TkJz6e11TOL7qNcf+LI5Pe4s
	hhHTvHD0JjQuAG8yqfVmA78muYFrPxY=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-231-TEw-IpXsMs6subDpi0717g-1; Wed, 27 Mar 2024 06:36:04 -0400
X-MC-Unique: TEw-IpXsMs6subDpi0717g-1
Received: by mail-ej1-f71.google.com with SMTP id a640c23a62f3a-a4e03687359so32850866b.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 03:36:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711535763; x=1712140563;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kf0Xa0I3oo6j0q/YyccFGyxt0Y4pFFj4J4v02xp8sgw=;
        b=cI016eqw7vhNYI/9LgclmFUMPrICu9mJsaAjNUOJK7He4YID0ZNhEZWnHnDuhaZ8IP
         mLVHpaF1fMhHva3kFDEtTbIIfEpxzg9F8nb8X1HdjLt6cOGCa4eVOuYvxTozNGN5g3WX
         rcXGTxHhokx8r8J0gPpsdXAFhZdEXNybJtaVBr66X9bjgSqgf2M5AdN71DUrnSOAoqx5
         lI+bvzWWD3mTnrUI9fR/quXars83nZPIa3mhy0BH2EJy5hIm0xnwfKNbpqqkCpU32DeE
         TTGEgX2TInfDc1BNBxw+G/Z7AJ0vRGhaVmy84+3omaEtTzzwrZpCvXAflCF9AamBQOQK
         8tUg==
X-Forwarded-Encrypted: i=1; AJvYcCX/2ha/0xwSMflgIYvbKG5ndE2wonhqZcveNxk+WwGyOOt/N6ENhWMzID48HhivzQ8Eq5zDknlE2eNPHC3jR0cgoyLkWDmWVr8CSgfu
X-Gm-Message-State: AOJu0YzENuwAkpIpbrn3cwn7C30dML9ow0AKYr2ulJ4soa8n5Foj79Ne
	imJShVkSTVGAr7EMveOG5tLfjd+PmwNW5IHTHowSaKE/4S9yyU2r/DMrcGo9yUYbIHVPgmakIj9
	o7nXxKepTc8L9Sjei32C2uXiphkCUIH/2IcOUTcaDETvEyAt0iCSGHAUAIf57IQ==
X-Received: by 2002:a17:906:6b13:b0:a47:340b:df71 with SMTP id q19-20020a1709066b1300b00a47340bdf71mr1670497ejr.2.1711535763756;
        Wed, 27 Mar 2024 03:36:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXIJnfqBe48JPS7KAJBUSmGXBW5NQxks56Wy5f+VzFBwfzkgubS3ihGGHzdYeX4eRBxnJSdw==
X-Received: by 2002:a17:906:6b13:b0:a47:340b:df71 with SMTP id q19-20020a1709066b1300b00a47340bdf71mr1670485ejr.2.1711535763405;
        Wed, 27 Mar 2024 03:36:03 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id ch12-20020a170906c2cc00b00a44180ab871sm5258891ejb.50.2024.03.27.03.36.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 03:36:02 -0700 (PDT)
Message-ID: <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
Date: Wed, 27 Mar 2024 11:36:02 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] power: supply: test-power: implement charge_behaviour
 property
Content-Language: en-US, nl
To: Sebastian Reichel <sebastian.reichel@collabora.com>,
 Sebastian Reichel <sre@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
 <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Sebastian,

On 3/26/24 8:50 PM, Sebastian Reichel wrote:
> 
> On Wed, 06 Mar 2024 20:37:04 +0100, Thomas Weißschuh wrote:
>> To validate the special formatting of the "charge_behaviour" sysfs
>> property add it to the example driver.
>>
>>
> 
> Applied, thanks!
> 
> [1/1] power: supply: test-power: implement charge_behaviour property
>       commit: 070c1470ae24317e7b19bd3882b300b6d69922a4

Does this mean that you've also applied patches 1-3 of:
"[PATCH v2 0/4] power: supply: core: align charge_behaviour format with docs" ?

Because this is a new version of 4/4 of that series and I think
that the new test may depend on the fixes from patches 1-3
of that series (which I'm reviewing now).

Regards,

Hans



