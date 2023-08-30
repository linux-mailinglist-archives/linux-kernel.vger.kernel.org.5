Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7CD678D2AB
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 06:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240077AbjH3EAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 00:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241997AbjH3EAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 00:00:11 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC590CC9
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:00:00 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-4122129390eso18516931cf.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 21:00:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1693367999; x=1693972799; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PtC3DCp+X9tV9ppSun12PymlfvzemQzP6kuCeERxDc4=;
        b=KTyrzd04Xppn4wf10whZ2biGs++p+uV+qCc6JYlnciOAYLjQ5Z/EhUZhzWV3qXkFFN
         OImNDyg9ndENIm7MEqwuuasD53FT7p56TQn8G9XwePJnfFnylrV55blOKvSFTvXjpW1r
         7MEiF55TYDSItWRA2ZNmlyeNPlhSmWexjWFe0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693367999; x=1693972799;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PtC3DCp+X9tV9ppSun12PymlfvzemQzP6kuCeERxDc4=;
        b=GI8exCPK+idzaRseXWPHmDia0a4q9YEQmafMXwkCwBEYr+/fW0j+O+dH9EE6/NO8K8
         ldOgWKGmbndU6P/SAT5nYalnyiUCiEb7LEKU62nvduTyfort6u/s0lF6orky4KO14DYp
         I/eI00HL0/O7RaE3VMQu/9V1/lSu/3EZEplT495SPBrHza1SapvciH9OrgdZtxT6qZxN
         rrfhLKw1dVHy/7+9KJvlTsPNelLuxrgoPO/xrEiaCoDR00AP6qXn2BuoixPnIiDt/uk1
         3lLHsqh87gCFejj6oIwjU1TfDCxZ1kTOFVbnzZqszzXx36+/4T0QdeaYG0cfdvTRqsz2
         L20g==
X-Gm-Message-State: AOJu0YyE4J2Jsb43+/GO4laJStiQRJJZd2rZv8crlLNectl9R9VQy2k1
        ADXLVBpgg/PRgUgPTw2Hn7VHe3hZweQU8q9reJ9fPw==
X-Google-Smtp-Source: AGHT+IHAQor/rj0roEKKGe5MSk7rDWuvsPcn3YRnRdAvDmg597oWKsc8i1yXmRPIENKkYoriaHTC1w==
X-Received: by 2002:ac8:4e89:0:b0:412:18a0:c556 with SMTP id 9-20020ac84e89000000b0041218a0c556mr1156009qtp.36.1693367999672;
        Tue, 29 Aug 2023 20:59:59 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id 18-20020ac85912000000b00413152fb99esm637605qty.49.2023.08.29.20.59.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Aug 2023 20:59:59 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-6490c2c4702so26408536d6.2
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 20:59:59 -0700 (PDT)
X-Received: by 2002:a0c:a609:0:b0:64a:2b04:c10a with SMTP id
 s9-20020a0ca609000000b0064a2b04c10amr970831qva.29.1693367998728; Tue, 29 Aug
 2023 20:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <CAAFQd5Cn3xQroyYtC+m+pk1jOE5i3H+FGr-y8zqhaf0Yo5p-1Q@mail.gmail.com>
 <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
In-Reply-To: <deb735ce-7de1-e59a-9de4-1365b374b417@arm.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Wed, 30 Aug 2023 12:59:41 +0900
X-Gmail-Original-Message-ID: <CAAFQd5DHUU4zb-J2MvtDXohwKttR_i9_C68RPjn82MFVEsjopw@mail.gmail.com>
Message-ID: <CAAFQd5DHUU4zb-J2MvtDXohwKttR_i9_C68RPjn82MFVEsjopw@mail.gmail.com>
Subject: Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     Anle Pan <anle.pan@nxp.com>, Christoph Hellwig <hch@lst.de>,
        m.szyprowski@samsung.com, mchehab@kernel.org,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        hui.fang@nxp.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 8:14=E2=80=AFPM Robin Murphy <robin.murphy@arm.com>=
 wrote:
>
> On 2023-08-29 11:03, Tomasz Figa wrote:
> > Hi Anle,
> >
> > On Mon, Aug 28, 2023 at 8:57=E2=80=AFAM Anle Pan <anle.pan@nxp.com> wro=
te:
> >>
> >> When allocating from pages, the size of the sg segment is unlimited an=
d
> >> the default is UINT_MAX. This will cause the DMA stream mapping failed
> >> later with a "swiotlb buffer full" error.
> >
> > Thanks for the patch. Good catch.
> >
> >> The default maximum mapping
> >> size is 128 slots x 2K =3D 256K, determined by "IO_TLB_SEGSIZE".
> >> To fix the issue, limit the sg segment size according to
> >> "dma_max_mapping_size" to match the mapping limit.
> >>
> >> Signed-off-by: Anle Pan <anle.pan@nxp.com>
> >> ---
> >>   drivers/media/common/videobuf2/videobuf2-dma-sg.c | 9 +++++++--
> >>   1 file changed, 7 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/drivers/media/common/videobuf2/videobuf2-dma-sg.c b/drive=
rs/media/common/videobuf2/videobuf2-dma-sg.c
> >> index fa69158a65b1..b608a7c5f240 100644
> >> --- a/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >> +++ b/drivers/media/common/videobuf2/videobuf2-dma-sg.c
> >> @@ -105,6 +105,7 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *v=
b, struct device *dev,
> >>          struct sg_table *sgt;
> >>          int ret;
> >>          int num_pages;
> >> +       size_t max_segment =3D 0;
> >>
> >>          if (WARN_ON(!dev) || WARN_ON(!size))
> >>                  return ERR_PTR(-EINVAL);
> >> @@ -134,8 +135,12 @@ static void *vb2_dma_sg_alloc(struct vb2_buffer *=
vb, struct device *dev,
> >>          if (ret)
> >>                  goto fail_pages_alloc;
> >>
> >> -       ret =3D sg_alloc_table_from_pages(buf->dma_sgt, buf->pages,
> >> -                       buf->num_pages, 0, size, GFP_KERNEL);
> >> +       if (dev)
>
> dev can't be NULL, see the context above.
>
> >> +               max_segment =3D dma_max_mapping_size(dev);
> >> +       if (max_segment =3D=3D 0)
> >> +               max_segment =3D UINT_MAX;
> >> +       ret =3D sg_alloc_table_from_pages_segment(buf->dma_sgt, buf->p=
ages,
> >> +               buf->num_pages, 0, size, max_segment, GFP_KERNEL);
> >
> > One thing that I'm not sure about here is that we use
> > sg_alloc_table_from_pages_segment(), but we actually don't pass the
> > max segment size (as returned by dma_get_max_seg_size()) to it.
> > I'm also not exactly sure what's the difference between "max mapping
> > size" and "max seg size".
> > +Robin Murphy +Christoph Hellwig I think we could benefit from your
> > expertise here.
>
> dma_get_max_seg_size() represents a capability of the device itself,
> namely the largest contiguous range it can be programmed to access in a
> single DMA descriptor/register/whatever. Conversely,
> dma_max_mapping_size() is a capablity of the DMA API implementation, and
> represents the largest contiguous mapping it is guaranteed to be able to
> handle (each segment in the case of dma_map_sg(), or the whole thing for
> dma_map_page()). Most likely the thing you want here is
> min_not_zero(max_seg_size, max_mapping_size).
>

The extra complexity needed here convinces me even more that we need a help=
er...

> > Generally looking at videobuf2-dma-sg, I feel like we would benefit
> > from some kind of dma_alloc_table_from_pages() that simply takes the
> > struct dev pointer and does everything necessary.
>
> Possibly; this code already looks lifted from drm_prime_pages_to_sg(),
> and if it's needed here then presumably vb2_dma_sg_get_userptr() also
> needs it, at the very least.

That code probably predates drm_prime_pages_to_sg(), but that's
probably also the reason that it has its own issues...
I'm tempted to send a patch adding such a helper, but Christoph didn't
sound very keen on that idea. Hmm.

Best regards,
Tomasz
