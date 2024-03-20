Return-Path: <linux-kernel+bounces-109213-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 73D0F881643
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 18:14:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 735781C231BD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Mar 2024 17:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29B426A037;
	Wed, 20 Mar 2024 17:13:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZK+zV9NB"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11CA869DF4
	for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 17:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710954832; cv=none; b=InViVn6cxUZCBFXrdf3l62eFeDAje9sWVCzcPVRvjfhHi6XVbnyA9a18ai67w+I5rhP2Lu+FdopXjvW7RHZZeU84G5UZvR0TFcaJHXKaBEvZRMiM7KskwKpvH7L3V9P8/idThLyoQKGWSM3VByov5KozsZ6/OKqJWG+R92FcLfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710954832; c=relaxed/simple;
	bh=Z2QMshSRUV/Ic6Kf5osNo4mJkuPuXiVLb5k5is3/ucs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=vBfnGSWASa/HHfi8XlrpktGR76TOehy7upWTO2OutI5L4cfL1DB85hB+vyv5OJ86JUlBAAvsEANH81tQjGbMDqdACmVRnN4rsU/VWOkL5xFPRDilEYYVUywCFePjad6BtOLHPZ2mL5njfDtp3+Pwp49PnZvrvmeM3GGMiMIO1OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ZK+zV9NB; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1dee917abd5so6845ad.1
        for <linux-kernel@vger.kernel.org>; Wed, 20 Mar 2024 10:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710954830; x=1711559630; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f+GdX2jdkDlWHWBVOsGIoAg8YOz++4sTFpjiRVGx7IY=;
        b=ZK+zV9NBZTGdUYxJDa0k4CUSddFVcRdznVDuyaWV2v9j+WFlVMsdDdBRV1L+CmxX0X
         bmo3Z+MMeBnkO3FqSMVNsTJM9g0iCFHq+bJV5VX6JYMsm5Kw8EGBjbfn4Jhb1bWwYgaD
         Prrgc0ja1NiG3CP++dvo52ABLpFt1wXJ5vJUy3DpvJFa8pScbd7ZK0Dz9uv+7OTPxbTh
         JosWOiQdZuEBKQi9XlkDxbR1Ch6d5jdqza0hkWfrNRwFKqR9jganS7bPoT9mihccCGHZ
         2n788+mQpUecUZ1ErlGOyPm55tcvJn8L52TNtou7B0KHq84EF4neGpyOA0mpqBJ/4DMF
         rb/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710954830; x=1711559630;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f+GdX2jdkDlWHWBVOsGIoAg8YOz++4sTFpjiRVGx7IY=;
        b=Vlo76AhasXcrto23wDhQyPhGlG0Dewm0V6Qxuil16JK59bufzawohpRyltWxRFnpND
         4PcWgG8+J38QzymKtdEMkWBqQy9F4DgRO1Pwv3DzW0gg063STXZdrQGBa03L+SJgktv7
         vV41pN2DVE2hC9qw0oZ1/QVExRl8hNCiFGrO0p9smQdB2E6BNl/aMYpK6HZlLkMBA93U
         zN4Gj3iN4eFg4krXwk/7xohRWlMo5svb4SAAFibt5xxOfTym0xl6WpMuDIwqBJkpWzoC
         wcEhxzbVXKaK3ZRC7sTqd50Gm5C/y5uGj/HLipgDHepvNIzAxkh1SAdBEzbi5hS6E17z
         Gs7w==
X-Forwarded-Encrypted: i=1; AJvYcCWDMhLFmHLfXR9kWdHQgWOQRll3/qj7YduskAcPjlCt1YthxqABLW2OHXVIuWqHQuUlwUFuAj+Dnk+xCErjylY781Ii5wNulsBQRrx8
X-Gm-Message-State: AOJu0YzQPgZoSQBZvF6KBlhqwI97Wim1boHmmvOsqg1jUQIejadjVkkj
	aWb375fKyUjOVC0qj1DEwmkb70/ppFcTbgw1ujhozrijJS5QoUlm85Wg0q+tOhHAP5f67g8ZxEi
	Gp0klOMkZ9wHI51kWX+xiu3/mZjPQ3Pnpfi7G
X-Google-Smtp-Source: AGHT+IH0qAID20MP6jp6NpXqn9mW2kuq00RtO9yb0PwCHdZ99yKuZBY632oWoHKU4JglvZUaklYHu5xGsWpmsCAynaA=
X-Received: by 2002:a17:902:6805:b0:1de:fdbd:930d with SMTP id
 h5-20020a170902680500b001defdbd930dmr312651plk.16.1710954830070; Wed, 20 Mar
 2024 10:13:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240320145417.336208-1-visitorckw@gmail.com> <20240320145417.336208-6-visitorckw@gmail.com>
In-Reply-To: <20240320145417.336208-6-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Wed, 20 Mar 2024 10:13:38 -0700
Message-ID: <CAP-5=fXcWRfsAnByOnX5z6aBJrW6+CLRpj=bQ6uiLM38OZjbRw@mail.gmail.com>
Subject: Re: [PATCH v2 05/15] lib min_heap: Add min_heap_init()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, dm-devel@lists.linux.dev, 
	linux-bcache@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 20, 2024 at 7:54=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com=
> wrote:
>
> Add min_heap_init() for initializing heap with data, nr, and size.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Thanks, is it possible to update lib/test_min_heap.c to use min_heap_init?

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

