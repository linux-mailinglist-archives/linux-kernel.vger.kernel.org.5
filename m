Return-Path: <linux-kernel+bounces-167148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 33A8A8BA4F2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:36:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DDD0F284591
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88BFAEAC5;
	Fri,  3 May 2024 01:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vn7hWOkr"
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D353FC11
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:36:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700203; cv=none; b=R0uyFQkkW2u6+ZblGUng1KjRimgJ+71GDfZJJ+bDOIuV3RFaiwuq/GosLVw/xD2EO2J2pcZVzgAgdG7P/3ejnBH8ecbL0SpNpNNAXjLWq+OGaIhTBoso7S+Hhj6uZVf498tfkf2E4RDjA5FjU8ggtE5ncWO5kqOK5Uk3r8NEebM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700203; c=relaxed/simple;
	bh=RKeSGwVWMd/kRozhUIAFCmzXmnNvyig96sBUiNLx3S0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UZSH0SLNhX3ctfIY6F908IgcRiZg8wTd1PDmscyoyCoBy1vthF8WrxTG/UnCY7kEBJmT0y7AJ+kMxuMFV05NIU03n/xu7hr+nQiEXz/wLVtj+q4Jn9ukASirdDLJdZGuS2BoMaGSFeQQlnz+vY7aKfmTEdM6PPEetkB3nrrmWIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vn7hWOkr; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-4affeacaff9so1800496e0c.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714700201; x=1715305001; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nrFyQBGNythIvg6X/90l73Utbc1IO7PWL/H9UUkOuvA=;
        b=Vn7hWOkr7sxkqOcGqOSrG3TqeML/MWFExD6HbA0pBLa/ULODmIICrcLOQgaQdIQtY7
         gMpdH2XLhLLXMgol1N1rNF5nYchhzBXiR9oP081NKgt5jQlcfW4G1nqlgZhMg0RWnLJz
         ddwxHBqf2Tf11E8p+cPbb6FVGQ0pHXwYNH/aS9/AlLky/K5xJiwv5+daf8oPM3S17oVT
         35+pNv13k/8YRtBqkiA5gTf2JWCfmQbchilrFk8ntX1KHyH/59k41uAZ6xYvUZu9Cr4Q
         4q2Naj7jic9+JnXzuygaBw39j1jez7BFN+66Wd5iu+rMBCU/0/tobHkRuwPUHr0frbkW
         Cf4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714700201; x=1715305001;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nrFyQBGNythIvg6X/90l73Utbc1IO7PWL/H9UUkOuvA=;
        b=hau4tEiW1LM4moI0cW9i7WJPQHLe3mNkQ9gB4FgQaqiqeayAS6gCj2gncwrPX1MwJq
         MKlNsPbZ32kmERNuIIFcbc20GKuLY+PhOSOf2RHx64T019x30vGMIVWfsK9I7/7dvqFn
         8krWnd7Teo2k7qVBdzsC6mBqdWrIvRJ1l1XJaZKVrTevuyjg+BLjGY0/b+dnc3Ga4xIH
         p5MYSF7dMtqzCI9shJ/dky/b8Cb45VGO+NufgeOwIxjyYEs7v1Zq9aPNrt2AuWIGWua6
         cBZ4bjdWmSOfS2rjxx5hJ3RmEDXdC16ReiCYYMQgcNflnJzjiIqKVj0892myX4CMRTaf
         vt3w==
X-Forwarded-Encrypted: i=1; AJvYcCWBoEFBYlCKc0MM+g5M4eGsJEDgSRYXmLJJTiimnW2+yDFARp5U7SCVl00ExSL7F4y/B36c1kO7i9kKJgG7bFrkrswnY70qQ1y+o52a
X-Gm-Message-State: AOJu0Yx3IXcdPU1RkiWPMeuaazvySEzOlEqHzArrCzmXiWlLF4p5YaYx
	2t3DJkTgUlj6NMiNbDa/x2yGxKk+A7pi0vYbzTXuxJRpPB0gfw8nq5/0me4lAjP4IcSNBQ7h4oI
	tzsgGM5TSjlgvVS1Qu7eNdBKoVJ4=
X-Google-Smtp-Source: AGHT+IHhMmjUuWPdCPTy+Ube8hlzNh3C48it5jM9NxcPeKrEiHu+1RTJ82EoLDet+hq4ITJpu4qrY8AkGZ3kbXfppNk=
X-Received: by 2002:a05:6122:459b:b0:4d4:20fa:eb0c with SMTP id
 de27-20020a056122459b00b004d420faeb0cmr1725015vkb.5.1714700201313; Thu, 02
 May 2024 18:36:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502161827.403338-1-pchelkin@ispras.ru> <20240502161827.403338-2-pchelkin@ispras.ru>
In-Reply-To: <20240502161827.403338-2-pchelkin@ispras.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 3 May 2024 13:36:30 +1200
Message-ID: <CAGsJ_4yFzR2RYBsLX2oqUHZpzySfT=0rtt6F71hkbFp1iqxCAA@mail.gmail.com>
Subject: Re: [PATCH 1/2] dma-mapping: benchmark: fix up kthread creation error handling
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Xiang Chen <chenxiang66@hisilicon.com>, Christoph Hellwig <hch@lst.de>, 
	Marek Szyprowski <m.szyprowski@samsung.com>, Robin Murphy <robin.murphy@arm.com>, 
	Barry Song <song.bao.hua@hisilicon.com>, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org, Alexey Khoroshilov <khoroshilov@ispras.ru>, 
	lvc-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, May 3, 2024 at 4:29=E2=80=AFAM Fedor Pchelkin <pchelkin@ispras.ru> =
wrote:
>
> If a kthread creation fails for some reason then uninitialized members of
> the tasks array will be accessed on the error path since it is allocated
> by kmalloc_array().
>
> Limit the bound in such case.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DM=
A APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---

Reviewed-by: Barry Song <baohua@kernel.org>

>  kernel/dma/map_benchmark.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index 02205ab53b7e..ea938bc6c7e3 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -118,6 +118,7 @@ static int do_map_benchmark(struct map_benchmark_data=
 *map)
>                 if (IS_ERR(tsk[i])) {
>                         pr_err("create dma_map thread failed\n");
>                         ret =3D PTR_ERR(tsk[i]);
> +                       threads =3D i;
>                         goto out;
>                 }
>
> --
> 2.45.0
>
>

