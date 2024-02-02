Return-Path: <linux-kernel+bounces-50552-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E50F3847AAB
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 21:47:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22E1E1C2658B
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 20:47:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E070C5FDBE;
	Fri,  2 Feb 2024 20:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ALYbNTNc"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 910CED2F5
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 20:47:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706906826; cv=none; b=Mnr3+zqTB1X6jUaH2QKzG/H14gLa8fdj0R/bERhkJqB5BJA7FhTnbwZv+EBEbYKHkOyQ1T5FbKE0T0nDTwyJDlzsZQdsjwgiVB4UCALB8M21BBkUOmkCi8jd7y4opGo/DR/S3hlxcRK1OYjuGHyrCxwmCM4BpwAAJ6IGCKJm0GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706906826; c=relaxed/simple;
	bh=C1NOo2D6BqxPz3sCVOg601jHnW2UzAwYZ75CPDqMBRk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rhpAnSRAxm3utMQZKH9O2Ttp3yeIxNUwD2/TziRElvxk12ZXD8CtpT+c57hmvP2t8B2zMakX1Mdu4pA8Xgh9wG873VoqFJdi1fan4rNJ0v66fGw12UHIe/1a57oiEc2v4ZCDS9/tE42O5PEyK4XHFUQ9CE+h8g231s3YJ0jFR/U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ALYbNTNc; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a2a17f3217aso353951966b.2
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:47:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1706906822; x=1707511622; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1NOo2D6BqxPz3sCVOg601jHnW2UzAwYZ75CPDqMBRk=;
        b=ALYbNTNcgeXq1V75F2d7IsKXGle5lvZxRqshEHO0ZhXU8L5SQGKCBR3qSXVzvJFoOO
         8gr9jLNVBmQaZtdX2C8zufGrt0klEKw8+5Mf51xIPrRRDGJAmQTFmGBeMdqJG3l+UhRH
         cTpfQpxQMSWM2goNJz/O2lr75yhDxB6f/RhWM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706906822; x=1707511622;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=C1NOo2D6BqxPz3sCVOg601jHnW2UzAwYZ75CPDqMBRk=;
        b=BAa+fCMR+OvLTXhKu7vX8rjxhYIOTy0189jdMtqS2Bi2k0P+KVRSjMmAcHRa26yKlF
         2JMdm5GiRNuxTQZ6qi+qxMx5fbMDB2HqX/02h/Yqs3Bvxr3qf5gIVp4FXiG0geeAHl7/
         vsVuzByMb+elk/fSwAFkyPcuDUVMgyMpM0P8cPtfmRrrnQdUKVWGHGkNxxVLxmLUbyKr
         2bl2q1632i1x1nwncV8lTjaaGzsDSM4Cx/ih/nFvwxwaV2mzS5EzLj+WcJI4S0iijDsd
         uKm8yie/eE8LDKf/nV915cFdyGb1WDFFnSvUzgUjMN1Hcj809kTJRdW43ex5WrOsUkb+
         pm3A==
X-Gm-Message-State: AOJu0YyZuabkyz2g62UMBHsjuHK6986Qw38/kys4ygdQ5buLNKBDCMPE
	cu3/KyNyj99Kza5rIX5f0ObkyIxWVKfVQzTI8QKcthFhRaJs3LxWzBOracly4lZKDZBTtLiHaWe
	ATijf
X-Google-Smtp-Source: AGHT+IG4Eq8uI7bKODc9L1kdjfq5wCCKAV9jRTlRXbxbAQ7jg6fjGgLY4wy23MH4bN9QYU1F67oVlQ==
X-Received: by 2002:a17:906:c29a:b0:a35:fbc4:4c20 with SMTP id r26-20020a170906c29a00b00a35fbc44c20mr5751846ejz.6.1706906822413;
        Fri, 02 Feb 2024 12:47:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCX20K+7z+aJrl3CeZMTgoKTKnoeshgPKK/GA/J2BnC7CtMrNFrpZJkXmJcpJ6sSNxFzXJAkwIYAkYQXTeGiLMOJX2xUBTnSTq2OBHCk
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id vk7-20020a170907cbc700b00a3724ffd4d0sm554501ejc.194.2024.02.02.12.47.02
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Feb 2024 12:47:02 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40f0218476aso795e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 12:47:02 -0800 (PST)
X-Received: by 2002:a05:600c:a3a4:b0:40f:c2f1:9d4c with SMTP id
 hn36-20020a05600ca3a400b0040fc2f19d4cmr7485wmb.4.1706906341770; Fri, 02 Feb
 2024 12:39:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202012249.GU2087318@ZenIV> <CAD=FV=X5dpMyCGg4Xn+ApRwmiLB5zB0LTMCoSfW_X6eAsfQy8w@mail.gmail.com>
 <20240202030438.GV2087318@ZenIV> <CAD=FV=Wbq7R9AirvxnW1aWoEnp2fWQrwBsxsDB46xbfTLHCZ4w@mail.gmail.com>
 <20240202034925.GW2087318@ZenIV> <20240202040503.GX2087318@ZenIV>
 <CAD=FV=X93KNMF4NwQY8uh-L=1J8PrDFQYu-cqSd+KnY5+Pq+_w@mail.gmail.com>
 <20240202164947.GC2087318@ZenIV> <20240202165524.GD2087318@ZenIV>
 <Zb0vem7KC28gmT5U@e133380.arm.com> <d7154f86-d185-495d-aa84-63d4561f1e47@sirena.org.uk>
In-Reply-To: <d7154f86-d185-495d-aa84-63d4561f1e47@sirena.org.uk>
From: Doug Anderson <dianders@chromium.org>
Date: Fri, 2 Feb 2024 12:38:38 -0800
X-Gmail-Original-Message-ID: <CAD=FV=ViEjvEevLq+1ZEVQB9qh4ofJHvLYfNu0XTQSjNRpZzAA@mail.gmail.com>
Message-ID: <CAD=FV=ViEjvEevLq+1ZEVQB9qh4ofJHvLYfNu0XTQSjNRpZzAA@mail.gmail.com>
Subject: Re: [PATCH] regset: use vmalloc() for regset_get_alloc()
To: Mark Brown <broonie@kernel.org>
Cc: Dave Martin <Dave.Martin@arm.com>, Al Viro <viro@zeniv.linux.org.uk>, 
	Christian Brauner <brauner@kernel.org>, Eric Biederman <ebiederm@xmission.com>, Jan Kara <jack@suse.cz>, 
	Kees Cook <keescook@chromium.org>, linux-fsdevel@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Oleg Nesterov <oleg@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Fri, Feb 2, 2024 at 11:43=E2=80=AFAM Mark Brown <broonie@kernel.org> wro=
te:
>
> On Fri, Feb 02, 2024 at 06:07:54PM +0000, Dave Martin wrote:
>
> > So, if the only reason for trying to migrate to vmalloc() is to cope
> > with an insanely sized regset on arm64, I think somehow or other we can
> > avoid that.
>
> With SME we do routinely see the full glory of the 64K regset for ZA in
> emulated systems so I think we have to treat it as an issue.

Ah, got it. 64K is much less likely to be as big of a problem (only an
order 4 allocation), but you're right that it's still a size where
kvmalloc() would be an improvement. With that in mind I'll plan to
send out a v2 of my patch where I use kvmalloc() instead of vmalloc()
and update the commit description a bit, including a link to this
thread. Then I will assume that others on this thread will move
forward with actually making the allocations smaller.

Please yell if the above sounds wrong. :-)

-Doug

