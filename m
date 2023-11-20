Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA8927F0AE6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 04:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbjKTDUs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Nov 2023 22:20:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231873AbjKTDUq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Nov 2023 22:20:46 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E94CFD52
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 19:20:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700450428; x=1731986428;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/WwpyBY5Lz5uVgYgV4rkDEvUBBIi7Rj6tYssKEgChWE=;
  b=A+dHWEslrhAArcYt1awSudttL+wjqH15nfTeCL8PoqJVWiy9crEj/Z0o
   ld/2mOUq56UMLR7RcMl1DxMmyWZ9TG3rgD50AiNjsl4/rVVcmwFbtF1A9
   Gy2mHvD3tIXsv4TfVipqgWyfMHajS1TyR2RxOuP6rJ9d6yb7ORRGHH3Ox
   Z+urGzJKbeXkihzCY7HbZdmV1L9r+sSoU+psaJ5/GGUdE81vhmx0FbAV6
   W2Of157Y9GXRtMic0vMxk+N9KGDeaJASn7epOYZjLT3Koy9zv8e68z43n
   rY6TaU/LhqCtBADNXDHsCfDpDyTJTSmqEKGslEboGXGUGNmPAku0I0+rH
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="381930739"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="381930739"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:20:28 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="14028926"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 19:20:25 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chris Li <chriscli@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Zhongkun He <hezhongkun.hzk@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Nhat Pham <nphamcs@gmail.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        linux-mm <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm:zswap: fix zswap entry reclamation failure in two
 scenarios
In-Reply-To: <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
        (Chris Li's message of "Thu, 16 Nov 2023 12:30:20 -0800")
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
        <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
        <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
        <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
        <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
Date:   Mon, 20 Nov 2023 11:18:24 +0800
Message-ID: <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chriscli@google.com> writes:

> On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@google.c=
om> wrote:
>>
>> Not bypassing the swap slot cache, just make the callbacks to
>> invalidate the zswap entry, do memg uncharging, etc when the slot is
>> no longer used and is entering the swap slot cache (i.e. when
>> free_swap_slot() is called), instead of when draining the swap slot
>> cache (i.e. when swap_range_free() is called). For all parts of MM
>> outside of swap, the swap entry is freed when free_swap_slot() is
>> called. We don't free it immediately because of caching, but this
>> should be transparent to other parts of MM (e.g. zswap, memcg, etc).
>
> That will cancel the batching effect on the swap slot free, making the
> common case for  swapping  faults take longer to complete, righ?
> If I recall correctly, the uncharge is the expensive part of the swap
> slot free operation.
> I just want to figure out what we are trading off against. This is not
> one side wins all situations.

Per my understanding, we don't batch memcg uncharging in
swap_entry_free() now.  Although it's possible and may improve
performance.

--
Best Regards,
Huang, Ying
