Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A0F772839
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 16:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbjHGOxN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 10:53:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjHGOxK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 10:53:10 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BA93107;
        Mon,  7 Aug 2023 07:53:09 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id 5614622812f47-3a76cbd4bbfso3569296b6e.3;
        Mon, 07 Aug 2023 07:53:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691419988; x=1692024788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gPyaQLNjb03ouvrVyzPL3TMkSNOyEwc/JBGegxpaeoQ=;
        b=YV8CMowsfVp8X6lMPHl/4+xuV9+mbuGldWgDG9uuV3GYK4sRZmzQacSaGoVaGXGrFL
         TCTYYAH589fxwBm8SRCBSSf06Pp/XTN7WaSI5MiN2GH8275qYCfKGNbQNzUxlbCRVkZ1
         iCGrn9ClTh0mOSTiJRgvgOlJLGc4VH3MyhD90tT0Uupg5ZIJQgtPwEu7cpXeyjoGt2rJ
         98qzrj0JMndq0M8Yd7UWERIn/7ww5tld01a8IbiNg+mAcF8pOMnhNKLHfjLb2hvzOxuL
         spLcbF0IFnhss8bzwh2Q+PDi3INuSrYO7RVIbesqQE4olgA792oWqbNDQZjOWa0bthlF
         cKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691419988; x=1692024788;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gPyaQLNjb03ouvrVyzPL3TMkSNOyEwc/JBGegxpaeoQ=;
        b=TUbHzXQpabe1u+fp5Cg9vp/++l9qgzBVMEoH3pWBave7aFOXF4hYe0QMF0iXNKzjc5
         JziFf/eeil6BjGXlWMaE7JegBmXcnnT07V2JqNJsfGcMrs48rqA1eL+PDA43E/khzUj7
         1LivL+XcD5dt1nLtr1Z1lJReV1R9k7j3Qw/4UQ0AvSSRunFxOwY1m+9y6GR1EjJdw4pX
         CPyXCJ6fZvKrd/9kYjA6qk4cBS638tI4RYshwrDyWV1nQ91vGjtJrO3aXumPW4MVkFKM
         w23yQgFe+Q8KnzPA7JetsD1ZSIvKDab1c07RHN8awGcjGMxdwtWDXH2tUmR7idQyBQkG
         xVbg==
X-Gm-Message-State: AOJu0YyQZEmrirlCSQL474Eq0UiyYGydPeArvoWmHP+GGdBVCr9o+U1O
        uPnKbGWTEdkr0+T2+IsZX8s=
X-Google-Smtp-Source: AGHT+IGQy+/2WjTiRQlHtjorkHwUnq3HFiuiWRlKIjB42JMnDCj4CZgQt28EvYw9iJNEkeYresq4Kg==
X-Received: by 2002:aca:6506:0:b0:3a7:540f:ca71 with SMTP id m6-20020aca6506000000b003a7540fca71mr10003496oim.53.1691419988476;
        Mon, 07 Aug 2023 07:53:08 -0700 (PDT)
Received: from ?IPv6:2605:59c8:448:b800:82ee:73ff:fe41:9a02? ([2605:59c8:448:b800:82ee:73ff:fe41:9a02])
        by smtp.googlemail.com with ESMTPSA id w184-20020a6362c1000000b00563feb7113dsm5013767pgb.91.2023.08.07.07.53.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Aug 2023 07:53:08 -0700 (PDT)
Message-ID: <db73f4943475a1cd7f79d70896e331204102ea4e.camel@gmail.com>
Subject: Re: [PATCH net-next v4 0/6] page_pool: a couple of assorted
 optimizations
From:   Alexander H Duyck <alexander.duyck@gmail.com>
To:     Alexander Lobakin <aleksander.lobakin@intel.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
        Larysa Zaremba <larysa.zaremba@intel.com>,
        Yunsheng Lin <linyunsheng@huawei.com>,
        Alexander Duyck <alexanderduyck@fb.com>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        Ilias Apalodimas <ilias.apalodimas@linaro.org>,
        Simon Horman <simon.horman@corigine.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 07 Aug 2023 07:53:06 -0700
In-Reply-To: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
References: <20230804180529.2483231-1-aleksander.lobakin@intel.com>
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

On Fri, 2023-08-04 at 20:05 +0200, Alexander Lobakin wrote:
> That initially was a spin-off of the IAVF PP series[0], but has grown
> (and shrunk) since then a bunch. In fact, it consists of three
> semi-independent blocks:
>=20
> * #1-2: Compile-time optimization. Split page_pool.h into 2 headers to
>   not overbloat the consumers not needing complex inline helpers and
>   then stop including it in skbuff.h at all. The first patch is also
>   prereq for the whole series.
> * #3: Improve cacheline locality for users of the Page Pool frag API.
> * #4-6: Use direct cache recycling more aggressively, when it is safe
>   obviously. In addition, make sure nobody wants to use Page Pool API
>   with disabled interrupts.
>=20
> Patches #1 and #5 are authored by Yunsheng and Jakub respectively, with
> small modifications from my side as per ML discussions.
> For the perf numbers for #3-6, please see individual commit messages.
>=20
> Also available on my GH with many more Page Pool goodies[1].
>=20
> [0] https://lore.kernel.org/netdev/20230530150035.1943669-1-aleksander.lo=
bakin@intel.com
> [1] https://github.com/alobakin/linux/commits/iavf-pp-frag
>=20
> Alexander Lobakin (4):
>   net: skbuff: don't include <net/page_pool/types.h> to <linux/skbuff.h>
>   page_pool: place frag_* fields in one cacheline
>   net: skbuff: avoid accessing page_pool if !napi_safe when returning
>     page
>   net: skbuff: always try to recycle PP pages directly when in softirq
>=20
> Jakub Kicinski (1):
>   page_pool: add a lockdep check for recycling in hardirq
>=20
> Yunsheng Lin (1):
>   page_pool: split types and declarations from page_pool.h

So the series mostly looks good to me. My only concern would be with
path 5 since I am not sure why we are just throwing a WARN_ON when we
could just take action on the info to prevent the problem in the first
place. That said the change doesn't hurt anything as-is so I would be
good with us thinking about changing that as a follow-up.

Reviewed-by: Alexander Duyck <alexanderduyck@fb.com>

