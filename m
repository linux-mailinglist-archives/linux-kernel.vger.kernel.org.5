Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ECD28007C5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 10:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378298AbjLAJ5i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 04:57:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378169AbjLAJ5a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 04:57:30 -0500
Received: from abb.hmeau.com (abb.hmeau.com [144.6.53.87])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24264B2;
        Fri,  1 Dec 2023 01:57:02 -0800 (PST)
Received: from loth.rohan.me.apana.org.au ([192.168.167.2])
        by formenos.hmeau.com with smtp (Exim 4.94.2 #2 (Debian))
        id 1r90GQ-005hRv-ME; Fri, 01 Dec 2023 17:56:51 +0800
Received: by loth.rohan.me.apana.org.au (sSMTP sendmail emulation); Fri, 01 Dec 2023 17:56:59 +0800
Date:   Fri, 1 Dec 2023 17:56:59 +0800
From:   Herbert Xu <herbert@gondor.apana.org.au>
To:     Edward Adam Davis <eadavis@qq.com>
Cc:     syzbot+c52ab18308964d248092@syzkaller.appspotmail.com,
        davem@davemloft.net, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, olivia@selenic.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [PATCH] hwrng: core - fix task hung in hwrng_fillfn
Message-ID: <ZWmt6wrbxN1W+cnv@gondor.apana.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <tencent_97BC6EC36EF24C91A7E7C6DFD2C106688906@qq.com>
X-Newsgroups: apana.lists.os.linux.cryptoapi,apana.lists.os.linux.kernel
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Adam Davis <eadavis@qq.com> wrote:
>
> diff --git a/drivers/char/hw_random/core.c b/drivers/char/hw_random/core.c
> index 420f155d251f..7323ddc958ce 100644
> --- a/drivers/char/hw_random/core.c
> +++ b/drivers/char/hw_random/core.c
> @@ -225,17 +225,18 @@ static ssize_t rng_dev_read(struct file *filp, char __user *buf,
>                        goto out;
>                }
> 
> -               if (mutex_lock_interruptible(&reading_mutex)) {
> -                       err = -ERESTARTSYS;
> -                       goto out_put;
> -               }
>                if (!data_avail) {
> +                       if (mutex_lock_interruptible(&reading_mutex)) {
> +                               err = -ERESTARTSYS;
> +                               goto out_put;
> +                       }
>                        bytes_read = rng_get_data(rng, rng_buffer,
>                                rng_buffer_size(),
>                                !(filp->f_flags & O_NONBLOCK));
> +                       mutex_unlock(&reading_mutex);
>                        if (bytes_read < 0) {
>                                err = bytes_read;
> -                               goto out_unlock_reading;
> +                               goto out_put;
>                        }
>                        data_avail = bytes_read;
>                }

Does this change anything at all? Please explain why it was holding
this lock for 143 seconds in the first place.  If it's doing it in
rng_get_data, then your change has zero effect.

> @@ -501,7 +499,10 @@ static int hwrng_fillfn(void *unused)
>                rng = get_current_rng();
>                if (IS_ERR(rng) || !rng)
>                        break;
> -               mutex_lock(&reading_mutex);
> +               if (mutex_lock_interruptible(&reading_mutex)) {
> +                       put_rng(rng);
> +                       return -ERESTARTSYS;
> +               }

No this is just the symptom.  The real problem is why is the driver
spending 143 seconds in rng_get_data?

Cheers,
-- 
Email: Herbert Xu <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt
