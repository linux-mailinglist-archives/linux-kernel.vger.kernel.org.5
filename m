Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9567278493F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 20:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbjHVSIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 14:08:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjHVSIa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 14:08:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA1ECC
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 11:08:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EEA3063C4C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 18:08:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB04DC433C8;
        Tue, 22 Aug 2023 18:08:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692727707;
        bh=J7lgKhJFr4zPVnWVn7o3RjxykfQYKFNZkD4U5iqX6sU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O9tYJVhMgRrfwbK2yQfxv9HXnWt2d7fmbF1UObXbXAFPXl0LxQGzfJbBtzv1eLr/o
         VIhpSoTBBFL/hPYktBdrD76nry+27Mz8ceDzGaL8x5NeeNsg+dPYnw7AEtyBhqAPqh
         MxUHbgw+/aiIS9R6qMysqkoEVrJDN55JXrmqPKxg1zEYyQc8zqgbmagS6LcJhHHLQl
         6CJpRWh8eam1RS5LyLlPsSbFtBCb94d5K/NDocCxNEoKrMDl5Gscga/D/O0gzE1YMo
         HlEFSiVdnBsdFn4dVbVdQHsmNuXwqcd1RmU3BRKlIu176hIcHJyWMZQrovhwYtiyI8
         aIirbdrM4+2Tg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5B99E40722; Tue, 22 Aug 2023 15:08:24 -0300 (-03)
Date:   Tue, 22 Aug 2023 15:08:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/1] perf bpf_skel augmented_raw_syscalls: Cap the
 socklen parameter using &= sizeof(saddr)
Message-ID: <ZOT5mK2MgQXTx75w@kernel.org>
References: <ZN1ELw41wQE5zDrK@kernel.org>
 <CAP-5=fVU07VHcQE6r9k7aEV+xM3_HFcgY+5Y8N7qVvsZD3V9vg@mail.gmail.com>
 <ZONpMu2/tQvZgM/S@kernel.org>
 <CAP-5=fX_DdDV8CVWvcRCP9iWwZAmGYBdi5_RRczB3HQUuRdrOw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fX_DdDV8CVWvcRCP9iWwZAmGYBdi5_RRczB3HQUuRdrOw@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Aug 21, 2023 at 07:52:46AM -0700, Ian Rogers escreveu:
> On Mon, Aug 21, 2023 at 6:40 AM Arnaldo Carvalho de Melo
> <acme@kernel.org> wrote:
> >
> > Em Wed, Aug 16, 2023 at 03:10:00PM -0700, Ian Rogers escreveu:
> > > On Wed, Aug 16, 2023 at 2:48 PM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > >   R2 min value is negative, either use unsigned or 'var &= const'
> > > >   processed 22 insns (limit 1000000) max_states_per_insn 0 total_states 1 peak_states 1 mark_read 1
> > > >   -- END PROG LOAD LOG --
> > > >   libbpf: prog 'sys_enter_sendto': failed to load: -13
> > > >   libbpf: failed to load object 'augmented_raw_syscalls_bpf'
> > > >   libbpf: failed to load BPF skeleton 'augmented_raw_syscalls_bpf': -13
> > > >
> > > > So use the suggested &= variant since sizeof(saddr) == 128 bytes.
> > >
> > > Could this be an assert?
> >
> > you mean (removing the change to saddr to make it trigger):
> 
> I was more meaning that doing sizeof(x) -1 and assuming that x is a
> power of two should really have an assert that sizeof(x) is a power of

Right, that was my understanding, and that is what:

_Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two")

Does, right?

- Arnaldo


> 2. Using 127 and asserting sizeof(x)==128 also works.


> Thanks,
> Ian
> 
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 9c1d0b271b20f693..521ce2d7357d983c 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -10,6 +10,16 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/limits.h>
> >
> > +/**
> > + * is_power_of_2() - check if a value is a power of two
> > + * @n: the value to check
> > + *
> > + * Determine whether some value is a power of two, where zero is *not*
> > + * considered a power of two.  Return: true if @n is a power of 2, otherwise
> > + * false.
> > + */
> > +#define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
> > +
> >  #define MAX_CPUS  4096
> >
> >  // FIXME: These should come from system headers
> > @@ -112,7 +122,10 @@ struct augmented_args_payload {
> >                 struct {
> >                         struct augmented_arg arg, arg2;
> >                 };
> > -               struct sockaddr_storage saddr;
> > +               struct {
> > +                       struct sockaddr_storage real_saddr;
> > +                       char padding;
> > +               } saddr;
> >                 char   __data[sizeof(struct augmented_arg)];
> >         };
> >  };
> > @@ -187,6 +200,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
> >          if (augmented_args == NULL)
> >                  return 1; /* Failure: don't filter */
> >
> > +       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
> >         socklen &= sizeof(augmented_args->saddr) - 1;
> >
> >         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
> >
> >
> > --------------------------------
> >
> >   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> > util/bpf_skel/augmented_raw_syscalls.bpf.c:203:2: error: static_assert failed due to requirement 'sizeof (augmented_args->saddr) != 0 && ((sizeof (augmented_args->saddr) & (sizeof (augmented_args->saddr) - 1)) == 0)' "sizeof(augmented_args->saddr) needs to be a power of two"
> >         _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
> >         ^              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > 1 error generated.
> > make[2]: *** [Makefile.perf:1104: /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o] Error 1
> > make[1]: *** [Makefile.perf:238: sub-make] Error 2
> > make: *** [Makefile:113: install-bin] Error 2
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> >
> > And here the assert being satisfied:
> >
> > ⬢[acme@toolbox perf-tools-next]$ git diff
> > diff --git a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > index 9c1d0b271b20f693..43549b63b433d81e 100644
> > --- a/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > +++ b/tools/perf/util/bpf_skel/augmented_raw_syscalls.bpf.c
> > @@ -10,6 +10,16 @@
> >  #include <bpf/bpf_helpers.h>
> >  #include <linux/limits.h>
> >
> > +/**
> > + * is_power_of_2() - check if a value is a power of two
> > + * @n: the value to check
> > + *
> > + * Determine whether some value is a power of two, where zero is *not*
> > + * considered a power of two.  Return: true if @n is a power of 2, otherwise
> > + * false.
> > + */
> > +#define is_power_of_2(n) (n != 0 && ((n & (n - 1)) == 0))
> > +
> >  #define MAX_CPUS  4096
> >
> >  // FIXME: These should come from system headers
> > @@ -187,6 +197,7 @@ int sys_enter_connect(struct syscall_enter_args *args)
> >          if (augmented_args == NULL)
> >                  return 1; /* Failure: don't filter */
> >
> > +       _Static_assert(is_power_of_2(sizeof(augmented_args->saddr)), "sizeof(augmented_args->saddr) needs to be a power of two");
> >         socklen &= sizeof(augmented_args->saddr) - 1;
> >
> >         bpf_probe_read(&augmented_args->saddr, socklen, sockaddr_arg);
> > ⬢[acme@toolbox perf-tools-next]$ m
> > make: Entering directory '/var/home/acme/git/perf-tools-next/tools/perf'
> >   BUILD:   Doing 'make -j32' parallel build
> >   INSTALL libsubcmd_headers
> >   INSTALL libperf_headers
> >   INSTALL libapi_headers
> >   INSTALL libbpf_headers
> >   CLANG   /tmp/build/perf-tools-next/util/bpf_skel/.tmp/augmented_raw_syscalls.bpf.o
> >   GENSKEL /tmp/build/perf-tools-next/util/bpf_skel/augmented_raw_syscalls.skel.h
> >   INSTALL libsymbol_headers
> >   CC      /tmp/build/perf-tools-next/builtin-trace.o
> >   LD      /tmp/build/perf-tools-next/perf-in.o
> >   LINK    /tmp/build/perf-tools-next/perf
> >   INSTALL binaries
> >   INSTALL tests
> >   INSTALL libperf-jvmti.so
> >   INSTALL libexec
> >   INSTALL perf-archive
> >   INSTALL perf-iostat
> >   INSTALL strace/groups
> >   INSTALL perl-scripts
> >   INSTALL python-scripts
> >   INSTALL dlfilters
> >   INSTALL perf_completion-script
> >   INSTALL perf-tip
> > make: Leaving directory '/var/home/acme/git/perf-tools-next/tools/perf'
> > ⬢[acme@toolbox perf-tools-next]$
> >
> >
> >
> >

-- 

- Arnaldo
