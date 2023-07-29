Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94AA768039
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jul 2023 17:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232058AbjG2PAH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jul 2023 11:00:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232047AbjG2PAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jul 2023 11:00:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D93A9B;
        Sat, 29 Jul 2023 08:00:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D02D960C56;
        Sat, 29 Jul 2023 15:00:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B356BC433C8;
        Sat, 29 Jul 2023 14:59:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690642801;
        bh=3emaoMx07vDdIf/Juc/HrzLfQ54toKxAhvzYwXrmIIQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=iTIqHPVbWQnJqxAeK71DUQmzeroktpQ8cog/AlySfZwnUYcKsmmxhqN7GyvACpa5A
         4mVO10/FQAC9v3bGqh1nIFPWNByTNWM1EIOcl0TlTJ9tiwblG3DTOzGRy4K/K1Hk2o
         l59gNYv+nwDFYv0fYOn+jdwkYpxPIlKml6JNjajpFL0bA7HjiJQMSwg25vBM2UhFet
         ihR2Kk9gN1msHXubZi35lgR+SHHFyUHjYScVtXe+RmcSt+EkhC3DjtHzyF45ZpYA2h
         Pg3H6lBy73GEKvljkr5RU5YxYlsywVW0f0q9dOS4ofvCp8SxfR7HXU8NjWFf3E/vxj
         Da0NST4IU/ZXQ==
Date:   Sat, 29 Jul 2023 16:00:06 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Chenyuan Mi <michenyuan@huawei.com>
Cc:     <lars@metafoo.de>, <linux-iio@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2] tools: iio: iio_generic_buffer: Fix some integer
 type and  calculation
Message-ID: <20230729160006.7352f957@jic23-huawei>
In-Reply-To: <20230725092407.62545-1-michenyuan@huawei.com>
References: <20230725092407.62545-1-michenyuan@huawei.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jul 2023 09:24:07 +0000
Chenyuan Mi <michenyuan@huawei.com> wrote:

> In function size_from_channelarray(), the return value 'bytes' is defined
> as int type. However, the calcution of 'bytes' in this function is designed
> to use the unsigned int type. So it is necessary to change 'bytes' type to
> unsigned int to avoid integer overflow.
> 
> The size_from_channelarray() is called in main() function, its return value
> is directly multipled by 'buf_len' and then used as the malloc() parameter.
> The 'buf_len' is completely controllable by user, thus a multiplication
> overflow may occur here. This could allocate an unexpected small area.
> 
> Signed-off-by: Chenyuan Mi <michenyuan@huawei.com>
> ---

Hi

There should be a change log here so we know what is different from v1.

I'm assuming it's mostly fixing up whatever made this not apply in v1.

Applied to the togreg branch of iio.git

Thanks,

Jonathan


>  tools/iio/iio_generic_buffer.c | 17 +++++++++++++----
>  1 file changed, 13 insertions(+), 4 deletions(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index f8deae4e26a1..44bbf80f0cfd 100644
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
> @@ -674,7 +674,16 @@ int main(int argc, char **argv)
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

