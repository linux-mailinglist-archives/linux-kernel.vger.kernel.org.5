Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFCE27EDCF5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 09:33:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344951AbjKPIdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 03:33:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbjKPIdT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 03:33:19 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91823D43
        for <linux-kernel@vger.kernel.org>; Thu, 16 Nov 2023 00:33:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700123594; x=1731659594;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=a6pNSoBHnMP71ZOfqHBa2nwHsEXWNsx5L+AMwWNcIXs=;
  b=fW9WfrC1Jp5PloBDSrCVMaLk7lCKrfVTkAFmHAFpOvnADF5S4RuSrBGw
   O5zQykt4Ziz3lt/oGZRzDihNaxQe8h0SNUyDhGBPpNjqPwf9uN7N1HBpU
   tyrZ5zpxdf5my+iaCmC0PgMCGSYKnAu9yCdgPuEx6DenDAnKgDeh3R0p7
   haAVR7qStggIkW/Cp1fR3wBrfZ+HjdSNu7L4BhP94zt35FHQfr7z8XqEA
   TaVSjzo7owdILGabExYzXJW/BpCW+uXCkKBiRjQ/jlyO8gC8bM34sfqL4
   vPcSxUfO7WjlrM9aJNjxrTQs40mzXxyF5dv6UlG5qh0wZ0WT5IkOsEwpd
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="388209419"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="388209419"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:33:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10895"; a="758759956"
X-IronPort-AV: E=Sophos;i="6.03,307,1694761200"; 
   d="scan'208";a="758759956"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Nov 2023 00:33:10 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Zhongkun He <hezhongkun.hzk@bytedance.com>,
        akpm@linux-foundation.org, hannes@cmpxchg.org, nphamcs@gmail.com,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two
 scenarios
In-Reply-To: <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
        (Yosry Ahmed's message of "Tue, 14 Nov 2023 09:16:00 -0800")
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
        <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
Date:   Thu, 16 Nov 2023 16:31:09 +0800
Message-ID: <87bkbudrqq.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Yosry Ahmed <yosryahmed@google.com> writes:

> +Ying
>
> On Mon, Nov 13, 2023 at 5:06=E2=80=AFAM Zhongkun He
> <hezhongkun.hzk@bytedance.com> wrote:
>>
>> I recently found two scenarios where zswap entry could not be
>> released, which will cause shrink_worker and active recycling
>> to fail.
>> 1)The swap entry has been freed, but cached in swap_slots_cache,
>> no swap cache and swapcount=3D0.
>> 2)When the option zswap_exclusive_loads_enabled disabled and
>> zswap_load completed(page in swap_cache and swapcount =3D 0).
>
> For case (1), I think a cleaner solution would be to move the
> zswap_invalidate() call from swap_range_free() (which is called after
> the cached slots are freed) to __swap_entry_free_locked() if the usage
> goes to 0. I actually think conceptually this makes not just for
> zswap_invalidate(), but also for the arch call, memcg uncharging, etc.
> Slots caching is a swapfile optimization that should be internal to
> swapfile code. Once a swap entry is freed (i.e. swap count is 0 AND
> not in the swap cache), all the hooks should be called (memcg, zswap,
> arch, ..) as the swap entry is effectively freed. The fact that
> swapfile code internally batches and caches slots should be
> transparent to other parts of MM. I am not sure if the calls can just
> be moved or if there are underlying assumptions in the implementation
> that would be broken, but it feels like the right thing to do.

This sounds reasonable for me.  Just don't forget to change other
swap_range_free() callers too.

--
Best Regards,
Huang, Ying
