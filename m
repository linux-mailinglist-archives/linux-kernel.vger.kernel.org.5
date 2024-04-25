Return-Path: <linux-kernel+bounces-159048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CEA58B289C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 20:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D60E1281B08
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 18:58:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DC41514F3;
	Thu, 25 Apr 2024 18:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="O2tq0uoX"
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com [209.85.208.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935291509B1
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 18:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714071518; cv=none; b=Ov8at9KAGo2LrdCS/o+7fQPzNodd958cgot0ZgpSdGj1wB4paVf4+2sG5RkOc9JUYxuo+Lpasre0r0XZ87bJbAOH7i2AAVE0xc65RKdUK8D+0HZe0MhELcMrjlDKQL4oy8YbC2vnl4v9mC+FpLFBFHAZ/OU1/8vb8vtDgtbBBPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714071518; c=relaxed/simple;
	bh=OVpsYfA8Qvyh7CR1+bvLaN9uwU+c3vdVxNAvJVeMlHk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kI5iW/Of25HHbZDZnXlndIV8swK2EvfKJ69X38OVGn6vaxjMmXJybE7w95hdFD+8BfXQzVB48k+iyBlXoGBXczpA++TlT316cfAd19j+iDPd1G8XRWcMUhJxgFDGmnCTYNOl+aQh6KZf41uri3YNUnWR8nMY3lY/F0QOjkEPi78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=O2tq0uoX; arc=none smtp.client-ip=209.85.208.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2def8e58471so16168731fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714071514; x=1714676314; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ce4eWZ96+PrDKbqu3JpH3mxBstfm8l4HTUGuvQBwL34=;
        b=O2tq0uoXJdvJEReh3iYL6qanMPcCXV3+BCB4zB+04uKxo64KWrSXgHT+Fn60fRktgJ
         oKNkwhebQN1cbviut4hcvnH+Jyp1wdWB/SinhTQPWmikxoge48vp11yDSpfvOtzayxPd
         Fy7fcMGKmWxt9+ozmxMz5Ai6Dz/IHLI86IUZ8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714071514; x=1714676314;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ce4eWZ96+PrDKbqu3JpH3mxBstfm8l4HTUGuvQBwL34=;
        b=T14PBOv4gzW9hmje9oOJXnpT+etuMY2LQc1ryAjfiyYZh+XSFdZZlDtVgNT5yeqdBr
         AKalJMxe/MqITPqmfgP8nb/yMbU9BK9FhyU6meoKF/pV6PU/T36APGNLjYQy8/fRi7Bv
         L1cdWxP4yo2lOUgIWK8mDSwiA11KSHjbRYv+D/lMX5dLAtoSRSOj0hmXtM00PnbwX2Cn
         hvRIbq4WxU0EfbPVX6WPVixivkIVUrJMc2t5R7+0QRN7alzVBUfZVwUyDBPvSWFXNI9R
         dAXJci4xbXcncDtkXZxgwKOpk+l/qw9z7cmEdkwCzi4B3PgA2V+zlZyk7IftgCBOTOMn
         UCQQ==
X-Forwarded-Encrypted: i=1; AJvYcCU0wS1IXnidT7sFsRfIqDQ/6Qe2RiwlM8nYFZ400+iyFBb+vkgFopAW5+6/4kOnx1EXC89Osskbr4DMXemDF0KRpOdFcXj4XejgQ01q
X-Gm-Message-State: AOJu0YzVnE3pAUuBpmaMiGIVzFQMLc46K0tIzDZFNkcorrs7F5mfebn/
	cfYSyAJJCziwQNpXUPNc1IsVvHVJrGGcMQzCT25aiSbNuN513kXh9mxChHUnEsfs69tzlhA3j3x
	VgRjqLQ==
X-Google-Smtp-Source: AGHT+IHNs/SpKuvCrXuc6DDaL++aT7tTsWuBtaCrpuJ/KGFN9FgOFhcNiBAnpPeIcpps9CIm1LkieQ==
X-Received: by 2002:a2e:a1c5:0:b0:2d6:c749:17bc with SMTP id c5-20020a2ea1c5000000b002d6c74917bcmr183194ljm.31.1714071514465;
        Thu, 25 Apr 2024 11:58:34 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id f26-20020a2e6a1a000000b002d8d0c91f55sm2451671ljc.2.2024.04.25.11.58.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 11:58:33 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-5176f217b7bso2449236e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 11:58:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCUjFVZOUWqMfW5ILouCyUdazKbGlR5xb25+by2nzZkHJ+U59EjG8NnZ5RcYZGWIdLo05XKEOmredlKpfaQKLppqbOPmFMo5uOtdf3E4
X-Received: by 2002:a05:6512:ba7:b0:51a:fc86:fc6d with SMTP id
 b39-20020a0565120ba700b0051afc86fc6dmr218319lfv.22.1714071512772; Thu, 25 Apr
 2024 11:58:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
In-Reply-To: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 11:58:16 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
Message-ID: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 10:46, Rafael J. Wysocki <rafael@kernel.org> wrote:
>
>  - Fix bit offset computation in MASK_VAL() macro used for applying
>    a bitmask to a new CPPC register value (Jarred White).

Honestly, that code should never have used GENMASK() in the first place.

When a helper macro is more complicated than just doing the obvious
thing without it, it's not a helper macro any more.

Doing

    GENMASK(((reg)->bit_width) - 1, 0)

is literally more work than just doing the obvious thing

    ((1ul << (reg)->bit_width) - 1)

and using that "helper" macro was actually more error-prone too as
shown by this example, because of the whole "inclusive or not" issue.

BUT!

Even with that simpler model, that's still entirely buggy, since 'val'
is 64-bit, and these GENMASK tricks only work on 'long'.

Which happens to be ok on x86-64, of course, and maybe in practice all
fields are less than 32 bits in width anyway so maybe it even works on
32-bit, but this all smells HORRIBLY WRONG.

And no, the fix is *NOT* to make that GENVAL() mindlessly just be
GENVAL_ULL().  That fixes the immediate bug, but it shows - once again
- how mindlessly using "helper macros" is not the right thing to do.

When that macro now has had TWO independent bugs, how about you just
write it out with explicit types and without any broken "helpers":

   static inline u64 MASK_VAL(const struct cpc_reg *reg, u64 val)
   {
        u64 mask = (1ull << reg->bit_width)-1;
        return (val >> reg->bit_offset) & mask;
   }

which is a few more lines, but doesn't that make it a whole lot more readable?

And maybe this time, it's not a buggy mess?

               Linus

