Return-Path: <linux-kernel+bounces-43047-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E06DB840ABD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 17:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C65F281D4C
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Jan 2024 16:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DC3715696D;
	Mon, 29 Jan 2024 16:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XDN9Xdz+"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FA9E155A32
	for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 16:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706544036; cv=none; b=cAHCNMTtj9wnBSzfMtQjcoNjKHZVCvdfseUsP1J33OTzz8ukjbhyFbSFcMlhUjJqYwo2RL27ikDGf/mS2T9LPxxKcmQgEV3mlOEm++rM5tqbC+psC2SZo33Q0IaK0oUPEa7/LOPkHd25AUR3wJZpzMkSwr7Xszm3bI8PkxyleWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706544036; c=relaxed/simple;
	bh=IpNBFj7rTRncHa2LoXpyMTadF1pa/ioDUWs0SSZnZJA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VOdccN77eE9PqOHrqEmdpoknSlBwPK6WFNpgYNRAKoeG+eJuv6PRsID/s6ypilFVRmIPi9X/7F15Gr3PTXh7gf9rB+E3uvqE63Hi/5tA6A8IxLVjKehkCt1BeixhCQAAnSLiBkmVcuBllURB2LKYRpuWmnAO7b1b+3/udXqutkI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XDN9Xdz+; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5d4a1e66750so1449239a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jan 2024 08:00:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706544034; x=1707148834; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iRGYZpq7Hm473xlHR3mHisE1vtl8EqHHSDvobXAqEcc=;
        b=XDN9Xdz+Rxg8jhroQAnxJ2od+jrukmqWLFepDcYTXrxST3N9JHWy6jT8aVx7ZKuM7a
         JZNYK5mYBAkH2boehOi/c/RRvASbQiUgGvBCHV7pbryP9ln+zx75QlQ5Dq1GVHXElDcg
         d7LE1QekAerMonq3IsC4l7SHSPu4hwxVD6gVdfi1A5xB99hPycJS/Z3XwMvqGpX6NGV3
         0KJyORqSihxpYpNXNyA2VLODqZfMmK5MpvRfQz1JbfZWIe1tkjmxM0p5C6SIES0QBbiE
         vMZaL37O44ZXwy6Q0ufwmFYn4qihn3IXDmLtxFgLww3MGNydj///9U+XJrBRa5h0EN+z
         Aovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706544034; x=1707148834;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iRGYZpq7Hm473xlHR3mHisE1vtl8EqHHSDvobXAqEcc=;
        b=JD2yd2zCKsGVhOt9fAu3z3+hw0UojLw1XkldZxIlOMJ642gAJsZGT/GFbOuHhyC2CY
         +q4m8YvESpiisQX/rZMK66Pcv8725XSwGDTIpFauSs8V98qBnFwAy0Wt0Ppn90J+m5aw
         rDJ+FToXBI10RyaF2ISVhGjFoNzXh7lZzDAS5pliw2VnkFIYpNDwg4FLZuXzgH/QiyLc
         O/bZom5P5VSbUyCRlkSTNo1tWzMTTm40cxowrDNokxT4/LZkvLh8rnC1RK+HJtTQ+6pO
         gJpmbvIwNIIHI0C7R1oUPdOZw0t6V9Sr+zN7QfOj91JOARL2s9Y6m7XDrwGcAhpMtfDc
         BF6Q==
X-Gm-Message-State: AOJu0Yy/k4rP7PvwpdE9LpG45aqBPoYVMMXwGFh7a3+hnQsyZU7RAEB+
	RdJ9st2Trv2tROfVDIfLfkbIfrduqtKKWiSMUvmrky3Ps/h+qBahGY9bQ6i1VUyLYjX7ESqizRs
	75PEC1xqke5jWvYUo74/v1cQUmc4=
X-Google-Smtp-Source: AGHT+IHYaG4TGyxxr+QUwFox3uX0KozbTrw1DkpCcQ884SLYhEdC9+JyrnlvINgX+uMWf1yitLFYVV1FQU1tdpUGP4c=
X-Received: by 2002:a05:6a21:2d84:b0:19c:9ba4:4851 with SMTP id
 ty4-20020a056a212d8400b0019c9ba44851mr2176004pzb.14.1706544034239; Mon, 29
 Jan 2024 08:00:34 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240125170628.2017784-1-tj@kernel.org> <20240125170628.2017784-10-tj@kernel.org>
In-Reply-To: <20240125170628.2017784-10-tj@kernel.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Tue, 30 Jan 2024 00:00:22 +0800
Message-ID: <CAJhGHyAuoGNmaaDa0p+wiJMprXYVYnVV75PS4+kPy-fsPJVH8w@mail.gmail.com>
Subject: Re: [PATCH 09/10] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Fri, Jan 26, 2024 at 1:06=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> @@ -5121,6 +5374,9 @@ void workqueue_set_max_active(struct workqueue_stru=
ct *wq, int max_active)
>
>         wq->flags &=3D ~__WQ_ORDERED;
>         wq->saved_max_active =3D max_active;
> +       if (wq->flags & WQ_UNBOUND)
> +               wq->saved_min_active =3D min(wq->saved_min_active, max_ac=
tive);
> +

wq_update_node_max_active() must be also called here.

Thanks
Lai

>         wq_adjust_max_active(wq);
>
>         mutex_unlock(&wq->mutex);

