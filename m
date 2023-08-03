Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A4676E796
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 14:01:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235693AbjHCMBJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 08:01:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234223AbjHCMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 08:01:07 -0400
Received: from mgamail.intel.com (unknown [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A670B134
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691064066; x=1722600066;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WpiP6tIHJyDnELCjyGnEAZxhobpxPxNGSGyj5Hx3NIk=;
  b=J42Mo5/Ux3o6OBxueBWD10djpFb+P/ndkk8XNnkGgwPHrMkTj1bLt0Es
   9Vtlsn9dB1fOzAQDesN55np7YIKcHvxyofKKf6Xvl0fzCIooKczwnWP8f
   W57zYOLfHzE89tTu4GqJ5v6pzk+BBinHHbVfJeAwrybeQ8UoWDwHDefO4
   C+HIsTMaY6sjP4CgaNZjEX+/EkDBqn0Jx+F5Txwr2iDWEmx0r5u6xVhKc
   ihsJ29Tk8VSvvK4+AHdDZo0EHI0r12d83ljhACYTVQQFebLd6qMtfEhPz
   OwW1j5xR+zvRTiJMCbQKOaN2X2hD3DU2Veu8gBiT/7wC1EFwJQuThrGiZ
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="368750923"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="368750923"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:01:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="794975195"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="794975195"
Received: from gvarshne-mobl2.gar.corp.intel.com (HELO box.shutemov.name) ([10.252.63.106])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 05:01:02 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 72801109FCF; Thu,  3 Aug 2023 15:01:00 +0300 (+03)
Date:   Thu, 3 Aug 2023 15:01:00 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Ryan Roberts <ryan.roberts@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Yin Fengwei <fengwei.yin@intel.com>,
        David Hildenbrand <david@redhat.com>,
        Yu Zhao <yuzhao@google.com>, Yang Shi <shy828301@gmail.com>,
        "Huang, Ying" <ying.huang@intel.com>, Zi Yan <ziy@nvidia.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v4 0/3] Optimize large folio interaction with deferred
 split
Message-ID: <20230803120100.2glxdc4yf7sjn7h5@box.shutemov.name>
References: <20230727141837.3386072-1-ryan.roberts@arm.com>
 <b308fbb3-73a1-f8b4-3b08-ed5da044b2a9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b308fbb3-73a1-f8b4-3b08-ed5da044b2a9@arm.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 02, 2023 at 05:42:23PM +0100, Ryan Roberts wrote:
>  - avoid the split lock contention by using mmu gather (suggested by Kirill)

[Offlist]

So, my idea is to embed struct deferred_split into struct mmu_gather and
make zap path to use it instead of per-node/per-memcg deferred_split. This
would avoid lock contention. If the list is not empty after zap, move the
to the per-node/per-memcg deferred_split.

But it is only relevant if we see lock contention.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
