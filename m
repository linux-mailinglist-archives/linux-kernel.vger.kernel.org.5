Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2019A801481
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 21:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379578AbjLAUbt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 15:31:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjLAUbs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 15:31:48 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7638FA
        for <linux-kernel@vger.kernel.org>; Fri,  1 Dec 2023 12:31:54 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5838EC433C7;
        Fri,  1 Dec 2023 20:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701462714;
        bh=z/OnjOkeegk98Wwk1WM2bdsYJshNJg8GFxorFqdXSKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BPTGLbsZyiNL4OzphPVONfiUwYIDYa/5IVrg4uL/6aK33VKklVYt3XLZu4s5xWer8
         tNdJnKTvqNn41aaF150j6NMm3DGre9e3+Jd0RIpgdz2b1STfxEKdjMvvYqdkuL8h/n
         v5ZQWyafDABiCJXdodD3xrS8amlqyhWeTAG8xIoni/1Fgzr4nunJEtH/v4d5f9P6Cb
         KHdB48eY2Zgk0tqlJ2uPQP3qnxOXN0R+lXVt5/g1xFICzIggigIV2VNdUInq50oqEL
         YVPft9eGD692HWXbB5i4NMc5vytlRZIxuXAQDM4ebV1uXwUQcBYmr0NmY0fNoKhHZq
         bGU3yHq1InuFg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5920A40094; Fri,  1 Dec 2023 17:31:52 -0300 (-03)
Date:   Fri, 1 Dec 2023 17:31:52 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Jiri Olsa <jolsa@kernel.org>, Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephane Eranian <eranian@google.com>,
        Ingo Molnar <mingo@kernel.org>
Subject: Re: [PATCH] perf/x86/amd: Reject branch stack for IBS events
Message-ID: <ZWpCuA1jJWFu23Sm@kernel.org>
References: <20230602194513.1589179-1-namhyung@kernel.org>
 <c5a40920-0b14-b9b5-19ee-48c965bd12e3@amd.com>
 <ZV9lfJyyC7xawHBC@kernel.org>
 <3d70b52f-2042-328c-6dc7-37fcbb3510a2@amd.com>
 <ZWSombzfCkxHc7lC@kernel.org>
 <fc2390cf-bdf9-590e-d078-4bb616d5feb6@amd.com>
 <ZWiIB0AURxL7qb5e@kernel.org>
 <CAM9d7chHWovp7W+e6KBaeZh3pBZTuHBe0hRH=6WW9-XBp0SQaw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chHWovp7W+e6KBaeZh3pBZTuHBe0hRH=6WW9-XBp0SQaw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Dec 01, 2023 at 12:23:16PM -0800, Namhyung Kim escreveu:
> On Thu, Nov 30, 2023 at 5:03 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Thu, Nov 30, 2023 at 11:58:15AM +0530, Ravi Bangoria escreveu:
> > > On 27-Nov-23 8:02 PM, Arnaldo Carvalho de Melo wrote:
> > > > Em Fri, Nov 24, 2023 at 09:30:37AM +0530, Ravi Bangoria escreveu:
> > > >> On 23-Nov-23 8:15 PM, Arnaldo Carvalho de Melo wrote:
> > > >>> Em Tue, Jun 06, 2023 at 10:08:43AM +0530, Ravi Bangoria escreveu:
> > > >>>> On 03-Jun-23 1:15 AM, Namhyung Kim wrote:
> > > >>>>> The AMD IBS PMU doesn't handle branch stacks, so it should not accept
> > > >>>>> events with brstack.
> >
> > > >>>>> Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > >>>> Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
> >
> > > >>> It seems this patch was not merged, can you please check?
> >
> > > >> Right. And it does not apply cleanly on peterz/queue.git/perf/core, since
> > > >> surrounding code has changed.
> >
> > > > Can you please refresh it if PeterZ has nothing against?
> >
> > > Posted v2: https://lore.kernel.org/r/20231130062246.290-1-ravi.bangoria@amd.com
> >
> > Peter, can you please consider this one?
> 
> The v2 is already in the tip tree.  Thanks Ravi for doing this!
> Namhyung

yay!

- Arnaldo
