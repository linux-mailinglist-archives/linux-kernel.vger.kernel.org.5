Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C03197CF888
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 14:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345378AbjJSMQt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Oct 2023 08:16:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233166AbjJSMQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 08:16:47 -0400
Received: from outbound-smtp41.blacknight.com (outbound-smtp41.blacknight.com [46.22.139.224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08462A3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 05:16:44 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp41.blacknight.com (Postfix) with ESMTPS id 84DB420D4
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:16:43 +0100 (IST)
Received: (qmail 8912 invoked from network); 19 Oct 2023 12:16:43 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.199.31])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 19 Oct 2023 12:16:43 -0000
Date:   Thu, 19 Oct 2023 13:16:40 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Huang Ying <ying.huang@intel.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH -V3 6/9] mm: add framework for PCP high auto-tuning
Message-ID: <20231019121640.ao2zvxlspgfkbwsr@techsingularity.net>
References: <20231016053002.756205-1-ying.huang@intel.com>
 <20231016053002.756205-7-ying.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20231016053002.756205-7-ying.huang@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 01:29:59PM +0800, Huang Ying wrote:
> The page allocation performance requirements of different workloads
> are usually different.  So, we need to tune PCP (per-CPU pageset) high
> to optimize the workload page allocation performance.  Now, we have a
> system wide sysctl knob (percpu_pagelist_high_fraction) to tune PCP
> high by hand.  But, it's hard to find out the best value by hand.  And
> one global configuration may not work best for the different workloads
> that run on the same system.  One solution to these issues is to tune
> PCP high of each CPU automatically.
> 
> This patch adds the framework for PCP high auto-tuning.  With it,
> pcp->high of each CPU will be changed automatically by tuning
> algorithm at runtime.  The minimal high (pcp->high_min) is the
> original PCP high value calculated based on the low watermark pages.
> While the maximal high (pcp->high_max) is the PCP high value when
> percpu_pagelist_high_fraction sysctl knob is set to
> MIN_PERCPU_PAGELIST_HIGH_FRACTION.  That is, the maximal pcp->high
> that can be set via sysctl knob by hand.
> 
> It's possible that PCP high auto-tuning doesn't work well for some
> workloads.  So, when PCP high is tuned by hand via the sysctl knob,
> the auto-tuning will be disabled.  The PCP high set by hand will be
> used instead.
> 
> This patch only adds the framework, so pcp->high will be set to
> pcp->high_min (original default) always.  We will add actual
> auto-tuning algorithm in the following patches in the series.
> 
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>

Acked-by: Mel Gorman <mgorman@techsingularity.net>

-- 
Mel Gorman
SUSE Labs
