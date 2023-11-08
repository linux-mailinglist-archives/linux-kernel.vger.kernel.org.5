Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC3DC7E5AC7
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231867AbjKHQEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjKHQEw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:04:52 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FD221BD7
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 08:04:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F043C433C8;
        Wed,  8 Nov 2023 16:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699459489;
        bh=qmF7hG0v0kmRv1CntymwM7/fOSf0jDyD41yeDqzS85o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qzDLvVTK52EcL0XKGJ76/899Q4vfJ/kV3Odc8Kx+WQfjcIwrdDyhNN42Dxgfro9ju
         v//BbyZJ129NPxOxaLz3nOwiVKtbMsBszc5RX/jVBdbSL/DXbnv4U8klgR2D6vj3Lk
         bTiis0GX8rGtXQi2PH61p6rRxFCqG9a41lnTGOcMAh2wPsTEdSP867wdi6CJERKLCc
         lydjM8hyPQNZ4EpP9iJtZnJSqbmoNUOBlS0sE4KmgpFT7maDfYFD5PEqFM2RwyBulh
         Mrd7F6HpB+O5PiPGLR+9HQeOI4ogLbYwIPodZcyokjoVQW6rwywIjJ36IJLf/6T+rx
         1ZeNkPsJ1B6vQ==
Received: by quaco.ghostprotocols.net (Postfix, from userid 1000)
        id 1396B4035D; Wed,  8 Nov 2023 13:04:47 -0300 (-03)
Date:   Wed, 8 Nov 2023 13:04:46 -0300
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
Subject: Re: [PATCH v4 05/53] perf machine thread: Remove exited threads by
 default
Message-ID: <ZUuxnhu5xrgRw1HR@kernel.org>
References: <20231102175735.2272696-1-irogers@google.com>
 <20231102175735.2272696-6-irogers@google.com>
 <371634c4-756a-498c-a46d-7459a07075e0@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <371634c4-756a-498c-a46d-7459a07075e0@intel.com>
X-Url:  http://acmel.wordpress.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Em Mon, Nov 06, 2023 at 01:28:43PM +0200, Adrian Hunter escreveu:
> On 2/11/23 19:56, Ian Rogers wrote:
> > struct thread values hold onto references to mmaps, dsos, etc. When a
> > thread exits it is necessary to clean all of this memory up by
> > removing the thread from the machine's threads. Some tools require
> > this doesn't happen, such as auxtrace events, perf report if offcpu
> > events exist or if a task list is being generated, so add a
> > symbol_conf value to make the behavior optional. When an exited thread
> > is left in the machine's threads, mark it as exited.
> > 
> > This change relates to commit 40826c45eb0b ("perf thread: Remove
> > notion of dead threads"). Dead threads were removed as they had a
> > reference count of 0 and were difficult to reason about with the
> > reference count checker. Here a thread is removed from threads when it
> > exits, unless via symbol_conf the exited thread isn't remove and is
> > marked as exited. Reference counting behaves as it normally does.
> > 
> > Signed-off-by: Ian Rogers <irogers@google.com>
> 
> For auxtrace:
> 
> Reviewed-by: Adrian Hunter <adrian.hunter@intel.com>

Thanks, applied to perf-tools-next.

- Arnaldo

