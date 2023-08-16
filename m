Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F197877DAF5
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 09:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242322AbjHPHLs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 03:11:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242348AbjHPHLj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 03:11:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AAF0210E
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 00:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692169899; x=1723705899;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=Fyuo5KVS7SmOX+46RsDtaSg2zfRHi3YLKR6KZxsGfz8=;
  b=PjiJ4AkeuD4K2BZ4Xb7hqZ5F/hZaj8UYr/rsKphQT8eSRXZGBPoAvZCT
   SCKOf5WubN2p1CwSBiY2ju1BONgZEaiaDKnTPC02Tu5jSi4+s0Fxi+a2t
   J4VdyRK/oJteEOoT1kwBdcpIxeloJpA3JdERLHTfG4hhID2mtPXyHuAbg
   pyIWsOI7uBTg0bWm8txOTfOg9dfSJ9lhomo5o5p6JztuQdxtPkYBMvTFP
   Zk2rAhjoWiF48yb1KqKHf+f9vWzar/NzHnCKnSHkW60s1tE2RGJAyqrsb
   79k1hKMnz+huooG5ecw+62CajIYs9aZ0TKxD2qFC7h0LdV6gQ+KveuNRY
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="369933752"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="369933752"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:10:07 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="769084661"
X-IronPort-AV: E=Sophos;i="6.01,176,1684825200"; 
   d="scan'208";a="769084661"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2023 00:10:05 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Christoph Lameter <cl@linux.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Vlastimil Babka <vbabka@suse.cz>
Subject: Re: [PATCH] mm: fix draining remote pageset
References: <20230811090819.60845-1-ying.huang@intel.com>
        <ZNYA6YWLqtDOdQne@dhcp22.suse.cz>
        <87r0o6bcyw.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ZNxxaFnM9W8+imHD@dhcp22.suse.cz>
Date:   Wed, 16 Aug 2023 15:08:23 +0800
In-Reply-To: <ZNxxaFnM9W8+imHD@dhcp22.suse.cz> (Michal Hocko's message of
        "Wed, 16 Aug 2023 08:49:12 +0200")
Message-ID: <87jztv79co.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Michal Hocko <mhocko@suse.com> writes:

> On Mon 14-08-23 09:59:51, Huang, Ying wrote:
>> Hi, Michal,
>> 
>> Michal Hocko <mhocko@suse.com> writes:
>> 
>> > On Fri 11-08-23 17:08:19, Huang Ying wrote:
>> >> If there is no memory allocation/freeing in the remote pageset after
>> >> some time (3 seconds for now), the remote pageset will be drained to
>> >> avoid memory wastage.
>> >> 
>> >> But in the current implementation, vmstat updater worker may not be
>> >> re-queued when we are waiting for the timeout (pcp->expire != 0) if
>> >> there are no vmstat changes, for example, when CPU goes idle.
>> >
>> > Why is that a problem?
>> 
>> The pages of the remote zone may be kept in the local per-CPU pageset
>> for long time as long as there's no page allocation/freeing on the
>> logical CPU.  In addition to the logical CPU goes idle, this is also
>> possible if the logical CPU is busy in the user space.
>
> But why is this a problem? Is the scale of the problem sufficient to
> trigger out of memory situations or be otherwise harmful?

This may trigger premature page reclaiming.  The pages in the PCP of the
remote zone would have been freed to satisfy the page allocation for the
remote zone to avoid page reclaiming.  It's highly possible that the
local CPU just allocate/free from/to the remote zone temporarily.  So,
we should free PCP pages of the remote zone if there is no page
allocation/freeing from/to the remote zone for 3 seconds.

This will not trigger OOM, because all PCP will be drained if allocation
failed after direct reclaiming.

--
Best Regards,
Huang, Ying
