Return-Path: <linux-kernel+bounces-121931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6182C88EFA0
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 20:58:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9349D1C2D464
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Mar 2024 19:58:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4BA11509AE;
	Wed, 27 Mar 2024 19:58:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="sWoZ4XjS"
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B9D4F208
	for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711569531; cv=none; b=aa140KQnkJlHgVDwerVF45qKTl5EmjF/oX2V0weNmoTgEiWv71jqNQ993QcRS6hExT+Lb70FYcJVUEbiZNDJq+6650ydBSES1AC5luVxhlPU1LuJbBuBnu/QJ9riqEi7ZaVg4uVjS1jb/GITtjNFi5F1CP/o4RAAE8/g5QwKuT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711569531; c=relaxed/simple;
	bh=kig2wHTCIiVlXqQt6dv3n0T1BiWHomzL4X5SmooCSt8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ml5RTfTxWhpyCcIfJ2X8k3eZxHVj2qeaq/bQJ9wV84uhng5+gt1BwXHwtLb/iMHrTtkF3HFhjDCfYE3CL/6IyYfuUsM3o158VbXGKZ0Ye7yS49PMThHH9fIrZwDa21HVg0c6iF4KLXLNh0R/BcWNw/0PdXsjVJAr+37w18GDCDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=sWoZ4XjS; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-dd02fb9a31cso165858276.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Mar 2024 12:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1711569529; x=1712174329; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3Qfpkbf5kbLfq8llRgT5p/4WuFc6Zn4iFP/1MSmSzOc=;
        b=sWoZ4XjSwdsBKHG9O6fH5XWdASKTDQ+Ac0tNKoWGbgC6CmtctcrCVFtVJZLuO4GHiu
         SS8h/mc+h3vptosQqCaFscvCpRC0T2iqKFnrzlM6JZqOk/W0/hiykxFZAypiSfutc6lJ
         FJxAsakoGiihchoLSg5+KraiQ1Bqid+h1iiVQMMeq/+QgfcOtBBJkQUNWE5AoWALYIOe
         ewtIEJ5EjLxUJvtkvtBeMPwvSMUKOhrB0+oYtGAlZ0sFIDE2Ca/1y55gW/sKrSucwD5N
         R43rGiqkqSyDVyB18A89vnN+k8v3T2sKsLY2qjivEec+m/UJ9iea/7cJK12s+TaJlDYH
         lM7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711569529; x=1712174329;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3Qfpkbf5kbLfq8llRgT5p/4WuFc6Zn4iFP/1MSmSzOc=;
        b=b5R2S9hQ3QUHwjU1IVlH08vKeVyyPcNyM93xSTm6It9d07KFIepsYv4i37JaR1giLB
         4ALQSd3V+h/jxzg0NxFcxp6aYgbD0m7U9h9GwgwJpKYJqQoXFN4ulqY4dye888zhRbZG
         i2pU9vqg1HyHzBS7JtgxccivG3KdlWXiXDxbT40bvz4aIz4i5+OmmtMq+F3fQbMSREkH
         /ZoAqqZh9/88Ly0aF+BCdj2EG+NrEEmnJyUvUAfPAUKDDM9RYlhyTwqRrNSG+Zf9TlPU
         zREMX09YS+om8hrpMg+7Wj/15Hn3hvsx/vfhQWkBhJVP/rekth5LfGIk8l+ek7iLO2Tw
         j6Rg==
X-Gm-Message-State: AOJu0Yw5hQDHhMFoi+hG8fx+LbX+NvbSwRZmRQQHNCrey9nwr1urD+rV
	vcoFKyXUzae76NlsrfjVtrFGGqUtbLN9SUc4O87Co0IrEHHRHyUJI2Wl08/U4aHtQi0mfRwypbm
	KRqpLv37xsOS4xEopsKcph3gtyR0j+2Ys4Xp2
X-Google-Smtp-Source: AGHT+IEFyG7T3F+TFGnix0LKe+O1OIsKyLUJ8/N19DK6dIX5Wz4cVm7ASWzRUkZ1PIHBA8pxHEVGRomkREbWybgDY5g=
X-Received: by 2002:a25:4406:0:b0:dc3:7041:b81b with SMTP id
 r6-20020a254406000000b00dc37041b81bmr988384yba.36.1711569528498; Wed, 27 Mar
 2024 12:58:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327143548.744070-1-david@redhat.com>
In-Reply-To: <20240327143548.744070-1-david@redhat.com>
From: Suren Baghdasaryan <surenb@google.com>
Date: Wed, 27 Mar 2024 12:58:36 -0700
Message-ID: <CAJuCfpF4EPeGN9EcPBb608LEv7=7d31O+-33JDtQEsoGaYgWkg@mail.gmail.com>
Subject: Re: [PATCH v1] mm: optimize CONFIG_PER_VMA_LOCK member placement in vm_area_struct
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
	Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 7:36=E2=80=AFAM David Hildenbrand <david@redhat.com=
> wrote:
>
> Currently, we end up wasting some memory in each vm_area_struct. Pahole
> states that:
>         [...]
>         int                        vm_lock_seq;          /*    40     4 *=
/
>
>         /* XXX 4 bytes hole, try to pack */
>
>         struct vma_lock *          vm_lock;              /*    48     8 *=
/
>         bool                       detached;             /*    56     1 *=
/
>
>         /* XXX 7 bytes hole, try to pack */
>         [...]
>
> Let's reduce the holes and memory wastage by moving the bool:
>         [...]
>         bool                       detached;             /*    40     1 *=
/
>
>         /* XXX 3 bytes hole, try to pack */
>
>         int                        vm_lock_seq;          /*    44     4 *=
/
>         struct vma_lock *          vm_lock;              /*    48     8 *=
/
>         [...]
>
> Effectively shrinking the vm_area_struct with CONFIG_PER_VMA_LOCK by
> 8 byte.
>
> Likely, we could place "detached" in the lowest bit of vm_lock, but at
> least on 64bit that won't really make a difference, so keep it simple.
>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Looks reasonable to me. Thanks!

> ---
>  include/linux/mm_types.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 4ae4684d1add..f56739dece7a 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -671,6 +671,9 @@ struct vm_area_struct {
>         };
>
>  #ifdef CONFIG_PER_VMA_LOCK
> +       /* Flag to indicate areas detached from the mm->mm_mt tree */
> +       bool detached;
> +
>         /*
>          * Can only be written (using WRITE_ONCE()) while holding both:
>          *  - mmap_lock (in write mode)
> @@ -687,9 +690,6 @@ struct vm_area_struct {
>          */
>         int vm_lock_seq;
>         struct vma_lock *vm_lock;
> -
> -       /* Flag to indicate areas detached from the mm->mm_mt tree */
> -       bool detached;
>  #endif
>
>         /*
> --
> 2.43.2
>

