Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5B867D8908
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 21:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231910AbjJZThr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 15:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjJZThp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 15:37:45 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7737C121;
        Thu, 26 Oct 2023 12:37:43 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91E6C433C8;
        Thu, 26 Oct 2023 19:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698349063;
        bh=uvyIqOBKNfkFHe0q/wlli3JBnyltBarFakFaKmvDmFQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XrQsUwHnBd2TcXUEDuaqTNHZ1Hp9O8Hws1njlwmYTNGZfI6KqoNWhSB0i3NBasXkd
         p1V/M80GAPwhhHBshBMFU0rFFB+LTiSxD6+9cqfiu5T7mDbW587X/fE4vBoMgB5fUR
         jthL2hlDcon2dyul3HJ8W7XI9yIkYVKCchyfSDjhOkKkYRD7d1mR4Lw84sqquCTGHA
         LyMQ+lqbS1G8A2u5yq7Bk6i6LssU+2PGxHu6/Nm9QCohVFx29ivMi7boKa55TOhgyF
         ChlcVVz166XfVf7tisa77/G6bUoR6plUb9gwKbf8dHu9pjX10l3/c0YWtETHbMtN7d
         2+ICEayNhHpYg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id D93054035D; Thu, 26 Oct 2023 16:37:39 -0300 (-03)
Date:   Thu, 26 Oct 2023 16:37:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ian Rogers <irogers@google.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Stephane Eranian <eranian@google.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        linux-toolchains@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: Re: [PATCH 13/48] perf annotate: Add annotate_get_insn_location()
Message-ID: <ZTrAA57YAQiNxQ1e@kernel.org>
References: <20231012035111.676789-1-namhyung@kernel.org>
 <20231012035111.676789-14-namhyung@kernel.org>
 <ZTahaOOOgFkclARB@kernel.org>
 <CAM9d7cg65AYsPg+0eKg8Cj1Vb42vwCdjJAP3_1G_r7-Dwu7z8A@mail.gmail.com>
 <CAM9d7ciZ0axC1A=q2mT-5fCmNUZF=QtmfcQmfs8aR-tgYftYmA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7ciZ0axC1A=q2mT-5fCmNUZF=QtmfcQmfs8aR-tgYftYmA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Oct 25, 2023 at 10:26:32PM -0700, Namhyung Kim escreveu:
> On Tue, Oct 24, 2023 at 12:10 PM Namhyung Kim <namhyung@kernel.org> wrote:
> > On Mon, Oct 23, 2023 at 9:38 AM Arnaldo Carvalho de Melo <acme@kernel.org> wrote:
> > > Em Wed, Oct 11, 2023 at 08:50:36PM -0700, Namhyung Kim escreveu:
> > > > The annotate_get_insn_location() is to get the detailed information of
> > > > instruction locations like registers and offset.  It has source and
> > > > target operands locations in an array.  Each operand can have a
> > > > register and an offset.  The offset is meaningful when mem_ref flag is
> > > > set.

> > > This needs to be enclosed in HAVE_DWARF_SUPPORT, as the build is failing
> > > in systems where this isn't available, see patch below.

> > Thanks for the test and the patch, will add it to v2.
 
> Hmm.. I think this function can work without DWARF.
> If the only problem is get_dwarf_regnum() probably
> I can add a dummy function when libdw is not found.
> Maybe I need to use arch reg number here and
> convert to DWARF later.

That can be a possibility, but the interesting thing is to try to run
'make -C tools/perf build-test' regularly to catch these builds without
some of the components, I bet this one:

make_no_libelf      := NO_LIBELF=1

As my container builds did, as that is one of the things built there.

One other suggestion would be to add some warning when the required
components to build the data profiling feature are not present.

- Arnaldo
