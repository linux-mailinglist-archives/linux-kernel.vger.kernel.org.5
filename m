Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFB8782B02
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234222AbjHUNy5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:54:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231940AbjHUNy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:54:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBE3EE6;
        Mon, 21 Aug 2023 06:54:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7886B63827;
        Mon, 21 Aug 2023 13:54:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9894FC433CB;
        Mon, 21 Aug 2023 13:54:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692626093;
        bh=JzwwWYWCYGdvrkAehVkAsqLFKvXhhaUaRSamrxLX/ps=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=svKLOfyrj4t2AoMvq2t39D+KtWXk+Eob7vhxs4NsyPvSKHDj2uhoOUUjTOOa05sI/
         DNxxbvdb3zL59215dkOnJ3tPoqzk0T/Imb3F6TNrRnT0IppEiey6dEUswqC8ej7JXx
         BoZCcka/5BSqpC1Kb/hc8fxPthyc+OB1+LZpZOaMfbabFul0VIxV7eFx5/pwaDm0HD
         SOThVDmIP9TeoINg1Y2AHMfp9zLMH0Z3eFoM22THmXY9dRBgJ2eIiYiqSLmTJQvCpm
         HeiLMitXg+2Hd0EqqZUaJ9AKS5X6DdqIZq/+bvyYYQPavrD/AiUObKzWDuAC+fb/Hn
         +ynPy3Np2ieGw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 0AA9740722; Mon, 21 Aug 2023 10:54:51 -0300 (-03)
Date:   Mon, 21 Aug 2023 10:54:50 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Kaige Ye <ye@kaige.org>, peterz@infradead.org, mingo@redhat.com,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, adrian.hunter@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] perf stat-display: Check if snprintf()'s fmt argument
 is NULL
Message-ID: <ZONsqpxUYAJWjxM1@kernel.org>
References: <01CA7674B690CA24+20230804020907.144562-2-ye@kaige.org>
 <CAP-5=fWxxaL7xqTFmButfVUEBCXB9PQOVovooMq+Z7NqP=10HA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fWxxaL7xqTFmButfVUEBCXB9PQOVovooMq+Z7NqP=10HA@mail.gmail.com>
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

Em Mon, Aug 14, 2023 at 01:24:06PM -0700, Ian Rogers escreveu:
> On Thu, Aug 3, 2023 at 7:10 PM Kaige Ye <ye@kaige.org> wrote:
> >
> > It is undefined behavior to pass NULL as snprintf()'s fmt argument.
> > Here is an example to trigger the problem:
> >
> >   $ perf stat --metric-only -x, -e instructions -- sleep 1
> >   insn per cycle,
> >   Segmentation fault (core dumped)
> >
> > With this patch:
> >
> >   $ perf stat --metric-only -x, -e instructions -- sleep 1
> >   insn per cycle,
> >   ,
> >
> > Signed-off-by: Kaige Ye <ye@kaige.org>
> 
> Thanks Kaige!
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied.

- Arnaldo

 
> > ---
> > V1 -> V2: Addressed Ian's comments (Ian Rogers)
> > ---
> >  tools/perf/util/stat-display.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
> > index 7329b3340..031888545 100644
> > --- a/tools/perf/util/stat-display.c
> > +++ b/tools/perf/util/stat-display.c
> > @@ -578,7 +578,7 @@ static void print_metric_only_csv(struct perf_stat_config *config __maybe_unused
> >         if (!valid_only_metric(unit))
> >                 return;
> >         unit = fixunit(tbuf, os->evsel, unit);
> > -       snprintf(buf, sizeof buf, fmt, val);
> > +       snprintf(buf, sizeof(buf), fmt ?: "", val);
> >         ends = vals = skip_spaces(buf);
> >         while (isdigit(*ends) || *ends == '.')
> >                 ends++;
> > @@ -600,7 +600,7 @@ static void print_metric_only_json(struct perf_stat_config *config __maybe_unuse
> >         if (!valid_only_metric(unit))
> >                 return;
> >         unit = fixunit(tbuf, os->evsel, unit);
> > -       snprintf(buf, sizeof(buf), fmt, val);
> > +       snprintf(buf, sizeof(buf), fmt ?: "", val);
> >         ends = vals = skip_spaces(buf);
> >         while (isdigit(*ends) || *ends == '.')
> >                 ends++;
> >
> > base-commit: f6b8436bede3e80226e8b2100279c4450c73806a
> > --
> > 2.41.0
> >

-- 

- Arnaldo
