Return-Path: <linux-kernel+bounces-123546-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B8649890AA3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 21:09:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB6391C28333
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 20:09:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C45713849A;
	Thu, 28 Mar 2024 20:09:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="b/LxhMJ5"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F8E36AF5
	for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 20:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711656569; cv=none; b=ikQr1otFOq0ztyhyB8jOp1pOiGVjTo8fu3m9xShZFFjRiuUiwEViRp9Hj2fCzyEQ+N5AGKvCFYD5qyFz8xDQLqNimSZOOXB+Pr/hvsNM7Qr6DzB4Tp5ikODVaQqYPM/9+h5UwQph00Z4aVmnA6Vs0GOx7Jv5rQU6lT1wgijBGZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711656569; c=relaxed/simple;
	bh=OrfH9kHPnKygy3hofZhQXKxDKdHWeNXPs7Z+BPCJInw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fgyD9hRFx02aPyX6SBVcdFZnkf6a1mmDTwilz/NLUgLPk8/gKwxL6MHwLAI+QlAbohuBeBPCroobVr69kTa5naSY2/BvAnt3n5MZOazIHBgaPhTeYlDs+7VWi3ox3ORQ2t8ciW59CdhHdVGH7MCUONm1U3KHsYOAyOphur9SPUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org; spf=pass smtp.mailfrom=linuxfoundation.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=b/LxhMJ5; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-foundation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linuxfoundation.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso2061769a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google; t=1711656566; x=1712261366; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XTxbVAahUUqo8qIWTib74cjwQuWnxXYmY/UOpSlb0dE=;
        b=b/LxhMJ57ZDdtRC1jnmbGYmHuyi7ZeUNhv+WO4VtE6p2IjBs4Sh6EDg2vfrOHpTRRE
         ySp5gYKo/2TisecQtLdTEAeGRTEEax8c2YO7gNfnkT60JNQb+iwq5XPDvaMDyONlorTe
         R/DuoDJ5Qp+aFmQcJWLaTSY+ZmEvQjCGPxAlU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711656566; x=1712261366;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XTxbVAahUUqo8qIWTib74cjwQuWnxXYmY/UOpSlb0dE=;
        b=TQqoiaCwto03+NqEhKWFCFdc84Skn2nKjqFgkPtGLbEwhe1R7fs7nDxQHUpJ3OuY6/
         vdXTaHkPVzuC4sxTXFgrKQ+JlWPDsmh0xZGQuaDflIQTKMixDZN0K539JeZyXMklTnln
         IwkpRPORiT/MZ3rXjwymBxVGb5kWMfVsansu+Vj1zuFAbALa8cAuF5ocK/a6PwEbMSE7
         2LEFApsmozQgoOGLW54FfnCYja0oLZaZiGKxYsh+HfA4s6ja8z+YDhNGYwTnyDiYTf54
         MvitQ6SGXGLTMahG572X6m7qEeimXiaS3hXGKQbFtM779cefDmY+lI1e/Mo8cSYp6JFt
         mivQ==
X-Forwarded-Encrypted: i=1; AJvYcCXL1MjN7Gbym9UL7HoqPNTVXBTWFz7/3YfWF7Vkaoakwr/BlDoEmInCZxpSzeKjvHvYAk5K802sM//C0MS/4X2h2Qfel5PDdekmZHmH
X-Gm-Message-State: AOJu0YzZCyKG3nD870C4GMiXbdIeB0YjDQbHJG63tW1qEDE7YU68KSKU
	11JQjwXoWbUM+8mEuJvbeSeNG+zZ1Yw9XN8NDZmcEl/pYMMrk6ULw79EeSq1gWfjnuuannH06+6
	4hdua7A==
X-Google-Smtp-Source: AGHT+IH5L1fxOIwUYxNmDIgSBfgs+INEPbgDhVdz7a57F3LCISVk/rN2S0WX3sNnjqxPsIwfyqZPNw==
X-Received: by 2002:a50:cc8e:0:b0:568:c6a2:f427 with SMTP id q14-20020a50cc8e000000b00568c6a2f427mr179380edi.27.1711656566226;
        Thu, 28 Mar 2024 13:09:26 -0700 (PDT)
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com. [209.85.208.49])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b0056c0a3d91easm1177587edb.12.2024.03.28.13.09.24
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 Mar 2024 13:09:24 -0700 (PDT)
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-56845954ffeso2061740a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 28 Mar 2024 13:09:24 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWxvo6SR4fYZsLmqHQAvB+ygPED9//EjvxkLItxWJDtGb9zd/AUqHgAPT+WcD1iYjQ2pG4/Obt6eoDrEx1rWGMXmRPHY/Dz8ikTO6jg
X-Received: by 2002:a17:906:2698:b0:a47:4d61:de44 with SMTP id
 t24-20020a170906269800b00a474d61de44mr190688ejc.55.1711656564444; Thu, 28 Mar
 2024 13:09:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com>
 <CADyTPEyAidGgBT3f1VJLHb3ouO-r1UyvFp1PcwXxy0NRG94sbw@mail.gmail.com>
 <1df92fec-7f57-5080-94ed-b149ed384280@leemhuis.info> <14dcd743-144a-9f7b-849c-0843d50e4c04@draconx.ca>
 <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
In-Reply-To: <4dce7447-678d-4e60-b76e-b01988bd6515@leemhuis.info>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 28 Mar 2024 13:09:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Message-ID: <CAHk-=wgFuoHpMk_Z_R3qMXVDgq0N1592+bABkyGjwwSL4zBtHA@mail.gmail.com>
Subject: Re: PROBLEM: Only one CPU active on Ultra 60 since ~4.8 (regression)
To: Linux regressions mailing list <regressions@lists.linux.dev>, Andreas Larsson <andreas@gaisler.com>
Cc: Nick Bowler <nbowler@draconx.ca>, linux-kernel@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

On Thu, 28 Mar 2024 at 12:36, Linux regression tracking (Thorsten
Leemhuis) <regressions@leemhuis.info> wrote:
>
> [CCing Linus, in case I say something to his disliking]
>
> On 22.03.24 05:57, Nick Bowler wrote:
> >
> > Just a friendly reminder that this issue still happens on Linux 6.8 and
> > reverting commit 9b2f753ec237 as indicated below is still sufficient to
> > resolve the problem.
>
> FWIW, that commit 9b2f753ec23710 ("sparc64: Fix cpu_possible_mask if
> nr_cpus is set") is from v4.8. Reverting it after all that time might
> easily lead to even bigger trouble.

I'm definitely not reverting a patch from almost a decade ago as a regression.

If it took that long to find, it can't be that critical of a regression.

So yes, let's treat it as a regular bug. And let's bring in Andreas to
the discussion too (although presumably he has seen it on the
sparclinux mailing list).

Andreas, if not, here's the link to lore for the beginning of the thread:

  https://lore.kernel.org/all/CADyTPEwt=ZNams+1bpMB1F9w_vUdPsGCt92DBQxxq_VtaLoTdw@mail.gmail.com/

And from a quick look I do think that commit is buggy, and yes, the
fix probably is just be to revert it.

As the original report makes clear, that commit 9b2f753ec23710 is
clearly confused about the difference between "number of CPU's", and
"index of CPU numbers".

When that smp_fill_in_cpu_possible_map() does

        int possible_cpus = num_possible_cpus();

and then uses that to fill in &__cpu_possible_mask, that's completely
nonsensical. Because we literally have

  #define cpu_possible_mask ((const struct cpumask *)&__cpu_possible_mask)
  #define num_possible_cpus()     cpumask_weight(cpu_possible_mask)

so it's reading cpu_possible_mask to figure out how many cpus it might
have, and then using that number to set possibly *different* bits in
the same bitmap that is just used to judge what the max number is.

So I do think a revert is called for, but I'm not going to treat this
as a regression, I'm going to just treat it as "sparc bug" and hope
that the sparc people try to figure out why that crazy code was
written.

And maybe it made more sense back a decade ago than it does now.

Andreas?

                Linus

