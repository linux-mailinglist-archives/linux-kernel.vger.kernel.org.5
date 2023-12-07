Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C359D808060
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 06:52:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346664AbjLGFwT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 00:52:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjLGFwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 00:52:18 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 514B21AD
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 21:52:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1701928342;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HSUZB2MS9IXq3JbO5o9diZppcpNs8joa8PI6k/pJS1g=;
        b=bUuLd1zAB94Wp3czypK6KO1DTShTcZhE4ZWPboHv4K20/bMl0XIBjYI+hWHcFzkvSElpQb
        6DP4jwMyk0p1Fb/q/KsrEFg+l6STM9SOFKdGP4dHV9ymL40pjvFs0OJ7+pwa5ehWhHa4ZC
        TBwUVQV1rx3f9F8IdI/zNExebeKBo8Q=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-WBYIC2X5PninDoBu-ZlXDg-1; Thu, 07 Dec 2023 00:52:20 -0500
X-MC-Unique: WBYIC2X5PninDoBu-ZlXDg-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2866c800dd5so737126a91.0
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 21:52:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701928339; x=1702533139;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HSUZB2MS9IXq3JbO5o9diZppcpNs8joa8PI6k/pJS1g=;
        b=oo3i4pOAaCuaOmpbehuIDBP7YML2IM7z0FGuMKhz3lvmG2RRNGVb/rtM8g87Ng0/SW
         AcY5q8M9TNObcocVrMn9hbbKHQPF6+snvImoTVSBLDzEtxen5zKkcJKK2oiRC9STs7kZ
         pnSAMdm+ZHTcsOMvKlPxELMNWNy6nMpq35PyiO1lNd5LWUDfYkSwR9daIytJfAM6VQRp
         my7OUOmF4Gvpszft1vPD+GZczeN8deRR31WC2mWKlk8dqilDvw9nAJCBG4JA/NcRcJa0
         jbvK8PVl9zrvakpVBB5EvsSMKusgRFDQXXyIxqNPwUArAChvNeV1d/N8JTtGU1RdwcGT
         qBGA==
X-Gm-Message-State: AOJu0Ywt2mnQewAXSqGyMCGHj56C6xoylp4KEqFlKGfGBuxj8Ye5Zeq9
        5+t8zWuzsXiNYSi/KCGsAx4DByjm1wHAXu+JbZGAWslMXau+TOc4H1PaXPfnAluFToQfs39GGyj
        iKbu4cOgLMOdCg+C1M3LxOTuW+IZ6fXruyk0IGqdB
X-Received: by 2002:a17:90a:fd09:b0:286:6cc0:cad3 with SMTP id cv9-20020a17090afd0900b002866cc0cad3mr1949087pjb.74.1701928339212;
        Wed, 06 Dec 2023 21:52:19 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHmSjJEJticrA6iI+yH1lm5XAyMtFr/azBvGsGe1XMJiQigUQ9nLH+oU43aD6xf+IguxCTdguGcxA4sxW4hVuw=
X-Received: by 2002:a17:90a:fd09:b0:286:6cc0:cad3 with SMTP id
 cv9-20020a17090afd0900b002866cc0cad3mr1949085pjb.74.1701928338997; Wed, 06
 Dec 2023 21:52:18 -0800 (PST)
MIME-Version: 1.0
References: <20231205113444.63015-1-linyunsheng@huawei.com> <20231205113444.63015-5-linyunsheng@huawei.com>
In-Reply-To: <20231205113444.63015-5-linyunsheng@huawei.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 7 Dec 2023 13:52:08 +0800
Message-ID: <CACGkMEvwG6EvZ3me9ReqA-YSR1Y_6fb_kotT=+PFARaLS1FTmg@mail.gmail.com>
Subject: Re: [PATCH net-next 4/6] vhost/net: remove vhost_net_page_frag_refill()
To:     Yunsheng Lin <linyunsheng@huawei.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>, kvm@vger.kernel.org,
        virtualization@lists.linux.dev, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 5, 2023 at 7:35=E2=80=AFPM Yunsheng Lin <linyunsheng@huawei.com=
> wrote:
>
> The page frag in vhost_net_page_frag_refill() uses the
> 'struct page_frag' from skb_page_frag_refill(), but it's
> implementation is similar to page_frag_alloc_align() now.
>
> This patch removes vhost_net_page_frag_refill() by using
> 'struct page_frag_cache' instead of 'struct page_frag',
> and allocating frag using page_frag_alloc_align().
>
> The added benefit is that not only unifying the page frag
> implementation a little, but also having about 0.5% performance
> boost testing by using the vhost_net_test introduced in the
> last patch.
>
> Signed-off-by: Yunsheng Lin <linyunsheng@huawei.com>
> ---

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

