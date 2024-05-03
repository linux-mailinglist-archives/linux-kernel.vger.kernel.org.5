Return-Path: <linux-kernel+bounces-167157-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49D7D8BA509
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 03:45:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4D63B1C21DBB
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 01:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C3E317547;
	Fri,  3 May 2024 01:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QSdIChzv"
Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D18DF510
	for <linux-kernel@vger.kernel.org>; Fri,  3 May 2024 01:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714700706; cv=none; b=rVzEvbgOWy//KodU6gO0vXv4Eat/BemtKRMvvuVS7uehFuH5tosJfYf80G9ISUYBEumJxwLopI6W7IPvIHqjLGj9HDBSFYshNwd9r1A8qrncvpwxErQLuQ1hMjy7GOseKxqv2UJUL2INE/wXwG7+ruBLTIq40twWRnb4pDdXlwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714700706; c=relaxed/simple;
	bh=ey+G/MUCESd2sdoi0DGUPvdRUSE5ujEB7MzNjilZVjA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HqxHLyuU/WJ3jP2qn6N9/LbtT9g/fsT0rfWungzzJ9332qmUZehRUwUhzoMIlSDF/8xig0DaI2HWAghDMe777xp2xrU1/Irc0O/Uy85aGseOnj3o/d+8xGzQ7Zu+ZHzBRun65YjXc4Wsc4luHWFPWhjJgk8YiXLwBYKz65FC7so=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QSdIChzv; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-7e043f577c5so1231913241.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 May 2024 18:45:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714700702; x=1715305502; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OBpaufwW255tHTakY+OCArHInOzRj+zykzi7grRdC1U=;
        b=QSdIChzvK+BQA5cQWiTb4CxhP97XO71q4ummreVIhk2zDfkIjibDRkNT/gVwgW3fmP
         xuh0QDzPNf4a6TYid8nOEQ/VyqAgZEdXHoCFQLq3AJK/0VHEmYhLkITU0JYNSmK5Fzzh
         uGiFoSz6I25tLb4HtbdjpzDGEmA/+ZFyHEOdIB6pmv9HH8ELMW8+IJRsTr4NouQ5ihLY
         mEj88a1IrvEN6sQDkSZKtw5/QWy+VcZj7ibhCVOXg2Rl1YZek42yO0gvmDfnaW+ssRM4
         QHsbbmXUYlwGT8RZqV8JZwvf/b0PuRw2yhtEbYWMZqUDBPdxlA2sV5y8gvZbQMF1XHvO
         0n5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714700702; x=1715305502;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OBpaufwW255tHTakY+OCArHInOzRj+zykzi7grRdC1U=;
        b=dkGm2WSylzNALWCazdGDucdWhKq463fgBbf7y+dTimB3okSmlXID9xHofAmgHpC2w8
         4Ytg1fwNWiCbiizPVIA4vh2//9DGPvKmxWr3BAgRKy0y0DXEawMhw4PyEFrUVAIgKrGk
         Ym24L9Yn+Wa/9bXTrDL8+GYefQM+wpVe6/i3o2gu1ty3qpIUs4VTqBnG541e0Oj4Vl5g
         ujmm6B7WFdn/zudWHC2buBq/oHUIso+SwnrBOgrAGeoI69asKjc4fVq75mgC0RSa9mkH
         Xp+DYNAtd7fXW231gxhUi353f0Cc1zdR2sFKpXdc/Yjq5lKGEpHwbhAXi7g89StSqw1b
         5jsQ==
X-Forwarded-Encrypted: i=1; AJvYcCWXBwH7P806mcp2LFxEPwWefMQQC+hN8+GTQ6h072xDmqOuyQolkl6hueugAbikDFlcx3pI1yP9KX4F+nBtPKeGHtSq/FWktSBg7R1d
X-Gm-Message-State: AOJu0YyYw5XhC1gbxwbXScnlTMeyhXSgnZB343QJvBIxzv4R3H1G2iY+
	CvCrFxrzIK38dAccSxwYhYMvf1dQySvNiUZDHPYpBQabtQsPI04IMgoMJYwjpDUBA6nPmLZsmcQ
	Uh6ABoNbiFNWKHAJb5tjPNIBJkfw=
X-Google-Smtp-Source: AGHT+IFZyWmBAJipXUPPt+Uv0QLkbPfwvtGgat1yYkY94P24DIj2C1Oirn7fshUPnUvtMM9lPCqJXhZGWJE6z4SC6r8=
X-Received: by 2002:a67:c58e:0:b0:47b:bda4:c30d with SMTP id
 h14-20020a67c58e000000b0047bbda4c30dmr2040619vsk.3.1714700702183; Thu, 02 May
 2024 18:45:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240502161827.403338-1-pchelkin@ispras.ru> <20240502161827.403338-3-pchelkin@ispras.ru>
In-Reply-To: <20240502161827.403338-3-pchelkin@ispras.ru>
From: Barry Song <21cnbao@gmail.com>
Date: Fri, 3 May 2024 13:44:51 +1200
Message-ID: <CAGsJ_4zKRSnpoepYsw8qiwVHY-ztWYixKjtD7D1SKbhYho=pUw@mail.gmail.com>
Subject: Re: [PATCH 2/2] dma-mapping: benchmark: prevent potential kthread hang
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
> If some of kthreads executing map_benchmark_thread() return with an error
> code (e.g. due to a memory allocation failure), then the next kthreads in
> the array are not stopped and potentially loop for indefinite time.
>
> Call kthread_stop() for each started thread as map_benchmark_thread()
> expects that happening in order to exit.
>
> Found by Linux Verification Center (linuxtesting.org).
>
> Fixes: 65789daa8087 ("dma-mapping: add benchmark support for streaming DM=
A APIs")
> Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
> ---
>  kernel/dma/map_benchmark.c | 12 ++++++++----
>  1 file changed, 8 insertions(+), 4 deletions(-)
>
> diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
> index ea938bc6c7e3..7e39a4690331 100644
> --- a/kernel/dma/map_benchmark.c
> +++ b/kernel/dma/map_benchmark.c
> @@ -140,13 +140,17 @@ static int do_map_benchmark(struct map_benchmark_da=
ta *map)
>
>         msleep_interruptible(map->bparam.seconds * 1000);
>
> -       /* wait for the completion of benchmark threads */
> +       /* wait for the completion of all started benchmark threads */
>         for (i =3D 0; i < threads; i++) {
> -               ret =3D kthread_stop(tsk[i]);
> -               if (ret)
> -                       goto out;
> +               int kthread_ret =3D kthread_stop(tsk[i]);
> +
> +               if (kthread_ret)
> +                       ret =3D kthread_ret;
>         }
>
> +       if (ret)
> +               goto out;
> +

do we still need to do copy_to_user(argp, &map->bparam, sizeof(map->bparam)
after  do_map_benchmark(map) fails?
do we also need the below?
diff --git a/kernel/dma/map_benchmark.c b/kernel/dma/map_benchmark.c
index 02205ab53b7e..28ca165cb62c 100644
--- a/kernel/dma/map_benchmark.c
+++ b/kernel/dma/map_benchmark.c
@@ -252,6 +252,9 @@ static long map_benchmark_ioctl(struct file *file,
unsigned int cmd,
                 * dma_mask changed by benchmark
                 */
                dma_set_mask(map->dev, old_dma_mask);
+
+               if (ret)
+                       return ret;
                break;
        default:
                return -EINVAL;


>         loops =3D atomic64_read(&map->loops);
>         if (likely(loops > 0)) {
>                 u64 map_variance, unmap_variance;
> --
> 2.45.0
>
>

