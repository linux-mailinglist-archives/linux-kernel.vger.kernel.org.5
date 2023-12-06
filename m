Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77467806FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 13:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378269AbjLFMdn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 07:33:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378248AbjLFMdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 07:33:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ADE6181
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 04:33:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBAACC433C7;
        Wed,  6 Dec 2023 12:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701866027;
        bh=jP8oTQYcoTQ/+jzJe9HomCjknj3ke/BfjtCVDvJLPxA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=H4zM4TYqeShLinEyDI2UvMarRD2zz4PARkf24a/dah9LQ2qAKA1kf7TE9gYro6Q/y
         EIk2Wspbx28eTBl7OpsnqTnjI6PMO8jAm1B37+h2Bhjr9XkiFdK8xZD5z/DMu5nUN0
         2e2o6j1GeAqsEQlQWjDNsNakPJx1WtGYcwF1JmHdC9W7GgvYdaIZf7orH491B/nMA1
         L0NJz/hDAniZrFKP3JmVxS2tHyxUjH7Ed2aj29Pf6j+XB5CdaKYKrREI54JnfHEnrT
         SlONgRaXybAXNEavCZ76hjpWExGaZ0x3MjyHOVeq5WaZaygoaP/EEd90beryR2VIFc
         v7vOW7Rp2aL0A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 71025403EF; Wed,  6 Dec 2023 09:33:45 -0300 (-03)
Date:   Wed, 6 Dec 2023 09:33:45 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Arnaldo Carvalho de Melo <arnaldo.melo@gmail.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Ian Rogers <irogers@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the perf tree
Message-ID: <ZXBqKaGRF8y/2K9b@kernel.org>
References: <20231206091433.68f59ba1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231206091433.68f59ba1@canb.auug.org.au>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Dec 06, 2023 at 09:14:33AM +1100, Stephen Rothwell escreveu:
> Commit
 
>   08b953508560 ("perf evsel: Fallback to "task-clock" when not system wide")
 
> is missing a Signed-off-by from its author.

Thanks for the report, fixed, the issue was that Ian's S-o-B was after a

--- line and thus git-am chopped it up :-\

===============================================================================

When the cycles event isn't available evsel will fallback to the
cpu-clock software event. task-clock is similar to cpu-clock but only
runs when the process is running. Falling back to cpu-clock when not
system wide leads to confusion, by falling back to task-clock it is
hoped the confusion is less.

Pass the target to determine if task-clock is more appropriate. Update
a nearby comment and debug string for the change.

---
v2. Use target__has_cpu as suggested by Namhyung.
https://lpc.events/event/17/contributions/1556/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/builtin-record.c |  2 +-
 tools/perf/builtin-stat.c   |  2 +-
 tools/perf/builtin-top.c    |  2 +-
 tools/perf/util/evsel.c     | 18 ++++++++++--------
 tools/perf/util/evsel.h     |  3 ++-
 5 files changed, 15 insertions(+), 12 deletions(-

--
===============================================================================

I'll check my pre-commit hooks to see why this didn't get flagged...

- Arnaldo
