Return-Path: <linux-kernel+bounces-91012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 98927870870
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 18:41:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0E9B61F227C5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BDEB612F6;
	Mon,  4 Mar 2024 17:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B8Q9LOQs"
Received: from mail-yb1-f176.google.com (mail-yb1-f176.google.com [209.85.219.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E16CE612DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 17:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709574054; cv=none; b=Ao1IzCsb4PTvUzfUGTR7bWzwuLRKNAeK3ZQLaPu/ELyobSXQD1XM//XtdTfQqwy/COXk8GNJbIMssa4zDz+z5r6o8XYe1am0OmBQ+poUNebodVw9QvNNeXF7ecBaJIiQrvDKgaCzfN4P5SNF9/G+pj79zMU011nSMsJEeusujg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709574054; c=relaxed/simple;
	bh=y3JoWnb3KrrTiOwXZ9cElaSSVn/zQn3QtMJuP0vyjp4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hSzoMdUmh44x8tE3+23XTiYR9M68GWXvwyBptFFh7ccnohlhSgrICDc9HuiRBByhilmT4huUKZ52DyWnBZ7QtfuXwNabIo/BMe4dKs66NF3meXjmdjpVQnc/oUZma8H+36cruyRBkvFtwfLzb/7oiejpfWsxbR0ltvy36Qmz4Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B8Q9LOQs; arc=none smtp.client-ip=209.85.219.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-yb1-f176.google.com with SMTP id 3f1490d57ef6-dcd94fb9e4dso4739416276.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 09:40:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709574050; x=1710178850; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iEuLXiE6YEs+aui+/jaMUElzJSBQFO1y3UQMDx17n4E=;
        b=B8Q9LOQskZHX3JJZqKdQaFggCsOciO7QDHrPbhuCWXv5sgJusRHKSQuIwsUTNtuKKL
         XWsvBtcf0Boq2ABwNCbugI3hAzTt1QtacEiXo3Atyp1zdgVXkuDyX9h2mp7wCvidNr7d
         68oZqaq7BBxFpRuU9BrGKJFFhW7JL89bVXuAAFH3vh3coaoQurB4R6ARf99z6Hkc8OdD
         i3yuwJeGMr44K78Ci0llr2Q/jPjdLLz51Lgc/mpg4RIMQmRgmChp50gHBXqL9YQZGsDW
         tA5UCpKnGNo5FZSPQXpMvVUGBrMvOfGvPspYI/aKXz8/9VjR98gcWfOoKD5upGzGK1a5
         Exxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709574050; x=1710178850;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iEuLXiE6YEs+aui+/jaMUElzJSBQFO1y3UQMDx17n4E=;
        b=XfBWVmzqgGk9w0nvRcG5WRcJ4BCqQYOUJ2heCJyWcTNQ9j9D8MbLgXEym0HafBJsFb
         /XnkOhnEZMRLiXYUJM2l0ZOxciBnk5QsUGM/jlhrcLd4j2tF7lc+gacsFggbNtT+c7kT
         nkCsuIz3rIpv7jpMT7xBKxUNL8wZuofgE/Z/1wksG/QNEcZ/FKuUnEiIos2odRXqM2rw
         fzGZn2W0530R7LP/ICZoYWx8FRYLsax3BYhIKGZ9fH5zIjTWTBI0OrUhx9QkbMTFij7S
         BeXvGsLckfX+Fa8YsCwA2cOxsl861IRDEGKm0a0qXna2+PdYsqy7qPA8CzGMOCrYpDPf
         Vpsg==
X-Forwarded-Encrypted: i=1; AJvYcCXMHvyZ2DuNkOqfzY0tr63H/PXAdBNekukj+YdfmtCXMTTKuKMkt9MGwijKD+/H6hvsGKP287dmOeq9d/xmMNUkli0gL78D7hn72Mf2
X-Gm-Message-State: AOJu0YxQoYlky7yDcfnL9DwJQ/5S6d6Iw9hotp4W8VwNIMBs71PDo/xn
	naabfef5ZCOUbStG7Woe3Vebs+/rZrb2CJArh4pBmx/69pgHApfPIEHeGq+B2hn2r/EsNnvE/U7
	pXLrDI018Jk/fo6vTtd0EwM5rgVXr+Kirz/RI
X-Google-Smtp-Source: AGHT+IGaiKRfH+P/Nd5eW1zOBx42oxgT2PLpxHTbTtZ/Ys0SlxYyMdToDHdIse7jaAdhX6cREDcAIwBnMZk7ymg6Ooc=
X-Received: by 2002:a5b:c86:0:b0:dc7:4860:1214 with SMTP id
 i6-20020a5b0c86000000b00dc748601214mr7630867ybq.4.1709574049580; Mon, 04 Mar
 2024 09:40:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240301084609.2133900-1-usama.anjum@collabora.com>
In-Reply-To: <20240301084609.2133900-1-usama.anjum@collabora.com>
From: "T.J. Mercier" <tjmercier@google.com>
Date: Mon, 4 Mar 2024 09:40:37 -0800
Message-ID: <CABdmKX2x3R1mmYUfmDhTb5cRow4q6jGsnSrr35w-83Pr0i=R9A@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] selftests/dmabuf-heap: conform test to TAP format output
To: Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc: Shuah Khan <shuah@kernel.org>, kernel@collabora.com, linux-kselftest@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 1, 2024 at 12:45=E2=80=AFAM Muhammad Usama Anjum
<usama.anjum@collabora.com> wrote:
>
> Conform the layout, informational and status messages to TAP. No
> functional change is intended other than the layout of output messages.
>
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> ---
> Chanages since v3:
> - abort test-case instead of exiting if heap/mem allocation fails
> - Correct test_alloc_zeroed() test case in case of failure
>
> Changes since v2:
> - Minor improvements in test_alloc_zeroed() results
>
> Changes since v1:
> - Update some more error handling code
> ---
>  .../selftests/dmabuf-heaps/dmabuf-heap.c      | 229 +++++++-----------
>  1 file changed, 93 insertions(+), 136 deletions(-)
>
> diff --git a/tools/testing/selftests/dmabuf-heaps/dmabuf-heap.c b/tools/t=
esting/selftests/dmabuf-heaps/dmabuf-heap.c
> index 890a8236a8ba7..7529c539be0e2 100644
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
> @@ -148,16 +148,14 @@ static int test_alloc_and_import(char *heap_name)
>         int ret;
>
>         heap_fd =3D dmabuf_heap_open(heap_name);
> -       if (heap_fd < 0)
> -               return -1;
>
> -       printf("  Testing allocation and importing:  ");
> +       ksft_print_msg("Testing allocation and importing:\n");
>         ret =3D dmabuf_heap_alloc(heap_fd, ONE_MEG, 0, &dmabuf_fd);
>         if (ret) {
> -               printf("FAIL (Allocation Failed!)\n");
> -               ret =3D -1;
> -               goto out;
> +               ksft_test_result_fail("FAIL (Allocation Failed!)\n");
> +               return;

Might as well setup goto out to clean up heap_fd, dmabuf_fd instead of
these returns for the test functions, which leave a bunch of FDs open
until the program exits.
With those fixed: Reviewed-by: T.J. Mercier <tjmercier@google.com>
Thanks!

>         }
> +
>         /* mmap and write a simple pattern */
>         p =3D mmap(NULL,
>                  ONE_MEG,
> @@ -166,9 +164,8 @@ static int test_alloc_and_import(char *heap_name)
>                  dmabuf_fd,
>                  0);
>         if (p =3D=3D MAP_FAILED) {
> -               printf("FAIL (mmap() failed)\n");
> -               ret =3D -1;
> -               goto out;
> +               ksft_test_result_fail("FAIL (mmap() failed)\n");
> +               return;
>         }
>
>         dmabuf_sync(dmabuf_fd, DMA_BUF_SYNC_START);
> @@ -179,70 +176,62 @@ static int test_alloc_and_import(char *heap_name)
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
> +               if (ret) {
> +                       ksft_test_result_fail("FAIL (Allocation (%i) fail=
ed)\n", i);
> +                       return;
>                 }
> +
>                 /* mmap and fill with simple pattern */
>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED=
, dmabuf_fd[i], 0);
>                 if (p =3D=3D MAP_FAILED) {
> -                       printf("FAIL (mmap() failed!)\n");
> -                       ret =3D -1;
> -                       goto out;
> +                       ksft_test_result_fail("FAIL (mmap() failed!)\n");
> +                       return;
>                 }
> +
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>                 memset(p, 0xff, size);
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
> @@ -251,48 +240,45 @@ static int test_alloc_zeroed(char *heap_name, size_=
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
>                 if (ret < 0) {
> -                       printf("FAIL (Allocation (%i) failed)\n", i);
> -                       goto out;
> +                       ksft_test_result_fail("FAIL (Allocation (%i) fail=
ed)\n", i);
> +                       return;
>                 }
>
>                 /* mmap and validate everything is zero */
>                 p =3D mmap(NULL, size, PROT_READ | PROT_WRITE, MAP_SHARED=
, dmabuf_fd[i], 0);
>                 if (p =3D=3D MAP_FAILED) {
> -                       printf("FAIL (mmap() failed!)\n");
> -                       ret =3D -1;
> -                       goto out;
> +                       ksft_test_result_fail("FAIL (mmap() failed!)\n");
> +                       return;
>                 }
> +
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_START);
>                 c =3D (char *)p;
>                 for (j =3D 0; j < size; j++) {
>                         if (c[j] !=3D 0) {
> -                               printf("FAIL (Allocated buffer not zeroed=
 @ %i)\n", j);
> -                               break;
> +                               ksft_print_msg("FAIL (Allocated buffer no=
t zeroed @ %i)\n", j);
> +                               dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_EN=
D);
> +                               munmap(p, size);
> +                               goto out;
>                         }
>                 }
>                 dmabuf_sync(dmabuf_fd[i], DMA_BUF_SYNC_END);
>                 munmap(p, size);
>         }
> +
> +out:
> +       ksft_test_result(i =3D=3D 32, "Allocate and validate all buffers =
are zeroed\n");
>         /* close them all */
>         for (i =3D 0; i < 32; i++)
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
> +       return;
>  }
>
>  /* Test the ioctl version compatibility w/ a smaller structure then expe=
cted */
> @@ -360,126 +346,97 @@ static int dmabuf_heap_alloc_newer(int fd, size_t =
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
> -       if (heap_fd >=3D 0)
> -               close(heap_fd);
> +       close(heap_fd);
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
> +       ksft_set_plan(11 * numer_of_heaps());
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
> 2.39.2
>

