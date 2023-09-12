Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF9CE79C7C1
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 09:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231329AbjILHLZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 03:11:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231185AbjILHLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 03:11:25 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4952AB9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:11:21 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id af79cd13be357-76dc77fd01fso327583385a.3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1694502679; x=1695107479; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=quq3SIopv7Gr1An8E941K4sULqr3zgkgx+h2bKR2keQ=;
        b=SnUrbJ9vCs306/d1YZZqwVHg3lffHRAhiPKbJvGbpDu927rbFUeJVeHHdp1Aj9IxN4
         vBnRr4JSRqReZj9c3mYpEXhbgNGCOfbGPxlmgFy55S5pRnHQCLQOJ7vPdsRl3Pp30VW/
         c6iew/xkfmmXfYTxXig4TboSeIgSP3gkZGVJg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694502679; x=1695107479;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=quq3SIopv7Gr1An8E941K4sULqr3zgkgx+h2bKR2keQ=;
        b=F9gKkITYnDh/3MIg70CdLW9HFLK1gMSeNG3tSx6xgimuQ0QIZN9G7h0VaG4gvtawrQ
         ptashEK0STQX1GZbmpWoGVTW140F+Yx0mA9vzPTjrYaIgdRU0IegUKR0yFpd4FCnBOvv
         19mvo96js0k2JpbP4vFnTOe08fE3y+ZUXjajteDIwnEjmBMnpLbKAja4ATW2unjWZWcE
         eK1eVyqHrbIz0zH+9y9E9dMnw9fhKJAJ80I64bYacLkJIfJU7lHqqoaR5/q/TBcTtdWI
         4MZlv94MXb8QZ8mISFW4eA6gofPPJHZ544eaPrsR153MqGelCxXC1409r3SBLck0YqQA
         70hg==
X-Gm-Message-State: AOJu0YyCagA1mDIP45e5IV58cakhFQ/c2TUTk/+gA4zh9ER5RoQGJGOg
        ZFDUwrArUYx2q0q7MYNojlsgN+jY/iDC8fsUnyOpWQ==
X-Google-Smtp-Source: AGHT+IGcJfEbgS7gdjTRi15VqOBnofLAVKYDYp+BiSBTY6FDq2imfNat78x7SAxEnsZnDsmfoJVPpQ==
X-Received: by 2002:a0c:a9c2:0:b0:64b:594b:7a60 with SMTP id c2-20020a0ca9c2000000b0064b594b7a60mr11015594qvb.35.1694502679411;
        Tue, 12 Sep 2023 00:11:19 -0700 (PDT)
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com. [209.85.219.44])
        by smtp.gmail.com with ESMTPSA id r9-20020a0c8b89000000b0064f75162d49sm3508855qva.90.2023.09.12.00.11.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Sep 2023 00:11:19 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id 6a1803df08f44-64bd231c95cso30686926d6.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 00:11:18 -0700 (PDT)
X-Received: by 2002:a0c:f312:0:b0:64f:518d:ac8d with SMTP id
 j18-20020a0cf312000000b0064f518dac8dmr11624045qvl.25.1694502677977; Tue, 12
 Sep 2023 00:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230828075420.2009568-1-anle.pan@nxp.com> <DB9PR04MB9284AA58AA71655C9C0C7C9A87E6A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5DYxwX+JdXQ_-ba5B9y+gyWPjvUpCBnKM1zz1W2EkO_vA@mail.gmail.com>
 <DB9PR04MB928460023FB3CCCBC3EACE1487E9A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5BGJX7=Z1ukFRq_ktaQ0d7FbvV-ob5gs8hfGaNHUXPTww@mail.gmail.com>
 <DB9PR04MB9284A0CDB1FC7CAADE0A394F87EFA@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5AugUGh7Z=9Qh7SS4=-0ddGBmRAOOyCGDfPdT-=eurtUg@mail.gmail.com>
 <DB9PR04MB9284A45033B3E24F44C5AA3987F2A@DB9PR04MB9284.eurprd04.prod.outlook.com>
 <CAAFQd5Bk0DUq5jgFDHV2wGYEcfQzNVQ2KYJ2ZYLubwFLgqW4kQ@mail.gmail.com> <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
In-Reply-To: <DB9PR04MB92846D75C93A9B2B8C8A998D87F1A@DB9PR04MB9284.eurprd04.prod.outlook.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Tue, 12 Sep 2023 16:10:59 +0900
X-Gmail-Original-Message-ID: <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
Message-ID: <CAAFQd5Ar18TvFE3jXBuphpCiwWAb8O99wqkiwEVDSs3+MXvW0w@mail.gmail.com>
Subject: Re: [EXT] Re: [PATCH] media: videobuf2-dma-sg: limit the sg segment size
To:     Hui Fang <hui.fang@nxp.com>
Cc:     Anle Pan <anle.pan@nxp.com>,
        "m.szyprowski@samsung.com" <m.szyprowski@samsung.com>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jindong Yue <jindong.yue@nxp.com>,
        Xuegang Liu <xuegang.liu@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 4:01=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wrote:
>
> On Tue, Sep 12 2023 at 11:22=E2=80=AFAM Tomasz Figa <tfiga@chromium.org>
> > On Mon, Sep 11, 2023 at 3:13=E2=80=AFPM Hui Fang <hui.fang@nxp.com> wro=
te:
> > >
> > > On Wed, Sep 6, 2023 at 18:28=E2=80=AFPM Tomasz Figa <tfiga@chromium.o=
rg>
> > wrote:
> > > > That all makes sense, but it still doesn't answer the real question
> > > > on why swiotlb ends up being used. I think you may want to trace
> > > > what happens in the DMA mapping ops implementation on your system
> > > > causing it to use swiotlb.
> > >
> > > Add log and feed invalid data to low buffer on purpose, it's confirme=
d
> > > that swiotlb is actually used.
> > >
> >
> > Yes, that we already know. But why?
>
>
> The physical address of v4l2 buffer is large than 4G (5504139264), so the=
 swiotlb is used.
> "[  846.570271][  T138] software IO TLB: =3D=3D=3D=3D swiotlb_bounce: DMA=
_TO_DEVICE,
>  dst 000000004589fa38, src 00000000c6d7e8d8, srcPhy 5504139264, size 4096=
".

Is your DMA device restricted only to the bottom-most 4 GB (32-bit DMA
address)? If yes, would it make sense to also allocate from that area
rather than bouncing the memory?

Best regards,
Tomasz
