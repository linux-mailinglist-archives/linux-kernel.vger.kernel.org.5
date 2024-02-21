Return-Path: <linux-kernel+bounces-75341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A42CB85E6E3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 20:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55F5F287868
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:06:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E5A85926;
	Wed, 21 Feb 2024 19:06:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+LqEYHc"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4140785953
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 19:06:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708542379; cv=none; b=OMep+rdxlfcUOaPtmx9TAE/QGPQ/SKWfF4rQjpOxqH8gXcfxfIXXnqiRq5UVCxg5rO9c3V2hE8wPXY0YXbfGXEnhzV8h1/jkgZI9n1M8i6IWIOIUJxOlHCKRaWYZ/hLY5wznSOuq7m3L45i7Fkov10hD1AXVKnbUQYQPrq+siso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708542379; c=relaxed/simple;
	bh=nQkkE0SX6fHuurzKVAkKwMHh5voYItjllI504GFJs9w=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fcviOgBZl9cJAjLPrZ5WYDYeWMENV45Sx1TDgin8J++WKdCp9q4dw+rcEYl4ue0dTkw6nLkFrYVNtPEVWPxLmh89u0/tRPT8d6DGWqXrrzjCNRksX2+GAx5GdtRyqGz8CZP125ur+yh2u1fj3Cqk9OGWOdfC9jkkWQ0TlElVUAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=S+LqEYHc; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708542372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1+0GfmbbV4DODzs8pIpHmthRZ4DdD4fcuCjWWmIUvxg=;
	b=S+LqEYHcvUKeK0J0AKr5UHCDIJvpIwt7A17zJs/tr6GBkMDBSZPYo3GUEeL8DL6pPDTXgy
	fY+QL4bBadpFG5d6gAFWwwZ8hLyMh6mGUjY93JERW1pOk7AZ50RABTQy1CXfWWLP6Ft56C
	mOgY37anRuBvCt/WrqGe2tGAIUjAMi0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-FMTaN4zXOmy1_ryCwkOMEQ-1; Wed, 21 Feb 2024 14:06:11 -0500
X-MC-Unique: FMTaN4zXOmy1_ryCwkOMEQ-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-41225f78258so30732965e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 11:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708542370; x=1709147170;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1+0GfmbbV4DODzs8pIpHmthRZ4DdD4fcuCjWWmIUvxg=;
        b=Fznh00pT1Bt+s0TDxtZHnQyJ/xpostEgYIgXjzHf/3CGKK3YGf7x2YdGENIUS1qJ1F
         xsH/vOaenX0/O7RVJHLfkjX2aUXXQFMKlhj3/S7cpzaQ+RIy350SYf5MQ2hweyhkDpON
         kdzXvksIABCMC+J4D18KNWPRB+tjUEkwl+IMksUfFKEbVGDsrfn7dgp51cjPr7+BQ9MX
         3wAU0at7mS6gAVRlqAFqNNL0m5Wlw83vte+YYH1lvfsH+EIe8G+m57s1K3V0jL1Z/TrE
         0Izmg11Qwm1bkTX1gsWSHB+XEwgdnCs5lWKzV4vbQ4ZRvL9zq1FQw2vKZ9feAB4bj91n
         jPww==
X-Forwarded-Encrypted: i=1; AJvYcCWoEWYtBApuN/X6/VhV0FNKOHHHHUm4icDjscS8+qJFMXYvGqfmAVE89EddAoqYoVH6cUHslQafCyXx7ietXqc3+kJxahrHJLigCKO8
X-Gm-Message-State: AOJu0YzX+fZJoT5T2z1nQUBVlf2a61JivhSWlBCepqoo6RUqpJQfgVBu
	jAT57lfeByFkxiEv98p//h2qVEUFwyouC9z3JX+l36Hc9LA8MUj8fLlc4sTMq4pQeHMqlHAreiw
	eeScC8fKgmc28JSS4+S7Xb5JNaurEoOySiqxhwU80jahLi58fEdcs40M6V08jAw==
X-Received: by 2002:adf:fd4f:0:b0:33d:1ad9:a20c with SMTP id h15-20020adffd4f000000b0033d1ad9a20cmr9442757wrs.28.1708542370260;
        Wed, 21 Feb 2024 11:06:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQmcpgowPakeWncE3IieRygGUzL5vkebbFf8TXwJDnljKUdqE0lTBWMTsTBxgmz+NxqoFNNg==
X-Received: by 2002:adf:fd4f:0:b0:33d:1ad9:a20c with SMTP id h15-20020adffd4f000000b0033d1ad9a20cmr9442743wrs.28.1708542369872;
        Wed, 21 Feb 2024 11:06:09 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id u11-20020a056000038b00b0033d7dd27d97sm2816317wrf.45.2024.02.21.11.06.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 11:06:09 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Arnd Bergmann
 <arnd@arndb.de>, linux-kernel@vger.kernel.org
Cc: Maxime Ripard <mripard@redhat.com>, Erico Nunes <nunes.erico@gmail.com>,
 Enric Balletbo i Serra <eballetbo@redhat.com>, Brian Masney
 <bmasney@redhat.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
In-Reply-To: <205248ce-caeb-4090-998e-379f79639bec@linaro.org>
References: <20240221125928.3711050-1-javierm@redhat.com>
 <9f419e86-6e14-42a1-84e1-31cab62d8ea2@app.fastmail.com>
 <205248ce-caeb-4090-998e-379f79639bec@linaro.org>
Date: Wed, 21 Feb 2024 20:06:08 +0100
Message-ID: <877cixiqn3.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 21/02/2024 16:31, Arnd Bergmann wrote:
>> On Wed, Feb 21, 2024, at 13:59, Javier Martinez Canillas wrote:
>>> These options are needed by some Linux distributions (e.g: Fedora), so
>>> let's enable them to make it easier for developers using such distros.
>>>
>>> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
>>> ---
>> 
>> Acked-by: Arnd Bergmann <arnd@arndb.de>
>> 
>>> @@ -1595,6 +1599,7 @@ CONFIG_HTE_TEGRA194_TEST=m
>>>  CONFIG_EXT2_FS=y
>>>  CONFIG_EXT3_FS=y
>>>  CONFIG_EXT4_FS_POSIX_ACL=y
>>> +CONFIG_XFS_FS=m
>>>  CONFIG_BTRFS_FS=m
>>>  CONFIG_BTRFS_FS_POSIX_ACL=y
>> 
>> Unfortunately this will increase build time noticeably, but
>> I agree it is the right thing to do.
>> 
>> Can you send it (with any other acks) to soc@kernel.org so
>> I can merge it from there?
>
> Due to XFS, please include:
>
> Nacked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>

Don't worry, I won't to re-send anything if you disagree with the change.

> so this will not be precedence used for further patches like this
> (Maxime already used such argument, so I want to be sure it will not be
> used against me in the future)
>

I used the same argument and is a fair one in my opinion. Removing other
filesystems should send the correct message, if that is the agreegment.

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


