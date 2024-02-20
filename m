Return-Path: <linux-kernel+bounces-72823-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0904085B904
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:28:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54943285D8F
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 10:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1FC60EF8;
	Tue, 20 Feb 2024 10:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="neV1pn/Q"
Received: from mail-vs1-f43.google.com (mail-vs1-f43.google.com [209.85.217.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96DA612C6;
	Tue, 20 Feb 2024 10:27:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708424832; cv=none; b=MjLr4pJdPa7mW4SKDra6Mymt1KKQ8AbOBmowEpkvyeg5qaGpAN+Fv4LQy7ohgbrX8Wq541dTrzZP23CPxp+unBKXtv5RGRlUTUIm9YUkVZnPV0bCQ6W6PIfex+KR1xNQDR3OwkNIQy9eSo1pROrIl8+7Q+C6NDtYsvxbEtbuZt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708424832; c=relaxed/simple;
	bh=3EueJ2zBmWvzfSaLZAnLQdxbaKULwjHWEYDSXiEtZq8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HMHv7B6SoF+tL5islB9UAIpGIeiVWxW/XqfjQ/wR0MOR7CU7xzhW3nednq6Yh9RPUIciFPeETgqOWWud145VKP5fM8S5s24jqGJ7Y89HYBRrc4ges98HPFSmk2GxtzSZESPr6iisWqLDoEgCbX9PQ66QsICJoTetQWQqwKf7+ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=neV1pn/Q; arc=none smtp.client-ip=209.85.217.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f43.google.com with SMTP id ada2fe7eead31-47047e7b068so203334137.2;
        Tue, 20 Feb 2024 02:27:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708424830; x=1709029630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EZn98CE/Oe+cVNVy+tmJNozH4/KB14kaXBjDwNFXGpA=;
        b=neV1pn/QI8BxFqSWmJ5SNNXZ28duUraTNNZ8+TIBN7LS/hpu+Z0V8UvAA8CV4wCQhc
         gWPRLCW6lMY1UYlyvhpIbVOQL5CwaKdwZ+RiER+bY778HWyP6icw0JzwrhGQlui0Jdih
         I4LTdzaxzdmbVKPLc2W5fBXnJUwLHkg/DIGPPKTxUjvPiQj0Wn9ve00+pgA/ZdMqYn/I
         vZhKJw4OOP4Sx8drExb56MG6Yfp2eWa04rpMHXkln4N3Uaom8TGkssJx+/8XKHSQzmfy
         MZPB+m814jmvY0dE+hv5Tr2KAr2fvm/lKFs6cyDvuPiJxnfaKNmfGhSoeaAPWoHYzdCm
         UsAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708424830; x=1709029630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EZn98CE/Oe+cVNVy+tmJNozH4/KB14kaXBjDwNFXGpA=;
        b=aW/0f1sdQ4OXvckQBIa5wU9WdZiDS3rHB041yRl5hRQ/0vl4aDFNW7lV+rY2RCp1/S
         1ulBouL3FuWRhmpPEenuCXTV4gXG83lFOHH7i9Nj+wxr4Ij/3dfYmMTrFVsxK0KyLrXv
         OC7YkCprzV2KSzNk/9F7KK1opZxCAWPns18zWDDc50fleJ0RM/q1JNTXnAQs1RNtSlfR
         2abEOu31QDViIEnuv0Nc99YMGAdpIULlpGP3YNJhVbYkBARMEy8Pgh2s82tAZR+6XY+Z
         MzQcUVKfDYloBsegcnrK3tY0mVBzDcRdpWbY9OutF7zVNmCyigHH242QXNSBBBV1hJWK
         W7Xg==
X-Forwarded-Encrypted: i=1; AJvYcCU6kEt82wE4MvP0M+SQRaddtOcDaPizc+saJFrc21Y98NwkZA/tkEkZfcu4pQTmicOdG0MhNh0DWaO5blr/muJc6tgjGU8qisLU2dUesSjIEcKstXZ+AY0zgLbvWdoypboULf+/
X-Gm-Message-State: AOJu0YwsZ9J3bSD1uFHVCPOBkFpgFkps+qGB07XS8a8/CS9DRmXUDiBY
	3JzhGOpcYuRgkRfR0MFiVYUvS0QK7onkmJLM/MUkAj9zRGde0f/FESwOJkeZNq4v5ga7502kD4I
	GFo1vfK2VYSvkcZE80C2so3XWjkY=
X-Google-Smtp-Source: AGHT+IE8IvKXeZAJNP8t3fFfQv7tnDCcvxm21TuRtRSHVBB6O9q7Kr4DiLzNMEangcb7uxvQPiWUzBnzRCH6HIjJnys=
X-Received: by 2002:a05:6102:3189:b0:470:5080:451 with SMTP id
 c9-20020a056102318900b0047050800451mr3585185vsh.16.1708424829609; Tue, 20 Feb
 2024 02:27:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240219082040.7495-1-ryncsn@gmail.com> <20240219173147.3f4b50b7c9ae554008f50b66@linux-foundation.org>
 <CAMgjq7DgBOJhDJStwGuD+C6-FNYZBp-cu6M_HAgRry3gBSf7GA@mail.gmail.com>
 <CAGsJ_4zyf5OOq_WA7VjsDKp1ciaDwzM23Ef95_O-24oLtr_5AQ@mail.gmail.com> <CAMgjq7AnZJSseC2BB_nF+s533YybyP_WU8HijEKFA=OXE1x41Q@mail.gmail.com>
In-Reply-To: <CAMgjq7AnZJSseC2BB_nF+s533YybyP_WU8HijEKFA=OXE1x41Q@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 20 Feb 2024 23:26:57 +1300
Message-ID: <CAGsJ_4xEM5od8Ebs4Kaejqw6DU8cu=YX+mfXejLoTuDySxjTOA@mail.gmail.com>
Subject: Re: [PATCH v4] mm/swap: fix race when skipping swapcache
To: Kairui Song <ryncsn@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	"Huang, Ying" <ying.huang@intel.com>, Chris Li <chrisl@kernel.org>, 
	Minchan Kim <minchan@kernel.org>, Barry Song <v-songbaohua@oppo.com>, Yu Zhao <yuzhao@google.com>, 
	SeongJae Park <sj@kernel.org>, David Hildenbrand <david@redhat.com>, Hugh Dickins <hughd@google.com>, 
	Johannes Weiner <hannes@cmpxchg.org>, Matthew Wilcox <willy@infradead.org>, Michal Hocko <mhocko@suse.com>, 
	Yosry Ahmed <yosryahmed@google.com>, Aaron Lu <aaron.lu@intel.com>, stable@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 5:56=E2=80=AFPM Kairui Song <ryncsn@gmail.com> wrot=
e:
>
> On Tue, Feb 20, 2024 at 12:01=E2=80=AFPM Barry Song <21cnbao@gmail.com> w=
rote:
> >
> > On Tue, Feb 20, 2024 at 4:42=E2=80=AFPM Kairui Song <ryncsn@gmail.com> =
wrote:
> > >
> > > On Tue, Feb 20, 2024 at 9:31=E2=80=AFAM Andrew Morton <akpm@linux-fou=
ndation.org> wrote:
> > > >
> > > > On Mon, 19 Feb 2024 16:20:40 +0800 Kairui Song <ryncsn@gmail.com> w=
rote:
> > > >
> > > > > From: Kairui Song <kasong@tencent.com>
> > > > >
> > > > > When skipping swapcache for SWP_SYNCHRONOUS_IO, if two or more th=
reads
> > > > > swapin the same entry at the same time, they get different pages =
(A, B).
> > > > > Before one thread (T0) finishes the swapin and installs page (A)
> > > > > to the PTE, another thread (T1) could finish swapin of page (B),
> > > > > swap_free the entry, then swap out the possibly modified page
> > > > > reusing the same entry. It breaks the pte_same check in (T0) beca=
use
> > > > > PTE value is unchanged, causing ABA problem. Thread (T0) will
> > > > > install a stalled page (A) into the PTE and cause data corruption=
.
> > > > >
> > > > > @@ -3867,6 +3868,20 @@ vm_fault_t do_swap_page(struct vm_fault *v=
mf)
> > > > >       if (!folio) {
> > > > >               if (data_race(si->flags & SWP_SYNCHRONOUS_IO) &&
> > > > >                   __swap_count(entry) =3D=3D 1) {
> > > > > +                     /*
> > > > > +                      * Prevent parallel swapin from proceeding =
with
> > > > > +                      * the cache flag. Otherwise, another threa=
d may
> > > > > +                      * finish swapin first, free the entry, and=
 swapout
> > > > > +                      * reusing the same entry. It's undetectabl=
e as
> > > > > +                      * pte_same() returns true due to entry reu=
se.
> > > > > +                      */
> > > > > +                     if (swapcache_prepare(entry)) {
> > > > > +                             /* Relax a bit to prevent rapid rep=
eated page faults */
> > > > > +                             schedule_timeout_uninterruptible(1)=
;
> > > >
> > > > Well this is unpleasant.  How often can we expect this to occur?
> > > >
> > >
> > > The chance is very low, using the current mainline kernel and ZRAM,
> > > even with threads set to race on purpose using the reproducer I
> > > provides, for 647132 page faults it occured 1528 times (~0.2%).
> > >
> > > If I run MySQL and sysbench with 128 threads and 16G buffer pool, wit=
h
> > > 6G cgroup limit and 32G ZRAM, it occured 1372 times for 40 min,
> > > 109930201 page faults in total (~0.001%).
> >
>
> Hi Barry,
>
> > it might not be a problem for throughput. but for real-time and tail la=
tency,
> > this hurts. For example, this might increase dropping frames of UI whic=
h
> > is an important parameter to evaluate performance :-)
> >
>

Hi Kairui,

> That's a true issue, as Chris mentioned before I think we need to
> think of some clever data struct to solve this more naturally in the
> future, similar issue exists for cached swapin as well and it has been
> there for a while. On the other hand I think maybe applications that
> are extremely latency sensitive should try to avoid swap on fault? A
> swapin could cause other issues like reclaim, throttled or contention
> with many other things, these seem to have a higher chance than this
> race.

ideally, if memory is very very large, we can avoid swap or mlock a
lot of things. In Android phones, most anon memory is actually in
swap as a system with limited memory.
For example, users might switch between a couple of applications.
some cold app could be entirely swapped. but those applications
can be re-activated by users all of a sudden.
We do mlock some limited memories. but we don't abuse mlock()
everywhere :-)
For a soft-real time system, a lot of other optimization is involved
to make sure RT/UI tasks can get priority on getting locks, memory
etc.
Overall we live together with swap but still try our best to make
important tasks have low latency.

The current patch, to me, seems to add a new place which makes
high priority tasks have no way to be done faster. But I do understand
the percentage is not high. And I have no doubt you have done your
best work on this.

I'm just curious if the number will increase a lot of times for large folio=
s
swap-in as the conflicting memory range is enlarged. and also its
impact on UI and RT tasks.

Thus, I have followed up your work and made it support large folios
swap-in[1] as below. I will get phones to run it and update you with
the result after a couple of days(could be 3-4 weeks later).

Subject: [PATCH] mm: swap: introduce swapcache_prepare_nr and
 swapcache_clear_nr for large folios swap-in

Apply Kairui's work on large folios swap-in

Signed-off-by: Barry Song <v-songbaohua@oppo.com>
---

diff --git a/include/linux/swap.h b/include/linux/swap.h
index a293ef17c2b6..f1cf64c9ccb5 100644
--- a/include/linux/swap.h
+++ b/include/linux/swap.h
@@ -483,6 +483,7 @@ extern int add_swap_count_continuation(swp_entry_t, gfp=
_t);
 extern void swap_shmem_alloc(swp_entry_t);
 extern int swap_duplicate(swp_entry_t);
 extern int swapcache_prepare(swp_entry_t);
+extern int swapcache_prepare_nr(swp_entry_t, int nr);
 extern void swap_free(swp_entry_t);
 extern void swap_nr_free(swp_entry_t entry, int nr_pages);
 extern void swapcache_free_entries(swp_entry_t *entries, int n);
diff --git a/mm/memory.c b/mm/memory.c
index 2d27c087a39e..9cfd806a8236 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3905,7 +3905,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
                                 * reusing the same entry. It's undetectabl=
e as
                                 * pte_same() returns true due to entry reu=
se.
                                 */
-                               if (swapcache_prepare(entry)) {
+                               if (swapcache_prepare_nr(entry, nr_pages)) =
{
                                        /* Relax a bit to prevent
rapid repeated page faults */
                                        schedule_timeout_uninterruptible(1)=
;
                                        goto out;
@@ -4194,7 +4194,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 out:
        /* Clear the swap cache pin for direct swapin after PTL unlock */
        if (need_clear_cache)
-               swapcache_clear(si, entry);
+               swapcache_clear_nr(si, entry, nr_pages);
        if (si)
                put_swap_device(si);
        return ret;
@@ -4210,7 +4210,7 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
                folio_put(swapcache);
        }
        if (need_clear_cache)
-               swapcache_clear(si, entry);
+               swapcache_clear_nr(si, entry, nr_pages);
        if (si)
                put_swap_device(si);
        return ret;
diff --git a/mm/swap.h b/mm/swap.h
index 693d1b281559..a457496bd669 100644
--- a/mm/swap.h
+++ b/mm/swap.h
@@ -39,6 +39,7 @@ void delete_from_swap_cache(struct folio *folio);
 void clear_shadow_from_swap_cache(int type, unsigned long begin,
                                  unsigned long end);
 void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry);
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t
entry, int nr);
 struct folio *swap_cache_get_folio(swp_entry_t entry,
                struct vm_area_struct *vma, unsigned long addr);
 struct folio *filemap_get_incore_folio(struct address_space *mapping,
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 6ecee63cf678..8c9d53f9f068 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -3322,65 +3322,76 @@ void si_swapinfo(struct sysinfo *val)
  * - swap-cache reference is requested but the entry is not used. -> ENOEN=
T
  * - swap-mapped reference requested but needs continued swap count. -> EN=
OMEM
  */
-static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+
+static int __swap_duplicate_nr(swp_entry_t entry, int nr, unsigned char us=
age)
 {
        struct swap_info_struct *p;
        struct swap_cluster_info *ci;
        unsigned long offset;
-       unsigned char count;
-       unsigned char has_cache;
-       int err;
+       unsigned char count[SWAPFILE_CLUSTER];
+       unsigned char has_cache[SWAPFILE_CLUSTER];
+       int err, i;

        p =3D swp_swap_info(entry);

        offset =3D swp_offset(entry);
        ci =3D lock_cluster_or_swap_info(p, offset);

-       count =3D p->swap_map[offset];
+       for (i =3D 0; i < nr; i++) {
+               count[i] =3D p->swap_map[offset + i];

-       /*
-        * swapin_readahead() doesn't check if a swap entry is valid, so th=
e
-        * swap entry could be SWAP_MAP_BAD. Check here with lock held.
-        */
-       if (unlikely(swap_count(count) =3D=3D SWAP_MAP_BAD)) {
-               err =3D -ENOENT;
-               goto unlock_out;
+               /*
+                * swapin_readahead() doesn't check if a swap entry is
valid, so the
+                * swap entry could be SWAP_MAP_BAD. Check here with lock h=
eld.
+                */
+               if (unlikely(swap_count(count[i]) =3D=3D SWAP_MAP_BAD)) {
+                       err =3D -ENOENT;
+                       goto unlock_out;
+               }
+
+               has_cache[i] =3D count[i] & SWAP_HAS_CACHE;
+               count[i] &=3D ~SWAP_HAS_CACHE;
+               err =3D 0;
+
+               if (usage =3D=3D SWAP_HAS_CACHE) {
+
+                       /* set SWAP_HAS_CACHE if there is no cache and
entry is used */
+                       if (!has_cache[i] && count[i])
+                               has_cache[i] =3D SWAP_HAS_CACHE;
+                       else if (has_cache[i])          /* someone
else added cache */
+                               err =3D -EEXIST;
+                       else                            /* no users remaini=
ng */
+                               err =3D -ENOENT;
+               } else if (count[i] || has_cache[i]) {
+
+                       if ((count[i] & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
+                               count[i] +=3D usage;
+                       else if ((count[i] & ~COUNT_CONTINUED) > SWAP_MAP_M=
AX)
+                               err =3D -EINVAL;
+                       else if (swap_count_continued(p, offset + i, count[=
i]))
+                               count[i] =3D COUNT_CONTINUED;
+                       else
+                               err =3D -ENOMEM;
+               } else
+                       err =3D -ENOENT;                  /* unused swap en=
try */
+
+               if (err)
+                       goto unlock_out;
        }

-       has_cache =3D count & SWAP_HAS_CACHE;
-       count &=3D ~SWAP_HAS_CACHE;
-       err =3D 0;
-
-       if (usage =3D=3D SWAP_HAS_CACHE) {
-
-               /* set SWAP_HAS_CACHE if there is no cache and entry is use=
d */
-               if (!has_cache && count)
-                       has_cache =3D SWAP_HAS_CACHE;
-               else if (has_cache)             /* someone else added cache=
 */
-                       err =3D -EEXIST;
-               else                            /* no users remaining */
-                       err =3D -ENOENT;
-
-       } else if (count || has_cache) {
-
-               if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-                       count +=3D usage;
-               else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-                       err =3D -EINVAL;
-               else if (swap_count_continued(p, offset, count))
-                       count =3D COUNT_CONTINUED;
-               else
-                       err =3D -ENOMEM;
-       } else
-               err =3D -ENOENT;                  /* unused swap entry */
-
-       WRITE_ONCE(p->swap_map[offset], count | has_cache);
-
+       for (i =3D 0; i < nr; i++)
+               WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]=
);
 unlock_out:
        unlock_cluster_or_swap_info(p, ci);
        return err;
 }

+
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+{
+       return __swap_duplicate_nr(entry, 1, usage);
+}
+
 /*
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
@@ -3419,17 +3430,33 @@ int swapcache_prepare(swp_entry_t entry)
        return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }

-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+int swapcache_prepare_nr(swp_entry_t entry, int nr)
+{
+       return __swap_duplicate_nr(entry, nr, SWAP_HAS_CACHE);
+}
+
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, in=
t nr)
 {
        struct swap_cluster_info *ci;
        unsigned long offset =3D swp_offset(entry);
-       unsigned char usage;
+       unsigned char usage[SWAPFILE_CLUSTER];
+       int i;

        ci =3D lock_cluster_or_swap_info(si, offset);
-       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+       for (i =3D 0; i < nr; i++)
+               usage[i] =3D __swap_entry_free_locked(si, offset + i,
SWAP_HAS_CACHE);
        unlock_cluster_or_swap_info(si, ci);
-       if (!usage)
-               free_swap_slot(entry);
+       for (i =3D 0; i < nr; i++) {
+               if (!usage[i]) {
+                       free_swap_slot(entry);
+                       entry.val++;
+               }
-
-       if (usage =3D=3D SWAP_HAS_CACHE) {
-
-               /* set SWAP_HAS_CACHE if there is no cache and entry is use=
d */
-               if (!has_cache && count)
-                       has_cache =3D SWAP_HAS_CACHE;
-               else if (has_cache)             /* someone else added cache=
 */
-                       err =3D -EEXIST;
-               else                            /* no users remaining */
-                       err =3D -ENOENT;
-
-       } else if (count || has_cache) {
-
-               if ((count & ~COUNT_CONTINUED) < SWAP_MAP_MAX)
-                       count +=3D usage;
-               else if ((count & ~COUNT_CONTINUED) > SWAP_MAP_MAX)
-                       err =3D -EINVAL;
-               else if (swap_count_continued(p, offset, count))
-                       count =3D COUNT_CONTINUED;
-               else
-                       err =3D -ENOMEM;
-       } else
-               err =3D -ENOENT;                  /* unused swap entry */
-
-       WRITE_ONCE(p->swap_map[offset], count | has_cache);
-
+       for (i =3D 0; i < nr; i++)
+               WRITE_ONCE(p->swap_map[offset + i], count[i] | has_cache[i]=
);
 unlock_out:
        unlock_cluster_or_swap_info(p, ci);
        return err;
 }

+
+static int __swap_duplicate(swp_entry_t entry, unsigned char usage)
+{
+       return __swap_duplicate_nr(entry, 1, usage);
+}
+
 /*
  * Help swapoff by noting that swap entry belongs to shmem/tmpfs
  * (in which case its reference count is never incremented).
@@ -3419,17 +3430,33 @@ int swapcache_prepare(swp_entry_t entry)
        return __swap_duplicate(entry, SWAP_HAS_CACHE);
 }

-void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+int swapcache_prepare_nr(swp_entry_t entry, int nr)
+{
+       return __swap_duplicate_nr(entry, nr, SWAP_HAS_CACHE);
+}
+
+void swapcache_clear_nr(struct swap_info_struct *si, swp_entry_t entry, in=
t nr)
 {
        struct swap_cluster_info *ci;
        unsigned long offset =3D swp_offset(entry);
-       unsigned char usage;
+       unsigned char usage[SWAPFILE_CLUSTER];
+       int i;

        ci =3D lock_cluster_or_swap_info(si, offset);
-       usage =3D __swap_entry_free_locked(si, offset, SWAP_HAS_CACHE);
+       for (i =3D 0; i < nr; i++)
+               usage[i] =3D __swap_entry_free_locked(si, offset + i,
SWAP_HAS_CACHE);
        unlock_cluster_or_swap_info(si, ci);
-       if (!usage)
-               free_swap_slot(entry);
+       for (i =3D 0; i < nr; i++) {
+               if (!usage[i]) {
+                       free_swap_slot(entry);
+                       entry.val++;
+               }
+       }
+}
+
+void swapcache_clear(struct swap_info_struct *si, swp_entry_t entry)
+{
+       swapcache_clear_nr(si, entry, 1);
 }

 struct swap_info_struct *swp_swap_info(swp_entry_t entry)

[1] https://lore.kernel.org/linux-mm/20240118111036.72641-1-21cnbao@gmail.c=
om/

>
> > BTW, I wonder if ying's previous proposal - moving swapcache_prepare()
> > after swap_read_folio() will further help decrease the number?
>
> We can move the swapcache_prepare after folio alloc or cgroup charge,
> but I didn't see an observable change from statistics, for some
> workload the reading is even worse. I think that's mostly due to
> noise, or higher swap out rate since all raced threads will alloc an
> extra folio now. Applications that have many pages swapped out due to
> memory limit are already on the edge of triggering another reclaim, so
> a dozen more folio alloc could just trigger that...

sometimes. might not be edged because of this app, but because users
launch another app as foreground and this one becomes background.

>
> And we can't move it after swap_read_folio()... That's exactly what we
> want to protect.

understood, thanks!

Barry

