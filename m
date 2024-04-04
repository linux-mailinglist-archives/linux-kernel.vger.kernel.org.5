Return-Path: <linux-kernel+bounces-132237-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8578991E6
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 01:10:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4B0028637D
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 23:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25BB13C3EB;
	Thu,  4 Apr 2024 23:10:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="u7Ne0Q4s"
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7764613119B
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 23:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712272216; cv=none; b=Oi3wNbdPhx+f4F+ZFxib0M8cNSBptffLnTBC5246+dviWYq4CS+IPnLjDqC+gNzw/TsrlBrcm9k3lchUSnIJj83BIVXAyp2HI+5Uv8kE789RG3qzrR8n0jhR2ilC+P/diy9nJLG6DhUKm2bW/tCnxYg5OUdvFwg7sD4uRNjKIbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712272216; c=relaxed/simple;
	bh=CiRdgJSRoDxQBfExeXBRD7dU/fpqdH8y8sFNfSwELbE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=utxiKHqYaDfB8AQ+jjbGSrw5oe1O3xFyZghCY4bJK2256ScIGY1Jq0XW9xp1aFqku1aXCiXUUztr5d54CAUA7acrMEEAJXDH5i0HrXE1epysQVUwR5lWQVA8XTMZLcKO83HR/gC1XUb39UEvK2MAwJU5z/jzCCA5RQwu9I//8Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=u7Ne0Q4s; arc=none smtp.client-ip=209.85.160.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f177.google.com with SMTP id d75a77b69052e-430d3fcc511so66881cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Apr 2024 16:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712272213; x=1712877013; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oGAM5h5LBMDAw+daJkVOIxme4dCXj+U4eKeIdhmjiU4=;
        b=u7Ne0Q4sX241pM4E7XH73FPr+mdV+w3upZ4N6Isaji3wI3PKtAzUvaxcb1omroy5I4
         euZ5EJHABLf0NFSwiTcB/B0wiwRNXsOPkQWfrEsyG7mZAyVh+8/m+rm6DJp2fedZuU5m
         0DTDqodmOy13JVLduHsaf9jBOTZfidvntQcMhW+GHge+2nIUJnNP71WGzJ3ebXG0E5NQ
         xyjF7tP79h3Zc3waufH8aujIB1lHIoxdPZbgDVfwHjzCmdrwz20NZT4bqZMQPsSgCKfq
         WcDPNCx7TEae+TIcvAgMI9QgtQDcew3x2AxZzeo+uj8RYyRpD7iszap9jwCJ4ncVhYOh
         cjew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712272213; x=1712877013;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oGAM5h5LBMDAw+daJkVOIxme4dCXj+U4eKeIdhmjiU4=;
        b=VS0SMx0hOO6dmFxCmJDf6+NIUo8LrxPlKo/F9BfkJcbJ2g0tniaEATUq2VxKl1FY4Q
         2W4l8/SbclTIurW9lyizwiX0Nigx6d193cuEJOWGolwGHPmapFdQ1s39qlML+SNs+4JW
         6rNrrW43e+3i5ulwaXYRVErDloEZ8T6m84uJ/gffnGoIbFaS5lgIg7kUSkQlxFZZ0r91
         Q99O/iVyvBB9rQ/yxJ+0oWsl6Spxc+cF2rH70DK4u7T8h9HKBgy7yrkx0E5k+k8N14UP
         RNKOIqL4ILMDHc2VPiWg2KAVWqsbrbYEwv4DfXVoJUpXIYjGA6ugOx9Cw/pBJ8t+B4ZP
         v6Rw==
X-Forwarded-Encrypted: i=1; AJvYcCXvNgKZ1hhoQLrqxBaZmyMAWpxARY12dtOEgAjsz5ehLYNGVdRNl5XNdkgc6UYeNik/F9ongn2boyRY7lyKNiVIfxZdGaBFkN+LWOjI
X-Gm-Message-State: AOJu0Yz5UO4sVMH+/r1cGj2PNNxAcWgj8Pbdi85y6KZ5Lh6GiphfrwMb
	4qtMGcn0K0c7ToIAQCxf1JyOj5aOaCywpwEw+RYzUk6y4Zek8a4j89sOlkwtfdfre3PP8wnGRDE
	Rfhb/QjIuhGOL77LDYw9xwcidui6vmhMNKCC1
X-Google-Smtp-Source: AGHT+IGXJQYNPaAWd2/ICZvTA1p0dvzvALKz4BFIvucPE/HvNEJ1jzC4fPNHZB9T4LpgmAGfwquyJAERhhklM7vnS70=
X-Received: by 2002:a05:622a:1495:b0:432:c041:7d99 with SMTP id
 t21-20020a05622a149500b00432c0417d99mr337788qtx.4.1712272213037; Thu, 04 Apr
 2024 16:10:13 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240404-dt-cleanup-free-v1-0-c60e6cba8da9@kernel.org> <20240404-dt-cleanup-free-v1-1-c60e6cba8da9@kernel.org>
In-Reply-To: <20240404-dt-cleanup-free-v1-1-c60e6cba8da9@kernel.org>
From: Saravana Kannan <saravanak@google.com>
Date: Thu, 4 Apr 2024 16:09:36 -0700
Message-ID: <CAGETcx83PSbA+M385-E2vPywBJBCPomEJtgLD7wjm0c60yvUnw@mail.gmail.com>
Subject: Re: [PATCH 1/3] of: Add a helper to free property struct
To: Rob Herring <robh@kernel.org>
Cc: Jonathan Cameron <jic23@kernel.org>, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 4, 2024 at 7:15=E2=80=AFAM Rob Herring <robh@kernel.org> wrote:
>
> Freeing a property struct is 3 kfree()'s which is duplicated in multiple
> spots. Add a helper, __of_prop_free(), and replace all the open coded
> cases in the DT code.
>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/of/dynamic.c    | 26 ++++++++++++--------------
>  drivers/of/of_private.h |  1 +
>  drivers/of/overlay.c    | 11 +++--------
>  drivers/of/unittest.c   | 12 +++---------
>  4 files changed, 19 insertions(+), 31 deletions(-)
>
> diff --git a/drivers/of/dynamic.c b/drivers/of/dynamic.c
> index 3bf27052832f..af7c57a7a25d 100644
> --- a/drivers/of/dynamic.c
> +++ b/drivers/of/dynamic.c
> @@ -305,15 +305,20 @@ int of_detach_node(struct device_node *np)
>  }
>  EXPORT_SYMBOL_GPL(of_detach_node);
>
> +void __of_prop_free(struct property *prop)
> +{
> +       kfree(prop->name);
> +       kfree(prop->value);
> +       kfree(prop);
> +}
> +
>  static void property_list_free(struct property *prop_list)
>  {
>         struct property *prop, *next;
>
>         for (prop =3D prop_list; prop !=3D NULL; prop =3D next) {
>                 next =3D prop->next;
> -               kfree(prop->name);
> -               kfree(prop->value);
> -               kfree(prop);
> +               __of_prop_free(prop);
>         }
>  }
>
> @@ -426,9 +431,7 @@ struct property *__of_prop_dup(const struct property =
*prop, gfp_t allocflags)
>         return new;
>
>   err_free:
> -       kfree(new->name);
> -       kfree(new->value);
> -       kfree(new);
> +       __of_prop_free(new);
>         return NULL;
>  }
>
> @@ -470,9 +473,7 @@ struct device_node *__of_node_dup(const struct device=
_node *np,
>                         if (!new_pp)
>                                 goto err_prop;
>                         if (__of_add_property(node, new_pp)) {
> -                               kfree(new_pp->name);
> -                               kfree(new_pp->value);
> -                               kfree(new_pp);
> +                               __of_prop_free(new_pp);
>                                 goto err_prop;
>                         }
>                 }
> @@ -921,11 +922,8 @@ static int of_changeset_add_prop_helper(struct of_ch=
angeset *ocs,
>                 return -ENOMEM;
>
>         ret =3D of_changeset_add_property(ocs, np, new_pp);
> -       if (ret) {
> -               kfree(new_pp->name);
> -               kfree(new_pp->value);
> -               kfree(new_pp);
> -       }
> +       if (ret)
> +               __of_prop_free(new_pp);
>
>         return ret;
>  }
> diff --git a/drivers/of/of_private.h b/drivers/of/of_private.h
> index 485483524b7f..94fc0aa07af9 100644
> --- a/drivers/of/of_private.h
> +++ b/drivers/of/of_private.h
> @@ -123,6 +123,7 @@ extern void *__unflatten_device_tree(const void *blob=
,
>   * own the devtree lock or work on detached trees only.
>   */
>  struct property *__of_prop_dup(const struct property *prop, gfp_t allocf=
lags);
> +void __of_prop_free(struct property *prop);
>  struct device_node *__of_node_dup(const struct device_node *np,
>                                   const char *full_name);
>
> diff --git a/drivers/of/overlay.c b/drivers/of/overlay.c
> index 2ae7e9d24a64..4d861a75d694 100644
> --- a/drivers/of/overlay.c
> +++ b/drivers/of/overlay.c
> @@ -262,9 +262,7 @@ static struct property *dup_and_fixup_symbol_prop(
>         return new_prop;
>
>  err_free_new_prop:
> -       kfree(new_prop->name);
> -       kfree(new_prop->value);
> -       kfree(new_prop);
> +       __of_prop_free(new_prop);
>  err_free_target_path:
>         kfree(target_path);
>
> @@ -361,11 +359,8 @@ static int add_changeset_property(struct overlay_cha=
ngeset *ovcs,
>                 pr_err("WARNING: memory leak will occur if overlay remove=
d, property: %pOF/%s\n",
>                        target->np, new_prop->name);
>
> -       if (ret) {
> -               kfree(new_prop->name);
> -               kfree(new_prop->value);
> -               kfree(new_prop);
> -       }
> +       if (ret)
> +               __of_prop_free(new_prop);
>         return ret;
>  }
>
> diff --git a/drivers/of/unittest.c b/drivers/of/unittest.c
> index 6b5c36b6a758..a8c01c953a29 100644
> --- a/drivers/of/unittest.c
> +++ b/drivers/of/unittest.c
> @@ -795,15 +795,11 @@ static void __init of_unittest_property_copy(void)
>
>         new =3D __of_prop_dup(&p1, GFP_KERNEL);
>         unittest(new && propcmp(&p1, new), "empty property didn't copy co=
rrectly\n");
> -       kfree(new->value);
> -       kfree(new->name);
> -       kfree(new);
> +       __of_prop_free(new);
>
>         new =3D __of_prop_dup(&p2, GFP_KERNEL);
>         unittest(new && propcmp(&p2, new), "non-empty property didn't cop=
y correctly\n");
> -       kfree(new->value);
> -       kfree(new->name);
> -       kfree(new);
> +       __of_prop_free(new);
>  #endif
>  }
>
> @@ -3718,9 +3714,7 @@ static __init void of_unittest_overlay_high_level(v=
oid)
>                                 goto err_unlock;
>                         }
>                         if (__of_add_property(of_symbols, new_prop)) {
> -                               kfree(new_prop->name);
> -                               kfree(new_prop->value);
> -                               kfree(new_prop);
> +                               __of_prop_free(new_prop);
>                                 /* "name" auto-generated by unflatten */
>                                 if (!strcmp(prop->name, "name"))
>                                         continue;
>

Reviewed-by: Saravana Kannan <saravanak@google.com>

-Saravana

