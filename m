Return-Path: <linux-kernel+bounces-108093-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA8D8805DC
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 21:09:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC999B21B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 20:09:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 555D154BEA;
	Tue, 19 Mar 2024 20:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="q/MBsCzv"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B9254665
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 20:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710878948; cv=none; b=bbE8HZgJCySp7ih5KF8W+XjvLv6Nsq0AtuFpSmpszx5KfNxO6Czd2JezHruZNPqixNyBtSdmBLlPa+r03mQknXvOvpNCdaYXgfgti0JVtH3HGZuHXYWnV0yTbUMdS0ehoXdDajNOcrqNc4uYv24hyDhamANFw/ysK1C3wr/PmDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710878948; c=relaxed/simple;
	bh=Ixzw19Ky+N8iJ48JNY0yM/7VDu4T9UHfcK9V04LE5jo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dt+YdjGGr8nThh2W7knuqxXEU/ANq/parM2OTgRv5wZW8IegyaDquXYsBLjboTJr+NH1OXtMp+rEFFjuaDh/FVCdQ7RYVzwukb8KH4YDeiC4Sz3ba9TmFhPKfFVhF01iGq2nIcIY0W5plySV3Z5cqRtwjI3PP0qT+noA/lHtNEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=q/MBsCzv; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a46d9fbb5a5so171441766b.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 13:09:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1710878945; x=1711483745; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HwfgyBIzjXd0CLtWmjCy0jIs1nMeq6X0wQLJWRmd4lk=;
        b=q/MBsCzvuD83IMV66y0K/cE8/rNKHLFHU7v/0zw/deqSzCXV2q8cBIHf6Lmd6xw5MC
         uUCKeUWpQZrCFaaeA+CtFmVYUhegg4nHagpn/z4dWq0NNdGiGFApZd2zM8+gsn0LVHO2
         mDtZ46bl/SZ9+XMLe1A/jpgNLvI0a4iv6pSCAekjd2JbjA9SWvyhbTGiqflUBTDUTz/V
         Cs47B4z/Wy1eqmKa5+5vRh4IwLvKU+Q5otgLOGRGhGhaIFum3b/FNZHSgn646u5f6j0S
         q+ZnPLc82Zoh1wr0DQKTj03/dXjbY/NdkaBulWh2QYgOQ4+EIWdIJU9lZkJdddntx0KI
         nTIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710878945; x=1711483745;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HwfgyBIzjXd0CLtWmjCy0jIs1nMeq6X0wQLJWRmd4lk=;
        b=YoCzE3iNlrRKDquut7JcAXXBfGBgUm5zdMOxJTWSlOoi7TcwbP/s/WIQZv7/gn+EUt
         vsd4px9FBkCWa9IPvwcl6MrvK7QjjkItYwxt/z8EhF+ps5t1O6MJklR209CXo5PB5SSG
         XAfzJy8dboDM9ILip6XFG66R43HNnfv7XpfuGBcBFZenGU5GvWbnnbp9qdqI6SWEWixL
         aiS+pZUl66T7CJ2wMefETen7Rf4sa+Q+nyOzypOKXMqsjhzigIvS7IWnOqcCJSB31pDH
         ZxR3hsQLSOF0AQwhoS6L1e6V7tMzfubzcAEX5U0PV+ymFR4YZC/H2xzwj2DcEZ/yVA44
         m+gQ==
X-Forwarded-Encrypted: i=1; AJvYcCVVxuriFiGQJ0FGs5BfnEl8tPyHDp1bZXYNwddEli5EIhn5EirpYaKzgdT8wjcNiVpNCQ1ozajm2aXSjGFSL2awGdsLcIDlFlxBVuvx
X-Gm-Message-State: AOJu0YxXxuqVccVgvrroUHlQWNdCUbLJ4XFbPWc9PGyZhr1IjwNyzMIz
	dFoIVc2satWglFp3CodByCZFhzMc3xYWeTVfCEM4JNExicI5qYb0Y8TYYINstpYDlJcB38m980r
	0wziwexKpl6q4iCSEWhy0Y5/KfTPqDw8tPvLm
X-Google-Smtp-Source: AGHT+IHcVNlW/4L9ZJSX+w0WIeNkV/d9UqRMZ7mkUjxPj4cCE/k/HU4FvxUq0OXNwVJOULhDDu4CaV3pI4La9qhMz+4=
X-Received: by 2002:a17:906:3e07:b0:a46:8d30:b91c with SMTP id
 k7-20020a1709063e0700b00a468d30b91cmr2101884eji.34.1710878945094; Tue, 19 Mar
 2024 13:09:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240311194346.2291333-1-yosryahmed@google.com>
In-Reply-To: <20240311194346.2291333-1-yosryahmed@google.com>
From: Yosry Ahmed <yosryahmed@google.com>
Date: Tue, 19 Mar 2024 13:08:26 -0700
Message-ID: <CAJD7tkYy=e_qkpu64y57o1cWs7RN7PwWgPoFamJu1YDjj_s=kw@mail.gmail.com>
Subject: Re: [PATCH] percpu: clean up all mappings when pcpu_map_pages() fails
To: Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>, Christoph Lameter <cl@linux.com>, 
	Andrew Morton <akpm@linux-foundation.org>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 11, 2024 at 12:43=E2=80=AFPM Yosry Ahmed <yosryahmed@google.com=
> wrote:
>
> In pcpu_map_pages(), if __pcpu_map_pages() fails on a CPU, we call
> __pcpu_unmap_pages() to clean up mappings on all CPUs where mappings
> were created, but not on the CPU where __pcpu_map_pages() fails.
>
> __pcpu_map_pages() and __pcpu_unmap_pages() are wrappers around
> vmap_pages_range_noflush() and vunmap_range_noflush(). All other callers
> of vmap_pages_range_noflush() call vunmap_range_noflush() when mapping
> fails, except pcpu_map_pages(). The reason could be that partial
> mappings may be left behind from a failed mapping attempt.
>
> Call __pcpu_unmap_pages() for the failed CPU as well in
> pcpu_map_pages().
>
> This was found by code inspection, no failures or bugs were observed.
>
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Any thoughts about this change? Should I resend next week after the
merge window?

> ---
>
> Perhaps the reason __pcpu_unmap_pages() is not currently being called
> for the failed CPU is that the size and alignment requirements make sure
> we never leave any partial mappings behind? I have no idea. Nonetheless,
> I think we want this change as that could be fragile, and is
> inconsistent with other callers.
>
> ---
>  mm/percpu-vm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/mm/percpu-vm.c b/mm/percpu-vm.c
> index 2054c9213c433..cd69caf6aa8d8 100644
> --- a/mm/percpu-vm.c
> +++ b/mm/percpu-vm.c
> @@ -231,10 +231,10 @@ static int pcpu_map_pages(struct pcpu_chunk *chunk,
>         return 0;
>  err:
>         for_each_possible_cpu(tcpu) {
> -               if (tcpu =3D=3D cpu)
> -                       break;
>                 __pcpu_unmap_pages(pcpu_chunk_addr(chunk, tcpu, page_star=
t),
>                                    page_end - page_start);
> +               if (tcpu =3D=3D cpu)
> +                       break;
>         }
>         pcpu_post_unmap_tlb_flush(chunk, page_start, page_end);
>         return err;
> --
> 2.44.0.278.ge034bb2e1d-goog
>

