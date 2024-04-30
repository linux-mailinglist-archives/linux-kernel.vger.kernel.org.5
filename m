Return-Path: <linux-kernel+bounces-164517-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E0768B7E8A
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 19:30:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D3ED1C225E1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 17:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B399176FD8;
	Tue, 30 Apr 2024 17:30:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="TFX60Iyp"
Received: from mail-yb1-f170.google.com (mail-yb1-f170.google.com [209.85.219.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00BBA1802A7
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 17:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714498225; cv=none; b=IbC0HcCkVqAfJ+dN88Ur/oHWU9uevT2x77oDb7We/AlT36IySB/vbVeESXJo1i2LC+qgU78nt6Ei9A34wLw0AyavGcgbizslZ36L04oQ36b4fU//UPyzhWgnx0emeDJBaFaSTdEl7k+ENotMXFD2CpZeQC1FpdirXBydgDVrd7k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714498225; c=relaxed/simple;
	bh=FxZbViaAhwO4PV0OUowq5huoBZWoVzh7Ze8dxxotR2M=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=onP63Gz6MfRIe0/DYdgvUU0rtgwWiE2Vglk0d+7bB1mMS1XEiPMCgKzljMMxmZ7MVOZFYfBcMPJqCYJOku+h+ra9oAA4odzDFAwYo8O1DfQVnC1l3BhyPy2RIfyui+kU7MRW3OFw9kaQ95nswOaQKYqDAP6frkkGjM9L3YkKF0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=TFX60Iyp; arc=none smtp.client-ip=209.85.219.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f170.google.com with SMTP id 3f1490d57ef6-de61424f478so1160985276.0
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 10:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1714498223; x=1715103023; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FxZbViaAhwO4PV0OUowq5huoBZWoVzh7Ze8dxxotR2M=;
        b=TFX60Iypf0rMbFM8hu2NbFXmFgAZB5vH2Jewbs2L6AWdIBbR5WjFkMKLWaeLu7Lyw6
         RJleaaLcphMNIeJvrW8M3d2Irw0FE8m51PhSRoTQgf3EoGuEmZHZyuUnIEIXWdXVsUM7
         4L446C3LXyIMR9v4cwOIB+BUkLkn7tcjld6TWcOvj7uZd4f33PzZWqDLa99qbqZ7jxsG
         uqaeMoswFyQQs07c4klH2hFdgh9sQheNkHdFCXGywUlCmWK3mHCcvykDd2oH3+PIsBNJ
         3/PUloafUdnTQbI3rvhqYI9gm8T2mncBipavedWuwjIdcm68ylNaVLCLcYLZdu+17qFB
         3BAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714498223; x=1715103023;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FxZbViaAhwO4PV0OUowq5huoBZWoVzh7Ze8dxxotR2M=;
        b=YFIBDNk7RYgUmYwh96OYMkuPhRax2/8ovQTA+kn1xSODVfN/zmladzxG0k1Fcr1k32
         jP1BvVqi+VfcPUumf9viYe3n2rPhS/9zGIqA9E+w56nftYi1Bkaw2G6GcQzBv7pQKH9i
         P2RC+qXMm2DVPzxFGWq8LPqpKtZS+fGPBLXpwgeUit+OzNcmYnanqef0ecb/qgjX7Byd
         6eSt1u1uiSfX9+4Dc6L6qbB2aTxaD+8n7VAKV2aSq1Ni01sy/P9LzDy5lTS8pY7jbkL0
         tPLKs66wawkoAkE3EIZKqaW1EfVmUoQkvp9J2vfqJlfXMjcMFjebQAwX2z9dwQNkiHag
         ZVOQ==
X-Forwarded-Encrypted: i=1; AJvYcCXN+kP9Yy7XXDjxQA5dzBlCcctwuVBPyh+gN3G4IpTX6d33wcsVgBj5yDaEYaVUq1jD53V0rZ1JdG8hH48GoaqizM+/MJV1fir26wqp
X-Gm-Message-State: AOJu0YyJeV4S48h4ELospL0MVDmApWT006vanPECaNEKX4fUARYAOxbC
	iXY+P4KODc4un3btiIDdXIOlrcH17EJhGA1oq+bnZKfQnchDZulFGyhMTMZdDKFnxCw5pJr3eMN
	fTmKVIRhGK5L9iT102fzYVxhhJmYtw4mNEIKQ
X-Google-Smtp-Source: AGHT+IHty/V744L2v5XOatNQF7i9eNUdQLrh2vd0dVlj+zon9AdpeH0meErTJfIImPxb7iOwtSY+aFtHN8bPD1KCT48=
X-Received: by 2002:a25:e08b:0:b0:de0:f74b:25f3 with SMTP id
 x133-20020a25e08b000000b00de0f74b25f3mr250740ybg.60.1714498222582; Tue, 30
 Apr 2024 10:30:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240430060612.2171650-1-shakeel.butt@linux.dev>
 <20240430060612.2171650-4-shakeel.butt@linux.dev> <CAJD7tkb0cOwgvet4MV8pAzP+R4ptHoWgFoMsdoYw_0qrcWv1=Q@mail.gmail.com>
In-Reply-To: <CAJD7tkb0cOwgvet4MV8pAzP+R4ptHoWgFoMsdoYw_0qrcWv1=Q@mail.gmail.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 30 Apr 2024 10:30:11 -0700
Message-ID: <CABdmKX3Q0rGLsZY63=M1gBcMhXahcd-hfFGjJwa2hqM1Z40QdA@mail.gmail.com>
Subject: Re: [PATCH v3 3/8] mm: memcg: account memory used for memcg vmstats
 and lruvec stats
To: Yosry Ahmed <yosryahmed@google.com>
Cc: Shakeel Butt <shakeel.butt@linux.dev>, Andrew Morton <akpm@linux-foundation.org>, 
	Johannes Weiner <hannes@cmpxchg.org>, Michal Hocko <mhocko@kernel.org>, 
	Roman Gushchin <roman.gushchin@linux.dev>, Muchun Song <muchun.song@linux.dev>, kernel-team@meta.com, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 30, 2024 at 1:34=E2=80=AFAM Yosry Ahmed <yosryahmed@google.com>=
 wrote:
>
> On Mon, Apr 29, 2024 at 11:06=E2=80=AFPM Shakeel Butt <shakeel.butt@linux=
dev> wrote:
> >
> > From: Roman Gushchin <roman.gushchin@linux.dev>
> >
> > The percpu memory used by memcg's memory statistics is already accounte=
d.
> > For consistency, let's enable accounting for vmstats and lruvec stats
> > as well.
> >
> > Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>
> > Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
>
> Reviewed-by: Yosry Ahmed <yosryahmed@google.com>
>
Reviewed-by: T.J. Mercier <tjmercier@google.com>

