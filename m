Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C35047B6CA6
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 17:09:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240194AbjJCPJS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 11:09:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbjJCPJR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 11:09:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3BEA1
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 08:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696345754; x=1727881754;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=nZ87GGtYEc0gY0sa1LHAtlEDPbNdG2W6N+19W0P2918=;
  b=fW08nzPiyZ9yDA7hux0bWZNfVTapDLj0OZN8+pQTCNBKgB7MU2njbnX/
   k9SYIZgk3c/ybkQKdNC+cRWfLWE/U8cMu/8uJ3bCgOq1SV1B7rGcLE9Np
   4VtMx612zuFvgPS3VR9R5FAdyXo2cNqw5QheH493HBsx8z0xY8YVKV/p5
   3UW1oARnEB3ObnuLKNAWvQrg6Ach1rhKVp2b53htyKnCU7zMwNYgW56xI
   VMxwOjyBsUKedOoSj/2RgTdEFkg4h+AHadjqI1AsSwVSWokwrzuCs5ewn
   cBPyB+pxCvBrKXhTYsWiUolp69i2szZs64krd/VdzzN4JhTcOJ2qiecC3
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="381779999"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="381779999"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:07:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10852"; a="998066313"
X-IronPort-AV: E=Sophos;i="6.03,197,1694761200"; 
   d="scan'208";a="998066313"
Received: from tassilo.jf.intel.com (HELO tassilo) ([10.54.38.190])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 08:07:00 -0700
Date:   Tue, 3 Oct 2023 08:06:59 -0700
From:   Andi Kleen <ak@linux.intel.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Liang, Kan" <kan.liang@linux.intel.com>, mingo@redhat.com,
        acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com,
        Sandipan Das <sandipan.das@amd.com>,
        Ravi Bangoria <ravi.bangoria@amd.com>,
        Athira Rajeev <atrajeev@linux.vnet.ibm.com>
Subject: Re: [RESEND PATCH V3 1/6] perf: Add branch stack extra
Message-ID: <ZRwuE8LPkwtkjX5C@tassilo>
References: <20230911154822.2559213-1-kan.liang@linux.intel.com>
 <20231002154535.GB35785@noisy.programming.kicks-ass.net>
 <ce16c6c1-9bdc-35e2-fe85-155bd7edbaa4@linux.intel.com>
 <20231002213752.GB1539@noisy.programming.kicks-ass.net>
 <ed169d4d-76d5-c134-c685-ad3d812028be@linux.intel.com>
 <20231003102733.GC1539@noisy.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003102733.GC1539@noisy.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm thinking we should do something like expose branch_counter_nr and
> branch_counter_width in the sysfs node, and then rename this extra field
> to counters.
> 
> Then userspace can do something like:
> 
> 	for (i = 0; i < branch_counter_nr; i++) {
> 		counter[i] = counters & ((1 << branch_counter_width) - 1);
> 		counters >>= branch_counter_width;
> 	}
> 
> to extract the actual counter values.

perf script/report won't necessarily have access to the sysfs
values if they run on a different system

It would need extra PT style metadata written by perf record to
perf.data and read by the user tools.

Seems complicated. It would be better if it just parsed on its own.

-Andi

