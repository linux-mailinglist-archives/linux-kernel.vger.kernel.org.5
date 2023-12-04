Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883FA8041D3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 23:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjLDWqp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 4 Dec 2023 17:46:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234255AbjLDWqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 17:46:43 -0500
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9138A9B;
        Mon,  4 Dec 2023 14:46:49 -0800 (PST)
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1901720a12.0;
        Mon, 04 Dec 2023 14:46:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701730009; x=1702334809;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LwdYS3W7LrNgkr4g+R3rXOTMxy7LyncKsnMZAwvDxzA=;
        b=OSHrbVPDciijAzOaY3+sreYE3LmiSUC3WFrGdv9aku/jm0RaxNNommO3PnVczzHxGX
         vcT/OWOV6gGXceQDzIOJlzGW7Nf/NQI9MZe+1Wr8/gXutBrsMmf+meLnR9ZU7cycm4G5
         P6QOmGBCxX6Ujzcjquvz9Sk2TXGl8kSUQqsALOV5YNmwJisGnPEO+HH1NnbbWb00wMd7
         o1DfPx7qVKzc92i6pYoTEWXUwzxYVDCXCJX/QQbb8TXX4eoVq0I69vhTh4Rc0vXbrX4u
         sEPt78mHMTPbq6K2sA8JTnoSCieqT47yusu5KteG+KblMHkK6qRuwGh2uK1swShyJtoY
         GaAQ==
X-Gm-Message-State: AOJu0YyHHXUNehOvQcT9tqvHq0g+uwGzxTiDjfgA7AVN5T8aBJZi/vtv
        TPlcfOfWVyoIVUYTEj+pQgZYrk6HN760SlQZ+oQ=
X-Google-Smtp-Source: AGHT+IGUFco2rR/+xB69zGaID+AA+8euhHgTNPvXTxjMib4H74P51lc8L80pWnSmaEW0XTIenuSeqbXh6fE8vtkDrzU=
X-Received: by 2002:a05:6a20:8f15:b0:18c:159b:777 with SMTP id
 b21-20020a056a208f1500b0018c159b0777mr31046328pzk.26.1701730008727; Mon, 04
 Dec 2023 14:46:48 -0800 (PST)
MIME-Version: 1.0
References: <20231128175441.721579-1-namhyung@kernel.org> <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com> <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
In-Reply-To: <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Mon, 4 Dec 2023 14:46:37 -0800
Message-ID: <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 30, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Nov 29, 2023 at 3:56 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > Hi Ian,
> >
> > On Tue, Nov 28, 2023 at 11:14 AM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Tue, Nov 28, 2023 at 9:54 AM Namhyung Kim <namhyung@kernel.org> wrote:
> > > >
> > > > Hello,
> > > >
> > > > It used to have annotation_options for each command separately (for
> > > > example, perf report, annotate, and top), but we can make it global as
> > > > they never used together (with different settings).  This would save
> > > > some memory for each symbol when annotation is enabled.
> > > >
> > > > This code is available at 'perf/annotate-option-v1' branch in
> > > >
> > > >   git://git.kernel.org/pub/scm/linux/kernel/git/namhyung/linux-perf.git
> > > >
> > > > Thanks,
> > > > Namhyung
> > >
> > > Thanks for doing this and I think it is progress. I think there is a
> > > common problem with having things be an option rather than say part of
> > > session. Having a global variable seems unfortunate but I'm not sure
> > > if in all locations we have easy access to the session.
> >
> > That's not the case when you deal with hist entry or TUI browser.
> > I think that's the reason we have the option in the annotation.
> >
> >
> > > The rough
> > > structure with annotations as I understand it is:
> > >
> > > session has machines
> > > a machine has dsos
> > > a dso has symbols
> > > a symbol has an annotation
> >
> > That's true.  But the annotation struct is used only if
> > symbol__annotation_init() is called.
>
> Right. I find this approach likely to lead to errors, such as a symbol
> created globally before symbol__annotation_init() was called breaking
> the container_of assumptions.

Sure, but that's a different issue.  Maybe we can add a hash table
to map a symbol to annotation or annotated_source directly.  But
I don't think we need annotation_option for each symbol/annotation.

>
> > >
> > > Annotation is something of unfortunate abstraction as it covers things
> > > like an IPC per symbol (why hard code to just IPC?) and things like
> > > source files and line numbers.
> >
> > Right, that's why I splitted the struct annotated_branch.
> >
> > >
> > > A recent success story where we got rid of a configuration variable
> > > was by switching to lazy allocation with sorting by name for symbols
> > > within a dso. If we could have a lazy allocation model with
> > > annotations then maybe we can do away with large hammers like global
> > > options.
> >
> > Maybe I can move the pointer to option into the annotated_source
> > which is allocated lazily.  But I don't think it needs to keep the option
> > for each symbol or annotation.  It's usually to control some display
> > behaviors in the disasm output globally.  So I think it's better to have
> > a global variable.
>
> Sgtm. My point wasn't to criticize, I think this is a good change, I
> was just trying to imagine doing things in a way that could overall
> reduce complexity

Yep, thanks for your review.  Can I get your ACKs? :)
Namhyung
