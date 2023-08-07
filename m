Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67BA577276F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:18:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232094AbjHGOS2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:18:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbjHGOS0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:18:26 -0400
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C182310EC;
        Mon,  7 Aug 2023 07:18:24 -0700 (PDT)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-686b9920362so2919966b3a.1;
        Mon, 07 Aug 2023 07:18:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691417904; x=1692022704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=OFa2DA6rsp2C0K+a6N9BrivDhqrO+NCruJ7CR9dDb7o=;
        b=GhkcVMDdfN+i+WCgvxeTkq/6+gLN4DWfjb9Od16ZT4Q+VPy4II9K86rVuyKa1g2CNI
         TQvKupNyff2Z5/iqxAomzMOGk4ei6vGT+HSWsYgaaoxlYnj/olx/MFyEtrWewbGWCS0p
         IPCY3m2n0DOtY4vk55q46j3BJ2wztoNTOYXvHlyIkM7peN8Lhj6DjNFFNzoRztIwqtmG
         l2hoMy/JXEt4qJ8G2VrrYHfte9TIaNW8nQFx1QmJlUUl59K/M//E5M6FZHsVQfPJLph2
         8c+4c+9pcXThkNF1jgLxpBdW2YfyGoA3WLpPy85LUIoyJJ9pC6IE6SV9w5+kLB3zSKwh
         LA0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691417904; x=1692022704;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OFa2DA6rsp2C0K+a6N9BrivDhqrO+NCruJ7CR9dDb7o=;
        b=C8irlkLeNOzMkAkqfyKhsPw3XQEh48Wcg8wCTQFIFOPmE6c7u+WxPQwsLZ21X3Zdl2
         b+Bjwx8d9ddnbcS5pgHi3WCQQnJkgqDyoHgHPzWJ88DpzZd0ihQLimIdAKD9Us5LvD50
         3IZIm3jPWP0SGhAq0jFkQq/Fl+ffSUJrom5D+QdSM8FFQzTrLBJ2J3k1rmrvpKbp2fAv
         xXPb4CsSX/flsxqp5eshr+WXf5PXFEV3MvMR8eLl/fZHhb4oYRVJnPR+8BFRz9Q9sRy6
         SE2GWdFTAbp0PGQKYnvkijJ7GygErDp128a5suiPVFEGUInkaruaDgNwjVKecc+I5YAf
         Jy2A==
X-Gm-Message-State: AOJu0YyE6GjAdfQIyd6MgWXKiU54AAhhU1TAmFEcW/9ncEsvthzVtoPK
        CVp5F3GbC/NvWy9qoy2mgNc=
X-Google-Smtp-Source: AGHT+IGJR3aWeUe8oH6VPG0NncqV3FpbFGTFqIEh8huV+y5dUGQaCZZJXiqYzMeqapqLEJBm/5DW6Q==
X-Received: by 2002:a05:6a21:498a:b0:13b:a1eb:79e6 with SMTP id ax10-20020a056a21498a00b0013ba1eb79e6mr8392636pzc.53.1691417903704;
        Mon, 07 Aug 2023 07:18:23 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id g15-20020aa7874f000000b006878f50d071sm6231031pfo.203.2023.08.07.07.18.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:18:23 -0700 (PDT)
Message-ID: <0aa395ee0386b4b470c152b95cc8a0517ee2d2cd.camel@gmail.com>
Subject: Re: [PATCH net-next] page_pool: Clamp ring size to 32K
From:   Alexander H Duyck <alexander.duyck@gmail.com>
To:     Jesper Dangaard Brouer <hawk@kernel.org>,
        Ratheesh Kannoth <rkannoth@marvell.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>
Date:   Mon, 07 Aug 2023 07:18:21 -0700
In-Reply-To: <b8eb926e-cfc9-b082-5bb9-719be3937c5d@kernel.org>
References: <20230807034932.4000598-1-rkannoth@marvell.com>
         <b8eb926e-cfc9-b082-5bb9-719be3937c5d@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.3 (3.48.3-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2023-08-07 at 13:42 +0200, Jesper Dangaard Brouer wrote:
>=20
> On 07/08/2023 05.49, Ratheesh Kannoth wrote:
> > https://lore.kernel.org/netdev/20230804133512.4dbbbc16@kernel.org/T/
> > Capping the recycle ring to 32k instead of returning the error.
> >=20
>=20
> Page pool (PP) is just a cache of pages.  The driver octeontx2 (in link)
> is creating an excessive large cache of pages.  The drivers RX
> descriptor ring size should be independent of the PP ptr_ring size, as
> it is just a cache that grows as a functions of the in-flight packet
> workload, it functions as a "shock absorber".
>=20
> 32768 pages (4KiB) is approx 128 MiB, and this will be per RX-queue.
>=20
> The RX-desc ring (obviously) pins down these pages (immediately), but PP
> ring starts empty.  As the workload varies the "shock absorber" effect
> will let more pages into the system, that will travel the PP ptr_ring.
> As all pages originating from the same PP instance will get recycled,
> the in-flight pages in the "system" (PP ptr_ring) will grow over time.
>=20
> The PP design have the problem that it never releases or reduces pages
> in this shock absorber "closed" system. (Cc. PP people/devel) we should
> consider implementing a MM shrinker callback (include/linux/shrinker.h).
>=20
> Are the systems using driver octeontx2 ready to handle 128MiB memory per
> RX-queue getting pinned down overtime? (this could lead to some strange
> do debug situation if the memory is not sufficient)
>=20
> --Jesper

I'm with Jesper on this. It doesn't make sense to be tying the
page_pool size strictly to the ring size. The amount of recycling you
get will depend on how long the packets are on the stack, not in the
driver.

For example, in the case of something like a software router or bridge
that is just taking the Rx packets and routing them to Tx you could
theoretically get away with a multiple of NAPI_POLL_WEIGHT since you
would likely never need much more than that as the Tx would likely be
cleaned about as fast as the Rx can consume the pages.

Rather than overriding the size here wouldn't it make more sense to do
it in the octeontx2 driver? With that at least you would know that you
were the one that limited the size instead of having the value modified
out from underneath you.

That said, one change that might help to enable this kind of change
would be look at adding a #define so that this value wouldn't be so
much a magic number and would be visible to the drivers should it ever
be changed in the future.
