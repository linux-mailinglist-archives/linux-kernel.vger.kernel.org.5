Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6464B75DD82
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 18:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGVQuU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 12:50:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjGVQuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 12:50:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60957A0;
        Sat, 22 Jul 2023 09:50:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E97F960B06;
        Sat, 22 Jul 2023 16:50:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFC23C433C7;
        Sat, 22 Jul 2023 16:50:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690044616;
        bh=9XeEJvlgen8BcyqBv9I/W6Fq2iW/Yz6k/D4YZTouxus=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=jUAEq07Klk95vWO9FT5slhqsTh47S6Pom4vQcWI9MDXX9edeZlAaXCISBdfFraCkc
         7pE8bA1zxsO3ggyKp3HVErjgMmR/g/X/4kbioVxIUwHHTJ4GB/PLcGDfVIK8EUL5Xu
         RnsjY84EEVLpmkBoPyopa8oo1DcAsJ9xi7Ru3MfkJrW4IFmaGh5Dwmq80WM1/gDjS1
         17RfDriN65MFFsUzSA99R8xDtf2mW2e9enTx/ROatl/cwEbBgHIXhWqmeLlxainqaa
         Uq21RisUDgzqVCiFfGR6kmNOoUKnw0JCY8Vde2J7wvW11l8UW0nTx6nEnPqc7LLHXo
         Vq/uW5iU4MoSQ==
Date:   Sat, 22 Jul 2023 17:50:10 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chenyuan Mi <michenyuan@huawei.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] tools: iio: iio_generic_buffer: Fix some integer type
 and calculation
Message-ID: <20230722175010.2e10bc6c@jic23-huawei>
In-Reply-To: <20230718081542.2892453-1-michenyuan@huawei.com>
References: <20230718081542.2892453-1-michenyuan@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Jul 2023 08:15:42 +0000
Chenyuan Mi <michenyuan@huawei.com> wrote:

Hi,

In principle I support hardening code, though in this case we are talking
about example code only.  We have libiio and similar for anyone who wants
to do more than basic tests.

> In function size_from_channelarray(), the return value 'bytes' is defined
> as int type. However, the calcution of 'bytes' in this function is designed
> to use the unsigned int type. So it is necessary to change 'bytes' type to
> unsigned int to avoid integer overflow.

For this one, in practice it's controlled entirely by the kernel drivers
and they won't get anywhere near integer overflow.  The change is
small however and doesn't hurt readability so I guess no harm applying it.

> 
> The size_from_channelarray() is called in main() function, its return value
> is directly multipled by 'buf_len' and then used as the malloc() parameter.
> The 'buf_len' is completely controllable by user, thus a multiplication
> overflow may occur here. This could allocate an unexpected small area.

That would have to be a very large allocation...  I suppose it is possible
someone might try it...

> 
> Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>

My first inclination is not to apply this on basis that it adds slight complexity
to example code (the aim of which is too illustrate the interface), however on the other
side of things the checks don't add significant complexity...

So I tried to apply it, but it doesn't go on cleanly and patch is telling
me it's malformed. I'm not quite sure why.

patching file tools/iio/iio_generic_buffer.c
patch: **** malformed patch at line 68:                 ret = -ENOMEM;

Jonathan





> ---
>  tools/iio/iio_generic_buffer.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index f8deae4e26a1..dc7d19c179ca 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -51,9 +51,9 @@ enum autochan {
>   * Has the side effect of filling the channels[i].location values used
>   * in processing the buffer output.
>   **/
> -static int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
> +static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>  {
> -	int bytes = 0;
> +	unsigned int bytes = 0;
>  	int i = 0;
>  
>  	while (i < num_channels) {
> @@ -348,7 +348,7 @@ int main(int argc, char **argv)
>  	ssize_t read_size;
>  	int dev_num = -1, trig_num = -1;
>  	char *buffer_access = NULL;
> -	int scan_size;
> +	unsigned int scan_size;
>  	int noevents = 0;
>  	int notrigger = 0;
>  	char *dummy;
> @@ -674,7 +674,14 @@ int main(int argc, char **argv)
>  	}
>  
>  	scan_size = size_from_channelarray(channels, num_channels);
> -	data = malloc(scan_size * buf_len);
> +
> +	size_t total_buf_len = scan_size * buf_len;
> +
> +	if (scan_size > 0 && total_buf_len / scan_size != buf_len) {
> +		ret = -EFAULT;
> +		perror("Integer overflow happened when calculate scan_size * buf_len");
> +		goto error;
> +	}
> +
> +	data = malloc(total_buf_len);
>  	if (!data) {
>  		ret = -ENOMEM;
>  		goto error;

