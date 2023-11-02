Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69FE37DEA99
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 03:18:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348240AbjKBCRz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 22:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbjKBCRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 22:17:54 -0400
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6D3BD
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 19:17:48 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698891466;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B+y5TA+dBJkHS1npJO+WnH+1LCxKJsUTCf46ix28dSM=;
        b=Em1XyI3/iCPrthA4ond4YGR3E2WDklG8rIywXuErsHfD8y60SzEoc0FG+91im5EV7jX5G2
        IbufFuGf41zfItJPCugj6PWOOpoUt0ajMr3ZMA8p1JsZs3ngpINCSzb/MhgtWta5iBzZaR
        xbuAunHLd6eEarkKHRkzXpHbTlbmYaA=
Mime-Version: 1.0
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <CAKEwX=PmLSKpmv3zpGhka-JaJoTk7Se4bo6D8r5s6HhPmkpEng@mail.gmail.com>
Date:   Thu, 2 Nov 2023 10:17:03 +0800
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        cerasuolodomenico@gmail.com, Yosry Ahmed <yosryahmed@google.com>,
        sjenning@redhat.com, ddstreet@ieee.org, vitaly.wool@konsulko.com,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Chris Li <chrisl@kernel.org>, Linux-MM <linux-mm@kvack.org>,
        kernel-team@meta.com, LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DB299182-3165-4BFD-8717-D6B88D1C9BCB@linux.dev>
References: <20231024203302.1920362-3-nphamcs@gmail.com>
 <20231101012614.186996-1-nphamcs@gmail.com>
 <B0D87683-DD13-4787-8188-98CEBF561B99@linux.dev>
 <CAKEwX=PmLSKpmv3zpGhka-JaJoTk7Se4bo6D8r5s6HhPmkpEng@mail.gmail.com>
To:     Nhat Pham <nphamcs@gmail.com>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Nov 2, 2023, at 01:44, Nhat Pham <nphamcs@gmail.com> wrote:
>=20
> On Tue, Oct 31, 2023 at 8:07=E2=80=AFPM Muchun Song =
<muchun.song@linux.dev> wrote:
>>=20
>>=20
>>=20
>>> On Nov 1, 2023, at 09:26, Nhat Pham <nphamcs@gmail.com> wrote:
>>>=20
>>> cc-ing Johannes, Roman, Shakeel, Muchun since you all know much more
>>> about memory controller + list_lru reparenting logic than me.
>>>=20
>>> There seems to be a race between memcg offlining and zswap=E2=80=99s
>>> cgroup-aware LRU implementation:
>>>=20
>>> CPU0                            CPU1
>>> zswap_lru_add()                 mem_cgroup_css_offline()
>>>   get_mem_cgroup_from_objcg()
>>>                                   memcg_offline_kmem()
>>>                                       memcg_reparent_objcgs()
>>>                                       memcg_reparent_list_lrus()
>>>                                           memcg_reparent_list_lru()
>>>                                               =
memcg_reparent_list_lru_node()
>>>   list_lru_add()
>>>                                               memcg_list_lru_free()
>>>=20
>>>=20
>>> Essentially: on CPU0, zswap gets the memcg from the entry's objcg
>>> (before the objcgs are reparented). Then it performs list_lru_add()
>>> after the list_lru entries reparenting =
(memcg_reparent_list_lru_node())
>>> step. If the list_lru of the memcg being offlined has not been freed
>>> (i.e before the memcg_list_lru_free() call), then the list_lru_add()
>>> call would succeed - but the list will be freed soon after. The new
>>=20
>> No worries.  list_lru_add() will add the object to the lru list of
>> the parent of the memcg being offlined, because the ->kmemcg_id of =
the
>> memcg being offlined will be changed to its parent's ->kmemcg_id =
before memcg_reparent_list_lru().
>>=20
>=20
> Ohhh that is subtle. Thanks for pointing this out, Muchun!
>=20
> In that case, I think Yosry is right after all! We don't even need to =
get
> a reference to the memcg:
>=20
> rcu_read_lock();
> memcg =3D obj_cgroup_memcg(objcg);
> list_lru_add();
> rcu_read_unlock();
>=20
> As long as we're inside this rcu section, we're guaranteed to get
> an un-freed memcg. Now it could be offlined etc., but as Muchun has

Right.

Thanks.

> pointed out, the list_lru_add() call will still does the right thing - =
it will
> either add the new entry to the parent list if this happens after the
> kmemcg_id update, or the child list before the list_lru reparenting
> action. Both of these scenarios are fine.
>=20
>> Muchun,
>> Thanks
>>=20
>>> zswap entry as a result will not be subjected to future reclaim
>>> attempt. IOW, this list_lru_add() call is effectively swallowed. And
>>> worse, there might be a crash when we invalidate the zswap_entry in =
the
>>> future (which will perform a list_lru removal).
>>>=20
>>> Within get_mem_cgroup_from_objcg(), none of the following seem
>>> sufficient to prevent this race:
>>>=20
>>>   1. Perform the objcg-to-memcg lookup inside a rcu_read_lock()
>>>   section.
>>>   2. Checking if the memcg is freed yet (with css_tryget()) (what
>>>   we're currently doing in this patch series).
>>>   3. Checking if the memcg is still online (with =
css_tryget_online())
>>>   The memcg can still be offlined down the line.
>>>=20
>>>=20
>>> I've discussed this privately with Johannes, and it seems like the
>>> cleanest solution here is to move the reparenting logic down to =
release
>>> stage. That way, when get_mem_cgroup_from_objcg() returns,
>>> zswap_lru_add() is given an memcg that is reparenting-safe (until we
>>> drop the obtained reference).


