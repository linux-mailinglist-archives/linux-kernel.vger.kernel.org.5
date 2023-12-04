Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F033803EA3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 20:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344402AbjLDTpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 14:45:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234070AbjLDTpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 14:45:05 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54EE3111
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 11:45:12 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B37DAC433C7;
        Mon,  4 Dec 2023 19:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701719112;
        bh=cmGhT0rNZ8LRt6ST5YFsV1NE54yYUY00lCLWNdQsFgo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gGXRVCA0+iQuobeTpTbatvmMNWDlV2ejifzBvETIsWwdTTjvnmZNpjC5Omy4HGaC7
         lDCafimFWTXVKXtt94KdMYS8y5mw1VZIpPtS5vYwhBs6ccqVZQwuBoZXbIhfQdd5TB
         11+Jj9jvM9675zlKJYG4w2NZrsHQKSx5qzBqOOauJEKZKS0yRkkLR3w3fjhgSc3J0F
         SvhJAnmrX3n2o1cL5jEb8vnbgDtTvFJnCQvKub/KIibBdAq2b7/ziqu8x08M0zPM6S
         ypkKdF78WRzolsLYaYGZe7ZdFX8JfGO4rZcluZOD9cLJ2aYTZq8ICyWaqEbgeZSSgR
         1ulzzNB5V7U+g==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1567A40094; Mon,  4 Dec 2023 16:45:09 -0300 (-03)
Date:   Mon, 4 Dec 2023 16:45:08 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Namhyung Kim <namhyung@kernel.org>,
        James Clark <james.clark@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-perf-users <linux-perf-users@vger.kernel.org>
Subject: Re: [PATCH v2 1/4] perf build: Shellcheck support for OUTPUT
 directory
Message-ID: <ZW4sRL0vPofcoS43@kernel.org>
References: <20231129213428.2227448-1-irogers@google.com>
 <CE3EBC99-B6B0-4DD5-A88E-26B28B1A4A46@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CE3EBC99-B6B0-4DD5-A88E-26B28B1A4A46@linux.vnet.ibm.com>
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

Em Fri, Dec 01, 2023 at 11:49:59AM +0530, Athira Rajeev escreveu:
> 
> 
> > On 30-Nov-2023, at 3:04 AM, Ian Rogers <irogers@google.com> wrote:
> > 
> > Migrate Makefile.tests to Build so that variables like rule_mkdir are
> > defined via Makefile.build (needed so the output directory can be
> > created). This requires SHELLCHECK being exported and the clean rule
> > tweaking to remove the files in find.
> > 
> > Change find "-perm -o=x" as it was failing on my Debian based Linux
> > kernel tree, switch to using "-executable".
> > 
> > Adding a filename prefix of "." to the shellcheck log files is a pain
> > and error prone in make, remove this prefix and just add the
> > shellcheck log files to .gitignore.
> > 
> > Fix the command echo so that running the test is displayed.
> > 
> > Fixes: 1638b11ef815 ("perf tools: Add perf binary dependent rule for shellcheck log in Makefile.perf")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Hi Ian,
> 
> Changes looks good to me.
> Tested with make, make clean, make with shellcheck error, make with NO_SHELLCHECK
> 
> Reviewed-by: Athira Rajeev <atrajeev@linux.vnet.ibm.com>

Next time please reply with your Reviewed-by to the cover letter, so
that b4 stamps your reviewed-by to all the patches and not just to the
patch that you replied to.

This time I'll take the plural in "Changes look good to me" to signify
that you reviewed the whole series, ok?

- Arnaldo
