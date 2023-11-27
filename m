Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C7B37F9C24
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:57:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231388AbjK0I4z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:56:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbjK0I4x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:56:53 -0500
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DFD111
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:56:59 -0800 (PST)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2c87acba73bso52093261fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1701075418; x=1701680218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4j+WUhsI6HLaQhNpMAvxRSBO5fBvP0PmC3kAAmj31Q=;
        b=dl4wWGOn6kykg48ZcRUMkhyRM5QYvpXh3/nidOx03B674JnRlGNCBOnLuLU4Pyx5rt
         QY+Ki3zae0/U8VuKfjYDh80WrTxWby2sWapoxRkWuC2zk4iY5YYPsY3ABCfRcymyGtX7
         CJt8HXopWnxweOO34BjtaWfrm9q9YcnAZhMOWPOKPfew2EBTNkiwVTknK8Z2AWiZICqz
         MflOgPcpTWZeBrYtY2c4NdzKDasQsjY4uyJWOFnqj8YWDUe12yPiRIz5IMHHEU1FazR5
         rXCMC9iDjcKaF2QmUeDLOLGxbfz3//3Yv0sWilNZnt27ebR8YITxzJkFLP0cWjEvHxfs
         BNIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701075418; x=1701680218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4j+WUhsI6HLaQhNpMAvxRSBO5fBvP0PmC3kAAmj31Q=;
        b=Ih6g2eOpIuXr1F1BLtF53t2z99eM8E0NEH49GrDv3iXVvC4OJvTKqWEmciR4/MSEWc
         sYaO/CxXwxKfPcLUbQiL+QwpdAXf0MmismsAHGdx4UOo9Zejoj02/84VSU2p7ToOmDKJ
         0f72MKc6TYox1eLo0Kp4F7ov/FP9+mRpTwiYhTxasc0r4Aukz7nPEchiSiWDegxZ4lEw
         vQ7APkP8ox2gJgzW0kz7jcfWYySVOgVrC+6ee3U5b2ZYLE8y5r8XEyz3GbXLtEhuvY4E
         43V83CEAErplNoCnkdPT7coXVJPYAMZaDKuIC5T1iHy5bI9+Frtntk73H3zvp4UDP7V8
         euFg==
X-Gm-Message-State: AOJu0YxyenfN9Rc5O4hVScc1PWtkmM11AQrYcvl+FDKEPky2XDIpyN8y
        4t/idIXMOtLd1QIojNSscg9prdWpBfkI7sPQtLY=
X-Google-Smtp-Source: AGHT+IF4Kbz8DWKARcdVUBkG6k/D9a5BYFVuw/h+Mioxpz8AW7vu4HyqBiXrNT5efzM4LMrKaN1/67x8vXH2BKAHuto=
X-Received: by 2002:a05:651c:317:b0:2c9:9ce3:dfd3 with SMTP id
 a23-20020a05651c031700b002c99ce3dfd3mr2179971ljp.0.1701075417464; Mon, 27 Nov
 2023 00:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20231127030930.1074374-1-zhaoyang.huang@unisoc.com> <20231127071430.GA28214@lst.de>
In-Reply-To: <20231127071430.GA28214@lst.de>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Mon, 27 Nov 2023 16:56:45 +0800
Message-ID: <CAGWkznFf5hdFRomLXDzoxEKVgiKY--DFbHjRLAMvgvodA01EFw@mail.gmail.com>
Subject: Re: [PATCH] kernel: dma: let dma use vmalloc area
To:     Christoph Hellwig <hch@lst.de>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
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

On Mon, Nov 27, 2023 at 3:14=E2=80=AFPM Christoph Hellwig <hch@lst.de> wrot=
e:
>
> On Mon, Nov 27, 2023 at 11:09:30AM +0800, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > memremap within dma_init_coherent_memory will map the given phys_addr
> > into vmalloc area if the pa is not found during iterating iomem_resourc=
es,
> > which conflict the rejection of vmalloc area in dma_map_single_attrs.
>
> I can't parse this sentence.
Sorry for the confusion, please find below codes for more information.
dma_init_coherent_memory
    memremap
        addr =3D ioremap_wt(offset, size);
What I mean is addr is a vmalloc address, which is implicitly mapped
by dma's framework and not be aware of to the driver.
>
> > IMO, it is find to let all valid virtual address be valid for DMA as th=
e
> > user will keep corresponding RAM safe for transfer.
>
> No, vmalloc address can't be passed to map_single.  You need to pass
> the page to dma_map_page, and explicitly mange cache consistency
> using the invalidate_kernel_vmap_range and flush_kernel_vmap_range
> helpers.
Please correct me if I am wrong. According to my understanding, cache
consistency could be solved inside dma_map_page via either
dma_direct_map_page(swio/arch_sync_dma_for_device) or ops->map_page.
The original thought of rejecting vmalloc is that this pa is not safe
as this mapping could go in any time. What I am suggesting is to let
this kind of va be enrolled.

 static inline dma_addr_t dma_map_single_attrs(struct device *dev, void *pt=
r,
                size_t size, enum dma_data_direction dir, unsigned long att=
rs)
 {
       /* DMA must never operate on areas that might be remapped. */
       if (dev_WARN_ONCE(dev, is_vmalloc_addr(ptr),
                         "rejecting DMA map of vmalloc memory\n"))
               return DMA_MAPPING_ERROR;

>
