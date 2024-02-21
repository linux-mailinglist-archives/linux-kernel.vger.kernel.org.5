Return-Path: <linux-kernel+bounces-75247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE71B85E534
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 19:09:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFD4A1C22C0C
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 18:09:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABCC285270;
	Wed, 21 Feb 2024 18:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ApCv9GGK"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500C58004E
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 18:09:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708538987; cv=none; b=NkGdpnPCtTX9HUsxVWgL75zd2sdU1M6Ux43n5C9wljERTbZr+JfXBQON5jEbfWmaaIyBX70gP4iLkG4lTK1wWunvkuzq9TFmqSBt2DN6KVu4WekVr7cYX838BDxz2XufW9aPeG5VUAxU2Q07869sHBIuZn4OxF1gVClEfZuRBrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708538987; c=relaxed/simple;
	bh=grrfvhq/I/smGmWB5qzlUYdKDiOv1OWKxpRbXWWlGhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLbmJOaMKTSAwgwXrQFAIqkCiGYIUR/bBzKMp9oSxeXX3d56IgynfKl3IqGHIuudafUI8fJbxZG7aeHv00jkg2SZ7iXZpZte7Nk4uDd0kuTyBy6y+7v3B8WtK1sgJpN9vg8dbNweWP3TJ49zUK9/+RaHe/Q6Cd0Tc8/PnAapmZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ApCv9GGK; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-3394b892691so22767f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 10:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708538983; x=1709143783; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h4dcAwM4JyllE93PmauYjgs8AqmntaycEy/T8qi1rzI=;
        b=ApCv9GGKZADiveqmayBbVtj6Qxx1ZI6Mj0+qPestgA3INLIBt7dC9ge+FLn9iZX4Gt
         p8PyJFBVNlbUgKqv4TC+6kBTMz8TK1ZFnyqGR23ibc29ln1tuxWksFtxXpXLGW5jaKUQ
         uo9RacETQly9EgytsOm5bbp0KYXnp0beWshpg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708538983; x=1709143783;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h4dcAwM4JyllE93PmauYjgs8AqmntaycEy/T8qi1rzI=;
        b=Gz/r7C78WzI4db0Ljil+rWXov4UXvtTrZfVplH7KZ3fbr0FiJMjRyzKv6SVbAqHGzh
         wugAQEoZpUyoCYC0Zs3SVx7CLCC2bqLsgaLKv+wijW5bBDVzNJzLcDCqPvNCUpoF1ifP
         plYiqjU5qBIT5dWePtytF0vNwkp/9Es0dXfnhudtGJSYR7GWgKJ+a6bRaN1G/cBTR4A0
         1iLgfMpVCM9v6L0pbraLzhjBgx8x4RzME3wMyhsIL1ExUy12de17b7Xy5P5ttoFEDSoj
         Z7NizTiKIyPrxMNZCUUQSOt8c6tSccijkWxEfTqfRRgPnw1n7uJTZtoFUnXW2BDzhmFA
         x2tQ==
X-Forwarded-Encrypted: i=1; AJvYcCW8wQl5YBvRlpStHucVt0+pb6PrwPB6V+0FhSbLWa/tdfUWg3Mj9rKUcnEi9ads2Dia/bHvbX2AdqU7az/T9a3FH1xDKwsVzMYAggpz
X-Gm-Message-State: AOJu0YyPyNUT0AXcOuF17B7bO+Rg8FpcNAQKhTrHNolM5/L5iUkR0ZgV
	n1V3PiBonCF1jSQOQtozfT1C3xozjqQPhehyX7nuRd9jG1dWy2tybULjNq79ljIzTVUp6CqV3u2
	d+XjijyfnJemq/HjfF0N00zfzgrQzKO5CPxi7
X-Google-Smtp-Source: AGHT+IFp5GswcTDnt63ehzKUWM0iZnqUh33RNzAL6UDlpBfaG3Tt1H2BLB9L+vrnOJHGI+GUhHT0D+UrAl0uxg8/aQY=
X-Received: by 2002:a5d:526e:0:b0:33d:2872:2437 with SMTP id
 l14-20020a5d526e000000b0033d28722437mr210389wrc.31.1708538983498; Wed, 21 Feb
 2024 10:09:43 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240214170720.v1.1.Ic3de2566a7fd3de8501b2f18afa9f94eadb2df0a@changeid>
 <20240215034528.240-1-hdanton@sina.com> <87h6iaf7di.wl-tiwai@suse.de>
 <CAG-rBigFG-U-sKY77CvzghGzs+1Xm3YXzBF6N4ti0+h6UdAb8Q@mail.gmail.com>
 <875xypk6d6.wl-tiwai@suse.de> <20240216043426.1218-1-hdanton@sina.com>
 <87plwwiz6z.wl-tiwai@suse.de> <87frxsiueo.wl-tiwai@suse.de>
 <alpine.DEB.2.22.394.2402161246520.14041@eliteleevi.tm.intel.com>
 <87zfw0h3lu.wl-tiwai@suse.de> <CAG-rBihE31G1q0pXbdR22bHKNboiADTUHx0JMnDKBg_sua+0RA@mail.gmail.com>
 <87le7gog4k.wl-tiwai@suse.de>
In-Reply-To: <87le7gog4k.wl-tiwai@suse.de>
From: Karthikeyan Ramasubramanian <kramasub@chromium.org>
Date: Wed, 21 Feb 2024 11:09:32 -0700
Message-ID: <CAJZwx_nw1H0+YP1v7AHwjb9imY+RqaN+6DpNXQ-Ud9Q_A7rqHw@mail.gmail.com>
Subject: Re: [PATCH v1] ALSA: memalloc: Fix indefinite hang in non-iommu case
To: Takashi Iwai <tiwai@suse.de>
Cc: Sven van Ashbrook <svenva@chromium.org>, Kai Vehmanen <kai.vehmanen@linux.intel.com>, 
	Hillf Danton <hdanton@sina.com>, LKML <linux-kernel@vger.kernel.org>, 
	Brian Geffon <bgeffon@google.com>, linux-sound@vger.kernel.org, 
	"Arava, Jairaj" <jairaj.arava@intel.com>, Curtis Malainey <cujomalainey@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 19, 2024 at 4:19=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wrote:
>
> On Fri, 16 Feb 2024 17:22:45 +0100,
> Sven van Ashbrook wrote:
> >
> > On Fri, Feb 16, 2024 at 9:43=E2=80=AFAM Takashi Iwai <tiwai@suse.de> wr=
ote:
> > >
> > > OK, then how about the one like below?
> > >
> > > This changes:
> > > - Back to __GFP_NORETRY as default
> > > - Use __GFP_RETRY_MAYFAIL for SNDRV_DMA_TYPE_NONCONTIG with IOMMU;
> > >   this should cover the commit a61c7d88d38c
> > > - Also use __GFP_RETRY_MAYFAIL for the SG-fallback allocations of the
> > >   minimal order, just like IOMMU allocator does.
> > >
> > > This should be less destructive, while still allowing more aggressive
> > > allocations for SG buffers.
> >
> > This one looks like it would keep the SOF firmware allocation issue at =
bay,
> > in both iommu and non-iommu cases.
> >
> > If there is no further discussion in this thread, we'll stress test thi=
s
> > on iommu and non-iommu Chromebooks.
>
> The test with my latest patch would be appreciated in anyway.
I am not sure if you are still interested in knowing the test results.
The original indefinite hang issue is not observed with your latest
patchset. This observation applies to both IOMMU and non-IOMMU cases.

Thanks and Regards,
Karthikeyan.

>
>
> thanks,
>
> Takashi
>

