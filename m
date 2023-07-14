Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E64753043
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 05:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234923AbjGND7r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 23:59:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232628AbjGND7o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 23:59:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3A1FD8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1689307140;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z0IXrRel0Jf5sI6yYnB7ussn8KJNTKMqE2zSLssKxOs=;
        b=ddcyXoitP7tXQ0P6AR9Kutjwt7zLz6VFa4jvDbDT9heWVmWw9i6hydBHek+RozusxKJobh
        wuH5PCtqvOvuT0GaOCxeO6WcR7TQsw4K/aJ1cNkweC8O2MSikowwNXgGTzjjXQ8IcOLEUX
        yb/mEOmgC0m0ZJTdQLuM0wupYq1w4uM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-5rByVKtrMceCpmqQQ6CwgA-1; Thu, 13 Jul 2023 23:58:58 -0400
X-MC-Unique: 5rByVKtrMceCpmqQQ6CwgA-1
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-2b69825cca2so14511671fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 20:58:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689307137; x=1691899137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Z0IXrRel0Jf5sI6yYnB7ussn8KJNTKMqE2zSLssKxOs=;
        b=HOsCoKD2n7dheio4mF7mOZV0CAWBV0SoRMp/lk/uMrARhBs5b5sOm4Ws55i7nk7sPb
         SsxLiOeZE/aaDk5rDct9Jw+Kvo+4ZfzonJOYvrkBXhVYalOyZD+O41x7bSb/gNaE6/28
         wT8LnAdjW8PTwIBJntVBok34vKgIuOdNQGvgowOyv1QuKPrpmtpCkuX/hBsd6qGXGyyE
         vziQV6C294ChjWWiKxNe8cdddzAw5+qKvBDAswxJkVpIvg4p5rJsWjOoWDm9DkVH24yc
         9ONXeHRAPSKLXE5GILQq15S3+OQhhJPneRgSJ13NW68+QLpKY6LZulcyY5k+fnbwDQka
         BYhQ==
X-Gm-Message-State: ABy/qLYflKLeeJebH+Y5HcVM2eSy5t2aAdRdQ5SiEM6kBvPlE7eUf+Gd
        udPi1xnd6VpoNzA2l8zEaR2YFjmwU99djf6W+RHIacsgunsYj8WJlrRfVm60ecb3agjOTMu/NXG
        coolXH5bQRHoaywnnpU4eMregsbAEbadDXESLmZWW
X-Received: by 2002:a2e:2c11:0:b0:2b4:8446:82a9 with SMTP id s17-20020a2e2c11000000b002b4844682a9mr541700ljs.17.1689307137503;
        Thu, 13 Jul 2023 20:58:57 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHM/PKtNMaPwkVCmNF7IN6cguTIWBujbOGf1vp5W5x6EOmDtNkZ8J0NSeeeKGnFbM4DzMfzYz0QkyDhMOKB7zc=
X-Received: by 2002:a2e:2c11:0:b0:2b4:8446:82a9 with SMTP id
 s17-20020a2e2c11000000b002b4844682a9mr541689ljs.17.1689307137231; Thu, 13 Jul
 2023 20:58:57 -0700 (PDT)
MIME-Version: 1.0
References: <ZLA0ILTAZsIzxR6c@debian.debian>
In-Reply-To: <ZLA0ILTAZsIzxR6c@debian.debian>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 14 Jul 2023 11:58:46 +0800
Message-ID: <CACGkMEvq8h_yYhxBWD4oPBBwE8xzDMt7VqbW4wz+oqjfYbiQfQ@mail.gmail.com>
Subject: Re: [PATCH v2 net] gso: fix dodgy bit handling for GSO_UDP_L4
To:     Yan Zhai <yan@cloudflare.com>
Cc:     "open list:NETWORKING [TCP]" <netdev@vger.kernel.org>,
        kernel-team@cloudflare.com, Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        David Ahern <dsahern@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
        Xin Long <lucien.xin@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Andrew Melnychenko <andrew@daynix.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:SCTP PROTOCOL" <linux-sctp@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 1:28=E2=80=AFAM Yan Zhai <yan@cloudflare.com> wrote=
:
>
> Commit 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4
> packets.") checks DODGY bit for UDP, but for packets that can be fed
> directly to the device after gso_segs reset, it actually falls through
> to fragmentation:
>
> https://lore.kernel.org/all/CAJPywTKDdjtwkLVUW6LRA2FU912qcDmQOQGt2WaDo28K=
zYDg+A@mail.gmail.com/
>
> This change restores the expected behavior of GSO_UDP_L4 packets.
>
> Fixes: 1fd54773c267 ("udp: allow header check for dodgy GSO_UDP_L4 packet=
s.")
> Suggested-by: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
> Signed-off-by: Yan Zhai <yan@cloudflare.com>
>
> ---
> v2: dropped modifications to tcp/sctp on DODGY bit removal after
> validating gso_segs. Also moved the UDP header check into
> __udp_gso_segment (per Willem's suggestion).
>

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

