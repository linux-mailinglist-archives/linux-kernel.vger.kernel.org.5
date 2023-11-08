Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E15AD7E5AC3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:02:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232724AbjKHQCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:02:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjKHQCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:02:04 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 808991BC3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:02:02 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E19F4C433C9;
        Wed,  8 Nov 2023 16:02:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699459322;
        bh=JLwYuFK4M7vyPsXdMDw7ENdR++WIDDZ3oikeo1rQ96g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rnMZhLzT0cjJZN1K2lZYk952u5KEWRThBai27SG+8zMTX1uYraQhza1hBobcLq26z
         KnKFPLstsQO6RgsvBJlNBUAC4/bdbEDRWH8Gwp5TpQFNl08QWWM7yyaE1l1T1ewA7C
         vWo5TVo1x5u4W5FlvONzqGzdvOTvI8MVYA36tZzzo4x04mJyB+u0xAv1m+RertK6dA
         WsfNp5nLb2ZbEw5PJ/Auca71S/heuQMJ3RlpuEj63Tdj5xKADU7ijqL9K3vdJrJ1B0
         BWHeOxXfDrz1RBjabWcvAkw7Y6Wcz7S37bsffMB/nMKex60FZwn+P1XYt67onqqWIL
         J24iHyiIIK0NQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 24C0C4035D; Wed,  8 Nov 2023 13:01:59 -0300 (-03)
Date:   Wed, 8 Nov 2023 13:01:59 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Adrian Hunter <adrian.hunter@intel.com>
Cc:     Ian Rogers <irogers@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 02/53] perf record: Lazy load kernel symbols
Message-ID: <ZUuw9zDRLXPvCI5k@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-3-irogers@google.com>
 <0d232518-4bac-46cc-8635-d834fa232f85@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0d232518-4bac-46cc-8635-d834fa232f85@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 06, 2023 at 01:00:14PM +0200, Adrian Hunter escreveu:
> On 2/11/23 19:56, Ian Rogers wrote:
> > Commit 5b7ba82a7591 ("perf symbols: Load kernel maps before using")
> > changed it so that loading a kernel dso would cause the symbols for
> > the dso to be eagerly loaded. For perf record this is overhead as the
> > symbols won't be used. Add a symbol_conf to control the behavior and
> > disable it for perf record and perf inject.

> > Signed-off-by: Ian Rogers <irogers@google.com>
 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next.

- Arnaldo

