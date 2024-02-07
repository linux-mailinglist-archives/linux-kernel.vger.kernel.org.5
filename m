Return-Path: <linux-kernel+bounces-55835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CA89B84C23D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 03:07:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 678FE1F28599
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 02:07:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35AF8FC0B;
	Wed,  7 Feb 2024 02:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHfoD17M"
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2AEAEFBE9
	for <linux-kernel@vger.kernel.org>; Wed,  7 Feb 2024 02:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707271630; cv=none; b=LdGtM9OHeJFVr468kx+0lCPSeNwSkjXsHOWUGu1oN5b1C/NFnxJYq5ZdLwOWpru9lXl8Eex33tyijV4BedE8IHjfSrs60rvDMBugcu78UO1+YlNhx2y0PFDfK3wA4rjhETc/N2EGd6t4th6ThoYI8OOrzcQPe1x107E3tqZhA1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707271630; c=relaxed/simple;
	bh=0UZS3TR3mgeInQ4tWMsJT0XhO0RJsIL8p3otmu3nU20=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ra4X9hHlYXapTAxncRujdNiMnXmsV/Gw+ZL1sZYsxsdY4X3vYaL6Foix40Jptzq4fimgVd6mxMv3yG+PDiSUW9wn7eydkdVeATAhdWLyx6trhyV/UmTN5Sb3mkJ3dYHkQwd/lk/rwRc2IOWVzpnq7DxYMgzqbh5UfIBTeMniqz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHfoD17M; arc=none smtp.client-ip=209.85.161.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-59a45d8ec91so32519eaf.3
        for <linux-kernel@vger.kernel.org>; Tue, 06 Feb 2024 18:07:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707271628; x=1707876428; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z+tb6IdasDYJTSSzqfl5+8dC3ryjBsl7LBjRRJfQivk=;
        b=FHfoD17MH839fkc8G2BUaPZfbVckg0pm/6N5rMpJk+DL7nelABg/GVOzDL8ttBIMrS
         otxOPJaYJ00J0mYPkm75lo5QJ2MQ5XOF7fT64r3WUEL7tFyGF6covE83Bzy+0PBfhkI9
         2hVN79vygFLDjWHWHL81aeJ6z7KLjFNC+UYzxch3Nqe44CZySPeoAerAJMenLEsoUqix
         A9qcm39s953/Um0wJYAq2fe2Wby4KO45EywLUuiXjHuio8LVca1UHEujpfPzFqX7/Y86
         DXO63/1Va9PqUOJDfrFcFfJ9fDQyvNeRugfSvhVooMFcXIU8Rfela7lnmOixjOaR4iK6
         hfig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707271628; x=1707876428;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z+tb6IdasDYJTSSzqfl5+8dC3ryjBsl7LBjRRJfQivk=;
        b=kBmwE5p/P0yK4Z2ewaxsWE2Q6u9+J4sGrNIEOvMRvCoNl/WdCDWgW5rGWeb2KJZS8y
         P82ezCTx9FTd7aFCLwnGKNu/Xz8z2i4qm15WsoK4uLUE6YJKUyLHjgKRfS5yPXDdx0sR
         jtrQ0yor1qNvJj/665LrCQ08LMqfdlG1rCe3U84M2gy4HFTmv2q0SFBBxDzWE9/tmhWi
         uSAvz5cY0Jvk4tDjLH/H6m4Q+2+EJ2yAcFuL27c4AxMSnS4A7910NweeRUZstqnDmAju
         4yjoujcEgXDF/0/JOdEuGg/0MMCkj/uK/hyl7I5k3fpWy49UY3WKoVIT4SGYyekLSZaz
         rjMw==
X-Gm-Message-State: AOJu0YybWXp1NyZ89OKBxhKma2STaL98GS/Tgq89uSy8uoyG/6LS59sF
	amX0zWi20vEXXe6lsR0hu+0fJms1zillF3hZIhX22IilaITcuPShyEqeexHrBHxpt1hFp9tWBW2
	X9BhkKLnJmMAkEYG1DWFbKI0/ZIg9RAoyS5Q=
X-Google-Smtp-Source: AGHT+IHXWX6Xzm6Ltfb2yYJRrcLyB3Rk7u2tcS2BfDX36WHefUVGanB8GU1PRRlFLOuq2jRQL4g6r4XMmUjgZ4Z7uHo=
X-Received: by 2002:a4a:7614:0:b0:59c:b0e2:c147 with SMTP id
 t20-20020a4a7614000000b0059cb0e2c147mr3634718ooc.3.1707271627608; Tue, 06 Feb
 2024 18:07:07 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240206080024.2373490-1-yunlong.xing@unisoc.com> <ZcJj2dUUyAY_7XFS@slm.duckdns.org>
In-Reply-To: <ZcJj2dUUyAY_7XFS@slm.duckdns.org>
From: yunlong xing <yunlongxing23@gmail.com>
Date: Wed, 7 Feb 2024 10:06:56 +0800
Message-ID: <CA+3AYtQBci3WgTfhSA-8V34qWbnQ23V86rw7rGArGqStdpnVPw@mail.gmail.com>
Subject: Re: [PATCH] workqueue: Fix pool->nr_running type back to atomic
To: Tejun Heo <tj@kernel.org>
Cc: Yunlong Xing <yunlong.xing@unisoc.com>, jiangshanlai@gmail.com, 
	linux-kernel@vger.kernel.org, hongyu.jin@unisoc.com, zhiguo.niu@unisoc.com, 
	zhengxu.zhang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 7, 2024 at 12:52=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:
>
> Hello,
>
> On Tue, Feb 06, 2024 at 04:00:24PM +0800, Yunlong Xing wrote:
> > In CPU-hotplug test, when plug the core, set_cpus_allowed_ptr() restori=
ng
> > the cpus_mask of the per-cpu worker may fail, the cpus_mask of the work=
er
> > remain wq_unbound_cpumask until the core hotpluged next time. so, worke=
rs
> > in the same per-cpu pool can run concurrently and change nr_running at =
the
> >  same time, atomic problem occur.
>
> How would set_cpus_allowed_ptr() fail? That should trigger WARN_ON, right=
?
> If set_cpus_allowed_ptr() fails, nr_running getting desynchronized is onl=
y a
> part of the problem. We will end up running per-cpu work items which must
> execute on the same CPU on foreign CPUs.

Hi tejun=EF=BC=8C

Yes, WARN_ON is triggered. The reason of  set_cpus_allowed_ptr() fail  stil=
l
needs to be further investigated.

I was originally planning to inquire workqueue whether or not allows the wo=
rker
that associated with one cpu running on the other cpus=EF=BC=9FFrom your re=
ply=EF=BC=8Cthe
answer of my question is not allow=EF=BC=8Cright=EF=BC=9F

>
> Thanks.
>
> --
> tejun

