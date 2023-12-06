Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8894E807130
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 14:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378613AbjLFNui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 08:50:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378530AbjLFNug (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 08:50:36 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E1DD4F
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 05:50:42 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5A94C433C8;
        Wed,  6 Dec 2023 13:50:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701870642;
        bh=uCGoGVcttTSCzC+PBnMTHcee7rAJ4T550zU26XqPTWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O6Dn1VAZUcaGjyLS8uMDLSsxvn6GMyS4hF5jYFb3UG63O0CBODCMg+Q/Quw8jVuRv
         X/quQU2pjg37pkXoxYijCug45FHtvFQYHxsnJ/5c8ZWus2Mzn9h4zt745mRKw4Rcn3
         QGj71/nMYRtHrYElOkJozDPCYD3TSV5K9I7cUOGybKuydK/WHZF9+L6wquEJSinGVH
         uXTRic/FupTI2m+PWmDkvty0RXnYfNLuOcjRLu4YB7RlaUVvBQVQbstiY+xrhZuGe2
         9drup1MPnU6xgWnoUUMdzPbvoTdu4XP6xZyL+KCKwTPxESGDgBL/+68BODuJk0J8fW
         4b8cPa/kaLmeA==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 6FCFD403EF; Wed,  6 Dec 2023 10:50:39 -0300 (-03)
Date:   Wed, 6 Dec 2023 10:50:39 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Namhyung Kim <namhyung@kernel.org>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Nick Terrell <terrelln@fb.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>,
        Huacai Chen <chenhuacai@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        "Steinar H. Gunderson" <sesse@google.com>,
        Liam Howlett <liam.howlett@oracle.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Colin Ian King <colin.i.king@gmail.com>,
        Dmitrii Dolgov <9erthalion6@gmail.com>,
        Yang Jihong <yangjihong1@huawei.com>,
        Ming Wang <wangming01@loongson.cn>,
        James Clark <james.clark@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Sean Christopherson <seanjc@google.com>,
        Leo Yan <leo.yan@linaro.org>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        German Gomez <german.gomez@arm.com>,
        Changbin Du <changbin.du@huawei.com>,
        Paolo Bonzini <pbonzini@redhat.com>, Li Dong <lidong@vivo.com>,
        Sandipan Das <sandipan.das@amd.com>,
        liuwenyu <liuwenyu7@huawei.com>, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Guilherme Amadio <amadio@gentoo.org>
Subject: Re: [PATCH v5 13/50] perf maps: Move symbol maps functions to maps.c
Message-ID: <ZXB8L8xhGATtPJJ/@kernel.org>
References: <20231127220902.1315692-1-irogers@google.com>
 <20231127220902.1315692-14-irogers@google.com>
 <CAM9d7chEb_ij73ZhBr9EpT7HE34Hy0aqTOmSWp_-xTwc2=0Zjg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAM9d7chEb_ij73ZhBr9EpT7HE34Hy0aqTOmSWp_-xTwc2=0Zjg@mail.gmail.com>
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

Em Mon, Dec 04, 2023 at 03:40:55PM -0800, Namhyung Kim escreveu:
> On Mon, Nov 27, 2023 at 2:09 PM Ian Rogers <irogers@google.com> wrote:
> >
> > Move the find and certain other symbol maps__* functions to maps.c for
> > better abstraction.
> >
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> Acked-by: Namhyung Kim <namhyung@kernel.org>

Thanks, applied to perf-tools-next.

- Arnaldo

