Return-Path: <linux-kernel+bounces-87188-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F80086D0DA
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:38:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E8161C21ECF
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DD47757E9;
	Thu, 29 Feb 2024 17:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qBmR69wi"
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C3B70AE6
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228244; cv=none; b=gJGN/l8E8K41QIEm7uhebam9DyDQ4JIg9BsepuKdBVZ5BFkUXsMPxCgm3Swqy/jjm39raeDRiF7SAE9Znq1NwInXgZLFEmbCQNZ47PbhKcERqtUlGqbtXCcJYCkYCDIWhwz0qD+sJrW+xJwdpPVfn0adTKUOARrBo8OHOrWCsDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228244; c=relaxed/simple;
	bh=6JoRL5mO7fLMulB/6t3qO6B3yI0tCBFSDVEtturgX6Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UXUwDlePi2b9YEQuTE2BgcRcyfjFORuPk/oJbcK0MKRqZwtQHG6wpp1UHF4RhifjM4KI5z7MQIfG9bgJyXfxgOOkqoslvnuhqrE2cpYszq1nDv6NR9aR7bSxpjPSBqkH2msv0rNJhYtle36I5rKuBKeWkfEG6eDcxwOQhMtbxtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qBmR69wi; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-607cd210962so11671617b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709228241; x=1709833041; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DEdtN4KatB5c+IeKPAjIpl5oCocbt9zgSK7rRSBe8Gw=;
        b=qBmR69wiyGtIEr0VaALytDeKuJysFErTN5nqPjsMMXNJBQxoxWOiuXsKZzXKjzIvso
         CP4G8N6xyRPwYdv0lSPYMgqD8IGw7CGl9678yEHAdI/0zMzrsGCIDBxRS6Oz+3K3JZHY
         WVKvkp9xzR0KqBDzdglqdzpzv2ns29AK+fjKWlWodH25NE4GFgJId/bJY+iEEaCfCvPy
         HRp81fYvD00vCZg/yMKpiFvd2/cGTnYZR2usDAiB4Uvimk2GhBDp5IKwoRNYc5pbReEN
         ck82GDqxhFQ9tecx6MQIl7mlToi/3U5ns04wXG4tFj68pas0QdeYVkb7DeITKczUwGOM
         3sdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228241; x=1709833041;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DEdtN4KatB5c+IeKPAjIpl5oCocbt9zgSK7rRSBe8Gw=;
        b=N0kbXAAJwspnAx3D0U4gL8jtvSPb7kVdWBuTI0bgyWRXA/JgF5qFNo25SVCz2Mic3c
         qAGrLj2jjGb10e4BLcY6PwdevN6ML7bVwfqoPTCtga25pHZcsKyHID+jQvC6d/6y5dng
         rWKRXmFmU81dXqRzShSgPsJabUyo9pkGHRaxlmvAmlKb2LFmKD7p4+UB6l7p+MiIGSz6
         BGttGjGl3XRTWol0e4T1/4I55pjkuYtbUa0+g6H4ZFE8gPwrZvM38dh6k2B6EOUa6Zie
         w1HxCCw/49WIcJEYH/17uW1kqVqr3zmiQvKoCWGqxc0YZCLYxuR+jhniHE8wtsfZr1Jm
         NMMA==
X-Forwarded-Encrypted: i=1; AJvYcCVbvWmNMTDZnSw9PV6yxhVUYPKOYCFH5/KXUrp/fx+jByn53/0wLFVJDM4E49p1LNYdtVQKv1ckXC+fAgltTUt240+8RORBQelDD4sH
X-Gm-Message-State: AOJu0Yzx8WWJsMkW6xA5QnZO1X1V2xOw/IFgtq0AvTUOX5hLxaHvaV1s
	Y9NNNDbcX1LF7eRwWx4pog+rK2qsuYC17Z672kD9hMDhVXMMYJNaBUiZZa4Q5k8FghXClL2WP8s
	wRmK6pfsvVbtvO5Z5ZK8Uq9dyNynofiduD8m5
X-Google-Smtp-Source: AGHT+IHvznw17zgRVPYSvuwcu1wSWN+3jALJte08neK70FS20mv6r2nPkp9Hco5l+WYagOeC6BiV3jQY1CYulIXuymI=
X-Received: by 2002:a25:d8cb:0:b0:dc6:d7de:5b29 with SMTP id
 p194-20020a25d8cb000000b00dc6d7de5b29mr3325117ybg.10.1709228241207; Thu, 29
 Feb 2024 09:37:21 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240229092035.1325113-1-usama.anjum@collabora.com>
In-Reply-To: <20240229092035.1325113-1-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Thu, 29 Feb 2024 09:37:09 -0800
Message-ID: <CABdmKX2r=9+dK71qrp4iU8Dkmt=CF1oWWZFmi9Ny+0iphBoynw@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 29, 2024 at 1:21=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v2:
> - Minor improvements in test_alloc_zeroed() results
>
> Changes since v1:
> - Update some more error handling code
> ---
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 234 +++++++-----------
>  1 file changed, 88 insertions(+), 146 deletions(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 890a8236a8ba7..bdc157ba542fd 100644
> --- a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> +++ b/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c
> @@ -15,6 +15,7 @@
>  #include <linux/dma-buf.h>
>  #include <linux/dma-heap.h>
>  #include <drm/drm.h>
> +#include "../kselftest.h"
>
>  #define DEVPATH "/dev/dma_heap"
>
> @@ -90,14 +91,13 @@ static int dmabuf_heap_open(char *name)
>         char buf[256];
>
>         ret =3D snprintf(buf, 256, "%s/%s", DEVPATH, name);
> -       if (ret < 0) {
> -               printf("snprintf failed!\n");
> -               return ret;
> -       }
> +       if (ret < 0)
> +               ksft_exit_fail_msg("snprintf failed!\n");
>
>         fd =3D open(buf, O_RDWR);
>         if (fd < 0)
> -               printf("open %s failed!\n", buf);
> +               ksft_exit_fail_msg("open %s failed: %s\n", buf, strerror(=
errno));
> +
>         return fd;
>  }
>
> @@ -140,7 +140,7 @@ static int dmabuf_sync(int fd, int start_stop)
>
>  #define ONE_MEG (1024 * 1024)
>
> -static int test_alloc_and_import(char *heap_name)
> +static void test_alloc_and_import(char *heap_name)
>  {
>         int heap_fd =3D -1, dmabuf_fd =3D -1, importer_fd =3D -1;
>         uint32_t handle =3D 0;
> @@ -148,16 +148,12 @@ static int test_alloc_and_import(char *heap_name)
>         int ret;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing allocation and importing:  ");
> +       ksft_print_msg("Testing allocation and importing:\n");
>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret) {
> -               printf("FAIL (Allocation Failed!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       if (ret)
> +               ksft_exit_fail_msg("FAIL (Allocation Failed!)\n");
> +
>         /* mmap and write a simple pattern */
>         p =3D mmap(NULL,
>                  ONE_MEG,
> @@ -165,11 +161,8 @@ static int test_alloc_and_import(char *heap_name)
>                  MAP_SHARED,
>                  dmabuf_fd,
>                  0);
> -       if (p =3D=3D MAP_FAILED) {
> -               printf("FAIL (mmap() failed)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       if (p =3D=3D MAP_FAILED)
> +               ksft_exit_fail_msg("FAIL (mmap() failed)\n");
>
>         dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
>         memset(p, 1, ONE_MEG / 2);
> @@ -179,70 +172,58 @@ static int test_alloc_and_import(char *heap_name)
>         importer_fd =3D open_vgem();
>         if (importer_fd < 0) {
>                 ret =3D importer_fd;
> -               printf("(Could not open vgem - skipping):  ");
> +               ksft_test_result_skip("Could not open vgem\n");
>         } else {
>                 ret =3D import_vgem_fd(importer_fd, dmabuf_fd, &handle);
> -               if (ret < 0) {
> -                       printf("FAIL (Failed to import buffer)\n");
> -                       goto out;
> -               }
> +               ksft_test_result(ret >=3D 0, "Import buffer\n");
>         }
>
>         ret =3D dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
>         if (ret < 0) {
> -               printf("FAIL (DMA_BUF_SYNC_START failed!)\n");
> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_START failed!)\n");
>                 goto out;
>         }
>
>         memset(p, 0xff, ONE_MEG);
>         ret =3D dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_END);
>         if (ret < 0) {
> -               printf("FAIL (DMA_BUF_SYNC_END failed!)\n");
> +               ksft_print_msg("FAIL (DMA_BUF_SYNC_END failed!)\n");
>                 goto out;
>         }
>
>         close_handle(importer_fd, handle);
> -       ret =3D 0;
> -       printf(" OK\n");
> +       ksft_test_result_pass("%s\n", __func__);
> +       return;
>  out:
> -       if (p)
> -               munmap(p, ONE_MEG);
> -       if (importer_fd >=3D 0)
> -               close(importer_fd);
> -       if (dmabuf_fd >=3D 0)
> -               close(dmabuf_fd);
> -       if (heap_fd >=3D 0)
> -               close(heap_fd);
> +       munmap(p, ONE_MEG);
> +       close(importer_fd);
> +       close(dmabuf_fd);
> +       close(heap_fd);
>
> -       return ret;
> +       ksft_test_result_fail("%s\n", __func__);
>  }
>
> -static int test_alloc_zeroed(char *heap_name, size_t size)
> +static void test_alloc_zeroed(char *heap_name, size_t size)
>  {
>         int heap_fd =3D -1, dmabuf_fd[32];
>         int i, j, ret;
>         void *p =3D NULL;
>         char *c;
>
> -       printf("  Testing alloced %ldk buffers are zeroed:  ", size / 102=
4);
> +       ksft_print_msg("Testing alloced %ldk buffers are zeroed:\n", size=
 / 1024);
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
>         /* Allocate and fill a bunch of buffers */
>         for (i =3D 0; i < 32; i++) {
>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]=
);
> -               if (ret < 0) {
> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> -                       goto out;
> -               }
> +               if (ret)
> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)=
\n", i);
> +
>                 /* mmap and fill with simple pattern */
>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED=
, dmabuf_fd[i], 0);
> -               if (p =3D=3D MAP_FAILED) {
> -                       printf("FAIL (mmap() failed!)\n");
> -                       ret =3D -1;
> -                       goto out;
> -               }
> +               if (p =3D=3D MAP_FAILED)
> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> +
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>                 memset(p, 0xff, size);
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
> @@ -251,48 +232,38 @@ static int test_alloc_zeroed(char *heap_name, size_=
t size)
>         /* close them all */
>         for (i =3D 0; i < 32; i++)
>                 close(dmabuf_fd[i]);
> +       ksft_test_result_pass("Allocate and fill a bunch of buffers\n");
>
>         /* Allocate and validate all buffers are zeroed */
>         for (i =3D 0; i < 32; i++) {
>                 ret =3D dmabuf_heap_alloc(heap_fd, size, 0, &dmabuf_fd[i]=
);
> -               if (ret < 0) {
> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> -                       goto out;
> -               }
> +               if (ret < 0)
> +                       ksft_exit_fail_msg("FAIL (Allocation (%i) failed)=
\n", i);
>
>                 /* mmap and validate everything is zero */
>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED=
, dmabuf_fd[i], 0);
> -               if (p =3D=3D MAP_FAILED) {
> -                       printf("FAIL (mmap() failed!)\n");
> -                       ret =3D -1;
> -                       goto out;
> -               }
> +               if (p =3D=3D MAP_FAILED)
> +                       ksft_exit_fail_msg("FAIL (mmap() failed!)\n");
> +
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>                 c =3D (char *)p;
>                 for (j =3D 0; j < size; j++) {
>                         if (c[j] !=3D 0) {
> -                               printf("FAIL (Allocated buffer not zeroed=
 @ %i)\n", j);
> +                               ksft_print_msg("FAIL (Allocated buffer no=
t zeroed @ %i)\n", j);
>                                 break;
>                         }
>                 }
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
>                 munmap(p, size);
>         }
> +
> +       ksft_test_result(i =3D=3D 32, "Allocate and validate all buffers =
are zeroed\n");

This part is still incorrect since we will always get i =3D=3D 32 as long
as the buffer can be allocated and mapped, regardless of the content
of the buffer which this test is supposed to be checking.

