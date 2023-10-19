Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1D7CF600
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:01:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345037AbjJSLBQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:01:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233051AbjJSLBO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:01:14 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8020F119
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p5y1GR1B+mQuth538qnCal0GEX1DvhgZa+zjCyCIpqE=; b=Z+2hlmkQmIexxPUEyXz6JKS1ZK
        gw+4OYbH6GkgFWgntXnwDX/KSNxgUlaFWu00DlXhNvtsXMZaOIhRPlkku/ko42/fb45ufScAfPccR
        O00EIi6O3ivhs4Gxwj1bA39uE1sGju4qsCuiLBUYlCLQbn8tQ2zUo9JNTkSep4zFpY2JO5myNRQ9d
        O4moHKZ7dO1oN2jdyniNn0NcA3/7CYutbOQiVx1fHIqfkhRfYJqjbu4inZAWCit/YBBhNcmIiJE9v
        nOT3Lj19I7D9C92jzz39PthSrdBpsxjcVh734ZAfh1qm6KQJ/xmg6TYeSgYLToPHCLZTH8Y6jhbom
        IbXzKp1Q==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qtQls-009nI9-37;
        Thu, 19 Oct 2023 11:00:59 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id A213D300392; Thu, 19 Oct 2023 13:00:56 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:00:56 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019110056.GH36211@noisy.programming.kicks-ass.net>
References: <20231004184044.3062788-1-kan.liang@linux.intel.com>
 <20231004184044.3062788-4-kan.liang@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231004184044.3062788-4-kan.liang@linux.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 04, 2023 at 11:40:41AM -0700, kan.liang@linux.intel.com wrote:

> +static ssize_t branch_counter_width_show(struct device *cdev,
> +					 struct device_attribute *attr,
> +					 char *buf)
> +{
> +	return snprintf(buf, PAGE_SIZE, "2\n");
> +}

> +#define ARCH_LBR_EVENT_LOG_WIDTH	2

I'm assuming this is the same '2' ? And having it hard-coded in two
locations is awesome..

> +#define ARCH_LBR_EVENT_LOG_MASK		0x3

Should probably be ((1<<2)-1)

As per that other email, the naming is confusing, should this not be:

ARCH_LBR_EVENT_COUNTER_BITS

or, since it's all local to lbr.c something shorter still, like:

LBR_COUNTER_BITS

hmm?

