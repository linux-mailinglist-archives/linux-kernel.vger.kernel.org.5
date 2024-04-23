Return-Path: <linux-kernel+bounces-154381-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80C9D8ADB6E
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 03:13:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D8A7284737
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 01:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598F410949;
	Tue, 23 Apr 2024 01:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsAELkk2"
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42B2312B82
	for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 01:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713834819; cv=none; b=dhS1pf/KNDwXqoDgKfNOu/64xFJ04DLG6HABu8XXQfXR0VI/zSkwNb70WaGcFYILlg1Q7R8qTPas4/xFj87XEDbgOv4bOAMA17k1IyaITTKIJZEAUymEonkxWOnQ5mXPLyhwrufzErV2jSb1xkculXf0r+NEQbCfRdlB/W0ejsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713834819; c=relaxed/simple;
	bh=5VVrV9hcvFlsKZI5OHGPpwRNXV+1M7uEM1Z2u6Qt0i0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=s4cpWjgk3dccry0KZ8AYEDNysIlbu7Z21Sd+0y6DJasT1El6XQHrZDecokCmvSgQS5TQMRYcce+/okO5z/tzNoJSu2lBuWd8qXT/nG4gGPxIBDIYrYMQMBD8DvxFTVoD76mlL9/LXfcXrfF5SFk6FQAuRxiVCJ3ufmZ0ZsZXzvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsAELkk2; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-4dcbf770c24so2639010e0c.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Apr 2024 18:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713834817; x=1714439617; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n0QiT4LgQZ50n1AQG3qCZkCQEm18Wik9J0mwlzbdXB4=;
        b=IsAELkk2CsoKgkqIKv+shwzhFA/kjR921wFX+0Xj43l34a/eYOrzNEQASLLMuAA3kh
         Qbr/AWSxxevYOVWvb5aj1p5bWtFuRB909tKmiwj1aFo6nOfs7Hydtj01LVMRdgBcVktl
         qynZ0PmW7k6wREfIgIthbHEeMUocaOdZVqoZ4Vpn5+oMHqyYrMIBURhaLSlsrkU1lvgB
         A2prKyUaGazYW3nKsdMG+2otciU3SjQ3P1JJAEuC7Ls8RO5iVdecKGH+GnamonS+m52+
         b8x22/WM1lpByumwj6pSwyKoz+iRpToY8imOz907M3D+qlEMpK5SYcUhAJCZJAIYh921
         XscQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713834817; x=1714439617;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=n0QiT4LgQZ50n1AQG3qCZkCQEm18Wik9J0mwlzbdXB4=;
        b=g4X3gvKkEn/Wxg3BBk/7HAWhp4QktjR/SD9T7LrpiycmxOZUSjPN2rwnoTKzb6m8DN
         WDTzkyoLRLyGZbrKEAxM32sbucoTqLcAwlKBF37PoFK9v/xj9UBL5tLUrDPXnwPh8SvH
         YNJsvwMWZ4/HBkDUZcIV83fVqBEFAJ2qXJS96+7taRyq9sXD0APLK03DUV2JxZbi6eqA
         yYSDxIbq7WeDPHbaSqAVhMTGI1Dp4zbeyK28gvb6aWTtIsSFN2tYksugsLecx+xPCP3G
         Y4yV/VEXJVDgBU4gZTm1yYrbS4mOqM+ToQkG+0ObWAjwRldq8TyzSyEZXcWUuc5/ABt/
         c/jA==
X-Forwarded-Encrypted: i=1; AJvYcCV2g8GEdpwSB5gNCcfplr6MVo+tsMJSRUJEOMfzWnc8GHCSqkXj6RaNqr04N5zzCZSqKLnKZAeTke31/AmW2AK9pJ9o3j6bpIOntPm5
X-Gm-Message-State: AOJu0YxUB89w3beJ35GRB4QtTUxuYmM4XqAYL4y7GXaFI6TGjNmgxDmn
	rufMkNLPBKnvnPfAjQJe9k8f64rjU5zhrleXUY5edvcBMymdBj+w5g8wrDERTLOwJM9BcFA0Ivu
	e0Q/SXi2FUK8mydvNAFCutFDXbdU=
X-Google-Smtp-Source: AGHT+IFRB0M8tYZ94U5gY6b3+0CP/60BN0LS4hrFYSqugv3DRLFg+lrNMDhGWo8hO6c9FKiwvatw9RCoZ8nXAT0I7HA=
X-Received: by 2002:a05:6122:ca3:b0:4bd:54d0:e6df with SMTP id
 ba35-20020a0561220ca300b004bd54d0e6dfmr2780294vkb.1.1713834817070; Mon, 22
 Apr 2024 18:13:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1713755580.git.baolin.wang@linux.alibaba.com> <4107dcc957f3b62a37c83e30ca22305c373ef149.1713755580.git.baolin.wang@linux.alibaba.com>
In-Reply-To: <4107dcc957f3b62a37c83e30ca22305c373ef149.1713755580.git.baolin.wang@linux.alibaba.com>
From: Barry Song <21cnbao@gmail.com>
Date: Tue, 23 Apr 2024 09:13:25 +0800
Message-ID: <CAGsJ_4zyVt13F=zwQNDuWZMKVtgh9U7pPAqgrRpM3nTn17or4g@mail.gmail.com>
Subject: Re: [RFC PATCH 3/5] mm: shmem: add THP validation for PMD-mapped THP
 related statistics
To: Baolin Wang <baolin.wang@linux.alibaba.com>
Cc: akpm@linux-foundation.org, hughd@google.com, willy@infradead.org, 
	david@redhat.com, wangkefeng.wang@huawei.com, ryan.roberts@arm.com, 
	ying.huang@intel.com, shy828301@gmail.com, ziy@nvidia.com, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 22, 2024 at 3:03=E2=80=AFPM Baolin Wang
<baolin.wang@linux.alibaba.com> wrote:
>
> In order to extend support for mTHP, add THP validation for PMD-mapped TH=
P
> related statistics to avoid statistical confusion.
>
> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
> ---

Reviewed-by: Barry  Song <v-songbaohua@oppo.com>

>  mm/shmem.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
>
> diff --git a/mm/shmem.c b/mm/shmem.c
> index 893c88efc45f..b4afda71a3f0 100644
> --- a/mm/shmem.c
> +++ b/mm/shmem.c
> @@ -1662,7 +1662,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_=
t gfp,
>                         return ERR_PTR(-E2BIG);
>
>                 folio =3D shmem_alloc_hugefolio(gfp, info, index, order);
> -               if (!folio)
> +               if (!folio && pages =3D=3D HPAGE_PMD_NR)
>                         count_vm_event(THP_FILE_FALLBACK);
>         } else {
>                 pages =3D 1;
> @@ -1680,7 +1680,7 @@ static struct folio *shmem_alloc_and_add_folio(gfp_=
t gfp,
>                 if (xa_find(&mapping->i_pages, &index,
>                                 index + pages - 1, XA_PRESENT)) {
>                         error =3D -EEXIST;
> -               } else if (huge) {
> +               } else if (pages =3D=3D HPAGE_PMD_NR) {
>                         count_vm_event(THP_FILE_FALLBACK);
>                         count_vm_event(THP_FILE_FALLBACK_CHARGE);
>                 }
> @@ -2046,7 +2046,8 @@ static int shmem_get_folio_gfp(struct inode *inode,=
 pgoff_t index,
>                 folio =3D shmem_alloc_and_add_folio(huge_gfp,
>                                 inode, index, fault_mm, true);
>                 if (!IS_ERR(folio)) {
> -                       count_vm_event(THP_FILE_ALLOC);
> +                       if (folio_test_pmd_mappable(folio))
> +                               count_vm_event(THP_FILE_ALLOC);
>                         goto alloced;
>                 }
>                 if (PTR_ERR(folio) =3D=3D -EEXIST)
> --
> 2.39.3
>

