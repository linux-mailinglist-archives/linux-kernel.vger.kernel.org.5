Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A8A47E645D
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 08:34:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232670AbjKIHer (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 02:34:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232571AbjKIHeq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 02:34:46 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0673BA4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 23:34:44 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id 2adb3069b0e04-507ad511315so781833e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 23:34:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699515282; x=1700120082; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ZGyCYYTcq3tfAOSXtV2/dw7L3jydVZ3P+lrWN5MQ7s=;
        b=QGwWwhGcIEfCBWhkJ5TkyvjMJH/ObZpubIeTtgXwTvt/1soFM6HaeOnEOJK54zM/uO
         mQYkEsKSbFdsZFVyKdH78TU6LlYvybvK/Gc1l87/c2l5PVcBQBRbd+WRneSjS3eCh5It
         1gAb7YeX4dlCC2zbeLed/tsdl58JEGMS97nwg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699515282; x=1700120082;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ZGyCYYTcq3tfAOSXtV2/dw7L3jydVZ3P+lrWN5MQ7s=;
        b=hwByjB1YI8NvRlmU8AF32eV05Z2rX2tWqaHVimJaKr0uiWMGeU+/A/ZmK7kZwY6guW
         6paQm3eMjbVENv8/+QWhGi7pj6QAYHyH259a/BUAc04sa1mJP91RtErQz0Nsonnh9gIH
         83W054xrjlrexPpt6fVLdKF6njH3MIZEHbA8VrZoS+KWzmYvm310j47c/BB2s5JHQPZk
         jU/qUAHnc59GwftD/zKise3LvR9TZ2fyecolvtlFpeUb/sQ24SYSVg5cnwKG6NY6vSUP
         q/NhRzRlzYhUfKG6AEQlCSOOjLlfDSa35Ll8xC3jtVL8ZSTKsN7CekiHGhhgHJ+Fgw9K
         uMKA==
X-Gm-Message-State: AOJu0YwV4yg0iNSKMFZK6a2Pdgfiobmc4opjwB/alx9LbRY67AmDqG6y
        kfHvFywf76eHIr1POPDYvEfrIWXDIUghwXuyHiPm8Va9
X-Google-Smtp-Source: AGHT+IEB4VFPt0u/mXE0t4bUMnjB6eUH0jNcp5oTSABlG38593ToFwVjjQ1dRRzv9SYHl+Qbr1WUGQ==
X-Received: by 2002:ac2:5f8a:0:b0:507:9803:ff8b with SMTP id r10-20020ac25f8a000000b005079803ff8bmr771881lfe.44.1699515282165;
        Wed, 08 Nov 2023 23:34:42 -0800 (PST)
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com. [209.85.167.52])
        by smtp.gmail.com with ESMTPSA id o15-20020a056512230f00b00509469ffb01sm964545lfu.193.2023.11.08.23.34.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 08 Nov 2023 23:34:42 -0800 (PST)
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-507ad511315so781829e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Nov 2023 23:34:42 -0800 (PST)
X-Received: by 2002:adf:e311:0:b0:32c:ea14:89e5 with SMTP id
 b17-20020adfe311000000b0032cea1489e5mr3220105wrj.39.1699514920620; Wed, 08
 Nov 2023 23:28:40 -0800 (PST)
MIME-Version: 1.0
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-53-benjamin.gaignard@collabora.com>
 <20231108104439.oxpbbd2yro7u57t4@chromium.org> <e9eeac63-b4d5-4710-bb85-b0997dce55cc@collabora.com>
In-Reply-To: <e9eeac63-b4d5-4710-bb85-b0997dce55cc@collabora.com>
From:   Tomasz Figa <tfiga@chromium.org>
Date:   Thu, 9 Nov 2023 16:28:20 +0900
X-Gmail-Original-Message-ID: <CAAFQd5AH6x461-a2=2JmzUhW2pWacgwj1w3SZH1kfMBbsmaZ3A@mail.gmail.com>
Message-ID: <CAAFQd5AH6x461-a2=2JmzUhW2pWacgwj1w3SZH1kfMBbsmaZ3A@mail.gmail.com>
Subject: Re: [PATCH v14 52/56] media: core: Add bitmap manage bufs array entries
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 9, 2023 at 12:30=E2=80=AFAM Benjamin Gaignard
<benjamin.gaignard@collabora.com> wrote:
>
>
> Le 08/11/2023 =C3=A0 11:44, Tomasz Figa a =C3=A9crit :
> > On Tue, Oct 31, 2023 at 05:31:00PM +0100, Benjamin Gaignard wrote:
[snip]
> >> @@ -1150,7 +1150,10 @@ static inline bool vb2_fileio_is_active(struct =
vb2_queue *q)
> >>    */
> >>   static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
> >>   {
> >> -    return q->num_buffers;
> >> +    if (!q->bufs_bitmap)
> >> +            return 0;
> >> +
> >> +    return bitmap_weight(q->bufs_bitmap, q->max_num_buffers);
> > Hmm, could we just cache the number of buffers we have, so that we don'=
t
> > have to go over the entire bitmap every time? (Basically just keep the
> > code that we had for handling q->num_buffers before this patch.)
>
> I would prefer no duplicate how the number of buffers in a queue is compu=
ted
> and bitmap offer helpers for that. Why not use it ?
>

bitmap_weight() can become costly when the number of buffers grows.
Since it's easy to track how many buffers we add and remove, we could
just cache that number and then any code could call
vb2_get_num_buffers() whenever it needs the buffer count without
caring how costly it is.

> >
> >>   }
> >>
> >>   /**
> >> @@ -1253,13 +1256,13 @@ static inline void vb2_clear_last_buffer_deque=
ued(struct vb2_queue *q)
> >>   static inline struct vb2_buffer *vb2_get_buffer(struct vb2_queue *q,
> >>                                              unsigned int index)
> >>   {
> >> -    if (!q->bufs)
> >> +    if (!q->bufs_bitmap)
> >>              return NULL;
> >>
> >>      if (index >=3D q->max_num_buffers)
> >>              return NULL;
> >>
> >> -    if (index < q->num_buffers)
> >> +    if (test_bit(index, q->bufs_bitmap))
> > Aha, I see why we need the extra condition above now. Perhaps it should=
've
> > been added in this patch instead?
>
> For me it was more explicit do introduce it at the same time that
> max_num_buffers field.

Okay. I don't have a strong opinion, especially since it was just an
intermediate patch.

Best regards,
Tomasz
