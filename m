Return-Path: <linux-kernel+bounces-36527-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FD3F83A268
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9EA85B21C72
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A13916431;
	Wed, 24 Jan 2024 06:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e2YAbF7B"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D82FE16415
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706079491; cv=none; b=hKv2tZv0yfjTLxndRzjBOL/HnGsc85YK/m869cbuPZLoOr+oKbjKYnEYH82Y+FZbW1wsvfdhLbSKWRYY1q9oGikRV9kCSuX8XoFtWw29iYpapAiTHLQBakT7krG/YWuMjhfxeIQmYNJK9Qo186WNGV0T8Cv0uZZWf1r3CpuXrN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706079491; c=relaxed/simple;
	bh=zyDuhJYKfkd5nL0QBFJLg9VBUkEdWhtlTT/0OWEifiM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Vpqk9HPaJGhzwZT5Mog8+Tx8qxHAs0LdU4i8m4kCmmMjXtaH6hGuhe5mUH6u5fYntucBFXv/5TMTGN/pm1gMEvGA6cDGSTNX2UF2omMTXbRlKYjieDdbjEp54RL6bZZwkuHznIJ+q8if3wDr+n0gHNTvBLoHHtPmm8qpe0feUhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=e2YAbF7B; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-50edf4f478eso6826346e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:58:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1706079487; x=1706684287; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/HUNAWl4C+LajTE63kyebzHQxUP0MAIa9ujNkriZ7FM=;
        b=e2YAbF7BfZgG/s7chyHEQx6yAbSiWid2OeRBW3IkdDdJHN6Fsz+LM+kEc3Ot4TOMDj
         CzPgcyXE0gIBTf70GNJLAOQd7TSR1lYV1tuOJMZJ9cGue5a2OWXAylrb263D0mGw6mx5
         l4wc//uNh8ftUA2GGoAszjyCdhIhYOA2jdtBNTJz8vjhFHfHwboHI1V8Y/9cd+GiX6Nq
         YlDaPFIqVdWUY9YhY4gsO2sYWNSUQtasZdcWGtXWkUesQNkUZffYSEUyWz7Gbh9oRqZ3
         DEv50AvgQIGuG9GI028n0REnRMqTqFc+JirfX71rM+OVX1DPfVuY8XNMycAjHM/pF6pv
         yaIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706079487; x=1706684287;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/HUNAWl4C+LajTE63kyebzHQxUP0MAIa9ujNkriZ7FM=;
        b=JTOXXOaA9htbr0MwwEfL+9uSSyOT8GiHZVS8Bdh5Ifba3K5rcSyWNhRgXn6NGIYsiT
         FcNuk7bNHvfAjbSrrT8DwK8Ch3KzU8ZPYxtFhAxn9znCUB6Iw8JOBwKs2mU+fVTHMcRT
         JQRC31upiL1UW9RrZECopKuD+8amXjipGMQ55wxtxHC4amgzS2YoYOT020Mq0KVF3AB8
         dOPDebO/qRSMzV92+e1WSVdvV1Oi6iUCniyWZsE6isuqR1XzBh+6MJxH/0Elfp5YICEv
         1xOf2BQUOSRcIZ2LbQl/9RUO3bi8Slcy2+red3KVvwItgo566HyhylCLtH3eqUB0nRuo
         m4wQ==
X-Gm-Message-State: AOJu0YzUqNjOgsAbW4anxWp6AgURlM7c8MFwGhYEqVgGRDWYrjR691D1
	7rKs9ypdu4i0FiVVBnF1yK9QYVXE+M9h4dtg0ivKN6ejmvVb5FES3PVqc+N02os9nidoJgNlCeH
	me7IYPYGEnmfp9S+dSCDEEj1drOMwjsdjAMIN
X-Google-Smtp-Source: AGHT+IEJEsLHmf36UzMWexlGozGTA3oncay9+EIOYknKAP+eAjKjeJ3MHNltDTaFjlQPJAUKixYdmXAstWPNY7P/2RQ=
X-Received: by 2002:a05:6512:10c3:b0:50f:152b:4430 with SMTP id
 k3-20020a05651210c300b0050f152b4430mr4342142lfg.8.1706079487182; Tue, 23 Jan
 2024 22:58:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240120024007.2850671-1-yosryahmed@google.com>
 <20240120024007.2850671-3-yosryahmed@google.com> <20240122201906.GA1567330@cmpxchg.org>
 <CAJD7tkaATS48HVuBfbOmPM3EvRUoPFr66WhF64UC4FkyVH5exg@mail.gmail.com>
 <20240123153851.GA1745986@cmpxchg.org> <CAJD7tkasHsRnT_75-TXsEe58V9_OW6m3g6CF7Kmsvz8CKRG_EA@mail.gmail.com>
 <20240123201234.GC1745986@cmpxchg.org> <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
In-Reply-To: <CAJD7tkZC6w2EaE=j2NEVWn1s7Lo2A7YZh8LiZ+w72jQzFFWLUQ@mail.gmail.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 23 Jan 2024 22:57:30 -0800
Message-ID: <CAJD7tkaVdJ9B_UDQs+o1nLdbs62CeKgbCyEXbMdezaBgOruEWw@mail.gmail.com>
Subject: Re: [PATCH 2/2] mm: zswap: remove unnecessary tree cleanups in zswap_swapoff()
To: Johannes Weiner <hannes@cmpxchg.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Nhat Pham <nphamcs@gmail.com>, 
	Chris Li <chrisl@kernel.org>, Chengming Zhou <zhouchengming@bytedance.com>, 
	Huang Ying <ying.huang@intel.com>, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000cc0d87060fab951c"

--000000000000cc0d87060fab951c
Content-Type: text/plain; charset="UTF-8"

> > > > > However, while I have your attention on the swapoff path, there's a
> > > > > slightly irrelevant problem that I think might be there, but I am not
> > > > > sure.
> > > > >
> > > > > It looks to me like swapoff can race with writeback, and there may be
> > > > > a chance of UAF for the zswap tree. For example, if zswap_swapoff()
> > > > > races with shrink_memcg_cb(), I feel like we may free the tree as it
> > > > > is being used. For example if zswap_swapoff()->kfree(tree) happen
> > > > > right before shrink_memcg_cb()->list_lru_isolate(l, item).
> > > > >
> > > > > Please tell me that I am being paranoid and that there is some
> > > > > protection against zswap writeback racing with swapoff. It feels like
> > > > > we are very careful with zswap entries refcounting, but not with the
> > > > > zswap tree itself.
> > > >
> > > > Hm, I don't see how.
> > > >
> > > > Writeback operates on entries from the LRU. By the time
> > > > zswap_swapoff() is called, try_to_unuse() -> zswap_invalidate() should
> > > > will have emptied out the LRU and tree.
> > > >
> > > > Writeback could have gotten a refcount to the entry and dropped the
> > > > tree->lock. But then it does __read_swap_cache_async(), and while
> > > > holding the page lock checks the tree under lock once more; if that
> > > > finds the entry valid, it means try_to_unuse() hasn't started on this
> > > > page yet, and would be held up by the page lock/writeback state.
> > >
> > > Consider the following race:
> > >
> > > CPU 1                                 CPU 2
> > > # In shrink_memcg_cb()     # In swap_off
> > > list_lru_isolate()
> > >                                             zswap_invalidate()
> > >                                             ..
> > >                                             zswap_swapoff() -> kfree(tree)
> > > spin_lock(&tree->lock);
> > >
> > > Isn't this a UAF or am I missing something here?
> >
> > Oof. You're right, it looks like there is a bug. Digging through the
> > history, I think this is actually quite old: the original backend
> > shrinkers would pluck something off their LRU, drop all locks, then
> > try to acquire tree->lock. There is no protection against swapoff.
> >
> > The lock that is supposed to protect this is the LRU lock. That's
> > where reclaim and invalidation should synchronize. But it's not right:
> >
> > 1. We drop the LRU lock before acquiring the tree lock. We should
> >    instead trylock the tree while still holding the LRU lock to make
> >    sure the tree is safe against swapoff.
> >
> > 2. zswap_invalidate() acquires the LRU lock when refcount hits 0. But
> >    it must always cycle the LRU lock before freeing the tree for that
> >    synchronization to work.
> >
> > Once we're holding a refcount to the entry, it's safe to drop all
> > locks for the next step because we'll then work against the swapcache
> > and entry: __read_swap_cache_async() will try to pin and lock whatever
> > swap entry is at that type+offset. This also pins the type's current
> > tree. HOWEVER, if swapoff + swapon raced, this could be a different
> > tree than what we had in @tree, so
> >
> > 3. we shouldn't pass @tree to zswap_writeback_entry(). It needs to
> >    look up zswap_trees[] again after __read_swap_cache_async()
> >    succeeded to validate the entry.
> >
> > Once it succeeded, we can validate the entry. The entry is valid due
> > to our refcount. The zswap_trees[type] is valid due to the cache pin.
> >
> > However, if validation failed and we have a non-zero writeback_result,
> > there is one last bug:
> >
> > 4. the original entry's tree is no longer valid for the entry put.
> >
> > The current scheme handles invalidation fine (which is good because
> > that's quite common). But it's fundamentally unsynchronized against
> > swapoff (which has probably gone undetected because that's rare).
> >
> > I can't think of an immediate solution to this, but I wanted to put my
> > analysis out for comments.
>
>
> Thanks for the great analysis, I missed the swapoff/swapon race myself :)
>
> The first solution that came to mind for me was refcounting the zswap
> tree with RCU with percpu-refcount, similar to how cgroup refs are
> handled (init in zswap_swapon() and kill in zswap_swapoff()). I think
> the percpu-refcount may be an overkill in terms of memory usage
> though. I think we can still do our own refcounting with RCU, but it
> may be more complicated.

FWIW, I was able to reproduce the problem in a vm with the following
kernel diff:
diff --git a/mm/zswap.c b/mm/zswap.c
index 78df16d307aa8..6580a4be52a18 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -880,6 +880,9 @@ static enum lru_status shrink_memcg_cb(struct
list_head *item, struct list_lru_o
         */
        spin_unlock(lock);

+       pr_info("Sleeping in shrink_memcg_cb() before
spin_lock(&tree->lock)\n");
+       schedule_timeout_uninterruptible(msecs_to_jiffies(10 * 1000));
+
        /* Check for invalidate() race */
        spin_lock(&tree->lock);
        if (entry != zswap_rb_search(&tree->rbroot, swpoffset))

This basically expands the race window to 10 seconds. I have a
reproducer script attached that utilizes the zswap shrinker (which
makes this much easier to reproduce btw). The steps are as follows:
- Compile the kernel with the above diff, and both ZRAM & KASAN enabled.
- In one terminal, run zswap_wb_swapoff_race.sh.
- In a different terminal, once the "Sleeping in shrink_memcg_cb()"
message is logged, run "swapoff /dev/zram0".
- In the first terminal, once the 10 seconds elapse, I get a UAF BUG
from KASAN (log attached as well).

--000000000000cc0d87060fab951c
Content-Type: text/x-sh; charset="US-ASCII"; name="zswap_wb_swapoff_race.sh"
Content-Disposition: attachment; filename="zswap_wb_swapoff_race.sh"
Content-Transfer-Encoding: base64
Content-ID: <f_lrrfmazh1>
X-Attachment-Id: f_lrrfmazh1

IyEvYmluL2Jhc2gKClRPVEFMX01CPTEwMApUT1RBTF9CWVRFUz0kKChUT1RBTF9NQiA8PCAyMCkp
ClJPT1RfQ0c9L3N5cy9mcy9jZ3JvdXAKWlJBTV9ERVY9L2Rldi96cmFtMApUTVBGUz0uL3RtcGZz
CkFfQVNDSUk9JChwcmludGYgJyVkJyAiJ0EiKQoKZnVuY3Rpb24gY2xlYW51cCgpIHsKICBybSAt
cmYgJFRNUEZTLyoKICB1bW91bnQgJFRNUEZTCiAgcm1kaXIgJFRNUEZTCgogIGlmIHN3YXBvbiAt
cyB8IGdyZXAgLXEgJFpSQU1fREVWOyB0aGVuCiAgICBzd2Fwb2ZmICRaUkFNX0RFVgogIGZpCiAg
ZWNobyAxID4gL3N5cy9ibG9jay96cmFtMC9yZXNldAoKICBybWRpciAkUk9PVF9DRy90ZXN0Cn0K
dHJhcCBjbGVhbnVwIEVYSVQKCmVjaG8gMSA+IC9zeXMvbW9kdWxlL3pzd2FwL3BhcmFtZXRlcnMv
c2hyaW5rZXJfZW5hYmxlZAoKIyBJbml0aWFsaXplIHRtcGZzCm1rZGlyICRUTVBGUwptb3VudCAt
dCB0bXBmcyBub25lICRUTVBGUwoKIyBJbml0aWFsaXplIHpyYW0KZWNobyAkKChUT1RBTF9NQioy
KSltID4gL3N5cy9ibG9jay96cmFtMC9kaXNrc2l6ZQpta3N3YXAgLUwgenJhbTAgJFpSQU1fREVW
CnN3YXBvbiAkWlJBTV9ERVYKCiMgSW5pdGlhbGl6ZSBjZ3JvdXAKZWNobyAiK21lbW9yeSIgPiAk
Uk9PVF9DRy9jZ3JvdXAuc3VidHJlZV9jb250cm9sCm1rZGlyICRST09UX0NHL3Rlc3QKCiMgQ3Jl
YXRlIGEgdGVzdCB0bXBmcyBmaWxlIGNvbnRhaW5pbmcgdGhlIGFscGhhYmV0IG9uIHJlcGVhdAoo
CiAgZWNobyAwID4gJFJPT1RfQ0cvdGVzdC9jZ3JvdXAucHJvY3MKICBzPSQocHJpbnRmICclcycg
e0EuLlp9KQogIHllcyAkcyB8IGRkIGlmbGFnPWZ1bGxibG9jayBvZj0kVE1QRlMvdGVzdCBicz0x
TSBjb3VudD0kVE9UQUxfTUIgc3RhdHVzPW5vbmUKKQoKIyBSZWNsYWltIGV2ZXJ5dGhpbmcgKGlu
dm9raW5nIHRoZSB6c3dhcCBzaHJpbmtlcikKZWNobyAkVE9UQUxfQllURVMgPiAkUk9PVF9DRy90
ZXN0L21lbW9yeS5yZWNsYWltCg==
--000000000000cc0d87060fab951c
Content-Type: application/octet-stream; name=uaf_log
Content-Disposition: attachment; filename=uaf_log
Content-Transfer-Encoding: base64
Content-ID: <f_lrrfmaze0>
X-Attachment-Id: f_lrrfmaze0

WyAgIDMwLjI1MTExNF0genN3YXA6IFNsZWVwaW5nIGluIHNocmlua19tZW1jZ19jYigpIGJlZm9y
ZSBzcGluX2xvY2soJnRyZWUtPmxvY2spClsgICA0MC40MDg0MzFdID09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQpbICAgNDAu
NDEzMDYyXSBCVUc6IEtBU0FOOiBzbGFiLXVzZS1hZnRlci1mcmVlIGluIF9yYXdfc3Bpbl9sb2Nr
KzB4NTkvMHgxMTAKWyAgIDQwLjQxNzI0N10gV3JpdGUgb2Ygc2l6ZSA0IGF0IGFkZHIgZmZmZjg4
ODEwMjUyZGM5OCBieSB0YXNrIHpzd2FwX3diX3N3YXBvZi8zODMKWyAgIDQwLjQyMTYwOV0KWyAg
IDQwLjQyMjY0OF0gQ1BVOiAwIFBJRDogMzgzIENvbW06IHpzd2FwX3diX3N3YXBvZiBOb3QgdGFp
bnRlZCA2LjcuMCsgIzE5ClsgICA0MC40MjY2NjNdIEhhcmR3YXJlIG5hbWU6IFFFTVUgU3RhbmRh
cmQgUEMgKFEzNSArIElDSDksIDIwMDkpLCBCSU9TIDEuMTYuMy1kZWJpYW4tMS4xNi4zLTIgMDQv
MDEvMjAxNApbICAgNDAuNDMyMTUxXSBDYWxsIFRyYWNlOgpbICAgNDAuNDMzNzE3XSAgPFRBU0s+
ClsgICA0MC40MzUxMjVdICBkdW1wX3N0YWNrX2x2bCsweDk4LzB4ZDAKWyAgIDQwLjQzNzM4OV0g
IHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24rMHg3Zi8weDNhMApbICAgNDAuNDQwMjcyXSAgcHJp
bnRfcmVwb3J0KzB4MTE5LzB4MjIwClsgICA0MC40NDI1NDBdICA/IF9yYXdfc3Bpbl9sb2NrKzB4
NTkvMHgxMTAKWyAgIDQwLjQ0NDk3MV0gID8ga2FzYW5fY29tcGxldGVfbW9kZV9yZXBvcnRfaW5m
bysweDY2LzB4ODAKWyAgIDQwLjQ0ODE3MF0gID8gX3Jhd19zcGluX2xvY2srMHg1OS8weDExMApb
ICAgNDAuNDUwNTcxXSAga2FzYW5fcmVwb3J0KzB4ZDcvMHgxMTAKWyAgIDQwLjQ1Mjc2Ml0gID8g
X3Jhd19zcGluX2xvY2srMHg1OS8weDExMApbICAgNDAuNDU1MjgxXSAga2FzYW5fY2hlY2tfcmFu
Z2UrMHgyNTAvMHgyZjAKWyAgIDQwLjQ1Nzc4Ml0gID8gX3Jhd19zcGluX2xvY2srMHg1OS8weDEx
MApbICAgNDAuNDYwMTYxXSAgX19rYXNhbl9jaGVja193cml0ZSsweDE4LzB4MjAKWyAgIDQwLjQ2
MjYzOF0gIF9yYXdfc3Bpbl9sb2NrKzB4NTkvMHgxMTAKWyAgIDQwLjQ2NDkzM10gIHNocmlua19t
ZW1jZ19jYisweDExYy8weDcwMApbICAgNDAuNDY3MzYwXSAgPyB4YV9sb2FkKzB4Y2QvMHgxNDAK
WyAgIDQwLjQ2OTQyOV0gIF9fbGlzdF9scnVfd2Fsa19vbmUrMHgyMzYvMHg1YzAKWyAgIDQwLjQ3
MjA4MF0gID8genN3YXBfc2hyaW5rZXJfY291bnQrMHgzMzAvMHgzMzAKWyAgIDQwLjQ3NDg0MV0g
ID8genN3YXBfc2hyaW5rZXJfY291bnQrMHgzMzAvMHgzMzAKWyAgIDQwLjQ3NzU4Nl0gIGxpc3Rf
bHJ1X3dhbGtfb25lKzB4YTMvMHgxMDAKWyAgIDQwLjQ4MDAyM10gIHpzd2FwX3Nocmlua2VyX3Nj
YW4rMHgyYzcvMHg0NTAKWyAgIDQwLjQ4MjY0OV0gIGRvX3Nocmlua19zbGFiKzB4M2E2LzB4OGYw
ClsgICA0MC40ODUwMDVdICBzaHJpbmtfc2xhYl9tZW1jZysweDNmZS8weDdjMApbICAgNDAuNDg3
NDk5XSAgc2hyaW5rX3NsYWIrMHg3Yy8weDNhMApbICAgNDAuNDg5NjU4XSAgPyBtZW1fY2dyb3Vw
X2l0ZXIrMHgyYWUvMHg3ODAKWyAgIDQwLjQ5MjEzN10gIHNocmlua19ub2RlX21lbWNncysweDM5
Ny8weDY3MApbICAgNDAuNDk0NjcxXSAgc2hyaW5rX25vZGUrMHgyNWYvMHhjZTAKWyAgIDQwLjQ5
Njg3N10gIHNocmlua196b25lcysweDUzMS8weDllMApbICAgNDAuNDk5MTYwXSAgZG9fdHJ5X3Rv
X2ZyZWVfcGFnZXMrMHgxZjQvMHhiMTAKWyAgIDQwLjUwMTgzOF0gIHRyeV90b19mcmVlX21lbV9j
Z3JvdXBfcGFnZXMrMHgzN2QvMHg3YzAKWyAgIDQwLjUwNDg5M10gIG1lbW9yeV9yZWNsYWltKzB4
MzAxLzB4MzcwClsgICA0MC41MDcyNDldICA/IF9jb3B5X2Zyb21faXRlcisweDE2Mi8weDExZTAK
WyAgIDQwLjUwOTg1MV0gID8gY2hlY2tfaGVhcF9vYmplY3QrMHgxNjAvMHg0MTAKWyAgIDQwLjUx
MjQ2M10gIGNncm91cF9maWxlX3dyaXRlKzB4MWUzLzB4M2QwClsgICA0MC41MTQ5NjBdICA/IGNn
cm91cF9zZXFmaWxlX3N0b3ArMHhiMC8weGIwClsgICA0MC41MTc2MDFdICBrZXJuZnNfZm9wX3dy
aXRlX2l0ZXIrMHgyOGUvMHgzOTAKWyAgIDQwLjUyMDM0OV0gIHZmc193cml0ZSsweDdkMi8weGIx
MApbICAgNDAuNTIyNDc4XSAga3N5c193cml0ZSsweGRlLzB4MWEwClsgICA0MC41MjQ1NzRdICBf
X3g2NF9zeXNfd3JpdGUrMHg3Zi8weDkwClsgICA0MC41MjY4OTFdICBkb19zeXNjYWxsXzY0KzB4
NmMvMHgxNTAKWyAgIDQwLjUyOTE0MF0gIGVudHJ5X1NZU0NBTExfNjRfYWZ0ZXJfaHdmcmFtZSsw
eDYzLzB4NmIKWyAgIDQwLjUzMjE4OV0gUklQOiAwMDMzOjB4N2Y3MThhOTgyYjAwClsgICA0MC41
MzQ0MTFdIENvZGU6IDQwIDAwIDQ4IDhiIDE1IDE5IGIzIDBkIDAwIGY3IGQ4IDY0IDg5IDAyIDQ4
IGM3IGMwIGZmIGZmIGZmIGZmIGViIGI3IDBmIDFmIDAwIDgwIDNkIGUxIDNhIDBlIDAwIDAwIDc0
IDE3IGI4IDAxIDAwIDAwIDAwIDA5ClsgICA0MC41NDUzMzhdIFJTUDogMDAyYjowMDAwN2ZmZmY1
ZmI1YzY4IEVGTEFHUzogMDAwMDAyMDIgT1JJR19SQVg6IDAwMDAwMDAwMDAwMDAwMDEKWyAgIDQw
LjU0OTg0Nl0gUkFYOiBmZmZmZmZmZmZmZmZmZmRhIFJCWDogMDAwMDAwMDAwMDAwMDAwYSBSQ1g6
IDAwMDA3ZjcxOGE5ODJiMDAKWyAgIDQwLjU1NDEwNl0gUkRYOiAwMDAwMDAwMDAwMDAwMDBhIFJT
STogMDAwMDU1NjRmYjFkNTg4MCBSREk6IDAwMDAwMDAwMDAwMDAwMDEKWyAgIDQwLjU1ODM0Ml0g
UkJQOiAwMDAwNTU2NGZiMWQ1ODgwIFIwODogMDAwMDAwMDAwMDAwMDA3MyBSMDk6IDAwMDAwMDAw
MDAwMDAwMDEKWyAgIDQwLjU2MjU4Nl0gUjEwOiAwMDAwMDAwMDAwMDAwMDAwIFIxMTogMDAwMDAw
MDAwMDAwMDIwMiBSMTI6IDAwMDAwMDAwMDAwMDAwMGEKWyAgIDQwLjU2Njg1OV0gUjEzOiAwMDAw
N2Y3MThhYTVmNzgwIFIxNDogMDAwMDAwMDAwMDAwMDAwYSBSMTU6IDAwMDA3ZjcxOGFhNWFkMDAK
WyAgIDQwLjU3MTEwM10gIDwvVEFTSz4KWyAgIDQwLjU3MjQ4OV0KWyAgIDQwLjU3MzUxMl0gQWxs
b2NhdGVkIGJ5IHRhc2sgMzg4OgpbICAgNDAuNTc1NjUwXSAga2FzYW5fc2F2ZV90cmFjaysweDMw
LzB4NjAKWyAgIDQwLjU3Nzk4Nl0gIGthc2FuX3NhdmVfYWxsb2NfaW5mbysweDY5LzB4NzAKWyAg
IDQwLjU4MDU3Ml0gIF9fa2FzYW5fa21hbGxvYysweGEyLzB4YjAKWyAgIDQwLjU4Mjg3OV0gIF9f
a21hbGxvY19ub2RlKzB4MWVlLzB4NDIwClsgICA0MC41ODUyMzVdICBrdm1hbGxvY19ub2RlKzB4
NTQvMHgxYTAKWyAgIDQwLjU4NzQ1MV0gIHpzd2FwX3N3YXBvbisweDRhLzB4MjYwClsgICA0MC41
ODk2NTBdICBfX2RvX3N5c19zd2Fwb24rMHgxMmFkLzB4MWZjMApbICAgNDAuNTkyMTA5XSAgX194
NjRfc3lzX3N3YXBvbisweDVlLzB4NzAKWyAgIDQwLjU5NDQzNF0gIGRvX3N5c2NhbGxfNjQrMHg2
Yy8weDE1MApbICAgNDAuNTk2NjUyXSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NjMvMHg2YgpbICAgNDAuNTk5Njg1XQpbICAgNDAuNjAwNjg4XSBGcmVlZCBieSB0YXNrIDQwMDoK
WyAgIDQwLjYwMjYxMF0gIGthc2FuX3NhdmVfdHJhY2srMHgzMC8weDYwClsgICA0MC42MDQ5NDNd
ICBrYXNhbl9zYXZlX2ZyZWVfaW5mbysweDUyLzB4NjAKWyAgIDQwLjYwNzQ3Nl0gIHBvaXNvbl9z
bGFiX29iamVjdCsweDExYS8weDE5MApbICAgNDAuNjEwMDA2XSAgX19rYXNhbl9zbGFiX2ZyZWUr
MHgzOS8weDcwClsgICA0MC42MTIzNzVdICBrZnJlZSsweGYzLzB4MjgwClsgICA0MC42MTQyOTRd
ICBrdmZyZWUrMHgyOS8weDMwClsgICA0MC42MTYxMzZdICB6c3dhcF9zd2Fwb2ZmKzB4MTAzLzB4
MWEwClsgICA0MC42MTg0NTRdICBfX3NlX3N5c19zd2Fwb2ZmKzB4MTlkOC8weDIxZDAKWyAgIDQw
LjYyMDk5MF0gIF9feDY0X3N5c19zd2Fwb2ZmKzB4M2MvMHg0MApbICAgNDAuNjIzMzYxXSAgZG9f
c3lzY2FsbF82NCsweDZjLzB4MTUwClsgICA0MC42MjU2MDVdICBlbnRyeV9TWVNDQUxMXzY0X2Fm
dGVyX2h3ZnJhbWUrMHg2My8weDZiClsgICA0MC42Mjg2MjBdClsgICA0MC42Mjk2NDRdIFRoZSBi
dWdneSBhZGRyZXNzIGJlbG9uZ3MgdG8gdGhlIG9iamVjdCBhdCBmZmZmODg4MTAyNTJkYzgwClsg
ICA0MC42Mjk2NDRdICB3aGljaCBiZWxvbmdzIHRvIHRoZSBjYWNoZSBrbWFsbG9jLTY0IG9mIHNp
emUgNjQKWyAgIDQwLjYzNjgxM10gVGhlIGJ1Z2d5IGFkZHJlc3MgaXMgbG9jYXRlZCAyNCBieXRl
cyBpbnNpZGUgb2YKWyAgIDQwLjYzNjgxM10gIGZyZWVkIDY0LWJ5dGUgcmVnaW9uIFtmZmZmODg4
MTAyNTJkYzgwLCBmZmZmODg4MTAyNTJkY2MwKQpbICAgNDAuNjQzODU0XQpbICAgNDAuNjQ0ODcx
XSBUaGUgYnVnZ3kgYWRkcmVzcyBiZWxvbmdzIHRvIHRoZSBwaHlzaWNhbCBwYWdlOgpbICAgNDAu
NjQ4MTg3XSBwYWdlOjAwMDAwMDAwOTg1OTAzYjYgcmVmY291bnQ6MSBtYXBjb3VudDowIG1hcHBp
bmc6MDAwMDAwMDAwMDAwMDAwMCBpbmRleDoweDAgcGZuOjB4MTAyNTJkClsgICA0MC42NTM3MTNd
IGZsYWdzOiAweDQwMDAwMDAwMDAwMDgwMChzbGFifG5vZGU9MHx6b25lPTEpClsgICA0MC42NTY4
ODBdIHBhZ2VfdHlwZTogMHhmZmZmZmZmZigpClsgICA0MC42NTkwMzFdIHJhdzogMDQwMDAwMDAw
MDAwMDgwMCBmZmZmODg4MTAwMDQyNjQwIGRlYWQwMDAwMDAwMDAxMDAgZGVhZDAwMDAwMDAwMDEy
MgpbICAgNDAuNjYzNjM1XSByYXc6IDAwMDAwMDAwMDAwMDAwMDAgMDAwMDAwMDAwMDIwMDAyMCAw
MDAwMDAwMWZmZmZmZmZmIDAwMDAwMDAwMDAwMDAwMDAKWyAgIDQwLjY2ODIzNV0gcGFnZSBkdW1w
ZWQgYmVjYXVzZToga2FzYW46IGJhZCBhY2Nlc3MgZGV0ZWN0ZWQKWyAgIDQwLjY3MTU2NF0KWyAg
IDQwLjY3MjU2OV0gTWVtb3J5IHN0YXRlIGFyb3VuZCB0aGUgYnVnZ3kgYWRkcmVzczoKWyAgIDQw
LjY3NTQ2M10gIGZmZmY4ODgxMDI1MmRiODA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZjIGZjIGZj
IGZjIGZjIGZjIGZjIGZjIGZjClsgICA0MC42Nzk3NjZdICBmZmZmODg4MTAyNTJkYzAwOiAwMCAw
MCAwMCAwMCAwMCAwMCAwMCBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYwpbICAgNDAuNjg0MTIw
XSA+ZmZmZjg4ODEwMjUyZGM4MDogZmEgZmIgZmIgZmIgZmIgZmIgZmIgZmIgZmMgZmMgZmMgZmMg
ZmMgZmMgZmMgZmMKWyAgIDQwLjY4ODQyM10gICAgICAgICAgICAgICAgICAgICAgICAgICAgIF4K
WyAgIDQwLjY5MDg2MF0gIGZmZmY4ODgxMDI1MmRkMDA6IDAwIDAwIDAwIDAwIDAwIDAwIDAwIGZj
IGZjIGZjIGZjIGZjIGZjIGZjIGZjIGZjClsgICA0MC42OTUxMzZdICBmZmZmODg4MTAyNTJkZDgw
OiAwMCAwMCAwMCAwMCAwMCAwMCBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYyBmYwpbICAgNDAu
Njk5NDU1XSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT0KWyAgIDQwLjcwNDI1OF0gRGlzYWJsaW5nIGxvY2sgZGVidWdnaW5n
IGR1ZSB0byBrZXJuZWwgdGFpbnQK
--000000000000cc0d87060fab951c--

