Return-Path: <linux-kernel+bounces-162299-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D68278B5939
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:59:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E9991C2138C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 12:59:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DA46537EC;
	Mon, 29 Apr 2024 12:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B9Kj/NFQ"
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A21710971
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 12:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714395541; cv=none; b=g5GjE61z4Lo4pNfaoXa/ixH687UQQ0CHzQVey94v3a1BUeyjR/ryxbCRrvHsfwaOVtlXlOinmpTkSMDyDNRYJeDncW0PWtkiQq6NX2DQTpVpC7TWy482UiFYkdXnz7coeqvz/34BtlfPzOQBXgfF4MXT2rSDhR0Fb0RFAkGAL0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714395541; c=relaxed/simple;
	bh=vCbFiVFJCuRka58hjPNbWGQzUqLA0O+7ieiUkSok1nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A/dDTlDaOm70wIeFSR4kAy0At7Fi6lb5EP4MXl57Zs8/ErMR6402FUVfdlPALz2S/C9LDfHVdJUB8tuejAOnTovPKsQJlopwij5YlCUjEewSqlpXiiEc8s+EkTYkU+CzQpJeocYE0ktbJqMwixjQUdL+8mqs0pYD376s6+5rOuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B9Kj/NFQ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-518a56cdbcfso6919497e87.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 05:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714395538; x=1715000338; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7EKWBgytODZQU31rywUVJiOdjv7GH+YZfkGd8P3Apls=;
        b=B9Kj/NFQGK6hzBgDBfuvjxp+UvHzyiv2BW4BpWkSmfC3rKNWCwGq3/wX8X2Uybi5/F
         PqWXPA97KZT5PWuFqTBgXJSsJ8sqtDN3HPVBTdiYJkR3XsOExneWHfNbv+BdPO9EbTaX
         EC9Je2b+sBvB4ABkcCwhAed1SExvoXzsqq5HIe9UnTZ7YErY41gO9/jGPM6JrJXD/ka5
         4dmi+D/NVUMSqyhN+DFQkpY++1dCylfAKDZnAmyF4+uSU3ldvw8rivTu5nZFrtr/wCWI
         AK9p9uGaQ8ALON2eAyG1EQNS53a0T1PHAKXuuYdBp/5d+d+x9IOCgUNUEZwebVrcMZx4
         xFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714395538; x=1715000338;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7EKWBgytODZQU31rywUVJiOdjv7GH+YZfkGd8P3Apls=;
        b=mGm9+39Y0DqC762oyCmT4rboQIYxsi4ls+T/bqPFP8QNpUpZKmsCrp/2aDLASR9umJ
         Ac7I3bi72Y49+XeKgISp3Eysj85UomPJ3rODLyZ4eHhliM7hlhikabiHpz9oq6WJMja4
         0PzPt4CIDHU9A0Rcp7TXIfC74/o776AaiJIVq+8SXFd2yARqZmfXUeHGagxpVTRljUND
         +CsetfNN1nnyFjIAAFCwpGN1ve4pzTtupqRV4X6KgvEYTsl/L/vUBYE6hzwicvoqe1li
         wRoTvOZgSiFkLTiyuYGFgHLJLA4IPhA92sah35jg5WazbKzYpfjEf+8HBjYmovB17eB8
         eeoQ==
X-Forwarded-Encrypted: i=1; AJvYcCWtGBwkhdEBS695UTT3fInBcdrcxopL9t2HLg1nwa171a4/Bz96JFBmdqxFETkgkjQ8RPMUcccm+1KNpoZQD7OVjyk5/hpEZAUsRa90
X-Gm-Message-State: AOJu0YytFP0xZ2yoBpV+yyR/NrGvM47sjy5Fx5W6WHOZ1O5MMBW1EukA
	28Vn2dVkVReJ7LVUfUw2PHjJGRNA9ep1nFehJumM9bhCizbQ4fmX
X-Google-Smtp-Source: AGHT+IEj2BMZHDIBuNJn1hbnu7Hgi2WDKZTw2Vu62n0umPjAWJzgMApXkwlF0Akz0AeulTOhq8uyRg==
X-Received: by 2002:ac2:5b9c:0:b0:51d:3acb:1d8b with SMTP id o28-20020ac25b9c000000b0051d3acb1d8bmr4865274lfn.62.1714395537432;
        Mon, 29 Apr 2024 05:58:57 -0700 (PDT)
Received: from [10.214.35.248] ([109.245.231.121])
        by smtp.gmail.com with ESMTPSA id v12-20020a056512348c00b0051af75b5b93sm3037276lfr.226.2024.04.29.05.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Apr 2024 05:58:57 -0700 (PDT)
Message-ID: <f90f5352-30ed-419f-803b-7885b4298868@gmail.com>
Date: Mon, 29 Apr 2024 14:57:35 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] arm: kasan: clear stale stack poison
To: "Russell King (Oracle)" <linux@armlinux.org.uk>,
 =?UTF-8?B?Qm95IFd1ICjlkLPli4Poqrwp?= <Boy.Wu@mediatek.com>
Cc: "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mediatek@lists.infradead.org" <linux-mediatek@lists.infradead.org>,
 "andreyknvl@gmail.com" <andreyknvl@gmail.com>,
 "dvyukov@google.com" <dvyukov@google.com>,
 "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
 =?UTF-8?B?SXZlcmxpbiBXYW5nICjnjovoi7PpnJYp?= <Iverlin.Wang@mediatek.com>,
 "mark.rutland@arm.com" <mark.rutland@arm.com>,
 =?UTF-8?B?TGlnaHQgQ2hlbiAo6Zmz5pix5YWJKQ==?= <Light.Chen@mediatek.com>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, "glider@google.com"
 <glider@google.com>, "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
 "vincenzo.frascino@arm.com" <vincenzo.frascino@arm.com>,
 "angelogioacchino.delregno@collabora.com"
 <angelogioacchino.delregno@collabora.com>
References: <20240410073044.23294-1-boy.wu@mediatek.com>
 <CACRpkdZ5iK+LnQ0GJjZpxROCDT9GKVbe9m8hDSSh2eMXp3do0Q@mail.gmail.com>
 <Zi5hDV6e0oMTyFfr@shell.armlinux.org.uk>
 <292f9fe4bab26028aa80f63bf160e0f2b874a17c.camel@mediatek.com>
 <Zi+Vu29rmNZ0MIFG@shell.armlinux.org.uk>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <Zi+Vu29rmNZ0MIFG@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



On 4/29/24 14:42, Russell King (Oracle) wrote:
> On Mon, Apr 29, 2024 at 07:51:49AM +0000, Boy Wu (吳勃誼) wrote:
>> On Sun, 2024-04-28 at 15:45 +0100, Russell King (Oracle) wrote:
>>>  On Fri, Apr 12, 2024 at 10:37:06AM +0200, Linus Walleij wrote:
>>>> On Wed, Apr 10, 2024 at 9:31 AM boy.wu <boy.wu@mediatek.com> wrote:
>>>>
>>>>> From: Boy Wu <boy.wu@mediatek.com>
>>>>>
>>>>> We found below OOB crash:
>>>>
>>>> Thanks for digging in!
>>>>
>>>> Pleas put this patch into Russell's patch tracker so he can apply
>>> it:
>>>> https://www.armlinux.org.uk/developer/patches/
>>>
>>> Is this a bug fix? If so, having a Fixes: tag would be nice...
>>>
>>
>> This is a patch for cpuidle flow when KASAN enable, that is in ARM64
>> but not in ARM, so add to ARM.
>>
>> The reference commits did not mention fix any commits.
>> [1] commit 0d97e6d8024c ("arm64: kasan: clear stale stack poison")
>> [2] commit d56a9ef84bd0 ("kasan, arm64: unpoison stack only with
>> CONFIG_KASAN_STACK")
> 
> These are not suitable for use as a Fixes: tag because these commits
> refer to code in another part of the tree that has nothing to do with
> the BUG() dump that is contained within your commit message.
> 
> I ask again... Is this a bug fix?
> 
> Is it a regression?
> 
> Is it something that used to work that no longer works?
> 
> When did it break?
> 
> Has it always been broken?
> 
> Has it been broken since KASAN was introduced on 32-bit ARM?
> 

Yes, this is a bug fix and it has been broken since KASAN was introduced on 32-bit ARM.
So, I think this should be
	Fixes: 5615f69bc209 ("ARM: 9016/2: Initialize the mapping of KASan shadow memory")

