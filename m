Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15DC676B9DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Aug 2023 18:46:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjHAQp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Aug 2023 12:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231992AbjHAQpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Aug 2023 12:45:55 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728F5210A;
        Tue,  1 Aug 2023 09:45:53 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RFgr50Z1cz67Mvl;
        Wed,  2 Aug 2023 00:42:13 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Tue, 1 Aug
 2023 17:45:50 +0100
Date:   Tue, 1 Aug 2023 17:45:49 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
CC:     Jonathan Cameron <jic23@kernel.org>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Kees Cook <keescook@chromium.org>, Nuno Sa <nuno.sa@analog.com>
Subject: Re: [PATCH v3 2/4] iio: core: Add opaque_struct_size() helper and
 use it
Message-ID: <20230801174549.000034b4@Huawei.com>
In-Reply-To: <ZMgTCzslTd2REumj@smile.fi.intel.com>
References: <20230724110204.46285-1-andriy.shevchenko@linux.intel.com>
        <20230724110204.46285-3-andriy.shevchenko@linux.intel.com>
        <20230729124618.67e89fff@jic23-huawei>
        <ZMgTCzslTd2REumj@smile.fi.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500005.china.huawei.com (7.191.163.240) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 31 Jul 2023 23:01:15 +0300
Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> On Sat, Jul 29, 2023 at 12:46:18PM +0100, Jonathan Cameron wrote:
> > On Mon, 24 Jul 2023 14:02:02 +0300
> > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:  
> 
> ...
> 
> > > + * Note, when @s is 0, the alignment @a is added to the sizeof(*(@p))
> > > + * and the result, depending on the @a, may be way off the initial size.  
> > 
> > How often is this true?  A quick and dirty grep suggests at least 2 so perhaps
> > worth retaining the old behaviour.  
> 
> You mean that the sizeof(_some_grepped_struct_) is much less than an alignment
> in those uses?

In two case the size of the extra space this is putting on the end of
the opaque structure is 0.  I've not checked how bit the main structure is - maybe
it doesn't make any real difference. Ugly even so!

> 
> > Can we take that into account?  Maybe something like
> > 
> > #define opaque_struct_size(p, a, s) ((s) ? size_add(ALIGN(sizeof(*(p)), (a)), (s)): sizeof(*p))   
> 
> (s) will be evaluated twice, not good. So, not in this form.

Good point...

> 
> > Or do it at the call site below.  
> 
> Looks much better to me.
> 
> ...
> 
> > 	if (sizeof_priv)
> > 		alloc_size = opaque_struct_size(iio_dev_opaque, IIO_DMA_MINALIGN, sizeof_priv);
> > 	else
> > 		alloc_size = sizeof(struct iio_dev_opaque);  
> 
> Right.
> 
> ...
> 
> > > -	indio_dev->priv = (char *)iio_dev_opaque +
> > > -		ALIGN(sizeof(struct iio_dev_opaque), IIO_DMA_MINALIGN);
> > > +	indio_dev->priv = opaque_struct_data(iio_dev_opaque, IIO_DMA_MINALIGN);  
> > 
> > Would have been safer if original code set this to NULL if
> > sizeof_priv == 0  
> 
> Yeah, original code and proposed change has no difference in this sense.
> 
> > A driver doing that should never have used iio_priv() but nicer if it was
> > NULL rather than off the end of the allocation.  
> 
> Agree.
> But looking at the above, I would rather see that in a form of
> 
> 	if (...)
> 		priv = opaque_struct_data(...);
> 	else
> 		priv = NULL;
> 
Agreed - that would be nicer


