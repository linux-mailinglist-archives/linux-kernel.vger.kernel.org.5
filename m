Return-Path: <linux-kernel+bounces-74947-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F160685E05A
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 15:55:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B03F1F25315
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 14:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615CA7FBBC;
	Wed, 21 Feb 2024 14:55:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I3KNEwLF"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E6E51FDB
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 14:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708527312; cv=none; b=iDM4aLYiIQa5NT+pqxUg3b8MAgdTd9vpFLknUZPtd7KQEYl+gMvonRTwBifl7rBrd0DWdnIAXZICjQOqZQ7p/KsPJmYksfUbQd8+toO4/hF+Ov/7UnRXCepowIjR2deTLFvHi0nE82TE4pJ2X/l+8kaaJlca6abSkDeNA5fW5eQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708527312; c=relaxed/simple;
	bh=FwmvhBN+OFHNRJGqCtuBa9zQ5OmMKVp5IfgUrr6yEdo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pR/hsH3purXAzclxtcSEY9P367LicFPoXquDlN44tsGnFYskv3teMvHi61wBBTs4KJ4+kvEJ3yluWRwqUvYYXQ6iI38FUda4k+I3v5Tn4120mlSqWxlheBq/kFKHe5jy9VtTp/6hcMsQ1saZriqlFO8IM58ZFaAbIh/SoruwAAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=I3KNEwLF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708527308;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nTOuhxSpIJojNYD3JH02I0hRbkAGahRwskglZbkisY0=;
	b=I3KNEwLFm7i/3LB4v6oNe3nDtItmKAFBRE2jpNRSC3YbPY2l4RgyhlWJLGyEoo4xABdOOX
	n9esy3pJaZ/wmIK8f5dsnM5WDUQqp6TbsQygQdIt3rfl+nlZIANUwaA5YZdbuCCBNL+pJX
	wd8TPhkWAOcQ3pOOEfJUVq81Uprs30M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-445-XhUVWENyNeW-3qLvpUWKOw-1; Wed, 21 Feb 2024 09:55:07 -0500
X-MC-Unique: XhUVWENyNeW-3qLvpUWKOw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-410e83001cbso36023065e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 06:55:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708527306; x=1709132106;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nTOuhxSpIJojNYD3JH02I0hRbkAGahRwskglZbkisY0=;
        b=PN+hMx+EMm78+EZ7pn1YA71DVeVJSnC8btliUt7uvx6mS3JSTtmJ1UYJxIHdbeVjmu
         ATd9tPRToQK6y/MUtvn7ElMhUYWFqwSXss+ArKNdmf2A1RI2aa5kwvQ1ZZWrxw3770i6
         q1bwN8vKpxTiBAy1ATG5HcuTgOLo6cH3oONvRawI/ainYYzJHKFAZ6orZUr/9WqU7t0I
         7UlrcmIvpAHcVSSbXHBIOXj/R3UBTnOiX49mg315SUiT3PtGq7BldXZsVX+eedrJ9MUe
         JTWvpZV+ldFf2cqTm7C2u0OMhJCQNb2VGki8m8KQSykC2mpREKPLpNBgLkwT5fHdMkBU
         kbtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVvEnCv1ZSqfX5g7ejEVgJlmGYdgbUZ8fF/9364NZbGfPvUAa8ACkJibhX5laPmk56/fgKIr65kSUtAaSDv4gVSDsex0j9QexVs17sF
X-Gm-Message-State: AOJu0YytdVMAjVP+I+AR7mwINcPynMT/NumgZ8zfNLYiRX0jxn3uKeIE
	QJMjxhgb4gmDUbHPgRuY9guP9amrKvBtSyXpciEmQQKR7N21L7KaQ/hQAjKEuluh16h97lC1EpO
	nfhPVRLICuwRcIJ51InkxW1rbLXVUhW5dwLxkN05rp64HsFLwGw1l7H7RjJ4otQ==
X-Received: by 2002:a05:600c:4f41:b0:412:7585:313a with SMTP id m1-20020a05600c4f4100b004127585313amr1607472wmq.25.1708527306039;
        Wed, 21 Feb 2024 06:55:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHwWllrJI3rhUE60OMvarIYpuTx3QfeNjJIGgv47dBj78w9h3HWwQiK7cG5GEBbqeMO6xEYPQ==
X-Received: by 2002:a05:600c:4f41:b0:412:7585:313a with SMTP id m1-20020a05600c4f4100b004127585313amr1607456wmq.25.1708527305701;
        Wed, 21 Feb 2024 06:55:05 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id o33-20020a05600c512100b00410add3af79sm2889094wms.23.2024.02.21.06.55.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 06:55:05 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org
Cc: Enric Balletbo i Serra <eballetbo@redhat.com>, Maxime Ripard
 <mripard@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, Brian Masney
 <bmasney@redhat.com>, Arnd Bergmann <arnd@arndb.de>, Bjorn Andersson
 <quic_bjorande@quicinc.com>, Catalin Marinas <catalin.marinas@arm.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, Marek Szyprowski <m.szyprowski@samsung.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
In-Reply-To: <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
Date: Wed, 21 Feb 2024 15:55:04 +0100
Message-ID: <87a5ntj29j.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> writes:

> On 21/02/2024 15:13, Javier Martinez Canillas wrote:
>> These options are needed by some Linux distributions (e.g: Fedora), so
>
> How ZRAM is needed? Why Fedora cannot boot without it? Debian, which I
> use on my arm64 boards, does not have any problem.
>

I haven't used Debian in ages so I don't know why is not a problem there.

But Fedora is using zram by default and if is not enabled in the kernel,
the boot is delayed considerably due the systemd zram-generator.

> I kind of repeat comments from similar patch earlier:
> https://lore.kernel.org/all/fe1e74a2-e933-7cd9-f740-86d871076191@linaro.org/
>

Ah! I forgot that posted the same change for exynos_defconfig some time
ago and I see that you nacked. Now I understand why all my Exynos boards
are in a drawer.

> About XFS: I don't think it is needed to boot anything.
>

How are you supposed to mount a XFS rootfs without at least have support
for it as a module?

> This is a defconfig, not a distro config. Please don't make it distro.
>

It seems that's a Debian distro config though, since you brought Debian as
an example.

> I will gladly support things needed by systemd or equivalent, but not
> unusual filesystems needed by distro.
>

Fair. But then you should probably remove all the other filesystems that are
already in the defconfig then?

$ grep "_FS=" arch/arm64/configs/defconfig | wc -l
15

Or it is OK to have support for btrfs, overlayfs, even plan9 fs but XFS is
where you draw the line??

> Best regards,
> Krzysztof
>

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


