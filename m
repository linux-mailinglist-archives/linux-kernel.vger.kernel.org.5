Return-Path: <linux-kernel+bounces-83690-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8738C869D58
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 18:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D001283853
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 17:18:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A80F4C61F;
	Tue, 27 Feb 2024 17:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="2pA3SkDZ"
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A272836D
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 17:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709054319; cv=none; b=HoiaYxr4g4ieC4z/UMKR3kyrjgKIe3bvVi17/afyP3A+TD2yCzTN0TjDd1UjZ8/DI4U3wnWPDeUbl5VSYNMnluQrIn/IwIz59bHfnC98/+uC3BXVb5oI1U0luCkIreqvHkRgudaIleuUShsZdY6xefs2PxN2hxeMos3LqlGUTos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709054319; c=relaxed/simple;
	bh=PuJh2k+2XBy+9ywLlgT3RGhYAwDWvIuvGUeh2znSNhY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dH4qoe02yuCBlMd1XdrTfV94Sgq7VSaZyovd6Al3swL/6m3OcioO4BB5OpCj+Fo7ftQVyTm0ZxncxfxouiDw6zlQJ/D7hBpIvo9BILOfA621w9LOMhpvlfKEMG+Y1UoWrf4kOtN6pdJ19ov1BvMZsZe3jUaGEKutdfl2zSTJH/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=2pA3SkDZ; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-6093419f332so5468487b3.0
        for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 09:18:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709054316; x=1709659116; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sDqOypY7dHmvPy9CDl/jYuR4VjvmuPiR4oKLpqN8T+A=;
        b=2pA3SkDZw7KZpmSpURnX0WAdpxbEvjYI936fBUzHE9fzNpD/G1OeAFwG4BlNHu0MBO
         LNN3cc+f6LcJcY+a5kzVm4orDAjJ1SlU3yGYKN+sXVy8uqUOnLmZ/K+xHH+BFqYhYfGD
         reZsIUNFmn4NmazbG0H9jDvKwjlAd9pMnLS+7CoXSqr8ndCgYOFniXqXBRgskYzq8ljx
         3CLF5LGJuFD3EdAuFKfNyfvY8GC9FDa1wdsCIPIKPC+SOUbeik9Uxe7jiGu7VPJjnf4K
         x/5aH6Oh15cnMFPLSs/lOELqotnHAw8nqK+LmZ1KhbxvW0K/kO1ukmpt0rl5rc+Dbvj6
         02PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709054316; x=1709659116;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sDqOypY7dHmvPy9CDl/jYuR4VjvmuPiR4oKLpqN8T+A=;
        b=waIBfIruuSxpkKnudtzjXv+P5g1uRmphpMuViCBQtcK8HihAkQiW5RLB2RTUrO0ALK
         RbNP98yx1+8LpnJJIeGskzR5MdxpWDhW+q/k/hHXtfJqmo9mzNIQ2SiArqNOAvZLAhQn
         yQOYOpk8+kSl6JkU/Y7ZEmY4KH7RGUhLmhahnB6jaLV2+/u28cfBRazUSyz+qlWGK4BQ
         43DWqaOy+nCu+E6ngdNTKpycsrjOTZ8uacD+icC4Uzt4oUm10nWdi6ZUNaGTwpkW2/ya
         l9gazSvE6h/LQqGoA030w5SnLuO5jr0QdvT4IbgYG9LMUafWxUGMeb3PiYHkM0rBdQsn
         8fVw==
X-Forwarded-Encrypted: i=1; AJvYcCX562DQl8RoFMnldrJ9aUz+NgKmInJ/vvMSICLPCUm+VpeKobdetUZprzMP+KN2zWre1aERN8v8kuTMXJ6Iu9X0009sk0gfOHTYhina
X-Gm-Message-State: AOJu0YxyPnZY6dlakUznPm6oxJXXyEbR4BzXZo7GGjj69lntG1R6rblp
	ll02Q4hL7PpYn0itLgAkeukZKiqXXaI+/DargaXXkMJXntF1GsQ4rI2foDBGqkILIbp4qa58+NC
	ECAc6SjiYTmOO6E99khZX7J+C9ew0SIS67SU7
X-Google-Smtp-Source: AGHT+IFHSB9ogsaTh5yLcJM87EoJGE6/1clrKsgUSeDiGCkQLyBT4UGt8Ht/4iS1hAewfkzRBc7+jRMpHyeXgR4Iopg=
X-Received: by 2002:a0d:e80f:0:b0:604:2c8:e49f with SMTP id
 r15-20020a0de80f000000b0060402c8e49fmr2668530ywe.50.1709054315790; Tue, 27
 Feb 2024 09:18:35 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240227121920.1905095-1-usama.anjum@collabora.com>
In-Reply-To: <20240227121920.1905095-1-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Tue, 27 Feb 2024 09:18:24 -0800
Message-ID: <CABdmKX3_+G20TB5HJLLLMQQ1-i9g=RV1QU_A00Knd08pyiJWgw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 27, 2024 at 4:21=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Changes since v1:
> - Update some more error handling code
> ---
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 217 +++++++-----------
>  1 file changed, 81 insertions(+), 136 deletions(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 890a8236a8ba7..41a8485cad5d0 100644
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
> @@ -179,31 +172,28 @@ static int test_alloc_and_import(char *heap_name)
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
>         if (p)
>                 munmap(p, ONE_MEG);
> @@ -214,35 +204,30 @@ static int test_alloc_and_import(char *heap_name)
>         if (heap_fd >=3D 0)
>                 close(heap_fd);
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

So based on the previous ksft_exit_fail_msg calls I thought your
intention was to exit the program and never run subsequent tests when
errors occurred. That's what led to my initial comment about switching
to ksft_exit_fail_msg from ksft_print_msg here, and I expected to see
only ksft_exit_fail_msg for error cases afterwards. But you're still
mixing ksft_exit_fail_msg and (ksft_print_msg +
ksft_test_result{_pass,_fail,_skip}) so we've got a mix of behaviors
where some errors lead to complete program exits and different errors
lead to skipped/failed tests followed by further progress.

It seems most useful and predictable to me to have all tests run even
after encountering an error for a single test, which we don't get when
ksft_exit_fail_msg is called from the individual tests. I was fine
with switching all error handling to ksft_exit_fail_msg to eliminate
cleanup code and reduce maintenance, but I think we should be
consistent with the behavior for dealing with errors which this
doesn't currently have. So let's either always call ksft_exit_fail_msg
for errors, or never call it (my preference).

Slight tangent:
For this specific MAP_FAILED error, I don't actually think it should
be considered a test failure because the mmap operation is optional
for dma-buf: https://docs.kernel.org/driver-api/dma-buf.html#c.dma_buf_ops.
It would be pretty unusual to get a buffer like that, and skipping
instead of failing when that happens would differ from the original
behavior of the test so that could go in another patch, but I wanted
to point this out.

> +
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>                 memset(p, 0xff, size);
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
> @@ -255,23 +240,19 @@ static int test_alloc_zeroed(char *heap_name, size_=
t size)
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
> @@ -283,16 +264,8 @@ static int test_alloc_zeroed(char *heap_name, size_t=
 size)
>                 close(dmabuf_fd[i]);
>
>         close(heap_fd);
> -       printf("OK\n");
> -       return 0;
> -
> -out:
> -       while (i > 0) {
> -               close(dmabuf_fd[i]);
> -               i--;
> -       }
> -       close(heap_fd);
> -       return ret;
> +       ksft_test_result_pass("%s\n", __func__);

Don't we need ksft_test_result based on whether we ever see a non-zero
value so that we get ksft_cnt.ksft_fail++ for the failure case?
Otherwise we could have all non-zero values and the test would still
pass with a bunch of "FAIL (Allocated buffer not zeroed"
ksft_print_msg.

> +       return;
>  }
>
>  /* Test the ioctl version compatibility w/ a smaller structure then expe=
cted */
> @@ -360,126 +333,98 @@ static int dmabuf_heap_alloc_newer(int fd, size_t =
len, unsigned int flags,
>         return ret;
>  }
>
> -static int test_alloc_compat(char *heap_name)
> +static void test_alloc_compat(char *heap_name)
>  {
> -       int heap_fd =3D -1, dmabuf_fd =3D -1;
> -       int ret;
> +       int ret, heap_fd =3D -1, dmabuf_fd =3D -1;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing (theoretical)older alloc compat:  ");
> +       ksft_print_msg("Testing (theoretical) older alloc compat:\n");
>         ret =3D dmabuf_heap_alloc_older(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret) {
> -               printf("FAIL (Older compat allocation failed!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> -       close(dmabuf_fd);
> -       printf("OK\n");
> +       if (dmabuf_fd >=3D 0)
> +               close(dmabuf_fd);
> +       ksft_test_result(!ret, "dmabuf_heap_alloc_older\n");
>
> -       printf("  Testing (theoretical)newer alloc compat:  ");
> +       ksft_print_msg("Testing (theoretical) newer alloc compat:\n");
>         ret =3D dmabuf_heap_alloc_newer(heap_fd, ONE_MEG, 0, &dmabuf_fd);
> -       if (ret) {
> -               printf("FAIL (Newer compat allocation failed!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> -       printf("OK\n");
> -out:
>         if (dmabuf_fd >=3D 0)
>                 close(dmabuf_fd);
> -       if (heap_fd >=3D 0)
> -               close(heap_fd);
> +       ksft_test_result(!ret, "dmabuf_heap_alloc_newer\n");
>
> -       return ret;
> +       close(heap_fd);
>  }
>
> -static int test_alloc_errors(char *heap_name)
> +static void test_alloc_errors(char *heap_name)
>  {
>         int heap_fd =3D -1, dmabuf_fd =3D -1;
>         int ret;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing expected error cases:  ");
> +       ksft_print_msg("Testing expected error cases:\n");
>         ret =3D dmabuf_heap_alloc(0, ONE_MEG, 0x111111, &dmabuf_fd);
> -       if (!ret) {
> -               printf("FAIL (Did not see expected error (invalid fd)!)\n=
");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       ksft_test_result(ret, "Error expected on invalid fd\n");
>
>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0x111111, &dmabuf_fd)=
;
> -       if (!ret) {
> -               printf("FAIL (Did not see expected error (invalid heap fl=
ags)!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       ksft_test_result(ret, "Error expected on invalid heap flags\n");
>
>         ret =3D dmabuf_heap_alloc_fdflags(heap_fd, ONE_MEG,
>                                         ~(O_RDWR | O_CLOEXEC), 0, &dmabuf=
_fd);
> -       if (!ret) {
> -               printf("FAIL (Did not see expected error (invalid fd flag=
s)!)\n");
> -               ret =3D -1;
> -               goto out;
> -       }
> +       ksft_test_result(ret, "Error expected on invalid heap flags\n");
>
> -       printf("OK\n");
> -       ret =3D 0;
> -out:
>         if (dmabuf_fd >=3D 0)
>                 close(dmabuf_fd);
>         if (heap_fd >=3D 0)
>                 close(heap_fd);
> +}
>
> -       return ret;
> +static int numer_of_heaps(void)
> +{
> +       DIR *d =3D opendir(DEVPATH);
> +       struct dirent *dir;
> +       int heaps =3D 0;
> +
> +       while ((dir =3D readdir(d))) {
> +               if (!strncmp(dir->d_name, ".", 2))
> +                       continue;
> +               if (!strncmp(dir->d_name, "..", 3))
> +                       continue;
> +               heaps++;
> +       }
> +
> +       return heaps;
>  }
>
>  int main(void)
>  {
> -       DIR *d;
>         struct dirent *dir;
> -       int ret =3D -1;
> +       DIR *d;
> +
> +       ksft_print_header();
>
>         d =3D opendir(DEVPATH);
>         if (!d) {
> -               printf("No %s directory?\n", DEVPATH);
> -               return -1;
> +               ksft_print_msg("No %s directory?\n", DEVPATH);
> +               return KSFT_SKIP;
>         }
>
> -       while ((dir =3D readdir(d)) !=3D NULL) {
> +       ksft_set_plan(9 * numer_of_heaps());
> +
> +       while ((dir =3D readdir(d))) {
>                 if (!strncmp(dir->d_name, ".", 2))
>                         continue;
>                 if (!strncmp(dir->d_name, "..", 3))
>                         continue;
>
> -               printf("Testing heap: %s\n", dir->d_name);
> -               printf("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -               ret =3D test_alloc_and_import(dir->d_name);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_zeroed(dir->d_name, 4 * 1024);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_zeroed(dir->d_name, ONE_MEG);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_compat(dir->d_name);
> -               if (ret)
> -                       break;
> -
> -               ret =3D test_alloc_errors(dir->d_name);
> -               if (ret)
> -                       break;
> +               ksft_print_msg("Testing heap: %s\n", dir->d_name);
> +               ksft_print_msg("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D\n");
> +               test_alloc_and_import(dir->d_name);
> +               test_alloc_zeroed(dir->d_name, 4 * 1024);
> +               test_alloc_zeroed(dir->d_name, ONE_MEG);
> +               test_alloc_compat(dir->d_name);
> +               test_alloc_errors(dir->d_name);
>         }
>         closedir(d);
>
> -       return ret;
> +       ksft_finished();
>  }
> --
> 2.42.0
>
>

