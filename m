Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2781D7ED810
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 00:22:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjKOXWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Nov 2023 18:22:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229879AbjKOXWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Nov 2023 18:22:00 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 456C8198
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:21:56 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1cc209561c3so63395ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 15 Nov 2023 15:21:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1700090516; x=1700695316; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lNrY+yv6flp09u25YudSqsktgZkCbw+hX4drbUgi3Pw=;
        b=F8+ElcVvm0NX6zwN30341pa5KkUHoO4FmFSeHW2B39gJTuHPIk4RQvIVCPP7PVw55G
         /J6zGU6xft1YnfumvuhML0C2aFex0NZOIiWcvXwtTTfXPuax3WJomqvg+/ek/4/MxrbF
         UyFUYKMK5jcOJeXuZeILkkIjk+g8yzbJOSgpatFFA9XJc+2Up4AuPd/QkkCqCiabJunm
         QiPhx2cxsBxl3BvQ0dTR3g+K5SV48rGBqi0YxmhWSCd2q3Hmxcscj6gCBOLxmSUjUyKo
         LRR0T3Cc3N6em/XAz0PHLh8uMB5vEK2wutPki4I/+8JLMceAzp4PbsJ9wJ6PNqK6GR0P
         dQEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700090516; x=1700695316;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=lNrY+yv6flp09u25YudSqsktgZkCbw+hX4drbUgi3Pw=;
        b=tfkeStTKVfZuom+qpedRjvXsVCG+XYFXGFuUToyCIr06hdLVnhDDtBB1NNvZb8v7Cn
         mtzM3+FvkeIwYEEF1WJZSqrjMNPHtMjzLfH1t1AmiGd3Ry1fcRv+ez1I/Z4Myt0F894h
         iuOtrQ9BDOA8jhB4u6wRCyYY0MyjOWAfIHgyn+8UVs+ssE1bELOpBmTZikpSFJ0ZV3zB
         VHJR3EzK1WY8cASCd/7vNqdyD0Si6yydfKwczShEscELiPizgTrHsEQWFJ7YzDPzGPkS
         AQHPd/E9vP6NpifLbRgDPvtKenMQRqJRttyYMWpz2ockOVtxnnSNmFdYbyuFQs3JaSXw
         QSMg==
X-Gm-Message-State: AOJu0Yz6AtC1CRp/t5+9hm9HRq3viFZAX3kMRI7wmu3Td27UUxAxrBc3
        3W0WVjAbN/1UoR+fREJL3D4iEfLNa4wEc0RBNtxg
X-Google-Smtp-Source: AGHT+IGm7zgQJWAfwVDpHCI+ij6qSFWymYieGz93/wfD0nW3TAyf4K67Hy1IrPWOL2RQmlTU4JpJXZoiI0CXMLDcngE=
X-Received: by 2002:a17:902:c942:b0:1cc:2c43:9061 with SMTP id
 i2-20020a170902c94200b001cc2c439061mr61673pla.21.1700090515344; Wed, 15 Nov
 2023 15:21:55 -0800 (PST)
MIME-Version: 1.0
References: <20231111111559.8218-1-yong.wu@mediatek.com> <20231111111559.8218-3-yong.wu@mediatek.com>
In-Reply-To: <20231111111559.8218-3-yong.wu@mediatek.com>
From:   Jeffrey Kardatzke <jkardatzke@google.com>
Date:   Wed, 15 Nov 2023 15:21:44 -0800
Message-ID: <CA+ddPcPZJzJXro1ph7tT=Zdk6wyDyncmpPZvO0i0J2zCRauMsQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/8] dma-buf: heaps: secure_heap: Add private heap ops
To:     Yong Wu <yong.wu@mediatek.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        christian.koenig@amd.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        Brian Starkey <Brian.Starkey@arm.com>,
        John Stultz <jstultz@google.com>, tjmercier@google.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linaro-mm-sig@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, jianjiao.zeng@mediatek.com,
        kuohong.wang@mediatek.com,
        Vijayanand Jitta <quic_vjitta@quicinc.com>,
        Joakim Bech <joakim.bech@linaro.org>,
        Nicolas Dufresne <nicolas@ndufresne.ca>,
        ckoenig.leichtzumerken@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 11, 2023 at 3:16=E2=80=AFAM Yong Wu <yong.wu@mediatek.com> wrot=
e:
>
> For the secure memory, there are two steps:
> a) Allocate buffers in kernel side;
> b) Secure that buffer.
> Different heaps may have different buffer allocation methods and
> different memory protection methods. Here abstract the memory
> allocation and securing operations.
>
> Signed-off-by: Yong Wu <yong.wu@mediatek.com>
> ---
>  drivers/dma-buf/heaps/secure_heap.c | 58 ++++++++++++++++++++++++++++-
>  1 file changed, 57 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/dma-buf/heaps/secure_heap.c b/drivers/dma-buf/heaps/=
secure_heap.c
> index a634051a0a67..87ac23072e9e 100644
> --- a/drivers/dma-buf/heaps/secure_heap.c
> +++ b/drivers/dma-buf/heaps/secure_heap.c
> @@ -24,15 +24,66 @@ struct secure_buffer {
>         size_t                          size;
>  };
>
> +struct secure_heap;
> +
> +struct secure_heap_prv_data {
> +       int     (*memory_alloc)(struct secure_heap *sec_heap, struct secu=
re_buffer *sec_buf);
> +       void    (*memory_free)(struct secure_heap *sec_heap, struct secur=
e_buffer *sec_buf);
> +
> +       /* Protect/unprotect the memory */
> +       int     (*secure_the_memory)(struct secure_heap *sec_heap, struct=
 secure_buffer *sec_buf);
> +       void    (*unsecure_the_memory)(struct secure_heap *sec_heap, stru=
ct secure_buffer *sec_buf);
> +};
Move these into dma-heap-secure.h per the comments on the prior patch.

> +
>  struct secure_heap {
>         const char                      *name;
>         const enum secure_memory_type   mem_type;
> +
> +       const struct secure_heap_prv_data *data;
>  };
>
> +static int secure_heap_secure_memory_allocate(struct secure_heap *sec_he=
ap,
> +                                             struct secure_buffer *sec_b=
uf)
> +{
> +       const struct secure_heap_prv_data *data =3D sec_heap->data;
> +       int ret;
> +
> +       if (data->memory_alloc) {
> +               ret =3D data->memory_alloc(sec_heap, sec_buf);
> +               if (ret)
> +                       return ret;
> +       }
You should probably always require that memory_alloc is defined
(secure_the_memory can be optional, as that may be part of the
allocation).
> +
> +       if (data->secure_the_memory) {
> +               ret =3D data->secure_the_memory(sec_heap, sec_buf);
> +               if (ret)
> +                       goto sec_memory_free;
> +       }
> +       return 0;
> +
> +sec_memory_free:
> +       if (data->memory_free)
> +               data->memory_free(sec_heap, sec_buf);
You should probably always require that memory_free is defined.
> +       return ret;
> +}
> +
> +static void secure_heap_secure_memory_free(struct secure_heap *sec_heap,
> +                                          struct secure_buffer *sec_buf)
> +{
> +       const struct secure_heap_prv_data *data =3D sec_heap->data;
> +
> +       if (data->unsecure_the_memory)
> +               data->unsecure_the_memory(sec_heap, sec_buf);
> +
> +       if (data->memory_free)
> +               data->memory_free(sec_heap, sec_buf);
You should probably always require that memory_free is defined.
> +}
> +
>  static struct dma_buf *
>  secure_heap_allocate(struct dma_heap *heap, unsigned long size,
>                      unsigned long fd_flags, unsigned long heap_flags)
>  {
> +       struct secure_heap *sec_heap =3D dma_heap_get_drvdata(heap);
>         struct secure_buffer *sec_buf;
>         DEFINE_DMA_BUF_EXPORT_INFO(exp_info);
>         struct dma_buf *dmabuf;
> @@ -45,6 +96,9 @@ secure_heap_allocate(struct dma_heap *heap, unsigned lo=
ng size,
>         sec_buf->size =3D ALIGN(size, PAGE_SIZE);
>         sec_buf->heap =3D heap;
>
> +       ret =3D secure_heap_secure_memory_allocate(sec_heap, sec_buf);
> +       if (ret)
> +               goto err_free_buf;
>         exp_info.exp_name =3D dma_heap_get_name(heap);
>         exp_info.size =3D sec_buf->size;
>         exp_info.flags =3D fd_flags;
> @@ -53,11 +107,13 @@ secure_heap_allocate(struct dma_heap *heap, unsigned=
 long size,
>         dmabuf =3D dma_buf_export(&exp_info);
>         if (IS_ERR(dmabuf)) {
>                 ret =3D PTR_ERR(dmabuf);
> -               goto err_free_buf;
> +               goto err_free_sec_mem;
>         }
>
>         return dmabuf;
>
> +err_free_sec_mem:
> +       secure_heap_secure_memory_free(sec_heap, sec_buf);
>  err_free_buf:
>         kfree(sec_buf);
>         return ERR_PTR(ret);
> --
> 2.25.1
>
