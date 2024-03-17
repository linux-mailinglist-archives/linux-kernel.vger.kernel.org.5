Return-Path: <linux-kernel+bounces-105332-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB19887DC60
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 06:48:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C7B01F212A7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 05:48:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087E6FC1D;
	Sun, 17 Mar 2024 05:47:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nAwqDRa3"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B5A7EADB
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 05:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710654477; cv=none; b=QE96pz49+w/dJdIveHZKjGwJxrS2qQZWNOaYbEppLSfvZM/5xzAa89czKaIdvNr1t4ur8xIJZJSF5KzW6hdbLSQKSURtStWF/hbkjcb0PlvCxHPnAs3+B1idZccVEYwQFqgIg/WHf/Fi+qSK//teZThpVRnCu6WPOX1fy2zg1Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710654477; c=relaxed/simple;
	bh=jCwVDtdjVLnS0p3Xc6iBZtal0EfLjsLMmpXpfH0mMsM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lV3XkG4SmDZm0dawZoepMtBrkbsNBlaQ/z3T+zjhc61xYebbXCezeYRYqWLssgeFS5zuNL3q0myHMluJ405FoozxyFfh0nNNTFWQMHHnvaZBrWaq9VpNlFdi+JJ/B9FPVLkQnteq47WaTyIN3ifEUgqQ7AKkZkMehLYW3LYfXVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nAwqDRa3; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-430a7497700so19461431cf.1
        for <linux-kernel@vger.kernel.org>; Sat, 16 Mar 2024 22:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710654473; x=1711259273; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjI0CmTAb9rBKNzvuDpGMzLCdPan9spH7TYPxSq//7M=;
        b=nAwqDRa3puEPiy0oBNzbwFWk2ldxQjQ/00bor3NpZ7sUtZmY0Rad15Y5bUQyfubgwH
         uvL90mlAafGA3EQU2dshWLuPsQuDyyzJch0rv/peHd0PgDPHFpDf2RWJO6E5JyeNvdzX
         +If5ALBHLGLeckmfPC1xTs9qn59A2aHR1R8fcvWm757tGMrQSX9JBqY0D5mszbs1yroW
         mTgR2U8sOt62GiljMe1KH7tgQvEqPnnaoP87hrqEXVllQMHKpr7Vb0PojRw2vCh+3o6k
         DcxmU4UdHNrtlC4ktdIFLSrsTa0Wn2PMMCa0juhJxKD4FKJIYqlQc4vE0YqMt+bD7pTJ
         Z8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710654473; x=1711259273;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjI0CmTAb9rBKNzvuDpGMzLCdPan9spH7TYPxSq//7M=;
        b=cHBKc4a3Jg7joz/1/l3yovyNHVhp++bCexrhc+7DRWe/zOmDUzu+Gr52PRhcr4g+G+
         dVwoxaQ7+rsu2P3cV1DJ/6KvWTT3OlBWBwH5JxWZhXbSvUNjSy6DYW4IjcQMw5/tg6OS
         SBD4QAPLbq5/Z1eAC4iaGbyuZ7mb6TajRKM3cbRKZJNfwbjKEKzDSIPRxuK43M+6xzNg
         5y9+oOu//FI2/dlS26m9epvN5fR4lfHvFLY+gQFfu/uaYy4zuegz73ODzdf5xspEUflL
         E4Dp5F36g+h2O6/kEG5AID8Yz9IDelRXuyfSIChx6JcQORXHAtCuhL4+vPf+zsDIQWIa
         4oqg==
X-Forwarded-Encrypted: i=1; AJvYcCXczNwmAZLRCAuYfSFnQTX+Pb7g1naq7ebQAzqqEilY1+vmeySwcx9WCGxn37QKcin1vv+Mrike7udwr8cSK9GNJ5lS4FVfNetu/1IT
X-Gm-Message-State: AOJu0Yxp75ijOrgV4mfdSdabyKJKB4CJ9wcJodfftLsG8aMV6yegsI1B
	xWNLJrk7RmTxstPP+CC8bFSbJj+F//LegJbYUX0dUa5JZh8XI9sojeh4pK0UVfJhX1vElOnQURr
	LW08qLRW8MTzUlSzHNNfziUOcYq3ELfNXoyU=
X-Google-Smtp-Source: AGHT+IF3n6ILrbIcqyw7Dk9ldN+JFXuDe2uBcHpys1fbj9TlKl6rn+Ktc0cERNyAszqG9dMbRhcxpRA2dK4IuomqNow=
X-Received: by 2002:a05:622a:1cf:b0:42e:eb29:91ba with SMTP id
 t15-20020a05622a01cf00b0042eeb2991bamr11260429qtw.63.1710654473492; Sat, 16
 Mar 2024 22:47:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314141516.31747-1-liuhailong@oppo.com> <20240315081803.2223-1-liuhailong@oppo.com>
 <CAGsJ_4yMXE_4YuMTczF6u4YYp_TWksi+byszD09E2PT5pK8zfA@mail.gmail.com> <ba894762-d3ea-4773-b54c-ce063e1065e5@oppo.com>
In-Reply-To: <ba894762-d3ea-4773-b54c-ce063e1065e5@oppo.com>
From: Barry Song <21cnbao@gmail.com>
Date: Sun, 17 Mar 2024 18:47:42 +1300
Message-ID: <CAGsJ_4wD-NiquhnhK_6TGEF4reTGO9pVNGyYBnYZ1inVFc40WQ@mail.gmail.com>
Subject: Re: [PATCH v2] Revert "mm: skip CMA pages when they are not available"
To: =?UTF-8?B?5YiY5rW36b6ZKExhb0xpdSk=?= <liuhailong@oppo.com>
Cc: "akpm@linux-foundation.org" <akpm@linux-foundation.org>, "nathan@kernel.org" <nathan@kernel.org>, 
	"ndesaulniers@google.com" <ndesaulniers@google.com>, "trix@redhat.com" <trix@redhat.com>, 
	"linux-mm@kvack.org" <linux-mm@kvack.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"llvm@lists.linux.dev" <llvm@lists.linux.dev>, "surenb@google.com" <surenb@google.com>, 
	"zhaoyang.huang@unisoc.com" <zhaoyang.huang@unisoc.com>, 
	"quic_charante@quicinc.com" <quic_charante@quicinc.com>, "yuzhao@google.com" <yuzhao@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 15, 2024 at 11:44=E2=80=AFPM =E5=88=98=E6=B5=B7=E9=BE=99(LaoLiu=
) <liuhailong@oppo.com> wrote:
>
> On 2024/3/15 16:46, Barry Song wrote:
> > On Fri, Mar 15, 2024 at 9:18=E2=80=AFPM <liuhailong@oppo.com> wrote:
> >>
> >> From: "Hailong.Liu" <liuhailong@oppo.com>
> >>
> >> This reverts
> >> commit b7108d66318a ("Multi-gen LRU: skip CMA pages when they are not =
eligible")
> >> commit 5da226dbfce3 ("mm: skip CMA pages when they are not available")
> >
> > Reverting these changes seems inappropriate since the original patches
> > did improve most cases.
> > While doing direct reclamation without MOVABLE flags, scanning cma
> > folio doesn't help at all.
> >
>
> Absolutely, but without this patch  it give chance to reclaim cma pages t=
o freelist,
> other tasks without this flag would work normally without holding too muc=
h time
> on lru lock and lru size decrease=E3=80=82 it also trigger memory psi eve=
nt to allow
> admin do something to release memory.
>
> >>
> >> skip_cma may cause system not responding. if cma pages is large in lru=
_list
> >> and system is in lowmemory, many tasks would direct reclaim and waste
> >> cpu time to isolate_lru_pages and return.
> >>
> >> Test this patch on android-5.15 8G device
> >> reproducer:
> >> - cma_declare_contiguous 3G pages
> >> - set /proc/sys/vm/swappiness 0 to enable direct_reclaim reclaim file
> >>   only.
> >> - run a memleak process in userspace
> >
> >
> > I assume that scanning cma folio provides additional opportunities to r=
eclaim
> > anonymous memory, even though it is ineffective for allocating NON-MOVA=
BLE
> > folios. Consequently, we alleviate pressure for future allocations of a=
nonymous
> > folios. Moreover, setting swappiness=3D0 is a rare scenario. Instead of=
 entirely
> > removing the mechanism, could we detect such corner cases and handle th=
em
> > differently.
> >
> > Otherwise, I don't see any chance of this being acknowledged.
>
> It happens in internal aging test. open camera and record 8K video which =
use
> more than 2Gib dmabuf pages. without this patch the devices would kill ca=
mera process,
> but the system hang with it.
>
> In fact, in my opinion the issue of this patch increase the scanning lru =
time
> and reclaim nothing. Do you have a better solution ?

rather than aggressively reverting the original patch which might help lots=
 of
cases, could we just detect the corner cases and fix them , for example, by
something as the belows,

diff --git a/mm/vmscan.c b/mm/vmscan.c
index 96147c4536e4..2f75ad9870c1 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -147,6 +147,9 @@ struct scan_control {
        /* Always discard instead of demoting to lower tier memory */
        unsigned int no_demotion:1;

+       /* no skipping cma */
+       unsigned int no_skip_cma:1;
+
        /* Allocation order */
        s8 order;

@@ -1595,7 +1598,7 @@ static __always_inline void
update_lru_sizes(struct lruvec *lruvec,
  */
 static bool skip_cma(struct folio *folio, struct scan_control *sc)
 {
-       return !current_is_kswapd() &&
+       return !current_is_kswapd() && !sc->no_skip_cma &&
                        gfp_migratetype(sc->gfp_mask) !=3D MIGRATE_MOVABLE =
&&
                        folio_migratetype(folio) =3D=3D MIGRATE_CMA;
 }
@@ -1636,7 +1639,7 @@ static unsigned long isolate_lru_folios(unsigned
long nr_to_scan,
        unsigned long nr_taken =3D 0;
        unsigned long nr_zone_taken[MAX_NR_ZONES] =3D { 0 };
        unsigned long nr_skipped[MAX_NR_ZONES] =3D { 0, };
-       unsigned long skipped =3D 0;
+       unsigned long skipped =3D 0, skipped_cma =3D 0;
        unsigned long scan, total_scan, nr_pages;
        LIST_HEAD(folios_skipped);

@@ -1645,6 +1648,7 @@ static unsigned long isolate_lru_folios(unsigned
long nr_to_scan,
        while (scan < nr_to_scan && !list_empty(src)) {
                struct list_head *move_to =3D src;
                struct folio *folio;
+               bool cma =3D false;

                folio =3D lru_to_folio(src);
                prefetchw_prev_lru_folio(folio, src, flags);
@@ -1652,10 +1656,11 @@ static unsigned long
isolate_lru_folios(unsigned long nr_to_scan,
                nr_pages =3D folio_nr_pages(folio);
                total_scan +=3D nr_pages;

-               if (folio_zonenum(folio) > sc->reclaim_idx ||
-                               skip_cma(folio, sc)) {
+               cma =3D skip_cma(folio, sc);
+               if (folio_zonenum(folio) > sc->reclaim_idx || cma) {
                        nr_skipped[folio_zonenum(folio)] +=3D nr_pages;
                        move_to =3D &folios_skipped;
+                       skipped_cma +=3D nr_pages;
                        goto move;
                }

@@ -1716,6 +1721,16 @@ static unsigned long
isolate_lru_folios(unsigned long nr_to_scan,
        *nr_scanned =3D total_scan;
        trace_mm_vmscan_lru_isolate(sc->reclaim_idx, sc->order, nr_to_scan,
                                    total_scan, skipped, nr_taken, lru);
+
+       /*
+        * If the majority of folios are skipped due to contiguous
memory allocator (CMA),
+        * the least recently used (LRU) list might become overloaded
with CMA folios.
+        * This could result in numerous idle loops for non-movable
allocations. On the
+        * other hand, reclaiming CMA folios can alleviate the strain
on other processes
+        * that require anonymous pages.
+        */
+       sc->no_skip_cma =3D skipped_cma > total_scan / 2 ? 1 : 0;
+
        update_lru_sizes(lruvec, lru, nr_zone_taken);
        return nr_taken;
 }


This is merely a proof of concept (PoC), and I haven't even built it
yet. Additionally, LRU_GEN remains
unchanged. It will also need similar changes.

>
> Brs,
> Hailong.

Thanks
Barry

