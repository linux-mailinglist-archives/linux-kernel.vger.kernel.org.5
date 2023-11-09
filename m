Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A597E6339
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 06:36:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231382AbjKIFgc convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 9 Nov 2023 00:36:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjKIFga (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 00:36:30 -0500
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49142696;
        Wed,  8 Nov 2023 21:36:27 -0800 (PST)
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2809414efa9so426009a91.1;
        Wed, 08 Nov 2023 21:36:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699508187; x=1700112987;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Lyzr7hVIacpaiFpBTLCUkDtovxAyidEihkZOQP1i5dI=;
        b=Yo9B+h0P3sQ/Po2azyyO7gJpj28R5xWcsY7kiZwpG2ZOCwhwSRzuMKVhbFGC7fOHWY
         CJ6z958L9jCKs8m1Iniz40WU6pkQu8Izwnbte9x9e0n3biyqmWoX8a2gH4aOZI4+Mz0d
         /Iu4RHBGExbwMkNJFW3yQv0WWgesPxy+5e/ls0u1N7IxLFvmh6JuNM050uYiKqpsGx3V
         NIIWzPjq5KmXflMpdL8m7SOJNMUXZod96bypXmyeX2eXO22xLoMq8Hye8Y3SDpwfEfNM
         sYhXMKkJwQkkY+AW+eiNwLqvoE7/3ViDxpp7RVcwnVg2ryLSATYC4rIlA+NSMxYhe0hf
         snIQ==
X-Gm-Message-State: AOJu0YxkiCf2D4+1GDpIqgzxi+qmji0BTItqQE7HJpoHquHKItsoPCMz
        JtyMBpiHw2doqT7TjbmTPgymXvbgmtM+7c+qpQw=
X-Google-Smtp-Source: AGHT+IHuz0K8LgffQfNoisCS7G9CiZAZlxMM5myUnjO6lx4R0dGZwysVVLNy2VrC3NGDhwJFZ60PmQ6dyRfOb0yrE54=
X-Received: by 2002:a17:90b:4f89:b0:27d:a14c:eba6 with SMTP id
 qe9-20020a17090b4f8900b0027da14ceba6mr721279pjb.21.1699508186934; Wed, 08 Nov
 2023 21:36:26 -0800 (PST)
MIME-Version: 1.0
References: <20231012035111.676789-1-namhyung@kernel.org> <20231012035111.676789-29-namhyung@kernel.org>
 <20231107002523.f0643720eac144841dedb8a4@kernel.org>
In-Reply-To: <20231107002523.f0643720eac144841dedb8a4@kernel.org>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 8 Nov 2023 21:36:15 -0800
Message-ID: <CAM9d7cjQbqEY6eJZK_2we_yJmRp7V0=+xn_m0d7cAUOo7SSFig@mail.gmail.com>
Subject: Re: [PATCH 28/48] perf dwarf-aux: Add die_find_variable_by_addr()
To:     Masami Hiramatsu <mhiramat@kernel.org>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 6, 2023 at 7:25 AM Masami Hiramatsu <mhiramat@kernel.org> wrote:
>
> On Wed, 11 Oct 2023 20:50:51 -0700
> Namhyung Kim <namhyung@kernel.org> wrote:
>
> > The die_find_variable_by_addr() is to find a variables in the given DIE
> > using given (PC-relative) address.  Global variables will have a
> > location expression with DW_OP_addr which has an address so can simply
> > compare it with the address.
> >
> >   <1><143a7>: Abbrev Number: 2 (DW_TAG_variable)
> >       <143a8>   DW_AT_name        : loops_per_jiffy
> >       <143ac>   DW_AT_type        : <0x1cca>
> >       <143b0>   DW_AT_external    : 1
> >       <143b0>   DW_AT_decl_file   : 193
> >       <143b1>   DW_AT_decl_line   : 213
> >       <143b2>   DW_AT_location    : 9 byte block: 3 b0 46 41 82 ff ff ff ff
> >                                      (DW_OP_addr: ffffffff824146b0)
> >
> > Note that the type-offset should be calculated from the base address of
> > the global variable.
> >
> > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
>
> Looks good to me.
>
> Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
>
> BTW, for the global variable, you can also find it via maps. Can't you?

What do you mean by 'via maps'?  The map in perf?

Thanks,
Namhyung
