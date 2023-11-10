Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B93717E80AB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 19:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344717AbjKJSRO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 13:17:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbjKJSOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 13:14:45 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 850FB8260;
        Thu,  9 Nov 2023 23:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1699600283; x=1731136283;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version:content-transfer-encoding;
  bh=CFrsyyYaC5+GirTFxIWyuSUnIgbvfSGgrSzOo8xJlhI=;
  b=hq0RJ0Xh+cJQpi/CQZ9YvU70MztW/cMhyXPN+2VQ1LFWHE0rOsCmSEPw
   5TfB+S1fueihwLTHWG+T1yZml2odEuoqnuj0bLdmQIlVVJliSm39i9HyB
   sLSJZOVybHpCcf/9RkHVkZhU5w+dX13dG0Yiu/sJiObXMwsnXM6bjiX1A
   sA8EpjMY687UvwWEtcPRLUQpD05DmgbH7wFtbIwYpGg1b6weWdgVGoRx/
   cUk+QwE+lDeGxA4561/EHjoVKoKpj0O+NYq28bzc20LtPCvKprJpPx7V2
   EJ4BzKzhZ9kPFQhpCLxTpOr2BvYiVD622L5xZaHmY/cK/zt5GuJJDvLKu
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="3164315"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="3164315"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 20:02:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10889"; a="1095079230"
X-IronPort-AV: E=Sophos;i="6.03,291,1694761200"; 
   d="scan'208";a="1095079230"
Received: from yhuang6-desk2.sh.intel.com (HELO yhuang6-desk2.ccr.corp.intel.com) ([10.238.208.55])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Nov 2023 20:02:01 -0800
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
In-Reply-To: <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com> (Huan Yang's
        message of "Fri, 10 Nov 2023 10:44:45 +0800")
References: <20231108065818.19932-1-link@vivo.com>
        <ZUuV9xOZ5k7Ia_V2@tiehlicka>
        <ccc4094a-54de-4ce4-b8f6-76ee46d8d02d@vivo.com>
        <87msvniplj.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <1e699ff2-0841-490b-a8e7-bb87170d5604@vivo.com>
        <ZUytB5lSwxeKkBW8@tiehlicka>
        <6b539e16-c835-49ff-9fae-a65960567657@vivo.com>
        <ZUy2-vrqDq7URzb6@tiehlicka>
        <e8c0c069-a685-482d-afad-d1069c6a95ba@vivo.com>
        <87a5rmiewp.fsf@yhuang6-desk2.ccr.corp.intel.com>
        <ab108b82-87a9-4927-9d29-f60713281e8a@vivo.com>
Date:   Fri, 10 Nov 2023 12:00:00 +0800
Message-ID: <878r76gsvz.fsf@yhuang6-desk2.ccr.corp.intel.com>
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

> =E5=9C=A8 2023/11/10 9:19, Huang, Ying =E5=86=99=E9=81=93:
>> [Some people who received this message don't often get email from ying.h=
uang@intel.com. Learn why this is important at https://aka.ms/LearnAboutSen=
derIdentification ]
>>
>> Huan Yang <link@vivo.com> writes:
>>
>>> =E5=9C=A8 2023/11/9 18:39, Michal Hocko =E5=86=99=E9=81=93:
>>>> [Some people who received this message don't often get email from mhoc=
ko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSender=
Identification ]
>>>>
>>>> On Thu 09-11-23 18:29:03, Huan Yang wrote:
>>>>> HI Michal Hocko,
>>>>>
>>>>> Thanks for your suggestion.
>>>>>
>>>>> =E5=9C=A8 2023/11/9 17:57, Michal Hocko =E5=86=99=E9=81=93:
>>>>>> [Some people who received this message don't often get email from mh=
ocko@suse.com. Learn why this is important at https://aka.ms/LearnAboutSend=
erIdentification ]
>>>>>>
>>>>>> On Thu 09-11-23 11:38:56, Huan Yang wrote:
>>>>>> [...]
>>>>>>>> If so, is it better only to reclaim private anonymous pages explic=
itly?
>>>>>>> Yes, in practice, we only proactively compress anonymous pages and =
do not
>>>>>>> want to touch file pages.
>>>>>> If that is the case and this is mostly application centric (which you
>>>>>> seem to be suggesting) then why don't you use madvise(MADV_PAGEOUT)
>>>>>> instead.
>>>>> Madvise  may not be applicable in this scenario.(IMO)
>>>>>
>>>>> This feature is aimed at a core goal, which is to compress the anonym=
ous
>>>>> pages
>>>>> of frozen applications.
>>>>>
>>>>> How to detect that an application is frozen and determine which pages=
 can be
>>>>> safely reclaimed is the responsibility of the policy part.
>>>>>
>>>>> Setting madvise for an application is an active behavior, while the a=
bove
>>>>> policy
>>>>> is a passive approach.(If I misunderstood, please let me know if ther=
e is a
>>>>> better
>>>>> way to set madvise.)
>>>> You are proposing an extension to the pro-active reclaim interface so
>>>> this is an active behavior pretty much by definition. So I am really n=
ot
>>>> following you here. Your agent can simply scan the address space of the
>>>> application it is going to "freeze" and call pidfd_madvise(MADV_PAGEOU=
T)
>>>> on the private memory is that is really what you want/need.
>>> There is a key point here. We want to use the grouping policy of memcg
>>> to perform
>>> proactive reclamation with certain tendencies. Your suggestion is to
>>> reclaim memory
>>> by scanning the task process space. However, in the mobile field,
>>> memory is usually
>>> viewed at the granularity of an APP.
>>>
>>> Therefore, after an APP is frozen, we hope to reclaim memory uniformly
>>> according
>>> to the pre-grouped APP processes.
>>>
>>> Of course, as you suggested, madvise can also achieve this, but
>>> implementing it in
>>> the agent may be more complex.(In terms of achieving the same goal,
>>> using memcg
>>> to group all the processes of an APP and perform proactive reclamation
>>> is simpler
>>> than using madvise and scanning multiple processes of an application
>>> using an agent?)
>> I still think that it's not too complex to use process_madvise() to do
>> this.  For each process of the application, the agent can read
>> /proc/PID/maps to get all anonymous address ranges, then call
>> process_madvise(MADV_PAGEOUT) to reclaim pages.  This can even filter
>> out shared anonymous pages.  Does this work for you?
>
> Thanks for this suggestion. This way can avoid touch shared anonymous, it=
's
> pretty well. But, I have some doubts about this, CPU resources are
> usually limited in
> embedded devices, and power consumption must also be taken into
> consideration.
>
> If this approach is adopted, the agent needs to periodically scan
> frozen applications
> and set pageout for the address space. Is the frequency of this active
> operation more
> complex and unsuitable for embedded devices compared to reclamation based=
 on
> memcg grouping features?

In memcg based solution, when will you start the proactive reclaiming?
You can just replace the reclaiming part of the solution from memcg
proactive reclaiming to process_madvise(MADV_PAGEOUT).  Because you can
get PIDs in a memcg.  Is it possible?

> In addition, without LRU, it is difficult to control the reclamation
> of only partially cold
> anonymous page data of frozen applications. For example, if I only
> want to proactively
> reclaim 100MB of anonymous pages and issue the proactive reclamation
> interface,
> we can use the LRU feature to only reclaim 100MB of cold anonymous pages.
> However, this cannot be achieved through madvise.(If I have
> misunderstood something,
> please correct me.)

IIUC, it should be OK to reclaim all private anonymous pages of an
application in your specific use case?  If you really want to restrict
the number of pages reclaimed, it's possible too.  You can restrict the
size of address range to call process_madvise(MADV_PAGEOUT), and check
the RSS of the application.  The accuracy of the number reclaimed isn't
good.  But I think that it should OK in practice?

BTW: how do you know the number of pages to be reclaimed proactively in
memcg proactive reclaiming based solution?

--
Best Regards,
Huang, Ying
