Return-Path: <linux-kernel+bounces-43048-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C85B3840AC1
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:03:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4E794B25767
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83DE915530D;
	Mon, 29 Jan 2024 16:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HjuHlYPS"
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E96F153BE2
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544177; cv=none; b=EISX/P8CnDP3lTs6xZnR6d0XUdZ/Y+GUxB4mOGtZWrcnwcaG321wEoPKO4baUo9NuzBaSTdT9FXHVpvU9wE1GehihlKzAr6ANhyFhDdM32LwwSC5pDlQ5QgigHvOcx4Ikm4X9SWr1aiK8C10qMWDgHQJb4QZ09fgtU3Z754dZCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544177; c=relaxed/simple;
	bh=hXlY0ftLlr6P+LZ8KvIoazr2KLExV1awHs5qk0LTyQs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Smo+buaN5oRq++A56MONhvgKByMq1/ZzOgp0fyh0vtfsrpPh8eVGrXtptyg51S7tnFR0Vix/Kt77h5XILS6nS24FJSKl6hg33+kLyzRYK008aQbOiTQ3En5j9aa1ioVoHlbEr1B9L10yWdZfERLsA5dZBgsYLgcIogsA4XsCPLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HjuHlYPS; arc=none smtp.client-ip=209.85.219.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f49.google.com with SMTP id 6a1803df08f44-68c37bf73aaso25426286d6.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:02:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544175; x=1707148975; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fStLCbKUTcGzRAhk1o+DOE0szU2Or0956o0vgo2cygQ=;
        b=HjuHlYPSW72fuKMoJFBktRH6IlWuSB7UI4iqrhrL2JLgXWUyCGJNPg4oVdZIv1ype1
         2POGGO8QC7PDMzupJGKYUY1B/zq0iz8NBvilijjUkdfI/BMkBIhax9aoRdyxcrT3vx0K
         R5fjIVyVl1ZK5cSxlpeoWh/bOKEM/FKUfSU+EVPYLbX8Qk892cfgxLcQzHFZj9xS0tDQ
         k1imBxieMN6yRN8KvOf5Qs7BN/SkLABmqdNCb5AoJJexDFw068pRec32DpAjmnHDom2N
         OAZAo4BrAU4wo/SMg/iWhXaqhINxIapxdk4oPurbytbMaAMIBEit7luQQpQG62B9o5HD
         qmUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544175; x=1707148975;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fStLCbKUTcGzRAhk1o+DOE0szU2Or0956o0vgo2cygQ=;
        b=s3BgqlzfR0A1ekYcc+wqseblu0e13alAzfYvprpFrCzr6VXyZ0FaVw8Rjf0DhMRyTj
         IG1RGmSpHcAIU/ggTzzkn6EJwMekBKe/u1kMAjy6tGIYfeKAqEkFSWYsNY/x0pYiNvsi
         uBGC29GhdrV2sEJ/OQKxtGO9oNO+0DeEBW2y/yI2UAwcv1i0oe30g0Px6sw8imEwJx03
         CSgFUzyJRoFyV55YLacPYEdtmJ5D4TmyjhaULTzrKVA8zVl7bNHQ5v2MKNfBCV9teo10
         xKhZdnmAw8pdx3Y2opmjDHqyjzt5SR2AJ5bNVPNL2nphmKpqPyczJw0QUtLiKcovbYPk
         /Oyg==
X-Gm-Message-State: AOJu0Yx+akY+hju+2TVqurXQtcTVVR/sFt9OU6dazBpTyZn9aVaVsdSH
	X6YBLb66uw+H9GKAvKtuR7U9s6LElY9hI6+tKwvXeoXeb+ZC9FxL4Gg02bIx8HzBzQbeoHgOJp2
	lBFs8ik7FaLRI+Uwi2byoLR9lATQ5hPPd
X-Google-Smtp-Source: AGHT+IHBY+NYlPvzlNbY5B0NDhyQZuJLDGA4D0xQA4x9CU2a4FSDpGesHGJijQAaIWOPvHAlcXSv1vtPLB6KRBQD0Ag=
X-Received: by 2002:a05:6214:20ad:b0:686:ae74:ae2f with SMTP id
 13-20020a05621420ad00b00686ae74ae2fmr6678844qvd.92.1706544175148; Mon, 29 Jan
 2024 08:02:55 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125170628.2017784-1-tj@kernel.org> <20240125170628.2017784-9-tj@kernel.org>
In-Reply-To: <20240125170628.2017784-9-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 30 Jan 2024 00:02:42 +0800
Message-ID: <CAJhGHyA=uO4P4skas0-DZCE+cS453V+PrJMOFj2G2DAc1tE0jA@mail.gmail.com>
Subject: Re: [PATCH 08/10] workqueue: Introduce struct wq_node_nr_active
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Fri, Jan 26, 2024 at 1:06=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> @@ -4036,12 +4097,62 @@ static void wq_free_lockdep(struct workqueue_stru=
ct *wq)
>  }
>  #endif
>
> +static void free_node_nr_active(struct wq_node_nr_active **nna_ar)
> +{
> +       int node;
> +
> +       for_each_node(node) {
> +               kfree(nna_ar[node]);
> +               nna_ar[node] =3D NULL;
> +       }
> +
> +       kfree(nna_ar[nr_node_ids]);
> +       nna_ar[nr_node_ids] =3D NULL;
> +}
> +

[....]


>  static void rcu_free_wq(struct rcu_head *rcu)
>  {
>         struct workqueue_struct *wq =3D
>                 container_of(rcu, struct workqueue_struct, rcu);
>
>         wq_free_lockdep(wq);
> +       free_node_nr_active(wq->node_nr_active);

for percpu workqueue, free_node_nr_active() will access out of bound.

>         free_percpu(wq->cpu_pwq);
>         free_workqueue_attrs(wq->unbound_attrs);
>         kfree(wq);

[......]

> @@ -4832,8 +4950,13 @@ struct workqueue_struct *alloc_workqueue(const cha=
r *fmt,
>         wq_init_lockdep(wq);
>         INIT_LIST_HEAD(&wq->list);
>
> +       if (flags & WQ_UNBOUND) {
> +               if (alloc_node_nr_active(wq->node_nr_active) < 0)
> +                       goto err_unreg_lockdep;
> +       }
> +
>         if (alloc_and_link_pwqs(wq) < 0)
> -               goto err_unreg_lockdep;
> +               goto err_free_node_nr_active;
>
>         if (wq_online && init_rescuer(wq) < 0)
>                 goto err_destroy;
> @@ -4858,6 +4981,8 @@ struct workqueue_struct *alloc_workqueue(const char=
 *fmt,
>
>         return wq;
>
> +err_free_node_nr_active:
> +       free_node_nr_active(wq->node_nr_active);


for percpu workqueue, free_node_nr_active() will access out of bound.


Thanks
Lai

>  err_unreg_lockdep:
>         wq_unregister_lockdep(wq);
>         wq_free_lockdep(wq);
> --
> 2.43.0
>

