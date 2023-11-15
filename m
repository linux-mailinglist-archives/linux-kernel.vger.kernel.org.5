Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BA187E969E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 07:12:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230072AbjKMGMO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 01:12:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229645AbjKMGML (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 01:12:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB7B171B;
        Sun, 12 Nov 2023 22:12:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699855930; x=1731391930;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=7LcmL3v83gLciivg6YlvQU94smXGBtfXXsaeFuMWyIw=;
  b=dnMHD2yMhTePR/3yKay0W+oHcE47PQRsiQOdH/i2U52BxS/hY/NhUZ+w
   59cvEAfPVaaFqeYcSY0O9r0np6np2HJzopQ7mToaNomDSVuan23l3iSO1
   aP4/uKApq60ZiC2YzqitIAgo56hlA+SbdZb9SmmP9/0PWm0ys0deDFTGn
   FNJ/+TZ8171xqmCAA67epbMrDElwKFcZAOutC89wo2KBbf3l5Rx1OMBcv
   uK3dNNh25GRlpoyF9zf+hGMU3Ds5m4Lw1RZlsOEBhTetXYvTFjbUuCz+P
   10jVbjbDeGKNCk/pwHXXmvmNmNZR73oE8GplinAL8TP74+90rlFYUbPPx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="9027768"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="9027768"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 22:12:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10892"; a="887846916"
X-IronPort-AV: E=Sophos;i="6.03,298,1694761200"; 
   d="scan'208";a="887846916"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2023 22:12:02 -0800
From:   "Huang, Ying" <ying.huang@intel.com>
To:     Huan Yang <link@vivo.com>
Cc:     Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        "Jonathan Corbet" <corbet@lwn.net>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Shakeel Butt" <shakeelb@google.com>,
        Muchun Song <muchun.song@linux.dev>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Peter Xu <peterx@redhat.com>,
        "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
        Yosry Ahmed <yosryahmed@google.com>,
        "Liu Shixin" <liushixin2@huawei.com>,
        Hugh Dickins <hughd@google.com>, <cgroups@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <opensource.kernel@vivo.com>
Subject: Re: [RFC 0/4] Introduce unbalance proactive reclaim
In-Reply-To: <b4694fbf-92df-4067-878e-6035df46582f@vivo.com> (Huan Yang's
        message of "Mon, 13 Nov 2023 10:17:57 +0800")
References: <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
        <ZUytB5lSwxeKkBW8@tiehlicka>
        <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
        <ZUy2-vrqDq7URzb6@tiehlicka>
        <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
        <ZUzTVgK_i05uiHiB@tiehlicka>
        <e07c977f-8c73-4772-b069-527c6ac0ae4f@vivo.com>
        <ZUziy-6QPdTIDJlm@tiehlicka>
        <f46de374-82a2-467c-8d32-a15b518bff17@vivo.com>
        <ZU4g9XZvi9mRQD27@tiehlicka>
        <b4694fbf-92df-4067-878e-6035df46582f@vivo.com>
Date:   Mon, 13 Nov 2023 14:10:01 +0800
Message-ID: <87edgufakm.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

Huan Yang <link@vivo.com> writes:

> =E5=9C=A8 2023/11/10 20:24, Michal Hocko =E5=86=99=E9=81=93:
>> On Fri 10-11-23 11:48:49, Huan Yang wrote:
>> [...]
>>> Also, When the application enters the foreground, the startup speed
>>> may be slower. Also trace show that here are a lot of block I/O.
>>> (usually 1000+ IO count and 200+ms IO Time) We usually observe very
>>> little block I/O caused by zram refault.(read: 1698.39MB/s, write:
>>> 995.109MB/s), usually, it is faster than random disk reads.(read:
>>> 48.1907MB/s write: 49.1654MB/s). This test by zram-perf and I change a
>>> little to test UFS.
>>>
>>> Therefore, if the proactive reclamation encounters many file pages,
>>> the application may become slow when it is opened.
>> OK, this is an interesting information. From the above it seems that
>> storage based IO refaults are order of magnitude more expensive than
>> swap (zram in this case). That means that the memory reclaim should
>> _in general_ prefer anonymous memory reclaim over refaulted page cache,
>> right? Or is there any reason why "frozen" applications are any
>> different in this case?
> Frozen applications mean that the application process is no longer active,
> so once its private anonymous page data is swapped out, the anonymous
> pages will not be refaulted until the application becomes active again.
>
> On the contrary, page caches are usually shared. Even if the
> application that
> first read the file is no longer active, other processes may still
> read the file.
> Therefore, it is not reasonable to use the proactive reclamation
> interface to
> reclaim=C2=A0page caches without considering memory pressure.

No.  Not all page caches are shared.  For example, the page caches used
for use-once streaming IO.  And, they should be reclaimed firstly.

So, your solution may work good for your specific use cases, but it's
not a general solution.  Per my understanding, you want to reclaim only
private pages to avoid impact the performance of other applications.
Privately mapped anonymous pages is easy to be identified (And I suggest
that you can find a way to avoid reclaim shared mapped anonymous pages).
There's some heuristics to identify use-once page caches in reclaiming
code.  Why doesn't it work for your situation?

[snip]

--
Best Regards,
Huang, Ying
