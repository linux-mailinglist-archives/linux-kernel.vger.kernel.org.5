Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E81F805C45
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 18:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442328AbjLEPT5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 10:19:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346848AbjLEPTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 10:19:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DB381A4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 07:19:57 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54631C433C8;
        Tue,  5 Dec 2023 15:19:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701789596;
        bh=ESDuP7NVVlvgAJpmS9L3L4ji0KgGi7hT55Q57KBxzu4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kBjvUUsE0hmw9JI2Ft9sn5J2xziqoli8xPJp2mIjjibv4EGtM8TNNevzF/QZDuHwa
         MK5XVsaRAnGzogU77hYHgf64XoL5NwjdCYWf5J/akr+8Kw0rcaQ44+wGy8Y9Is47ef
         QTOjutmydzGoGsTwdwR6w5UF0MafyFAdUb/2qRsLEtZ6fNlwGebfdzhChV/aOdppGx
         t9hHxD+OS+FEux5L6ZVKXL++0XBUfoMvb64etlUWp/RwCqeelUnxYKwYXY7dahKlMP
         Uvy3lzFLIANxKb7/+naCjER9wYcDAVPUt0g24vUAvaL8oy9CyIXB9d33iaboFJJxaB
         oKvwb5gpw1zZw==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id B953740094; Tue,  5 Dec 2023 12:19:53 -0300 (-03)
Date:   Tue, 5 Dec 2023 12:19:53 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ilkka Koskinen <ilkka@os.amperecomputing.com>
Cc:     Ian Rogers <irogers@google.com>,
        John Garry <john.g.garry@oracle.com>,
        Will Deacon <will@kernel.org>,
        James Clark <james.clark@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 1/2] perf metrics: Avoid segv if default metricgroup
 isn't set
Message-ID: <ZW8/mWUuctdg/8fE@kernel.org>
References: <20231204182330.654255-1-irogers@google.com>
 <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bea4ad79-297e-9737-8af1-2286192d26f4@os.amperecomputing.com>
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

Em Mon, Dec 04, 2023 at 02:44:54PM -0800, Ilkka Koskinen escreveu:
> 
> 
> On Mon, 4 Dec 2023, Ian Rogers wrote:
> > A metric is default by having "Default" within its groups. The default
> > metricgroup name needn't be set and this can result in segv in
> > default_metricgroup_cmp and perf_stat__print_shadow_stats_metricgroup
> > that assume it has a value when there is a Default metric group. To
> > avoid the segv initialize the value to "".
> > 
> > Fixes: 1c0e47956a8e ("perf metrics: Sort the Default metricgroup")
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Thanks! I was going to look for the bug but got pulled to other tasks. The
> patch looks good to me and I tested it successfully on AmpereOne.
> 
>   Reviewed-and-tested-by: Ilkka Koskinen <ilkka@os.amperecomputing.com>

Thanks, applied to perf-tools-next.

- Arnaldo

