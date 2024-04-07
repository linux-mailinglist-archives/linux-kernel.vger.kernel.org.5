Return-Path: <linux-kernel+bounces-134620-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 25E1E89B3C0
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 21:11:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 129581C21490
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Apr 2024 19:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EC463D0AF;
	Sun,  7 Apr 2024 19:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="twdFLsYO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464303D0AD
	for <linux-kernel@vger.kernel.org>; Sun,  7 Apr 2024 19:10:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712517055; cv=none; b=Yaabbp84tUlA58BQZOrxH5tCqexmldZ7jlucOjHbWTzC7vLFhG5WD+Kmnec+slaG/3Hzzbmb8Ma+fXq88zHUeonVTd+mcEflbJO5n/ogdgok2+P0BGUz6fnZV28ABUZScWmp5ULKZ1KrsUSd0PZLPNCdeE+YNctz/L+O/Jx9b8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712517055; c=relaxed/simple;
	bh=70HHBEd6cxrXlLkgbwjfvu3LYrWt/mT4YkQDDZ2MPi0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HKO+uU1sg1ZjopsIBD7QWydAENv2Zvhwf33210yTAZiwv2pac52A3u6zongRSlLr+fnFhbzQ3XF/1+IK/oupqNZ1eVDGFVFnxLWniSN23yfB6M/+bB+AWQYG5QbQf4J7vrIj0Bus83u1f1XF0KIEXzKkImYO6Osz5IaeZWhKeuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=twdFLsYO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e42a6158d5so14235ad.0
        for <linux-kernel@vger.kernel.org>; Sun, 07 Apr 2024 12:10:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712517053; x=1713121853; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x6EUWLXyMd/QrPrA543Vnpb+tkAZZfWHn9rSEQeDI00=;
        b=twdFLsYOYbDEG5VMd/NJt3yra0CScuu6rLvDlvzD0/UcM3ccsSLLWrFRme5S+Qw4tc
         4AY8PNP5cS4iwCjKeWSUZvUbK4MwXP6J37sY0+2ec0UvZFPji/4xxe/VoNNkX6mhwJLC
         hu1+sVaI9v8ro30Kh9TSdyJCvVyrAnB4tSZd6oDpmHx+P1UgL64ssFvTGjV6VdDe3Bwl
         NIIrwkY261Swzjqh5E3Jxh64m+RJzck+Y3HdCqlFgX+7BqC7cVE8eB5tnujEwkgKkqEG
         wOJ+UEfcVumZZ8F5KdDvPayNoa3ekqecmz9NsZiJeQ4n/MsY3l99qQ8MMohBqtBzuUby
         QHfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712517053; x=1713121853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x6EUWLXyMd/QrPrA543Vnpb+tkAZZfWHn9rSEQeDI00=;
        b=LB8t//+8dgM7uAU2H6dVFgkcZuvIVyzH71PASSwTuR/zehfBSYac8RdMhdfCLixR78
         OapGKjxqB78EsWmNmR8tZ/8alDj8WmU2uqW87IGjNGZkWEt4wrZo6X8vZ2E8lyE/m7Jk
         ZNBB4d3Nl7BTa1kG+BI2ZrQsWRhEe65nmY+dVNHoTNm15qz46HGs7+YaimbJk/tyYAvM
         ZSPWia26COJOopdfhunx46uIIYCLF835lH8q2Do8Igr+hD0R+/yJ/Lmw33Am9dZYCmUk
         AapdWuamapWXNf65xtMZdHU+ZPQerWcfBnU4se7KzYLgAhCwn2qrKvg+fSz84CrM4Us2
         R9pA==
X-Forwarded-Encrypted: i=1; AJvYcCW/i7s7LL7zU88SDbVmgTpCipMJMuh9RETNOm3d06rtlikryGqjGe67GL51MlRv0za8PEEhPaf6Iu9yDndATqriSErBkupU5LiOxvRd
X-Gm-Message-State: AOJu0YzpVuMmKmmVo2dzd7MB1L0qC0nEgckf5KTWJbT/B6OaiI31a1Rh
	y98SM/PgDHCdSkpwXHlyVUjcBOtycuifs09Kk7PgAFX/2mhy7FLTvtUH+VpCQvAbclMDiuVixEf
	NkW3unHZIbdu2ima/mVLPPke0nH4LZZPhXA56
X-Google-Smtp-Source: AGHT+IF3K6r9xbBJkilZy6HGKb6dlLXRf6FqatUAZbCIWOQ+wDqVm5LXVF61yEKWVnLToUGV3EtmibzNbcvolpkp1/g=
X-Received: by 2002:a17:903:32c9:b0:1e3:c1a9:ed7e with SMTP id
 i9-20020a17090332c900b001e3c1a9ed7emr176673plr.25.1712517053266; Sun, 07 Apr
 2024 12:10:53 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240406164727.577914-1-visitorckw@gmail.com> <20240406164727.577914-10-visitorckw@gmail.com>
In-Reply-To: <20240406164727.577914-10-visitorckw@gmail.com>
From: Ian Rogers <irogers@google.com>
Date: Sun, 7 Apr 2024 12:10:42 -0700
Message-ID: <CAP-5=fWb3eNe3mufRJjPAc=jcHFiHYpPqLuK2H8YiijHu0rLZw@mail.gmail.com>
Subject: Re: [PATCH v3 09/17] lib min_heap: Add min_heap_sift_up()
To: Kuan-Wei Chiu <visitorckw@gmail.com>
Cc: colyli@suse.de, kent.overstreet@linux.dev, msakai@redhat.com, 
	peterz@infradead.org, mingo@redhat.com, acme@kernel.org, namhyung@kernel.org, 
	akpm@linux-foundation.org, bfoster@redhat.com, mark.rutland@arm.com, 
	alexander.shishkin@linux.intel.com, jolsa@kernel.org, adrian.hunter@intel.com, 
	jserv@ccns.ncku.edu.tw, linux-bcache@vger.kernel.org, 
	linux-kernel@vger.kernel.org, dm-devel@lists.linux.dev, 
	linux-bcachefs@vger.kernel.org, linux-perf-users@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Apr 6, 2024 at 9:48=E2=80=AFAM Kuan-Wei Chiu <visitorckw@gmail.com>=
 wrote:
>
> Add min_heap_sift_up() to sift up the element at index 'idx' in the
> heap.
>
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>

Reviewed-by: Ian Rogers <irogers@google.com>

Thanks,
Ian

> ---
>  include/linux/min_heap.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
> diff --git a/include/linux/min_heap.h b/include/linux/min_heap.h
> index 9391f7cc9da9..201f59cb3558 100644
> --- a/include/linux/min_heap.h
> +++ b/include/linux/min_heap.h
> @@ -111,6 +111,26 @@ void __min_heapify(min_heap_char *heap, int pos, siz=
e_t elem_size,
>  #define min_heapify(_heap, _pos, _func, _args) \
>         __min_heapify((min_heap_char *)_heap, _pos, __minheap_obj_size(_h=
eap), _func, _args)
>
> +/* Sift up ith element from the heap, O(log2(nr)). */
> +static __always_inline
> +void __min_heap_sift_up(min_heap_char *heap, size_t elem_size, size_t id=
x,
> +               const struct min_heap_callbacks *func, void *args)
> +{
> +       void *data =3D heap->data;
> +       size_t parent;
> +
> +       while (idx) {
> +               parent =3D (idx - 1) / 2;
> +               if (func->less(data + parent * elem_size, data + idx * el=
em_size, args))
> +                       break;
> +               func->swp(data + parent * elem_size, data + idx * elem_si=
ze, args);
> +               idx =3D parent;
> +       }
> +}
> +
> +#define min_heap_sift_up(_heap, _idx, _func, _args)    \
> +       __min_heap_sift_up((min_heap_char *)_heap, __minheap_obj_size(_he=
ap), _idx, _func, _args)
> +
>  /* Floyd's approach to heapification that is O(nr). */
>  static __always_inline
>  void __min_heapify_all(min_heap_char *heap, size_t elem_size,
> --
> 2.34.1
>

