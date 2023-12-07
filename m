Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1F08091EB
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 20:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233073AbjLGTwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 14:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229541AbjLGTwO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 14:52:14 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55D6EA5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 11:52:21 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B75ECC433C7;
        Thu,  7 Dec 2023 19:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701978741;
        bh=mbc/iuLtD8dfCRev1lXPOrNzkAar0/fIcJRnERdFfIk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LnBBcxt+T/FbexCwnL4xPBnb0UqNrwMD4tRzSXMLvI6QfnQIBLxcBs5fve8nuy1+S
         OSuYEMGauWPmMwDATH/cgCAvLwic5xCUt/JHsOwOt9aBwxdt5vsqyQujV2bBCbcaeO
         9uOjCguEiKxDhXbrMx/LbnBp57cXNyOW2KZB26u296oYUqBtq7+AwGPWiGmqzUPtwI
         Gj91ncJ/UYtA2RYmJILWnI7EMb+dreTIvuWgBpq99zLsOXDlCZVOgcTTxNIkwKGBSN
         HduANwSSITKLUAcERcaOjKcUkBNn9HExtVHSkVFAM1hmDeeihBSRXahQnu1xcLbkLx
         b48wXRlNd+6Og==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 13641403EF; Thu,  7 Dec 2023 16:52:18 -0300 (-03)
Date:   Thu, 7 Dec 2023 16:52:17 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCHSET 0/8] perf annotate: Make annotation_options global (v1)
Message-ID: <ZXIicbe9K5KYGSV4@kernel.org>
References: <20231128175441.721579-1-namhyung@kernel.org>
 <CAP-5=fWfKqgT60TFRALw8vTDQT7VFV+0+eo1rFSSH3eVrjzPmA@mail.gmail.com>
 <CAM9d7chKmDETK6Ea2wyR8L21jyHWcPHbKavarnq-JmNA-AoUnQ@mail.gmail.com>
 <CAP-5=fUf6R=bsfg7i8atFApJBY-=zWUBMq7inFsCPZhB+w2==Q@mail.gmail.com>
 <CAM9d7cjDiu=dksnhboJFT4uPQJcvGMB-vBt96v3i7Kqy5LKRMw@mail.gmail.com>
 <CAP-5=fXKbi3DYoOKrJvNKLNU=fJEY9aDAOQhH+Vh+XWxHzGjwA@mail.gmail.com>
 <ZXIiBp-rvdvSI-ZY@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZXIiBp-rvdvSI-ZY@kernel.org>
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

Em Thu, Dec 07, 2023 at 04:50:30PM -0300, Arnaldo Carvalho de Melo escreveu:
> Em Tue, Dec 05, 2023 at 09:59:02AM -0800, Ian Rogers escreveu:
> > On Mon, Dec 4, 2023 at 2:46 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > > On Thu, Nov 30, 2023 at 10:37 AM Ian Rogers <irogers@google.com> wrote:
> > > > Sgtm. My point wasn't to criticize, I think this is a good change, I
> > > > was just trying to imagine doing things in a way that could overall
> > > > reduce complexity
> 
> > > Yep, thanks for your review.  Can I get your ACKs? :)
> 
> > For the series:
> > Reviewed-by: Ian Rogers <irogers@google.com>
> 
> Thanks, applied to perf-tools-next.


Now trying to fix this:

  CC      bench/numa.o
  CC      tests/hists_cumulate.o
ui/gtk/annotate.c: In function ‘symbol__gtk_annotate’:
ui/gtk/annotate.c:179:43: error: passing argument 3 of ‘symbol__annotate’ from incompatible pointer type [-Werror=incompatible-pointer-types]
  179 |         err = symbol__annotate(ms, evsel, options, NULL);
      |                                           ^~~~~~~
      |                                           |
      |                                           struct annotation_options *
In file included from ui/gtk/annotate.c:5:
/home/acme/git/perf-tools-next/tools/perf/util/annotate.h:376:36: note: expected ‘struct arch **’ but argument is of type ‘struct annotation_options *’
  376 |                      struct arch **parch);
      |                      ~~~~~~~~~~~~~~^~~~~
ui/gtk/annotate.c:179:15: error: too many arguments to function ‘symbol__annotate’
  179 |         err = symbol__annotate(ms, evsel, options, NULL);
      |               ^~~~~~~~~~~~~~~~
/home/acme/git/perf-tools-next/tools/perf/util/annotate.h:374:5: note: declared here
  374 | int symbol__annotate(struct map_symbol *ms,
      |     ^~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
  CC      tests/python-use.o
  CC      trace/beauty/sockaddr.o
  CC      arch/x86/util/topdown.o
make[6]: *** [/home/acme/git/perf-tools-next/tools/build/Makefile.build:105: ui/gtk/annotate.o] Error 1
make[6]: *** Waiting for unfinished jobs....
  CC      arch/x86/util/machine.o

