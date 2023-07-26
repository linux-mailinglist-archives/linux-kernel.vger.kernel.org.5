Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 393E4764005
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 21:55:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232246AbjGZTzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 15:55:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232166AbjGZTy4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 15:54:56 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D16EE1BF6;
        Wed, 26 Jul 2023 12:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=+sjmv9pr64iRjIpEvcW+PMYy8Vwjlj4j8rPWgraZnrY=; b=EubcXkNMSbl8RgGlP5/BfrOYz1
        R03MQHY9xkTpyY/Hr7t42wS48d6jace3WCnvwwCI4z/uo0dROX1lsugwabY5wGNvkg4w59iuWevxS
        Xy5cIzRAoP0UG0kxgrvjSS/UOL39P9LiJvE84VIA9Rp2covc06PbKwhtHSwxL3zreaagDn7tqhxeq
        nPtE+B163aH+EnYFgaB6zXBHS+/A+jR+2Me1/NMgT7PO1NgNemUDAi+4+lShDYYBdt2UDSx5XEpt/
        ns1mQRmUIMgnqEuYnvVMCsOYDvrGuX24ckftJ6eZkcTXatpAjnryrh1pj/hkp38maFlC89oI5iQzI
        NC9o7Q1g==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qOkam-006njv-5X; Wed, 26 Jul 2023 19:54:42 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 48B5D30057C;
        Wed, 26 Jul 2023 21:54:39 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 06994205963B6; Wed, 26 Jul 2023 12:16:05 +0200 (CEST)
Date:   Wed, 26 Jul 2023 12:16:05 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ravi Bangoria <ravi.bangoria@amd.com>
Cc:     namhyung@kernel.org, acme@kernel.org, mingo@kernel.org,
        eranian@google.com, kan.liang@linux.intel.com, jolsa@kernel.org,
        irogers@google.com, adrian.hunter@intel.com, leo.yan@linaro.org,
        kjain@linux.ibm.com, linux-perf-users@vger.kernel.org,
        linux-kernel@vger.kernel.org, sandipan.das@amd.com,
        ananth.narayan@amd.com, santosh.shukla@amd.com
Subject: Re: [RESEND][PATCH v4 0/3] perf/mem: AMD IBS improvements
Message-ID: <20230726101605.GC3802077@hirez.programming.kicks-ass.net>
References: <20230725150206.184-1-ravi.bangoria@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230725150206.184-1-ravi.bangoria@amd.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:32:03PM +0530, Ravi Bangoria wrote:
> Namhyung Kim (1):
>   perf/x86/ibs: Set mem_lvl_num, mem_remote and mem_hops for data_src
> 
> Ravi Bangoria (2):
>   perf/mem: Introduce PERF_MEM_LVLNUM_UNC
>   perf/mem: Add PERF_MEM_LVLNUM_NA to PERF_MEM_NA
> 
>  arch/x86/events/amd/ibs.c       | 156 ++++++++++++++------------------
>  include/linux/perf_event.h      |   3 +-
>  include/uapi/linux/perf_event.h |   3 +-
>  3 files changed, 72 insertions(+), 90 deletions(-)

Thanks!
