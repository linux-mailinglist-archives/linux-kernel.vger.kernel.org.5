Return-Path: <linux-kernel+bounces-107436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 91DE787FC7C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 12:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 183C31F2301B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 11:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF1B7E56F;
	Tue, 19 Mar 2024 11:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCxZDADs"
Received: from mail-vs1-f47.google.com (mail-vs1-f47.google.com [209.85.217.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E422A7CF03;
	Tue, 19 Mar 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710846069; cv=none; b=TRtUsG8fGsx6acjNk8q4xk+Iy2zXstY3POPn+yxh7A6bBY0Cemm9vG5w3B1EtDHwb9n/GfrjftJ9zD//7wBAhD5sswXp0FyFTiyrR6u7PafoH6C2WZobY9wUlXg4tx8G4VpKL5T32gaqV8q34N9p4h4u3temZBOXRanWVNrrN1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710846069; c=relaxed/simple;
	bh=V8dQ99e5Y9M3LuuWQ364Upo7u+6yPLvJxT/d6XYPtps=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cdWB+kgfqTpx3RtTPb9fW3vRjSXO/ae0Jb7f6gEAImamI50WzA7Kq/S7b0lHV7jPPCIk68RXvutvpLzSFF3VVk18uXD3kQLQmUkelDrPSeH6jD50vS64Te9VegL3qWzs6MkH1483CwnCNj7lzvU5XtBjZYSavrWRptx9bwa46ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCxZDADs; arc=none smtp.client-ip=209.85.217.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vs1-f47.google.com with SMTP id ada2fe7eead31-47689bdbc5aso606317137.2;
        Tue, 19 Mar 2024 04:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710846067; x=1711450867; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=kOBLKV0xQ7AJ5900qlJ5sX84DjfeTGhfWKoI9iiPc1I=;
        b=RCxZDADs9AbGFvwhC7zk35begld1yZDA/yz5VmOC3bB1ckFfC5zP+y2PyYj2Jf01ua
         d/dIfxG8Cb2+/gOODYoaQxExxhuFSlCfX0y8Rl+P9okqy7Tj1RaxDpquuKSNB90KIzY9
         ZYqKAhCF5oot8jl++udKjf1CFq/dc0kjsMZaQ9auw652vzOYUo7cUMWlJfkBizV4sE9K
         H6jtdAPqDulqNruMQ2Bj+RkOODXUnTkukPCjhriBehPzzxrk068ex7odu/9JJP0Na5r0
         2HIUN73NA1fzaaXmlDkkiWExowUOLTBc7aTH8g3iJ0Q7zaUXmQ5/I9enUuEsChzL0vb5
         MZJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710846067; x=1711450867;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kOBLKV0xQ7AJ5900qlJ5sX84DjfeTGhfWKoI9iiPc1I=;
        b=W7mvPuqngiqR5ZILZUUhYHzLMmSqrHqP7i8fX+I7Np4zryApYSy9KNTI3Ra/LkKDYR
         /WJ257YVjEZZt8U2d9UwRMoqr9TueJVV4A3KliwOoiIqzdG6Hab0Hb3RsG1Hl7yr+N4C
         iHgTOdpjmdHHWTXHUpMnFnyz6VO5x0t/IooA+Jtb9iGDN8ja+zTjg5sfT/V07KNuYHc5
         8093HHNC5G/jAEqZXv3X9wpDeXpRUVM7oHWyZIr0x9QZB5cUfDRgUKuDe3EiAf0Kp40G
         3Z/v0Y9ffaH9FILqqAuiwocH66nj3p46T9XlDoGaYoWBW1c5e8G5MqbVgnuuFZLZ6Hz6
         ISGA==
X-Forwarded-Encrypted: i=1; AJvYcCVjVkq6D4OvqZbzBLya2BG35XQCtZrKlqY2CszYEBwYwv02wVCzKcQ1PFuHWMAO544rD57VtGkN7qe9OhyVCKj34E6uWWM7P2kFiCTs42ASZeohA45lVhGts6bNb4BvPgwSvKpHb5y4OY3a
X-Gm-Message-State: AOJu0Yyu/b5vPbh18cy9aUHUBGxWPwYW8pavMt+CZl11y0f0Q+U0g97i
	Y/azMqzcIKPx2QPZDZ+ePdVe6AZAuUNBsx45J45Aut7fh1npb8ZCH4DZRUrRH8CqDgdFMfmFIqr
	fKqosKSbq8UmeE8AFhnG6j55Qdro=
X-Google-Smtp-Source: AGHT+IGdbW0VUwa9qosaiw9cgqJN6DwQC54NdjZWWS92EGosoQQuO0RaG4psVVbqF4D15bN7RBb5MF2n462s5LhYXB8=
X-Received: by 2002:a67:f296:0:b0:473:1a3e:57ce with SMTP id
 m22-20020a67f296000000b004731a3e57cemr11704297vsk.27.1710846066747; Tue, 19
 Mar 2024 04:01:06 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240222081135.173040-1-21cnbao@gmail.com> <20240308121139.GA116548@cmpxchg.org>
In-Reply-To: <20240308121139.GA116548@cmpxchg.org>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 19 Mar 2024 19:00:55 +0800
Message-ID: <CAGsJ_4wSSvVxPb7eJqewqM1My7y+yT1hNZC0s04G=mD06tq4=g@mail.gmail.com>
Subject: Re: [PATCH v6 0/2] zswap: remove the memcpy if acomp is not sleepable
To: Johannes Weiner <hannes@cmpxchg.org>, Tom Zanussi <tom.zanussi@linux.intel.com>, 
	herbert@gondor.apana.org.au
Cc: akpm@linux-foundation.org, davem@davemloft.net, 
	linux-crypto@vger.kernel.org, linux-mm@kvack.org, nphamcs@gmail.com, 
	yosryahmed@google.com, zhouchengming@bytedance.com, chriscli@google.com, 
	chrisl@kernel.org, ddstreet@ieee.org, linux-kernel@vger.kernel.org, 
	sjenning@redhat.com, vitaly.wool@konsulko.com, 
	Barry Song <v-songbaohua@oppo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 8, 2024 at 8:11=E2=80=AFPM Johannes Weiner <hannes@cmpxchg.org>=
 wrote:
>
> On Thu, Feb 22, 2024 at 09:11:33PM +1300, Barry Song wrote:
> > From: Barry Song <v-songbaohua@oppo.com>
> >
> > In zswap, if we use zsmalloc, we cannot sleep while we map the
> > compressed memory, so we copy it to a temporary buffer. By
> > knowing the alg won't sleep can help zswap to avoid the
> > memcpy.
> > Thus we introduce an API in crypto to expose if acomp is async,
> > and zswap can use it to decide if it can remove copying to the
> > tmp buffer.
> >
> > -v6:
> >  * add acked-by of Herbert, Thanks!
> >  * remove patch 3/3 from the series, as that one will go
> >    through crypto
> >
> > Barry Song (2):
> >   crypto: introduce: acomp_is_async to expose if comp drivers might
> >     sleep
> >   mm/zswap: remove the memcpy if acomp is not sleepable
> >
> >  include/crypto/acompress.h | 6 ++++++
> >  mm/zswap.c                 | 6 ++++--
> >  2 files changed, 10 insertions(+), 2 deletions(-)
>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
>
> Looks good to me.
>
> One small question: why cache is_sleepable in zswap instead of
> checking acomp_is_async() directly? It doesn't look expensive.

Thank you, Johannes. Your question sparked an idea for me. Drivers, such as
drivers/crypto/intel/iaa/iaa_crypto_main.c, have the capability to dynamica=
lly
switch between synchronous and asynchronous modes. Consequently, they
also have the opportunity to dynamically modify cra_flags. This means that
we may not require the cache. right now, iaa always has an ASYNC flag and
needs a memcpy. If we can dynamically change the flag, the iaa platform mig=
ht
be able to further remove a memcpy in zswap if sync mode is set for it.

/*
 * The iaa crypto driver supports three 'sync' methods determining how
 * compressions and decompressions are performed:
 *
 * - sync:      the compression or decompression completes before
 *              returning.  This is the mode used by the async crypto
 *              interface when the sync mode is set to 'sync' and by
 *              the sync crypto interface regardless of setting.
 *
 * - async:     the compression or decompression is submitted and returns
 *              immediately.  Completion interrupts are not used so
 *              the caller is responsible for polling the descriptor
 *              for completion.  This mode is applicable to only the
 *              async crypto interface and is ignored for anything
 *              else.
 *
 * - async_irq: the compression or decompression is submitted and
 *              returns immediately.  Completion interrupts are
 *              enabled so the caller can wait for the completion and
 *              yield to other threads.  When the compression or
 *              decompression completes, the completion is signaled
 *              and the caller awakened.  This mode is applicable to
 *              only the async crypto interface and is ignored for
 *              anything else.
 *
 * These modes can be set using the iaa_crypto sync_mode driver
 * attribute.
 */

But it seems we will get lots of synchronized issues particularly when we a=
re
changing the mode by sysfs.

static ssize_t sync_mode_store(struct device_driver *driver,
      const char *buf, size_t count)
{
           ...
}

I don't have any iaa hardware. But I'd like to ask if this can interest Tom=
, the
maintainer of INTEL IAA CRYPTO DRIVER to have a go :-)

+Tom Zanussi

Thanks
Barry

