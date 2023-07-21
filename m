Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3C2275C488
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231992AbjGUKW0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:22:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230384AbjGUKWJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:22:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F08830F0;
        Fri, 21 Jul 2023 03:21:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 06A27618AC;
        Fri, 21 Jul 2023 10:21:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96278C433C7;
        Fri, 21 Jul 2023 10:21:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689934899;
        bh=H8POZOfX8besCzfb+R2Af8o5NH3RWaYoXAhuHVlzDWI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VbmaRk5gsNQiIzh9mDHq/Ide82FIOBdDLshzMR0m5hFPnfc+g/QXkO7IrSov11nB2
         tUaTeHjAoniOnZwpvnmuaffj8SBXdLqAPIBhXhZZnnv8gz9OeejASdREr15SIHxf9W
         e4m8nUXE/KIGg3zQGX63qmABM6/0Rg6hkhzPqPydKyrjstV2JPU0GLLJqoN+r2jKjE
         AEEh/yKYjEgWeyyx/3iw0qRtki+hi97Um+Lp7U+lfFRhSdtN2ebS+WcYl6/NkdGXcR
         2/NIta67icXLsKPiYIw4dJR8BX0uakCFximn4sUMz4WO4y/Sfy0Q/bqIiHlKpOZ/35
         6dNPvpL3zC14w==
Date:   Fri, 21 Jul 2023 11:21:31 +0100
From:   Will Deacon <will@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     James Clark <james.clark@arm.com>, linux-kernel@vger.kernel.org,
        Mark Rutland <mark.rutland@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        linux-perf-users@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@kernel.org>
Subject: Re: [PATCH 1/4] arm_pmu: Add PERF_PMU_CAP_EXTENDED_HW_TYPE capability
Message-ID: <20230721102131.GA12457@willie-the-truck>
References: <20230710122138.1450930-1-james.clark@arm.com>
 <20230710122138.1450930-2-james.clark@arm.com>
 <e111d9ac-c4f6-c541-313b-7a3a6acfb5d2@arm.com>
 <597f53e0-5a5b-75a1-4054-253630a941f2@arm.com>
 <CAP-5=fVpjJLBNCd4LJ7krX1tpqUT-S_DCRebXR1ioTCGFsF6Pw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fVpjJLBNCd4LJ7krX1tpqUT-S_DCRebXR1ioTCGFsF6Pw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 20, 2023 at 10:12:21AM -0700, Ian Rogers wrote:
> On Tue, Jul 11, 2023 at 7:12 AM James Clark <james.clark@arm.com> wrote:
> >
> >
> >
> > On 11/07/2023 13:01, Anshuman Khandual wrote:
> > >
> > >
> > > On 7/10/23 17:51, James Clark wrote:
> > >> This capability gives us the ability to open PERF_TYPE_HARDWARE and
> > >> PERF_TYPE_HW_CACHE events on a specific PMU for free. All the
> > >> implementation is contained in the Perf core and tool code so no change
> > >> to the Arm PMU driver is needed.
> > >>
> > >> The following basic use case now results in Perf opening the event on
> > >> all PMUs rather than picking only one in an unpredictable way:
> > >>
> > >>   $ perf stat -e cycles -- taskset --cpu-list 0,1 stress -c 2
> > >>
> > >>    Performance counter stats for 'taskset --cpu-list 0,1 stress -c 2':
> > >>
> > >>          963279620      armv8_cortex_a57/cycles/                (99.19%)
> > >>          752745657      armv8_cortex_a53/cycles/                (94.80%)
> > >>
> > >> Fixes: 55bcf6ef314a ("perf: Extend PERF_TYPE_HARDWARE and PERF_TYPE_HW_CACHE")
> > >> Suggested-by: Ian Rogers <irogers@google.com>
> > >> Signed-off-by: James Clark <james.clark@arm.com>
> 
> Hi ARM Linux and ARM Linux PMU people,
> 
> Could this patch be picked up for Linux 6.5? I don't see it in the
> tree and it seems a shame to have to wait for it. The other patches do
> cleanup and so waiting for 6.6 seems okay.

I'm only taking fixes for 6.5 and I don't think this qualifies.

If it was an oversight introduced during the recent merge window, then
I'd be happier fixing it up, but 55bcf6ef314a was merged ages ago (v5.12?),
so I think we can wait.

I'll be queuing perf changes for 6.6 next week, so I'll look at this
then.

Cheers,

Will
