Return-Path: <linux-kernel+bounces-65030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B8AC8546EB
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 11:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B7FF1F28FE2
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 10:14:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0D01171D2;
	Wed, 14 Feb 2024 10:14:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="Bfq05XKp"
Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E6F1643A
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 10:14:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707905673; cv=none; b=PPisSZM8Y7OYqApl1ZNGhyAOE+NPPi5UFKHDD/6bbeCmVAhu3Mm5KKraOa0oiYfSVPwNDmTuKV3cGG/1dGwMA4eSgZZxbBXabvq+IezX3W4qLKBeS2HyX4+EuTrkMKSb8pDDIs6Lv5pJ0DEXddjO6iHfdkETaEbJPQv7aiJxZeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707905673; c=relaxed/simple;
	bh=wH6ZUUDxzWcvM9A5J/M26EhQbNj8CDbgdD8EHHWlvfE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZKfHzZpBX2AfsOkNr4D++smERBUu6qS/eRQCLTSvikOotOiEc7sYHGLFUUSgO+nJCEr5CoWQXSsvar7Ak1bfoyWEjonk0hkV/6qj6am7co8yNZcfYFo2Kp9V8OlaobUuOz04eiuUa/IIdhi6siLme0xGhLezKijD7rjH+Qp9nXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=Bfq05XKp; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Wed, 14 Feb 2024 18:14:20 +0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1707905669;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Sq2ZgsBArKU+/0ptSnLdA9Td8CjugpWxYMkYPjmxX1A=;
	b=Bfq05XKp+zIQtFUrDOsAp5gfblgGsPGVIhQuL7AsMzfWvqCzE7E7SBWMXoVUa+8taAJaWV
	UACiCI8iKWwXqHb3AXKU5gpyvIE1rqnFKkoiJVPdrooLT2TN4tnZE+1HNCPTxnzp055tv5
	JtWgQkUDVvmgHGNoTem+qlMG4Cn9+VQ=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Leo Yan <leo.yan@linux.dev>
To: Namhyung Kim <namhyung@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>,
	Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
	linux-perf-users@vger.kernel.org, Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	John Garry <john.g.garry@oracle.com>,
	Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] perf tools: Fixup module symbol end address properly
Message-ID: <20240214101420.GF81405@debian-dev>
References: <20240212233322.1855161-1-namhyung@kernel.org>
 <20240213033954.GB81405@debian-dev>
 <CAM9d7ciTwYAgry-nW9z+_VMj+BJ7ZNZnkKH_t_AHvV5joNuWQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAM9d7ciTwYAgry-nW9z+_VMj+BJ7ZNZnkKH_t_AHvV5joNuWQQ@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Tue, Feb 13, 2024 at 10:48:53AM -0800, Namhyung Kim wrote:
> Hi Leo,
> 
> Thanks for your review!
> 
> On Mon, Feb 12, 2024 at 7:40???PM Leo Yan <leo.yan@linux.dev> wrote:
> >
> > On Mon, Feb 12, 2024 at 03:33:22PM -0800, Namhyung Kim wrote:
> > > I got a strange error on ARM to fail on processing FINISHED_ROUND
> > > record.  It turned out that it was failing in symbol__alloc_hist()
> > > because the symbol size is too big.
> > >
> > > When a sample is captured on a specific BPF program, it failed.  I've
> > > added a debug code and found the end address of the symbol is from
> > > the next module which is placed far way.
> > >
> > >   ffff800008795778-ffff80000879d6d8: bpf_prog_1bac53b8aac4bc58_netcg_sock    [bpf]
> > >   ffff80000879d6d8-ffff80000ad656b4: bpf_prog_76867454b5944e15_netcg_getsockopt      [bpf]
> > >   ffff80000ad656b4-ffffd69b7af74048: bpf_prog_1d50286d2eb1be85_hn_egress     [bpf]   <---------- here
> > >   ffffd69b7af74048-ffffd69b7af74048: $x.5    [sha3_generic]
> > >   ffffd69b7af74048-ffffd69b7af740b8: crypto_sha3_init        [sha3_generic]
> > >   ffffd69b7af740b8-ffffd69b7af741e0: crypto_sha3_update      [sha3_generic]
> > >
> > > The logic in symbols__fixup_end() just uses curr->start to update the
> > > prev->end.  But in this case, it won't work as it's too different.
> > >
> > > I think ARM has a different kernel memory layout for modules and BPF
> > > than on x86.  Actually there's a logic to handle kernel and module
> > > boundary.  Let's do the same for symbols between different modules.
> >
> > Even Arm32 and Arm64 kernel have different memory layout for modules
> > and kernel image.
> >
> > eBPF program (JITed) should be allocated from the vmalloc region, for
> > Arm64, see bpf_jit_alloc_exec() in arch/arm64/net/bpf_jit_comp.c.
> 
> Ok, so chances are they can fall out far away right?

Yes, this is my understanding.

> > > Signed-off-by: Namhyung Kim <namhyung@kernel.org>
> > > ---
> > >  tools/perf/util/symbol.c | 21 +++++++++++++++++++--
> > >  1 file changed, 19 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/tools/perf/util/symbol.c b/tools/perf/util/symbol.c
> > > index 35975189999b..9ebdb8e13c0b 100644
> > > --- a/tools/perf/util/symbol.c
> > > +++ b/tools/perf/util/symbol.c
> > > @@ -248,14 +248,31 @@ void symbols__fixup_end(struct rb_root_cached *symbols, bool is_kallsyms)
> > >                * segment is very big.  Therefore do not fill this gap and do
> > >                * not assign it to the kernel dso map (kallsyms).
> > >                *
> > > +              * Also BPF code can be allocated separately from text segments
> > > +              * and modules.  So the last entry in a module should not fill
> > > +              * the gap too.
> > > +              *
> > >                * In kallsyms, it determines module symbols using '[' character
> > >                * like in:
> > >                *   ffffffffc1937000 T hdmi_driver_init  [snd_hda_codec_hdmi]
> > >                */
> > >               if (prev->end == prev->start) {
> > > +                     const char *prev_mod;
> > > +                     const char *curr_mod;
> > > +
> > > +                     if (!is_kallsyms) {
> > > +                             prev->end = curr->start;
> > > +                             continue;
> > > +                     }
> > > +
> > > +                     prev_mod = strchr(prev->name, '[');
> > > +                     curr_mod = strchr(curr->name, '[');
> > > +
> > >                       /* Last kernel/module symbol mapped to end of page */
> > > -                     if (is_kallsyms && (!strchr(prev->name, '[') !=
> > > -                                         !strchr(curr->name, '[')))
> > > +                     if (!prev_mod != !curr_mod)
> > > +                             prev->end = roundup(prev->end + 4096, 4096);
> > > +                     /* Last symbol in the previous module */
> > > +                     else if (prev_mod && strcmp(prev_mod, curr_mod))
> >
> > Should two consecutive moudles fall into this case? I think we need to assign
> > 'prev->end = curr->start' for two two consecutive moudles.
> 
> Yeah I thought about that case but I believe they would be on
> separate pages (hopefully there's a page gap between them).
> So I think it should not overlap.  But if you really care we can
> check it explicitly like this:
> 
>     prev->end = min(roundup(...), curr->start);

I am not concerned that to assign a bigger end value for the 'prev'
symbol. With an exaggerate end region, it will not cause any
difficulty for parsing symbols. On the other hand, I am a bit concern
for a big function (e.g. its code size > 4KiB), we might fail to find
symbols in this case with the change above.

> > If so, we should use a specific checking for eBPF program, e.g.:
> >
> >                         else if (prev_mod && strcmp(prev_mod, curr_mod) &&
> >                                  (!strcmp(prev->name, "bpf") ||
> >                                   !strcmp(curr->name, "bpf")))
> 
> I suspect it can happen on any module boundary so better
> to handle it in a more general way.

I don't want to introduce over complexity at here. We can apply
current patch as it is.

A side topic, when I saw the code is hard coded for 4096 as the page
size, this is not always true on Arm64 (the page size can be 4KiB,
16KiB or 64KiB). We need to consider to extend the environment for
recording the system's page size.

Thanks,
Leo

> Thanks,
> Namhyung
> 
> >
> > >                               prev->end = roundup(prev->end + 4096, 4096);
> > >                       else
> > >                               prev->end = curr->start;
> > > --
> > > 2.43.0.687.g38aa6559b0-goog
> > >

