Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4201D7A96C8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Sep 2023 19:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbjIURH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Sep 2023 13:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjIURHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Sep 2023 13:07:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C6DB2101
        for <linux-kernel@vger.kernel.org>; Thu, 21 Sep 2023 10:03:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63CCC4E772;
        Thu, 21 Sep 2023 15:46:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1695311178;
        bh=XbJgWS2b4Zs6ittxozTQbmeIioM0YEqG8HDmDMXPv/U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=EmOPQtjpihFmSGI9lHQLn9ZbTdoa0pDV27Y6p+DgCqQoWSEhawxxqTaWPvbBMcyJx
         8UpdnxNbLOTXxxk/BLuxsf5jEk3FvH8kQjP6E9KJ5eR44XXCyBAEdKjkqVSBXXwJJL
         9jM2G7bH41H4C/HV/mVrPcN1LEbU5kxxFGjheoTQ=
Date:   Thu, 21 Sep 2023 08:46:17 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     "Huang, Ying" <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Arjan Van De Ven <arjan@linux.intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Hildenbrand <david@redhat.com>,
        Johannes Weiner <jweiner@redhat.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Michal Hocko <mhocko@suse.com>,
        Pavel Tatashin <pasha.tatashin@soleen.com>,
        Matthew Wilcox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>
Subject: Re: [PATCH 00/10] mm: PCP high auto-tuning
Message-Id: <20230921084617.b1129a46de247e4a6f0098af@linux-foundation.org>
In-Reply-To: <87leczwt1o.fsf@yhuang6-desk2.ccr.corp.intel.com>
References: <20230920061856.257597-1-ying.huang@intel.com>
        <20230920094118.8b8f739125c6aede17c627e0@linux-foundation.org>
        <87leczwt1o.fsf@yhuang6-desk2.ccr.corp.intel.com>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 21 Sep 2023 21:32:35 +0800 "Huang, Ying" <ying.huang@intel.com> wrote:

> >   : It's possible that PCP high auto-tuning doesn't work well for some
> >   : workloads.  So, when PCP high is tuned by hand via the sysctl knob,
> >   : the auto-tuning will be disabled.  The PCP high set by hand will be
> >   : used instead.
> >
> >   Is it a bit hacky to disable autotuning when the user alters
> >   pcp-high?  Would it be cleaner to have a separate on/off knob for
> >   autotuning?
> 
> This was suggested by Mel Gormon,
> 
> https://lore.kernel.org/linux-mm/20230714140710.5xbesq6xguhcbyvi@techsingularity.net/
> 
> "
> I'm not opposed to having an adaptive pcp->high in concept. I think it would
> be best to disable adaptive tuning if percpu_pagelist_high_fraction is set
> though. I expect that users of that tunable are rare and that if it *is*
> used that there is a very good reason for it.
> "
> 
> Do you think that this is reasonable?

I suppose so, if it's documented!

Documentation/admin-guide/sysctl/vm.rst describes
percpu_pagelist_high_fraction.
