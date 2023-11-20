Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 849A17F0B9C
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Nov 2023 06:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231917AbjKTFlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Nov 2023 00:41:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbjKTFln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Nov 2023 00:41:43 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31321C5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Nov 2023 21:41:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700458900; x=1731994900;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=/7/+XwGPOEKnt1JtA+NEPBy+ni/uzk3f0T3/SJhZvXQ=;
  b=GS3HvtEEqOIvbdkh4BcTdjbvMNmiBf23TX2Sd9UGpltsDZN5sWGpUFOj
   bwLT4ZPzEsnFuKnpNLyvreV1aoutg/iT5R/CNlKl3rw2hVV6HJZi8t3md
   r4KFpJ0z+5OT+WrmYoTS3EriZ3dfNJesjcc2vRXJ0+/M8jAs7lmj2ofzC
   5qtuF+XSrKeWhunYYkGWMoQQS7mkeHqQmn73cXnHzsmUKwH/v+MZ1nA8h
   urLupsKMHBu/muSWJOe7LLO7SbxWQx/unZBuqZlKr/LPN9RrweY9m+p+H
   kake/bD/mm9MqmZZT1OcMPo51Yo89s/jE7s1FMmCrjNZGJJQPEvZLqXp3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10899"; a="13109499"
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="13109499"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 21:41:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.04,212,1695711600"; 
   d="scan'208";a="14046099"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2023 21:41:37 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Chris Li <chrisl@kernel.org>
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
In-Reply-To: <CAF8kJuPs=O7dKQYWAyM5N1UPyCkEmaCb9REHmNvAi7o4tPbMDg@mail.gmail.com>
        (Chris Li's message of "Sun, 19 Nov 2023 21:31:30 -0800")
References: <20231113130601.3350915-1-hezhongkun.hzk@bytedance.com>
        <CAJD7tkY8SwROmNEaBAhkS4OKj33g-6fHsKFeYKW3afT+yAbvxA@mail.gmail.com>
        <CAF8kJuPonfuOtipdifXwBny2H7cy6m6BL8mWFVXzfb9JSdYq3Q@mail.gmail.com>
        <CAJD7tkYMiJiXTTgAN34TP8QTr-ViAuEFddYes=ac+1ErenjCZw@mail.gmail.com>
        <CAF8kJuOC30feLGs0bNHOxMjSZ3uqF1y7eUdJ4p-w-myP8c1cFg@mail.gmail.com>
        <8734x1cdtr.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAF8kJuPs=O7dKQYWAyM5N1UPyCkEmaCb9REHmNvAi7o4tPbMDg@mail.gmail.com>
Date:   Mon, 20 Nov 2023 13:39:35 +0800
Message-ID: <87v89xasq0.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Chris Li <chrisl@kernel.org> writes:

> On Sun, Nov 19, 2023 at 7:20=E2=80=AFPM Huang, Ying <ying.huang@intel.com=
> wrote:
>>
>> Chris Li <chriscli@google.com> writes:
>>
>> > On Thu, Nov 16, 2023 at 12:19=E2=80=AFPM Yosry Ahmed <yosryahmed@googl=
e.com> wrote:
>> > That will cancel the batching effect on the swap slot free, making the
>> > common case for  swapping  faults take longer to complete, righ?
>> > If I recall correctly, the uncharge is the expensive part of the swap
>> > slot free operation.
>> > I just want to figure out what we are trading off against. This is not
>> > one side wins all situations.
>>
>> Per my understanding, we don't batch memcg uncharging in
>> swap_entry_free() now.  Although it's possible and may improve
>> performance.
>
> swap_entry_free() does not do batching, it is at the caller level.
>
> I just checked. The batching is done in free_swap_slot() is still
> using swap slot cache and batching.
> It uses swapcache_free_entries() to batch free the swap_slots. That is
> where the uncharge happens per my understanding.

Per my understanding, memcg uncharging happens in

swapcache_free_entries()
  swap_entry_free()
    mem_cgroup_uncharge_swap()

The swap entries are uncharged one-by-one, not

acquire lock in memcg
uncharge all entries
release lock in memcg

--
Best Regards,
Huang, Ying
