Return-Path: <linux-kernel+bounces-53866-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 218A584A769
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 22:32:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78C5D1F2A5AC
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 21:32:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A9C580BE8;
	Mon,  5 Feb 2024 19:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P7ilLlYC"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0DF80BE5
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 19:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707162470; cv=none; b=Ia2CqSAYPZVL706D1dwsdDodhEGz3bZzmP14RjmYJRgV1EFHI5U4+Ihpcwmbi8kf+mHcPe5Jo6O8v/QTXFjgU3hlUvn6YLT8+IgP8Y2iyrR/lLw2WKs8yNx3WgCN9EigGKNqahHrMfjsiXDF1aFspBAzYvx4KLuHT+PrU8D4eaM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707162470; c=relaxed/simple;
	bh=x1kUU12PBdGOi64ugvIL/Dagv+ULJJFda5wctexET7A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gMOyi5u8ifeX50omJ27TYmx17Bn2RFZ5bNcK0kT+AmIohO38mRQRbWUKJZ06XrLr+Oy3LibbWqa0zTr73Bmz40WLZjZ7pookM09QtssKG5GN8VknWnfG+IjPShL+l8BK61JXrRxGSd9BZHoErdjuteP8+8/45Bv6m1fxAHeAuI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P7ilLlYC; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-428405a0205so2681cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 11:47:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707162468; x=1707767268; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DajBnD5fipiVsk/3bOr2Yb4lyBEIu0IM/yG+o6HIkoE=;
        b=P7ilLlYC/sTGGrRhMqVw4hpEyu5mrC58s5msbdyVPbpWrkPEn1ai5VbYd3hDXYNEFX
         jh3r7TvLwoM/tT6GROWHWPfC4HDf4iNpEIPOYR0Vk22+Lp+CRjgOs9F+6HQBLXPKxrLK
         V2IKnR4NGGIRkbyo9B9R8Zj3lU72+W/FKY0Yn2erAgaWv4YZY7t0Orw+OuP1CMfMTSqa
         +Zmc7pqHARVDTb5fkkONvh9enN0eINisJ3YWxPkX6o6bN2sR+4MrjazRQFvEKrwciOFG
         NUk2YnE2WT9JrQNR7SNFwopnrpWBjPRXsxLCsEdmssnCQYTjN6yOJTVScb43cI7JRjrI
         tXzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707162468; x=1707767268;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DajBnD5fipiVsk/3bOr2Yb4lyBEIu0IM/yG+o6HIkoE=;
        b=GSSe0mbnxb83KtP6rS+VGj9sOlNODoN8aM1IT6FmIioM+oM82Yi9Qb16Nto45EAlJn
         MH+sSpYSVBNw03frsXIm155Hxp4z2PH8rPOd9FD632N9z4RezX/pnQsZ9QqMaEkVl3Fc
         33GQpfzUSgrveRw8nkhFZdh24K6Q1kiJM04WK6+TV2i0UNbxZZq4VnVHDiL/a1c42X4a
         fjcSFqvfJgaFoilHQGgz6hzZQckcKAJLsojT+Lh8R2AKdiRA6gKaAS3LGdd/VrcYXxiv
         +uwjUTxNKXlmzoxwN6/hyhB1EMsqjenMqAeDsP42NaB6HCZ0jKPxyU9Jc+iiyw/USg8c
         JZfg==
X-Gm-Message-State: AOJu0YxdCiiL0eAaJt2oF/mbS84OuIPzLg36ucxMorEsIFESMQb7CtAp
	mlPx/FGHCzvIab7jPXGDxXvO7ezxSaj7su/juGAxH1Tll07jy8R2MoXjb9F9hknsTcah9ghL4ay
	Zmek+xg9Jz6Y+mcQj5SiARfe1JiOkUAJEOqBNYG9NwjvgdpiVMyFd
X-Google-Smtp-Source: AGHT+IHjmRkCoUV1eDoxdgxxNnOBYAns/sW6lg7i3t+zXfXtt9vMPwnLJGciQqrg3kzrRBwb5xDX5eN0vhxnGnaqGY4=
X-Received: by 2002:ac8:5148:0:b0:42b:ff00:b789 with SMTP id
 h8-20020ac85148000000b0042bff00b789mr45226qtn.25.1707162467846; Mon, 05 Feb
 2024 11:47:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240202101326.876070-1-saravanak@google.com> <20240202101326.876070-2-saravanak@google.com>
 <20240205173626.GA3657127-robh@kernel.org>
In-Reply-To: <20240205173626.GA3657127-robh@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Mon, 5 Feb 2024 11:47:09 -0800
Message-ID: <CAGETcx-RhrhHJyXmG_37pQmJip9LwwasAv9jdSiEr-7_bweKrQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] of: property: Improve finding the consumer of a
 remote-endpoint property
To: Rob Herring <robh@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	kernel-team@android.com, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 9:36=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> On Fri, Feb 02, 2024 at 02:13:24AM -0800, Saravana Kannan wrote:
> > We have a more accurate function to find the right consumer of a
> > remote-endpoint property instead of searching for a parent with
> > compatible string property. So, use that instead. While at it, make the
> > code to find the consumer a bit more flexible and based on the property
> > being parsed.
> >
> > Fixes: f7514a663016 ("of: property: fw_devlink: Add support for remote-=
endpoint")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >  drivers/of/property.c | 52 +++++++++++++------------------------------
> >  1 file changed, 15 insertions(+), 37 deletions(-)
> >
> > diff --git a/drivers/of/property.c b/drivers/of/property.c
> > index 641a40cf5cf3..ba374a1f2072 100644
> > --- a/drivers/of/property.c
> > +++ b/drivers/of/property.c
> > @@ -1063,36 +1063,6 @@ of_fwnode_device_get_match_data(const struct fwn=
ode_handle *fwnode,
> >       return of_device_get_match_data(dev);
> >  }
> >
> > -static struct device_node *of_get_compat_node(struct device_node *np)
> > -{
> > -     of_node_get(np);
> > -
> > -     while (np) {
> > -             if (!of_device_is_available(np)) {
> > -                     of_node_put(np);
> > -                     np =3D NULL;
> > -             }
> > -
> > -             if (of_property_present(np, "compatible"))
> > -                     break;
> > -
> > -             np =3D of_get_next_parent(np);
> > -     }
> > -
> > -     return np;
> > -}
> > -
> > -static struct device_node *of_get_compat_node_parent(struct device_nod=
e *np)
> > -{
> > -     struct device_node *parent, *node;
> > -
> > -     parent =3D of_get_parent(np);
> > -     node =3D of_get_compat_node(parent);
> > -     of_node_put(parent);
> > -
> > -     return node;
> > -}
> > -
> >  static void of_link_to_phandle(struct device_node *con_np,
> >                             struct device_node *sup_np)
> >  {
> > @@ -1222,10 +1192,10 @@ static struct device_node *parse_##fname(struct=
 device_node *np,           \
> >   *  parse_prop.prop_name: Name of property holding a phandle value
> >   *  parse_prop.index: For properties holding a list of phandles, this =
is the
> >   *                 index into the list
> > + * @get_con_dev: If the consumer node containing the property is never=
 converted
> > + *            to a struct device, implement this ops so fw_devlink can=
 use it
> > + *            to find the true consumer.
> >   * @optional: Describes whether a supplier is mandatory or not
> > - * @node_not_dev: The consumer node containing the property is never c=
onverted
> > - *             to a struct device. Instead, parse ancestor nodes for t=
he
> > - *             compatible property to find a node corresponding to a d=
evice.
> >   *
> >   * Returns:
> >   * parse_prop() return values are
> > @@ -1236,8 +1206,8 @@ static struct device_node *parse_##fname(struct d=
evice_node *np,             \
> >  struct supplier_bindings {
> >       struct device_node *(*parse_prop)(struct device_node *np,
> >                                         const char *prop_name, int inde=
x);
> > +     struct device_node *(*get_con_dev)(struct device_node *np);
> >       bool optional;
> > -     bool node_not_dev;
> >  };
> >
> >  DEFINE_SIMPLE_PROP(clocks, "clocks", "#clock-cells")
> > @@ -1328,6 +1298,11 @@ static struct device_node *parse_interrupts(stru=
ct device_node *np,
> >       return of_irq_parse_one(np, index, &sup_args) ? NULL : sup_args.n=
p;
> >  }
> >
> > +static struct device_node *get_remote_endpoint_dev(struct device_node =
*np)
> > +{
> > +     return to_of_node(fwnode_graph_get_port_parent(of_fwnode_handle(n=
p)));
>
> DT APIs shouldn't depend on fwnode APIs.

I get what you are saying, but is it an API though? It's a static
internal function that's eventually used by .add_link to add fwnode
links. Would it be better if I rolled this into two separate inline
code where this function is getting called from? I'm trying to avoid
duplicating the function that's already present in
fwnode_graph_get_port_parent(), but it also feels too specific an op
to introduce into drivers/of/property.c

How would you like me to handle this? I don't see a good option.

> Otherwise, this series looks good.

Thanks,
Saravana

