Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBCA98120F9
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 22:54:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234122AbjLMVym convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 13 Dec 2023 16:54:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234018AbjLMVyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 16:54:32 -0500
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 598A5107;
        Wed, 13 Dec 2023 13:54:29 -0800 (PST)
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c21e185df5so6432333a12.1;
        Wed, 13 Dec 2023 13:54:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702504468; x=1703109268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/V92WNigxkpLHvd6G9qdAoFEF4im8xTNaGvtCA5qz2k=;
        b=KVR1PfYXAj7QkdKWSlqDLFklgZiD1aHzzRnfgNPIEMpq4MZrqCYiuEZyp8h8SQLbb2
         uU7vDHdtjyApGdhVM5Q5yxr4OxwThis8EJgOiwWpzneP+EEK+W0ZgWrCxSfBSIYrUP2V
         lPWXCRGnnbElAuBHwNbPqIODigdH1vsN4rV8YzBOHfSpBdBlOqiVV7N4Vgc1yD83ik+h
         ne6ceI8MfIVmyFrO+I2tuUcfT7/zi8/sg5Dah+D51WPNG4mYd1hpudyV0hiHwWs51QPX
         YI+z4uVNfCAMJAh6PrAoPrZ7CU5a0hquff3KCHWwvMPkj83TF5/0e51/07/TnwgTAOFu
         BM9w==
X-Gm-Message-State: AOJu0YwQhPZ+3q3ct0GS1Affu58HBYXMsLflnkj/h/7mfLDZjBM4TcOB
        /Gs1MW7f+oLz3ioQGcG/YYOpDpyhmyQF0Cs7myxagWDpyHg=
X-Google-Smtp-Source: AGHT+IHcxKHf+UJp4ADzr61NX+GW5A7CImLhki/3W/mJD4VdSapx1lgkzQXU0gtND1OJafmZp6zoC71T7CATJEtzYLA=
X-Received: by 2002:a17:90a:ad85:b0:286:ab9d:c6be with SMTP id
 s5-20020a17090aad8500b00286ab9dc6bemr6657432pjq.16.1702504468420; Wed, 13 Dec
 2023 13:54:28 -0800 (PST)
MIME-Version: 1.0
References: <20231212193833.415110-1-kan.liang@linux.intel.com>
 <CAP-5=fWCgjCC-DHHx+HJCuYk6vNn9Lf9EKcnBBZQ+xmnyYnmPg@mail.gmail.com>
 <996ec30b-2bcf-4739-bec0-728c7f7af2ac@linux.intel.com> <CAP-5=fVnH0eTEvvNbKLF9xYye5Pu8hvDL4ruoxh5xG76+B8WFQ@mail.gmail.com>
 <CAM9d7chQ4NbbcmumQSMRaGm987nxxh6_QbbJr7+GYgL_WAmaNw@mail.gmail.com>
 <43e57041-fe13-452a-af6e-db2ed451f93a@linux.intel.com> <CAP-5=fXHadLYuRkY2Z=kymWJkB63dBWfCibQJnwgt0wkSuVVsg@mail.gmail.com>
In-Reply-To: <CAP-5=fXHadLYuRkY2Z=kymWJkB63dBWfCibQJnwgt0wkSuVVsg@mail.gmail.com>
From:   Namhyung Kim <namhyung@kernel.org>
Date:   Wed, 13 Dec 2023 13:54:17 -0800
Message-ID: <CAM9d7cjW-DpV_-eHTBJC08he9dou06GWqBN+UWcjtTf_T3Qf=g@mail.gmail.com>
Subject: Re: [PATCH V2] perf top: Use evsel's cpus to replace user_requested_cpus
To:     Ian Rogers <irogers@google.com>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, acme@kernel.org,
        mark.rutland@arm.com, maz@kernel.org, marcan@marcan.st,
        linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org
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

On Wed, Dec 13, 2023 at 9:42 AM Ian Rogers <irogers@google.com> wrote:
>
> On Wed, Dec 13, 2023 at 7:45 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> >
> >
> >
> > On 2023-12-12 8:06 p.m., Namhyung Kim wrote:
> > > On Tue, Dec 12, 2023 at 2:12 PM Ian Rogers <irogers@google.com> wrote:

> > >> If my memory serves there was a patch where perf top was showing >1
> > >> event. It would be nice here to do some kind of hybrid merging rather
> > >> than having to view each PMU's top separately.
> >
> > The current perf top doesn't merge when there are >1 event.
> > sudo ./perf top -e "cycles,instructions"
> >
> > Available samples
> > 2K cycles
> >
> > 2K instructions
> >
> > For now, I think we may just append a PMU name to distinguish the hybrid
> > case.
> >
> > We may implement the merging feature which impacts both hybrid and
> > non-hybrid cases later separately.
> >
> > >
> > > Using event groups, but I noticed you removed the --group option.
> > > Maybe perf top can just use `{ ... }` notation for explicit grouping,
> > > but it might be implicit like in the hybrid case.
> > >
> >
> > Yes, if the events are from different PMUs, the perf tool will
> > implicitly de-group the hybrid events. "{ ... }" may not help here.
>
> I think grouping may have been the situation where I saw >1 event
> displayed but I agree with Kan, we implicitly de-group events on
> different PMUs so it won't help here.

The --group option was implemented in perf report which means
it doesn't matter if events are in different PMUs.  It's just to display
the results together.

Thanks,
Namhyung
