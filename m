Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79F067A0676
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 15:52:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239254AbjINNwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239273AbjINNwD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 09:52:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48BB51BE
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694699472;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=K1aANZQtwFDU4g/VWeNDGent7e6hMjtrdWucBBS3aak=;
        b=UQayGSK0b+mo+8T73EKI4aswLlWNmA+SCTxy60guCh+txhUtztqv/9QdZlWT/WDSMkZ+dU
        Ezwo5wdKzderosmHKpLX5sUu+NHWzoTTbkUHh+1lmiAyeo8LMqq0f8uZg7YW0n4h8pz/0U
        3jxdxfrux3UahoECUgVa93amRt92SRo=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-VW-wcnJnPHe2mo6N2Hs_OQ-1; Thu, 14 Sep 2023 09:51:11 -0400
X-MC-Unique: VW-wcnJnPHe2mo6N2Hs_OQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2be370ff948so12353071fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 06:51:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699469; x=1695304269;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=K1aANZQtwFDU4g/VWeNDGent7e6hMjtrdWucBBS3aak=;
        b=oLQdPKgIqTChqH5Kqt+dqUYdTD+38SeGN2wMr2vSTdb2HFA43GesM0PhT85Xdd56rF
         Ibg8rI/k1lCmLrzgh5gq+utC/oTdifOzAlj0Zqbtn7OiFZIHiQgruiYDqcLbi3u0ZWqE
         zXSWchOM7tGjRgPYMAAO0SogOg2MBH5coA6lVHn/YFWJkho/N+a5L0OeFtV9LTxiu9Z7
         3B2eMy2ImAN1ByZPVTxTzno3Xd9ToOsRBa2PAndEXx6gxz2OspRUA2seNgG+ZkGPvUsA
         bk4x5wbiWLPFW0va9N1KNLmWSg4xCssNaJ/0WZF4OQPV1hn0WdBEFpucstygz9H12w3h
         G/eg==
X-Gm-Message-State: AOJu0YzXfJaFxOZysez1XsdX2rzDAiXqOKh+ucPRlQte1vUiiJjgjfjL
        eBo8cKoRdD1fBO9hgm96Od+5JcwrEpjilX52lx4Q7/qj1xZEe4DjgRo8c2s/b9ZSenQx/DeqmX5
        IILeLzajL7O3GnXGsjuPsNEyQWrH+bp0ir/X4lTM3
X-Received: by 2002:a2e:924d:0:b0:2bc:bf29:18d3 with SMTP id v13-20020a2e924d000000b002bcbf2918d3mr4921036ljg.31.1694699469466;
        Thu, 14 Sep 2023 06:51:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGK7INPPlpWH23+iLmgrvRbIbOe157ZE8DmeGxtMRrlh2im4vwq15gUMK1Q785CMuTKK3cW1Ha9IbpSxNndAO8=
X-Received: by 2002:a2e:924d:0:b0:2bc:bf29:18d3 with SMTP id
 v13-20020a2e924d000000b002bcbf2918d3mr4921011ljg.31.1694699469086; Thu, 14
 Sep 2023 06:51:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115316.3652155-1-leitao@debian.org> <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com> <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com> <20230914091234.GE16631@noisy.programming.kicks-ass.net>
 <ZQLSw6PeUbV+p2gH@gmail.com> <20230914111845.GF16631@noisy.programming.kicks-ass.net>
 <b1cf5990-1019-49ea-a1e8-e22410922801@amd.com> <ZQL64dX+5lfK4rOh@gmail.com>
In-Reply-To: <ZQL64dX+5lfK4rOh@gmail.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 14 Sep 2023 15:50:57 +0200
Message-ID: <CAE4VaGDkAcs8v8ReT3ZhimWmMY0MGH0Rsi5GX1C4=-B-81vSYA@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Breno Leitao <leitao@debian.org>
Cc:     Sandipan Das <sandipan.das@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
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
        "H. Peter Anvin" <hpa@zytor.com>, leit@fb.com,
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

Thank you, all!

I have confirmed that the latest microcode fixes the issue.

=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
cat /proc/cpuinfo
microcode       : 0xaa00212

perf top runs fine, without any kernel warnings
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D

Jirka


On Thu, Sep 14, 2023 at 2:22=E2=80=AFPM Breno Leitao <leitao@debian.org> wr=
ote:
>
> On Thu, Sep 14, 2023 at 04:52:13PM +0530, Sandipan Das wrote:
> > On 9/14/2023 4:48 PM, Peter Zijlstra wrote:
> > > On Thu, Sep 14, 2023 at 02:30:43AM -0700, Breno Leitao wrote:
> > >> On Thu, Sep 14, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> > >>> On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
> > >>
> > >>>> I agree with using WARN_ON_ONCE() to make this less intrusive.
> > >>>
> > >>> Could you send a patch that AMD is happy with?
> > >>
> > >> Why the current patch is not good enough?
> > >
> > > Sandipan, can you answer this? I don't tihnk I'm qualified to speak f=
or
> > > the AMD pmu and certainly I don't have insight into their design futu=
re.
> >
> > Hi Breno,
> >
> > Functionally, the patch looks good to me and I will be reusing it
> > without any change to the authorship. However, as Peter suggested, I
> > wanted to add a message to prompt users to update the microcode and
> > also call out the required patch levels in the commit message since
> > different Zen 4 variants and steppings use different microcode.
> >
> > Here's what I plan to send.
>
> Awesome. Thanks for addressing it.
>


--=20
-Jirka

