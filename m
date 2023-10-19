Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D197CF653
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 13:12:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345316AbjJSLMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 07:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345037AbjJSLMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 07:12:19 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6291313A
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 04:12:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=Nw5Gk35NEIfC2Li/28jQ70AKaQXVN3S7LVGM18nIWg8=; b=Li95tS5sxjc2hJYoR16kuiR1YD
        yIRBnYzPiUxPJbOK+A/qCZ6CoLCDeMy7mqtkQiQHHGuqe72qvBeyHtnYt3woMfI96dngo2HZjGIrN
        aDVHL1xIAjpcBnxdPDiFQk1nBl8IZdykCHCHxLM1gh2l6w5mGYo/6zwnawShPMAVbHcpKMwUypBrm
        F6AM95+VWfsmH7b+sGMALa8OikjYQDaVvYDID1OmyXKtS+rs9tZJAlpCFSRyVHubp+hWEEJF22rPg
        vBYmzspiEYPIjRGMNAKFFjrZrpKIWGpNrlVKaBheckjkf7O3f/rLY3qI4TfaIZ90wiJr/ZyNth0C0
        KwH+jFtA==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qtQwd-006hTP-Bt; Thu, 19 Oct 2023 11:12:03 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
        id 0B2C7300392; Thu, 19 Oct 2023 13:12:03 +0200 (CEST)
Date:   Thu, 19 Oct 2023 13:12:02 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     kan.liang@linux.intel.com
Cc:     mingo@redhat.com, acme@kernel.org, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, ak@linux.intel.com, eranian@google.com,
        alexey.v.bayduraev@linux.intel.com, tinghao.zhang@intel.com
Subject: Re: [PATCH V4 4/7] perf/x86/intel: Support LBR event logging
Message-ID: <20231019111202.GJ36211@noisy.programming.kicks-ass.net>
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
> +static __always_inline void get_lbr_events(struct cpu_hw_events *cpuc,
> +					   int i, u64 info)
> +{
> +	/*
> +	 * The later code will decide what content can be disclosed
> +	 * to the perf tool. It's no harmful to unconditionally update
> +	 * the cpuc->lbr_events.
> +	 * Pleae see intel_pmu_lbr_event_reorder()
> +	 */
> +	cpuc->lbr_events[i] = info & LBR_INFO_EVENTS;
> +}

You could be forcing an extra cachemiss here. A long time ago I had
hacks to profile perf with perf, but perhaps PT can be abused for that
now?
