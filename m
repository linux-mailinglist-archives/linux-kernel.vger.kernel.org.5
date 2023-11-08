Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665017E56AA
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 13:59:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344616AbjKHM7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 07:59:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344583AbjKHM7J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 07:59:09 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AB821BF5
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 04:59:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Transfer-Encoding:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=sLIymDU8NTMb4JE6uhmaFeHtnc3AURJlksCh4tSko9U=; b=kPRSk5L61jcyG45/orAsN/ynkf
        ovAdKMefXglNg6QsSI+NI0cGN5lJXK+eH3YIE9L7w9iQbEevBia/Y6ma4PeiBkBg/seESqfPZPI2n
        Gwi/ZPKbtlEYPDJAmMsxAhUJZvY+T7Puy3AlgC2fGh3lPb1JVkBZVBccNWLRYV44iOxZtQCLOSt3w
        I1VJ3WFbvgM4ZMjMIXtStozEQhYIAppW6VynubetqZqTUT+46CxLkJC4ky7gccmA5PjX3TMxs8MpR
        5OV8ya4SiQmzNCDws33YhxNqcmVJlyGbVgdDIh0TZ41V+F4sMF0FKDow1TNK96iU7hhdtfy2HVmiq
        UVeVPhrA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1r0i8v-0016aZ-7p; Wed, 08 Nov 2023 12:58:49 +0000
Date:   Wed, 8 Nov 2023 12:58:49 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Ankur Arora <ankur.a.arora@oracle.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        linux-kernel@vger.kernel.org, tglx@linutronix.de,
        peterz@infradead.org, torvalds@linux-foundation.org,
        paulmck@kernel.org, linux-mm@kvack.org, x86@kernel.org,
        akpm@linux-foundation.org, luto@kernel.org, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, mingo@redhat.com,
        juri.lelli@redhat.com, vincent.guittot@linaro.org, mgorman@suse.de,
        jon.grimm@amd.com, bharata@amd.com, raghavendra.kt@amd.com,
        boris.ostrovsky@oracle.com, konrad.wilk@oracle.com,
        jgross@suse.com, andrew.cooper3@citrix.com, mingo@kernel.org,
        bristot@kernel.org, mathieu.desnoyers@efficios.com,
        geert@linux-m68k.org, glaubitz@physik.fu-berlin.de,
        anton.ivanov@cambridgegreys.com, mattst88@gmail.com,
        krypton@ulrich-teichert.org, rostedt@goodmis.org,
        David.Laight@aculab.com, richard@nod.at, mjguzik@gmail.com,
        SeongJae Park <sj@kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <muchun.song@linux.dev>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        Marco Elver <elver@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Rapoport <rppt@kernel.org>, Will Deacon <will@kernel.org>,
        "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
        Nick Piggin <npiggin@gmail.com>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Hugh Dickins <hughd@google.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Minchan Kim <minchan@kernel.org>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>
Subject: Re: [RFC PATCH 68/86] treewide: mm: remove cond_resched()
Message-ID: <ZUuGCekSB727c61n@casper.infradead.org>
References: <20231107215742.363031-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-1-ankur.a.arora@oracle.com>
 <20231107230822.371443-12-ankur.a.arora@oracle.com>
 <20231108012823.GD11577@google.com>
 <7155f21f-a7e5-cc36-89e5-c1ce257b9420@suse.cz>
 <CAJD7tkYYqqYT361pbeqTFxoAep2qtTAWSQx4SzFCcEEOZgRT3Q@mail.gmail.com>
 <87sf5gocas.fsf@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87sf5gocas.fsf@oracle.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 08, 2023 at 12:54:19AM -0800, Ankur Arora wrote:
> Yosry Ahmed <yosryahmed@google.com> writes:
> > On Tue, Nov 7, 2023 at 11:49 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >> On 11/8/23 02:28, Sergey Senozhatsky wrote:
> >> > I'd personally prefer to have a comment explaining why we do that
> >> > spin_unlock/spin_lock sequence, which may look confusing to people.
> >>
> >> Wonder if it would make sense to have a lock operation that does the
> >> unlock/lock as a self-documenting thing, and maybe could also be optimized
> >> to first check if there's a actually a need for it (because TIF_NEED_RESCHED
> >> or lock is contended).
> >
> > +1, I was going to suggest this as well. It can be extended to other
> > locking types that disable preemption as well like RCU. Something like
> > spin_lock_relax() or something.
> 
> Good point. We actually do have exactly that: cond_resched_lock(). (And
> similar RW lock variants.)

That's a shame; I was going to suggest calling it spin_cycle() ...
