Return-Path: <linux-kernel+bounces-50913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22FAB848329
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE4E828BF11
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:30:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1071850271;
	Sat,  3 Feb 2024 04:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ze0n6zBk"
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AE2950259
	for <linux-kernel@vger.kernel.org>; Sat,  3 Feb 2024 04:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706933880; cv=none; b=URQYL2K7o7Y9jpLGtPYgxd56EejXHLpkQFSaGJd5M5Sk2L88ZMN9wCyNnnDQiupPQT2jKDPQdnzFkvvrEvFPuNL4heCP+iWYmBxSHv1QGCCJrQG8CqhuGXbLNPJMpfDU6kWpjJ0WUenp69uRJ8bASy2lGaORgfdf6SekEzLNKMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706933880; c=relaxed/simple;
	bh=nsl3WqQ+k+ykbNiLwPF1PCJ3ZiKDT5+I14JPm9QENBQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=AWja88qY7VIqxdkMC3J7QQLVIiQRy8Jb1lpxJrWEqw8USIhnMousw0EByfQDpvcmkODcpcBILoOxSoGi0eyf5r01gpoyi3ZIdm1XlkuH2/nDtLNcFIlCi+1XZ9Gf86Z5vMRg37THN4kwOXBGery8ng+i9jY4EBNhv27zGJRdV2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ze0n6zBk; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-dc6cbe1ac75so1124348276.1
        for <linux-kernel@vger.kernel.org>; Fri, 02 Feb 2024 20:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706933877; x=1707538677; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nsl3WqQ+k+ykbNiLwPF1PCJ3ZiKDT5+I14JPm9QENBQ=;
        b=Ze0n6zBkzeNSaNLwYm5BbCvoQqA5KXXPSeEFPl5GnI6l10SXg7U9RWCT+srAQdmDsg
         g5QR4swG+iD6R8wVAXDqz2aEhI3BjG/kckN3G/spsijE9V7P5Q+dDPFJlzSQC6fsVgJM
         d7iTmgehVfNpJMJibF7L/XuIlOphB9JZCZ7LU9o7+Qgwv/uHo92WDPhajq9TeYq0fAY/
         l7DnEy13uPGDKsYBmEz6GClYRJ7LVbcEra4mlfLcGqf261HSFw24RSX4kk+G6Xc/MIOF
         DfR/+NMilgxx+Ca9UimUiNcgsBKqMXXUoPfhEFZCiCAhcQRAr9R0AQYjtmfcrm5nNXbI
         BTMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706933877; x=1707538677;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nsl3WqQ+k+ykbNiLwPF1PCJ3ZiKDT5+I14JPm9QENBQ=;
        b=gKFQ7gsLeieczrrlnMsO6+rszfbqiyeLKPl8JWGR3TlltOaheoR0qMneVo6rhxMpQP
         3X+PStWNEYBbnILJpW+CzN1n8z+X0akw8pz9VfjaZXGC+dQFmoWBujTK8hqjPZxvKS1Y
         T716MPLkIMYKxIVRD6lkiH2gbpzje10Gwi4VUxYAmoZBdbl3oqwPMQD6FatrofLh9xQO
         uPioPkI7CIGJgncMg4Ti2EhfVhqKr2F714M7jQSsJUQmXT7cMoXW2sZHP+dnvVveHbys
         hUCmL8kU1UkqeJoUEwkaz3knvoSjrwsNYSdDssoJ3oNFHJhHnNBM6SecLI5p4LWBQcge
         ABng==
X-Gm-Message-State: AOJu0Yx3XMlX4LmlSKzsPmZAxzYadcleT3NHaGdMafVfQeMsXMyd1B/r
	oh1iFLhm6ZlBiPxXim+Gah9YbSXPv9/3YFUwLyalwEGSsqQK9Y+WJHN155VwCWn2LVKCxecxrNu
	tRuQE+Y4HjzgqFBRaGm/4+8MRZ6c=
X-Google-Smtp-Source: AGHT+IGDes7I6Lw5tNAKr41vy3Nm31KZ13xinGdJaeNu3Cj+y1qeCO20pV70xsfUrp9HTXKQPWob3FOvoTdbhzTRNRw=
X-Received: by 2002:a25:8183:0:b0:dc6:5570:898e with SMTP id
 p3-20020a258183000000b00dc65570898emr353556ybk.17.1706933877392; Fri, 02 Feb
 2024 20:17:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240201125226.28372-1-ioworker0@gmail.com> <Zby-sHLDlmTRaUcd@tiehlicka>
 <CAK1f24=7sy_Bczpt5YeDbkhfriYUc1=zreSFdGCxfF3R0D6sRQ@mail.gmail.com>
 <ZbzfxNn4AYnTVFLh@tiehlicka> <CAK1f24mvBkc2c=fHL6UxMhL2mgLHVrSwZfE5516bOR0yVdfZpQ@mail.gmail.com>
 <ZbzmvwyTGeW18nJy@tiehlicka> <CAK1f24kdyOnUjcpnrk6j4cF6bSFXQwwzFk9tM+jD4RsO_Hc4hA@mail.gmail.com>
 <Zbz_ao0uBKabzKB1@tiehlicka> <CAK1f24nHmvqm1XD_UkWUB7DmNdH0NEOKzpLgKDJ=UuPWO=rEHw@mail.gmail.com>
 <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
In-Reply-To: <CAHbLzkpYM3jGVP19hG6LcD0=C=LHgGXqjVhsMYhO4HQufsfy-g@mail.gmail.com>
From: Lance Yang <ioworker0@gmail.com>
Date: Sat, 3 Feb 2024 12:17:45 +0800
Message-ID: <CAK1f24n_ahUoWvw1zJN3P9W-4cxuQVL=1cOZKNjiBhp-ortc5g@mail.gmail.com>
Subject: Re: [PATCH 1/1] mm/khugepaged: skip copying lazyfree pages on collapse
To: Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>, 
	David Hildenbrand <david@redhat.com>
Cc: akpm@linux-foundation.org, zokeefe@google.com, songmuchun@bytedance.com, 
	peterx@redhat.com, minchan@kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hey Michal, David, Yang,

I sincerely appreciate your time!

I still have two questions that are perplexing me.

First question:
Given that khugepaged doesn't treat MADV_FREE
pages as pte_none, why skip the 2M block when all
the pages within the range are old and unreferenced,
but won't skip if the partial range is MADV_FREE,
even if it's not redirtied? Why make this distinction?
Would it not be more straightforward to maintain
if either all were skipped or not?

Second question:
Does copying lazyfree pages (not redirtied) to the
new huge page during khugepaged collapse
undermine the semantics of MADV_FREE?
Users mark pages as lazyfree with MADV_FREE,
expecting these pages to be eventually reclaimed.
Even without subsequent writes, these pages will
no longer be reclaimed, even if memory pressure
occurs.

BR,
Lance

On Sat, Feb 3, 2024 at 1:42=E2=80=AFAM Yang Shi <shy828301@gmail.com> wrote=
:
>
> On Fri, Feb 2, 2024 at 6:53=E2=80=AFAM Lance Yang <ioworker0@gmail.com> w=
rote:
> >
> > How about blocking khugepaged from
> > collapsing lazyfree pages? This way,
> > is it not better to keep the semantics
> > of MADV_FREE?
> >
> > What do you think?
>
> First of all, khugepaged doesn't treat MADV_FREE pages as pte_none
> IIUC. The khugepaged does skip the 2M block if all the pages are old
> and unreferenced pages in the range in hpage_collapse_scan_pmd(), then
> repeat the check in collapse_huge_page() again.
>
> And MADV_FREE pages are just old and unreferenced. This is actually
> what your first test case does. The whole 2M range is MADV_FREE range,
> so they are skipped by khugepaged.
>
> But if the partial range is MADV_FREE, khugepaged won't skip them.
> This is what your second test case does.
>
> Secondly, I think it depends on the semantics of MADV_FREE,
> particularly how to treat the redirtied pages. TBH I'm always confused
> by the semantics. For example, the page contained "abcd", then it was
> MADV_FREE'ed, then it was written again with "1234" after "abcd". So
> the user should expect to see "abcd1234" or "00001234".
>
> I'm supposed it should be "abcd1234" since MADV_FREE pages are still
> valid and available, if I'm wrong please feel free to correct me. If
> so we should always copy MADV_FREE pages in khugepaged regardless of
> whether it is redirtied or not otherwise it may incur data corruption.
> If we don't copy, then the follow up redirty after collapse to the
> hugepage may return "00001234", right?
>
> The current behavior is copying the page.
>
> >
> > Thanks,
> > Lance
> >
> > On Fri, Feb 2, 2024 at 10:42=E2=80=AFPM Michal Hocko <mhocko@suse.com> =
wrote:
> > >
> > > On Fri 02-02-24 21:46:45, Lance Yang wrote:
> > > > Here is a part from the man page explaining
> > > > the MADV_FREE semantics:
> > > >
> > > > The kernel can thus free thesepages, but the
> > > > freeing could be delayed until memory pressure
> > > > occurs. For each of the pages that has been
> > > > marked to be freed but has not yet been freed,
> > > > the free operation will be canceled if the caller
> > > > writes into the page. If there is no subsequent
> > > > write, the kernel can free the pages at any time.
> > > >
> > > > IIUC, if there is no subsequent write, lazyfree
> > > > pages will eventually be reclaimed.
> > >
> > > If there is no memory pressure then this might not
> > > ever happen. User cannot make any assumption about
> > > their content once madvise call has been done. The
> > > content has to be considered lost. Sure the userspace
> > > might have means to tell those pages from zero pages
> > > and recheck after the write but that is about it.
> > >
> > > > khugepaged
> > > > treats lazyfree pages the same as pte_none,
> > > > avoiding copying them to the new huge page
> > > > during collapse. It seems that lazyfree pages
> > > > are reclaimed before khugepaged collapses them.
> > > > This aligns with user expectations.
> > > >
> > > > However, IMO, if the content of MADV_FREE pages
> > > > remains valid during collapse, then khugepaged
> > > > treating lazyfree pages the same as pte_none
> > > > might not be suitable.
> > >
> > > Why?
> > >
> > > Unless I am missing something (which is possible of
> > > course) I do not really see why dropping the content
> > > of those pages and replacing them with a THP is any
> > > difference from reclaiming those pages and then faulting
> > > in a non-THP zero page.
> > >
> > > Now, if khugepaged reused the original content of MADV_FREE
> > > pages that would be a slightly different story. I can
> > > see why users would expect zero pages to back madvised
> > > area.
> > > --
> > > Michal Hocko
> > > SUSE Labs

