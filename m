Return-Path: <linux-kernel+bounces-57024-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E95584D2F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 21:26:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 934EAB26B80
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 20:26:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6308127B6A;
	Wed,  7 Feb 2024 20:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="PaleEkjV"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAC1A127B51
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 20:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707337508; cv=none; b=RIUjqsx0DOUk1PJeJOeBmGa71LqYNa51myGDbdPBW5EsSKSK0DT6QYufnMAYfKyt9hRMRoOM9HGWwqlEhsnSy0xkY7GAFjZMzQVCN4f5GuCNLggeRpe38JYXIHruzUEP1lLyv0SkSzymV0fMKyPIdTmqHs8CgkWZTj/gNOG+Olg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707337508; c=relaxed/simple;
	bh=vFnk6DQ8EIJEAZ/DRRBigdf0kxotx3XgDLJZVdGyWlw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=taEio2EdWsd3AZmc/usljEuGYyzUIhYctzihSXdtwbR2qokba5Fl7GoG72ddvyZIrXDj1Evr0k/rMNzN5NqyT8uO9r3CvDzPoUMrX+P6BXVDgp0iOYDLWQTi0vzBNvxK+bFtb4/pcrfFYnccgndd7lbhOPhzw58M8ewa7unukwo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=PaleEkjV; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33b5736b7c9so45069f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Feb 2024 12:25:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707337505; x=1707942305; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAp9QYmAagl4q8JstQaVuR+UzMqpGvUOafiaUGshjJs=;
        b=PaleEkjVXxGy63Ac5y+TKCmm1XTs6lU90cBz6EKTDiixC8bMAajNTFdbP/uBiFLuc6
         1fSeICo9XL6/4DsMG4oQVTviu5Z0givtNpXrtGaHkiFSiZbyjVRMRXGOBPgvivHeyDry
         ziZXUHPTDftXbxAnkw/t+AjODhrGARwGNeKk8TSgZ0KMio+yab3vVm4hZqIbM8ZVGeaB
         8zPQ8ky9N5JqVnCvn93JVm9rgJN3Sc/cKV1qRJmIdfIkFPTnC4oBv4U97xf9nr9GrrkH
         fKJWSRdGossRtu9mvcWPzPlMnBVBocf/U0xZrotiMOJFShN+yRVOztwXAbsW/kDKMHjN
         I3Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707337505; x=1707942305;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAp9QYmAagl4q8JstQaVuR+UzMqpGvUOafiaUGshjJs=;
        b=nExD555pY7yTxqImSFIEe80EVYJ3HyXbQPlJQ/bmf00W6K8a8ZWivopuwKcTAyPQUw
         WS6XbceM+pG7kvvSNSy2PGKfnIr+5UfzXqzoEGEh9mNu7FaQu/VK1tiJOVCOMgRzhzeE
         lF1bWlv211ql3esb1iJ2lk6/3LT9HxeK8BVntp2tgLgHBWmBo5q2MlUT4YP1jFPfX6w2
         3KLSGSC6+JwCxJ78tzWQWfd1hb4ioBpgSnphc867UCkonFWEVSzdeixpva2W2Sla4qis
         s92Oblz3UoC5XibSBh6vlDj7AeprXIJrcPoI2vxkTIGjs2BMJYYK32mEniB+ffQeRe00
         B7ww==
X-Forwarded-Encrypted: i=1; AJvYcCVPI9bHVjGJuQeqwWRfWg6R3WeL4GO/Y/6Sbysyrr72BX7U5mBEy95vUUNrWhrLkxrLtdq1Mos/QWWGVPzdQvUWHLouMwnaZNAlrMiQ
X-Gm-Message-State: AOJu0YyYsqhQmiXqPJCRdIXPVWSwhKGT7I+75zvF4LF3D4ot+OS54084
	n0+GYOl3AHtwEb9/QvU+ZV0HjX1ZlkokYcxQx8DQ6Ycr1YeJyBxYN2Z8bbQR7BCveSJsPl/xc7y
	F6P/dlYxIPQmam+lpHNe5E8Wdxrowa6gpseAe
X-Google-Smtp-Source: AGHT+IGQqWin6xslOwihUtxiZ2GFaThvfVui+rAPsrOr+dtRa0BkT869a3jIv2EUBTyktcfXEleTmaU5Z1oYmEKy778=
X-Received: by 2002:adf:ff91:0:b0:33b:2177:2228 with SMTP id
 j17-20020adfff91000000b0033b21772228mr4665957wrr.59.1707337504834; Wed, 07
 Feb 2024 12:25:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240129193512.123145-1-lokeshgidra@google.com>
 <20240129193512.123145-3-lokeshgidra@google.com> <20240129210014.troxejbr3mzorcvx@revolver>
 <CA+EESO6XiPfbUBgU3FukGvi_NG5XpAQxWKu7vg534t=rtWmGXg@mail.gmail.com>
 <20240130034627.4aupq27mksswisqg@revolver> <Zbi5bZWI3JkktAMh@kernel.org>
 <20240130172831.hv5z7a7bhh4enoye@revolver> <CA+EESO7W=yz1DyNsuDRd-KJiaOg51QWEQ_MfpHxEL99ZeLS=AA@mail.gmail.com>
 <Zb9mgL8XHBZpEVe7@kernel.org> <CA+EESO7RNn0aQhLxY+NDddNNNT6586qX08=rphU1-XmyoP5mZQ@mail.gmail.com>
 <ZcOhW8NR9XWhVnKS@kernel.org>
In-Reply-To: <ZcOhW8NR9XWhVnKS@kernel.org>
From: Lokesh Gidra <lokeshgidra@google.com>
Date: Wed, 7 Feb 2024 12:24:52 -0800
Message-ID: <CA+EESO6V9HiPtFpG7-cjvadj_BcKzGvi4GSdJBXD_zTM+EQu5A@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] userfaultfd: protect mmap_changing with rw_sem in userfaulfd_ctx
To: Mike Rapoport <rppt@kernel.org>
Cc: "Liam R. Howlett" <Liam.Howlett@oracle.com>, akpm@linux-foundation.org, 
	linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com, timmurray@google.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 7:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> wrot=
e:
>
> On Mon, Feb 05, 2024 at 12:53:33PM -0800, Lokesh Gidra wrote:
> > On Sun, Feb 4, 2024 at 2:27=E2=80=AFAM Mike Rapoport <rppt@kernel.org> =
wrote:
> > >
> > > > 3) Based on [1] I see how mmap_changing helps in eliminating duplic=
ate
> > > > work (background copy) by uffd monitor, but didn't get if there is =
a
> > > > correctness aspect too that I'm missing? I concur with Amit's point=
 in
> > > > [1] that getting -EEXIST when setting up the pte will avoid memory
> > > > corruption, no?
> > >
> > > In the fork case without mmap_changing the child process may be get d=
ata or
> > > zeroes depending on the race for mmap_lock between the fork and
> > > uffdio_copy and -EEXIST is not enough for monitor to detect what was =
the
> > > ordering between fork and uffdio_copy.
> >
> > This is extremely helpful. IIUC, there is a window after mmap_lock
> > (write-mode) is released and before the uffd monitor thread is
> > notified of fork. In that window, the monitor doesn't know that fork
> > has already happened. So, without mmap_changing it would have done
> > background copy only in the parent, thereby causing data inconsistency
> > between parent and child processes.
>
> Yes.
>
> > It seems to me that the correctness argument for mmap_changing is
> > there in case of FORK event and REMAP when mremap is called with
> > MREMAP_DONTUNMAP. In all other cases its only benefit is by avoiding
> > unnecessary background copies, right?
>
> Yes, I think you are right, but it's possible I've forgot some nasty race
> that will need mmap_changing for other events.
>
> > > > > > > > > > @@ -783,7 +788,9 @@ bool userfaultfd_remove(struct vm_a=
rea_struct *vma,
> > > > > > > > > >               return true;
> > > > > > > > > >
> > > > > > > > > >       userfaultfd_ctx_get(ctx);
> > > > > > > > > > +     down_write(&ctx->map_changing_lock);
> > > > > > > > > >       atomic_inc(&ctx->mmap_changing);
> > > > > > > > > > +     up_write(&ctx->map_changing_lock);
> > > > > > > > > >       mmap_read_unlock(mm);
> > > > > > > > > >
> > > > > > > > > >       msg_init(&ewq.msg);
> > > > > > >
> > > > > > > If this happens in read mode, then why are you waiting for th=
e readers
> > > > > > > to leave?  Can't you just increment the atomic?  It's fine ha=
ppening in
> > > > > > > read mode today, so it should be fine with this new rwsem.
> > > > > >
> > > > > > It's been a while and the details are blurred now, but if I rem=
ember
> > > > > > correctly, having this in read mode forced non-cooperative uffd=
 monitor to
> > > > > > be single threaded. If a monitor runs, say uffdio_copy, and in =
parallel a
> > > > > > thread in the monitored process does MADV_DONTNEED, the latter =
will wait
> > > > > > for userfaultfd_remove notification to be processed in the moni=
tor and drop
> > > > > > the VMA contents only afterwards. If a non-cooperative monitor =
would
> > > > > > process notification in parallel with uffdio ops, MADV_DONTNEED=
 could
> > > > > > continue and race with uffdio_copy, so read mode wouldn't be en=
ough.
> > > > > >
> > > > >
> > > > > Right now this function won't stop to wait for readers to exit th=
e
> > > > > critical section, but with this change there will be a pause (sin=
ce the
> > > > > down_write() will need to wait for the readers with the read lock=
).  So
> > > > > this is adding a delay in this call path that isn't necessary (?)=
 nor
> > > > > existed before.  If you have non-cooperative uffd monitors, then =
you
> > > > > will have to wait for them to finish to mark the uffd as being re=
moved,
> > > > > where as before it was a fire & forget, this is now a wait to tel=
l.
> > > > >
> > > > I think a lot will be clearer once we get a response to my question=
s
> > > > above. IMHO not only this write-lock is needed here, we need to fix
> > > > userfaultfd_remove() by splitting it into userfaultfd_remove_prep()
> > > > and userfaultfd_remove_complete() (like all other non-cooperative
> > > > operations) as well. This patch enables us to do that as we remove
> > > > mmap_changing's dependency on mmap_lock for synchronization.
> > >
> > > The write-lock is not a requirement here for correctness and I don't =
see
> > > why we would need userfaultfd_remove_prep().
> > >
> > > As I've said earlier, having a write-lock here will let CRIU to run
> > > background copy in parallel with processing of uffd events, but I don=
't
> > > feel strongly about doing it.
> > >
> > Got it. Anyways, such a change needn't be part of this patch, so I'm
> > going to keep it unchanged.
>
> You mean with a read lock?

No, I think write lock is good as it enables parallel background copy.
Also because it brings consistency in blocking userfaultfd operations.

I meant encapsulating remove operations within
userfaultfd_remove_prep() and userfaultfd_remove_complete(). I
couldn't figure out any need for that.


>
> --
> Sincerely yours,
> Mike.

