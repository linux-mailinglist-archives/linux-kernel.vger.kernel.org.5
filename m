Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 008B277662F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232733AbjHIRNg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 13:13:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjHIRNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 13:13:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DE0B1FEF;
        Wed,  9 Aug 2023 10:13:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2240064251;
        Wed,  9 Aug 2023 17:13:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DE84C433C8;
        Wed,  9 Aug 2023 17:13:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691601213;
        bh=+nrTL02ww3JydtaHvbtFC7KdfKrvmXtVFH1FyyLEWGI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Zd/elhXcp3KzONVWRbLdRxXwf0AzdFl4P4uRYuUP2GLi9CQPwSnkJd+Rck7ckBBOW
         lJqbtLux3KucpqY3wja4V0FhuVYejoOAx5CipbNNvUZ32EqSN673D5orMbOqesjKCC
         V/KnOEdy+HFSXgxeQ7kL+0tPgotD5GmmbFQXdYLvJPXjN9brbtSX6Bk46ilI22gM5M
         tEwrDrFVbfh6Dk8DaFTD3aMZBTCWDsChNgLQWsR8Oyw4FTfC/JJoVWKPMyyuc+YceI
         5LMtp7W1rC/YtD5xAS4MtMyaH8lBDmxpuh1ifZRUZu+a6a2YQiWRG7+uIBYGkxN4VU
         XdNzQ95zEcVpw==
Date:   Wed, 9 Aug 2023 18:13:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>,
        Kees Cook <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: Re: [PATCH RFC] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Message-ID: <20230809181329.46c00a5d@jic23-huawei>
In-Reply-To: <20230809093729.00000a1d@Huawei.com>
References: <20230808083719.280777-1-gongruiqi@huaweicloud.com>
        <ZNIijIoh/famqTDl@work>
        <20230809093729.00000a1d@Huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 9 Aug 2023 09:37:29 +0100
Jonathan Cameron <Jonathan.Cameron@Huawei.com> wrote:

> On Tue, 8 Aug 2023 05:10:04 -0600
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
>=20
> > On Tue, Aug 08, 2023 at 04:37:19PM +0800, GONG, Ruiqi wrote: =20
> > > From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> > >=20
> > > When compiling with gcc 13 with -Warray-bounds enabled:
> > >=20
> > > In file included from drivers/iio/proximity/irsd200.c:15:
> > > In function =E2=80=98iio_push_to_buffers_with_timestamp=E2=80=99,
> > >     inlined from =E2=80=98irsd200_trigger_handler=E2=80=99 at drivers=
/iio/proximity/irsd200.c:770:2:
> > > ./include/linux/iio/buffer.h:42:46: error: array subscript =E2=80=98i=
nt64_t {aka long long int}[0]=E2=80=99
> > > is partly outside array bounds of =E2=80=98s16[1]=E2=80=99 {aka =E2=
=80=98short int[1]=E2=80=99} [-Werror=3Darray-bounds=3D]
> > >    42 |                 ((int64_t *)data)[ts_offset] =3D timestamp;
> > >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > > drivers/iio/proximity/irsd200.c: In function =E2=80=98irsd200_trigger=
_handler=E2=80=99:
> > > drivers/iio/proximity/irsd200.c:763:13: note: object =E2=80=98buf=E2=
=80=99 of size 2
> > >   763 |         s16 buf =3D 0;
> > >       |             ^~~
> > >=20
> > > The problem seems to be that irsd200_trigger_handler() is taking a s16
> > > variable as an int64_t buffer. Fix it by extending the buffer to 64 b=
its.   =20
> >=20
> > Thanks for working on this!
> >  =20
> > >=20
> > > Link: https://github.com/KSPP/linux/issues/331
> > > Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>   =20
> >=20
> > Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org> =20
>=20
> Good find on the bug, but the fix is wrong even if it squashes the error.
>=20
> >=20
> > --
> > Gustavo
> >  =20
> > > ---
> > >=20
> > > RFC: It's a preliminary patch since I'm not familiar with this hardwa=
re.
> > > Further comments/reviews are needed about whether this fix is correct,
> > > or we should use iio_push_to_buffers() instead of the *_with_timestam=
p()
> > > version.
> > >=20
> > >  drivers/iio/proximity/irsd200.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/=
irsd200.c
> > > index 5bd791b46d98..34c479881bdf 100644
> > > --- a/drivers/iio/proximity/irsd200.c
> > > +++ b/drivers/iio/proximity/irsd200.c
> > > @@ -759,10 +759,10 @@ static irqreturn_t irsd200_trigger_handler(int =
irq, void *pollf)
> > >  {
> > >  	struct iio_dev *indio_dev =3D ((struct iio_poll_func *)pollf)->indi=
o_dev;
> > >  	struct irsd200_data *data =3D iio_priv(indio_dev);
> > > -	s16 buf =3D 0;
> > > +	int64_t buf =3D 0; =20
>=20
> s64 as internal kernel type.
> More importantly needs to be at least s64 buf[2]; as the offset
> https://elixir.bootlin.com/linux/latest/source/include/linux/iio/buffer.h=
#L41
> will be 1 due to this filling the timestamp in at first 8 byte aligned lo=
cation
> after the data that is already in the buffer.
>=20
> With hindsight was a bad decision a long time ago not to force people to =
also
> pass the size into this function so we could detect this at runtime at le=
ast.
> Hard to repair now give very large number of drivers using this and the f=
act
> that it's not always easy to work out that size.  Unfortunately occasiona=
lly
> one of these slips through review :(
>=20
> I suppose we could, in some cases check if the buffer was at least 16 byt=
es which
> would get us some of the way.
>=20
I was going to pick the patch up and modify it, but I think you managed
to send it out as an html email so it didn't reach the mailing list archive=
s.
If you could send a v2 with s64 buf[2]; that would be great.
Due to some travel I need to send a pull request shortly but this won't be =
in
a release for some time (as pull is targetting 6.6) so not a problem as long
as we make sure to address in soon.

Thanks,

Jonathan

> Jonathan
>=20
> > >  	int ret;
> > > =20
> > > -	ret =3D irsd200_read_data(data, &buf);
> > > +	ret =3D irsd200_read_data(data, (s16 *)&buf);
> > >  	if (ret)
> > >  		goto end;
> > > =20
> > > --=20
> > > 2.41.0
> > >    =20
>=20

