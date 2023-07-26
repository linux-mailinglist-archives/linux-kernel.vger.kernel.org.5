Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5168A763A9A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 17:15:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234868AbjGZPPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 11:15:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjGZPOq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 11:14:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D149C421E;
        Wed, 26 Jul 2023 08:14:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690384452; x=1721920452;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=twdnQmWxP0xXWy9qV4unW07+aDwHB9IVDIUtmrg3iVc=;
  b=nXIoviKcpNAc7mB93v/2dmuFi576PBG9wqlJvb0GvZGcyZgnFw7U0pfx
   v7Y584+vyDFDNWcRhHY9HSbOpomuhNcYfS7cum+uWClnArvjDKzFUxMwp
   bXBsry1WTGCT7JjQNPihZYivNC6dX5+8i7qn90L8bZhjx1zB4bbVb0pNC
   9NZx5HqGNAy7SCYm6jM9oEbHC0MbiHtN8qR1tTw0fvvNjggScuvtwSUgL
   lnSI86ZZu+uQ+bFxRZa6W3SwFM+44zR960oQiJTpHyqT/hsko51Z7k+k+
   ZOPA/i0eI3mctbi5eVVdCtC4BS92E8MwnTf0wGS5yVmJjVNwMliUJ1mef
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="431845185"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="431845185"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:13:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="720503292"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="720503292"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 08:13:44 -0700
Date:   Wed, 26 Jul 2023 08:13:43 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Ian Rogers <irogers@google.com>
Cc:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Zhengjun Xing <zhengjun.xing@linux.intel.com>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1 0/3] Parse event sort/regroup fixes
Message-ID: <ZME4Jxg5g21B2l4Y@tassilo>
References: <20230719001836.198363-1-irogers@google.com>
 <ZLf4C/+x2ZSpb1Uz@kernel.org>
 <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAP-5=fWXd8KhvxnPjjFjtybNZ7BsN6n_55xFaEA_-Jda0g2+XQ@mail.gmail.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Andi,
> >
> >         Can you please check these patches and provide a Tested-by?
> 
> I think we should be aiming to get these fixes/changes into Linux 6.5
> and it's a shame this didn't happen last week. Feedback appreciated.

Sorry was on vacation. Will test right now.

-Andi
