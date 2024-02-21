Return-Path: <linux-kernel+bounces-75577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C01485EB72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 22:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8D46283F2D
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 21:56:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 279C4127B63;
	Wed, 21 Feb 2024 21:56:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N1G8EK0x"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B730CEEB3
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 21:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708552599; cv=none; b=YaWjjPhQY4bYfF67enEY1RNMB/hM+P68U82L7plRNBz9e7UGU+BQoqox+CL7wgBy/UgQ2KDVbWJRzninM+OqrjnJf6M6qLFh1QFWFlCQ6q8TKYMPF4sGY2zMFv7Sz/d/+soSDYGJUA92U9uWOEu5zWTsQjG7ck79mQLm84x7RKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708552599; c=relaxed/simple;
	bh=OyRow3DdRAYVCPA+6fTJxNAEs8n5BLDE+pMgkX/vORY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EoqO9bybSkjWnbbiNuLw8xXSovvHGNWYSakBJbJz+KN5pyeRLjRwX5KJ2hHP1kC8mqgpmq8I7uwVzgihFlEKzrotR4v2/gsY81AvGOBrKH9TvTeM2i83SxESs6+h7GSoxjyR8p69rc1umFjS0VmHjwT5gmxotgeAdTY1Aw/JSEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N1G8EK0x; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708552596;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wz69wT3KOjKDMqorWTqZ4COQkehom3tYVQ/EfROhM1o=;
	b=N1G8EK0xNDgf6+a2BcXmHW91Uu8NiE62gpTS+z/ZDFm4SVHRsvLGDzGDx0fbK3buhzCQZ6
	YJ96dyBG1StnbkkXRPoQJtdyFSvD6MkUsQwR+8nKuYg4BHnv9YtKjPc5RDhjbzaFNfbhIw
	e5O4i+J3uwcQ2Bo7sqLWVpqCud9h5z0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-613-XPBq_9WEPIeK1PzFJHNcJw-1; Wed, 21 Feb 2024 16:56:33 -0500
X-MC-Unique: XPBq_9WEPIeK1PzFJHNcJw-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-33d256ca4c8so2499870f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 13:56:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708552592; x=1709157392;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wz69wT3KOjKDMqorWTqZ4COQkehom3tYVQ/EfROhM1o=;
        b=ixqFsmONAIWrneXFMldd4K+F1pDHqjAfNvow6j6sWQaH/yiVM7f8rr+tqBHKD8J8Gp
         KtsoS6ohBa3TLh4G1BB5IvHM50CK0F3ilfUuzRyukp20NzdIlSxgjt/v9N8SRobuWZql
         yCIcJ0bCFyR02YQSXVg0Ad0ui/8APl96PwernA5QlycsBo9xk31xnABIGIWLvUb+aogB
         d2LDXuqKbys7by/FwZIHD/0caYlH9RMmd/X2ilboJoMTTiT6isi/+pmScRQYvXYm0ebk
         qERwc5BgcZ+50jWQZ5aWZNIqsVkEVU0AdnvNc9YR9b7ysO1fAwbZbCApUW50hQUpI1C9
         hdcg==
X-Forwarded-Encrypted: i=1; AJvYcCVTYdS4Wb5iAtZfBW7xodNYUxDuXFcXkanjI/xH0ZZEbEnIwMOJCr1M8VXMi1+AjQOBZ3W9B3h8zAn7e+1Y1jfgdOUakhbiVHzEJy+v
X-Gm-Message-State: AOJu0Yyhly4eoUTurfT+rEjIKHe8TRAEswWN+FxnbrnRmpHCa8AMfgl1
	hnQDXkMZwSLTnSQBRayjyld50PQKSyUsgSx4ya60UkXafCZeDqobFrvkyCrkSvtBWWkgsxEqBt3
	Rc+YGSNOMrR6eK3/zQK9bPhJ3PVuAlkMUQreMnih3uEQHsBlwvA+khB2t+VZlCA==
X-Received: by 2002:a05:6000:1104:b0:33d:3b09:e06f with SMTP id z4-20020a056000110400b0033d3b09e06fmr8943476wrw.54.1708552592102;
        Wed, 21 Feb 2024 13:56:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZ7rF8Wet2GZBYN3pL68kY2DE/ZJSFf5X2VoXNwVPOXFvyfKUeS8B7Ly5dProvwU8w7ze0tw==
X-Received: by 2002:a05:6000:1104:b0:33d:3b09:e06f with SMTP id z4-20020a056000110400b0033d3b09e06fmr8943457wrw.54.1708552591761;
        Wed, 21 Feb 2024 13:56:31 -0800 (PST)
Received: from localhost (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id bk26-20020a0560001d9a00b0033d568f8310sm10242215wrb.89.2024.02.21.13.56.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Feb 2024 13:56:31 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Maxime Ripard <mripard@redhat.com>, Arnd Bergmann <arnd@arndb.de>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 linux-kernel@vger.kernel.org, Enric Balletbo i Serra
 <eballetbo@redhat.com>, Erico Nunes <nunes.erico@gmail.com>, Brian Masney
 <bmasney@redhat.com>, Bjorn Andersson <quic_bjorande@quicinc.com>, Catalin
 Marinas <catalin.marinas@arm.com>, Geert Uytterhoeven
 <geert+renesas@glider.be>, Konrad Dybcio <konrad.dybcio@linaro.org>, Marek
 Szyprowski <m.szyprowski@samsung.com>, Neil Armstrong
 <neil.armstrong@linaro.org>, Will Deacon <will@kernel.org>,
 linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: defconfig: Enable zram, xfs and loading
 compressed FW support
In-Reply-To: <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
References: <20240221141350.3740488-1-javierm@redhat.com>
 <1f28256c-e436-4add-aa67-2cfb2248b220@linaro.org>
 <6scz7iti3tzzrd4ph3gnuc2pvkcbtuuicgfgujh3pa3c34kdkt@bhfa4xbxeu7t>
 <cb8bf006-57df-494e-80f3-947582ec71f1@linaro.org>
 <fy3wffb2jwv4veo3golfn5olri77clxywbuwuokese7sbobixd@mird5k66cl2w>
 <56625c21-1b34-479b-b5b2-4c4d8b7a11b3@app.fastmail.com>
 <724jnhrbs6r4q6whynr3aon5w7mhfvetlgcnts4nukvtxbuium@mrjv6apjqk7r>
Date: Wed, 21 Feb 2024 22:56:30 +0100
Message-ID: <87v86h7a7l.fsf@minerva.mail-host-address-is-not-set>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Maxime Ripard <mripard@redhat.com> writes:

> On Wed, Feb 21, 2024 at 04:41:38PM +0100, Arnd Bergmann wrote:
>> On Wed, Feb 21, 2024, at 16:24, Maxime Ripard wrote:

[...]

>> > Being able to test an upstream kernel quickly when you have a bug in a
>> > downstream distro is super valuable for any distro developper. And on
>> > the long run, if we don't make the switch from a kernel distro to a
>> > mainline kernel relatively easy, we're the ones that will lose out.
>> > Because people just won't bother, or be frustrated and thus super
>> > reluctant to do that work.
>> 
>> We had previously discussed adding config fragments for common
>> distros the way we have kvm_guest.config, but if the Javier's
>> patch is all that is actually needed for Fedora, that seems better
>> to me than the added complexity of fragments.
>
> Oh, right. Fragments would be a great tool to reconcile the need for
> minimal boot time and supporting reasonable use-cases.
>
> I guess it's even more of a struggle with the single arm64 defconfig vs
> the minimal vs batteries included defconfig setup we had for arm.
>

I'm OK with using fragments instead and propose a fedora.config or
whatever name is decided for this.

As long as the list is kept in the mainline repo, instead of every
Fedora developer having to make local changes in their .config, it
works for me.

> Maxime

-- 
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat


