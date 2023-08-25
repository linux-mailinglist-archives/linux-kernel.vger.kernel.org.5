Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1A3788BEA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 16:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343844AbjHYOqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 10:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240257AbjHYOq0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 10:46:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4CA2109;
        Fri, 25 Aug 2023 07:46:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A5A0622A2;
        Fri, 25 Aug 2023 14:46:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 533A5C433C8;
        Fri, 25 Aug 2023 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692974783;
        bh=RId/5/iXShBVctnrrr6Y2T9OzHSw2h2nMjzM8MonGHU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=htCCQYUD30K7SwzsDohB/EpP+awpuWjKtGzxStaBNcvt7J8XtL7wKMOOVOv9aufd5
         GeA9ROiqIhgOE/izPFtjmKdO1eVsL0V4xzrnrVoqcdaMH3fw2eYJj5dXxBD+RqpfHY
         4/cFON8CIvDNd18NAHZYMXtP66R1eyaJpLm2v4xZjFkojNbUtRnijtYZNOprkDaNBL
         txEcPfupPcz3MEaNF0BiSAgbYM1aFMKMP73/RVjIt7HRa6F46cFuMN5ofQOfJwIlXX
         +h2n4SYTRxEJK6+Zcg07VF7+Kf4rb1pDiPkrOrLvj1TqgN6g98mcFDCwVvgRg5zb8L
         +XfOgMU+ZSufg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 516C140722; Fri, 25 Aug 2023 11:46:20 -0300 (-03)
Date:   Fri, 25 Aug 2023 11:46:20 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        John Garry <john.g.garry@oracle.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 0/2] perf list: Remove duplicate PMUs
Message-ID: <ZOi+vNhyUd5oduBQ@kernel.org>
References: <20230825135237.921058-1-irogers@google.com>
 <166e2aad-5e17-3ffa-b140-05f174583ab2@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <166e2aad-5e17-3ffa-b140-05f174583ab2@linux.intel.com>
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

Em Fri, Aug 25, 2023 at 10:05:46AM -0400, Liang, Kan escreveu:
> On 2023-08-25 9:52 a.m., Ian Rogers wrote:
> > When there are multiple PMUs, differing by ordered suffixes, by
> > default only display one. This avoids repeated listing of events, in
> > particular when there are 10s of uncore PMUs. If "-v" is passed to
> > "perf list" then still list all PMUs.
> > 
> > Listing fewer PMU/event combinations helps speed the all PMU event
> > tests.
> > 
> > Before:
> > ```
> > $ perf list
> > ...
> >   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
> >   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
> >   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
> >   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
> >   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
> >   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> > ```
> > 
> > After:
> > ```
> > $ perf list
> > ...
> >   uncore_imc_free_running/data_read/                 [Kernel PMU event]
> >   uncore_imc_free_running/data_total/                [Kernel PMU event]
> >   uncore_imc_free_running/data_write/                [Kernel PMU event]
> > ...
> > $ perf list -v
> > ...
> >   uncore_imc_free_running_0/data_read/               [Kernel PMU event]
> >   uncore_imc_free_running_0/data_total/              [Kernel PMU event]
> >   uncore_imc_free_running_0/data_write/              [Kernel PMU event]
> >   uncore_imc_free_running_1/data_read/               [Kernel PMU event]
> >   uncore_imc_free_running_1/data_total/              [Kernel PMU event]
> >   uncore_imc_free_running_1/data_write/              [Kernel PMU event]
> > ...
> > ```
> > 
> > The PMUs are sorted by name then suffix as a part of this change.
> > 
> > v5: Improved the 2nd patch's commit message and removed an unused
> >     variable as suggested by Kan Liang <kan.liang@linux.intel.com>.
> > v4: Rebase on top of lazy PMU changes. Ignore numeric ordering due to
> >     gaps, suggested by Kan Liang <kan.liang@linux.intel.com>. Fold
> >     patches 2 & 3 as suggested by John Garry <john.g.garry@oracle.com>
> >     (done by accident as part of rebasing).
> > v3: Add detail to patch 1 sorting commit message about the suffix and
> >     why sorting is necessary.
> > v2: List all PMUs when "-v" is passed as suggested by John Garry
> >     <john.g.garry@oracle.com>.
> > 
> > Ian Rogers (2):
> >   perf pmus: Sort pmus by name then suffix
> >   perf pmus: Skip duplicate PMUs and don't print list suffix by default
> 
> 
> Reviewed-by: Kan Liang <kan.liang@linux.intel.com>

Thanks, applied.

- Arnaldo
