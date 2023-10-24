Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD5F27D54F4
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 17:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233522AbjJXPMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 11:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230059AbjJXPMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 11:12:48 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E39BA
        for <linux-kernel@vger.kernel.org>; Tue, 24 Oct 2023 08:12:28 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB31C433C7;
        Tue, 24 Oct 2023 15:12:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698160348;
        bh=Fq23oTVX0YBaNukXFPosDVGf8a1RsbhVsJ4u1q14Z5s=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Ve9OAwmiHJiGnk42fCQsmjMzoYzh9dvNXjCkqn1oSDS6DYs5IV7xhkJLaXZsVjIzI
         +dkdfq3ajHxeYgxVJv3n52vYoLOCMjliwrPPTirBtqh8W53/ESnbT+hIhwXevmqjhU
         OzVmZgCeZ1xhizJk96njAxoioUEEr5JUW3eVUtV+yyDYksoZtesSM904QSzVmrsMlP
         6rXlFn2pk7e+5NPgTW96mvmdK3wcERW2PceV1buJkXq5qhQZ2DB17dX+BBL2C3CtHR
         x66SfoJV218GSGxF8HJUftDSLMhn/VVvUDDzPMzHFTnYhltIZMqK9yHJQH9Y5NGMUa
         qAwX/4b8sKbnw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id AD5794035D; Tue, 24 Oct 2023 12:12:24 -0300 (-03)
Date:   Tue, 24 Oct 2023 12:12:24 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] perf build: Remove stray '\' before that is warned about
 since grep 3.8
Message-ID: <ZTfe2N+EQwEEBUml@kernel.org>
References: <ZS7PIHUZfHcrfvi4@kernel.org>
 <CAM9d7cjkFQU+dd8m8pq6-u6JruY9tFi_86ZyiQrXGL9js_vuuA@mail.gmail.com>
 <ZTLkWVempj1xV6CV@kernel.org>
 <CAM9d7cgW7PmgSj3kAowFOVLG56L=QHVCU=PfM+p7sVfQyJrt6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7cgW7PmgSj3kAowFOVLG56L=QHVCU=PfM+p7sVfQyJrt6Q@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Fri, Oct 20, 2023 at 02:15:03PM -0700, Namhyung Kim escreveu:
> On Fri, Oct 20, 2023 at 1:34 PM Arnaldo Carvalho de Melo > <acme@kernel.org> wrote:
> > Em Tue, Oct 17, 2023 at 12:02:20PM -0700, Namhyung Kim escreveu:
> > > On Tue, Oct 17, 2023 at 11:15 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > > To address this grep 3.8 warning:

> > > >   grep: warning: stray \ before #

> > > > +++ b/tools/perf/Makefile.perf
> > > > @@ -361,7 +361,7 @@ python-clean := $(call QUIET_CLEAN, python) $(RM) -r $(PYTHON_EXTBUILD) $(OUTPUT
> > > >  ifeq ($(CONFIG_LIBTRACEEVENT),y)
> > > >    PYTHON_EXT_SRCS := $(shell grep -v ^\# util/python-ext-sources)

> > > Do we need to change it here too?  Otherwise looks good

> > I think I did tests and simply removing the \ in this case will comment
> > out the rest of the line after the #, IIRC we would have to enclose it
> > in '', like
> >
> >   PYTHON_EXT_SRCS := $(shell grep -v '^\#' util/python-ext-sources)
> >
> > But then if it works as-is, why pollute the patch? :-)
> >
> > In general the less lines you touch in a patch, the better, don't fix
> > what isn't broken, helps reviewing, etc. :-)
> 
> Agreed, thanks!
> Namhyung

But while this makes it build in newer systems, it breaks on older ones:

Makefile.perf:364: *** unterminated call to function 'shell': missing ')'.  Stop.
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-6.6.0-rc1/tools/perf'
+ exit 1
[perfbuilder@five ~]$ dsh opensuse:15.4
sh-4.4$ rpm -q grep make
grep-3.1-150000.4.6.1.x86_64
make-4.2.1-7.3.2.x86_64
sh-4.4$

Makefile.perf:364: *** unterminated call to function 'shell': missing ')'.  Stop.
make[1]: *** [Makefile.perf:242: sub-make] Error 2
make: *** [Makefile:70: all] Error 2
make: Leaving directory '/git/perf-6.6.0-rc1/tools/perf'
+ exit 1
[perfbuilder@five ~]$ dsh ubuntu:20.04
$ dpkg -l make grep
Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name           Version      Architecture Description
+++-==============-============-============-=================================
ii  grep           3.4-1        amd64        GNU grep, egrep and fgrep
ii  make           4.2.1-1.2    amd64        utility for directing compilation
$

Both these containers don't have libtraceevent-devel installed (not
available).

:-\

- Arnaldo
