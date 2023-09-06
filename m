Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A91D7941A3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238372AbjIFQnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 12:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237536AbjIFQnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 12:43:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15E651998;
        Wed,  6 Sep 2023 09:43:39 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C104C433C7;
        Wed,  6 Sep 2023 16:43:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694018618;
        bh=INoTxFTgz1EC0U+ftuMgP49fdpeC/V4RqcR4oqdd0es=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WEBkx4RAkJyL4LqEQegU7rusjMw080VVIc55LQ0pKoAeLPCsFykupQT5k/PP+jVBZ
         gbK0xLbWWaxUnFeey0QBlpnq93X5eC58nmdCYo08HaJEUqD+6/5+w/KFWOYCqBoHG4
         1wRYN8xCNDXJzKZrosJobIaVVsbWDnF1SFGdlKn26HcSxGBgQCm+MlZcW1UCGlt0u1
         n+SHe75vkL0cRJNho9gEoZ6AeVCmY3Ad1W4SENYRLBZMbcS4+C3O2Aq/jOwrPS3A3i
         7kvXXHo5QjggBOj1EjwdhFjNMs2slofm9BNqD8/DlAz6r5gXTQBdo0nusygMBNdop3
         Zyy2B596jbJWA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 5F355403F4; Wed,  6 Sep 2023 13:43:35 -0300 (-03)
Date:   Wed, 6 Sep 2023 13:43:35 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Yang Jihong <yangjihong1@huawei.com>, peterz@infradead.org,
        mingo@redhat.com, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, adrian.hunter@intel.com,
        kan.liang@linux.intel.com, sandipan.das@amd.com,
        ravi.bangoria@amd.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org
Subject: Re: [RFC v1 01/16] perf kwork: Fix incorrect and missing free atom
 in work_push_atom()
Message-ID: <ZPisN7/pZrnQeQmK@kernel.org>
References: <20230812084917.169338-1-yangjihong1@huawei.com>
 <20230812084917.169338-2-yangjihong1@huawei.com>
 <CAP-5=fUVY9eL-t4Ya5bqHz7gDKDSi9=kvDgMdGmb02Yh8LhVaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fUVY9eL-t4Ya5bqHz7gDKDSi9=kvDgMdGmb02Yh8LhVaA@mail.gmail.com>
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

Em Sun, Sep 03, 2023 at 09:05:06PM -0700, Ian Rogers escreveu:
> On Sat, Aug 12, 2023 at 1:52 AM Yang Jihong <yangjihong1@huawei.com> wrote:
> >
> > 1. Atoms are managed in page mode and should be released using atom_free()
> >    instead of free().
> > 2. When the event does not match, the atom needs to free.
> >
> > Fixes: f98919ec4fcc ("perf kwork: Implement 'report' subcommand")
> > Signed-off-by: Yang Jihong <yangjihong1@huawei.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied locally, will perform some tests and later today
probably push publicly, great work!

- Arnaldo

 
> > ---
> >  tools/perf/builtin-kwork.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/builtin-kwork.c b/tools/perf/builtin-kwork.c
> > index 14bf7a8429e7..73b5dc099a8a 100644
> > --- a/tools/perf/builtin-kwork.c
> > +++ b/tools/perf/builtin-kwork.c
> > @@ -406,12 +406,14 @@ static int work_push_atom(struct perf_kwork *kwork,
> >
> >         work = work_findnew(&class->work_root, &key, &kwork->cmp_id);
> >         if (work == NULL) {
> > -               free(atom);
> > +               atom_free(atom);
> 
> Presumably this is fixing a memory-leak. It would be nice if kwork had
> perf tests, then our builds with -fsanitize=address would highlight
> this kind of issue. Here is a build command I use for this:
> make -C tools/perf O=/tmp/perf DEBUG=1 EXTRA_CFLAGS="-O0 -g
> -fno-omit-frame-pointer -fsanitize=address" BUILD_BPF_SKEL=1
> NO_LIBTRACEEVENT=1
> 
> Thanks,
> Ian
> 
> >                 return -1;
> >         }
> >
> > -       if (!profile_event_match(kwork, work, sample))
> > +       if (!profile_event_match(kwork, work, sample)) {
> > +               atom_free(atom);
> >                 return 0;
> > +       }
> >
> >         if (dst_type < KWORK_TRACE_MAX) {
> >                 dst_atom = list_last_entry_or_null(&work->atom_list[dst_type],
> > --
> > 2.30.GIT
> >

-- 

- Arnaldo
