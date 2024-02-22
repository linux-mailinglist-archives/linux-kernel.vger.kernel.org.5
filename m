Return-Path: <linux-kernel+bounces-76190-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E28E85F404
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 10:10:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 05B7C1F2533E
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Feb 2024 09:10:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89F45374F0;
	Thu, 22 Feb 2024 09:10:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dMXnu6sl"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 261F336AE9
	for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 09:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708593001; cv=none; b=Pm7ko4Nc5NsLVMq1R8LuEOLJFv+lGNFCRk3uHOhHdbDVRe+YSjmW5ThdzlFbCdCNR55ZyyDdpSUjaYeHb3Z/69ZJRxWA3cjyWFg7Pl6/Bqrm/ErCaDsWhZdTgtyUfdnp/f5azIp24PMYAeS2SdnpETcsyehVPdbTep20WVJ2Ouw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708593001; c=relaxed/simple;
	bh=S9f68HyI+Zr46UH5DB8yRbHjWXcwpz7SlL2wIFedeI4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=g+5YuPO3puQWpZZrejO9Ga7kA7JABmUvVApPL3jECTnww1+ipTuWgisxt41vhHUyNhw+ytihdZXrUokufQBZCNMbV2Os+kNSA8wC7VgozZgaOqStBscuXypBQPLz1GoopW4dvMDo8MtuYTDGEtRIol1rQjcPOdQnxGzlSG/kGXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dMXnu6sl; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708592999;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5z2LjmcVYTTtMHfSdE+4c74yPQ1zKXSnEQ+04Bz2RkY=;
	b=dMXnu6slRuOdcDqNnQDdWSXFsB64fbl4rRTPjo+n+znh24mwjAAM15hVfPXau3Z+tS9Lvj
	foUZVgbwHQ83vdYn07Vhhyii+fIs1RnJshX7mouRa5Z9cAfBZ60gppkcPsTB6Op0GQZ1ku
	TFegnjFkKceQuoSq7ZC1IjZKOEZ4fT4=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-O6bkTPXSOO2yFX2frwmNZQ-1; Thu, 22 Feb 2024 04:09:57 -0500
X-MC-Unique: O6bkTPXSOO2yFX2frwmNZQ-1
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-512d6483799so1139037e87.1
        for <linux-kernel@vger.kernel.org>; Thu, 22 Feb 2024 01:09:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708592996; x=1709197796;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5z2LjmcVYTTtMHfSdE+4c74yPQ1zKXSnEQ+04Bz2RkY=;
        b=WPOi99IFYKUIA7xwTrHZgWtggv1a6iKaLmlXJ6KLezEImpJ3C1GLcu14fI52jUlZ6P
         yMtv8d4OSXjzyOMmtPriTDzF2kL4AJdljqN1QoLi6dWxcnlQaohTSmvoVmY0tvTP+0VY
         Fc55kdQ/xWUyYz2ZuNS4dEZ8Ez0APhtzln1+hhVbExszoeXMN0gylMeFIZrihFfdB1No
         GUWEsv59IEfuKQcFmHqSrBDjSTTm8T5DNjnLyHLQACkiqTgM8OsrwedK5DPoUMrg1ViO
         Ui27me4HWMKFGwIJlKpjDnKICGR2qihAlqMKsoMg07T/Z0+v2SwuxbOSwj/qdJ0h7e9m
         RbuQ==
X-Gm-Message-State: AOJu0YxYeOkOJvO3yzYKiTQ+kdECaXjjGgXslP0h0Wr522O+MFsyUcPz
	WGZBHMlcw1rrpsjtItm23WNxXM9tgWS08fpCkePyqV2Ufr/nIyVxErty2YyGkTn/2WhA/1wEIDt
	BdigAXzHjMfYkI/m9VTq/FSql4jkhRFPuR8lDgGuCVh/R3bMxd8cfrbr06uxEXA==
X-Received: by 2002:a05:6512:34cc:b0:512:d643:8ce0 with SMTP id w12-20020a05651234cc00b00512d6438ce0mr2265903lfr.3.1708592996080;
        Thu, 22 Feb 2024 01:09:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUfQ8/pcELa6/T5KDQWDZsKcrbNfqYNrm0L3u4xqUXs43U22KoHb268lI/Y9EyTKszcVyvVA==
X-Received: by 2002:a05:6512:34cc:b0:512:d643:8ce0 with SMTP id w12-20020a05651234cc00b00512d6438ce0mr2265896lfr.3.1708592995763;
        Thu, 22 Feb 2024 01:09:55 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c451200b0040fd1629443sm21435438wmo.18.2024.02.22.01.09.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 01:09:55 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>, Maxime Ripard
 <mripard@redhat.com>
Cc: linux-kernel@vger.kernel.org, Enric Balletbo i Serra
 <eballetbo@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, Brian Masney
 <bmasney@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
 <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
In-Reply-To: <bd071521-7f7b-41e8-8786-ad2eeb58b03e@linaro.org>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <9083c414-62f2-4bff-93ee-13f8ff60eb34@linaro.org>
 <874je1ipb4.fsf@minerva.mail-host-address-is-not-set>
 <bd071521-7f7b-41e8-8786-ad2eeb58b03e@linaro.org>
Date: Thu, 22 Feb 2024 10:09:54 +0100
Message-ID: <87r0h47tlp.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 21/02/2024 20:34, Javier Martinez Canillas wrote:

[...]

>>>
>>> Any explanation what ZRAM is necessary for Fedora to boot.
>>>
>> 
>> I mentioned already in another email, Fedora is enabling the systemd
>> zram-generator and not having a /dev/zram0 slows down the boot to the
>> point of being unusable. One could disable that service but then is yet
>
> That one sentence would be enough for me.
>

I'll add that then to the commit message when proposing a config fragment.

[...]

>> 
>> So that means that for aarch64, some filesystems have more precedence over
>> others? It's OK to have ext4 or btrfs but no xfs? Honestly it seems quite
>> arbitrary and subjective for me.
>
> Yes, subjective, but to be honest: I would drop Btrfs. I was thinking

Fair. If the agreegment is to minimize defconfig (which AFAIU is your
point), then I'm on board with it. We can start splitting in separate
fragments, people can then mix and match for their specific use cases.

> about it, but since Arnd agrees on XFS I won't fight that battle.
>

Yeah, it was a strange hill for me to die on and is true that fragments
seems to be the best compromise, as Maxime said before in this thread.

By the way, I want to apologize for my harsh/rude comments yesterday. I
wasn't in the best mood and I got too emotional...

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


