Return-Path: <linux-kernel+bounces-102375-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 279A687B15C
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 20:14:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5904D1C2738A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Mar 2024 19:13:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5D0634EB;
	Wed, 13 Mar 2024 18:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b="DsWP5D+9"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB0D751034
	for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 18:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710355230; cv=none; b=ZCxUCxUGDAgEPvQ24WVFt8jl67uuuAQMKaJo+M83kYM7BpFHkePfGF6AuydZchHKOTOzyPU1dU5IeCyQ+lfiyoZScf1irmu+Rg2GCX55vcLxaIbZLBnviBGeureQjTT/1aF/nh+wsOtGtO8mN9SbOYnJ3hglEPXOnaRYQj7i2bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710355230; c=relaxed/simple;
	bh=UKCF2JgHU6sGdK9UO+UqDfgKMPdx70tIOR76xFhLuAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=muM3hjA2r9HLKOZoSdjNRgVT7EgBzSugi7CbfSA92Jt6Qw74fFWGxxSbKBEvTdXlQSUZU0wnsxOAl6Ml5fmD8+yGmMSrSL+xyfVyoTDVowbx8HIWPSy+3I1PFscX66grHFOxIp+jl1YqxbeUgwoYUKz6KaHkulucnvLWq6YQ40g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com; spf=pass smtp.mailfrom=cloudflare.com; dkim=pass (2048-bit key) header.d=cloudflare.com header.i=@cloudflare.com header.b=DsWP5D+9; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cloudflare.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudflare.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-29a8911d11cso126713a91.1
        for <linux-kernel@vger.kernel.org>; Wed, 13 Mar 2024 11:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudflare.com; s=google09082023; t=1710355228; x=1710960028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UKCF2JgHU6sGdK9UO+UqDfgKMPdx70tIOR76xFhLuAM=;
        b=DsWP5D+9ztT78OdfoxZNmKX7mrs3RRF6LNVAAVVePPTRkn31yOqFJc0zCijhsHStSg
         Jx6cJpITe3jyY38S6vzFQOX89Bv4SsBExza05GPCZerYL3CroKtwTjqZRhbVjAvPFRh7
         Ad4XG9GtXEPZaT3bbebPlGGyX+TyJx7JT3exVJfn+Pj/eCExwBc7BDo9cAPhuMpZNaxp
         kkYZbsapbdYl+Xcr8G6pVAHrsbfECdeAV/zRj4890dNXfqY1F7zb6nqbX45gjXoPE6rl
         cOgX9M64EtCCpBxng3pynmHiPtBtKZLik96NVpR+84RxK45yUoOlIymPqyAf8Wlg/ybb
         hZ/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710355228; x=1710960028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UKCF2JgHU6sGdK9UO+UqDfgKMPdx70tIOR76xFhLuAM=;
        b=SetKeE7FzC0Gk8L32EMpGhfLsckysmrKW3M0jEoObUvcQ/oOojO1S1p/YIphZvvmot
         MXKYckypCF+lNZAbKMUOEHPWws6SSJpLI+M/BJZpdwb3qlQJxEm2wrBI2dsvV19d9dQv
         nyYzKuKWtYRbda75+3DAoep6IQG42SH8NA/tHgtWZuL73M7HA/wq1ELgTfHjZ7GMDaQg
         BbAif/DHt5Jag8HVbThPhO/MHS1JJI6ngJpDf2yLZYSj9WvWT+DebGoQAYWpE+b8ibYu
         qjSYih5RJKgAfFtVrHr8fwWjJV5R1hdC6m3XKdFmDg/dFLGTa7ey5Wvm+LqXSMICtqbr
         0ipw==
X-Forwarded-Encrypted: i=1; AJvYcCU2wZLsP0ahzWOXpAPnihvSPbl2FlApdD0u/WYPWYyvptWhkXVrizccwBTbDfiPMUObe/NVThcbR6NUYy6UnmOQrz5BaPN64LpitZhW
X-Gm-Message-State: AOJu0YwonNufrX3QdBdhV4eFtvCZa8fkwetb3BfPd5X/49Jg7O8wdl05
	98LgjLGay1ZCUpWRCqJrDPGQzaaXxwzHYdGsHUNCd/2fVdMihRb4RzFV7QcoSrCc1osaPJZSx8C
	ZU/KOSmFqczj8mxXu2X/1Jyp6TWXmCqtFAGn9ZQ==
X-Google-Smtp-Source: AGHT+IFn7m3XPNUeSG6h1n4OWydgJgqKei2hyzaeIOCPn+b2XJT96X5dFxS6HSNU3tdMob4iV030gza5PkO6o4jft5g=
X-Received: by 2002:a17:90a:7784:b0:29c:720b:5f95 with SMTP id
 v4-20020a17090a778400b0029c720b5f95mr786007pjk.30.1710355228037; Wed, 13 Mar
 2024 11:40:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240312160551.73184-1-ignat@cloudflare.com> <20240312164221.5bf92fd0@kernel.org>
In-Reply-To: <20240312164221.5bf92fd0@kernel.org>
From: Ignat Korchagin <ignat@cloudflare.com>
Date: Wed, 13 Mar 2024 18:40:16 +0000
Message-ID: <CALrw=nGE7kzj9wnPw0qkM2d0HT-BUYtLqoD5iJGjrOXcbMPe3Q@mail.gmail.com>
Subject: Re: [PATCH net v2 0/2] net: veth: ability to toggle GRO and XDP independently
To: Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	kernel-team@cloudflare.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 13, 2024 at 12:42=E2=80=AFAM Jakub Kicinski <kuba@kernel.org> w=
rote:
>
> On Tue, 12 Mar 2024 16:05:49 +0000 Ignat Korchagin wrote:
> > It is rather confusing that GRO is automatically enabled, when an XDP p=
rogram
> > is attached to a veth interface. Moreover, it is not possible to disabl=
e GRO
> > on a veth, if an XDP program is attached (which might be desirable in s=
ome use
> > cases).
> >
> > Make GRO and XDP independent for a veth interface.
>
> Looks like the udpgro_fwd.sh test also needs tweakin'

Sent a v3 with adjusted test

> https://netdev-3.bots.linux.dev/vmksft-net/results/504620/17-udpgro-fwd-s=
h/stdout
> --
> pw-bot: cr

