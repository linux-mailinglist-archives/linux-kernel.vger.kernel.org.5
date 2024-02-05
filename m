Return-Path: <linux-kernel+bounces-53057-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B823A84A028
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 18:02:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BA8D1F228CF
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 17:02:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60D243FE5B;
	Mon,  5 Feb 2024 17:02:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="U1n8Sn5W"
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A4E93FB34
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 17:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707152547; cv=none; b=BdaPeh7Vy5ZO77sX1CAomp+Lt08z6/TfIFG3/PPUYAP9hcPgOFy4/4dDTIcwaY4r5TydReDQ8IFwjlW2WdcfCPNbQMt26XJiduOsS+7NfpRQma5Cc78RAtpVsCrxNjBpGcwCWSmBlCbGtZ87FT2oLxMlDeFiPuxwFx5XTSKhDzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707152547; c=relaxed/simple;
	bh=f0zMY5eWde1DrhOGVKSV6wLNgNyHnBPeDoFVdLhpxxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HF8F6KNjWG3Ua70mCFOKBipF4dLHs+MgLAuMSFwCqAnAY+jePQD2Jypdf67Wy6X9fnxQfUMULMGZ9f6rxpxFAQXrWSyqox6RFwWqsfIlflRKe8az10oBonaG0lAP1d3R0sQjZs383+9/vIx8WqiOFWXFED9HZoS8RTLeJyRjNQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=U1n8Sn5W; arc=none smtp.client-ip=209.85.160.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f180.google.com with SMTP id d75a77b69052e-42a9f4935a6so43693191cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:02:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707152544; x=1707757344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nZ5yVc2GM1gajAlCrM1xr5CA/oF06LanPERbQMooNvo=;
        b=U1n8Sn5WOBMuiDn/IRypCgHEaoFUaJLjdJsfKPUmikfqlHEerEv4yaDvyyAkNAeU4Q
         tWWaxFmKoRsoykgs11B2QNptc/+acoaHXUiE9y9APokx9H6l9GOsS5y6RKFX7yzMyST/
         QqvVml/suWTuMWucWtEEvzh+9Zj4fd8SjfiTc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707152544; x=1707757344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nZ5yVc2GM1gajAlCrM1xr5CA/oF06LanPERbQMooNvo=;
        b=T8XXUIRkT1q9nRgsIKroMXSG0hbdMrYwVkFWRVJ6rAkN/tIPBn47cczbRmkbP5fCYt
         3YfHHTnB+KYKGlu2ANvM0W3OI8Ic1NyCDO+APAVr2cppLa3hEzwshvcgq7IaDPFdDEsu
         +RyXBreR767e1E5Ghgq++jSFSKl0Q95D27cX93QX5a6eP3TkF76OlHctg1HzJMcf61kh
         8mCjS/NZPzKImy2oH2dUKWs9dkjwMBxvmnfTdpolxfrNhrZJqS622VGhFz8rOISWRTAG
         0S1Q5dnsM5Vyenb3jMj43RHEq2DpwCriiuMV9O8mIiZ2Z+e/YhZNS1lkeqwMSq0rnI/C
         SR1A==
X-Gm-Message-State: AOJu0YwKGvE9ZTyPwLqirYtQZDW+ox8v/LgyM0kFcgqCCOrmi3D5WAjW
	IBeaYol60UlJ6/Meqs5dPjr/B8NEDG8ehphOVyP6hUJtf9dwA4DcGZVg0WoC1zvEPswom+EgYTz
	sFw==
X-Google-Smtp-Source: AGHT+IFekeqshuWNPS80Dgf4YgmoVRUzDAZz46iQW9FfvvmfdLRJGJdPqg5O8T056pgpwyP+7EZmBQ==
X-Received: by 2002:ac8:4587:0:b0:42c:c80:1576 with SMTP id l7-20020ac84587000000b0042c0c801576mr438452qtn.20.1707152544570;
        Mon, 05 Feb 2024 09:02:24 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWEgxaUZ5znw+gPVgI8Md86dexI0uhuPBbfOPQax75nsy6hpWpwtO2nluHye9z/cO/8jrOfNCwO5YVq4T1Ow0okfT1u8DTwptCcaPjP
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com. [209.85.160.170])
        by smtp.gmail.com with ESMTPSA id ka23-20020a05622a441700b0042c21d31b86sm109120qtb.87.2024.02.05.09.02.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 09:02:23 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42a99dc9085so6001cf.0
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 09:02:23 -0800 (PST)
X-Received: by 2002:ac8:42cf:0:b0:42b:f0eb:b3c with SMTP id
 g15-20020ac842cf000000b0042bf0eb0b3cmr2344qtm.28.1707152543367; Mon, 05 Feb
 2024 09:02:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
In-Reply-To: <20240203-arm64-sve-ptrace-regset-size-v1-1-2c3ba1386b9e@kernel.org>
From: Doug Anderson <dianders@chromium.org>
Date: Mon, 5 Feb 2024 09:02:08 -0800
X-Gmail-Original-Message-ID: <CAD=FV=XupbtO3_+P9=XO26vH_5nALSSLZZHZywPSR_hQsWxM0Q@mail.gmail.com>
Message-ID: <CAD=FV=XupbtO3_+P9=XO26vH_5nALSSLZZHZywPSR_hQsWxM0Q@mail.gmail.com>
Subject: Re: [PATCH] arm64/sve: Lower the maximum allocation for the SVE
 ptrace regset
To: Mark Brown <broonie@kernel.org>
Cc: Will Deacon <will@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	Dave Martin <Dave.Martin@arm.com>, Oleg Nesterov <oleg@redhat.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Sat, Feb 3, 2024 at 4:18=E2=80=AFAM Mark Brown <broonie@kernel.org> wrot=
e:
>
> Doug Anderson observed that ChromeOS crashes are being reported which
> include failing allocations of order 7 during core dumps due to ptrace
> allocating storage for regsets:
>
>   chrome: page allocation failure: order:7,
>           mode:0x40dc0(GFP_KERNEL|__GFP_COMP|__GFP_ZERO),
>           nodemask=3D(null),cpuset=3Durgent,mems_allowed=3D0
>    ...
>   regset_get_alloc+0x1c/0x28
>   elf_core_dump+0x3d8/0xd8c
>   do_coredump+0xeb8/0x1378
>
> with further investigation showing that this is:
>
>    [   66.957385] DOUG: Allocating 279584 bytes
>
> which is the maximum size of the SVE regset. As Doug observes it is not
> entirely surprising that such a large allocation of contiguous memory mig=
ht
> fail on a long running system.
>
> The SVE regset is currently sized to hold SVE registers with a VQ of
> SVE_VQ_MAX which is 512, substantially more than the architectural maximu=
m
> of 16 which we might see even in a system emulating the limits of the
> architecture. Since we don't expose the size we tell the regset core
> externally let's define ARCH_SVE_VQ_MAX with the actual architectural
> maximum and use that for the regset, we'll still overallocate most of the
> time but much less so which will be helpful even if the core is fixed to
> not require contiguous allocations.
>
> We could also teach the ptrace core about runtime discoverable regset siz=
es
> but that would be a more invasive change and this is being observed in
> practical systems.
>
> Reported-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Mark Brown <broonie@kernel.org>

Confirmed that when I send a "quit" signal to Chrome now that the
allocation I see for "core_note_type" NT_ARM_SVE goes down from
279,584 bytes (n=3D17474) to just 8,768 bytes (n=3D548). I'm not
intimately familiar with this code so I'll skip the Reviewed-by unless
someone thinks it would be valuable for me to analyze more. I think
there are already plenty of people who know this well, so for now,
just:

Tested-by: Douglas Anderson <dianders@chromium.org>

