Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41E32780CF4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 15:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377384AbjHRNto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 09:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377478AbjHRNtY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 09:49:24 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DB124682
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:49:08 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-643909db8f4so9623496d6.1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 06:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20221208.gappssmtp.com; s=20221208; t=1692366547; x=1692971347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SknGd1OGAImO0gpD7vAgIL5kV6VxTVw1G0lBI9eZFTI=;
        b=rGCgpiLWWyHLpNU/f74FjInWfpLrfIOmGhhKPhf/ECN6iOuuc9UmP7vZHpSc9U7l0O
         HcTwar9abmVF268ZgWvh36PGzr8b1v/YYLek7Bu3pKfVTENUUgR+BvMvPcMwWXnNf2yC
         U339aTZ4MYbvbLH6KMSHI/QMpBzdJVT9w9fD2hvWlsFWFHnUIdnLNVAHWwN2hwKZsrRY
         cecpac6jkGwP4jmeDV7OaQsB18Xa3C7vuNoe4nVJ7QlS2upjiOSVI7ucPWdXMgrEFxcE
         4i957D3Cm9FFCwcL/sS7wO81OlEN01gco1e1a2MSzWFjZWWFS58dIA8Q4Dz2PeTStyO5
         KgTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692366547; x=1692971347;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SknGd1OGAImO0gpD7vAgIL5kV6VxTVw1G0lBI9eZFTI=;
        b=U8AlkctZayn/7GbRYTlhMoAbWMR4K9uaQewBu2pP+e/3dNzIaOW+Xa9KGvmYmdmx5/
         AQs5RqIUyCjr2bFY9W/EH2uOmnaWTymYjTjOQBGmK8uy7RntqNVGPVdxSaaCjDnykk0e
         p46oxOFjVhtB4QY5sv2jvO9o4cbAsqgroji8IMsmDyfRTj4jIFRyf3jJhKxGbpp5T2Cm
         z41AfFkQzZJje4Oihb8i7bcmrjmt9Xq6PcciPmj6dE+36LebpfDTOrFpqm6PGKEOrP83
         KH/T4A1ANYIdqlz+wodoXsAgxEpjjerdeIKkNn05NXXvk8P7D4HZt9OKRZbq2hhf+e4b
         /KYg==
X-Gm-Message-State: AOJu0YwY9t18Gmh30Jgo+bQLK7It9fuDohITTJG8LNgsF1l/gADEHlaS
        I5q5HJilvzb2Fu8DgVuDt9w1Aw==
X-Google-Smtp-Source: AGHT+IHqZZNdqmvvDJfUJAxKuFM7NyEFK3DwfOKGEkVIur/tVoF8cGu1PkjeI8ml0OTvhHLWs883Pg==
X-Received: by 2002:ad4:5dc7:0:b0:63c:f325:bb03 with SMTP id m7-20020ad45dc7000000b0063cf325bb03mr6752636qvh.8.1692366547079;
        Fri, 18 Aug 2023 06:49:07 -0700 (PDT)
Received: from localhost ([2620:10d:c091:400::5:75e0])
        by smtp.gmail.com with ESMTPSA id i8-20020a0cf388000000b0063d5d173a51sm697181qvk.50.2023.08.18.06.49.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Aug 2023 06:49:06 -0700 (PDT)
Date:   Fri, 18 Aug 2023 09:49:06 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Yosry Ahmed <yosryahmed@google.com>, Nhat Pham <nphamcs@gmail.com>,
        akpm@linux-foundation.org, kernel-team@meta.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] workingset: ensure memcg is valid for recency check
Message-ID: <20230818134906.GA138967@cmpxchg.org>
References: <20230817164733.2475092-1-nphamcs@gmail.com>
 <20230817190126.3155299-1-nphamcs@gmail.com>
 <CAJD7tkaNo=0mkYKxrTwGNaJ33G1z7cYdWhNQNF3tQp_MKCh-uA@mail.gmail.com>
 <CAKEwX=Pt3ir0jpn+eRjzH=K49b0Y0_N1NnieLm0a0VwV1aCKKQ@mail.gmail.com>
 <CAJD7tkb1jMuCouyL8OX0434HK0Wx=Hyf9UnGVOH8fP7NxA8+Pw@mail.gmail.com>
 <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOUHufbDhqSgSYZwkEo1aF1iFqGge_8jY3dt3OfPwXU0s07KOA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 05:12:17PM -0600, Yu Zhao wrote:
> On Thu, Aug 17, 2023 at 4:50 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> >
> > On Thu, Aug 17, 2023 at 3:43 PM Nhat Pham <nphamcs@gmail.com> wrote:
> > >
> > > On Thu, Aug 17, 2023 at 1:50 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> > > >
> > > > On Thu, Aug 17, 2023 at 12:01 PM Nhat Pham <nphamcs@gmail.com> wrote:
> > > > >
> > > > > In eviction recency check, we are currently not holding a local
> > > > > reference to the memcg that the refaulted folio belonged to when it was
> > > > > evicted. This could cause serious memcg lifetime issues, for e.g in the
> > > > > memcg hierarchy traversal done in mem_cgroup_get_nr_swap_pages(). This
> > > > > has occurred in production:
> > > > >
> > > > > [ 155757.793456] BUG: kernel NULL pointer dereference, address: 00000000000000c0
> > > > > [ 155757.807568] #PF: supervisor read access in kernel mode
> > > > > [ 155757.818024] #PF: error_code(0x0000) - not-present page
> > > > > [ 155757.828482] PGD 401f77067 P4D 401f77067 PUD 401f76067 PMD 0
> > > > > [ 155757.839985] Oops: 0000 [#1] SMP
> > > > > [ 155757.846444] CPU: 7 PID: 1380944 Comm: ThriftSrv-pri3- Kdump: loaded Tainted: G S                 6.4.3-0_fbk1_rc0_594_g8d0cbcaa67ba #1
> > > > > [ 155757.870808] Hardware name: Wiwynn Twin Lakes MP/Twin Lakes Passive MP, BIOS YMM16 05/24/2021
> > > > > [ 155757.887870] RIP: 0010:mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > > > > [ 155757.899377] Code: 29 19 4a 02 48 39 f9 74 63 48 8b 97 c0 00 00 00 48 8b b7 58 02 00 00 48 2b b7 c0 01 00 00 48 39 f0 48 0f 4d c6 48 39 d1 74 42 <48> 8b b2 c0 00 00 00 48 8b ba 58 02 00 00 48 2b ba c0 01 00 00 48
> > > > > [ 155757.937125] RSP: 0018:ffffc9002ecdfbc8 EFLAGS: 00010286
> > > > > [ 155757.947755] RAX: 00000000003a3b1c RBX: 000007ffffffffff RCX: ffff888280183000
> > > > > [ 155757.962202] RDX: 0000000000000000 RSI: 0007ffffffffffff RDI: ffff888bbc2d1000
> > > > > [ 155757.976648] RBP: 0000000000000001 R08: 000000000000000b R09: ffff888ad9cedba0
> > > > > [ 155757.991094] R10: ffffea0039c07900 R11: 0000000000000010 R12: ffff888b23a7b000
> > > > > [ 155758.005540] R13: 0000000000000000 R14: ffff888bbc2d1000 R15: 000007ffffc71354
> > > > > [ 155758.019991] FS:  00007f6234c68640(0000) GS:ffff88903f9c0000(0000) knlGS:0000000000000000
> > > > > [ 155758.036356] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > > > > [ 155758.048023] CR2: 00000000000000c0 CR3: 0000000a83eb8004 CR4: 00000000007706e0
> > > > > [ 155758.062473] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> > > > > [ 155758.076924] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> > > > > [ 155758.091376] PKRU: 55555554
> > > > > [ 155758.096957] Call Trace:
> > > > > [ 155758.102016]  <TASK>
> > > > > [ 155758.106502]  ? __die+0x78/0xc0
> > > > > [ 155758.112793]  ? page_fault_oops+0x286/0x380
> > > > > [ 155758.121175]  ? exc_page_fault+0x5d/0x110
> > > > > [ 155758.129209]  ? asm_exc_page_fault+0x22/0x30
> > > > > [ 155758.137763]  ? mem_cgroup_get_nr_swap_pages+0x3d/0xb0
> > > > > [ 155758.148060]  workingset_test_recent+0xda/0x1b0
> > > > > [ 155758.157133]  workingset_refault+0xca/0x1e0
> > > > > [ 155758.165508]  filemap_add_folio+0x4d/0x70
> > > > > [ 155758.173538]  page_cache_ra_unbounded+0xed/0x190
> > > > > [ 155758.182919]  page_cache_sync_ra+0xd6/0x1e0
> > > > > [ 155758.191738]  filemap_read+0x68d/0xdf0
> > > > > [ 155758.199495]  ? mlx5e_napi_poll+0x123/0x940
> > > > > [ 155758.207981]  ? __napi_schedule+0x55/0x90
> > > > > [ 155758.216095]  __x64_sys_pread64+0x1d6/0x2c0
> > > > > [ 155758.224601]  do_syscall_64+0x3d/0x80
> > > > > [ 155758.232058]  entry_SYSCALL_64_after_hwframe+0x46/0xb0
> > > > > [ 155758.242473] RIP: 0033:0x7f62c29153b5
> > > > > [ 155758.249938] Code: e8 48 89 75 f0 89 7d f8 48 89 4d e0 e8 b4 e6 f7 ff 41 89 c0 4c 8b 55 e0 48 8b 55 e8 48 8b 75 f0 8b 7d f8 b8 11 00 00 00 0f 05 <48> 3d 00 f0 ff ff 77 33 44 89 c7 48 89 45 f8 e8 e7 e6 f7 ff 48 8b
> > > > > [ 155758.288005] RSP: 002b:00007f6234c5ffd0 EFLAGS: 00000293 ORIG_RAX: 0000000000000011
> > > > > [ 155758.303474] RAX: ffffffffffffffda RBX: 00007f628c4e70c0 RCX: 00007f62c29153b5
> > > > > [ 155758.318075] RDX: 000000000003c041 RSI: 00007f61d2986000 RDI: 0000000000000076
> > > > > [ 155758.332678] RBP: 00007f6234c5fff0 R08: 0000000000000000 R09: 0000000064d5230c
> > > > > [ 155758.347452] R10: 000000000027d450 R11: 0000000000000293 R12: 000000000003c041
> > > > > [ 155758.362044] R13: 00007f61d2986000 R14: 00007f629e11b060 R15: 000000000027d450
> > > > > [ 155758.376661]  </TASK>
> > > > >
> > > > > This patch fixes the issue by getting a local reference inside
> > > > > unpack_shadow().
> > > > >
> > > > > Fixes: f78dfc7b77d5 ("workingset: fix confusion around eviction vs refault container")
> > > >
> > > > Beyond mem_cgroup_get_nr_swap_pages(), we still use the eviction_memcg
> > > > without grabbing a ref to it first in workingset_test_recent() (and in
> > > > workingset_refault() before that) as well as lru_gen_test_recent().
> > > >
> > > > Wouldn't the fix go back even further? or am I misinterpreting the problem?
> > > Hmm I don't see eviction_memcg being used outside of *_test_recent
> > > (the rest just uses memcg = folio_memcg(folio), which if I'm not mistaken is
> > > the memcg that is refaulting the folio into memory).
> > >
> > > Inside workingset_test_recent(), the only other place where eviction_memcg
> > > is used is for mem_cgroup_lruvec. This function call won't crash whether
> > > eviction_memcg is valid or not.
> >
> > If eviction_memcg is invalid because the memory was already freed, we
> > are basically dereferencing garbage in mem_cgroup_lruvec() aren't we?
> >
> > > The crash only happens during
> > > mem_cgroup_get_nr_swap_pages, which has an upward traversal from
> > > eviction_memcg to root.
> > >
> > > Let me know if this does not make sense and/or is insufficient to ensure
> > > safe upward traversal from eviction_memcg to root!
> > > >
> > > >
> > > >
> > > > > Signed-off-by: Nhat Pham <nphamcs@gmail.com>
> > > > > Cc: stable@vger.kernel.org
> > > > > ---
> > > > >  mm/workingset.c | 65 ++++++++++++++++++++++++++++++++-----------------
> > > > >  1 file changed, 43 insertions(+), 22 deletions(-)
> > > > >
> > > > > diff --git a/mm/workingset.c b/mm/workingset.c
> > > > > index da58a26d0d4d..03cadad4e484 100644
> > > > > --- a/mm/workingset.c
> > > > > +++ b/mm/workingset.c
> > > > > @@ -206,10 +206,19 @@ static void *pack_shadow(int memcgid, pg_data_t *pgdat, unsigned long eviction,
> > > > >         return xa_mk_value(eviction);
> > > > >  }
> > > > >
> > > > > -static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
> > > > > -                         unsigned long *evictionp, bool *workingsetp)
> > > > > +/*
> > > > > + * Unpacks the stored fields of a shadow entry into the given pointers.
> > > > > + *
> > > > > + * The memcg pointer is only populated if the memcg recorded in the shadow
> > > > > + * entry is valid. In this case, a reference to the memcg will be acquired,
> > > > > + * and a corresponding mem_cgroup_put() will be needed when we no longer
> > > > > + * need the memcg.
> > > > > + */
> > > > > +static void unpack_shadow(void *shadow, struct mem_cgroup **memcgp,
> > > > > +                       pg_data_t **pgdat, unsigned long *evictionp, bool *workingsetp)
> > > > >  {
> > > > >         unsigned long entry = xa_to_value(shadow);
> > > > > +       struct mem_cgroup *memcg;
> > > > >         int memcgid, nid;
> > > > >         bool workingset;
> > > > >
> > > > > @@ -220,7 +229,24 @@ static void unpack_shadow(void *shadow, int *memcgidp, pg_data_t **pgdat,
> > > > >         memcgid = entry & ((1UL << MEM_CGROUP_ID_SHIFT) - 1);
> > > > >         entry >>= MEM_CGROUP_ID_SHIFT;
> > > > >
> > > > > -       *memcgidp = memcgid;
> > > > > +       /*
> > > > > +        * Look up the memcg associated with the stored ID. It might
> > > > > +        * have been deleted since the folio's eviction.
> > > > > +        *
> > > > > +        * Note that in rare events the ID could have been recycled
> > > > > +        * for a new cgroup that refaults a shared folio. This is
> > > > > +        * impossible to tell from the available data. However, this
> > > > > +        * should be a rare and limited disturbance, and activations
> > > > > +        * are always speculative anyway. Ultimately, it's the aging
> > > > > +        * algorithm's job to shake out the minimum access frequency
> > > > > +        * for the active cache.
> > > > > +        */
> > > > > +       memcg = mem_cgroup_from_id(memcgid);
> > > > > +       if (memcg && css_tryget(&memcg->css))
> > > > > +               *memcgp = memcg;
> > > > > +       else
> > > > > +               *memcgp = NULL;
> > > > > +
> > > > >         *pgdat = NODE_DATA(nid);
> > > > >         *evictionp = entry;
> > > > >         *workingsetp = workingset;
> > > > > @@ -262,15 +288,16 @@ static void *lru_gen_eviction(struct folio *folio)
> > > > >  static bool lru_gen_test_recent(void *shadow, bool file, struct lruvec **lruvec,
> > > > >                                 unsigned long *token, bool *workingset)
> > > > >  {
> > > > > -       int memcg_id;
> > > > >         unsigned long min_seq;
> > > > >         struct mem_cgroup *memcg;
> > > > >         struct pglist_data *pgdat;
> > > > >
> > > > > -       unpack_shadow(shadow, &memcg_id, &pgdat, token, workingset);
> > > > > +       unpack_shadow(shadow, &memcg, &pgdat, token, workingset);
> > > > > +       if (!mem_cgroup_disabled() && !memcg)
> > > > > +               return false;
> > > >
> > > > +Yu Zhao
> > > >
> > > > There is a change of behavior here, right?
> > > >
> > > > The existing code will continue if !mem_cgroup_disabled() && !memcg is
> > > > true, and mem_cgroup_lruvec() will return the lruvec of the root
> > > > memcg. Now we are just returning false.
> > > >
> > > > Is this intentional?
> > > Oh right, there is. Should have cc-ed Yu Zhao as well, my bad.
> > > get_maintainers.pl isn't always sufficient I guess :)
> > >
> > > But yeah, this behavioral change is intentional.
> > >
> > > Correct me if I'm wrong of course, but it seems like MGLRU should
> > > follow the same pattern here. That is, once we return from unpack_shadow,
> > > the possible scenarios are the same as prescribed in workingset_test_recent:
> > >
> > > 1. If mem_cgroup is disabled, we can ignore this check.
> > > 2. If mem_cgroup is enabled, then the only reason why we get NULL
> > > memcg from unpack_shadow is if the eviction_memcg is no longer
> > > valid.  We should not try to get its lruvec, or substitute it with the
> > > root memcg, but return false right away (i.e not recent).
> > > >
> >
> > I will leave this for Yu :)
> 
> Thanks, Yosry.
> 
> Hi Nhat, it seems unnecessary to me to introduce a get/put into
> lru_gen_test_recent() because it doesn't suffer from the bug this
> patch tries to fix. In theory, the extra get/put can impact
> performance, though admittedly the impact is unlikely to be
> measurable. Regardless, the general practice is to fix the bug
> locally, i.e., when the mem_cgroup_get_nr_swap_pages() path is taken,
> rather than change the unrelated path. Thank you.

Hey guys,

I had suggested to have it in unpack_shadow() to keep things simple,
and not further complicate the lifetime rules in this code. The
tryget() is against a per-cpu counter, so it's not expensive.

The NULL deref is evidence that while *some* cgroup members are still
accessible once it's dead, not all of it is. There is no explicit
guarantee from the cgroup code that anything BUT the tryget() is still
valid against group that is under rcu freeing.

Since it isn't expensive, let's keep it simple and robust, and prevent
future bugs of the same class, by always ensuring the cgroup is alive
before accessing random members. Especially in non-cgroup code.
