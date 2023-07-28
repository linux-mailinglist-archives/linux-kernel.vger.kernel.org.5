Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD4A07669C2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 12:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235705AbjG1KDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 06:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235148AbjG1KDj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 06:03:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59ADF35A2;
        Fri, 28 Jul 2023 03:03:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B674C620A8;
        Fri, 28 Jul 2023 10:03:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C66C433CB;
        Fri, 28 Jul 2023 10:03:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690538617;
        bh=Mwb3geMIex9bief6/MfEaJk/1F/fz+2cfnXdqIIS7kA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tXpHkr01M64W1DlXlgN/uXAgQO8lbyiEuO9Cf0SA6Q2RwpJdglx+2A0vRRYDmqeFx
         QkTSlvyPqmqL5v2RGTmtZIQCphoyH1AMpe/MzjMnZbgbsn7ANvRddsPz5dfpMpeuOG
         6l12lZNR0KLb31OrfsB25kBIZZCHOOCZrMFkKSzf3Sn9GeITMm80WpBC25fbo/MeiH
         Is2QOewf3opADVOZGSDdpl0GZlOCa0klQ0zI98I6Yqddd2IP316tAkQeY8FyfGyUD1
         jRK4ZYBZDSKe9POSmHbsNwVOrkLU/PqrDqdXT/BM+hMIHzatm8aiKxo28ex5ebGkj2
         BmUzcKu/wrcCA==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2b9b904bb04so29495181fa.1;
        Fri, 28 Jul 2023 03:03:37 -0700 (PDT)
X-Gm-Message-State: ABy/qLa+PG976yRFusus4rZkBckoUUNOGEQke7u4ZF94NVHHGgq6Qh24
        LZ4/M/ZXyggUPjkwVZqfgTAwkLeLvUo49kclMVs=
X-Google-Smtp-Source: APBJJlFx+dQYWLD4Q57imF/9JvEvN5dBgTWOloOyttLP1mjqjiHeaGuGhb9mmggYpjQLqdnp9xDE77NZuZ6h+uNdIwc=
X-Received: by 2002:a2e:828f:0:b0:2b7:7c:d5a1 with SMTP id y15-20020a2e828f000000b002b7007cd5a1mr1160535ljg.23.1690538615123;
 Fri, 28 Jul 2023 03:03:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230718125847.3869700-1-ardb@kernel.org> <ZMOQiPadP2jggZ2i@gondor.apana.org.au>
 <CAMj1kXFRAhoyRD8mGe4xKZ-xGord2vwPXHCM7O8DPOpYWcgnJw@mail.gmail.com> <ZMORcmIA/urS8OI4@gondor.apana.org.au>
In-Reply-To: <ZMORcmIA/urS8OI4@gondor.apana.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Fri, 28 Jul 2023 12:03:23 +0200
X-Gmail-Original-Message-ID: <CAMj1kXFnr64b7SA1zYvSOrXazdH_O5G=i4re=taQa9hAeRbh-w@mail.gmail.com>
Message-ID: <CAMj1kXFnr64b7SA1zYvSOrXazdH_O5G=i4re=taQa9hAeRbh-w@mail.gmail.com>
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

On Fri, 28 Jul 2023 at 11:59, Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> On Fri, Jul 28, 2023 at 11:57:42AM +0200, Ard Biesheuvel wrote:
> >
> > So will IPcomp be able to simply assign those pages to the SKB afterwards?
>
> Yes that is the idea.  The network stack is very much in love with
> SG lists :)
>

Fair enough. But my point remains: this requires a lot of boilerplate
on the part of the driver, and it would be better if we could do this
in the acomp generic layer.

Does the IPcomp case always know the decompressed size upfront?
