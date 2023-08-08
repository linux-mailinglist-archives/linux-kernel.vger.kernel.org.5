Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6ED9774054
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:02:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233769AbjHHRBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233754AbjHHRBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:01:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 461628690;
        Tue,  8 Aug 2023 09:00:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C2FD624C3;
        Tue,  8 Aug 2023 11:09:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7956BC433C9;
        Tue,  8 Aug 2023 11:09:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691492941;
        bh=t5keYJaEqeaKp0mlDUXsYS276GlhxU47w2DsH4m0WSQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aGfhd3qPUfmNl6GWDoGyXHJhdpsdWij0VZ0SJo3PJM4CLiYU2Eux/iXMmmjm0/xS1
         j3iCUOwr1aqrioS0wSPNIEEzGYgBy5UObE6GB7CHi+PCSTE/AV+OqEj8VLWe8swVMV
         a2Si78opzwY+ceZMGZYHlu3LQOhop8JFQc4Y97dj7LjOsJAHGOzSNyEK0Fm9niPPM2
         /AObOrFinhcL7QulHGNcASebLzL/qGZuWQuqzstnqpi2DhkIkjsupePHs1+K1TFoCJ
         2f5dFA1g9xcZgRUdVbB0qr1WD+3EJKGzTFyVDE6MTt8c7QMTMGkjY4dEMTWTO5mLeb
         pZgL3POCeFHlg==
Date:   Tue, 8 Aug 2023 05:10:04 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     "GONG, Ruiqi" <gongruiqi@huaweicloud.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Waqar Hameed <waqar.hameed@axis.com>,
        Kees Cook <keescook@chromium.org>, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org,
        Wang Weiyang <wangweiyang2@huawei.com>,
        Xiu Jianfeng <xiujianfeng@huawei.com>, gongruiqi1@huawei.com
Subject: Re: [PATCH RFC] iio: irsd200: fix -Warray-bounds bug in
 irsd200_trigger_handler
Message-ID: <ZNIijIoh/famqTDl@work>
References: <20230808083719.280777-1-gongruiqi@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230808083719.280777-1-gongruiqi@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:37:19PM +0800, GONG, Ruiqi wrote:
> From: "GONG, Ruiqi" <gongruiqi1@huawei.com>
> 
> When compiling with gcc 13 with -Warray-bounds enabled:
> 
> In file included from drivers/iio/proximity/irsd200.c:15:
> In function ‘iio_push_to_buffers_with_timestamp’,
>     inlined from ‘irsd200_trigger_handler’ at drivers/iio/proximity/irsd200.c:770:2:
> ./include/linux/iio/buffer.h:42:46: error: array subscript ‘int64_t {aka long long int}[0]’
> is partly outside array bounds of ‘s16[1]’ {aka ‘short int[1]’} [-Werror=array-bounds=]
>    42 |                 ((int64_t *)data)[ts_offset] = timestamp;
>       |                 ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~
> drivers/iio/proximity/irsd200.c: In function ‘irsd200_trigger_handler’:
> drivers/iio/proximity/irsd200.c:763:13: note: object ‘buf’ of size 2
>   763 |         s16 buf = 0;
>       |             ^~~
> 
> The problem seems to be that irsd200_trigger_handler() is taking a s16
> variable as an int64_t buffer. Fix it by extending the buffer to 64 bits.

Thanks for working on this!

> 
> Link: https://github.com/KSPP/linux/issues/331
> Signed-off-by: GONG, Ruiqi <gongruiqi1@huawei.com>

Acked-by: Gustavo A. R. Silva <gustavoars@kernel.org>

--
Gustavo

> ---
> 
> RFC: It's a preliminary patch since I'm not familiar with this hardware.
> Further comments/reviews are needed about whether this fix is correct,
> or we should use iio_push_to_buffers() instead of the *_with_timestamp()
> version.
> 
>  drivers/iio/proximity/irsd200.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iio/proximity/irsd200.c b/drivers/iio/proximity/irsd200.c
> index 5bd791b46d98..34c479881bdf 100644
> --- a/drivers/iio/proximity/irsd200.c
> +++ b/drivers/iio/proximity/irsd200.c
> @@ -759,10 +759,10 @@ static irqreturn_t irsd200_trigger_handler(int irq, void *pollf)
>  {
>  	struct iio_dev *indio_dev = ((struct iio_poll_func *)pollf)->indio_dev;
>  	struct irsd200_data *data = iio_priv(indio_dev);
> -	s16 buf = 0;
> +	int64_t buf = 0;
>  	int ret;
>  
> -	ret = irsd200_read_data(data, &buf);
> +	ret = irsd200_read_data(data, (s16 *)&buf);
>  	if (ret)
>  		goto end;
>  
> -- 
> 2.41.0
> 
