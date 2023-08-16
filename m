Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F194F77E437
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 16:54:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233213AbjHPOyR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 10:54:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343824AbjHPOxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 10:53:45 -0400
Received: from mail-qk1-x736.google.com (mail-qk1-x736.google.com [IPv6:2607:f8b0:4864:20::736])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7502610FF;
        Wed, 16 Aug 2023 07:53:40 -0700 (PDT)
Received: by mail-qk1-x736.google.com with SMTP id af79cd13be357-76754b9eac0so447950385a.0;
        Wed, 16 Aug 2023 07:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692197619; x=1692802419;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C/F+yO89r+58XA2jTJmqFV7AKNI1UXlByvHmUmA3sA4=;
        b=hJ0JNR07O6hNfvI0xZ2K57RdwwA+zhGGvgN1u5MeIJpwg2g6A38rxQYYtjMTc+DrIQ
         OQKQIzsh/kXj6LBcKPZHjh6TDJjQoyZR9sv/ZFs1MrH/0YQbtE8WdYpPg89JB9m9u9j8
         y/u5h/wRwaSktqnNv6AeWOnq16To/G5M8xOsJ4xwE5+6U03REY4mPgeLMapCOdBPycHL
         JEq5/GHZ+7CMff1ABYwHMm7pYN1NFal7znvXjmINFymH4O7Fe5T77dnWF9Ir/tCqjnF7
         mqH+Pdma8Ou779VNhqk7dP7ET2SKLB2szR+/7oxYyeGGm6ZxG5QXiGhmus7LtSaOPOCl
         7lcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692197619; x=1692802419;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:cc:to:from:date:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=C/F+yO89r+58XA2jTJmqFV7AKNI1UXlByvHmUmA3sA4=;
        b=TwJPZDWuQ6yYY3cc8JdtNTnPKLnQ5HMJxRVb5Tbcqp5vU9uTXeesq8k8d1XLfMCkL6
         HTYXPE0c0+vOSezD1Fbzjbsv4Kdcl8FZy37ySmwhl/yPZ5sq6zCudMslHNq21dZZx+O8
         IZ1GCJIO5voIS+ZsHBL0ygMyJvLWC/BtF1ZkPokbjG7ZeDMCytoMfRHpTWajCU26cLpc
         27Dt93OTiewquyX96CHaxXQuup86akms3WyObXNv557ksbh7P88fgaLoBRhUGCWhAtQR
         gNUTu1bu086oBc8u/Qtb4HY2gakPe4/doqBlsdVJDtxMTyZol8vZgJs+Azv+KxqZhkgW
         8AEQ==
X-Gm-Message-State: AOJu0Yx/S7N5QQyji3faY5MWaDCWgGkWBeKhv1RofwYMY4AgJs5LxVxm
        GqZh9oqyulmIKnOtUXeS01A=
X-Google-Smtp-Source: AGHT+IE/ongpvCQd3F2ohVavPqcLH2c3ICTQBale59UpK8GdXCBun10dc4tTmVJGODuMRW1RyyVMpQ==
X-Received: by 2002:a05:620a:b8d:b0:76c:9ad6:8199 with SMTP id k13-20020a05620a0b8d00b0076c9ad68199mr1789963qkh.77.1692197619528;
        Wed, 16 Aug 2023 07:53:39 -0700 (PDT)
Received: from localhost (172.174.245.35.bc.googleusercontent.com. [35.245.174.172])
        by smtp.gmail.com with ESMTPSA id f23-20020a05620a15b700b0076cf0c4eecbsm4469821qkk.0.2023.08.16.07.53.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Aug 2023 07:53:38 -0700 (PDT)
Date:   Wed, 16 Aug 2023 10:53:38 -0400
From:   Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To:     Feng Liu <feliu@nvidia.com>,
        Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Simon Horman <horms@kernel.org>
Cc:     virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Bodong Wang <bodong@nvidia.com>, Jiri Pirko <jiri@nvidia.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Message-ID: <64dce2f2b99f5_23f1f82949f@willemb.c.googlers.com.notmuch>
In-Reply-To: <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
References: <20230814171845.65930-1-feliu@nvidia.com>
 <ZNtYpohWyjnb883M@vergenet.net>
 <05348d62-586c-4b1f-40bd-5541caca0947@nvidia.com>
 <ZNunz1hbqPKpcOgA@vergenet.net>
 <CAF=yD-L+d34Uuvt3sOFOnxXhMmoMXNfHzcaSPk=t1PtiPUHZ1g@mail.gmail.com>
 <f9f3c150-2b5e-7bd0-1c1a-062bd1f16fcd@nvidia.com>
Subject: Re: [PATCH net v1] virtio_net: Introduce skb_vnet_common_hdr to avoid
 typecasting
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > 
> > Since legacy virtio will no longer be modified, I don't think there is
> > much value is exposing this new union as UAPI. I do appreciate the
> > benefit to the implementation.
> > 
> > [1] https://patches.linaro.org/project/netdev/patch/20210208185558.995292-3-willemdebruijn.kernel@gmail.com/
> Hi, William and Simon
> 
> Thanks for the detailed explanation.
> 
> I kept virtio_net_hdr_mrg_rxbuf and virtio_net_hdr_v1_hash structures in 
> virtio_net.h, which can be forward compatible with existing user 
> applications which use these structures.

They're UAPI, so we cannot modify or remove them anyway.

Which is exactly why we want to be careful with adding anything new.
 
> virtio_net_hdr_v1_hash cannot use virtio_net_hdr as the first member, 
> because in virtio_net_hdr_v1, csum_start and csum_offset are stored in 
> union as a structure, and virtio_net_hdr cannot be used instead.

Oh right. That wasn't always the case, or the reason for this.
Not super relevant but, commit ed9ecb0415b9 has the history

    virtio: Don't expose legacy net features when VIRTIO_NET_NO_LEGACY defined.

    In particular, the virtio header always has the u16 num_buffers field.
    We define a new 'struct virtio_net_hdr_v1' for this (rather than
    simply calling it 'struct virtio_net_hdr', to avoid nasty type errors
    if some parts of a project define VIRTIO_NET_NO_LEGACY and some don't.

    Transitional devices (which can't define VIRTIO_NET_NO_LEGACY) will
    have to keep using struct virtio_net_hdr_mrg_rxbuf, which has the same
    byte layout as struct virtio_net_hdr_v1.

The union was added to overload csum use on tx with RSC use on rx, in
commit 22b436c9b568. I don't quite follow why there now are three
structs, rather than two. The first two seem to both implement csum
partial. Anyway, not super important here.

> In addition, I put this new structure virtio_net_common_hdr in uapi, 
> hoping it could be used in future user space application to avoid 
> potential risks caused by type coercion (such as the problems mentioned 
> in the patch description ). So I think it should be in this header file.
> What do you think?

Adding anything to UAPI has a high bar. Do you have a concrete use
case for this?

This does seem mostly a helper to simplify kernel logic to me, which
is better kept in non-UAPI headers.
