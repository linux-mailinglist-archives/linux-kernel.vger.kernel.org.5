Return-Path: <linux-kernel+bounces-30449-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A8C11831ED5
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 18:58:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 61298282916
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 17:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD5262D632;
	Thu, 18 Jan 2024 17:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="LIBCzbNy"
Received: from mail-yb1-f173.google.com (mail-yb1-f173.google.com [209.85.219.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 257D02D608
	for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 17:58:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705600719; cv=none; b=VYrN0PqDNjadr818G7xmWTx7K0H1B8tSCJXqCuehXafGb2+wtEDmDlooWQB5TFVDgyTLGvxegZ4As6p8GnX8q/Qn+WF2aQHB94gbeyML2aAzq+DzIGgmf81lBEri5JNPkZ9Fq+JDvimoQ6tzzIAetGNiAIjAE4AKlImIpIcY2X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705600719; c=relaxed/simple;
	bh=ZcYMvcsQH6MHqA1+N4qCacongVgwJYYPcw4IYjAOuHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dPrlEMCkRURw9w5j3ESdsJ8KHo4EeW0UcfIl/JIGMbYlVl4C6MNLA4bVDVM5TAwyPkjO8ExuAq2VrqF4vG6NMIdJbzVv5tP5gEhz9nuKNJAhQYHiLGWFlAZgBa1/ulRMNk9bv7ZCCuuwJ2hR9HmD0JAhmqei5lYbYs3vaj62kwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=LIBCzbNy; arc=none smtp.client-ip=209.85.219.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f173.google.com with SMTP id 3f1490d57ef6-dae7cc31151so9708397276.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jan 2024 09:58:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705600716; x=1706205516; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I3U0OrNpJfRDyrApMuNVXpFFbNS8QwOQtWJeZb9DDFc=;
        b=LIBCzbNyPjlZGc6yoBJrVBJ5zE84lb7MPqEYlj8ZJctEbvZqhGag33BHf1o+YM7732
         HpjDZISqiZ58tJW0gNHCQOyJZQVp0HKHqVRDkdRAZ2CZGQEHepSbb1s1TGu95k0bkkk9
         FX+3Exicn9+c7MFjhlJeSFKsgOf+27SQIB8eqaz1q1GJ1zk8fluh4BVcH2Pqi8MiGvmx
         GysTipOQ6o7H0ouUZEvS8Ix/69PsdbWZBK4f3fn9WXUmOYgckaaKz5eoOqeP1zeqnH2D
         k9XrN1yd2eeggSCN5Nn6GQRlwjB2izaipniwRlrzlSVNPeldp8FMGqs2NYGDHdA0Z87n
         BTOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705600716; x=1706205516;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I3U0OrNpJfRDyrApMuNVXpFFbNS8QwOQtWJeZb9DDFc=;
        b=wpsiOpQ5GlS3g6k/XIpMe2qt813cc2gfw6z9VcW5i7IRgy6427E7A0ZbDglqXndgvw
         ZCunx0akDwzFq2bylhXwfcKRk/kWjGiNGbwK4y1jO/sqMgz+T91sE+t6uUXRKIH9sWDv
         btLvvz40uctBcCQnwWu1jHcVF5hpKeQVoSOLnO9nx44V2aZ6lZDshZE3b5HxlW1cyX/z
         s9SpM04sVVFzcQSy/ey2dm6670mTc+RHDHhPj0tsv7IMsw1USkTNsGTUOUnRnEqdCyzY
         VFnQD1rpMxBeve9vLRsfMR/yapxP/SOgOFLhbS8GwJnQmTszzSLONN28ZhpfZyGQoBnJ
         pnwA==
X-Gm-Message-State: AOJu0Yy6cLVmqqSHo9Hoy7qxOmY+0mky0zViWlkgMWvGdPIeFfRTAw2B
	ZNMpHiTk6qXNCcmxhrH29kGznvH7LElmTKZhel/hjN0SKS/5XW/m9iJ35e3q68iKpSdNhxBhcRn
	F5hGLq93aSx5hcFwRy1z1AzVAGRAMhZ/ACiYX
X-Google-Smtp-Source: AGHT+IFBb14PleCUhidhSqngFu/RoI/xHs3X/Gt/g6JHIitV1JJwjxG8/fbU8sM06GYMAvGzbxG9GrAGkxH7C5sGq7E=
X-Received: by 2002:a05:6902:89:b0:dbe:a3b0:6e37 with SMTP id
 h9-20020a056902008900b00dbea3b06e37mr938736ybs.117.1705600715789; Thu, 18 Jan
 2024 09:58:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240115183837.205694-1-surenb@google.com> <1bc8a5df-b413-4869-8931-98f5b9e82fe5@suse.cz>
 <74005ee1-b6d8-4ab5-ba97-92bec302cc4b@suse.cz> <CAJuCfpGTVEy=ZURbL3c7k+CduDR8wSfqsujN+OecPwuns7LiGQ@mail.gmail.com>
In-Reply-To: <CAJuCfpGTVEy=ZURbL3c7k+CduDR8wSfqsujN+OecPwuns7LiGQ@mail.gmail.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Thu, 18 Jan 2024 09:58:24 -0800
Message-ID: <CAJuCfpHsNP7C2aDrgG=ANS+O2jh1ptEcAn2Gp0JhpM33=sf9UA@mail.gmail.com>
Subject: Re: [RFC 0/3] reading proc/pid/maps under RCU
To: Vlastimil Babka <vbabka@suse.cz>
Cc: akpm@linux-foundation.org, viro@zeniv.linux.org.uk, brauner@kernel.org, 
	jack@suse.cz, dchinner@redhat.com, casey@schaufler-ca.com, 
	ben.wolsieffer@hefring.com, paulmck@kernel.org, david@redhat.com, 
	avagin@google.com, usama.anjum@collabora.com, peterx@redhat.com, 
	hughd@google.com, ryan.roberts@arm.com, wangkefeng.wang@huawei.com, 
	Liam.Howlett@oracle.com, yuzhao@google.com, axelrasmussen@google.com, 
	lstoakes@gmail.com, talumbau@google.com, willy@infradead.org, 
	mgorman@techsingularity.net, jhubbard@nvidia.com, vishal.moola@gmail.com, 
	mathieu.desnoyers@efficios.com, dhowells@redhat.com, jgg@ziepe.ca, 
	sidhartha.kumar@oracle.com, andriy.shevchenko@linux.intel.com, 
	yangxingui@huawei.com, keescook@chromium.org, linux-kernel@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 16, 2024 at 9:57=E2=80=AFAM Suren Baghdasaryan <surenb@google.c=
om> wrote:
>
> On Tue, Jan 16, 2024 at 6:46=E2=80=AFAM Vlastimil Babka <vbabka@suse.cz> =
wrote:
> >
> > On 1/16/24 15:42, Vlastimil Babka wrote:
> > > On 1/15/24 19:38, Suren Baghdasaryan wrote:
> > >
> > > Hi,
> > >
> > >> The issue this patchset is trying to address is mmap_lock contention=
 when
> > >> a low priority task (monitoring, data collecting, etc.) blocks a hig=
her
> > >> priority task from making updated to the address space. The contenti=
on is
> > >> due to the mmap_lock being held for read when reading proc/pid/maps.
> > >> With maple_tree introduction, VMA tree traversals are RCU-safe and p=
er-vma
> > >> locks make VMA access RCU-safe. this provides an opportunity for loc=
k-less
> > >> reading of proc/pid/maps. We still need to overcome a couple obstacl=
es:
> > >> 1. Make all VMA pointer fields used for proc/pid/maps content genera=
tion
> > >> RCU-safe;
> > >> 2. Ensure that proc/pid/maps data tearing, which is currently possib=
le at
> > >> page boundaries only, does not get worse.
> > >
> > > Hm I thought we were to only choose this more complicated in case add=
itional
> > > tearing becomes a problem, and at first assume that if software can d=
eal
> > > with page boundary tearing, it can deal with sub-page tearing too?
>
> Hi Vlastimil,
> Thanks for the feedback!
> Yes, originally I thought we wouldn't be able to avoid additional
> tearing without a big change but then realized it's not that hard, so
> I tried to keep the change in behavior transparent to the userspace.

In the absence of other feedback I'm going to implement and post the
originally envisioned approach: remove validation step and avoid any
possibility of blocking but allowing for sub-page tearing. Will use
Matthew's rwsem_wait() to deal with possible inconsistent maple_tree
state.
Thanks,
Suren.

>
> > >
> > >> The patchset deals with these issues but there is a downside which I=
 would
> > >> like to get input on:
> > >> This change introduces unfairness towards the reader of proc/pid/map=
s,
> > >> which can be blocked by an overly active/malicious address space mod=
ifyer.
> > >
> > > So this is a consequence of the validate() operation, right? We could=
 avoid
> > > this if we allowed sub-page tearing.
>
> Yes, if we don't care about sub-page tearing then we could get rid of
> validate step and this issue with updaters blocking the reader would
> go away. If we choose that direction there will be one more issue to
> fix, namely the maple_tree temporary inconsistent state when a VMA is
> replaced with another one and we might observe NULL there. We might be
> able to use Matthew's rwsem_wait() to deal with that issue.
>
> > >
> > >> A couple of ways I though we can address this issue are:
> > >> 1. After several lock-less retries (or some time limit) to fall back=
 to
> > >> taking mmap_lock.
> > >> 2. Employ lock-less reading only if the reader has low priority,
> > >> indicating that blocking it is not critical.
> > >> 3. Introducing a separate procfs file which publishes the same data =
in
> > >> lock-less manner.
> >
> > Oh and if this option 3 becomes necessary, then such new file shouldn't
> > validate() either, and whoever wants to avoid the reader contention and
> > converts their monitoring to the new file will have to account for this
> > possible extra tearing from the start. So I would suggest trying to cha=
nge
> > the existing file with no validate() first, and if existing userspace g=
ets
> > broken, employ option 3. This would mean no validate() in either case?
>
> Yes but I was trying to avoid introducing additional file which
> publishes the same content in a slightly different way. We will have
> to explain when userspace should use one vs the other and that would
> require going into low level implementation details, I think. Don't
> know if that's acceptable/preferable.
> Thanks,
> Suren.
>
> >
> > >> I imagine a combination of these approaches can also be employed.
> > >> I would like to get feedback on this from the Linux community.
> > >>
> > >> Note: mmap_read_lock/mmap_read_unlock sequence inside validate_map()
> > >> can be replaced with more efficiend rwsem_wait() proposed by Matthew
> > >> in [1].
> > >>
> > >> [1] https://lore.kernel.org/all/ZZ1+ZicgN8dZ3zj3@casper.infradead.or=
g/
> > >>
> > >> Suren Baghdasaryan (3):
> > >>   mm: make vm_area_struct anon_name field RCU-safe
> > >>   seq_file: add validate() operation to seq_operations
> > >>   mm/maps: read proc/pid/maps under RCU
> > >>
> > >>  fs/proc/internal.h        |   3 +
> > >>  fs/proc/task_mmu.c        | 130 ++++++++++++++++++++++++++++++++++-=
---
> > >>  fs/seq_file.c             |  24 ++++++-
> > >>  include/linux/mm_inline.h |  10 ++-
> > >>  include/linux/mm_types.h  |   3 +-
> > >>  include/linux/seq_file.h  |   1 +
> > >>  mm/madvise.c              |  30 +++++++--
> > >>  7 files changed, 181 insertions(+), 20 deletions(-)
> > >>
> > >
> >

