Return-Path: <linux-kernel+bounces-108081-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B7D68805AC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:51:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBB97284B48
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:51:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F36A154665;
	Tue, 19 Mar 2024 19:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="j8hm5QRA"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC9E93B28F
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710877899; cv=none; b=H/OJJ2ls+1j1XHWJGyaV8LHfcxr5dwwniY61FgxKfGdmgC7/VW2QOUjkUq6LNXqVRyjbbe8nJ7Zh/pYxm3eUoVehKcMAHSlnRxxHH1RSeTDHLOjeRg++9fLaME0DEBKh1uKJThX6x//MvwVcZd0x+sOkvxWwVzeM10qCGUQ+3B0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710877899; c=relaxed/simple;
	bh=u5ISTVgLFXBHPytLP7czQVcemEzdgRVw+u5krgsn5QA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=mWUnC9kj1fCGa5FWdxhuThaT23fKsN0xHy46kMTAg0M7cKMte5UcqWvo8EWGHkYBIpUxQ2/bFGmXjb9ihCGqrJgDhwehNCjPCyeF99f5M30ddqM9swsc1Vft0Wbkp8jFT1a33VjBYcQvZsDucGLGKqc3QzZhniyTiINXmPGcdSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=j8hm5QRA; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dee917abd5so1355ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710877897; x=1711482697; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0TkXuhmLGM7c9bdHQNzOA0SGeCtxI5tN/gqKMMP6F0c=;
        b=j8hm5QRA91NoXNsZMtjBMmSRGagPsBzX2iJSVImfSyJi1LmFDYrJ5+c1pOezGlbZE0
         5/IY6Qfx73bArihTLDmlyihtIXP5CD3WhBdbfMfrjcf6eldPT8LfO+7LRfTEffCdnDbr
         isJYxwH5tFEaJlMoPvGalXe4zl1CiJoWeSO3zF5X9HAgLqoU0UekFmXDN3wEdIoKGR7Q
         pVP54A38wvPbEPm74idtfRxoQvqQbPhygeMlkatZmD6Ruho59H0SfwvbDrTo3KDBdIBk
         Xhsn0hPph7UEm8bhKXirnnKnTc/ahgALYj22WsLRLrzTEeRaam4WRlj5cvpVVBcpajcD
         X9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710877897; x=1711482697;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0TkXuhmLGM7c9bdHQNzOA0SGeCtxI5tN/gqKMMP6F0c=;
        b=tmAqDrTImJHkufD6Qivc0finJjidD9kGTDFdhW9pAOrzwdewU/9sDGa2tLTxOnmcFP
         WElFJNLVz6hqNwoWZBoQWOGfEAe0/pSXa667tM14dqd0HahXcwvcwHJOXrr+5n3ccU1v
         RPTE4KIfnkqhQ+C2DcMLWjzRG1gYvafxz4yPOIvBEATDQ81vr/Qc8VfLxW5P824B/enB
         HdbKtndFhJCHmBXy3dG0RwfJKQM5Aw2v3Bnieg3HZBtCb7qHmdcqFea4aqzKPh6pBddN
         6O4CygI97zg2n70Wb2qiMde3aajmge/dYQYSsICNt2CJOzzeGy9Hef0murnLia22hzG/
         0bBQ==
X-Forwarded-Encrypted: i=1; AJvYcCV1U/Rg3R4kX8dat+rZwkNLhrpqJSYIUy4pPq0nxHvmYLGWkL2tc0ZIzWT4Q2nzwmODPf3xfbYFYlBshi8oUgzA9iUBMCQv0OGEkmgr
X-Gm-Message-State: AOJu0YwA0Xi/IklaeiZrEUPS4L+TSbCdrcLsZOLUL44VkrJbhxBYWBXy
	l8t8mth1vf251msVyyWojwwmQRdLH11yKE3wkCqps1YP0GSzO8LHxv0SPeGyd4nXlplQ/QYT50r
	k367ku51U6gnn72aRCmEYjZzkLgBVAydx2rTc
X-Google-Smtp-Source: AGHT+IF+frKKJWR+nVJ2Vrwk/OC3+PDYLd1fNu1rRucHMrbQJorul6XLTLfqlvUhZfZc5d71eG8DO7rmDaJ3MYo16Z4=
X-Received: by 2002:a17:902:ecc8:b0:1de:ff9f:e760 with SMTP id
 a8-20020a170902ecc800b001deff9fe760mr68290plh.0.1710877897067; Tue, 19 Mar
 2024 12:51:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-6-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-6-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 12:51:22 -0700
Message-ID: <CAP-5=fW+FvUu8JL+KrtVv5uC++4AW=VhyEOgmdWzpH1mswQNzw@mail.gmail.com>
Subject: Re: [PATCH 05/13] lib min_heap: Add min_heap_init()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	dm-devel@lists.linux.dev, linux-bcachefs@vger.kernel.org, 
	linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 19, 2024 at 11:00=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Add min_heap_init() for initializing heap with data, nr, and size.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Should this change update lib/test_min_heap.c to use min_heap_init?

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 12 ++++++++++++
>  1 file changed, 12 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index c3635a7fdb88..ed462f194b88 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -44,6 +44,18 @@ struct min_heap_callbacks {
>         void (*swp)(void *lhs, void *rhs);
>  };
>
> +/* Initialize a min-heap. */
> +static __always_inline
> +void __min_heap_init(struct __min_heap *heap, void *data, int size)
> +{
> +       heap->data =3D data;
> +       heap->nr =3D 0;
> +       heap->size =3D size;
> +}
> +
> +#define min_heap_init(_heap, _data, _size)     \
> +       __min_heap_init(&(_heap)->heap, _data, _size)
> +
>  /* Sift the element at pos down the heap. */
>  static __always_inline
>  void __min_heapify(struct __min_heap *heap, int pos, size_t elem_size,
> --
> 2.34.1
>

