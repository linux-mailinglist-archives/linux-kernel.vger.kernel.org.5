Return-Path: <linux-kernel+bounces-36367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D437C839FB8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 03:58:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 75CA91F21ADE
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 02:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED6621799B;
	Wed, 24 Jan 2024 02:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bWmvKPp5"
Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C8E917994
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 02:54:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706064880; cv=none; b=AXhlePPej72VQirlV9xXQVoSn4x7QtFhadPmV8PASZRC3nDcKxusBqpAM6RUxaZqnilTV26GGv+1FZBWiWnuKgBoYGf7VVBRNltQf5UEmhwChyXtN5Zm+nkF/DZ1npHYaj/YHFMnfmFqX/xa485v0BEZI2wYvcXJhpd+NCMSNAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706064880; c=relaxed/simple;
	bh=Yn+nLTB0WC6AzTCg37SAk6As162gpJKAndCBlsYZfjU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cibG92f1SfES3qMyydF+DQmmGCEZK20GZuhqkLyHIzeLA5jSQxZ54uzTE6/b4tfSrp82J7KWVv5sRZ/OyaSwgKSskYOVOttEg+PoYWdg8aTfQTs8fuYxarXVatYFnj/VSAOPYRMBd2+xrEe43JFdhCRD+lhPFYR5Gj6s+9YC2Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bWmvKPp5; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-5cf87cdc4c5so4018182a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 18:54:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706064878; x=1706669678; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2FjGNcF2e3RjXXt/dhUbDnlKzJFy1p5NLV9tNM3j+rw=;
        b=bWmvKPp5zoGFNscfKCwjRrrnZlpkQZh4H//CH++Zjyf+Qjzt3iLGVvuyhel3jAcztW
         qsK/FUgVJmyeVGA+AePXUuM01lFoghaapBljTKzjU9REqjCyYZY1diseQ8jw7tNjiT4O
         u2y7XEsM43but0nGdP/g/xVHXBi3to7vvS6IOxE15/AYwRsOzHOv2vY+55/pj0yTkePs
         0Yvdgx39T2PmTJAoTLEUt1el1Xh8mM32chRrJt/9g6c64aU0fQRwnBCZVA3wkD9D4L4w
         6ZyPa3aMiagHJ+VuHksI4Ww/Lq+Q2ynB6F1YWyntSw631utPtvuHyVA/msaSii1n0K3R
         yxbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706064878; x=1706669678;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2FjGNcF2e3RjXXt/dhUbDnlKzJFy1p5NLV9tNM3j+rw=;
        b=uEQJ/leyFzuSGrOTGReRLoaRW2mj0dC1CN5w6HUe37UypWPRnyengUU4C/oe18iXXb
         2nm2dWsy74sYT0anzRpR5RAb/TCnRAj6HwOJxIRo6jdOtYVCnJAloBzQpKMER2eJjpzO
         Ab1SKRT/WdyMe2c9+nWDIhfuwNv9ZOIwgIpomABBH7lJ6/2D39FS6NQp5G0ky+VwFRnk
         CTameNKVwOqwxCDL0FhjRn3685kQIsovblWq4HOghRSk4iJlldq309+EJjPYDff4hh9h
         azuQ43UvvZDatofNejfP8kJNTGD6Fzley7hkYrLhS3nnI1Db6F8X7nM9J5HzK+0G8kRh
         WRZA==
X-Gm-Message-State: AOJu0Yyzx3cadynNKL3jqSSapIuAUhxzT+pFnJQvpHzWK2Ef0JmzlyhY
	43I/O5YTlApVEHHCtwlpLOlsmTlyAil/bCRfvauE5zBsXrASBWBcINaEECs5EIyhBvqtZkhIVwo
	SuwwGIwmDfzzN4dJyIh89kEjFrOI=
X-Google-Smtp-Source: AGHT+IGZtCU0d2diTMSdGmSbVWXO3oc4aH0ic+qyI2ZMXd6aN42MMqhuCXp40cpiJZR+Lry/azrwi+iyE18bGoZRcSQ=
X-Received: by 2002:a05:6a21:9983:b0:19b:1fc3:18d1 with SMTP id
 ve3-20020a056a21998300b0019b1fc318d1mr202176pzb.10.1706064878288; Tue, 23 Jan
 2024 18:54:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240113002911.406791-1-tj@kernel.org> <20240113002911.406791-10-tj@kernel.org>
 <CAJhGHyDaNCoXaK4g4fKg3vfBYuQ7r+e8TT8ObrtT3nBcTeeuMg@mail.gmail.com> <ZbBaH2uSqLmJmSsV@slm.duckdns.org>
In-Reply-To: <ZbBaH2uSqLmJmSsV@slm.duckdns.org>
From: Lai Jiangshan <jiangshanlai@gmail.com>
Date: Wed, 24 Jan 2024 10:54:26 +0800
Message-ID: <CAJhGHyByJkvANA_w2JXeOiZYid9cQ=5a5dZSwSBLgBL_oKkWUg@mail.gmail.com>
Subject: Re: [PATCH 9/9] workqueue: Implement system-wide nr_active
 enforcement for unbound workqueues
To: Tejun Heo <tj@kernel.org>
Cc: linux-kernel@vger.kernel.org, Naohiro.Aota@wdc.com, kernel-team@meta.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello, Tejun

On Wed, Jan 24, 2024 at 8:30=E2=80=AFAM Tejun Heo <tj@kernel.org> wrote:

> > >  /**
> > >   * pwq_activate_first_inactive - Activate the first inactive work it=
em on a pwq
> > >   * @pwq: pool_workqueue of interest
> > > + * @fill: max_active may have increased, try to increase concurrency=
 level
> >
> > I think it is also legitimate to increase the concurrency level ASAP
> > when called from try_to_grab_pending() path.
>
> Can you elaborate why that'd be useful?
>

If an active item for a PWQ is canceled, the PWQ will lose a hard-earned
nr_active and have to wait on the round-robbin queue for another nr_active.

It seems it is unfair for this PWQ. If a user's program pattern is
queuing-checking-cancelling items, it can cause delays for other users
sharing the same workqueue.

Thanks
Lai

