Return-Path: <linux-kernel+bounces-73935-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA1285CDBC
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 03:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9698A1F25DC5
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A86566A;
	Wed, 21 Feb 2024 02:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HY0K8rZ1"
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A57BD4432
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 02:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708481377; cv=none; b=n6sGWz6rplfTpK5/E9l+b0jwWWAUyjiCo6qElbTM0l3eJl3BOGqICrob5jb1bbiY3oZYOol4hwczg89oGi+WXGGcHvgFLrYKovq/Bn79f0SEd7r/oJKANT/ddz01GZy9QR2VrhZdYNxLGeUf4vqqcuDD+1YbwRPlC09B2o6BKtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708481377; c=relaxed/simple;
	bh=szYKJrGmDp93JCS78nmQ3szqAsbuBjTO7gxM7SgdWmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CnLAviv0Mo4NxV90oxUNn12+y2dUgZRoU0Mogo1Mm6vltgknro7Z5FnbLOFyrDctG2STDhmoGAkKPnkQ57dbVODr8f8WlLyAnPcT43iYFwsVYKA5MIYVH6hR4hVgHy1jQT59793AyDsPYbEHzCPRu8aI69UBw8wChQ7+Gh4Vz38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=HY0K8rZ1; arc=none smtp.client-ip=209.85.160.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-42e2507c6e1so76091cf.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 18:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708481374; x=1709086174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b1VM94YAF3zp4otk2Hvp6TAgshqoTETLzdYzzpGhRoQ=;
        b=HY0K8rZ16BKUCkNrGRh25BQfCw/ungo8PB0CmJqjdvjJjHlZbphrZcC1Lq22TJX08r
         fmjTGLo3TxbXJPjjpWdTYXF/Me7Gs3dTbxHK1X4/lYXXJS3tyDH0Y8dbnjNhVx1SrVGy
         uxyCpVA/wiYk/4fF2vDZ+TiuIVmZc3kYmHA4EnMmDWiHAFTcrXmOj34zUbtqvLiICTbc
         jyLkmOzju8eYaO4mR+R/b77xbljtXTf82bi1UOW9NG11dC/OBa39Axo3TgcqcNANhZG5
         wVWuXEtpcUeeb8hcb5PgbR+GpDFUREHHLLXJ49tjlrJy4ofCgQ+u3N69oHbVCTc+Xt3u
         QMrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708481374; x=1709086174;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b1VM94YAF3zp4otk2Hvp6TAgshqoTETLzdYzzpGhRoQ=;
        b=iQY/uUaz5A0sGK8Z05zV6vMg0XLTyA28Ya476824MxCGKOE0MCV66w//mVCrPO4KvE
         +nasa6qdNPgFxFvNTUDNlP5CNum09sSpSP9LP1CYCIHjVuemENoTr0d0mTsSp6VKliYY
         2sHrRTqHfu4BHA565B/5yCJz536Pw6HGcjSc8PiCqZQAUNZoOOFpWD35Cc6wLtfsh79R
         0RUN+h4pc6n/5KM81vQb2Z5Y7GV/b3TZHAEY2b+LdpuZHbyW9fhyAbJZbcQ8VcZzd5eA
         ZRsO6kvq+8bVZhvIvs0ygXdPGbVF5olZBjtJsNZrNTK7tU9FYbxzt2/EfEHv0YI53s9u
         QbDw==
X-Forwarded-Encrypted: i=1; AJvYcCWIm2auye0446Dcn/npttlbZOlYi3iDP8YMAAakbXNIrKF667Fvxa2F5aAT99bKVbd1y+BgXfUxvuo0SbyJoYELqMb9GOoG9DHelrni
X-Gm-Message-State: AOJu0YwifwQSF5EhDH+PcJcUUhNrKqwiZN6e+6ZfmlHlOZmUugVhKubP
	kqhAoQozvMLBY9mWvjWNQ6b+b4dz7ae7TJwlaay1DeIjtBwz3ZAiLsYzO5Vp9eLZKgY4tbURfj0
	YPpPQMM83bSvqKcH6Tg8/j5Z2Re78zC3TmKB98cxnbvI/vnpgNgDq
X-Google-Smtp-Source: AGHT+IE4zvEttWNpeKE0T11pIYvLpTo0R5aTyHAaiaUj8r7KFCsvEi0g+mE8WZ8l+OXrqb7mhsiveLrF+6Sag++iVlY=
X-Received: by 2002:ac8:7643:0:b0:42e:1260:c4e6 with SMTP id
 i3-20020ac87643000000b0042e1260c4e6mr137559qtr.10.1708481374445; Tue, 20 Feb
 2024 18:09:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240220161002.2983334-1-andriy.shevchenko@linux.intel.com>
From: Saravana Kannan <saravanak@google.com>
Date: Tue, 20 Feb 2024 18:08:56 -0800
Message-ID: <CAGETcx8hzYzjKWPz4ACgS=XrVXqg46QHB4hTpP5bDTY9=WFK+Q@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] driver core: Move fw_devlink stuff to where it belongs
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, 
	linux-acpi@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Daniel Scally <djrscally@gmail.com>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, 
	Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 20, 2024 at 8:10=E2=80=AFAM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> A few APIs that belong specifically to the fw_devlink APIs
> - are exposed to others without need
> - prevents device property code to be cleaned up in the future
>
> Resolve this mess by moving fw_devlink code to where it belongs
> and hide from others.
>
> Fixes: b5d3e2fbcb10 ("device property: Add fwnode_is_ancestor_of() and fw=
node_get_next_parent_dev()")
> Fixes: 372a67c0c5ef ("driver core: Add fwnode_to_dev() to look up device =
from fwnode")
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/base/core.c      | 58 ++++++++++++++++++++++++++++++++++++++++
>  drivers/base/property.c  | 56 --------------------------------------
>  include/linux/fwnode.h   |  1 -
>  include/linux/property.h |  2 --
>  4 files changed, 58 insertions(+), 59 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 9828da9b933c..35ccd8bb2c9b 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -1871,6 +1871,7 @@ static void fw_devlink_unblock_consumers(struct dev=
ice *dev)
>         device_links_write_unlock();
>  }
>
> +#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
>
>  static bool fwnode_init_without_drv(struct fwnode_handle *fwnode)
>  {
> @@ -1901,6 +1902,63 @@ static bool fwnode_ancestor_init_without_drv(struc=
t fwnode_handle *fwnode)
>         return false;
>  }
>
> +/**
> + * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
> + * @ancestor: Firmware which is tested for being an ancestor
> + * @child: Firmware which is tested for being the child
> + *
> + * A node is considered an ancestor of itself too.
> + *
> + * Return: true if @ancestor is an ancestor of @child. Otherwise, return=
s false.
> + */
> +static bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor,
> +                                 const struct fwnode_handle *child)
> +{
> +       struct fwnode_handle *parent;
> +
> +       if (IS_ERR_OR_NULL(ancestor))
> +               return false;
> +
> +       if (child =3D=3D ancestor)
> +               return true;
> +
> +       fwnode_for_each_parent_node(child, parent) {
> +               if (parent =3D=3D ancestor) {
> +                       fwnode_handle_put(parent);
> +                       return true;
> +               }
> +       }
> +       return false;
> +}
> +
> +/**
> + * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
> + * @fwnode: firmware node
> + *
> + * Given a firmware node (@fwnode), this function finds its closest ance=
stor
> + * firmware node that has a corresponding struct device and returns that=
 struct
> + * device.
> + *
> + * The caller is responsible for calling put_device() on the returned de=
vice
> + * pointer.
> + *
> + * Return: a pointer to the device of the @fwnode's closest ancestor.
> + */
> +static struct device *fwnode_get_next_parent_dev(const struct fwnode_han=
dle *fwnode)
> +{
> +       struct fwnode_handle *parent;
> +       struct device *dev;
> +
> +       fwnode_for_each_parent_node(fwnode, parent) {
> +               dev =3D get_dev_from_fwnode(parent);
> +               if (dev) {
> +                       fwnode_handle_put(parent);
> +                       return dev;
> +               }
> +       }
> +       return NULL;
> +}
> +
>  /**
>   * __fw_devlink_relax_cycles - Relax and mark dependency cycles.
>   * @con: Potential consumer device.
> diff --git a/drivers/base/property.c b/drivers/base/property.c
> index a1b01ab42052..afa1bf2b3c5a 100644
> --- a/drivers/base/property.c
> +++ b/drivers/base/property.c
> @@ -699,34 +699,6 @@ struct fwnode_handle *fwnode_get_next_parent(struct =
fwnode_handle *fwnode)
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_next_parent);
>
> -/**
> - * fwnode_get_next_parent_dev - Find device of closest ancestor fwnode
> - * @fwnode: firmware node
> - *
> - * Given a firmware node (@fwnode), this function finds its closest ance=
stor
> - * firmware node that has a corresponding struct device and returns that=
 struct
> - * device.
> - *
> - * The caller is responsible for calling put_device() on the returned de=
vice
> - * pointer.
> - *
> - * Return: a pointer to the device of the @fwnode's closest ancestor.
> - */
> -struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fw=
node)
> -{
> -       struct fwnode_handle *parent;
> -       struct device *dev;
> -
> -       fwnode_for_each_parent_node(fwnode, parent) {
> -               dev =3D get_dev_from_fwnode(parent);
> -               if (dev) {
> -                       fwnode_handle_put(parent);
> -                       return dev;
> -               }
> -       }
> -       return NULL;
> -}
> -
>  /**
>   * fwnode_count_parents - Return the number of parents a node has
>   * @fwnode: The node the parents of which are to be counted
> @@ -773,34 +745,6 @@ struct fwnode_handle *fwnode_get_nth_parent(struct f=
wnode_handle *fwnode,
>  }
>  EXPORT_SYMBOL_GPL(fwnode_get_nth_parent);
>
> -/**
> - * fwnode_is_ancestor_of - Test if @ancestor is ancestor of @child
> - * @ancestor: Firmware which is tested for being an ancestor
> - * @child: Firmware which is tested for being the child
> - *
> - * A node is considered an ancestor of itself too.
> - *
> - * Return: true if @ancestor is an ancestor of @child. Otherwise, return=
s false.
> - */
> -bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const s=
truct fwnode_handle *child)
> -{
> -       struct fwnode_handle *parent;
> -
> -       if (IS_ERR_OR_NULL(ancestor))
> -               return false;
> -
> -       if (child =3D=3D ancestor)
> -               return true;
> -
> -       fwnode_for_each_parent_node(child, parent) {
> -               if (parent =3D=3D ancestor) {
> -                       fwnode_handle_put(parent);
> -                       return true;
> -               }
> -       }
> -       return false;
> -}
> -
>  /**
>   * fwnode_get_next_child_node - Return the next child node handle for a =
node
>   * @fwnode: Firmware node to find the next child node for.
> diff --git a/include/linux/fwnode.h b/include/linux/fwnode.h
> index 0428942093a7..4228c45d5ccc 100644
> --- a/include/linux/fwnode.h
> +++ b/include/linux/fwnode.h
> @@ -193,7 +193,6 @@ struct fwnode_operations {
>                 if (fwnode_has_op(fwnode, op))                          \
>                         (fwnode)->ops->op(fwnode, ## __VA_ARGS__);      \
>         } while (false)
> -#define get_dev_from_fwnode(fwnode)    get_device((fwnode)->dev)
>
>  static inline void fwnode_init(struct fwnode_handle *fwnode,
>                                const struct fwnode_operations *ops)
> diff --git a/include/linux/property.h b/include/linux/property.h
> index 07fbebc73243..1f0135e24d00 100644
> --- a/include/linux/property.h
> +++ b/include/linux/property.h
> @@ -150,11 +150,9 @@ struct fwnode_handle *fwnode_get_next_parent(struct =
fwnode_handle *fwnode);
>         for (parent =3D fwnode_get_parent(fwnode); parent;        \
>              parent =3D fwnode_get_next_parent(parent))
>
> -struct device *fwnode_get_next_parent_dev(const struct fwnode_handle *fw=
node);
>  unsigned int fwnode_count_parents(const struct fwnode_handle *fwn);
>  struct fwnode_handle *fwnode_get_nth_parent(struct fwnode_handle *fwn,
>                                             unsigned int depth);
> -bool fwnode_is_ancestor_of(const struct fwnode_handle *ancestor, const s=
truct fwnode_handle *child);

The rest of the functions here are related to parents and children of
a fwnode. So, why is this function considered to be in the wrong
place?

-Saravana

>  struct fwnode_handle *fwnode_get_next_child_node(
>         const struct fwnode_handle *fwnode, struct fwnode_handle *child);
>  struct fwnode_handle *fwnode_get_next_available_child_node(

