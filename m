Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A587F97F2
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 04:29:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjK0D3j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Nov 2023 22:29:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjK0D3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Nov 2023 22:29:37 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E6E126
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:29:43 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c997467747so16904431fa.1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Nov 2023 19:29:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701055781; x=1701660581; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sV1CXf/5vgCh5mOFnUCAA7ihYHRFt1CuTIjPFpsOHiU=;
        b=Zyd21S7UkMxmG+5u5MatnqKT84rAeTpNvinObDpWoZzz+J5SoGtFI8WdhtIarsYv/S
         SBNSFGgvH9XsiY24lnkt4ArumrMrwfBeL/KdkryGpXN+M4xa6AEWnhQPi8LjgU7HKANZ
         O3TWLmvLReR2sIXEwHxbbHaSB+PopnAYQQorS9EKJQgko9E5GMTqfv5FFbkColqwOqtl
         9FXC2PYx6mbVjxUc4Sz0cMSRof55aRBHqcEF6jJZIZnKB3r2yakFGqgDJ6Y8YMu6+6Io
         kxOaT1lqVqSq5OrLZIlF6v7Z8JbHUP9vzrvM74lKSf35XXZRU2+3ao7nf/7oPtqfs+47
         QFLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701055781; x=1701660581;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sV1CXf/5vgCh5mOFnUCAA7ihYHRFt1CuTIjPFpsOHiU=;
        b=RsQYNiT1X8/gETPj3OrKl207aWheZNl/l1/ulNsM0xeoD04Il6dhE35dGnDr0rJAQD
         484/A/6XYbhYbWrP9ly19pTFoHssCgLfumybFto+2ZV7lQRlbNT/syt4UHMMRHiDQdVG
         a1sE1TbJCmvWjVOceBPKJPYQM9DQacE0UzOBc8/yQ+VPatZ7jw13sZPGtGY/bHIYV08+
         HqEpSPR92KlRVPcB/flXRgjiVivsT9D84qaGsgFfibCju/ZgYERnANy+dYjvqvZn7l8F
         ezHp9+VCvYyP603gBjIjr2S0kcOqbASBr0UnCNbYkaIRoJUsFbO5QcYR99tWl6T9XqkF
         IuCg==
X-Gm-Message-State: AOJu0Ywnu0zwPv+N5yQ4WhlNyEp1jj1rs5LtEpTspvzOWiQQa1OUeHlv
        s3vAHL+gUQFr9FIX+WF9QQ2tNuswyD2KlSUSCeE=
X-Google-Smtp-Source: AGHT+IGOf4mC0tblJt+CsMkIa+mju8Wanx4dOjJ4UGZAvNfOvuBltgSZ2ncd12yqTeq8/VhiG5zFlfwlz54C/8ofkhQ=
X-Received: by 2002:a2e:3c15:0:b0:2bc:b9c7:7ba8 with SMTP id
 j21-20020a2e3c15000000b002bcb9c77ba8mr3854903lja.43.1701055781092; Sun, 26
 Nov 2023 19:29:41 -0800 (PST)
MIME-Version: 1.0
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
In-Reply-To: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 27 Nov 2023 11:29:29 +0800
Message-ID: <CAGWkznGz-Q_gC6EnuTgO3boZY9mSMpMWPRHt-ajo=VDUTHMMEw@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
To:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, steve.kang@unisoc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch arose from a real problem where the driver failed to use
dma_map_single(dev, ptr). The ptr is a vmalloc va which is mapped over
the reserve memory by dma_init_coherent_memory.

On Mon, Nov 27, 2023 at 11:09=E2=80=AFAM zhaoyang.huang
<zhaoyang.huang@unisoc.com> wrote:
>
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
>
> memremap within dma_init_coherent_memory will map the given phys_addr
> into vmalloc area if the pa is not found during iterating iomem_resources=
,
> which conflict the rejection of vmalloc area in dma_map_single_attrs.
> IMO, it is find to let all valid virtual address be valid for DMA as the
> user will keep corresponding RAM safe for transfer.
>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> ---
>  include/linux/dma-mapping.h | 12 +++++++-----
>  kernel/dma/debug.c          |  4 ----
>  2 files changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index f0ccca16a0ac..7a7b87289d55 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -328,12 +328,14 @@ static inline void dma_free_noncoherent(struct devi=
ce *dev, size_t size,
>  static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *=
ptr,
>                 size_t size, enum dma_data_direction dir, unsigned long a=
ttrs)
>  {
> -       /* DMA must never operate on areas that might be remapped. */
> -       if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
> -                         "rejecting DMA map of vmalloc memory\n"))
> -               return DMA_MAPPING_ERROR;
> +       struct page *page;
> +
>         debug_dma_map_single(dev, ptr, size);
> -       return dma_map_page_attrs(dev, virt_to_page(ptr), offset_in_page(=
ptr),
> +       if (is_vmalloc_addr(ptr))
> +               page =3D vmalloc_to_page(ptr);
> +       else
> +               page =3D virt_to_page(ptr);
> +       return dma_map_page_attrs(dev, page, offset_in_page(ptr),
>                         size, dir, attrs);
>  }
>
> diff --git a/kernel/dma/debug.c b/kernel/dma/debug.c
> index 06366acd27b0..51e1fe9a70aa 100644
> --- a/kernel/dma/debug.c
> +++ b/kernel/dma/debug.c
> @@ -1198,10 +1198,6 @@ void debug_dma_map_single(struct device *dev, cons=
t void *addr,
>         if (!virt_addr_valid(addr))
>                 err_printk(dev, NULL, "device driver maps memory from inv=
alid area [addr=3D%p] [len=3D%lu]\n",
>                            addr, len);
> -
> -       if (is_vmalloc_addr(addr))
> -               err_printk(dev, NULL, "device driver maps memory from vma=
lloc area [addr=3D%p] [len=3D%lu]\n",
> -                          addr, len);
>  }
>  EXPORT_SYMBOL(debug_dma_map_single);
>
> --
> 2.25.1
>
