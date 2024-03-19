Return-Path: <linux-kernel+bounces-108084-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BEC18805BB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:58:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9EBAC284CDA
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:57:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 819A55645E;
	Tue, 19 Mar 2024 19:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="qxt/eEnk"
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D43B55644E
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 19:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878268; cv=none; b=E7hsr0LqwFmhZyCy+Vx+CBxp2lLNKbfeSX1rvaqiGb3dNjqmEWapal/MOmcScpisnYN7lR+1tclqyKOyQu5qNAkMiUIknMTiN3NsmjEmax6woCdt6LI6Doi1GQblIuia0ggW7WxYCSV2xdnZd3ioNOPVCamqNrf2h4qRPK3mUAo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878268; c=relaxed/simple;
	bh=35ecHv+9qehFof6aQVy5gVpDqX2M7KB4dSVOdvgkfjI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ngVzRs2tO9j4rUO2pAJHn07a8ityjg0okDIJRBk9wql3Y5d4Ma/MXPsOu85Hc4y99kbWpVQeJhKtJ/LB+P8LIdQ6tS8ITRTMglAo9GO/bSxY0JeOSwkkSq/aYMnY0VxRU22uTvKmAc2eWfloew4ihxb4Ut4Q03n2KkPPxKxhFZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qxt/eEnk; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dee917abd5so2545ad.1
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 12:57:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710878266; x=1711483066; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XettUXCUytZxztvpokYxesf4Q1Gu8ZAwELXRrBrtnls=;
        b=qxt/eEnksrGJ5ouZYznivYm05QiHTopSEQZRyzP0QhGvv6qqwj4Sr257nyPbeAh63u
         JawtAqqrK5BYrzqnylj6GKRV5DFBNHB078tj5MNhuQPwZsSdTdYzMLjmY+imiKW7wNGm
         6LP/9VEQOCTPFdjbD8JU2G00/8Sd1aHDm0W9MiInLYRHl2JNc6ncK38slDesUM6SqaZP
         pQXu9poVSYHVzkl/f8cg7YYWoXw8MX+2puYi03Vkn2RUvTtm10RmWcl/YKJOlH4Y5xGc
         hSa7Fa10b61UUD8+ntODsrJJSnPO3N2iLoAcuFkfTrmwJjVFuru3HcCpNUS0N8NYRint
         PYHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878266; x=1711483066;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XettUXCUytZxztvpokYxesf4Q1Gu8ZAwELXRrBrtnls=;
        b=Za8SpVXD8zS6KjumwbTRg7+5EJFoGd9dPoZxBjBUmkYyusU/ybsBOakA+Epe5uB2d5
         oULuokq0JeCWiwJ1TZ6nJTYwA/3zBWySbmwoDNiP2lV2fjV54cfWmPh0Wd0MehbJkQ7g
         e7DfB0OEZFSLKk+dfRmwrtbg8fGH+GrkKJFOs/FHeRiF2saGTqQ0ZBPPgjJxVAvDJLF5
         d1fmUf42gLJ3/pEkYXKrrQyaUcMcRFeId7Hrgz66/5RaDLBUNUqE6Aelm46BT/jPH3MI
         VrzS2wr22kfmAvj9FqfryNNNk9OR7Pd25apk/VmYGWFKbr955F1EA8j7N3hcR49GTLeR
         pLvA==
X-Forwarded-Encrypted: i=1; AJvYcCVcUe+yJUiiP9azXq7UrjFup4YVnCowFl4gc4yimAGufxa9u6S3o4z8oTmV9g888sIxzSU8mzWZYASwLQFoIGdrrgxSGN7UiKF3YoeY
X-Gm-Message-State: AOJu0YyJVcvS7A4ItoK6qTDiuiCPllVPkuJscX9rGbSrlad6WqYllUo5
	ceG2f/gydTUIASph6uVgxaUPLXpeTNfXRokx1PJjdJoc1WaeFfAt96ajResHNLymag/UUM1uhQs
	arnZFrRPjcMGstPqcqSA0sWcLPlFh9cRihlwG
X-Google-Smtp-Source: AGHT+IGhJBZPV5sgsvA1Ag4NPK7bHjOsEVeBT2FsY6a3D5GhexHGoEVe1DyqNZMv3VMEmxrkmDela6UPobccY4gXZ38=
X-Received: by 2002:a17:903:230a:b0:1dd:b505:d518 with SMTP id
 d10-20020a170903230a00b001ddb505d518mr62555plh.22.1710878265724; Tue, 19 Mar
 2024 12:57:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240319180005.246930-1-visitorckw@gmail.com> <20240319180005.246930-10-visitorckw@gmail.com>
In-Reply-To: <20240319180005.246930-10-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Tue, 19 Mar 2024 12:57:34 -0700
Message-ID: <CAP-5=fUkm-BxztTFUUsWk=VrksWD=Sb+zo0+Y8peX=c5icbqmw@mail.gmail.com>
Subject: Re: [PATCH 09/13] lib min_heap: Update min_heap_push() and
 min_heap_pop() to return bool values
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
> Modify the min_heap_push() and min_heap_pop() to return a boolean
> value. They now return false when the operation fails and true when it
> succeeds.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Nice change.

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 97d8ba5c32e6..154ac2102114 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -130,18 +130,20 @@ void __min_heapify_all(struct __min_heap *heap, siz=
e_t elem_size,
>
>  /* Remove minimum element from the heap, O(log2(nr)). */
>  static __always_inline
> -void __min_heap_pop(struct __min_heap *heap, size_t elem_size,
> +bool __min_heap_pop(struct __min_heap *heap, size_t elem_size,
>                 const struct min_heap_callbacks *func, void *args)
>  {
>         void *data =3D heap->data;
>
>         if (WARN_ONCE(heap->nr <=3D 0, "Popping an empty heap"))
> -               return;
> +               return false;
>
>         /* Place last element at the root (position 0) and then sift down=
 */
>         heap->nr--;
>         memcpy(data, data + (heap->nr * elem_size), elem_size);
>         __min_heapify(heap, 0, elem_size, func, args);
> +
> +       return true;
>  }
>
>  #define min_heap_pop(_heap, _func, _args)      \
> @@ -167,7 +169,7 @@ void __min_heap_pop_push(struct __min_heap *heap,
>
>  /* Push an element on to the heap, O(log2(nr)). */
>  static __always_inline
> -void __min_heap_push(struct __min_heap *heap, const void *element, size_=
t elem_size,
> +bool __min_heap_push(struct __min_heap *heap, const void *element, size_=
t elem_size,
>                 const struct min_heap_callbacks *func, void *args)
>  {
>         void *data =3D heap->data;
> @@ -175,7 +177,7 @@ void __min_heap_push(struct __min_heap *heap, const v=
oid *element, size_t elem_s
>         int pos;
>
>         if (WARN_ONCE(heap->nr >=3D heap->size, "Pushing on a full heap")=
)
> -               return;
> +               return false;
>
>         /* Place at the end of data. */
>         pos =3D heap->nr;
> @@ -190,6 +192,8 @@ void __min_heap_push(struct __min_heap *heap, const v=
oid *element, size_t elem_s
>                         break;
>                 func->swp(parent, child, args);
>         }
> +
> +       return true;
>  }
>
>  #define min_heap_push(_heap, _element, _func, _args)   \
> --
> 2.34.1
>

