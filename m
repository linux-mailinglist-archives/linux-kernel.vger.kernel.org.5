Return-Path: <linux-kernel+bounces-71168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3164585A18D
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 12:01:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 91F80B21FEE
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Feb 2024 11:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F355828E39;
	Mon, 19 Feb 2024 11:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="aL6YHDeu"
Received: from mail-qt1-f195.google.com (mail-qt1-f195.google.com [209.85.160.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE56C1C10
	for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 11:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708340469; cv=none; b=AX+KLfPRkwpaJZaU0VBLrb76hFsEGso2KifOJDoBmF2qfVPEoV71Cllm+P4CQ2dTGhHl9gq71tQv7uymBZjnrFJd5dqtau+L4fotANn4FUaPc7WNXTxH+p9nl1+vW+gBV5vUNiC/G80e6J2jeL/kthaknQZSFuw08NnZargFhvs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708340469; c=relaxed/simple;
	bh=rWsOnu9c0E3+G48KddE34DONtrfMn5lcE+flCVqxLVE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jumPPywR24RNQAR3JEFWPXYn0LLMGdSwAvkvzthwl0Eg147HiQcuubTdvNQ0/Cl4hVT38DPCYQJh3QE8EyXe5ws4LCoHlCZkoVojb6C3Qlq6wMHr0hK3rTvdxM3nwbvur21hItHqrKQziWDc3AdTcSbkWgZFDS7zWHswjWKWVyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=aL6YHDeu; arc=none smtp.client-ip=209.85.160.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-qt1-f195.google.com with SMTP id d75a77b69052e-42c7908fad8so6514481cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 19 Feb 2024 03:01:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1708340466; x=1708945266; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AZYRZSmiMtv1nVWBmnpx4nfvYB6XZR9iTXkP1K/oLxg=;
        b=aL6YHDeurhvb+BebFy7X0/4tkHlOFIzFsbJD1eh3g7PHY6eZ0r27jFkwnFBlz7wncp
         tJahBN0wUbU7voi3nbwmBW5A2YZPvYTUjqSrqfLexD7cEewSnzvg0uYKzlDXS13Id1hZ
         1JS8TegJfDiD71EG0IO0DBjFeYbz3X8TfggRs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708340466; x=1708945266;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AZYRZSmiMtv1nVWBmnpx4nfvYB6XZR9iTXkP1K/oLxg=;
        b=O6zTFB9bnI950wjYjeCbTxlZRqvLfdS7iH91MDj4G0rU4blIMPogKGcxDM4N8GT3Tn
         FeFNJx5ZauHqK55XwbJQZxvie2iGFtSYnYPPAiM5R93Nl4hPbWYskRMNJDY2x+qjQy5H
         HH1HiNHoZa8oWfD3r4Ag0nelyV3BYOqDyM6cs0CylVz7dfzNy3z6m0g4wbQ4PM9gTgOt
         YP2iNBKZ7L7KmHgpdAERWNDi40mV6eZoz5ThdNFFyJ4Mo1h5iVB0ujEvvTEV4zkDzHBp
         XSu+qLzq5Qc7l3AlFQ/vfuBFdkoihMUQlKbjKfiE2zVxpAAlgksKD2x7mkEKrdqeQ7P1
         V/sQ==
X-Forwarded-Encrypted: i=1; AJvYcCVDvFb5YW+gTYANOwlFnH7M7LaGaIiJaUiK69GGCy7IbrY/VLHKqBrKcAQDT0Nw1xANWk7uluubG0FKpdaDVWBwR/3RxwBXWUE2Vczi
X-Gm-Message-State: AOJu0YxM+6tcF302oVGOOqAtDd/A4jdsQ8lHve3fBBvVTisOGrWjlluM
	On5V/wymrtuff/fLDUEuI6cdAZ1jNHxXeHyXv3JinZMsOTfISkB9ADHykaeuko+ej3O4Nx53GrJ
	WdZ/maz6G0r69Bp2SPYyGhqnr3dCKC+uYs57T
X-Google-Smtp-Source: AGHT+IFIyTslOoP/5qvkPX58Yl1ODI3m3FBSnFsxBzqTTkSNYT6rBtjjtKNBFtcWaJOsDwBqowPopZKYU7kUtHrJeg0=
X-Received: by 2002:a05:622a:1885:b0:42d:c856:a2bf with SMTP id
 v5-20020a05622a188500b0042dc856a2bfmr14383238qtc.5.1708340466731; Mon, 19 Feb
 2024 03:01:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240119033126.1802711-1-ototot@chromium.org>
In-Reply-To: <20240119033126.1802711-1-ototot@chromium.org>
From: Tommy Chiang <ototot@chromium.org>
Date: Mon, 19 Feb 2024 19:00:55 +0800
Message-ID: <CAH2knV03g8_z8326yd=pQV11X3N1VFc_DqXzVjMgM4Q0C+8awg@mail.gmail.com>
Subject: Re: [PATCH] dma-buf: Add syntax highlighting to code listings in the document
To: Sumit Semwal <sumit.semwal@linaro.org>, =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc: linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org, 
	linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Kindly ping :)

On Fri, Jan 19, 2024 at 11:33=E2=80=AFAM Tommy Chiang <ototot@chromium.org>=
 wrote:
>
> This patch tries to improve the display of the code listing
> on The Linux Kernel documentation website for dma-buf [1] .
>
> Originally, it appears that it was attempting to escape
> the '*' character, but looks like it's not necessary (now),
> so we are seeing something like '\*' on the webite.
>
> This patch removes these unnecessary backslashes and adds syntax
> highlighting to improve the readability of the code listing.
>
> [1] https://docs.kernel.org/driver-api/dma-buf.html
>
> Signed-off-by: Tommy Chiang <ototot@chromium.org>
> ---
>  drivers/dma-buf/dma-buf.c | 15 +++++++++------
>  1 file changed, 9 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/dma-buf/dma-buf.c b/drivers/dma-buf/dma-buf.c
> index 8fe5aa67b167..e083a0ab06d7 100644
> --- a/drivers/dma-buf/dma-buf.c
> +++ b/drivers/dma-buf/dma-buf.c
> @@ -1282,10 +1282,12 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF=
);
>   *   vmap interface is introduced. Note that on very old 32-bit architec=
tures
>   *   vmalloc space might be limited and result in vmap calls failing.
>   *
> - *   Interfaces::
> + *   Interfaces:
>   *
> - *      void \*dma_buf_vmap(struct dma_buf \*dmabuf, struct iosys_map \*=
map)
> - *      void dma_buf_vunmap(struct dma_buf \*dmabuf, struct iosys_map \*=
map)
> + *   .. code-block:: c
> + *
> + *     void *dma_buf_vmap(struct dma_buf *dmabuf, struct iosys_map *map)
> + *     void dma_buf_vunmap(struct dma_buf *dmabuf, struct iosys_map *map=
)
>   *
>   *   The vmap call can fail if there is no vmap support in the exporter,=
 or if
>   *   it runs out of vmalloc space. Note that the dma-buf layer keeps a r=
eference
> @@ -1342,10 +1344,11 @@ EXPORT_SYMBOL_NS_GPL(dma_buf_move_notify, DMA_BUF=
);
>   *   enough, since adding interfaces to intercept pagefaults and allow p=
te
>   *   shootdowns would increase the complexity quite a bit.
>   *
> - *   Interface::
> + *   Interface:
> + *
> + *   .. code-block:: c
>   *
> - *      int dma_buf_mmap(struct dma_buf \*, struct vm_area_struct \*,
> - *                    unsigned long);
> + *     int dma_buf_mmap(struct dma_buf *, struct vm_area_struct *, unsig=
ned long);
>   *
>   *   If the importing subsystem simply provides a special-purpose mmap c=
all to
>   *   set up a mapping in userspace, calling do_mmap with &dma_buf.file w=
ill
> --
> 2.43.0.381.gb435a96ce8-goog
>

