Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8412D7F69E9
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 01:45:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjKXAmz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 19:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKXAmx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 19:42:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 645B41A8
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 16:43:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700786580; x=1732322580;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=LCijnWUbR8fFTOXQFLktGTa8GhwEgc+K0cu0Fz4sHUE=;
  b=BjlIhNn8bXcK0cXvyk8wbuIvf1MVTpzz6n7vbQtqRgamltDGt1FBekk9
   HlxtT6GJqxz/EIr6f8Jf/2izbxuZ8Gjrs6BXPIw5hPNyuHleOMx0RQL+E
   7dpw6QL8erWPG4YEr+4jmwyl9f/OXmwNhxKPvzb2TOiahch6MEtIjt3we
   +YCgbf4bOLDEsUCqrJBoaeTLeXvfKUe+gF5HARVo8FuwkjQFrSSeoAzP7
   DUnYw4731pSyAUEmFV2ZsR8iA6b4u/jUW/W/BUcQg8yNeS/7Qix5WeWSn
   tmFQAUBWd5bQ5y0UIb9W934LsOSOpK60KBCxcWsInexu3dle3mtdptXxM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="377373483"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="377373483"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 16:42:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717191678"
X-IronPort-AV: E=Sophos;i="6.04,223,1695711600"; 
   d="scan'208";a="717191678"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 16:42:57 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Kairui Song <ryncsn@gmail.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Matthew Wilcox <willy@infradead.org>,
        Michal Hocko <mhocko@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/24] mm/swap: reduce scope of get_swap_device in
 swapin path
In-Reply-To: <CAMgjq7Ba9inFHCqoZSNY_gFUv=UEVEC8FvG+V7-7Qpv027tEmQ@mail.gmail.com>
        (Kairui Song's message of "Thu, 23 Nov 2023 19:13:27 +0800")
References: <20231119194740.94101-1-ryncsn@gmail.com>
        <20231119194740.94101-17-ryncsn@gmail.com>
        <87sf4yaajv.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <CAMgjq7Ba9inFHCqoZSNY_gFUv=UEVEC8FvG+V7-7Qpv027tEmQ@mail.gmail.com>
Date:   Fri, 24 Nov 2023 08:40:56 +0800
Message-ID: <875y1s7zl3.fsf@yhuang6-desk2.ccr.corp.intel.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Kairui Song <ryncsn@gmail.com> writes:

> Huang, Ying <ying.huang@intel.com> =E4=BA=8E2023=E5=B9=B411=E6=9C=8822=E6=
=97=A5=E5=91=A8=E4=B8=89 08:38=E5=86=99=E9=81=93=EF=BC=9A
>>
>> Kairui Song <ryncsn@gmail.com> writes:
>>
>> > From: Kairui Song <kasong@tencent.com>
>> >
>> > Move get_swap_device into swapin_readahead, simplify the code
>> > and prepare for follow up commits.
>>
>> No.  Please don't do this.  Please check the get/put_swap_device() usage
>> rule in the comments of get_swap_device().
>>
>> "
>>  * When we get a swap entry, if there aren't some other ways to
>>  * prevent swapoff, such as the folio in swap cache is locked, page
>>  * table lock is held, etc., the swap entry may become invalid because
>>  * of swapoff.  Then, we need to enclose all swap related functions
>>  * with get_swap_device() and put_swap_device(), unless the swap
>>  * functions call get/put_swap_device() by themselves.
>> "
>>
>> This is to simplify the reasoning about swapoff and swap entry.
>>
>> Why does it bother you?
>
> Hi Ying,
>
> This is trying to reduce LOC, avoid a trivial si read, and make error
> checking logic easier to refactor in later commits.

The race with swapoff isn't considered by many developers usually.  So,
we should use a simple rule as much as possible.  For example, if you
get a swap entry, use get/put_swap_device() to enclose all code that
operate on the swap entry.  This makes code easier to be maintained in
the long run.  Yes.  Sometimes we break the rule a little, but only if
we have enough benefit, such as improving performance in some practical
use cases.

> And besides there is one trivial change I forgot to include in this
> commit, get_swap_device can be put after swap_cache_get_folio in
> swapin_readahead, since swap_cache_get_folio doesn't need to hold the
> swap device, so in cache hit case this get/put_swap_device() can be
> saved.

swapoff is rare operation, it's OK to delay it a little to make the code
easier to be understood.

> The comment also mentioned:
>
> "Then, we need to enclose all swap related functions with
> get_swap_device() and put_swap_device(), unless the swap functions
> call get/put_swap_device() by themselves"
>
> So I think it should be OK to do this.

No.  You should change the code with a good enough reason.  Compared
with complexity it introduced, the benefit isn't enough for me so far.

--
Best Regards,
Huang, Ying
