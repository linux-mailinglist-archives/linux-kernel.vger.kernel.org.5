Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C367BD2D2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 07:29:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345117AbjJIF3S convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 9 Oct 2023 01:29:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345049AbjJIF3Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 01:29:16 -0400
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DC909E;
        Sun,  8 Oct 2023 22:29:15 -0700 (PDT)
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-27740ce6c76so2364672a91.0;
        Sun, 08 Oct 2023 22:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696829354; x=1697434154;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vr/F+bCfSklSZ5y08IwzckZb9rJ4zF5BksIsHEdUNU0=;
        b=Kyv0YlLheoIHRnDjd2PNm7dCqBaPzaOui7gze85f9jri92YobwdneYrJbupminq12k
         xSjDTed65cNUxshugxdntBdInoz4fRg2c6UvYoYmAXIUh+j/nTtW4AGoWYTsECBoLE1I
         aECH7RCoK0uewvAdgmQBt2GsaJaCyR6IMKlBnL3PQAnH6SnkoOFTPcMwR6YbKdyGTfOZ
         X+yyN3bH7o3Gqqi3z98aVYEYiv+BQWVTeKqqwgKYdaDaoHe4P4otUuF0G2DhHaAjK2ud
         tsV4CHzs4hvlduozbwUaiKJDJLiqMljh/N2V1WZMKpeR0LDz42c1RIIQvExWuz4HoenG
         JzXQ==
X-Gm-Message-State: AOJu0YxZfFJWS7M42jH4wMsP5v21GpBScDMDa0WoFLFkgEWgjPlZW7ZQ
        FJT0BV6G6R6Ui1exGlXogYiOg1vrpPSz4n1Aelw=
X-Google-Smtp-Source: AGHT+IFjuFOwAwgsbfljMcjBSoN7dfnQTS3qqskI6Sm1oinsBVThEl8w00q+fWuQEJaIjhJW6PRA73xKJHQDET5JRro=
X-Received: by 2002:a17:90b:4c87:b0:26d:416a:d9d0 with SMTP id
 my7-20020a17090b4c8700b0026d416ad9d0mr11350450pjb.21.1696829354575; Sun, 08
 Oct 2023 22:29:14 -0700 (PDT)
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com> <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
In-Reply-To: <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Sun, 8 Oct 2023 22:29:03 -0700
Message-ID: <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com>
Subject: Re: [PATCH v1] perf intel-pt: pkt-decoder: Fix alignment issues
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Jiri Olsa <jolsa@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Liam Howlett <liam.howlett@oracle.com>,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 5, 2023 at 2:24 PM Ian Rogers <irogers@google.com> wrote:
>
> On Thu, Oct 5, 2023 at 12:06 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> >
> > On 5/10/23 18:48, Ian Rogers wrote:
> > > On Mon, Oct 2, 2023 at 3:19 PM Ian Rogers <irogers@google.com> wrote:
> > >>
> > >> The byte aligned buffer is cast to large types and dereferenced
> > >> causing misaligned pointer warnings from undefined behavior sanitizer.
> > >> Fix the alignment issues with memcpy which may require the
> > >> introduction of temporaries.
> > >>
> > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > >> ---
> > >
> > > This is a relatively small change that fixes building with
> > > -fsanitize=alignment -fsanitize-undefined-trap-on-error. Adrian, as
> > > this is Intel-PT could you take a look?
> >
> > Thanks! This has been down my list of things to do for ages,
> > but using get_unaligned_le16() etc seems nicer.  I sent a patch
> > set for that.
>
> Thanks Adrian! Your patch set looks good and I think after Arnaldo's
> comment is addressed we should go with it.

I think it can be done as a later step as long as the interface is the
same.  Can I add your Ack's to the Adrian's patchset?

Thanks,
Namhyung
