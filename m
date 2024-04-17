Return-Path: <linux-kernel+bounces-147813-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA3D78A79FF
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 03:04:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCA8EB22BC8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 01:04:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5791851;
	Wed, 17 Apr 2024 01:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ONrEkfVJ"
Received: from mail-qt1-f182.google.com (mail-qt1-f182.google.com [209.85.160.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F9E117C2
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 01:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713315844; cv=none; b=Cvqk3aoBhYEPPVDIGNNnLrssSYgABL5+LchRKdIfHCakMwRVrwL55aj2U6qJ8yyeYRSE8BEm0+PXbByO8OPJ1TynA0t26Hd3ho/C+gouSWW0M5cB7p5605iZQwU2zHO/X+QIfBD29vWsD6cxdWNmf1rpeGwxZjcNTdEwRrRaWe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713315844; c=relaxed/simple;
	bh=ApJLZ2EuaU+5tyeB65wbduCgQyBQGakeHaRYXMUkuU0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gHgFQw5/FZhTzUl9e2ncZdB+0h20JCT2ip5qHMYjWBNeAd0ZZcQdO7KIELUXROvdDnnZeXbf7W2tHZ7lMg+hyDv5/y9/xr5gcTNAqXqqQn1M14wtR7UnLZ0Da5n/0zw2wu8U2hJAk/GHFGe0Bo9be6VIR6Zo8nRU25ctKLj08oQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ONrEkfVJ; arc=none smtp.client-ip=209.85.160.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f182.google.com with SMTP id d75a77b69052e-436ed871225so94581cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 18:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713315841; x=1713920641; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DkfTVjPD3XwT0FdLWkEiWLmQxyUXEV4QDw4WnoToh/k=;
        b=ONrEkfVJsSHuOoz41uP4AJ1LsbjkIzLAFsFZgIxvzA65rCcL3uWp632j+MQ7vZP/IE
         XtKhizcNajm8fssiwTqVuydbPuKsAwU/C8Lql0WxCV691O9yTPOT08VD1bxrWwSrePNm
         tnYtjJmQXHZx+psTvYvSlK91qH+pTYjnIxj0Pv3acuiGwIed1GT1CudR9eZLY91P9CI3
         +I830fDVKGecb3qcwsHasmfxJLd7RJq71kJoiGuIFz1QY//sunAst7t5DTqAVIXI9iqh
         cg8EXZiKmSeRiyezV42XQAZLY9uAkGAL+B95yryGbntTq0KaU81KDfsAL6tDBr/MabUD
         Jnzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713315841; x=1713920641;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DkfTVjPD3XwT0FdLWkEiWLmQxyUXEV4QDw4WnoToh/k=;
        b=DbhvaNnteELP9LZNnqbu1cS/P5pzxKAx6IQEX9a78POaIwpx7ZalYSD4GRDsVi3qdf
         8QxvBp3Q2vj5KuJ0eo9ql5VT8R3S42hrgDEw/7gt3gdheWcjoNmR/8LdOUEKrlh3FWxp
         6ZI6XqAGaWlPR0bMQD1Bg8r5SSZ5sumlv6kc18ijA5MrULi0JWxeLSQWyZe5R+TiP9FN
         YW+2vTuX58egTFGo2cxUjTt5SafF0axh01s+omWqyW76e3b4J9Fd3dqGDc0d1uWcAn3d
         5lsKvdf9BEAebq7otx2upuwioEZBqD/DnVX0i9r3gw+/w3SjxkD9kiChdMCpXMbaP1zk
         7DyQ==
X-Forwarded-Encrypted: i=1; AJvYcCU9GpI1CvmsRrELsZfkMVV8JnHuZSuFr4OuGls7CnghccVIs/zd6+fg4/dPD3Ay8ViMNqJzJhlR+CGUMiIsqkSbuFM6/nQzs9BXIeuU
X-Gm-Message-State: AOJu0Yx3hTnZsYzm5AXvoj6aikyqv/F0F9lB+x+mVzL0irl/qQ350yP6
	ISz79SG+O4s789JARQEy4vM2VwxziRjeOaOdqcC1mvECGtyCPc6ZdYWjAhO5d1chRx6P4ZclGGS
	Epweb7L1NuGy4rANjRI6h27kD1sLa0hHNmnmU
X-Google-Smtp-Source: AGHT+IFf/DbEiUMrNE3+3h0tNx17EZOn9EV/2/1uYIxpd1cVsA33zTZAoAPdkuvZ4k9AuW9caLh6SDxCdS61jKH0I7c=
X-Received: by 2002:ac8:580c:0:b0:436:9f37:f5e4 with SMTP id
 g12-20020ac8580c000000b004369f37f5e4mr144572qtg.8.1713315837611; Tue, 16 Apr
 2024 18:03:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240413091942.316054-1-apatel@ventanamicro.com> <20240416141049.GA2148267-robh@kernel.org>
In-Reply-To: <20240416141049.GA2148267-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 16 Apr 2024 18:03:17 -0700
Message-ID: <CAGETcx_Ni3MjwVHDOdre1nSqQP07=gaUtCDj31ndKcMFtm+xjg@mail.gmail.com>
Subject: Re: [PATCH v2] of: property: Add fw_devlink support for interrupt-map property
To: Rob Herring <robh@kernel.org>
Cc: Anup Patel <apatel@ventanamicro.com>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Paul Walmsley <paul.walmsley@sifive.com>, Atish Patra <atishp@atishpatra.org>, 
	Andrew Jones <ajones@ventanamicro.com>, Sunil V L <sunilvl@ventanamicro.com>, 
	Anup Patel <anup@brainfault.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2024 at 7:11=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Sat, Apr 13, 2024 at 02:49:42PM +0530, Anup Patel wrote:
> > Some of the PCI controllers (such as generic PCI host controller)
> > use "interrupt-map" DT property to describe the mapping between
> > PCI endpoints and PCI interrupt pins. This the only case where
> > the interrupts are not described in DT.
> >
> > Currently, there is no fw_devlink created based on "interrupt-map"
> > DT property

parse_interrupts() calls of_irq_parse_one() that in turn calls
of_irq_parse_one() that does the "interrupts-map" handling. In fact
of_irq_parse_pci() also calls of_irq_parse_one() if the PCI device has
a DT node. So I don't think any new functionality needs to be added.
If I'm not mistaken we just need parse_interrupts to not ignore
interrupts-map? A one line change?

Why do we need all of this code you wrote below?

-Saravana

> >  so interrupt controller is not guaranteed to be probed
> > before PCI host controller. This affects every platform where both
> > PCI host controller and interrupt controllers are probed as regular
> > platform devices.
> >
> > This creates fw_devlink between consumers (PCI host controller) and
> > supplier (interrupt controller) based on "interrupt-map" DT property.
> >
> > Signed-off-by: Anup Patel <apatel@ventanamicro.com>
> > ---
> > Changes since v1:
> > - Updated commit description based on Rob's suggestion
> > - Use of_irq_parse_raw() for parsing interrupt-map DT property
> > ---
> >  drivers/of/property.c | 58 +++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 58 insertions(+)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index a6358ee99b74..67be66384dac 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1311,6 +1311,63 @@ static struct device_node *parse_interrupts(stru=
ct device_node *np,
> >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.n=
p;
> >  }
> >
> > +static struct device_node *parse_interrupt_map(struct device_node *np,
> > +                                            const char *prop_name, int=
 index)
> > +{
> > +     const __be32 *imap, *imap_end, *addr;
> > +     struct of_phandle_args sup_args;
> > +     struct device_node *tn, *ipar;
> > +     u32 addrcells, intcells;
> > +     int i, j, imaplen;
> > +
> > +     if (!IS_ENABLED(CONFIG_OF_IRQ))
> > +             return NULL;
> > +
> > +     if (strcmp(prop_name, "interrupt-map"))
> > +             return NULL;
> > +
> > +     ipar =3D of_node_get(np);
> > +     do {
> > +             if (!of_property_read_u32(ipar, "#interrupt-cells", &intc=
ells))
> > +                     break;
> > +             tn =3D ipar;
> > +             ipar =3D of_irq_find_parent(ipar);
> > +             of_node_put(tn);
> > +     } while (ipar);
>
> No need for this loop. We've only gotten here if 'interrupt-map' is
> present in the node and '#interrupt-cells' is required if
> 'interrupt-map' is present.
>
> > +     if (!ipar)
> > +             return NULL;
> > +     addrcells =3D of_bus_n_addr_cells(ipar);
> > +     of_node_put(ipar);
> > +
> > +     imap =3D of_get_property(np, "interrupt-map", &imaplen);
> > +     if (!imap || imaplen <=3D (addrcells + intcells))
> > +             return NULL;
> > +     imap_end =3D imap + imaplen;
> > +
> > +     sup_args.np =3D NULL;
> > +     for (i =3D 0; i <=3D index && imap < imap_end; i++) {
> > +             if (sup_args.np) {
> > +                     of_node_put(sup_args.np);
> > +                     sup_args.np =3D NULL;
> > +             }
> > +
> > +             addr =3D imap;
> > +             imap +=3D addrcells;
> > +
> > +             sup_args.np =3D np;
> > +             sup_args.args_count =3D intcells;
> > +             for (j =3D 0; j < intcells; j++)
> > +                     sup_args.args[j] =3D be32_to_cpu(imap[j]);
> > +             imap +=3D intcells;
> > +
> > +             if (of_irq_parse_raw(addr, &sup_args))
> > +                     return NULL;
> > +             imap +=3D sup_args.args_count + 1;
> > +     }
>
> Doesn't this leak a ref on the last time the function is invoked? For
> example, if we have 2 entries and index is 2. We'll get index=3D1, but
> then exit because imap=3D=3Dimap_end. We need a put on index=3D=3D1 node.
>
> Look at my next branch where I've converted things to use __free()
> cleanups. I don't see it helping here as-is, but maybe when it is
> correct.
>
> Rob

