Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF8E7829A3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 14:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbjHUM4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 08:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235102AbjHUM4P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 08:56:15 -0400
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DA2DCD;
        Mon, 21 Aug 2023 05:56:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1692622573;
  x=1724158573;
  h=references:from:to:cc:subject:date:in-reply-to:
   message-id:mime-version:content-transfer-encoding;
  bh=ehYcc0tlmgSj4nIJYZfVf8DxvlpS6F9Csv171D9Ul4E=;
  b=hVAtLYVraOffBNu2N1R6xfybxlS2GSeMr06gShnkWDIoNQ5DOxncklD3
   ICs1wSDas7Lhi1wd/2exWMShfZpT7niI2/TQiuIruBQRFrY5qL0USxQ6U
   M7rhjIeEqSsuySHXJ3LAZmIk8XSzaT6QZDNB/OTh4H9clmZyl4zIt/2f4
   oP98Y9pUWwYy8DFtnASd02+HKxLPSEnzayq96JYKQajV3E5lD25org3ku
   K7kM5Gyk+I362I55by0+S9S333AhIQp7kDKduSXwdYNJIa4E8cOWk//C8
   9kqhTOgJqgI4AKcpRsE0f3ktGDHoRNKDhSza3ckLIcdGCwpKqgZlCwDu5
   Q==;
References: <20230808083719.280777-1-gongruiqi@huaweicloud.com>
 <ZNIijIoh/famqTDl@work> <20230809093729.00000a1d@Huawei.com>
User-agent: a.out
From:   Waqar Hameed <waqar.hameed@axis.com>
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
CC:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Kees Cook <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: Re: [PATCH RFC] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Date:   Mon, 21 Aug 2023 14:52:18 +0200
In-Reply-To: <20230809093729.00000a1d@Huawei.com>
Message-ID: <pndwmxosgey.fsf@axis.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Originating-IP: [10.0.5.60]
X-ClientProxiedBy: se-mail02w.axis.com (10.20.40.8) To se-mail02w.axis.com
 (10.20.40.8)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 09, 2023 at 09:37 +0100 Jonathan Cameron <Jonathan.Cameron@Huaw=
ei.com> wrote:

> On Tue, 8 Aug 2023 05:10:04 -0600
> "Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:
>
>> On Tue, Aug 08, 2023 at 04:37:19PM +0800, GONG, Ruiqi wrote:
>> > From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
>> >=20
>> > When compiling with gcc 13 with -Warray-bounds enabled:
>> >=20
>> > In file included from drivers/iio/proximity/irsd200.c:15:
>> > In function =E2=80=98iio_push_to_buffers_with_timestamp=E2=80=99,
>> >     inlined from =E2=80=98irsd200_trigger_handler=E2=80=99 at drivers/=
iio/proximity/irsd200.c:770:2:
>> > ./include/linux/iio/buffer.h:42:46: error: array subscript =E2=80=98in=
t64_t {aka long long int}[0]=E2=80=99
>> > is partly outside array bounds of =E2=80=98s16[1]=E2=80=99 {aka =E2=80=
=98short int[1]=E2=80=99} [-Werror=3Darray-bounds=3D]
>> >    42 |                 ((int64_t *)data)[ts_offset] =3D timestamp;
>> >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
>> > drivers/iio/proximity/irsd200.c: In function =E2=80=98irsd200_trigger_=
handler=E2=80=99:
>> > drivers/iio/proximity/irsd200.c:763:13: note: object =E2=80=98buf=E2=
=80=99 of size 2
>> >   763 |         s16 buf =3D 0;
>> >       |             ^~~
>> >=20
>> > The problem seems to be that irsd200_trigger_handler() is taking a s16
>> > variable as an int64_t buffer. Fix it by extending the buffer to 64 bi=
ts.=20=20
>>=20
>> Thanks for working on this!
>>=20
>> >=20
>> > Link: https://github.com/KSPP/linux/issues/331
>> > Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>=20=20
>>=20
>> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>
> Good find on the bug, but the fix is wrong even if it squashes the error.

Yeah, this one slipped through!

[...]

>> > RFC: It's a preliminary patch since I'm not familiar with this hardwar=
e.
>> > Further comments/reviews are needed about whether this fix is correct,
>> > or we should use iio_push_to_buffers() instead of the *_with_timestamp=
()
>> > version.
>> >=20
>> >  drivers/iio/proximity/irsd200.c | 4 ++--
>> >  1 file changed, 2 insertions(+), 2 deletions(-)
>> >=20
>> > diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/i=
rsd200.c
>> > index 5bd791b46d98..34c479881bdf 100644
>> > --- a/drivers/iio/proximity/irsd200.c
>> > +++ b/drivers/iio/proximity/irsd200.c
>> > @@ -759,10 +759,10 @@ static irqreturn_t irsd200_trigger_handler(int i=
rq, void *pollf)
>> >  {
>> >  	struct iio_dev *indio_dev =3D ((struct iio_poll_func *)pollf)->indio=
_dev;
>> >  	struct irsd200_data *data =3D iio_priv(indio_dev);
>> > -	s16 buf =3D 0;
>> > +	int64_t buf =3D 0;
>
> s64 as internal kernel type.
> More importantly needs to be at least s64 buf[2]; as the offset
> https://elixir.bootlin.com/linux/latest/source/include/linux/iio/buffer.h=
#L41
> will be 1 due to this filling the timestamp in at first 8 byte aligned lo=
cation
> after the data that is already in the buffer.
>
> With hindsight was a bad decision a long time ago not to force people to =
also
> pass the size into this function so we could detect this at runtime at le=
ast.
> Hard to repair now give very large number of drivers using this and the f=
act
> that it's not always easy to work out that size.  Unfortunately occasiona=
lly
> one of these slips through review :(
>
> I suppose we could, in some cases check if the buffer was at least 16 byt=
es which
> would get us some of the way.

Yes, that would actually be helpful.
