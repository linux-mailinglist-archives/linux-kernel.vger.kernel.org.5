Return-Path: <linux-kernel+bounces-103448-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0166087BF74
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 16:01:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BEC6285938
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EF6071740;
	Thu, 14 Mar 2024 15:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bAyIfEoI"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B96E71734
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 15:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710428457; cv=none; b=F5tsm+TjEtarDSEJWZdSuTvCcI0ViUj/PB+OOc8upieKtDHMeXb19KZy2BPfw8YaY7aZOZ3wHZ3O2cm5CH7y9acSIjIQh5wujgVu5p9Pp1gBoxIunSW6J4AKO2M1IGP6fqgRMlw0SNOoOqUxZ4h19B3i6FFu8vOZ43X/Qr15ak8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710428457; c=relaxed/simple;
	bh=MScNp1nP9nUSyVDewm9QpHPiKVaNJLVtYQ3J+Fa+oLY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=koYXKTJyipCHap9+FVL69Pzq2JQvDr6a+05eZTRcVpV9cZmVSwgHDWNstzh3cEw79ls/DEeVk7+KzNMcVYORyoReqWdDjaEqZzo+73UqPsWrFv7mEt8WeVplgrOL+9ZISJHCdOVCymImTsHycWqKAdgBByw0NT6zFBmx4r6bIXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bAyIfEoI; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dddd1a8732so156605ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 08:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710428456; x=1711033256; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CH8RANQQT2jsR2s4b+7SiD1gGhZ0rPFRwfusn0ZxoXM=;
        b=bAyIfEoIJ112xjtaSAc/KxxDyD7rwyM8WV1IEAevwA3fR8+ArQ4X7ZcQD3C0d38gX7
         FWFt8XrYxIhZY0jDs2bJws3w4TxwCgoUxeJ2AdsutNQ7M/IEvnRDdYDCa4SyhEcRWe52
         xLingU0s6EJ+fgWG3McloOUvOJ1G2RXgtcDWZS9qpAO0CtB8vV6l6s6ebVaouH4KYEhD
         rl3r1Z3Ad3XtP+WVToI53jUW40bheFb3eE0OqAlhlWrbk1/o8/tvveWH1ieEXTWnvltQ
         ahLppaAJniqCOlS7yhrFaCZi+Yu0Nz9jRagzasHro5MrsENKQNrgPLwT4r/mhX7X64eM
         WTGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710428456; x=1711033256;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CH8RANQQT2jsR2s4b+7SiD1gGhZ0rPFRwfusn0ZxoXM=;
        b=CMsn/3V9Zw7luc5xQWtqGaksL9dZfOcTD4jNMnl4hA2ylCuak861xHfGD8rbDKTXwW
         dl5kJyV/uord9LcqoF0tHnBZNj7E3I7oNGiXDv89d264qYX2C5p5OB0HPQWOq1G+yeVf
         zbyI9kLtWJtU54+Hx8qurkK9IBqqjAaXf8BWa69eIihDFJTy9WCGwB+aT0/yVsNfDFnX
         zHvrmlkyOgEYUFcILmXU23NWB62kXpWIlUxAKlLOOWaKEInJGfdvc5Nza1/MG6UpAtwv
         bNKtvS3SHTVpWRLbBxCLSOfc/CncM0BYPNEhhZJuyugWQyCG/dfalX3P/NowcLnGNWY1
         dj8w==
X-Forwarded-Encrypted: i=1; AJvYcCWk2XZCPF0AJTNSaA6bXOOyff021tMBhM1uotYskCRPqEYKL+g9LPE7+Qi6A9HNHy106dV1hOaj+VExRHDxqiCUcVlvxixLg/NFn+CP
X-Gm-Message-State: AOJu0YxWlN/giRo06ZjyRHPDLctrAeS7/pvOvZElnnCbOadLEF7SIi9F
	2MjGSPysbzrzJCOaUUS57nFYfCZW0vOWqiXOVaCehfSuW+G+v5aMJGDkj8/7/Yx/baX+BvUFCym
	vh0Tb468f0h9g4JRX2Zb/B2ORYAPjuSk4B1dXj49Fs3CKtGYTGs7+
X-Google-Smtp-Source: AGHT+IEKpRXqG3a2vfe//6ITfZ7EAT+S4pM5b3IxGmmn6yNhIkazGMPT4qAGhWlGcQS+ZphOOFIgY1VsjYM7e8DbreU=
X-Received: by 2002:a17:902:bcca:b0:1dc:dfd0:f3da with SMTP id
 o10-20020a170902bcca00b001dcdfd0f3damr211253pls.28.1710428455163; Thu, 14 Mar
 2024 08:00:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240314144320.743217-1-acme@kernel.org>
In-Reply-To: <20240314144320.743217-1-acme@kernel.org>
From: Ian Rogers <irogers@google.com>
Date: Thu, 14 Mar 2024 08:00:38 -0700
Message-ID: <CAP-5=fX=UmW2iAQNfYcBG89Bv9LmLUtSmPOOH+3LN=r396sO1g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Move some more header copies to tools/perf/trace/beauty/
To: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>, Namhyung Kim <namhyung@kernel.org>, 
	Adrian Hunter <adrian.hunter@intel.com>, linux-kernel@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, Arnaldo Carvalho de Melo <acme@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 14, 2024 at 7:43=E2=80=AFAM Arnaldo Carvalho de Melo
<acme@kernel.org> wrote:
>
> From: Arnaldo Carvalho de Melo <acme@redhat.com>
>
> Hi,
>
>         Move a few more files that is used just by scrappers.

Thanks Arnaldo! A nit, could you change s/scrapp/scrap/g in the commit
messages - scrapping is throwing away, you mean scraping :-)

Ian

> - Arnaldo
>
> Arnaldo Carvalho de Melo (3):
>   perf beauty: Move uapi/linux/usbdevice_fs.h copy out of the directory
>     used to build perf
>   perf beauty: Move uapi/sound/asound.h copy out of the directory used
>     to build perf
>   perf beauty: Move arch/x86/include/asm/irq_vectors.h copy out of the
>     directory used to build perf
>
>  tools/perf/Makefile.perf                      | 19 +++++++++++--------
>  tools/perf/check-headers.sh                   |  6 +++---
>  .../arch/x86/include/asm/irq_vectors.h        |  0
>  .../beauty}/include/uapi/linux/usbdevice_fs.h |  0
>  .../trace/beauty}/include/uapi/sound/asound.h |  0
>  tools/perf/trace/beauty/sndrv_ctl_ioctl.sh    |  4 ++--
>  tools/perf/trace/beauty/sndrv_pcm_ioctl.sh    |  4 ++--
>  .../beauty/tracepoints/x86_irq_vectors.sh     |  6 +++---
>  tools/perf/trace/beauty/usbdevfs_ioctl.sh     |  6 +++---
>  9 files changed, 24 insertions(+), 21 deletions(-)
>  rename tools/{ =3D> perf/trace/beauty}/arch/x86/include/asm/irq_vectors.=
h (100%)
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/linux/usbdevice_fs.h=
 (100%)
>  rename tools/{ =3D> perf/trace/beauty}/include/uapi/sound/asound.h (100%=
)
>
> --
> 2.43.2
>

