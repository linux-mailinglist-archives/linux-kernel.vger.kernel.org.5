Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897907BF594
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 10:20:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442793AbjJJIUP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 04:20:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442783AbjJJIT7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 04:19:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62881FF
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 01:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696925984; x=1728461984;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=sk+nnPqYTn+YyXOxRcQSUiESqi6TufJlzBVbwS0YCZA=;
  b=ViOD5H8EfaDa2bXfQdbpyj5pFUisMs4zikb2vj/abQn331DDrgC9sFUt
   Q2stSQ7Fg8AwD4GKu9m59FjNbRxAmbEGtjO21YLCM+ZQo8G3LpWnpSPo8
   qNEIb8LKHmGV/11XiB3LYMM+DReY+Il3Zaq9tgyeKMQf0+lkpzjYYJqa4
   DZ9oMToAs+lZ5oQNcuWT/EQrj7OLvHc0GWJWwvcwYQ1mHs71pwO90P2/z
   nZPXcwUy6ZjG+5qGxW2UahX7HTw5BanuEykuouCF42MT1g1lgUhNxLEwy
   E6OQ5Dtsvyu8Jk4h2ffqDEtywoXYRsSh5+mV9bNZiWY1GDk23/0I5yIZ2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="415342314"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="415342314"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:19:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="703220588"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="703220588"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 01:19:41 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, <willy@infradead.org>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <david@redhat.com>, Zi Yan <ziy@nvidia.com>
Subject: Re: [PATCH -next 1/7] mm_types: add _last_cpupid into folio
References: <20231010064544.4162286-1-wangkefeng.wang@huawei.com>
        <20231010064544.4162286-2-wangkefeng.wang@huawei.com>
Date:   Tue, 10 Oct 2023 16:17:14 +0800
In-Reply-To: <20231010064544.4162286-2-wangkefeng.wang@huawei.com> (Kefeng
        Wang's message of "Tue, 10 Oct 2023 14:45:38 +0800")
Message-ID: <87il7ehoxh.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kefeng Wang <wangkefeng.wang@huawei.com> writes:

> At present, only arc/sparc/m68k define WANT_PAGE_VIRTUAL, both of
> them don't support numa balancing, and the page struct is aligned
> to _struct_page_alignment, it is safe to move _last_cpupid before
> 'virtual' in page, meanwhile, add it into folio, which make us to
> use folio->_last_cpupid directly.

Add BUILD_BUG_ON() to check this automatically?

--
Best Regards,
Huang, Ying
