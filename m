Return-Path: <linux-kernel+bounces-106653-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AEF5A87F191
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 21:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 270121F22455
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 20:50:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19B5957895;
	Mon, 18 Mar 2024 20:50:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egwKstfS"
Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925A1250EC
	for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 20:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710795045; cv=none; b=ccpKdBIiQfiKjstJbDn9NCX89A+GTyq8J6keFxlzOMhUZDs/jaS9MZDb3fLjbQWa54aP4O1n46c77TDBf/xh+rBvQjR+KrmGB1vgmVV/pvFDv5+g+5xYUJiv+DWJPAkAF6kyoJgYpBd9+Cs32mL8bnrItnH2v+eE3K9MuZW+L48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710795045; c=relaxed/simple;
	bh=tzDzOD9lG0PFz/q/x2y7h3krtiV/OfjUp7kHu+v2Qko=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=OJpMEwRuDKOnO/zByttENMreIhvVFEr98VqTMWXwI+dfSB6WH3dKAgfkK1UPme+i3znFbh+IS2niAMCyBp426bN1x3K9fYWLCrlug40e/3VvnzbWau75BSmRyeNvlaJ/zu1bWEh51Ty9p0KudiYFcId49eocl0B5F6CWqcTHW9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egwKstfS; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-475ffc62cbaso1164669137.1
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 13:50:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710795042; x=1711399842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aInPZU8ZCi7iEM6SQv8qrjNGFrnU4zLmzqDSDyV+MFA=;
        b=egwKstfSBoF51PYsDhx1whXehLSbKDty9POI9A1Fvvqw1YfJjT8Cr/I38iKtNjkY8X
         cZpxgLUqbTiN+/HPqthVuLk1YxlTwIaKSCdIGSGOCNu6RbYl7mJX5ebt72RQJn/7ICu1
         2i9KoqoKFefGfEU+7dkaBQq0/lacRFleknwOFwkmgBl2A8OnCYC0jPHEp06D2NpNKs/H
         OlqT3E6BIug37Get1MKdm7E20+fGyH4EAzYO4qHUtSVsdmgxu10ECHxF5GOUgaMjnFp9
         LJuXO0v1c5k4FDWZXldzyKaLXQ0eHPgtvhttb76LfKNNySz238q1KUipGiePPsqXJ1qO
         E+/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710795042; x=1711399842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aInPZU8ZCi7iEM6SQv8qrjNGFrnU4zLmzqDSDyV+MFA=;
        b=vrXBlxY+9JN0Zzc2JYqT8Za8V9eaWBEugcBXFE6UOiFekv5lsaoiPjK2H/HV040kxw
         BX8nBknCICeSCo4+5saB+aRzhc7crrE+5TzwMCUadhGqQ1jtTqMy6yLlDRqrkeloQwea
         VSUCMkh2oEgt7zJrTM7pPaE/B9pLMDsw34R29lTIH2XrmYauglHb/Cn5eVlDF1y78LDL
         RV9kDRRVhYgkDCQZ6vxW7vExngQRtfKVV9eMkP2kIJJHJDmKUwN+kYqBxewozUES2Ruu
         Fo6S3H/yDtk94KsZXSDnQijcamEe2p2xLAnkvebIESoBbzisnXeSGSfVwf7Ze/J1RknV
         9Pnw==
X-Forwarded-Encrypted: i=1; AJvYcCWqIcOA2skxosD1n4ggD0/GASl51DaDjgIes0PPB5sguBdpI9rofR4dbSUZKsHNWaqRSey15tSWU53FmlJYAzQ3lweEPW0CHl4GsKMq
X-Gm-Message-State: AOJu0Yxq8jzaHZG9p3y5PcS1A/UQRWqS7tW4WDy8mcpPGdaUL56PYo+1
	pqVgErookVbItdYl0wTI1u/xFL0Em791YQ4hv3k0jYZdoa76c48tcz7QVHrMVXKBW0msKH3PTPj
	5u01cVhPVL0EG6wkFmHXE7enQrno=
X-Google-Smtp-Source: AGHT+IHuwhlb3WMYSXhaIbOIWC+yG/5k7grmB2tJmYrBhwE3kWR4pf2Jiy5Afwn0tuPVWmVaR1s9PQpgpG768jKocwk=
X-Received: by 2002:a67:fc81:0:b0:476:9b54:506b with SMTP id
 x1-20020a67fc81000000b004769b54506bmr510050vsp.5.1710795042387; Mon, 18 Mar
 2024 13:50:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000bbb3d80613f243a6@google.com> <CAKEwX=MAX0km1p43DQmKbeSy2G4dPFHiF+deH_qzqygc2Vnjig@mail.gmail.com>
 <CAGsJ_4y7aFg3FBh_isa_TCqY1B8n64Rro5mVu6=wvk7FP35mWw@mail.gmail.com> <CAJD7tkaPmgsUjPCi0wKCYAmPb+Vnif_zS+ouyd9NGQN=mdhJPw@mail.gmail.com>
In-Reply-To: <CAJD7tkaPmgsUjPCi0wKCYAmPb+Vnif_zS+ouyd9NGQN=mdhJPw@mail.gmail.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 09:50:30 +1300
Message-ID: <CAGsJ_4xyDm0BLYvbW0z9J-Q=sQPYrttva33g2mRFVXcJJ+wimw@mail.gmail.com>
Subject: Re: [syzbot] [mm?] kernel BUG in sg_init_one
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Nhat Pham <nphamcs@gmail.com>, 
	syzbot <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com>, 
	akpm@linux-foundation.org, chengming.zhou@linux.dev, hannes@cmpxchg.org, 
	linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	syzkaller-bugs@googlegroups.com, Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 9:35=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Mar 18, 2024 at 1:25=E2=80=AFPM Barry Song <21cnbao@gmail.com> wr=
ote:
> >
> > On Tue, Mar 19, 2024 at 7:00=E2=80=AFAM Nhat Pham <nphamcs@gmail.com> w=
rote:
> > >
> > > On Mon, Mar 18, 2024 at 9:58=E2=80=AFAM syzbot
> > > <syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com> wrote:
> > > >
> > > > Hello,
> > > >
> > > > syzbot found the following issue on:
> > > >
> > > > HEAD commit:    e5eb28f6d1af Merge tag 'mm-nonmm-stable-2024-03-14-=
09-36' ..
> > > > git tree:       upstream
> > > > console output: https://syzkaller.appspot.com/x/log.txt?x=3D13043ab=
e180000
> > > > kernel config:  https://syzkaller.appspot.com/x/.config?x=3D19bb57c=
23dffc38e
> > > > dashboard link: https://syzkaller.appspot.com/bug?extid=3Dadbc983a1=
588b7805de3
> > > > compiler:       arm-linux-gnueabi-gcc (Debian 12.2.0-14) 12.2.0, GN=
U ld (GNU Binutils for Debian) 2.40
> > > > userspace arch: arm
> > > > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D1706d=
231180000
> > > > C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=3D13ba795=
9180000
> > > >
> > > > Downloadable assets:
> > > > disk image (non-bootable): https://storage.googleapis.com/syzbot-as=
sets/8ead8862021c/non_bootable_disk-e5eb28f6.raw.xz
> > > > vmlinux: https://storage.googleapis.com/syzbot-assets/0a7371c63ff2/=
vmlinux-e5eb28f6.xz
> > > > kernel image: https://storage.googleapis.com/syzbot-assets/7539441b=
4add/zImage-e5eb28f6.xz
> > > >
> > > > IMPORTANT: if you fix the issue, please add the following tag to th=
e commit:
> > > > Reported-by: syzbot+adbc983a1588b7805de3@syzkaller.appspotmail.com
> > > >
> > > > ------------[ cut here ]------------
> > > > kernel BUG at include/linux/scatterlist.h:187!
> > >
> > > Looks like the provided buffer is invalid:
> > >
> > > #ifdef CONFIG_DEBUG_SG
> > > BUG_ON(!virt_addr_valid(buf));
> > > #endif
> > >
> > > which is "src" from:
> > >
> > > sg_init_one(&input, src, entry->length);
> > >
> > > Looking at the surrounding code and recent history, there's this
> > > commit that stands out:
> > >
> > > mm/zswap: remove the memcpy if acomp is not sleepable
> > > (sha: 270700dd06ca41a4779c19eb46608f076bb7d40e)
> > >
> > > which has the effect of, IIUC, using the zpool mapped memory directly
> > > as src, instead of acomp_ctx->buffer (which was previously the case,
> > > as zsmalloc was not sleepable).
> > >
> > > This might not necessarily be a bug with that commit itself, but migh=
t
> > > have revealed another bug elsewhere.
> > >
> > > Anyway, cc-ing the author, Barry Song, to fact check me :) Will take =
a
> > > closer look later.
> >
> > I guess that is because on arm32 , we have highmem but
> > sg_init_one supports lowmem only. the below should be
> > able to fix?
> >
> > diff --git a/mm/zswap.c b/mm/zswap.c
> > index 9dec853647c8..47c0386caba2 100644
> > --- a/mm/zswap.c
> > +++ b/mm/zswap.c
> > @@ -1086,7 +1086,8 @@ static void zswap_decompress(struct zswap_entry
> > *entry, struct page *page)
> >                 zpool_unmap_handle(zpool, entry->handle);
> >         }
> >
> > -       sg_init_one(&input, src, entry->length);
> > +       sg_init_table(&input, 1);
> > +       sg_set_page(&input, kmap_to_page(src), entry->length,
> > offset_in_page(src));
>
> Is this working around the debug check in sg_init_one()? IIUC, only

I wouldn't characterize it as a workaround; it's more of a solution.

> lowmem pages are supported. We may be passing in a highmem page to
> sg_set_page() now, right?

we can pass highmem to sg_set_page(). This is perfectly fine.

>
> Also, it seems like if src is a lowmem address kmap_to_page() will be
> doing unnecessary checks (assuming it's working correctly)?

In practice, we consistently use kmap and kunmap even on systems with
low memory.
However, it's worth noting that for low memory scenarios, kmap
essentially returns
page_to_virt(page_address). Thus, the overhead of kmap_to_page shouldn't be
significant on low memory systems, especially considering that it simplifie=
s to
virt_to_page().

Another approach is to consistently employ page_to_virt() for low
memory situations
and reserve kmap for high memory scenarios. However, since we always
utilize kmap
regardless of whether the page is low or high memory, we don't need to conc=
ern
ourselves with this distinction

>
> Would it be more robust to just use the temporary buffer if src is a
> kmap address?

I don't think so because we will need a memcpy then.

>
> Also FWIW, I think you can use "#sys test" to check if a diff fixes the p=
roblem.
>
> >         sg_init_table(&output, 1);
> >         sg_set_page(&output, page, PAGE_SIZE, 0);
> >         acomp_request_set_params(acomp_ctx->req, &input, &output,
> > entry->length, PAGE_SIZE);
> >
> >
> >
Thanks
Barry

