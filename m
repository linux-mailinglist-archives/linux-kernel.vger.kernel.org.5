Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B1D7C497E
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 07:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344179AbjJKF4Q convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 11 Oct 2023 01:56:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344216AbjJKF4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 01:56:15 -0400
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C25C19D;
        Tue, 10 Oct 2023 22:56:13 -0700 (PDT)
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-58e119bb28eso487263a12.1;
        Tue, 10 Oct 2023 22:56:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697003773; x=1697608573;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S9baY0raJWT0UxO3DXGBjth97e+wvq2TLwcz5cGk19I=;
        b=UPwf7yQGKT89ATne28cV4g2h0fepAhtI7Wy1h6Cq5CwJVCm03i6CtCLBbqX5DucvsF
         EZYZzCtyuHi8iwTnlOV85AsoTmm3eUqKiNuyhMOU/Ee93pWcaiZaPimbqTYf3PC/iPjl
         WWbwgaaPOk4ZEw3KwiH1ZHYiolwL38SM5X6K3hvPY28dltkIzwnzKs6GH2wi8HaN5OqH
         8Re93PvtfDj1t+u/yHTN8oYqlThn3IPrS6YOiImrGlgc8Z1GTn6QOnRyA3rAeINhOvqn
         Eg+q2rccC75Lg6YpuGhkXWqgsF5bU3vxvd9zgvCRUt5OS0I/+1hqJ42ZGzqPTp0aMu9x
         /zTg==
X-Gm-Message-State: AOJu0Yw8KkLIX146h1o3xyOOeXeDHbzC6F2NUnMx6EKdiT8vmo6KmTBe
        kk8WzY1rPZ1xlV0QkxHMAMJfAprX+8/rVP6Bi/A=
X-Google-Smtp-Source: AGHT+IGucUyht1bByNKOC94VYeNc/FSTLZAd6PXQOBPgJeXOrs4i/XQzSfmEcCzVhRvUVUxj3XkdAavcAaancrUUYvs=
X-Received: by 2002:a17:90a:4892:b0:27c:ecec:8854 with SMTP id
 b18-20020a17090a489200b0027cecec8854mr5722823pjh.7.1697003772775; Tue, 10 Oct
 2023 22:56:12 -0700 (PDT)
MIME-Version: 1.0
References: <20231002221909.2958708-1-irogers@google.com> <CAP-5=fX-VOeCkOJY5xeW67x0+A0tGAHM4VYBBz46L-g2eRCR+w@mail.gmail.com>
 <93afcf44-5f8b-49c1-abc5-5304cba5f991@intel.com> <CAP-5=fXzcR6QKKhFG5PS1pFYi5JsO4AOUoH_-Bv0O+11YzEkkw@mail.gmail.com>
 <CAM9d7cjQZvZm+Vyrx9PTUYMFN5RjE+i-Kq1kbffyVp2hGKF6sg@mail.gmail.com> <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com>
In-Reply-To: <CAP-5=fUo-vuLofC4jgHC9z=BTe80OEiY_PoQWqQtyVdvHcf+KQ@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Tue, 10 Oct 2023 22:56:01 -0700
Message-ID: <CAM9d7cjdb5WE-xdSdKD=p_EtsS7OSVEWL+GL3RVwczu-+1JvFQ@mail.gmail.com>
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

On Mon, Oct 9, 2023 at 8:31 AM Ian Rogers <irogers@google.com> wrote:
>
> On Sun, Oct 8, 2023 at 10:29 PM Namhyung Kim <namhyung@kernel.org> wrote:
> >
> > On Thu, Oct 5, 2023 at 2:24 PM Ian Rogers <irogers@google.com> wrote:
> > >
> > > On Thu, Oct 5, 2023 at 12:06 PM Adrian Hunter <adrian.hunter@intel.com> wrote:
> > > >
> > > > On 5/10/23 18:48, Ian Rogers wrote:
> > > > > On Mon, Oct 2, 2023 at 3:19 PM Ian Rogers <irogers@google.com> wrote:
> > > > >>
> > > > >> The byte aligned buffer is cast to large types and dereferenced
> > > > >> causing misaligned pointer warnings from undefined behavior sanitizer.
> > > > >> Fix the alignment issues with memcpy which may require the
> > > > >> introduction of temporaries.
> > > > >>
> > > > >> Signed-off-by: Ian Rogers <irogers@google.com>
> > > > >> ---
> > > > >
> > > > > This is a relatively small change that fixes building with
> > > > > -fsanitize=alignment -fsanitize-undefined-trap-on-error. Adrian, as
> > > > > this is Intel-PT could you take a look?
> > > >
> > > > Thanks! This has been down my list of things to do for ages,
> > > > but using get_unaligned_le16() etc seems nicer.  I sent a patch
> > > > set for that.
> > >
> > > Thanks Adrian! Your patch set looks good and I think after Arnaldo's
> > > comment is addressed we should go with it.
> >
> > I think it can be done as a later step as long as the interface is the
> > same.  Can I add your Ack's to the Adrian's patchset?
>
> I think addressing Arnaldo's comment:
> https://lore.kernel.org/lkml/ZR8QnasisGEsaaDR@kernel.org/
> will need some changes to the patch series, and so I was waiting to
> see the outcome of that.

It seems it's done without further changes.  Can I get your Ack's now?

Thanks,
Namhyung
