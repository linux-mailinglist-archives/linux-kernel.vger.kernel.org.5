Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B823790B85
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 13:02:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236512AbjICLCL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 07:02:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235800AbjICLCK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 07:02:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB38DC;
        Sun,  3 Sep 2023 04:02:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 85A7D60A54;
        Sun,  3 Sep 2023 11:02:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A047DC433C7;
        Sun,  3 Sep 2023 11:02:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693738926;
        bh=S0xOyqOW//KyuuxLGzY9rxeJnWsmzBOrYw4kkuc4yns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=TsVZuNqtvCvT+k7PI7sIj/IHPX1Z3Lc17OTMFi49hjN8sZLaoi1Hfctx+bbGHpFP3
         ks5z6YpTwT85zAm/fkSVAMN/7y3S5npHMFIK9MeOr6Dr3vdGkkwJ3diCH2EAVwWQzs
         ySloYJ9xN1qpIg5TBiBoxGvQ4AtzrMhOgYYsO31TxYc0pNbtgMbMXrZSuocOOyHPq7
         /0lAHdxK8c3xE28vpD8I2JrMpmASKuE+iN/J6OefuuUP7543pLYA/s1nMNfdRlxfVN
         8CEuRhNGQT1SDTalqyyAxySV7fRXFComyvWiBSOOeC0Oi6S3jGB/jPhYPcxnnXbNRZ
         SkeZ1r1etdr4w==
Date:   Sun, 3 Sep 2023 12:02:31 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Waqar Hameed <waqar.hameed@axis.com>
Cc:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        "Gustavo A . R . Silva" <gustavoars@kernel.org>,
        "Kees Cook" <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        "Wang Weiyang" <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: Re: [PATCH v2] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Message-ID: <20230903120231.04aebf65@jic23-huawei>
In-Reply-To: <pndsf8cse40.fsf@axis.com>
References: <20230810035910.1334706-1-gongruiqi@huaweicloud.com>
        <pndsf8cse40.fsf@axis.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Aug 2023 15:41:18 +0200
Waqar Hameed <waqar.hameed@axis.com> wrote:

> On Thu, Aug 10, 2023 at 11:59 +0800 "GONG, Ruiqi" <gongruiqi@huaweicloud.=
com> wrote:
>=20
> > From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> >
> > When compiling with gcc 13 with -Warray-bounds enabled:
> >
> > In file included from drivers/iio/proximity/irsd200.c:15:
> > In function =E2=80=98iio_push_to_buffers_with_timestamp=E2=80=99,
> >     inlined from =E2=80=98irsd200_trigger_handler=E2=80=99 at drivers/i=
io/proximity/irsd200.c:770:2:
> > ./include/linux/iio/buffer.h:42:46: error: array subscript =E2=80=98int=
64_t {aka long long int}[0]=E2=80=99
> > is partly outside array bounds of =E2=80=98s16[1]=E2=80=99 {aka =E2=80=
=98short int[1]=E2=80=99} [-Werror=3Darray-bounds=3D]
> >    42 |                 ((int64_t *)data)[ts_offset] =3D timestamp;
> >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > drivers/iio/proximity/irsd200.c: In function =E2=80=98irsd200_trigger_h=
andler=E2=80=99:
> > drivers/iio/proximity/irsd200.c:763:13: note: object =E2=80=98buf=E2=80=
=99 of size 2
> >   763 |         s16 buf =3D 0;
> >       |             ^~~
> >
> > The problem seems to be that irsd200_trigger_handler() is taking a s16
> > variable as an int64_t buffer. As Jonathan suggested [1], fix it by
> > extending the buffer to a two-element array of s64.
> >
> > Link: https://github.com/KSPP/linux/issues/331
> > Link: https://lore.kernel.org/lkml/20230809181329.46c00a5d@jic23-huawei=
/ [1]
> > Fixes: 3db3562bc66e ("iio: Add driver for Murata IRS-D200")
> > Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>
> > Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org> =20
>=20
> Reviewed-by: Waqar Hameed <waqar.hameed@axis.com>
> Tested-by: Waqar Hameed <waqar.hameed@axis.com>

Applied to the fixes-togreg branch of iio.git.  However as we are mid
merge window that tree has an odd base and I'll wait to rebase it on rc1 be=
fore
sending a pull request.

Thanks,

Jonathan
