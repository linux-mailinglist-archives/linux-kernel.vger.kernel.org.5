Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364087E6E4E
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 17:11:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232101AbjKIQLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 11:11:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbjKIQLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 11:11:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AA0730F9
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 08:11:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA071C433C7;
        Thu,  9 Nov 2023 16:11:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699546261;
        bh=C7jR2LQ8Z/vOJmqohoUAFoWt6yaYYGfydMvsWCPU5Xc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DroV/pppoEy9af18cjZfiWHM5mA82YjI/c8VWbbVOrCvkb1pUPQqxzUpFTVbxPDj5
         WMvVyGBbHB2E8u4q6tZRslFV1677Q8B7+Gp3bTDeX++w8xCBiI/cCM/Mr9D5KVqgNz
         vsJ4/k7xBZx2Sr4CZXDMaPEvQNW3e5LJkWluClpd0k/5zSaZuIjbRIhdinOU9lvjP+
         wWtS/03iQNjKPOpkFjPYrUhebm7vnyVI3EbcNVvzA63Fv3c/Z9ozvOHRlCleBJckwm
         4gV+lZEDID3DIRLqFssfWI6ffhsVvm4BTGaEcQI/Fot4m7rQ0luQPnAk/20/uUQ8fI
         Xxcq+sRbD7sqA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0BECC40094; Thu,  9 Nov 2023 13:10:59 -0300 (-03)
Date:   Thu, 9 Nov 2023 13:10:58 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Song Liu <song@kernel.org>
Cc:     Ian Rogers <irogers@google.com>, Song Liu <songliubraving@fb.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 12/53] perf bpf: Don't synthesize BPF events when
 disabled
Message-ID: <ZU0Ekh3mrHZImqqk@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-13-irogers@google.com>
 <ZUuz/8EC0orXCffn@kernel.org>
 <CAPhsuW4ftvoUFnNfcZgBg7=SeaHmev7roFnix=+c+zSq3LawFQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPhsuW4ftvoUFnNfcZgBg7=SeaHmev7roFnix=+c+zSq3LawFQ@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 08, 2023 at 03:03:15PM -0800, Song Liu escreveu:
> On Wed, Nov 8, 2023 at 8:15 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> >
> > Em Thu, Nov 02, 2023 at 10:56:54AM -0700, Ian Rogers escreveu:
> > > If BPF sideband events are disabled on the command line, don't
> > > synthesize BPF events too.
> >
> >
> > Interesting, in 71184c6ab7e60fd5 ("perf record: Replace option
> > --bpf-event with --no-bpf-event") we checked that, but only down at
> > perf_event__synthesize_one_bpf_prog(), where we have:
> >
> >         if (!opts->no_bpf_event) {
> >                 /* Synthesize PERF_RECORD_BPF_EVENT */
> >                 *bpf_event = (struct perf_record_bpf_event)
> >
> >
> > So we better remove that, now redundant check? I'll apply your patch as
> > is and then we can remove that other check.
> >
> > Song, can I have your Acked-by or Reviewed-by, please?
> >
> > - Arnaldo
> >
> > > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Good catch!
> 
> Acked-by: Song Liu <song@kernel.org>

Thanks, applied the patch with your Acked-by, will revisit this after
this gets published.

- Arnaldo
