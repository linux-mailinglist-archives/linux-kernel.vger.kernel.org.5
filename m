Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8AE977558D
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 10:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbjHIIhi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Aug 2023 04:37:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjHIIhe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 04:37:34 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC62C170B;
        Wed,  9 Aug 2023 01:37:33 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RLNct5KHJz6J7mD;
        Wed,  9 Aug 2023 16:33:50 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Wed, 9 Aug
 2023 09:37:30 +0100
Date:   Wed, 9 Aug 2023 09:37:29 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>,
        Kees Cook <keescook@chromium.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-hardening@vger.kernel.org>,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, <gongruiqi1@huawei.com>
Subject: Re: [PATCH RFC] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Message-ID: <20230809093729.00000a1d@Huawei.com>
In-Reply-To: <ZNIijIoh/famqTDl@work>
References: <20230808083719.280777-1-gongruiqi@huaweicloud.com>
        <ZNIijIoh/famqTDl@work>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Aug 2023 05:10:04 -0600
"Gustavo A. R. Silva" <gustavoars@kernel.org> wrote:

> On Tue, Aug 08, 2023 at 04:37:19PM +0800, GONG, Ruiqi wrote:
> > From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> > 
> > When compiling with gcc 13 with -Warray-bounds enabled:
> > 
> > In file included from drivers/iio/proximity/irsd200.c:15:
> > In function ‘iio_push_to_buffers_with_timestamp’,
> >     inlined from ‘irsd200_trigger_handler’ at drivers/iio/proximity/irsd200.c:770:2:
> > ./include/linux/iio/buffer.h:42:46: error: array subscript ‘int64_t {aka long long int}[0]’
> > is partly outside array bounds of ‘s16[1]’ {aka ‘short int[1]’} [-Werror=array-bounds=]
> >    42 |                 ((int64_t *)data)[ts_offset] = timestamp;
> >       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> > drivers/iio/proximity/irsd200.c: In function ‘irsd200_trigger_handler’:
> > drivers/iio/proximity/irsd200.c:763:13: note: object ‘buf’ of size 2
> >   763 |         s16 buf = 0;
> >       |             ^~~
> > 
> > The problem seems to be that irsd200_trigger_handler() is taking a s16
> > variable as an int64_t buffer. Fix it by extending the buffer to 64 bits.  
> 
> Thanks for working on this!
> 
> > 
> > Link: https://github.com/KSPP/linux/issues/331
> > Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>  
> 
> Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Good find on the bug, but the fix is wrong even if it squashes the error.

> 
> --
> Gustavo
> 
> > ---
> > 
> > RFC: It's a preliminary patch since I'm not familiar with this hardware.
> > Further comments/reviews are needed about whether this fix is correct,
> > or we should use iio_push_to_buffers() instead of the *_with_timestamp()
> > version.
> > 
> >  drivers/iio/proximity/irsd200.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> > index 5bd791b46d98..34c479881bdf 100644
> > --- a/drivers/iio/proximity/irsd200.c
> > +++ b/drivers/iio/proximity/irsd200.c
> > @@ -759,10 +759,10 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
> >  {
> >  	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
> >  	struct irsd200_data *data = iio_priv(indio_dev);
> > -	s16 buf = 0;
> > +	int64_t buf = 0;

s64 as internal kernel type.
More importantly needs to be at least s64 buf[2]; as the offset
https://elixir.bootlin.com/linux/latest/source/include/linux/iio/buffer.h#L41
will be 1 due to this filling the timestamp in at first 8 byte aligned location
after the data that is already in the buffer.

With hindsight was a bad decision a long time ago not to force people to also
pass the size into this function so we could detect this at runtime at least.
Hard to repair now give very large number of drivers using this and the fact
that it's not always easy to work out that size.  Unfortunately occasionally
one of these slips through review :(

I suppose we could, in some cases check if the buffer was at least 16 bytes which
would get us some of the way.

Jonathan

> >  	int ret;
> >  
> > -	ret = irsd200_read_data(data, &buf);
> > +	ret = irsd200_read_data(data, (s16 *)&buf);
> >  	if (ret)
> >  		goto end;
> >  
> > -- 
> > 2.41.0
> >   

