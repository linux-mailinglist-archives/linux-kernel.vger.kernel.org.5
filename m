Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB1217F4D7B
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 17:55:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343632AbjKVQz3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 11:55:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232069AbjKVQz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 11:55:27 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC521B1
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 08:55:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED266C433C7;
        Wed, 22 Nov 2023 16:55:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700672122;
        bh=XtZvgLADNlJjF3CcuU8HxQP4DWF/LbbIw8RHhj3IkrM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mFrg54gHiLOzWFDHZDSev0swVEl65IU2NvNmLySHloTSJBhDI6QQZE73gV92PnD0M
         yh4jo6s4eipjfQZ2BGg1iS4NQnxvan3GKF64/AE43b/oEjligQ6Oipxfm/UQMAm+hH
         2Nq3FwPLmuvLgdVpLMWP2IDhIjFY/ciT27DDc6XEusD2FdwQ364C38widBbIlVVOgm
         D2EAAeTxzZWgJ4jMC2YSp1Yrnw6cW6gYYqWbAbtUfR1TXgKBPEY5t6Q02BH3MH9gQ8
         nt+bgJfCR0DeILG9EKypgowMUvMcHf70KImiI7wtJEVvVpnygDBe98H5cumCEoJVUR
         iYM9wliiYSWsQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6825940094; Wed, 22 Nov 2023 13:55:19 -0300 (-03)
Date:   Wed, 22 Nov 2023 13:55:19 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Mark Rutland <mark.rutland@arm.com>, Marc Zyngier <maz@kernel.org>,
        Hector Martin <marcan@marcan.st>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        James Clark <james.clark@arm.com>,
        linux-perf-users@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>,
        Asahi Linux <asahi@lists.linux.dev>
Subject: Re: [REGRESSION] Perf (userspace) broken on big.LITTLE systems since
 v6.5
Message-ID: <ZV4yd3oz2Ykl/N5Q@kernel.org>
References: <ZVzPUjOiH6zpUlz5@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUB75DCL4+8YO62iPVsnxoeXGv5cLmT7eP2bHNs=xoMdg@mail.gmail.com>
 <ZVzUr7TWEYPoZrWX@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fUWm7efu3xdUBbiifs_KNU1igwAxbXmum=V38SjHQHtXg@mail.gmail.com>
 <ZVzXjz_0nYbmSGPQ@FVFF77S0Q05N.cambridge.arm.com>
 <CAP-5=fWLGOCWv=wp2xsi4AVxfbS8KhkmtkMwOA4yVrz791=Z8Q@mail.gmail.com>
 <ZV38ParIEYWOjt6T@FVFF77S0Q05N>
 <CAP-5=fUxBv4kbXyLrD5G-=wyRh6tKEJMy5qX0_86wQXxT79dJw@mail.gmail.com>
 <ZV4nj-_q4hHaf8Wl@FVFF77S0Q05N>
 <CAP-5=fWtHYr9J2izkNmTpfKvdEdt0ViELJ1Gsih6H9XBTE83UA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWtHYr9J2izkNmTpfKvdEdt0ViELJ1Gsih6H9XBTE83UA@mail.gmail.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Wed, Nov 22, 2023 at 08:29:58AM -0800, Ian Rogers escreveu:
> I can look at doing an event parser change like:
> 
> ```
> diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
> index aa2f5c6fc7fc..9a18fda525d2 100644
> --- a/tools/perf/util/parse-events.c
> +++ b/tools/perf/util/parse-events.c
> @@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr *attr,
>                                                           err_str,
> /*help=*/NULL);
>                        return -EINVAL;
>                }
> -               if (perf_pmu__supports_legacy_cache(pmu)) {
> +               if (perf_pmu__supports_legacy_cache(pmu) &&
> +                   !perf_pmu__have_event(pmu, term->val.str)) {
>                        attr->type = PERF_TYPE_HW_CACHE;
>                        return
> parse_events__decode_legacy_cache(term->config, pmu->type,
>                                                                 &attr->config);
> @@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_attr *attr,
>                                                           err_str,
> /*help=*/NULL);
>                        return -EINVAL;
>                }
> -               attr->type = PERF_TYPE_HARDWARE;
> -               attr->config = term->val.num;
> -               if (perf_pmus__supports_extended_type())
> -                       attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
> +               if (perf_pmu__have_event(pmu, term->val.str)) {
> +                       /* If the PMU has a sysfs or json event prefer
> it over legacy. ARM requires this. */
> +                       term->term_type = PARSE_EVENTS__TERM_TYPE_USER;
> +               } else {
> +                       attr->type = PERF_TYPE_HARDWARE;
> +                       attr->config = term->val.num;
> +                       if (perf_pmus__supports_extended_type())
> +                               attr->config |= (__u64)pmu->type <<
> PERF_PMU_TYPE_SHIFT;
> +               }
>                return 0;
>        }
>        if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
> ```
> (note: this is incomplete as term->val.str isn't populated for
> PARSE_EVENTS__TERM_TYPE_HARDWARE)

Yeah, I had to apply manually as your MUA mangled it, then it didn't
build, had to remove some consts, then there was a struct member
mistake, after all fixed I get to the patch below, but it now segfaults,
probably what you mention...

root@roc-rk3399-pc:~# strace -e perf_event_open taskset -c 4,5 perf stat -v -e cycles,armv8_cortex_a53/cycles/,armv8_cortex_a72/cycles/ echo
Using CPUID 0x00000000410fd082
perf_event_open({type=PERF_TYPE_HARDWARE, size=0 /* PERF_ATTR_SIZE_??? */, config=0x7<<32|PERF_COUNT_HW_CPU_CYCLES, sample_period=0, sample_type=0, read_format=0, disabled=1, precise_ip=0 /* arbitrary skid */, ...}, 0, -1, -1, PERF_FLAG_FD_CLOEXEC) = -1 ENOENT (No such file or directory)
--- SIGSEGV {si_signo=SIGSEGV, si_code=SEGV_MAPERR, si_addr=NULL} ---
+++ killed by SIGSEGV +++
Segmentation fault
root@roc-rk3399-pc:~#

- Arnaldo

diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index aa2f5c6fc7fc..1e648454cc49 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -976,7 +976,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			   struct parse_events_error *err)
 {
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_LEGACY_CACHE) {
-		const struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
 		if (!pmu) {
 			char *err_str;
@@ -986,7 +986,8 @@ static int config_term_pmu(struct perf_event_attr *attr,
 							   err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
-		if (perf_pmu__supports_legacy_cache(pmu)) {
+		if (perf_pmu__supports_legacy_cache(pmu) &&
+		    !perf_pmu__have_event(pmu, term->val.str)) {
 			attr->type = PERF_TYPE_HW_CACHE;
 			return parse_events__decode_legacy_cache(term->config, pmu->type,
 								 &attr->config);
@@ -994,7 +995,7 @@ static int config_term_pmu(struct perf_event_attr *attr,
 			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
 	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_HARDWARE) {
-		const struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
+		struct perf_pmu *pmu = perf_pmus__find_by_type(attr->type);
 
 		if (!pmu) {
 			char *err_str;
@@ -1004,10 +1005,15 @@ static int config_term_pmu(struct perf_event_attr *attr,
 							   err_str, /*help=*/NULL);
 			return -EINVAL;
 		}
-		attr->type = PERF_TYPE_HARDWARE;
-		attr->config = term->val.num;
-		if (perf_pmus__supports_extended_type())
-			attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		if (perf_pmu__have_event(pmu, term->val.str)) {
+			/* If the PMU has a sysfs or JSON event prefer it over legacy. ARM requires this. */
+			term->type_term = PARSE_EVENTS__TERM_TYPE_USER;
+		} else {
+			attr->type = PERF_TYPE_HARDWARE;
+			attr->config = term->val.num;
+			if (perf_pmus__supports_extended_type())
+			    attr->config |= (__u64)pmu->type << PERF_PMU_TYPE_SHIFT;
+		}
 		return 0;
 	}
 	if (term->type_term == PARSE_EVENTS__TERM_TYPE_USER ||
