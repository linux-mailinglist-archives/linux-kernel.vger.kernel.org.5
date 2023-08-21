Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270FF7821B3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 04:53:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjHUCxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Aug 2023 22:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229908AbjHUCxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Aug 2023 22:53:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F388CA6
        for <linux-kernel@vger.kernel.org>; Sun, 20 Aug 2023 19:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692586419; x=1724122419;
  h=from:to:cc:subject:references:date:in-reply-to:
   message-id:mime-version;
  bh=IkjujvBsdlsoDFEpFOiG+vgVcyT2VHYJYSw2RNjYJXE=;
  b=eQnqpr/t8zE8LD34R5aarNE3riRT/t/iZaIcsnTLYt96azcdxEbHIfe3
   KA0MhjGe8GzG96SkVpIdX9xTFwT5Uedc5V0fBWDvyft1nQ4fbfhooJP1S
   F43SjSegMVx+ADDVo/oVNfLZUIVy3Oo96gSZGb/C0mvxz69c73JoL6qyp
   fDe0i6UgmTD5VS5rPMf9oQoPM+WQKvXJxzf9hWR4e39RWTPGQqpniXOh8
   rBBjGYr119wXH9Yqx7AMb8X+5BfBYe/p1ObRvRDn/nBUaAhZzzLlihZj9
   okndrKOXYPCLyI/ocC/NrSEs7wPot1bFuaVDJiIGRWEu3jsgwJbr56RfT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="373450685"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="373450685"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 19:53:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10808"; a="825768632"
X-IronPort-AV: E=Sophos;i="6.01,189,1684825200"; 
   d="scan'208";a="825768632"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Aug 2023 19:53:35 -0700
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Byungchul Park <byungchul@sk.com>
Cc:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <kernel_team@skhynix.com>, <akpm@linux-foundation.org>,
        <namit@vmware.com>, <xhao@linux.alibaba.com>,
        <mgorman@techsingularity.net>, <hughd@google.com>,
        <willy@infradead.org>, <david@redhat.com>, <peterz@infradead.org>,
        <luto@kernel.org>, <dave.hansen@linux.intel.com>
Subject: Re: [RFC 2/2] mm: Defer TLB flush by keeping both src and dst
 folios at migration
References: <20230804061850.21498-1-byungchul@sk.com>
        <20230804061850.21498-3-byungchul@sk.com>
        <877cpx9jsx.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230816001307.GA44941@system.software.com>
        <87r0o37qcn.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <20230821012804.GA43847@system.software.com>
Date:   Mon, 21 Aug 2023 10:51:31 +0800
In-Reply-To: <20230821012804.GA43847@system.software.com> (Byungchul Park's
        message of "Mon, 21 Aug 2023 10:28:05 +0900")
Message-ID: <878ra5ds5o.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Byungchul Park <byungchul@sk.com> writes:

> On Wed, Aug 16, 2023 at 09:01:12AM +0800, Huang, Ying wrote:
>> Byungchul Park <byungchul@sk.com> writes:
>> 
>> > On Tue, Aug 15, 2023 at 09:27:26AM +0800, Huang, Ying wrote:
>> >> Byungchul Park <byungchul@sk.com> writes:
>> >> 
>> >> > Implementation of CONFIG_MIGRC that stands for 'Migration Read Copy'.
>> >> >
>> >> > We always face the migration overhead at either promotion or demotion,
>> >> > while working with tiered memory e.g. CXL memory and found out TLB
>> >> > shootdown is a quite big one that is needed to get rid of if possible.
>> >> >
>> >> > Fortunately, TLB flush can be defered or even skipped if both source and
>> >> > destination of folios during migration are kept until all TLB flushes
>> >> > required will have been done, of course, only if the target PTE entries
>> >> > have read only permission, more precisely speaking, don't have write
>> >> > permission. Otherwise, no doubt the folio might get messed up.
>> >> >
>> >> > To achieve that:
>> >> >
>> >> >    1. For the folios that have only non-writable TLB entries, prevent
>> >> >       TLB flush by keeping both source and destination of folios during
>> >> >       migration, which will be handled later at a better time.
>> >> >
>> >> >    2. When any non-writable TLB entry changes to writable e.g. through
>> >> >       fault handler, give up CONFIG_MIGRC mechanism so as to perform
>> >> >       TLB flush required right away.
>> >> >
>> >> >    3. TLB flushes can be skipped if all TLB flushes required to free the
>> >> >       duplicated folios have been done by any reason, which doesn't have
>> >> >       to be done from migrations.
>> >> >
>> >> >    4. Adjust watermark check routine, __zone_watermark_ok(), with the
>> >> >       number of duplicated folios because those folios can be freed
>> >> >       and obtained right away through appropreate TLB flushes.
>> >> >
>> >> >    5. Perform TLB flushes and free the duplicated folios pending the
>> >> >       flushes if page allocation routine is in trouble due to memory
>> >> >       pressure, even more aggresively for high order allocation.
>> >> 
>> >> Is the optimization restricted for page migration only?  Can it be used
>> >> for other places?  Like page reclaiming?
>> >
>> > Just to make sure, are you talking about the (5) description? For now,
>> > it's performed at the beginning of __alloc_pages_slowpath(), say, before
>> > page recaiming. Do you think it'd be meaningful to perform it during page
>> > reclaiming? Or do you mean something else?
>> 
>> Not for (5).  TLB needs to be flushed during page reclaiming too.  Can
>> similar method be used to reduce TLB flushing there too?
>
> If you were talking about unmapping for swap while reclaiming, then I
> think yes. The case can also take benefit from CONFIG_MIGRC.

Yes.  Thanks for explanation.

--
Best Regards,
Huang, Ying

