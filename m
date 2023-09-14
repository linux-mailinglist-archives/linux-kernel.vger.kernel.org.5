Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40A2B7A03A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 14:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238254AbjINMWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 08:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234522AbjINMWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 08:22:01 -0400
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 894241FC0;
        Thu, 14 Sep 2023 05:21:57 -0700 (PDT)
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-99bcf2de59cso126164866b.0;
        Thu, 14 Sep 2023 05:21:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694694116; x=1695298916;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=t7IZyQdVtdbZHBl3wbHmMmV0IyMQ1PCAgLkaTrOg3sE=;
        b=sQNhs10XLk5p7xw2N0jdYXI6FFrcn2Y5yE4X7M1MbUjUiVO1jVGMsDLu9mI9W+cYii
         xObKAEoRzdMJA+ZrkcUrILIKe0iczsZNx/2f5GLmaFmMZ3xlt3nrt9GIsgmUfGjhVaKA
         CEtJcJE40usjloteabY9gHvvli6tZRLKozgyA1+XHUDJjySrooyaaAiccU1WQiybsVwv
         NtxrjydZ26HYD0+OTdyHIX/9emblrK9z6hvSVFk/VS1qkae8zy3OKT6d2ivhrMpN3CZL
         b6kI+x1mXF2yBFW9s7x0ZuOlXBZgD+dSuP81ZttTdtle3qddjyAxeE2X5wJoH0yBiQHy
         YEIw==
X-Gm-Message-State: AOJu0Yw5zjOPRcP6xKp6/ri2Ri6RKU8IAaZ8Di7737N3bC/FsFaQMREt
        SzS2uOAHNsPV9WEZSwslzyk=
X-Google-Smtp-Source: AGHT+IG0bnHHFEZfZ7GHwVT4Ornajhheg2FbtdodFZ113wx0S64+lBqLosjcparSy/cI7k0DIT+Mgw==
X-Received: by 2002:a17:907:7742:b0:9a5:d657:47ee with SMTP id kx2-20020a170907774200b009a5d65747eemr4753065ejc.58.1694694115763;
        Thu, 14 Sep 2023 05:21:55 -0700 (PDT)
Received: from gmail.com (fwdproxy-cln-012.fbsv.net. [2a03:2880:31ff:c::face:b00c])
        by smtp.gmail.com with ESMTPSA id t25-20020a1709064f1900b009ad8084e08asm947925eju.0.2023.09.14.05.21.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Sep 2023 05:21:55 -0700 (PDT)
Date:   Thu, 14 Sep 2023 05:21:53 -0700
From:   Breno Leitao <leitao@debian.org>
To:     Sandipan Das <sandipan.das@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jirka Hladky <jhladky@redhat.com>,
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
Subject: Re: [PATCH] perf/x86/amd: Do not WARN on every IRQ
Message-ID: <ZQL64dX+5lfK4rOh@gmail.com>
References: <20230616115316.3652155-1-leitao@debian.org>
 <20230616132954.GG4253@hirez.programming.kicks-ass.net>
 <ZQHiJxHSSGNk+ul5@gmail.com>
 <CAE4VaGBXO5Joynan_o13XpT=mNrwt4D84NTZF6H62GXJjpMbBA@mail.gmail.com>
 <f06ef3dd-dd71-4ba4-a4fa-18a08788c035@amd.com>
 <20230914091234.GE16631@noisy.programming.kicks-ass.net>
 <ZQLSw6PeUbV+p2gH@gmail.com>
 <20230914111845.GF16631@noisy.programming.kicks-ass.net>
 <b1cf5990-1019-49ea-a1e8-e22410922801@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b1cf5990-1019-49ea-a1e8-e22410922801@amd.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 14, 2023 at 04:52:13PM +0530, Sandipan Das wrote:
> On 9/14/2023 4:48 PM, Peter Zijlstra wrote:
> > On Thu, Sep 14, 2023 at 02:30:43AM -0700, Breno Leitao wrote:
> >> On Thu, Sep 14, 2023 at 11:12:34AM +0200, Peter Zijlstra wrote:
> >>> On Thu, Sep 14, 2023 at 02:25:40PM +0530, Sandipan Das wrote:
> >>
> >>>> I agree with using WARN_ON_ONCE() to make this less intrusive.
> >>>
> >>> Could you send a patch that AMD is happy with?
> >>
> >> Why the current patch is not good enough?
> > 
> > Sandipan, can you answer this? I don't tihnk I'm qualified to speak for
> > the AMD pmu and certainly I don't have insight into their design future.
> 
> Hi Breno,
> 
> Functionally, the patch looks good to me and I will be reusing it
> without any change to the authorship. However, as Peter suggested, I
> wanted to add a message to prompt users to update the microcode and
> also call out the required patch levels in the commit message since
> different Zen 4 variants and steppings use different microcode.
> 
> Here's what I plan to send.

Awesome. Thanks for addressing it.
