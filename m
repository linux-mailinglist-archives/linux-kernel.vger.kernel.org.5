Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E19F79FEB6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:45:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236525AbjINIpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjINIpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:45:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 472041FC2
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1694681079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aZw6hbxq/embQ47llYIzPMH7DMweT5RR/fyzZ/IaAeE=;
        b=UR3emsxJh13krOgqRavuw8HluBUD35miLG+FM5kb90NNLve9JcNuscM1GQsAOPfaeK24L7
        npHLzH6Vt6EAJUXM0YYWRcqMLUDgNlwKaN8sV4dtzRCaJ/+pXk1WEkyvDaomv4lXfA8WID
        gkoZQQ90Drk+4kep8ATujBz0s+CAZkI=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-naHRBVFIMG6uFpDTrk4zVw-1; Thu, 14 Sep 2023 04:44:38 -0400
X-MC-Unique: naHRBVFIMG6uFpDTrk4zVw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2be63489592so12274371fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 01:44:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694681077; x=1695285877;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aZw6hbxq/embQ47llYIzPMH7DMweT5RR/fyzZ/IaAeE=;
        b=nI81/vp44l8mGmV94BbItdYGGDzvzZ16RttCUxHohQNzbgGxqpzlF/gwJRVBTAk8vz
         ELaVP3TD3KELUBrVcfpu7gVhFowQIdJm3lEOd/lVlaBFqkCweLQNyy/XwTMLk1A3JpWX
         qDof08Gjnuij04d4WFNpLTDOxQF3eGtTRJGxchPScmlKkqpUkIxumuexXcX20pVr2OS2
         wE75yCrwa8ly5aA7WZS5TQG7nabsoLxidLKn/Y1YtMmsT/YjLb3Cp/DietjU/XFVBXVf
         6pzmcC1goYZVU+ngEpYYWlx2LvNyM9erEFfG6c4ydew14/hJLsCLZCe0+RCs5a2gCkX7
         TPvA==
X-Gm-Message-State: AOJu0YxpQ90u78dj74/WrYfLC+cNR0deLASKDRiUxtpgfc8bG/fBwK/e
        dTLCxl3dErg8TWBtXL9OFIg+OVmglCQ3tsdUzQpgJSDr/j4p7tSk63o0mIC7to13Jtn179wWil0
        2NModO6OZR1RL0+vBvLDwKGVSXiIW3lHPt7NzaBMm
X-Received: by 2002:a05:651c:222:b0:2bd:21ea:bf0a with SMTP id z2-20020a05651c022200b002bd21eabf0amr451713ljn.2.1694681076823;
        Thu, 14 Sep 2023 01:44:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGXqn21JqRoVZAD9wyDGrdj8us8mB1oFCjJnoTd+pLrivjCjNMTde5cowMo0QmOqovM5UnTzu5V+YMsAf2QB/w=
X-Received: by 2002:a05:651c:222:b0:2bd:21ea:bf0a with SMTP id
 z2-20020a05651c022200b002bd21eabf0amr451699ljn.2.1694681076529; Thu, 14 Sep
 2023 01:44:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115316.3652155-1-leitao@debian.org> <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZIxrxpYtffT0FtEx@gmail.com> <100041d0-f2fe-331b-13a7-ad09082aeb7d@gmail.com>
 <20230616153221.GI4253@hirez.programming.kicks-ass.net> <CAE4VaGBbKC+KgX-drhnc-nHsBo_DfcX4yZWBsNvrULiV3+Li1A@mail.gmail.com>
 <ada0da4e-4260-47c0-897f-09e3e1e1658e@amd.com>
In-Reply-To: <ada0da4e-4260-47c0-897f-09e3e1e1658e@amd.com>
From:   Jirka Hladky <jhladky@redhat.com>
Date:   Thu, 14 Sep 2023 10:44:25 +0200
Message-ID: <CAE4VaGA7kjMw8rWk3cvktGmwjjkwwrHPSrY80Ozjsc=7TvQmAg@mail.gmail.com>
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Breno Leitao <leitao@debian.org>,
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
        <linux-kernel@vger.kernel.org>, ananth.narayan@amd.com,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Michael Petlan <mpetlan@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sandipan,

here is the info from /proc/cpuinfo

vendor_id       : AuthenticAMD
cpu family      : 25
model           : 160
model name      : AMD EPYC 9754 128-Core Processor
stepping        : 2
microcode       : 0xaa0020f

>2. Microcode patch level
Is it the microcode string from cpuinfo provided above, or are you
looking for something else?

Thanks!
Jirka


On Wed, Sep 13, 2023 at 6:19=E2=80=AFPM Sandipan Das <sandipan.das@amd.com>=
 wrote:
>
> Hi Jirka,
>
> Can you please share the following?
>
> 1. Family, Model and Stepping of the processor
> 2. Microcode patch level
> On 9/13/2023 8:00 PM, Jirka Hladky wrote:
> > Hi Sandipan,
> >
> > Is there any update on this issue? We have hit the issue, and it makes
> > the server pretty unusable due to the thousands of Call Traces being
> > logged.
> >
> > Thanks a lot!
> > Jirka
> >
> >
> > On Fri, Jun 16, 2023 at 5:34=E2=80=AFPM Peter Zijlstra <peterz@infradea=
d.org> wrote:
> >>
> >> On Fri, Jun 16, 2023 at 08:13:22PM +0530, Sandipan Das (AMD) wrote:
> >>> The reserved bits should never be set. The purpose of the WARN_ON() i=
s to catch such anomalies.
> >>> I am working out the details with Breno and will report back with a r=
esolution.
> >>
> >> Thanks!
> >>
> >
> >
>


--=20
-Jirka

