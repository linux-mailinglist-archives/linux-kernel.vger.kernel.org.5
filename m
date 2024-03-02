Return-Path: <linux-kernel+bounces-89626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FB0C86F330
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 01:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 253151C20D3B
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 00:00:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 117FED26D;
	Sun,  3 Mar 2024 00:00:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VTwn+z2y"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC7864A19
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 00:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709424011; cv=none; b=sn0t934YY3B/pWCKxKcnpYqldwEgJKNXSwQyIZXswnmrFAysHbgLDNG93PzGiLZnnZSna+eKgA1aDkSs4Rx5VmB2J3is0c///dFA23KwVBl9/q6fg1skfdkADTjC1FReSQ/GopzIK9942NKDRO4eTPzcDMvWF4VUCZpX2slkKek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709424011; c=relaxed/simple;
	bh=J6lqD5tPBpfsKE9gR0kW41bi8JlBl/s/g4TtD6cOmJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I2kkkJFcT+dcrsQuKmKQvmiWStrXRPH03ZnFnSAHeqg4Fa9EQ4hh82N/5tJ53LX2VbpDxixTCzST7WkNjff2YUFJ4d/5aJoNiV20KhHPcD+pL9h5p/IJqbqft9pS9ORuKK4lnQk65t+Ke0suWlxbXOUBItDSBKQoSn2XxAoeqUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VTwn+z2y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1709424007;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oNn4AYHDxOyYCw1sWBQwABamqz8kdnNfjo/jO2yqNzo=;
	b=VTwn+z2yp8ZYyEwebcEiy2Yhd/A0Lg6F0jgLxFqIe/zBOCHdXTjLqNR7bp1WQ3xiSAt47j
	QbPeLZPIuJ+ZjUF2W+HF+W1H4HiLBxkLup1KIOYoi6Z0Hee5LGotBf2mgKHo7bRhR+24SZ
	EYuPVvRu1hLIYUqUXVTvvI4ZLm55ZM8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695--YSL0tcKOoS_cYmtm0Lu_g-1; Sat, 02 Mar 2024 19:00:06 -0500
X-MC-Unique: -YSL0tcKOoS_cYmtm0Lu_g-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7d302c6a708so2427354241.0
        for <linux-kernel@vger.kernel.org>; Sat, 02 Mar 2024 16:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709424005; x=1710028805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oNn4AYHDxOyYCw1sWBQwABamqz8kdnNfjo/jO2yqNzo=;
        b=e7Q6AFRDFNM7CXbukSe8+fjDJjBQLtK41YLxS9+RjMC3N45lMqU1oFWN9mEbx9Dx4F
         gCs7BU7TNZ4zf+QjJ1lTsjMMFvLIShzq+XiYLggPVDtPNqAAoUZOIS/cn058fj0bKNCu
         a+POI5/5caKpzuxVB7Hi2oHScwkknt6mjKYLKT0kocfXGKxIZ5bitZbZEYTkqS6ifm0v
         mADTXnq5Dsfjvic8JZt7eD/67Y7x332OiknmqWVIRii8DhLTnQiGOpyvnXyn1c9qVgOZ
         /P6E2VHz0HCQuHomoNXBdOoVxGKBMKnt/RLw+M9YCl8JMdIlqrPn32lAQRjXvCBj5etD
         Cb4w==
X-Gm-Message-State: AOJu0YzvDdQTsT3sEQGqJhU/3URbVrM1JHfnUNNmAUPXuu+KURf0m+du
	aaFIgPZSmpdaLu46dmlt0twdRdzcJVYInX8HH79bVKHXWvhp/nJ+E+oNE6JnVihcQ2Spd+YJWx0
	G+kGHtz7nGyFClCl69ehoutd5ZAZYS40R0ZG4HtWtAsiXy/GwIUFse5tZ6U8SFSfH7UZTpgRkl3
	YPfnxQQWwsnnIVe64a67MnuWb35UKQwbK45OfS
X-Received: by 2002:a05:6102:2e6:b0:472:7619:1a63 with SMTP id j6-20020a05610202e600b0047276191a63mr3804555vsj.35.1709424005599;
        Sat, 02 Mar 2024 16:00:05 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFByXUW6H7RopND/l/85n7vhh3nESgMcc0/78odRPIE36Mxfh25xt5RnW/nCFHDtnaXb5pilZ920//jFoIFzNY=
X-Received: by 2002:a05:6102:2e6:b0:472:7619:1a63 with SMTP id
 j6-20020a05610202e600b0047276191a63mr3804545vsj.35.1709424005271; Sat, 02 Mar
 2024 16:00:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301203023.2197451-1-jsavitz@redhat.com> <87cysdfsef.fsf@mail.lhotse>
In-Reply-To: <87cysdfsef.fsf@mail.lhotse>
From: Joel Savitz <jsavitz@redhat.com>
Date: Sat, 2 Mar 2024 18:59:49 -0500
Message-ID: <CAL1p7m7nHfLM=koNaFZ0MrrcC6Lyj3VWdC9i8rOWGmrijKR3+Q@mail.gmail.com>
Subject: Re: [PATCH] powerpc: align memory_limit to 16MB in early_parse_mem
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-kernel@vger.kernel.org, Nicholas Piggin <npiggin@gmail.com>, 
	Christophe Leroy <christophe.leroy@csgroup.eu>, "Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, 
	"Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Benjamin Gray <bgray@linux.ibm.com>, 
	Paul Mackerras <paulus@ozlabs.org>, linuxppc-dev@lists.ozlabs.org, 
	Gonzalo Siero <gsierohu@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 6:23=E2=80=AFPM Michael Ellerman <mpe@ellerman.id.au=
> wrote:
>
> Hi Joel,
>
> Joel Savitz <jsavitz@redhat.com> writes:
> > On 64-bit powerpc, usage of a non-16MB-aligned value for the mem=3D ker=
nel
> > cmdline parameter results in a system hang at boot.
>
> Can you give us any more details on that? It might be a bug we can fix.

The console freezes after the following output:

  Booting a command list

OF stdout device is: /vdevice/vty@30000000
Preparing to boot Linux version 6.8.0-rc6.memNOfix-00120-g87adedeba51a
(root@ibm-p9z-26-lp11.virt.pnr.lab.eng.rdu2.redhat.com) (gcc (GCC)
11.4.1 20231218 (Red Hat 11.4.1-3), GNU ld version 2.35.2-43.el9) #3
SMP Fri Mar  1 10:45:45 EST 2024
Detected machine type: 0000000000000101
command line: BOOT_IMAGE=3D(ieee1275//vdevice/v-scsi@30000003/disk@81000000=
00000000,msdos2)/vmlinuz-6.8.0-rc6.memNOfix-00120-g87adedeba51a
root=3D/dev/mapper/rhel_ibm--p9z--26--lp11-root ro
crashkernel=3D2G-4G:384M,4G-16G:512M,16G-64G:1G,64G-128G:2G,128G-:4G
rd.lvm.lv=3Drhel_ibm-p9z-26-lp11/root
rd.lvm.lv=3Drhel_ibm-p9z-26-lp11/swap mem=3D4198400K
Max number of cores passed to firmware: 256 (NR_CPUS =3D 2048)
Calling ibm,client-architecture-support... done
Ignoring mem=3D0000000101000000 >=3D ram_top.
memory layout at init:
  memory_limit : 0000000000000000 (16 MB aligned)
  alloc_bottom : 00000000114f0000
  alloc_top    : 0000000020000000
  alloc_top_hi : 0000000020000000
  rmo_top      : 0000000020000000
  ram_top      : 0000000020000000
instantiating rtas at 0x000000001ecb0000... done
prom_hold_cpus: skipped
copying OF device tree...
Building dt strings...
Building dt structure...
Device tree strings 0x0000000011500000 -> 0x00000000115017b7
Device tree struct  0x0000000011510000 -> 0x0000000011520000
Quiescing Open Firmware ...
Booting Linux via __start() @ 0x000000000a6e0000 ...

>
> > For example, using 'mem=3D4198400K' will always reproduce this issue.
> >
> > This patch fixes the problem by aligning any argument to mem=3D to 16MB
> > corresponding with the large page size on powerpc.
>
> The large page size depends on the MMU, with Radix it's 2MB or 1GB. So
> depending on what's happening 16MB may not be enough.
>
> What system are you testing on?

I'm running a virtual system in PowerVM on an IBM Z mainframe, 8375-42A mod=
el.

Best,
Joel Savitz

>
> cheers
>
> > Fixes: 2babf5c2ec2f ("[PATCH] powerpc: Unify mem=3D handling")
> > Co-developed-by: Gonzalo Siero <gsierohu@redhat.com>
> > Signed-off-by: Gonzalo Siero <gsierohu@redhat.com>
> > Signed-off-by: Joel Savitz <jsavitz@redhat.com>
> > ---
> >  arch/powerpc/kernel/prom.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/arch/powerpc/kernel/prom.c b/arch/powerpc/kernel/prom.c
> > index 0b5878c3125b..8cd3e2445d8a 100644
> > --- a/arch/powerpc/kernel/prom.c
> > +++ b/arch/powerpc/kernel/prom.c
> > @@ -82,8 +82,12 @@ static int __init early_parse_mem(char *p)
> >  {
> >       if (!p)
> >               return 1;
> > -
> > +#ifdef CONFIG_PPC64
> > +     /* Align to 16 MB =3D=3D size of ppc64 large page */
> > +     memory_limit =3D ALIGN(memparse(p, &p), 0x1000000);
> > +#else
> >       memory_limit =3D PAGE_ALIGN(memparse(p, &p));
> > +#endif
> >       DBG("memory limit =3D 0x%llx\n", memory_limit);
> >
> >       return 0;
> > --
> > 2.43.0
>


