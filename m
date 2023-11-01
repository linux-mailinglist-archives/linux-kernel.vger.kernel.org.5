Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C064D7DDB52
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 04:07:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376751AbjKADH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 23:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345437AbjKADHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 23:07:23 -0400
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [IPv6:2001:41d0:203:375::ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81BD7A4
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 20:07:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1698808035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uWoT6krnJovWyrEsMbfgyVFj2a0jkXtJTHAUCAcBSHk=;
        b=tdHJYSBR9O6TjCmWCn2ljaxzGettdzXpL+yVuzXAIkcUPgnCN7ueVaIJI4+NTgBqk01xm1
        bxU5yWujuCAG4cVbxT23sYtyr4ehEISpdILe17tsUdbHjohsz7Ni1wf5DMUsAGOy0N1vfe
        69csr/e6AnbTYIRoWHcrPVcA8jdj/vY=
Mime-Version: 1.0
Subject: Re: [PATCH v4 2/5] zswap: make shrinking memcg-aware
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20231101012614.186996-1-nphamcs@gmail.com>
Date:   Wed, 1 Nov 2023 11:06:26 +0800
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
Message-Id: <B0D87683-DD13-4787-8188-98CEBF561B99@linux.dev>
References: <20231024203302.1920362-3-nphamcs@gmail.com>
 <20231101012614.186996-1-nphamcs@gmail.com>
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



> On Nov 1, 2023, at 09:26, Nhat Pham <nphamcs@gmail.com> wrote:
>=20
> cc-ing Johannes, Roman, Shakeel, Muchun since you all know much more
> about memory controller + list_lru reparenting logic than me.
>=20
> There seems to be a race between memcg offlining and zswap=E2=80=99s
> cgroup-aware LRU implementation:
>=20
> CPU0                            CPU1
> zswap_lru_add()                 mem_cgroup_css_offline()
>    get_mem_cgroup_from_objcg()
>                                    memcg_offline_kmem()
>                                        memcg_reparent_objcgs()
>                                        memcg_reparent_list_lrus()
>                                            memcg_reparent_list_lru()
>                                                =
memcg_reparent_list_lru_node()
>    list_lru_add()
>                                                memcg_list_lru_free()
>=20
>=20
> Essentially: on CPU0, zswap gets the memcg from the entry's objcg
> (before the objcgs are reparented). Then it performs list_lru_add()
> after the list_lru entries reparenting =
(memcg_reparent_list_lru_node())
> step. If the list_lru of the memcg being offlined has not been freed
> (i.e before the memcg_list_lru_free() call), then the list_lru_add()
> call would succeed - but the list will be freed soon after. The new

No worries.  list_lru_add() will add the object to the lru list of
the parent of the memcg being offlined, because the ->kmemcg_id of the
memcg being offlined will be changed to its parent's ->kmemcg_id before =
memcg_reparent_list_lru().

Muchun,
Thanks

> zswap entry as a result will not be subjected to future reclaim
> attempt. IOW, this list_lru_add() call is effectively swallowed. And
> worse, there might be a crash when we invalidate the zswap_entry in =
the
> future (which will perform a list_lru removal).
>=20
> Within get_mem_cgroup_from_objcg(), none of the following seem
> sufficient to prevent this race:
>=20
>    1. Perform the objcg-to-memcg lookup inside a rcu_read_lock()
>    section.
>    2. Checking if the memcg is freed yet (with css_tryget()) (what
>    we're currently doing in this patch series).
>    3. Checking if the memcg is still online (with css_tryget_online())
>    The memcg can still be offlined down the line.
>=20
>=20
> I've discussed this privately with Johannes, and it seems like the
> cleanest solution here is to move the reparenting logic down to =
release
> stage. That way, when get_mem_cgroup_from_objcg() returns,
> zswap_lru_add() is given an memcg that is reparenting-safe (until we
> drop the obtained reference).

