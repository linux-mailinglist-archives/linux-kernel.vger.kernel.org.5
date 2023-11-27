Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 126CC7FACE8
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 23:00:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233348AbjK0WAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 17:00:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbjK0WAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 17:00:02 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AC341A1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 14:00:09 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D392AC433C8;
        Mon, 27 Nov 2023 22:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701122409;
        bh=FFALWKc/ZBfqGfDdhBIDp6jyuxWJOXHiknj8f6bxGxw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DuTC72HSX5/ni6VtI6ee1ReyY5DM23etTVmz+W2dS1CZNxpRduOoSrK+NKhE1t792
         oN+W8RptKeRvwXtbiTZR/253B0TKUwphknKx2yOWKz7gRqJ6sCg0MgfkGnfJYhrFVw
         cv2AGseVPutOzVdNMRzH+K5rmJ2fLL8LhiVFt2CWRvm4ezgw9dLW7KWDZaZmiqx1WL
         DPTgywCoQW2OpU83HWGVdP4AWY1nKjDGkUKjCeZPuL7GPW0ZvziMmNN2504RSszbh8
         OrUdNYc2z/eLFoez7Ct34ShdGO5QpwiAY7nC/imxdxohqFcqLNikeQEYhsH/oTbl+3
         W8O3HvqFg5Q5A==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 3B4BF40094; Mon, 27 Nov 2023 19:00:06 -0300 (-03)
Date:   Mon, 27 Nov 2023 19:00:06 -0300
From:   Arnaldo Carvalho de Melo <acme@kernel.org>
To:     Ian Rogers <irogers@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
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
        linux-perf-users@vger.kernel.org
Subject: Re: [PATCH v4 04/53] perf mmap: Lazily initialize zstd streams
Message-ID: <ZWURZvDA2L4Mr3HR@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-5-irogers@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231102175735.2272696-5-irogers@google.com>
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

Em Thu, Nov 02, 2023 at 10:56:46AM -0700, Ian Rogers escreveu:
> Zstd streams create dictionaries that can require significant RAM,
> especially when there is one per-CPU. Tools like perf record won't use
> the streams without the -z option, and so the creation of the streams
> is pure overhead. Switch to creating the streams on first use.
> 
> Signed-off-by: Ian Rogers <irogers@google.com>

Thanks, applied to perf-tools-next.

- Arnaldo

