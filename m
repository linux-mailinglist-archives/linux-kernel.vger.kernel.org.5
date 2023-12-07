Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 680E880805A
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:46:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230383AbjLGFq3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFq2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:46:28 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3DBD1B4
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:46:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701927993;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
        b=Ou1eulSyabayFdautSHc5oxVnhnZ57YhHzXu1sFulzqCmqtAh73+Ir7nAbtOeeObuTIilg
        nWIK0hS0Yj0TER8oExh2yQLjLPPp2Y5l685flujCp4dgJDqhu0TOnFP1Bwa7EGG2TmNWJu
        IbMT9mq2z3S0rD01UctOOKEEJJModyo=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-682-0e9dBo2oOuONHVGLkghSew-1; Thu, 07 Dec 2023 00:46:32 -0500
X-MC-Unique: 0e9dBo2oOuONHVGLkghSew-1
Received: by mail-pj1-f72.google.com with SMTP id 98e67ed59e1d1-286f8b84890so575241a91.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:46:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701927991; x=1702532791;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QxiqDGFIicHFEtEIHtNQNblDDB+Ip0Yoq6i22AXMcsw=;
        b=iQpCXy4d0VHHg6BaPCNOnvVgwo04F7zJlP+25/49MUym+tqAPRTrUJ2tSq6Awi/BNO
         Q4A2r/J3lD5k0sCHfLXu2lpVRln5XaeddypjAnGuk5Dpcu3Mltt9ev8qiYHfbY+ZCOps
         Mc+VQCg6yUFuK6wk9mVUr9rAZD7VLehad4PSapCFME548bKNW+inVNxmpp1/f+2l4Xhe
         zDHFEu+Xa2nHgUbFyVjPTZfh1mb6lFrZBhtRVjR3qMqfHykOzjP/dmBTIRPv/jfkpeZ9
         1Zbg/2UEHADCA8RoxIAEgaz7ZX8FZNxLTbWRhCb5MdLdk/WfxesBUIP4CuxYlIL7d1/c
         d1yA==
X-Gm-Message-State: AOJu0YydINzIR5E+t7sGt+XjQ+zhgApocQgs5jEdaJydpKP78PtZTDOY
        fxs/LJ0gyYnQ3H3qvXjjp9XKNCNRAIstekXZiZ4LZ9DejvMJYFOXmXaUARXIMkS/c/5Kig+8h+k
        p0mRyD/AvcjrBuPGYI0duGSkt4WUZbwVUqN6JM/hT
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id gc11-20020a17090b310b00b00286bff2c41bmr1876738pjb.23.1701927991086;
        Wed, 06 Dec 2023 21:46:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHUfgjoIKpasl0QD67eKC09rD6Vvob1+V2GPMTPFb8/kThT/w3JyyDRtZYtlMl19xjCR/LXa/IPCZwYXFZnNus=
X-Received: by 2002:a17:90b:310b:b0:286:bff2:c41b with SMTP id
 gc11-20020a17090b310b00b00286bff2c41bmr1876711pjb.23.1701927990817; Wed, 06
 Dec 2023 21:46:30 -0800 (PST)
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-6-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-6-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 13:46:19 +0800
Message-ID: <CACGkMEsiDbZcCAKDxK7hQ=pqWM-GHG2UaKRGM264ozqKVwZRPg@mail.gmail.com>
Subject: Re: [PATCH net-next 5/6] net: introduce page_frag_cache_drain()
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jeroen de Borst <jeroendb@google.com>,
        Praveen Kaligineedi <pkaligineedi@google.com>,
        Shailend Chand <shailend@google.com>,
        Eric Dumazet <edumazet@google.com>,
        Felix Fietkau <nbd@nbd.name>, John Crispin <john@phrozen.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Mark Lee <Mark-MC.Lee@mediatek.com>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-nvme@lists.infradead.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev,
        linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> When draining a page_frag_cache, most user are doing
> the similar steps, so introduce an API to avoid code
> duplication.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

For vhost part:

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

