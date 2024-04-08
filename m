Return-Path: <linux-kernel+bounces-135663-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA9BB89C975
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 18:14:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55E35287DAC
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 16:14:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4B941422D3;
	Mon,  8 Apr 2024 16:14:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SaLLMuxR"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40B81422C5;
	Mon,  8 Apr 2024 16:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712592880; cv=none; b=CJUJXn+dmBadwNaaYplYZww5YsoqUlnFDGk1Wg+crGWa/Xk3stpzM1LM+8zppZMdGIpOmTKX4jBDlxdWOBvywYG/8N2K+nXVR4ovkCCc04vYaq7Crzu9EWisbWb+VflYLVwadcQjtvoynvURpPnXMg6DxbvHKwPn4SVVeSUSyXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712592880; c=relaxed/simple;
	bh=ypVidWJ5/T2oagwVDZNMW/jM65Pm3yZ4rUqOM2IWgLI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VLfNGTOm0G7Z4T4hT14B7GGKbI49hbM/aB6mgXcrti8cBctz3x1XvMte4Ch1ZNsFIRjQJoaacdqBjISNSc/jj9+OqdaTIflYkrXxD1W1hYi1IHQhy5hMK+VknMG44v3G5iKdnBYnCi46cDPc4m7AygJUfHhvO2bDfh02GM7jZqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SaLLMuxR; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-343e7c20686so2528485f8f.1;
        Mon, 08 Apr 2024 09:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712592876; x=1713197676; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rxQFu3J8wxSQLmoLY/QSxOgIAvqkXiwa4KCnsukDrRQ=;
        b=SaLLMuxR8I5+DPFbh/apfNzDiseidm3zN64IcrCTNnZFFs062vZvH5rtEAVtY2Bh7M
         mnyKJGgM/TdllK6XxpnHVODE2wdRPNYY+0D85Zx/cyc2pEqFc1bJ1fzShnY8AQY5ZuLu
         j3a8XP4JaSbwNGxCzs8McnMfSSkp/rTlP4GxMNPKUuVQ73dLqw5sm23wDymD5FLMghis
         enNkN/IsC2TbJyEvXA4dXneUdMw8GfnAWy9V7/L1WdKVcRSo350jR1wmsG++1VKKrFrh
         9B3PDpQwP6h8fmbShwFNmkd4xNYxY/E05PFLOPeKnTA4PKwogDNjOb2KO7P+J7LBMOD0
         xTyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712592876; x=1713197676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rxQFu3J8wxSQLmoLY/QSxOgIAvqkXiwa4KCnsukDrRQ=;
        b=C86MEp0p5mWqu/dPP01CYr9NzSpsxuGv1i0sukvzXiYqsFXV6cl1IP9M3E6Hu1KcuA
         QU9hdhPZW98JByaoOJTtlM1y54qmwyaWthryanKvhj0yJaMty8mT/+8HFLcML7GbYyqf
         EelWywueZZUB6HjBgpJW+0pcsFa2zIERb1MTUR8aEmsoJjy1HUjMre/eRUM+tMKJQcpo
         FS46FidapwpIjvM6BySpdnxJG96Dxf/52ACCVNtnsC7IWULNnyf9fzryQpQiKffMw2Ca
         hYc/U4jX5IJPRdp4it5sJBaYx3n9WuSAmcUhjK/TspDGMxMZ3zcSbggHUBc+R9MS7YOW
         XNhA==
X-Forwarded-Encrypted: i=1; AJvYcCWWxb8DQt6bQDFmW0FqH3/vhXfbucDX1QC59bqrHlYr7JWbCXnO7y2cqitC8jJsHs7vRgqzsYp5tCGD43C9y+Nw+3lRRFKZonYw9lYhyF9mTw3QovE44Ht1tI1+RXh/6NidhWfOewDZLywVCgp5KIwljQ1zw6TDC3vlOuC68KeJ
X-Gm-Message-State: AOJu0YwNou2kd6ahh2OXrva8nnaTWLlYNVMM/HnBv4GVhFNgH+IaeCCW
	9sMff2oPQFhrTNGG3J87Cky3GV4lVnTax9Z7ygrhrqYGdpstu+Nfsdlun2FG7xkfmcGR24K/yMW
	wezXQS/okNoyvwulWXBFiIFju9Ww=
X-Google-Smtp-Source: AGHT+IG/WiMnMCTVwJ9rD4gISqNoHb7M1mUzeUXDXj1b7Buc3SbDIKXU945XUBZcBVYDkOlC+s/l1VQ1QGkAtVk1e+Y=
X-Received: by 2002:a5d:4f88:0:b0:343:dc46:bb4b with SMTP id
 d8-20020a5d4f88000000b00343dc46bb4bmr6822587wru.59.1712592876179; Mon, 08 Apr
 2024 09:14:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240407130850.19625-1-linyunsheng@huawei.com>
 <20240407130850.19625-13-linyunsheng@huawei.com> <b5c5866e626f6c90657a32b5e9adff724d5896db.camel@gmail.com>
 <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
In-Reply-To: <c1f5a78a-3040-0cc7-f113-d5ec82c6010f@huawei.com>
From: Alexander Duyck <alexander.duyck@gmail.com>
Date: Mon, 8 Apr 2024 09:13:59 -0700
Message-ID: <CAKgT0UfZBGEVJa1O7cdNt6zy_EEPoGo=aW6ugRKy8a44qg0j8w@mail.gmail.com>
Subject: Re: [PATCH net-next v1 12/12] mm: page_frag: update documentation and
 maintainer for page_frag
To: Yunsheng Lin <linyunsheng@huawei.com>
Cc: davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	Jonathan Corbet <corbet@lwn.net>, Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
	linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 8, 2024 at 6:39=E2=80=AFAM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> On 2024/4/8 2:13, Alexander H Duyck wrote:
> > On Sun, 2024-04-07 at 21:08 +0800, Yunsheng Lin wrote:
> >> Update documentation about design, implementation and API usages
> >> for page_frag.
> >>
> >> Also update MAINTAINERS for page_frag. Alexander seems to be the
> >> orginal author for page_frag, we can add him to the MAINTAINERS
> >> later if we have an ack from him.
> >>
> >> CC: Alexander Duyck <alexander.duyck@gmail.com>
> >> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> >
> > Again, this seems more like 2 different pathches at least. One for the
> > Documentation and MAINTAINERS changes, and one for the function
> > documentation.
>
> Sure.
>

[...]

> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -16683,6 +16683,16 @@ F:  mm/page-writeback.c
> >>  F:  mm/readahead.c
> >>  F:  mm/truncate.c
> >>
> >> +PAGE FRAG
> >> +M:  Yunsheng Lin <linyunsheng@huawei.com>
> >> +L:  linux-mm@kvack.org
> >> +L:  netdev@vger.kernel.org
> >> +S:  Supported
> >> +F:  Documentation/mm/page_frags.rst
> >> +F:  include/linux/page_frag_cache.h
> >> +F:  mm/page_frag_cache.c
> >> +F:  mm/page_frag_test.c
> >> +
> >
> > I would appreciate it if you could add me as I usually am having to
> > deal with issues people have with this anyway. You can probably just go
> > with:
> > Alexander Duyck <alexander.duyck@gmail.com>
>
> Sure, good to your ack here.

Just to be clear this isn't an Ack, but if you are going to list
maintainers for this my name should be on the list so this is the
preferred format. There are still some things to be cleaned up in this
patch.

