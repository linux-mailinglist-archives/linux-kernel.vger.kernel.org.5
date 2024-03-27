Return-Path: <linux-kernel+bounces-121368-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E72F188E6DF
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 15:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9EF1C2E87B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 14:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FBE613CF93;
	Wed, 27 Mar 2024 13:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xpw3M2ev"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C58D13CF86
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 13:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711546447; cv=none; b=DJ2d/0Hef+9eyEfi0sHB/vegUInXcDwl/7oLmKtAdaiBXRkuH+fVpeyZuKmVSbjOzkbtaHp44SwREFdaU+hcruOchqOtqjwOUcHs2WP0TzGkDjwmzgXOeGRjwwhprtgs37IhZqrA02bEH1HpGBIZvjLaK2FQqHoJN+t41rDAPgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711546447; c=relaxed/simple;
	bh=mhD5Bdbl9xqlD/ZzMYP8h2iIylF+PL/hxO84dCYV3es=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=AuNHyw/yrCB0rZonznB7wRtuTXHEoXdYyn5eEI52YmgicSQtsUNTJ9jUmctQt/V7q1Onh/Aw7KqM679AyDCBvD5xGW1oRSOKcrlH+ve6m6K0+6WGOZWfkVcPsfsWZR6McH90JgTzlCYmsbAODhaT7RngTmFX8CNTDHcrwPS2BJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Xpw3M2ev; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711546445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JBGHbR98SVbQuq7gLThAj4hcnxWXW+uct5ynf/kbRpI=;
	b=Xpw3M2eveBAj82v0R5T27Z6UehdqxqtxUHpJH4RSh0MAlJj3Eg7qcCxRMaVlyhehWIg98b
	g1Y00i+IZckOIhRP5Ro6aIuU9XcDwtljUwC8g+v53w//jryrzezwOnAGYyM4HKFUvH5hPO
	df516dG60DY9jutPx6h4zUQNEQyYWn0=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-407-xeQFq0lfMOyBNCmehH1yhQ-1; Wed, 27 Mar 2024 09:34:02 -0400
X-MC-Unique: xeQFq0lfMOyBNCmehH1yhQ-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a4df17773a5so147716466b.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 06:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711546441; x=1712151241;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JBGHbR98SVbQuq7gLThAj4hcnxWXW+uct5ynf/kbRpI=;
        b=IKRbvPjjL67a5RFeGRgP6XpJXgJ7xN1K0cLkfqxyJFw+1B/57gLTN1tGIelg0IMXiv
         1Xgdry6pUjmaPt20oMyRLkaUfTLUec8bMG67fQ5EypIIwj7TfVja/3/Cyun64E8H6fRr
         fN0dIpjmlIaOw67cg9SR5OY2shjjDENN5DfDwLbTsx4B9DkGAWUFyeryC2PUtPwYKrnr
         vAeMhqLHIMUEsESqAs+FryHQQR+9qdooQy/V0sGQHe9kkHfNTOI2k3Rkbk/XdR0M715Q
         3g7l4DZlBPSv0nVqZp37/13B1xAzT5eLhXajcbBMPDbky69rnu+Z/cCmKYugHe7KaXOF
         EPsg==
X-Forwarded-Encrypted: i=1; AJvYcCWk1+adXV6GXdXMRCsuqAbm/IusK+/lvrtb36AWXou+zwqaMg4D6m3my/7DtEHRMY2KuRV42Z841mCRazExfWeee1QfCSrvkipHFtpU
X-Gm-Message-State: AOJu0YxC2qQuMnTd6OuYIiRbHQkieEbYkwU2ZiI3KpQoePo3jvJ/IMv9
	PKXcLkHaS3B+C7gcmXIBnMcqfs7n4WyyHUa62II0dfw1QohvEnQtb1V3LmIDOVITkScY/RRNOlU
	zcSB/qHb+T3y2XnKhsMKB+uXdD3+zd2+t7IBLnkJNuHcUiW5n35AtIxhNCYRSSw==
X-Received: by 2002:a17:907:94c9:b0:a4d:fc83:70e1 with SMTP id dn9-20020a17090794c900b00a4dfc8370e1mr2502663ejc.56.1711546441747;
        Wed, 27 Mar 2024 06:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHJviY0St74qEyP6qellDd9zmlVznwxqV/gUPGQvopc0KPlLveQO7FVqAn+a+pURkrR1ZW/BQ==
X-Received: by 2002:a17:907:94c9:b0:a4d:fc83:70e1 with SMTP id dn9-20020a17090794c900b00a4dfc8370e1mr2502642ejc.56.1711546441231;
        Wed, 27 Mar 2024 06:34:01 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id bm2-20020a170906c04200b00a45c9ea48e3sm5417015ejb.193.2024.03.27.06.34.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Mar 2024 06:34:00 -0700 (PDT)
Message-ID: <2e4f42b3-fe64-43f2-a55b-c745a6903ddc@redhat.com>
Date: Wed, 27 Mar 2024 14:34:00 +0100
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
To: Sebastian Reichel <sebastian.reichel@collabora.com>
Cc: Konrad Dybcio <konradybcio@kernel.org>,
 =?UTF-8?Q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>,
 linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240306-power_supply-charge_behaviour_prop-v3-1-d04cf1f5f0af@weissschuh.net>
 <171148264419.185695.14027540198251584096.b4-ty@collabora.com>
 <6f0761a6-5f49-42e2-9b79-3e04c9d259a4@redhat.com>
 <9fe3d7a6-3b34-4c96-bd9f-510b41f9ab0d@redhat.com>
 <daactalkmzucga47cmncjkgnxyppouqnrj3vtsz34d5edrkmzu@p32ylpv3nqwx>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <daactalkmzucga47cmncjkgnxyppouqnrj3vtsz34d5edrkmzu@p32ylpv3nqwx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi,

On 3/27/24 2:25 PM, Sebastian Reichel wrote:
> Hello Hans,
> 
> On Wed, Mar 27, 2024 at 11:44:41AM +0100, Hans de Goede wrote:
>> On 3/27/24 11:36 AM, Hans de Goede wrote:
>>> On 3/26/24 8:50 PM, Sebastian Reichel wrote:
>>>> On Wed, 06 Mar 2024 20:37:04 +0100, Thomas Weißschuh wrote:
>>>>> To validate the special formatting of the "charge_behaviour" sysfs
>>>>> property add it to the example driver.
>>>>
>>>> Applied, thanks!
>>>>
>>>> [1/1] power: supply: test-power: implement charge_behaviour property
>>>>       commit: 070c1470ae24317e7b19bd3882b300b6d69922a4
>>>
>>> Does this mean that you've also applied patches 1-3 of:
>>> "[PATCH v2 0/4] power: supply: core: align charge_behaviour format with docs" ?
>>>
>>> Because this is a new version of 4/4 of that series and I think
>>> that the new test may depend on the fixes from patches 1-3
>>> of that series (which I'm reviewing now).
>>
>> Ok, I have some not entirely trivial comments on patch 3/4 of that series.
>> I guess you (Sebastian) could address those while merging, or wait for
>> a v3 of the series.
> 
> I can't. Patches 1-3 are already in 6.9-rc1. It looks you did not
> get my replies, but they certainly have been captured by lore and
> obviously Thomas got them since he send a v3 with just the last
> patch:
> 
> https://lore.kernel.org/all/20240303-power_supply-charge_behaviour_prop-v2-0-8ebb0a7c2409@weissschuh.net/
> 
> Anyways, I think your suggestions for further simplifications in
> patch 3 are sensible. They just require doing an extra patch now
> instead of being squashed.

Ah I see that is fine too :)

Thomas, can you do a follow-up patch with the simplifications
which I suggested in my review of patch v2 3/4 ?

Regards,

Hans



