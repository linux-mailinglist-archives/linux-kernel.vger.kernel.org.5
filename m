Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8107F34E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 18:23:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233671AbjKURXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 12:23:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230052AbjKURX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 12:23:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E31113
        for <linux-kernel@vger.kernel.org>; Tue, 21 Nov 2023 09:23:24 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748E7C433C8;
        Tue, 21 Nov 2023 17:23:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700587404;
        bh=/AUV+T6dC4Jy/S3IQTHApQXK2DkGP6Vfy23a7EuIvPY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tyWpJe5OcyLhfTFF9PqLPR/vnTVJ7yoOnLGeFEtTT25znxVoqK+4d/dJ0dtzqWDNA
         rdvdL3bjdTlNNQxeL8rP5TToGieiLWX9BoyIG3WmEOBkrr12BvI9rUak6CPmcSTf6c
         dhgI070/vfz8QdhZORqr1uHKT8h1jZMR4RXX/VWMunzaXCrCtHYnppnCaz45Q40Kph
         jWP0VYWzr9k3etTsgqixpQbL9ils+kQbsPngzcBIPWJlw5VaTeLdaJMMpxf2gFPGj9
         ShKIyiEUAPKR4X0yVyqQZ+XUiIqEZXum19BcafJ147FvZ3imDP4jnu3Qk8G+ZPWKcS
         eYYcr6i/dxrMg==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 2FD1640094; Tue, 21 Nov 2023 14:23:22 -0300 (-03)
Date:   Tue, 21 Nov 2023 14:23:22 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     zhaimingbing <zhaimingbing@cmss.chinamobile.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Sean Christopherson <seanjc@google.com>,
        Li Dong <lidong@vivo.com>, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] perf script perl: Fail check on dynamic allocation
Message-ID: <ZVznim5Grz/biW76@kernel.org>
References: <20231120112356.8652-1-zhaimingbing@cmss.chinamobile.com>
 <CAP-5=fU4FBah=S_C7Zwh3MSNjwWtT5WrVB9OCc1jRM3eDCykng@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAP-5=fU4FBah=S_C7Zwh3MSNjwWtT5WrVB9OCc1jRM3eDCykng@mail.gmail.com>
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

Em Mon, Nov 20, 2023 at 04:30:28PM -0800, Ian Rogers escreveu:
> On Mon, Nov 20, 2023 at 3:24 AM zhaimingbing
> <zhaimingbing@cmss.chinamobile.com> wrote:
> >
> > Return ENOMEM when dynamic allocation failed.
> >
> > Signed-off-by: zhaimingbing <zhaimingbing@cmss.chinamobile.com>
> 
> Reviewed-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

 
> Thanks,
> Ian
> 
> > ---
> >  tools/perf/util/scripting-engines/trace-event-perl.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/tools/perf/util/scripting-engines/trace-event-perl.c b/tools/perf/util/scripting-engines/trace-event-perl.c
> > index 603091317..b072ac5d3 100644
> > --- a/tools/perf/util/scripting-engines/trace-event-perl.c
> > +++ b/tools/perf/util/scripting-engines/trace-event-perl.c
> > @@ -490,6 +490,9 @@ static int perl_start_script(const char *script, int argc, const char **argv,
> >         scripting_context->session = session;
> >
> >         command_line = malloc((argc + 2) * sizeof(const char *));
> > +       if (!command_line)
> > +               return -ENOMEM;
> > +
> >         command_line[0] = "";
> >         command_line[1] = script;
> >         for (i = 2; i < argc + 2; i++)
> > --
> > 2.33.0
> >
> >
> >
> >

-- 

- Arnaldo
