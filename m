Return-Path: <linux-kernel+bounces-103633-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1415887C236
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 18:46:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4A9CCB226E5
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 17:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082F074BFD;
	Thu, 14 Mar 2024 17:46:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jt3Tjsy9"
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 155587443F;
	Thu, 14 Mar 2024 17:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710438393; cv=none; b=XS+xrpvWL6WHTSsIQi4Mg3l/mH3lo41EDMVRQsQbgnSkI/t8lPnseRM18813m6AI+zITD8DtNn77FAhjfWzaNhv6zc9x+VEbDAWy9keqPZ3xt+mcCWCbtGwvSMPZ3UZjZ8SJrjppDs4sDL6dtpfSWHYal+GGCW8NWtYXS/HH8IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710438393; c=relaxed/simple;
	bh=agKTTomEz4kA+n4rL2OUGP6ABhhFhpO2Zl2XImbNJrE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BniQ4zsP3P1SCjJbaONpvYyHGxWNvUt5NFSNLl7h/yt17qsCZsKmZ8aG2na+msgioek3xE72Lhkh/+lV7ViO1uNOxRcDsNkKcSljPuoskVqmZfN0Zf/9mvhI/xtXP6JBq0Y8VSaXZWlixp7LtaJeHr1Yja2SD5+dbmNNmcnapjA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jt3Tjsy9; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-33e9990da78so1016014f8f.0;
        Thu, 14 Mar 2024 10:46:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710438389; x=1711043189; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4I/hbAEGvzlzslG7GDyeJP5iYQIKOeg2en3UKGStes=;
        b=Jt3Tjsy9L4k5j5sfbiIhCu+nvDKYi7Avj2cnxxxtAbLuYOCuBfB932WAK4uzTsJua+
         6QhNCf4XYLjfh7263+LtrPXzrjPZUvYWjLYAHCbtPq8a35kwJ/0CUwgwD591HP8MWAXu
         NMBmEuRrsAA9DZQNWMJ81o0oOCSd79XVAorDHikGIAA402WbF1wXIxWunopQOb0sgPRE
         PW9NHBlg+eA3JPS/ylG28XWOJW315NIVz/36c44WonYYUINQzCAVBKkToLOiO2qpVBdD
         AuofhJwzIDFYALTNC9L61hz1snMNcHlCumWsSJn0AQDbtBl2wHxtuIrPrlDaHdKSCNtg
         NAgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710438389; x=1711043189;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4I/hbAEGvzlzslG7GDyeJP5iYQIKOeg2en3UKGStes=;
        b=tRf140xGEPYVjzeXu/hFirk5hiJRfPVe1iMdfUrUWtp1sScUdgO/zuoDf/ynJnCmRp
         o3U1tx/4oxl6Ada4iC9cp1hrOFe6i54zXkjXE1s/t6Txj5TU3rhbmmfdkNrxuaKOpL6F
         2w8yOcP+2AIwtdk1wiCwh8X7riA7lgBwxancyVP/hRiZAwLOOVHFNpBFsRSNAvOaSdfK
         Z8ZetE86Y7EVq6uwK6iH19YkXbLefDU3dRCeZAz4/gR4B8/k2SwUd0rihdwP/aBz5tTh
         W8sYeczO33sDlJtZf8xlPxXytr96010DBPKj4v3vRI8E6v2d26qklGPRkQLGOQfOdcYV
         1skw==
X-Forwarded-Encrypted: i=1; AJvYcCXmgB01HA/yjt6PmgBTsgqen2v1sJ6qg0xxfGL4Rq+ELAAQ3p3DeB24Zlxx3BAotBe+HtTTotbjCNq9TUQ/xPS1PDPd4B+MJCp6/2Pa7EYwrgygGlQ53j3SzNN/NNoebkcLYBtGVyJiOsTxwOoLeB4NOmzFHq4UvFG6WIBHo78dsfhdESYhAuvd2WhMBczG4y4icmMeQQ==
X-Gm-Message-State: AOJu0Yxeov4ssXYLHBpTFgGHXvk8qMq1xcCopiCL/Kbao/RthiN1HymK
	gy72+tEJIki2OgAMyxzSIjIq5uOdcwxDVHyOXI3v2ebHInYd76+wVz63eJmgJWJH8z3me4wTtW+
	/3wbGVbDbs9KNqakFDM2F/l3XsoRY+oOmlD8=
X-Google-Smtp-Source: AGHT+IFFxixUpVKaMDQ0ST25az6uKrSdahJaFVI4ZiUZI2qk5WssR4jx9vxjvViv3ooNXrvDQ4x3Tz7pzCcwqdsjJUI=
X-Received: by 2002:a5d:594d:0:b0:33d:5484:e451 with SMTP id
 e13-20020a5d594d000000b0033d5484e451mr1740326wri.34.1710438389228; Thu, 14
 Mar 2024 10:46:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240307123619.159f1c4c@canb.auug.org.au> <20240313105117.699dc720@canb.auug.org.au>
 <20240314093012.3dba692a@canb.auug.org.au> <ZfLElrAT3RMLuWdB@pc636>
In-Reply-To: <ZfLElrAT3RMLuWdB@pc636>
From: Alexei Starovoitov <alexei.starovoitov@gmail.com>
Date: Thu, 14 Mar 2024 10:46:18 -0700
Message-ID: <CAADnVQJpoBCL6r9BM09-kcMeB4Cm0H0y+UD-i8NX5YtvcCpffw@mail.gmail.com>
Subject: Re: linux-next: manual merge of the bpf-next tree with the mm-stable tree
To: Uladzislau Rezki <urezki@gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Andrew Morton <akpm@linux-foundation.org>, 
	Networking <netdev@vger.kernel.org>, David Miller <davem@davemloft.net>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Daniel Borkmann <daniel@iogearbox.net>, Alexei Starovoitov <ast@kernel.org>, 
	Andrii Nakryiko <andrii@kernel.org>, bpf <bpf@vger.kernel.org>, 
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, 
	Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 2:34=E2=80=AFAM Uladzislau Rezki <urezki@gmail.com>=
 wrote:
>
> > Hi all,
> >
> > On Wed, 13 Mar 2024 10:51:17 +1100 Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
> > >
> > > On Thu, 7 Mar 2024 12:36:19 +1100 Stephen Rothwell <sfr@canb.auug.org=
au> wrote:
> > > >
> > > > Today's linux-next merge of the bpf-next tree got a conflict in:
> > > >
> > > >   mm/vmalloc.c
> > > >
> > > > between commit:
> > > >
> > > >   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo=
")
> > > >
> > > > from the mm-stable tree and commit:
> > > >
> > > >   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_p=
ages().")
> > > >
> > > > from the bpf-next tree.
> > > >
> > > > I fixed it up (I think - see below) and can carry the fix as necess=
ary.
> > > > This is now fixed as far as linux-next is concerned, but any non tr=
ivial
> > > > conflicts should be mentioned to your upstream maintainer when your=
 tree
> > > > is submitted for merging.  You may also want to consider cooperatin=
g
> > > > with the maintainer of the conflicting tree to minimise any particu=
larly
> > > > complex conflicts.
> > > >
> > > >
> > > > diff --cc mm/vmalloc.c
> > > > index 25a8df497255,e5b8c70950bc..000000000000
> > > > --- a/mm/vmalloc.c
> > > > +++ b/mm/vmalloc.c
> > > > @@@ -4755,81 -4423,70 +4820,84 @@@ static void show_numa_info(struc=
t seq_f
> > > >
> > > >   static void show_purge_info(struct seq_file *m)
> > > >   {
> > > >  +        struct vmap_node *vn;
> > > >           struct vmap_area *va;
> > > >  +        int i;
> > > >
> > > >  -        spin_lock(&purge_vmap_area_lock);
> > > >  -        list_for_each_entry(va, &purge_vmap_area_list, list) {
> > > >  -                seq_printf(m, "0x%pK-0x%pK %7ld unpurged vm_area\=
n",
> > > >  -                        (void *)va->va_start, (void *)va->va_end,
> > > >  -                        va->va_end - va->va_start);
> > > >  -        }
> > > >  -        spin_unlock(&purge_vmap_area_lock);
> > > >  -}
> > > >  +        for (i =3D 0; i < nr_vmap_nodes; i++) {
> > > >  +                vn =3D &vmap_nodes[i];
> > > >
> > > >  -static int s_show(struct seq_file *m, void *p)
> > > >  -{
> > > >  -        struct vmap_area *va;
> > > >  -        struct vm_struct *v;
> > > >  -
> > > >  -        va =3D list_entry(p, struct vmap_area, list);
> > > >  -
> > > >  -        if (!va->vm) {
> > > >  -                if (va->flags & VMAP_RAM)
> > > >  -                        seq_printf(m, "0x%pK-0x%pK %7ld vm_map_ra=
m\n",
> > > >  +                spin_lock(&vn->lazy.lock);
> > > >  +                list_for_each_entry(va, &vn->lazy.head, list) {
> > > >  +                        seq_printf(m, "0x%pK-0x%pK %7ld unpurged =
vm_area\n",
> > > >                                   (void *)va->va_start, (void *)va-=
>va_end,
> > > >                                   va->va_end - va->va_start);
> > > >  -
> > > >  -                goto final;
> > > >  +                }
> > > >  +                spin_unlock(&vn->lazy.lock);
> > > >           }
> > > >  +}
> > > >
> > > >  -        v =3D va->vm;
> > > >  +static int vmalloc_info_show(struct seq_file *m, void *p)
> > > >  +{
> > > >  +        struct vmap_node *vn;
> > > >  +        struct vmap_area *va;
> > > >  +        struct vm_struct *v;
> > > >  +        int i;
> > > >
> > > >  -        seq_printf(m, "0x%pK-0x%pK %7ld",
> > > >  -                v->addr, v->addr + v->size, v->size);
> > > >  +        for (i =3D 0; i < nr_vmap_nodes; i++) {
> > > >  +                vn =3D &vmap_nodes[i];
> > > >
> > > >  -        if (v->caller)
> > > >  -                seq_printf(m, " %pS", v->caller);
> > > >  +                spin_lock(&vn->busy.lock);
> > > >  +                list_for_each_entry(va, &vn->busy.head, list) {
> > > >  +                        if (!va->vm) {
> > > >  +                                if (va->flags & VMAP_RAM)
> > > >  +                                        seq_printf(m, "0x%pK-0x%p=
K %7ld vm_map_ram\n",
> > > >  +                                                (void *)va->va_st=
art, (void *)va->va_end,
> > > >  +                                                va->va_end - va->=
va_start);
> > > >
> > > >  -        if (v->nr_pages)
> > > >  -                seq_printf(m, " pages=3D%d", v->nr_pages);
> > > >  +                                continue;
> > > >  +                        }
> > > >
> > > >  -        if (v->phys_addr)
> > > >  -                seq_printf(m, " phys=3D%pa", &v->phys_addr);
> > > >  +                        v =3D va->vm;
> > > >
> > > >  -        if (v->flags & VM_IOREMAP)
> > > >  -                seq_puts(m, " ioremap");
> > > >  +                        seq_printf(m, "0x%pK-0x%pK %7ld",
> > > >  +                                v->addr, v->addr + v->size, v->si=
ze);
> > > >
> > > >  -        if (v->flags & VM_SPARSE)
> > > >  -                seq_puts(m, " sparse");
> > > >  +                        if (v->caller)
> > > >  +                                seq_printf(m, " %pS", v->caller);
> > > >
> > > >  -        if (v->flags & VM_ALLOC)
> > > >  -                seq_puts(m, " vmalloc");
> > > >  +                        if (v->nr_pages)
> > > >  +                                seq_printf(m, " pages=3D%d", v->n=
r_pages);
> > > >
> > > >  -        if (v->flags & VM_MAP)
> > > >  -                seq_puts(m, " vmap");
> > > >  +                        if (v->phys_addr)
> > > >  +                                seq_printf(m, " phys=3D%pa", &v->=
phys_addr);
> > > >
> > > >  -        if (v->flags & VM_USERMAP)
> > > >  -                seq_puts(m, " user");
> > > >  +                        if (v->flags & VM_IOREMAP)
> > > >  +                                seq_puts(m, " ioremap");
> > > >
> > > >  -        if (v->flags & VM_DMA_COHERENT)
> > > >  -                seq_puts(m, " dma-coherent");
> > > > ++                        if (v->flags & VM_SPARSE)
> > > > ++                                seq_puts(m, " sparse");
> > > > +
> > > >  -        if (is_vmalloc_addr(v->pages))
> > > >  -                seq_puts(m, " vpages");
> > > >  +                        if (v->flags & VM_ALLOC)
> > > >  +                                seq_puts(m, " vmalloc");
> > > >
> > > >  -        show_numa_info(m, v);
> > > >  -        seq_putc(m, '\n');
> > > >  +                        if (v->flags & VM_MAP)
> > > >  +                                seq_puts(m, " vmap");
> > > >  +
> > > >  +                        if (v->flags & VM_USERMAP)
> > > >  +                                seq_puts(m, " user");
> > > >  +
> > > >  +                        if (v->flags & VM_DMA_COHERENT)
> > > >  +                                seq_puts(m, " dma-coherent");
> > > >  +
> > > >  +                        if (is_vmalloc_addr(v->pages))
> > > >  +                                seq_puts(m, " vpages");
> > > >  +
> > > >  +                        show_numa_info(m, v);
> > > >  +                        seq_putc(m, '\n');
> > > >  +                }
> > > >  +                spin_unlock(&vn->busy.lock);
> > > >  +        }
> > > >
> > > >           /*
> > > >            * As a final step, dump "unpurged" areas.
> > >
> > > This is now a conflict between the net-next tree and the mm-stable tr=
ee.
> >
> >  ... and now a conflict between te mm-stable tree and Linus' tree.
> >
> If you need some help with resolving conflicts i can help. The problem
> to me looks like:
>
> <snip>
> commit d7bca9199a27b8690ae1c71dc11f825154af7234
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Fri Mar 8 09:12:54 2024 -0800
>
>     mm: Introduce vmap_page_range() to map pages in PCI address space
>
> commit e6f798225a31485e47a6e4f6aa07ee9fdf80c2cb
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Mon Mar 4 19:05:16 2024 -0800
>
>     mm: Introduce VM_SPARSE kind and vm_area_[un]map_pages().
>
> commit 3e49a866c9dcbd8173e4f3e491293619a9e81fa4
> Author: Alexei Starovoitov <ast@kernel.org>
> Date:   Mon Mar 4 19:05:15 2024 -0800
>
>     mm: Enforce VM_IOREMAP flag and range in ioremap_page_range.
> <snip>
>
> those three patches were not based on linux-next and are currently
> in the Linus tree(bypassing mm-tree?). Whereas below work:
>
> mm: vmalloc: refactor vmalloc_dump_obj() function
> mm: vmalloc: improve description of vmap node layer
> mm: vmalloc: add a shrinker to drain vmap pools
> mm: vmalloc: set nr_nodes based on CPUs in a system
> mm: vmalloc: support multiple nodes in vmallocinfo
> mm: vmalloc: support multiple nodes in vread_iter
> mm: vmalloc: add a scan area of VA only once
> mm: vmalloc: offload free_vmap_area_lock lock
> mm: vmalloc: remove global purge_vmap_area_root rb-tree
> mm/vmalloc: remove vmap_area_list
> mm: vmalloc: remove global vmap_area_root rb-tree
> mm: vmalloc: move vmap_init_free_space() down in vmalloc.c
> mm: vmalloc: rename adjust_va_to_fit_type() function
> mm: vmalloc: add va_alloc() helper
>
> now should be based on Alexei Starovoitov base in order to resolve
> a small conflict.

Pls don't rebase anything.

> But you better know how to proceed. Just in case, if you need some
> support please let me know i can help with conflict resolving.

As Stephen said these two conflict:

> > >   8e1d743f2c26 ("mm: vmalloc: support multiple nodes in vmallocinfo")
> > >
> > >   e6f798225a31 ("mm: Introduce VM_SPARSE kind and vm_area_[un]map_pag=
es().")

and conflict is trivial. It just looks big due to the indent change.

