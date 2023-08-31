Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C797278E5E8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 07:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237573AbjHaFnb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 01:43:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbjHaFn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 01:43:28 -0400
Received: from 167-179-156-38.a7b39c.syd.nbn.aussiebb.net (167-179-156-38.a7b39c.syd.nbn.aussiebb.net [167.179.156.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67AD9E8;
        Wed, 30 Aug 2023 22:43:21 -0700 (PDT)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1qbaRo-009Xru-Qp; Thu, 31 Aug 2023 13:42:29 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Thu, 31 Aug 2023 13:42:30 +0800
Date:   Thu, 31 Aug 2023 13:42:30 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Yang Shen <shenyang39@huawei.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>, ardb@kernel.org,
        kees@kernel.org, linux-kernel@vger.kernel.org, enlin.mu@unisoc.com,
        ebiggers@google.com, gpiccoli@igalia.com, willy@infradead.org,
        yunlong.xing@unisoc.com, yuxiaozhang@google.com,
        Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
        qat-linux@intel.com,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Zhou Wang <wangzhou1@hisilicon.com>
Subject: Re: [PATCH 1/4] crypto: hisilicon/zip - Remove driver
Message-ID: <ZPAoRvMYbsoNfnLk@gondor.apana.org.au>
References: <ZO8ULhlJSrJ0Mcsx@gondor.apana.org.au>
 <E1qbI7v-009Bvf-CA@formenos.hmeau.com>
 <8a73f9cb-b1e8-3b54-4b6c-7cfb19244560@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a73f9cb-b1e8-3b54-4b6c-7cfb19244560@huawei.com>
X-Spam-Status: No, score=2.7 required=5.0 tests=BAYES_00,HELO_DYNAMIC_IPADDR2,
        PDS_RDNS_DYNAMIC_FP,RCVD_IN_DNSWL_BLOCKED,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,TVD_RCVD_IP autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:21:52AM +0800, Yang Shen wrote:
> 
> It's a pity to see that there is no user in the kernel of zlib-deflate.
> However, there may still be hidden
> users in the current kernel who may be using the zlib-deflate algorithm.
> Such as zswap, it can use
> user-specified algorithm. So there are still some benefits to be gained from
> zlib hardware.

Perhaps you should try reconstructing the zlib header in your
driver so that it becomes capable of handling "deflate" data as
is rather than adding the non-standard "zlib-deflate" algorithm?

There is no way of getting the checksum without decompressing
the data first but perhaps your hardware could ignore checksum
errors?

> What's more, hisilicon zip driver also does other work besides supporting
> the zlib-deflate:
> 1.Support gzip algorithm.

We don't even have a generic "gzip" implementation so this should
never have gone into the kernel.

> 2.Support a user space cdev hisi-zip which can accelerate user space process
> via uacce subsystem.

Feel free to resubmit this as a new driver but it doesn't belong
in drivers/crypto.

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
