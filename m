Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB5C779FEB7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236534AbjINIqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236468AbjINIqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:46:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 194CC106
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694681140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZPWUJt9WZ2RKYjC2FfyDRPBLoDD7vPyZdjkHVLwZxgA=;
        b=JnTXJuu6O0U7hDKOeaI/fGpQLKVlSDPsf3fxsg/cI/lCDwtv5CL8pTjWoCp4WMqucrgVih
        YIRMYfVXJBQh3anANPZJrKQ+HVEXDNd/j90bIzAR4DXgWTWXDzgX7VJqzbEc04T5PHKhx0
        9KruOyS2LXpb4e5j4ylJ/WoixNPXAcI=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-600-2rmVHMPwMAytm1NCw455ow-1; Thu, 14 Sep 2023 04:45:39 -0400
X-MC-Unique: 2rmVHMPwMAytm1NCw455ow-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2bcc03ed694so9244031fa.2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:45:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681137; x=1695285937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZPWUJt9WZ2RKYjC2FfyDRPBLoDD7vPyZdjkHVLwZxgA=;
        b=MZme5ovJkmq0vpV0YeQYuEI18QW6IWOAFALlsdgdjR9+LgqlJFpvFTxy/9XP9C8lJb
         O72B/ykS8FG4q+Tkn8DhbW75Ct1vhHHMYiyxPQtaE7tSmKn3H4jymlOgpvPD2RyNA8XM
         gob7LuvjDDLEH30XfeHX2NU9lJRLk+1fG8EwKYFLL1jL4+KfM5cEytE76x6l61bm/Sbx
         1Tl+MAwGyZXqgNQnuB5KUeQOqeHgytL64IZGG8Q83jy6Ez/awEC67LuD3vERJ12PoEg4
         5t2pSjkNOSrLOxHULqa4O24g3XkKb84lOrNDtVyewKJQmHOtM39ZLOqQMMBjvnm4wnfW
         rJkw==
X-Gm-Message-State: AOJu0Yx79wKEb3TlAkcL2TwgJtaTy9cLSYI6Z3hL3OFto6z2ylNzqm1r
        i0tAwU1UnovNZgFRO9LvF3h8mRqdbWyjiQ4yGG6GKAV8AAZBWIfjhlY5ixrN0qpvXfHIHguEido
        KnUXU5kuwx68UI+bDIIJ5PjZ58pOkrBbVCxuONVHQ
X-Received: by 2002:a2e:8557:0:b0:2ba:18e5:1063 with SMTP id u23-20020a2e8557000000b002ba18e51063mr4133168ljj.50.1694681137682;
        Thu, 14 Sep 2023 01:45:37 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEl3iGxG9z9pzSVoj1U53hPDZT0x51orYLzvDfs6x7agdKCrNDqRvP0Eb3gKLCiKIk4fXxQBbe7PBIylDs+3T8=
X-Received: by 2002:a2e:8557:0:b0:2ba:18e5:1063 with SMTP id
 u23-20020a2e8557000000b002ba18e51063mr4133140ljj.50.1694681137323; Thu, 14
 Sep 2023 01:45:37 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115316.3652155-1-leitao@debian.org> <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
In-Reply-To: <ZQHiJxHSSGNk+ul5@gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 14 Sep 2023 10:45:26 +0200
Message-ID: <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Breno Leitao <leitao@debian.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Sandipan Das <sandipan.das@amd.com>, leit@fb.com,
        dcostantino@meta.com,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-perf-users@vger.kernel.org>,
        "open list:PERFORMANCE EVENTS SUBSYSTEM" 
        <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Breno,

I'm definitively voting for using WARN_ON_ONCE - in the current
implementation, we are getting thousands of the same warnings and Call
Traces, causing the system to become unusable.

>Anyway, please let me know whatever is your preferred way and I will submi=
t a v2.
@Peter Zijlstra and @Sandipan - could you please comment on the
preferred implementation of the patch?

THANK YOU
Jirka

On Wed, Sep 13, 2023 at 6:24=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> Hi Peter,
>
> On Fri, Jun 16, 2023 at 03:29:54PM +0200, Peter Zijlstra wrote:
> > On Fri, Jun 16, 2023 at 04:53:15AM -0700, Breno Leitao wrote:
> > > On some systems, the Performance Counter Global Status Register is
> > > coming with reserved bits set, which causes the system to be unusable
> > > if a simple `perf top` runs. The system hits the WARN() thousands tim=
es
> > > while perf runs.
> > >
> > > WARNING: CPU: 18 PID: 20608 at arch/x86/events/amd/core.c:944 amd_pmu=
_v2_handle_irq+0x1be/0x2b0
> > >
> > > This happens because the "Performance Counter Global Status Register"
> > > (PerfCntGlobalStatus) MSR has bit 7 set. Bit 7 should be reserved acc=
ording
> > > to the documentation (Figure 13-12 from "AMD64 Architecture Programme=
r=E2=80=99s
> > > Manual, Volume 2: System Programming, 24593"[1]
> >
> > Would it then not make more sense to mask out bit7 before:
> >
> > +     status &=3D ~AMD_PMU_V2_GLOBAL_STATUS_RESERVED;
> >       if (!status)
> >               goto done;
>
> Instead of masking `status` against AMD_PMU_V2_GLOBAL_STATUS_RESERVED
> (AMD64_NUM_COUNTERS?), I opted for using the `amd_pmu_global_cntr_mask`
> global variable because it seems to represent what the loop below is
> iterating over:
>
>         /* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
>         static u64 amd_pmu_global_cntr_mask __read_mostly;
>
> Also, I think we want to WARN_ON_ONCE() if we see this problem. Right
> now, it warns at every time we call this function, which makes the
> machine unusable, but, warning it once could be helpful to figure out
> there is something wrong with the machine/firmware.
>
> Anyway, please let me know whatever is your preferred way and I will
> submit a v2.
>


--=20
-Jirka

