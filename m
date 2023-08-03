Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C81276EA01
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 15:23:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjHCNXO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 09:23:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236181AbjHCNXE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 09:23:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3F571BFA
        for <linux-kernel@vger.kernel.org>; Thu,  3 Aug 2023 06:22:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691068938;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BNTHDdg/8y8LZ/kyOzqf0q4Up0RQizeLF6R2Nz/km3o=;
        b=bakDvd5rFfSJup0hV2VK9NCHVEnIQAdCiHOjC11gbBzBWY9bDrlMBL1im1G9HckLOqlE1W
        yrz3MuBjkWuiR+/AYwXhyv8TyS/TS1Z9whvCNPeuzE50XxavOzRwgfNEXYPkKZSguiAW8p
        KhnsNfFk5Wd7tCiygo7zf9cDcvMWX0Q=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-yciUZ84QPqqeWqpBHmXTvA-1; Thu, 03 Aug 2023 09:22:17 -0400
X-MC-Unique: yciUZ84QPqqeWqpBHmXTvA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-76cb292df12so24504285a.0
        for <linux-kernel@vger.kernel.org>; Thu, 03 Aug 2023 06:22:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691068936; x=1691673736;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BNTHDdg/8y8LZ/kyOzqf0q4Up0RQizeLF6R2Nz/km3o=;
        b=TIc2okYKT2ECBZsgeIlQXs81IHa4St8HPlLXepK3opI1jcGFCFaNQGljJt5bfOZ0xR
         WD+U5RFWGA79p/mQoEU3LjRscKc/5ybDF6ryPRJLJbRfu7VLiuDhIbWWZjlSS84Fo7PU
         Zvgfugor3X13Dp4dfHqnLC7S6r/EwNuKeSTIPeU1YZxIPcU/aQHkDV4FDk5P2N5rUvep
         cyV20td/DSTToLjcjwhtpaViqcJcSJWI5DEtEBlpuAyOP2BzoPxzceXCXc/ntpzMf6VA
         dq4J041hmBPQVIeG5R3zrPIhRxvIcE2KRFejKzcqSyw+32dRVQeDcnj9X9oQrEhXEc53
         Zfzg==
X-Gm-Message-State: ABy/qLYnUZwHyEzFN9sT7i3BUNOamIihjpS7jsL39iizefsRUcP94Jo/
        rqwginAQ1YI/Ql+xdOcQYIF3Rg/Y7BXQV8IQhZEYQ1H3Rqkg/vsFSiXrh+2iiC218XXIyzropOB
        UJ5wEzwSzfy3au1cQ4X5xHTLY
X-Received: by 2002:ac8:7d90:0:b0:400:a9a4:8517 with SMTP id c16-20020ac87d90000000b00400a9a48517mr17924160qtd.4.1691068936705;
        Thu, 03 Aug 2023 06:22:16 -0700 (PDT)
X-Google-Smtp-Source: APBJJlHqLxU/E4sYmLXRhgaw/0xEY4EC2L0mYwpjXh1EAJzhzXzHaIC/+6zCE6ZmGqdXbhMs9U4PhQ==
X-Received: by 2002:ac8:7d90:0:b0:400:a9a4:8517 with SMTP id c16-20020ac87d90000000b00400a9a48517mr17924148qtd.4.1691068936451;
        Thu, 03 Aug 2023 06:22:16 -0700 (PDT)
Received: from gerbillo.redhat.com (146-241-226-226.dyn.eolo.it. [146.241.226.226])
        by smtp.gmail.com with ESMTPSA id a26-20020ac8001a000000b00403ad6ec2e8sm6217311qtg.26.2023.08.03.06.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Aug 2023 06:22:16 -0700 (PDT)
Message-ID: <8470c431e0930d2ea204a9363a60937289b7fdbe.camel@redhat.com>
Subject: Re: [PATCH v3 net-next 0/5] selftests: openvswitch: add flow
 programming cases
From:   Paolo Abeni <pabeni@redhat.com>
To:     Aaron Conole <aconole@redhat.com>, netdev@vger.kernel.org
Cc:     dev@openvswitch.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, Shuah Khan <shuah@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>,
        Pravin B Shelar <pshelar@ovn.org>,
        Adrian Moreno <amorenoz@redhat.com>,
        Ilya Maximets <i.maximets@ovn.org>
Date:   Thu, 03 Aug 2023 15:22:12 +0200
In-Reply-To: <20230801212226.909249-1-aconole@redhat.com>
References: <20230801212226.909249-1-aconole@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2023-08-01 at 17:22 -0400, Aaron Conole wrote:
> The openvswitch selftests currently contain a few cases for managing the
> datapath, which includes creating datapath instances, adding interfaces,
> and doing some basic feature / upcall tests.  This is useful to validate
> the control path.
>=20
> Add the ability to program some of the more common flows with actions. Th=
is
> can be improved overtime to include regression testing, etc.
>=20
> v2->v3:
> 1. Dropped support for ipv6 in nat() case
> 2. Fixed a spelling mistake in 2/5 commit message.
>=20
> v1->v2:
> 1. Fix issue when parsing ipv6 in the NAT action
> 2. Fix issue calculating length during ctact parsing
> 3. Fix error message when invalid bridge is passed
> 4. Fold in Adrian's patch to support key masks

FTR, this apparently requires an [un?]fairly recent version of
pyroute2. Perhaps you could explicitly check for a minimum working
version and otherwise bail out (skip) the add-flow tests.

Cheers,

Paolo


