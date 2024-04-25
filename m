Return-Path: <linux-kernel+bounces-159072-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A48D8B28F2
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 21:18:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D47101C21F19
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 19:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2523D14E2E2;
	Thu, 25 Apr 2024 19:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="NLaMPAaD"
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EB72135A
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 19:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714072718; cv=none; b=TWvxPRtctpFUCWpA/W31QKPqZ58pnESv2nZK4CmgZkMXqo9QS/f3hpdFjUf0IIJGAwCuVm183TIX1X9nbceeiAA5IfxYAI0V4wHkOCsigBEkBjbUhAGj5y6bQCZ/pshxcG9VkuMgCCVGMS0sRmiVdBrdE6XjFh2JfGbtf3Tke1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714072718; c=relaxed/simple;
	bh=9SMxCSKhvmc+6oVvqLR1AsFgyVSziSQPD4cUWIChFV0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OlrVBK+bQHYDi1K1U/A7iOj/Qs/fSYjIVCG7RegPN0YC66MXfRIKDm5yhdfWAsI1+nwud83Bd7W59VMozaRo+F8IYo2JghvtCb179LuwW1SPosDYiX2jzPv62qf/vp0OE7iASRh9I2RyVmjXrocFuam0OkxCXbUHxCIIuUw2cAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=NLaMPAaD; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-571c22d9de4so2093888a12.3
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1714072714; x=1714677514; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ev52rMR4Q4Woczb+9iTzXyh9tVmc6K3sVmdOuWpY6dU=;
        b=NLaMPAaDAfWyAjYqlc8UoygSIrawsyKNAlA7ESSWqmOyuD7gYLHRVsXShcg27laH8C
         nrJd6Nj6G8fx4R8h0a8lGW4sjlZ9kMbuxbjuZPoDCVrR4Sw84QIFhpBf3t6MTgRss3lj
         taDq8/QEE0XVuwzqEDWPUP3Xc4yEjWjtvE2Mc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714072714; x=1714677514;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ev52rMR4Q4Woczb+9iTzXyh9tVmc6K3sVmdOuWpY6dU=;
        b=hG3+sKgBouyINCAfgDM43hq/Ps6eUN8vJslSfc9CYH9FQTD9071JXPD0Nu0xiWq7n6
         1t5uCTc3lHVEkvj2pkXyKr0TQmchosvw7t/LDcJHTXnxEAlux6z88hFoG2t3s32+6Gm2
         jAIdR4be+u5tqDxdYx/tk0OWz5+eETUcJI6WEMOMHETBemvstxONEgPzQ6Is9JO5Z8hD
         Tz54w9X7g5s5cGN8BBc5b/HFjfsTLSTIMkBdwWVk4bAfl6dJVlr+tiWf6/ijLFXCtE6e
         ejP14ko76cfRdKZTb728a1Xh8V2br1+OeWyeItaOlLlWIUxw2V6Rg2uN7nokEhExfEGl
         SrPA==
X-Forwarded-Encrypted: i=1; AJvYcCULQS6INEh+IhifKgRZKgdutTs6dadwu7eYh+Z/bviDXg7JzvqQqdjpTsChGAk28bmVa+csATlVi4XrSY0I2B+IUeFQsI00/5HTwQZK
X-Gm-Message-State: AOJu0YwhKhrnFYTlaPfbZtzKsYYwLn5eZUq4VfjaYVEH04YQqoerON6w
	8ph1+X2YmnL/ac77disU7/sSwnBKFSpX3vwj+5nqq2NZc9bnzZsE1z934JMhHojc92A7lZKsj4F
	s2I+ixw==
X-Google-Smtp-Source: AGHT+IHwFEUXONOtUtq0UtRh3pYTp8Tw1vjc98RZKcUVE5ieQmYmWF/dkqwm+UmB+u0C+83l6yeVlA==
X-Received: by 2002:a17:906:3102:b0:a55:aeb0:cb22 with SMTP id 2-20020a170906310200b00a55aeb0cb22mr537592ejx.9.1714072714451;
        Thu, 25 Apr 2024 12:18:34 -0700 (PDT)
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com. [209.85.218.41])
        by smtp.gmail.com with ESMTPSA id mc11-20020a170906eb4b00b00a5256d8c956sm9764353ejb.61.2024.04.25.12.18.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Apr 2024 12:18:33 -0700 (PDT)
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a51a7d4466bso161182366b.2
        for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 12:18:33 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCXjCW6H7cbq56SiGGBNZA4u5FgHfpYPa0MyvCBGaQtJQOx5GTIiH75Y0gf1xppNkAnkxZFHDkCJdgE8Qb9QlmQ4kF2CdmnBPImUA5Tj
X-Received: by 2002:a17:906:1345:b0:a4e:cd5c:da72 with SMTP id
 x5-20020a170906134500b00a4ecd5cda72mr421167ejb.63.1714072713361; Thu, 25 Apr
 2024 12:18:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAJZ5v0iUUmMUo86vBzYJjL4NjoFzpDwD1+c292aP+T++PLv6vQ@mail.gmail.com>
 <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
In-Reply-To: <CAHk-=wj8J78-12QfAoKaLdRi2g1=_U7sv02POShjotcJ6t4nzw@mail.gmail.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 25 Apr 2024 12:18:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
Message-ID: <CAHk-=wj52PUZ0xtoLs79B9uar6h7FVaKC0gbD-a_wZxDjH2ViQ@mail.gmail.com>
Subject: Re: [GIT PULL] ACPI fixes for v6.9-rc6
To: "Rafael J. Wysocki" <rafael@kernel.org>, Jarred White <jarredwhite@linux.microsoft.com>
Cc: ACPI Devel Maling List <linux-acpi@vger.kernel.org>, Linux PM <linux-pm@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

On Thu, 25 Apr 2024 at 11:58, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> And maybe this time, it's not a buggy mess?

Actually, even with MASK_VAL() fixed, I think it's *STILL* a buggy mess.

Why? Beuse the *uses* of MASK_VAL() seem entirely bogus.

In particular, we have this in cpc_write():

        if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY)
                val = MASK_VAL(reg, val);

        switch (size) {
        case 8:
                writeb_relaxed(val, vaddr);
                break;
        case 16:
                writew_relaxed(val, vaddr);
                break;
        ...

and I strongly suspect that it needs to update the 'vaddr' too. Something like

        if (reg->space_id == ACPI_ADR_SPACE_SYSTEM_MEMORY) {
                val = MASK_VAL(reg, val);
  #ifdef __LITTLE_ENDIAN
                vaddr += reg->bit_offset >> 3;
                if (reg->bit_offset & 7)
                        return -EFAULT;
  #else
                /* Fixme if we ever care */
                if (reg->bit_offset)
                        return -EFAULT;
  #endif
        }

*might* be changing this in the right direction, but it's unclear and
I neither know that CPC rules, nor did I think _that_ much about it.

Anyway, the take-away should be that all this code is entirely broken
and somebody didn't think enough about it.

It's possible that that whole cpc_write() ACPI_ADR_SPACE_SYSTEM_MEMORY
case should be done as a 64-bit "read-mask-write" sequence.

Possibly with "reg->bit_offset == 0" and the 8/16/32/64-bit cases as a
special case for "just do the write".

Or, maybe writes with a non-zero bit offset shouldn't be allowed at
all, and there are CPC rules that aren't checked. I don't know. I only
know that the current code is seriously broken.

                   Linus

