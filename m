Return-Path: <linux-kernel+bounces-51493-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2F73848BDE
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 08:42:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2B62C1C21534
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Feb 2024 07:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5890EBA2D;
	Sun,  4 Feb 2024 07:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="bfK1lW3V"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2ECE8F77
	for <linux-kernel@vger.kernel.org>; Sun,  4 Feb 2024 07:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707032523; cv=none; b=R0I+7pDC3zoMo1Tg+qcGHNT+1fW7CCFYKMxBVnLUeSfbpdhkW6Cp5/TspJO6SHj5kGRCEgt6dv4oXvkPYFzhA+8kFqEBaZ8cBEf743a/nEb9ByeStJjFWXGB3k/jV3XTT51hF+1XeVnTWXbw7yt5GcWdqWT/SK1UIeXKPKiDnbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707032523; c=relaxed/simple;
	bh=ivawquPkjq89vuGPt9zRK+PP8y8ZqNfCeHnU8NAATS4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mzrFCBowvIf2cOQ+T2+DRoKCjX0BKIIt/raouvBk8xE3thiTBhRHiSwbE13mLTy9Hmij1+q+eC/zvN9+EmjEFu/VRb+Fpaz2cw6xH3hOGB0nbeTm3ihZRGXjdzBm0bFyAcNcr7H1AMeIPmFJYaHLnULoPQRfMqbUYMrERqCZav8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=bfK1lW3V; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a363961b96aso435531166b.3
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 23:42:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1707032519; x=1707637319; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=fuvlxA+anJtkOMreE35KRYFx2Wh10b5WLrE1tllolU0=;
        b=bfK1lW3VHfDbBdeN+4LDQLRmB1iZQKOL2JeXNXGBObluO3uetnw6Z1j+caLBn8Y9Qg
         oNlGWftvS9uq4ZT/BF7+xS5q6I0JLvyMIyEzZxHVfoEatay8tCpcYpsV9QTTjzqNRJRC
         qQR+HI/D9jYXlLLssRKljeXbQBxC8/YXO2Esk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707032519; x=1707637319;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fuvlxA+anJtkOMreE35KRYFx2Wh10b5WLrE1tllolU0=;
        b=c66MmkecKbSh/JIfkamP3ICwprp4Gi4MuK5OaNrt/fy8d058X0FfTIbHEAkQtTedny
         UPqefIViJMaMOlls8ngwGoNjxkiPw0SMB9JobnRx4wziUdZjJoRkBIT66pPJ9lLv5GUf
         jLbO3s1aOcinfTGzbO9vgjaytW9FsBR5wBwoAzAvrUZmMSC2nw6TOkKBpPFYbiFbNIVq
         Wxa9LI1jkNclN6YmLBXOgNpwZRg1/UJsepqI7O7swVm4oqe4AT2ozrdegq/SeYaTWQxT
         oF1MQMhYJoeCIoeSQkpbrlL34KyGRpf8Rmf0xfvObT41vmpRR9A4T5Ro2hjkPAo8WvMX
         t8Yg==
X-Gm-Message-State: AOJu0YwX/4DjhR5CAiTCCdYZQtZ4oKgtEHlWyn9zQHgwlkdf9WOFYYWU
	2aLqdvixl3tgm6tR+3437DIu60dctcD6u8ViCJCJvF8vDe1lvbZ7IFyQpJhfsRt7k5VL/oXGAiE
	E+1fZZA==
X-Google-Smtp-Source: AGHT+IFtrMg6n+iHN/ZREVMD3+DftiGP+9IAiQfrN8OjJRctWATWtkimyG1i2miyrVVyNLwJpM/ZnQ==
X-Received: by 2002:a17:906:af1b:b0:a31:8dd6:6ae0 with SMTP id lx27-20020a170906af1b00b00a318dd66ae0mr8462540ejb.7.1707032519712;
        Sat, 03 Feb 2024 23:41:59 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW23R4rSy7ocMA6H2i9/uzdRyFdUozDCmpQwI7DOTc6xfM4DURiP+6zbHOe5J7+sSYp0P++2Kk+VIcpuJb/tI+NZDLZwaMNE2XQlNT/
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com. [209.85.208.42])
        by smtp.gmail.com with ESMTPSA id vb9-20020a170907d04900b00a36814670cbsm2845979ejc.62.2024.02.03.23.41.58
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 03 Feb 2024 23:41:58 -0800 (PST)
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-55a90a0a1a1so4275668a12.0
        for <linux-kernel@vger.kernel.org>; Sat, 03 Feb 2024 23:41:58 -0800 (PST)
X-Received: by 2002:a05:6402:1507:b0:55f:f73d:c63b with SMTP id
 f7-20020a056402150700b0055ff73dc63bmr2660980edw.20.1707032517833; Sat, 03 Feb
 2024 23:41:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202-exception_ip-v2-0-e6894d5ce705@flygoat.com>
 <CAHk-=wiaSjYApqmUYCdCyYfr_bRsfVKDkwU6r6FMmoZzrxHrKQ@mail.gmail.com> <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com>
In-Reply-To: <eeb92d70-44d6-47f4-a059-66546be5f62a@flygoat.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Sun, 4 Feb 2024 07:41:41 +0000
X-Gmail-Original-Message-ID: <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
Message-ID: <CAHk-=wiUb1oKMHqrxZ6pA7OjNmtgw6giTKWiagUC2kt-ePCakg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Handle delay slot for extable lookup
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Oleg Nesterov <oleg@redhat.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Andrew Morton <akpm@linux-foundation.org>, Ben Hutchings <ben@decadent.org.uk>, 
	linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	Xi Ruoyao <xry111@xry111.site>
Content-Type: text/plain; charset="UTF-8"

On Sat, 3 Feb 2024 at 13:56, Jiaxun Yang <jiaxun.yang@flygoat.com> wrote:
>
> Given that exception_ip is guarded by !user_mode(regs), EPC must points
> to a kernel text address. There is no way accessing kernel text will generate such
> exception..

Sadly, that's not actually likely true.

The thing is, the only reason for the code in
get_mmap_lock_carefully() is for kernel bugs. IOW, some kernel bug
with a wild pointer, and we do not want to deadlock on the mm
semaphore, we want to get back to the fault handler and it should
report an oops.

.. and one of the "wild pointers" might in fact be the instruction
pointer, in case we've branched through a NULL function pointer or
similar. IOW, the exception *source* might be the instruction pointer
itself.

So I realy think that MIPS needs to have some kind of "safe kernel
exception pointer" helper. One that is guaranteed not to fault when
evaluating the exception pointer.

Assuming the kernel itself is never built with MIPS16e instructions,
maybe that's a safe assumption thanks to the "get_isa16_mode()" check
of EPC. But all of this makes me nervous.

              Linus

