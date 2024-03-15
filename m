Return-Path: <linux-kernel+bounces-104987-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2140987D750
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CABF81F220F0
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 23:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCED65A4C9;
	Fri, 15 Mar 2024 23:23:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PaPbdIQP"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0CBA54745
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 23:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710545011; cv=none; b=T7mpCwzF0z2vcdngtvPGxgnXjWgJ7tSTbJZRt0/s+Nf/r34JxnB5AoekX/Sk0QzWshviyjKw5q6thavgUSMvMALiTSjsVLK01RKcXP3EUwHKrZunMbBhV3WCeDezqlzvGGaarYNUp6wN3scF7mCu9gxQFs9DaCaLAfHmi3n1JIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710545011; c=relaxed/simple;
	bh=sytlPHzECdx/TQnD3Z0Odvtgw7GxrNRoLcw66cnO0n8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZD/ZV20QTcJcRLEh1WQWzCEqEHEphVbAsz9zXOkHUFkv3zlJn8DkQEk9F5TBD1bki6zvcKBmibrJNUycgoQ4wuU53KoXrxIx/rlhM1rWAqiAxJlgqh5P2ar6f2RCoa2R1yGz3HOh49P66Fwa7PM3kWJ2fAKASdwHS6tQi7dfuSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PaPbdIQP; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-513e134f73aso19220e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:23:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google; t=1710545006; x=1711149806; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Md0NRsaNOOwAL+jub1moMYrNKunx652Xm1e//iAuX8U=;
        b=PaPbdIQPRFOUY4nCtg40+NoIFL1U7vLk82l+a7I2sXjBINk2jd+pfILFeMtwehYcBj
         mk+JeE5m3JpQBRZOEf2Pdx1W+wabAQ1WCPF++ygfS0M4YxMmdlqsqHuwzxXn311AgC5z
         x40h1q0dFqd/VZgn79pjDwQkfic//HZqpUTYg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710545006; x=1711149806;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Md0NRsaNOOwAL+jub1moMYrNKunx652Xm1e//iAuX8U=;
        b=m4/zoElLsf4tdHh4gEW8BLeTltlqLigjWm2VmP6P6XBESTs3oPoUglirCjBaflKIE4
         zn18XxYrFk6foZ2Kq8guenRHjFP3pp1CF8aQ4qhi9kiMjjDEp0d4PHktb3Yz/KaNjtUQ
         P+zW67vAVEfbDSLKmPiLZ/Rh8F1pdt73115+p2cg8ZqXEnoDJPluOxGO64qCsz89dvhb
         ZZO73DLevNnX2em+udxbTfcUIl8Maz0EyQP9rqgjDshRbpZh9m2Yt/zBYYyCNKCcVe1K
         BIJyfMgNxiEhKMF6SWm8VkrrEYmbZMqd9AFe9B+mq/Qh+vEknB136uVloQlMEIggTAz9
         Hm7g==
X-Forwarded-Encrypted: i=1; AJvYcCXPynFsiNKT4mcC8eCEOV4Yw7Yqhd0TVlP87tsMFCiC1aPHqmoeUUrVPnllJK4RX2dmkmn/T1bZhEX6ryyzyiYYnKWQK6+UA6pGLI9S
X-Gm-Message-State: AOJu0YxXPMeD0QOnZ4pFJdlxqVPMKkFqK0aIHskl2cZ3nE8CGdK+kCIV
	439wguLphJ4KIR3Bxdv79ROgA+E/3O+K5Ess4wlKCkhdGJxc5jS5m2gCp1rdJocQu9t2wYUg57U
	IWhi8xw==
X-Google-Smtp-Source: AGHT+IHw/dNmSy3gP5T6oVi1MBmgcYhlMeaGhoL8hQdUgz0WebMsrmZQgghFvixdab+rEmwNK2j/Zg==
X-Received: by 2002:a05:6512:32b7:b0:513:c9d2:e1e1 with SMTP id q23-20020a05651232b700b00513c9d2e1e1mr4329014lfe.66.1710545006688;
        Fri, 15 Mar 2024 16:23:26 -0700 (PDT)
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com. [209.85.167.49])
        by smtp.gmail.com with ESMTPSA id 25-20020ac25f59000000b00513ca446cb4sm776860lfz.120.2024.03.15.16.23.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 16:23:25 -0700 (PDT)
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-513e134f73aso19197e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 16:23:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCW4MW5H8Gz+GyIPoxTu8AtJQAzT1w83KMs0Fc2+qChSaviiqVY2S7X+0QN0abAHdIh7VunSrUNi5hZOq3vMiJawoYbITIx+0mcGYy+h
X-Received: by 2002:a19:5f45:0:b0:512:ed8e:97ce with SMTP id
 a5-20020a195f45000000b00512ed8e97cemr3783714lfj.16.1710545005123; Fri, 15 Mar
 2024 16:23:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240303235029.555787150@linutronix.de> <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
In-Reply-To: <87o7bfjeae.ffs@tglx>
From: Linus Torvalds <torvalds@linuxfoundation.org>
Date: Fri, 15 Mar 2024 16:23:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
Message-ID: <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Guenter Roeck <linux@roeck-us.net>, LKML <linux-kernel@vger.kernel.org>, x86@kernel.org, 
	Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org, lkp@intel.com, 
	oe-kbuild-all@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

On Fri, 15 Mar 2024 at 15:55, Thomas Gleixner <tglx@linutronix.de> wrote:
>
> Not really. The problem is that a SMP build can run on a UP machine w/o
> APIC or command line disables the APIC and will run into the exactly
> same problem. The only case where we know that it is impossible is when
> APIC support is disabled, which is silly but topic for a different
> discussion.

Oh, I agree - that was why I said that it shouldn't depend on a local
APIC on machines that may not even have one.

That "may not even have one" can still be a static option - we
technically allow 32-bit UP kernel to not enable X86_UP_APIC, although
it might be time to drop that option.

> So the proper thing to do is to check for num_possible_cpus() == 1 in
> that function.

I think that's _one_ proper thing. I still think that the deeper
problem is that it still looks at local apic rules even when those
rules are completely nonsensical.

For example, that MAX_LOCAL_APIC range test may not matter simply
because it's testing a constant value, but it still smells entirely
wrong to even check for that, when the system doesn't necessarily have
one.

So I think your patch may fix the immediate bug, but I think it's
still just a band-aid.

Either we should just make all machines look like they have the proper
local apic mappings, or we shouldn't look at any local apic rules AT
ALL.

So I'd rather see those apic_maps[] just be properly filled in.

> Sure you can argue that we could avoid it for SMP=n builds completely,
> but I think the right thing to do is to aim for removing CONFIG_SMP and
> make the UP build a subset of a generic SMP capable build which has
> CONFIG_NR_CPUS=1, i.e. num_possible_cpus() = 1. Why?

I wouldn't be entirely opposed to just doing that. UP has become
fairly irrelevant.

That said, UP is *not* entirely irrelevant on other architectures, and
if we drop UP support on x86, we'll be effectively dropping a lot of
coverage testing. The number of people who do cross-compilers is
pretty small.

End result: I'd *much* rather get rid of X86_UP_APIC and the "nolapic"
kernel command line, and say "even UP has to have a local APIC".

We already require a Pentium-class CPU, so in practice we already
require that local APIC setup. And yes, machines existed where it
could be turned off, but I don't think that is relevant any more.

Put another way: I think "UP config for wider build testing" is a
_lot_ more relevant than "no LAPIC support".

             Linus

