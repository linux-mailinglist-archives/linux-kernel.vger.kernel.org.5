Return-Path: <linux-kernel+bounces-132253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6B9899210
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:22:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE381F22EAB
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB4F713C666;
	Thu,  4 Apr 2024 23:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="rwEV9ply"
Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E4413C66C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272948; cv=none; b=fMfXTNoC1K4TC2hYelubu5UMbKz7lGRTF207m4CS0h1C5tcPd6uMak+Cq17gVBN8CS2FYFfd9q1Ds29CSDIKDW++N/58mKP/SNCX2hiWE4V5vY9ycKOXuSB0Kvg42tH8bRCAUgLfnB0MF0nfBkukkaAYB1l5Kyqu7U790PHi/TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272948; c=relaxed/simple;
	bh=81ilPwRHHK1IaiPmLVjOOLAFqykOjd5u5odwMh7gDRc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SQy61oz0FVjXNi1mim2U5rJ0V2uvAd4Hs9LBwM1kSmVWAG0w9SbRRKj7A28YYYvOpZOq37rWg8XM+nSFS+AnTdGkIACZkqfX1eMp713ptgRS3bqjf3NezRh9QBDQkAU2dp742Yya2wa0DQqFRi1sB3DjvPpZn0gxNUh2VEr3ASM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=rwEV9ply; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-432d55b0fa9so80661cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 16:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712272944; x=1712877744; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtS12Qj1Fa9azv5kdA0F+Ff3Z/GmFUw8QGuiTRSom+g=;
        b=rwEV9plydU+9exw3yhHWUGotCRpaHAgguJuxhzHK5JfXjF461k3S96hjbOs0eCihfL
         8Eh3GvNzCSs+jMmSgBXvm7qC4IDXpHaQ2VfvoICV0GgY5zF36SYuZKol0n/ZXsbsok4a
         +Ou7XxR72T8rFcpUGbyPIo9IWruMyfbM41vHHdTrDFRRJvBDN5x4KdNLDZjSU3m3RWLY
         bKW9tcjebsfypS7I8pfy2jql/65fbbz3oigYyBdrA1wUYrfoEWFVgbUTV0dqpV+KdhzL
         LdXauWkrvJwZWOh9wcLPyzv++N4T78P38LRB9dTSwkq9GsbPpbttdH8/BmL1aJPVIW13
         jacw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712272944; x=1712877744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtS12Qj1Fa9azv5kdA0F+Ff3Z/GmFUw8QGuiTRSom+g=;
        b=lB5uwHhWVhkKAh/9ow1Lg/myrgPhs0IzD5afFBVtCFQrkDbiGa22wU2jIXa+76ASBl
         IlXDKk3gbxsj8clG4f1VHaiO/gUClsrDeUs54L3QQfuYIyT7A9IVMztFcLMUZyZlnpvr
         0tGuB+Vq3Mi35Q0ai5sxmaqbIinhDE0vrsVnT9RMt8QEEpy8Ae10jkA6HH8lMYployeC
         jwImK2elGLG2FTKVgQagrfaGJUfTkX6biLFvYmJkR5E7olJQv0gpmQuVsgL5feuUpxGz
         ayYATQi0RzgmoWecNJzrTAM7osz/RDYEslgXoaqL9jwfmPZ9Tdtz/4nUsvJfN/xm6zKz
         Z0dQ==
X-Forwarded-Encrypted: i=1; AJvYcCULZFwF02ZRp/j/4o1a+3zlgdZkkHNtuuC7bbOQuABbZmARWj3zQbu/bOgFMzLLbIMLZ+VmLx6BLma0B31mc1MCBfxHqOE7oVrKSy3x
X-Gm-Message-State: AOJu0Yy98r/DgAxoKBtmG2+52ztagratNta8PuvgJTVNqT+jQcFVILjI
	EOW18zb6KaiCrZPHTVcMlsZxjEaykr4mXvwQcArzacnrVhJxrR8GfnLO4vPFLS2uf/ZAJUhu28U
	ErIldv1BMK/ZDZNL2KMYU1gXolZNEXXB5cMkd
X-Google-Smtp-Source: AGHT+IG0sgGZIj2htPldvG95/uB+tjM3KKT4R4j2B00eDqc01S9L6qPaprvf/br39MAJwLD3v8LpQI3D59XvAjrvpDI=
X-Received: by 2002:a05:622a:1dc8:b0:434:47a9:95dd with SMTP id
 bn8-20020a05622a1dc800b0043447a995ddmr326963qtb.1.1712272944319; Thu, 04 Apr
 2024 16:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org> <20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org>
In-Reply-To: <20240404-dt-cleanup-free-v1-3-c60e6cba8da9@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 4 Apr 2024 16:21:47 -0700
Message-ID: <CAGETcx8Wd5OsHWiGSASWkQQtof0D-ScwYsvq9hWizV3DFC27gA@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Use scope based of_node_put() cleanups
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> Use the relatively new scope based of_node_put() cleanup to simplify
> function exit handling. Doing so reduces the chances of forgetting an
> of_node_put() and simplifies error paths by avoiding the need for goto
> statements.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/address.c  | 60 ++++++++++++++++-----------------------------=
------
>  drivers/of/property.c | 22 ++++++-------------
>  2 files changed, 26 insertions(+), 56 deletions(-)
>
> diff --git a/drivers/of/address.c b/drivers/of/address.c
> index ae46a3605904..f7b2d535a6d1 100644
> --- a/drivers/of/address.c
> +++ b/drivers/of/address.c
> @@ -491,7 +491,6 @@ static u64 __of_translate_address(struct device_node =
*dev,
>                                   const __be32 *in_addr, const char *rpro=
p,
>                                   struct device_node **host)
>  {
> -       struct device_node *parent =3D NULL;
>         struct of_bus *bus, *pbus;
>         __be32 addr[OF_MAX_ADDR_CELLS];
>         int na, ns, pna, pns;
> @@ -504,7 +503,7 @@ static u64 __of_translate_address(struct device_node =
*dev,
>
>         *host =3D NULL;
>         /* Get parent & match bus type */
> -       parent =3D get_parent(dev);
> +       struct device_node *parent __free(device_node) =3D get_parent(dev=
);

Can we leave the variable definition where it was? We generally define
all the variables up top. So, defining the one variable in the middle
feels weird. I at least get when we do this inside for/if blocks. But
randomly in the middle feels weird.

Similar comments in other places. Since both kfree() and of_put() can
both handle NULL pointers, I'd be surprised if we HAVE to combine
these lines.

Not a very strong position, but I'd rather we didn't. So,

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

>         if (parent =3D=3D NULL)
>                 goto bail;
>         bus =3D of_match_bus(parent);
> @@ -573,7 +572,6 @@ static u64 __of_translate_address(struct device_node =
*dev,
>                 of_dump_addr("one level translation:", addr, na);
>         }
>   bail:
> -       of_node_put(parent);
>         of_node_put(dev);
>
>         return result;
> @@ -654,19 +652,16 @@ EXPORT_SYMBOL(of_translate_dma_address);
>  const __be32 *of_translate_dma_region(struct device_node *dev, const __b=
e32 *prop,
>                                       phys_addr_t *start, size_t *length)
>  {
> -       struct device_node *parent;
> +       struct device_node *parent __free(device_node) =3D __of_get_dma_p=
arent(dev);
>         u64 address, size;
>         int na, ns;
>
> -       parent =3D __of_get_dma_parent(dev);
>         if (!parent)
>                 return NULL;
>
>         na =3D of_bus_n_addr_cells(parent);
>         ns =3D of_bus_n_size_cells(parent);
>
> -       of_node_put(parent);
> -
>         address =3D of_translate_dma_address(dev, prop);
>         if (address =3D=3D OF_BAD_ADDR)
>                 return NULL;
> @@ -688,21 +683,19 @@ const __be32 *__of_get_address(struct device_node *=
dev, int index, int bar_no,
>  {
>         const __be32 *prop;
>         unsigned int psize;
> -       struct device_node *parent;
> +       struct device_node *parent __free(device_node) =3D of_get_parent(=
dev);
>         struct of_bus *bus;
>         int onesize, i, na, ns;
>
> -       /* Get parent & match bus type */
> -       parent =3D of_get_parent(dev);
>         if (parent =3D=3D NULL)
>                 return NULL;
> +
> +       /* match the parent's bus type */
>         bus =3D of_match_bus(parent);
> -       if (strcmp(bus->name, "pci") && (bar_no >=3D 0)) {
> -               of_node_put(parent);
> +       if (strcmp(bus->name, "pci") && (bar_no >=3D 0))
>                 return NULL;
> -       }
> +
>         bus->count_cells(dev, &na, &ns);
> -       of_node_put(parent);
>         if (!OF_CHECK_ADDR_COUNT(na))
>                 return NULL;
>
> @@ -888,14 +881,13 @@ static u64 of_translate_ioport(struct device_node *=
dev, const __be32 *in_addr,
>   */
>  int of_dma_get_range(struct device_node *np, const struct bus_dma_region=
 **map)
>  {
> -       struct device_node *node =3D of_node_get(np);
> +       struct device_node *node __free(device_node) =3D of_node_get(np);
>         const __be32 *ranges =3D NULL;
>         bool found_dma_ranges =3D false;
>         struct of_range_parser parser;
>         struct of_range range;
>         struct bus_dma_region *r;
>         int len, num_ranges =3D 0;
> -       int ret =3D 0;
>
>         while (node) {
>                 ranges =3D of_get_property(node, "dma-ranges", &len);
> @@ -905,10 +897,9 @@ int of_dma_get_range(struct device_node *np, const s=
truct bus_dma_region **map)
>                         break;
>
>                 /* Once we find 'dma-ranges', then a missing one is an er=
ror */
> -               if (found_dma_ranges && !ranges) {
> -                       ret =3D -ENODEV;
> -                       goto out;
> -               }
> +               if (found_dma_ranges && !ranges)
> +                       return -ENODEV;
> +
>                 found_dma_ranges =3D true;
>
>                 node =3D of_get_next_dma_parent(node);
> @@ -916,10 +907,8 @@ int of_dma_get_range(struct device_node *np, const s=
truct bus_dma_region **map)
>
>         if (!node || !ranges) {
>                 pr_debug("no dma-ranges found for node(%pOF)\n", np);
> -               ret =3D -ENODEV;
> -               goto out;
> +               return -ENODEV;
>         }
> -
>         of_dma_range_parser_init(&parser, node);
>         for_each_of_range(&parser, &range) {
>                 if (range.cpu_addr =3D=3D OF_BAD_ADDR) {
> @@ -930,16 +919,12 @@ int of_dma_get_range(struct device_node *np, const =
struct bus_dma_region **map)
>                 num_ranges++;
>         }
>
> -       if (!num_ranges) {
> -               ret =3D -EINVAL;
> -               goto out;
> -       }
> +       if (!num_ranges)
> +               return -EINVAL;
>
>         r =3D kcalloc(num_ranges + 1, sizeof(*r), GFP_KERNEL);
> -       if (!r) {
> -               ret =3D -ENOMEM;
> -               goto out;
> -       }
> +       if (!r)
> +               return -ENOMEM;
>
>         /*
>          * Record all info in the generic DMA ranges array for struct dev=
ice,
> @@ -957,9 +942,7 @@ int of_dma_get_range(struct device_node *np, const st=
ruct bus_dma_region **map)
>                 r->size =3D range.size;
>                 r++;
>         }
> -out:
> -       of_node_put(node);
> -       return ret;
> +       return 0;
>  }
>  #endif /* CONFIG_HAS_DMA */
>
> @@ -1016,11 +999,9 @@ phys_addr_t __init of_dma_get_max_cpu_address(struc=
t device_node *np)
>   */
>  bool of_dma_is_coherent(struct device_node *np)
>  {
> -       struct device_node *node;
> +       struct device_node *node __free(device_node) =3D of_node_get(np);
>         bool is_coherent =3D dma_default_coherent;
>
> -       node =3D of_node_get(np);
> -
>         while (node) {
>                 if (of_property_read_bool(node, "dma-coherent")) {
>                         is_coherent =3D true;
> @@ -1032,7 +1013,6 @@ bool of_dma_is_coherent(struct device_node *np)
>                 }
>                 node =3D of_get_next_dma_parent(node);
>         }
> -       of_node_put(node);
>         return is_coherent;
>  }
>  EXPORT_SYMBOL_GPL(of_dma_is_coherent);
> @@ -1049,19 +1029,17 @@ EXPORT_SYMBOL_GPL(of_dma_is_coherent);
>   */
>  static bool of_mmio_is_nonposted(struct device_node *np)
>  {
> -       struct device_node *parent;
>         bool nonposted;
>
>         if (!IS_ENABLED(CONFIG_ARCH_APPLE))
>                 return false;
>
> -       parent =3D of_get_parent(np);
> +       struct device_node *parent __free(device_node) =3D of_get_parent(=
np);
>         if (!parent)
>                 return false;
>
>         nonposted =3D of_property_read_bool(parent, "nonposted-mmio");
>
> -       of_node_put(parent);
>         return nonposted;
>  }
>
> diff --git a/drivers/of/property.c b/drivers/of/property.c
> index a6358ee99b74..b73daf81c99d 100644
> --- a/drivers/of/property.c
> +++ b/drivers/of/property.c
> @@ -40,15 +40,12 @@
>   */
>  bool of_graph_is_present(const struct device_node *node)
>  {
> -       struct device_node *ports, *port;
> +       struct device_node *ports __free(device_node) =3D of_get_child_by=
_name(node, "ports");
>
> -       ports =3D of_get_child_by_name(node, "ports");
>         if (ports)
>                 node =3D ports;
>
> -       port =3D of_get_child_by_name(node, "port");
> -       of_node_put(ports);
> -       of_node_put(port);
> +       struct device_node *port __free(device_node) =3D of_get_child_by_=
name(node, "port");
>
>         return !!port;
>  }
> @@ -610,9 +607,9 @@ EXPORT_SYMBOL(of_graph_parse_endpoint);
>   */
>  struct device_node *of_graph_get_port_by_id(struct device_node *parent, =
u32 id)
>  {
> -       struct device_node *node, *port;
> +       struct device_node *port;
> +       struct device_node *node __free(device_node) =3D of_get_child_by_=
name(parent, "ports");
>
> -       node =3D of_get_child_by_name(parent, "ports");
>         if (node)
>                 parent =3D node;
>
> @@ -626,8 +623,6 @@ struct device_node *of_graph_get_port_by_id(struct de=
vice_node *parent, u32 id)
>                         break;
>         }
>
> -       of_node_put(node);
> -
>         return port;
>  }
>  EXPORT_SYMBOL(of_graph_get_port_by_id);
> @@ -655,14 +650,13 @@ struct device_node *of_graph_get_next_endpoint(cons=
t struct device_node *parent,
>          * parent port node.
>          */
>         if (!prev) {
> -               struct device_node *node;
> +               struct device_node *node __free(device_node) =3D
> +                       of_get_child_by_name(parent, "ports");
>
> -               node =3D of_get_child_by_name(parent, "ports");
>                 if (node)
>                         parent =3D node;
>
>                 port =3D of_get_child_by_name(parent, "port");
> -               of_node_put(node);
>
>                 if (!port) {
>                         pr_debug("graph: no port node found in %pOF\n", p=
arent);
> @@ -1052,15 +1046,13 @@ static int of_fwnode_graph_parse_endpoint(const s=
truct fwnode_handle *fwnode,
>                                           struct fwnode_endpoint *endpoin=
t)
>  {
>         const struct device_node *node =3D to_of_node(fwnode);
> -       struct device_node *port_node =3D of_get_parent(node);
> +       struct device_node *port_node __free(device_node) =3D of_get_pare=
nt(node);
>
>         endpoint->local_fwnode =3D fwnode;
>
>         of_property_read_u32(port_node, "reg", &endpoint->port);
>         of_property_read_u32(node, "reg", &endpoint->id);
>
> -       of_node_put(port_node);
> -
>         return 0;
>  }
>
>
> --
> 2.43.0
>

