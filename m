Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCD7C792741
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236278AbjIEQCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354561AbjIEMk0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:40:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C42118D;
        Tue,  5 Sep 2023 05:40:20 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EDBC660686;
        Tue,  5 Sep 2023 12:40:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C63CC433C7;
        Tue,  5 Sep 2023 12:40:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693917619;
        bh=beRODS9NYcKlQSB25WXmlWwIwOWQhbiWrJCkehvjCO0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pMkVCa9aywMm+uN7iQSKUhFIovvYGElYMFesQ/Kfh0qR8MxeYHCibpoQpDtFFoVUN
         Ba6kDf3CbvD23Emg/ojfYvZiCNyM/3EiRBtzu1Hbdh7vw9zopKbhTRSLVFRTJ2hflP
         lay1jQLQ0PWLX7hdiEq9EfRk/2HIFpCL5VTd/SIpEet2nx1kpBY5TDx7+fW3OVfu+S
         fhbeb5r2FIsF9yAx1Lr8s6q+PMCNE9pxGEMY0wAb+ZLDhQgoQY4q6RnNjFd0jvIyKr
         9XrqhFQ+c97jpvmBY12NxBKRwazzeu8eHhIMImjAR99jTGHJ54muZWsIi1xqgRgHGl
         ekt6UHrne6tkQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B783B40722; Tue,  5 Sep 2023 09:40:16 -0300 (-03)
Date:   Tue, 5 Sep 2023 09:40:16 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     James Clark <james.clark@arm.com>
Cc:     Ian Rogers <irogers@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>
Subject: Re: [PATCH v1] perf parse-events: Fix driver config term
Message-ID: <ZPchsHYId3ylN2P4@kernel.org>
References: <20230905033805.3094293-1-irogers@google.com>
 <d7bae298-9d83-1bff-15a2-4ebe433ec8af@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7bae298-9d83-1bff-15a2-4ebe433ec8af@arm.com>
X-Url:  http://acmel.wordpress.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Tue, Sep 05, 2023 at 09:40:30AM +0100, James Clark escreveu:
> 
> 
> On 05/09/2023 04:38, Ian Rogers wrote:
> > Inadvertently deleted in commit 30f4ade33d64 ("perf tools: Revert
> > enable indices setting syntax for BPF map").
> > 
> > Reported-by: James Clark <james.clark@arm.com>
> > Signed-off-by: Ian Rogers <irogers@google.com>
> > ---
> >  tools/perf/util/parse-events.y | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> > 
> > diff --git a/tools/perf/util/parse-events.y b/tools/perf/util/parse-events.y
> > index 4a305df61f74..21bfe7e0d944 100644
> > --- a/tools/perf/util/parse-events.y
> > +++ b/tools/perf/util/parse-events.y
> > @@ -839,6 +839,23 @@ PE_TERM
> >  
> >  	$$ = term;
> >  }
> > +|
> > +PE_DRV_CFG_TERM
> > +{
> > +	struct parse_events_term *term;
> > +	char *config = strdup($1);
> > +	int err;
> > +
> > +	if (!config)
> > +		YYNOMEM;
> > +	err = parse_events_term__str(&term, PARSE_EVENTS__TERM_TYPE_DRV_CFG, config, $1, &@1, NULL);
> > +	if (err) {
> > +		free($1);
> > +		free(config);
> > +		PE_ABORT(err);
> > +	}
> > +	$$ = term;
> > +}
> >  
> >  sep_dc: ':' |
> >  
> 
> Reviewed-by: James Clark <james.clark@arm.com>



Thanks, applied.

- Arnaldo

