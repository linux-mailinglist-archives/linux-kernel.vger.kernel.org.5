Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570DE76698B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 11:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232603AbjG1J6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 05:58:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234512AbjG1J55 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 05:57:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1A311BF2;
        Fri, 28 Jul 2023 02:57:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74492620A8;
        Fri, 28 Jul 2023 09:57:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8CA3C433CD;
        Fri, 28 Jul 2023 09:57:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690538275;
        bh=oJaH4FPNITgFoQ+abPo51cru9bJTKsgeWccgWhkv5cE=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=SUoVrrVL6fuFu9dh/fQxhreLndwtivej2cw8a+pevy2EpHU+QjJYN4XWPf/xfVkFF
         HX9jFeNC2xSBe5QYPhMsk2oZgjV02lgtYWIc+GeJFb9Vw0R2PT4+vJmLahM1r9i0Nj
         4yvyhCgjGeBSSHWTWWO3pKHYX12kUh0IpZ7nuYzXRwL8L1aWNF8rsVgyXae8BiBMl2
         MTIpT59ZpxB9s2JK7kzGvqTd8NdggCK0QPZn/d0TGUKIUyv3DvKVPCXyGO+2ZYdUAi
         zjzxxOXvK9RN19dlk7XHr8W4zFX7tOgc2fLardbWjO0l4ZdL4FVN/3Qk8r50UDks5F
         B1sGZ7gJbjeXA==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2b9d07a8d84so6271611fa.3;
        Fri, 28 Jul 2023 02:57:55 -0700 (PDT)
X-Gm-Message-State: ABy/qLYbliP+NrzOV4M+cbwQp3bwlSC7ExHynGch5FjhVrKbnqFRCX6e
        ivaNpnQ629K9nyyww8TF6PPhmEzCS+RuR1ymrKI=
X-Google-Smtp-Source: APBJJlGdvD0o+yLEzMNCc0c1pu2cw3CoX/pd5F5+PU3DAnRSXj0L5yohZi4+WeMBmC3e6J8LoSkPbHQyHGUQqY1xvjk=
X-Received: by 2002:a2e:97d7:0:b0:2b6:fa60:85a1 with SMTP id
 m23-20020a2e97d7000000b002b6fa6085a1mr1402058ljj.21.1690538273864; Fri, 28
 Jul 2023 02:57:53 -0700 (PDT)
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <ZMOQiPadP2jggZ2i@gondor.apana.org.au>
In-Reply-To: <ZMOQiPadP2jggZ2i@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Jul 2023 11:57:42 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFRAhoyRD8mGe4xKZ-xGord2vwPXHCM7O8DPOpYWcgnJw@mail.gmail.com>
Message-ID: <CAMj1kXFRAhoyRD8mGe4xKZ-xGord2vwPXHCM7O8DPOpYWcgnJw@mail.gmail.com>
Subject: Re: [RFC PATCH 00/21] crypto: consolidate and clean up compression APIs
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     linux-crypto@vger.kernel.org, Eric Biggers <ebiggers@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Haren Myneni <haren@us.ibm.com>,
        Nick Terrell <terrelln@fb.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Jens Axboe <axboe@kernel.dk>,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        Richard Weinberger <richard@nod.at>,
        David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Steffen Klassert <steffen.klassert@secunet.com>,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        qat-linux@intel.com, linuxppc-dev@lists.ozlabs.org,
        linux-mtd@lists.infradead.org, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 28 Jul 2023 at 11:56, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Tue, Jul 18, 2023 at 02:58:26PM +0200, Ard Biesheuvel wrote:
> >
> > Patch #2 removes the support for on-the-fly allocation of destination
> > buffers and scatterlists from the Intel QAT driver. This is never used,
> > and not even implemented by all drivers (the HiSilicon ZIP driver does
> > not support it). The diffstat of this patch makes a good case why the
> > caller should be in charge of allocating the memory, not the driver.
>
> The implementation in qat may not be optimal, but being able to
> allocate memory in the algorithm is a big plus for IPComp at least.
>
> Being able to allocate memory page by page as you decompress
> means that:
>
> 1. We're not affected by memory fragmentation.
> 2. We don't waste memory by always allocating for the worst case.
>

So will IPcomp be able to simply assign those pages to the SKB afterwards?
