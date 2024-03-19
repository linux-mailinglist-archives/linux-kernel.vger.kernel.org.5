Return-Path: <linux-kernel+bounces-108085-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 680368805BF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:59:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B591F22D88
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A45455645E;
	Tue, 19 Mar 2024 19:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="mK7AsmiD"
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 902B739FFB
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878386; cv=none; b=swdGmjUvFuUcdO3fTD1kuhPAujvC/30RVhDRn7+5uk0yJxeGjd1I8g6X3F8SsgSGerJgllOvnjCOyq2XfYpJsHUbr9lWjGUJa5f/tFHeSVuTrtHBTWgKF2004tKwOuu37g/lJ+aL6Rrg4O/NSKvURR8rZe4yXWyqNNbsMNExsVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878386; c=relaxed/simple;
	bh=5F9GV5774xtDFEEGdDVdO5yEYWYXmfsvieiNhJPNsC8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SUVnEzhqdxrcj7EatocaR6u+T5eM/4chglIPzBOJeLcXQJV+nmH4pnTUuB+H81YKM3wSCcOUTUi6B6t/hcrDgbRO+2mgoBM3XK6VWi+npYwG2BA5wBRQFOHhh/jgs/I+yJPZZ0SmtDIrg1cf4pRXIipUha0HdrxqB8RtTpD0jZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mK7AsmiD; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1e058b9e479so25745ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710878384; x=1711483184; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DobisIZIdWT5fAMjugODSdKj/CsBUKizI1tCDIITWoc=;
        b=mK7AsmiDoHfrkG5ox8Iqi92M23TWxzowYMPMYpzWVAfjgcSVyiuhr1DtULGd+ZfHi/
         XlAKCxRApRxSLkaXn/MSfvsL5BNywkFFYcjkd/DtyM60AjZymj5RnLmJubBbeDOauTlz
         C6q6orx8hFmGcQ1mv5N6vHxlCr56lU+m121GKdFYffRTXBV0OTrZqeASKJJ9z4WbflNg
         Leh7I1ztnfYkW0eH4J9dCvsgKqpTt8u3v2W5wXObqHr1FbJNItKuQtZnDMiO3iwhsmXy
         G30cjJqF1WNn4BnHT6GdBHpXARhf1Kvon1XpF41scbwHqXLDhHgho0wGyMr06Ux/d/Ps
         YEbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878384; x=1711483184;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DobisIZIdWT5fAMjugODSdKj/CsBUKizI1tCDIITWoc=;
        b=HolklwW6Ol9J10ikBMGh6xyAdFyFI5XZEEdufl7vFbg5qktR361uO0dEFxVVnXuISi
         P7R5SaArulejLAJ+5/UCBYS1F7l5d4ZIP06JiBZeixxUqdP2x1bMYqXQ3jzQIHFnXHrR
         fTbInprep0ztE28XvTD4V4yHChaB/r5sQ/h8DcdUz0yfzq+N2X2TvRRXUNXHuCHqC+8O
         jROwjQGVFirNT63PbtJKQMmCD+vKHSp1u8+KzIsrv3akyZ4QWjcSivYUqpFetJ2WgqKD
         0HU6xaBUIktvypFCUr1oJFOinKEaANMlVMJdSnMGaQkMWlGRQFxOk9VsTbhXnnPG9mGP
         /WJQ==
X-Forwarded-Encrypted: i=1; AJvYcCUySWUWVcRzlnIAlCRHgiUJe4LMHhVUThDZQcth5VX39MOGfQNVKxaPrCkOgT6ncg5xRYMnyKWgqK+vmqciGtobQ8ZXF+5mtJGYjcot
X-Gm-Message-State: AOJu0YwQR5y+EJv6iJV6iffMljfPIJBXuouyYMihjklLbl9b2ayVkRMZ
	59BlfsRIpCSVl1Q1Ay1Rx2PyizQjK/ltAHu9hpTg/VxNz1ZVcGew80rMsvGtxwXLNxexunmN8eV
	JNAlZeEXSpuFOGs3owMCAinTBgQbMFxqkCa9+
X-Google-Smtp-Source: AGHT+IHKYWLHUpxloLUH+NKyvBuPDnmTq249MWbzWivuQqJ4VjbGHKTaD+z9zajEi+vi9n0XoP3Own5xUGSSExIU1xI=
X-Received: by 2002:a17:902:d4c6:b0:1dd:b010:8339 with SMTP id
 o6-20020a170902d4c600b001ddb0108339mr65089plg.8.1710878383639; Tue, 19 Mar
 2024 12:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-12-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-12-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 12:59:32 -0700
Message-ID: <CAP-5=fXKU9uS-F=G5q8jEdCGC8tS9uM52TKjHOE9aP7yXb6RaQ@mail.gmail.com>
Subject: Re: [PATCH 11/13] lib min_heap: Add min_heap_del()
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

On Tue, Mar 19, 2024 at 11:01=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.co=
m> wrote:
>
> Add min_heap_del() to delete the element at index 'idx' in the heap.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 24 ++++++++++++++++++++++++
>  1 file changed, 24 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 154ac2102114..ce085137fce7 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -199,4 +199,28 @@ bool __min_heap_push(struct __min_heap *heap, const =
void *element, size_t elem_s
>  #define min_heap_push(_heap, _element, _func, _args)   \
>         __min_heap_push(&(_heap)->heap, _element, __minheap_obj_size(_hea=
p), _func, _args)
>
> +/* Remove ith element from the heap, O(log2(nr)). */
> +static __always_inline
> +bool __min_heap_del(struct __min_heap *heap, size_t elem_size, size_t id=
x,
> +               const struct min_heap_callbacks *func, void *args)
> +{
> +       void *data =3D heap->data;
> +
> +       if (WARN_ONCE(heap->nr <=3D 0, "Popping an empty heap"))
> +               return false;
> +
> +       /* Place last element at the root (position 0) and then sift down=
 */
> +       heap->nr--;
> +       if (idx =3D=3D heap->nr)
> +               return true;
> +       memcpy(data, data + (heap->nr * elem_size), elem_size);
> +       __min_heap_sift_up(heap, elem_size, idx, func, args);
> +       __min_heapify(heap, idx, elem_size, func, args);
> +
> +       return true;
> +}
> +
> +#define min_heap_del(_heap, _idx, _func, _args)        \
> +       __min_heap_del(&(_heap)->heap, __minheap_obj_size(_heap), _idx, _=
func, _args)
> +
>  #endif /* _LINUX_MIN_HEAP_H */
> --
> 2.34.1
>

