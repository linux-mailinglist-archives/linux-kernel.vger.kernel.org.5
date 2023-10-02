Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4A557B50C6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 13:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236596AbjJBLAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 07:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236601AbjJBLAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 07:00:06 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DE2BF
        for <linux-kernel@vger.kernel.org>; Mon,  2 Oct 2023 04:00:03 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id d75a77b69052e-4198f67b581so7962771cf.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1696244401; x=1696849201; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zag2FfUNq99ttVshS20BuMzQ5l7ujEO0IQzOyYgkL70=;
        b=e0TC4acnjxe0jCpLWfAhJsSZsaRkuDW0nqwdTls0QUr3J4qFskX+2m4pEq/3lw6Tgf
         lvQYqvqt6RAmEEa0hUCQkSeQPSxAfGciuBpG4ugDsO8C05NYXKKsRNh7+4wCUcuVWwZz
         Z2BTpOy2mJD4t16kHp1Vk7GLVWDn3oVc1VNPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696244401; x=1696849201;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zag2FfUNq99ttVshS20BuMzQ5l7ujEO0IQzOyYgkL70=;
        b=WEVkxt1Par60zLUhphSHWbunJF9c7UxsTV+qGvrbITKQYi4O2mXuok4oRLGw0qEtcF
         SaKQo8Sv0S/AjRyawMrorlQRMPuAZ5xMq6bEqQppiypWzug0Omus77Werh7dwSVhYV07
         nhrA59BmrsoM3gUh0B+Z1Yd1h7yXc2ldqnuM6Oo2b8jI7cbP6pfClTRwzwI1c3Tp4MVI
         IOkaVYTOGOT00TU6KUTKUPmrb+FuQWr7ue10c7/gVuupQoVfPJG6XuhtnayXUVzm0qQ8
         odgDhQKiA8SJIfpckk4HZJ/F3e64j2ob6Xz+ml+OiH+r96h0lL95ZCxJQdWoHuL4q6VB
         A/rw==
X-Gm-Message-State: AOJu0YxJp4OuNT1l7jdIN6yW7ciVg9ABcQ1HgOcust4uKsKvmi17TXHN
        0kqYqUKy8lov8k01AlB8VuP79RLy/YNal/bkSbhF2g==
X-Google-Smtp-Source: AGHT+IHsF+Y+gplvjz9ADxZs0kqBrs6fzfa28OP8ChpK3udpId0CmYlTOsUZrzilc6aiLrYkh7eKcg==
X-Received: by 2002:a05:622a:148c:b0:418:fc1:1e9f with SMTP id t12-20020a05622a148c00b004180fc11e9fmr12260554qtx.52.1696244401002;
        Mon, 02 Oct 2023 04:00:01 -0700 (PDT)
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com. [209.85.219.48])
        by smtp.gmail.com with ESMTPSA id x14-20020ac8538e000000b0040331f93ee0sm4873618qtp.77.2023.10.02.04.00.00
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Oct 2023 04:00:00 -0700 (PDT)
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-65b0c9fb673so66717906d6.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 Oct 2023 04:00:00 -0700 (PDT)
X-Received: by 2002:a05:6214:5f0c:b0:65d:105f:6934 with SMTP id
 lx12-20020a0562145f0c00b0065d105f6934mr10393985qvb.5.1696244399754; Mon, 02
 Oct 2023 03:59:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230924124425.3664024-1-make_ruc2021@163.com> <20e3745b-ed89-4f9e-9ef6-f527122fe204@xs4all.nl>
In-Reply-To: <20e3745b-ed89-4f9e-9ef6-f527122fe204@xs4all.nl>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Mon, 2 Oct 2023 19:59:43 +0900
X-Gmail-Original-Message-ID: <CAAFQd5BewuzafQ-ohW6hESRH409ZBRKBZUAPP3OCK5iHuPPHNA@mail.gmail.com>
Message-ID: <CAAFQd5BewuzafQ-ohW6hESRH409ZBRKBZUAPP3OCK5iHuPPHNA@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2: Fix IS_ERR checking in vb2_vmalloc_put_userptr()
To:     Hans Verkuil <hverkuil@xs4all.nl>
Cc:     Ma Ke <make_ruc2021@163.com>, m.szyprowski@samsung.com,
        mchehab@kernel.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 2, 2023 at 7:16=E2=80=AFPM Hans Verkuil <hverkuil@xs4all.nl> wr=
ote:
>
> Hi Ma Ke,
>
> On 24/09/2023 14:44, Ma Ke wrote:
> > In order to avoid error pointers from frame_vector_pages(), we could
> > use IS_ERR() to check the return value to fix this. This checking
> > operation could make sure that vector contains pages.
> >
> > Signed-off-by: Ma Ke <make_ruc2021@163.com>
> > ---
> >  drivers/media/common/videobuf2/videobuf2-vmalloc.c | 1 +
> >  1 file changed, 1 insertion(+)
> >
> > diff --git a/drivers/media/common/videobuf2/videobuf2-vmalloc.c b/drive=
rs/media/common/videobuf2/videobuf2-vmalloc.c
> > index 7c635e292106..c37775080aff 100644
> > --- a/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> > +++ b/drivers/media/common/videobuf2/videobuf2-vmalloc.c
> > @@ -134,6 +134,7 @@ static void vb2_vmalloc_put_userptr(void *buf_priv)
> >       if (!buf->vec->is_pfns) {
> >               n_pages =3D frame_vector_count(buf->vec);
> >               pages =3D frame_vector_pages(buf->vec);
> > +             BUG_ON(IS_ERR(pages));

Can this even happen? We removed support for pfn maps from
get_vaddr_frames() quite long ago, so we should always have pages in
the frame vector if vb2_crate_framevec() in get_userptr() succeeds.

Or am I reading something wrong?

> >               if (vaddr)
> >                       vm_unmap_ram((void *)vaddr, n_pages);
> >               if (buf->dma_dir =3D=3D DMA_FROM_DEVICE ||
>
> The use of BUG_ON is discouraged in the kernel. I did notice that is it
> also used in the put_userptr callback in videobuf2-dma-contig.c.
>
> I think it is much better to do something like this:
>
>         if (!buf->vec->is_pfns) {
>                 n_pages =3D frame_vector_count(buf->vec);
>                 if (vaddr)
>                         vm_unmap_ram((void *)vaddr, n_pages);
>                 if (buf->dma_dir =3D=3D DMA_FROM_DEVICE ||
>                     buf->dma_dir =3D=3D DMA_BIDIRECTIONAL) {
>                         pages =3D frame_vector_pages(buf->vec);
>                         if (!WARN_ON_ONCE(IS_ERR(pages)))
>                                 for (i =3D 0; i < n_pages; i++)
>                                         set_page_dirty_lock(pages[i]);
>                 }
>         } else {
>
> and do something similar in videobuf2-dma-contig.c.
>
> Regards,
>
>         Hans
