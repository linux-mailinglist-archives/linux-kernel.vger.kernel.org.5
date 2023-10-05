Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E21B7BA3EC
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 18:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235276AbjJEQAV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 12:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237198AbjJEP5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:57:36 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C9F95FEB;
        Thu,  5 Oct 2023 08:17:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB54C433C7;
        Thu,  5 Oct 2023 15:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696519033;
        bh=CaTNBuS9Fb+l4tmi5Xy/KGFrITEbvOikbxtS6uzbucQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=RmrQmJWsiOI0JOKuWZWH5xdVVFwz84p4aSCWCLx4AbpCab9LDFs+I7CKPX4pWDy71
         y8S1ua7EdGnzFqblYc7vfLslKvpbicVKf9a9jx2Gi7UZH1Brwsin7U39NGSrlz2bjg
         2CpMIAyxKbfSrs2ySjKKLzB6X7JCNECwTURpmEjjIEt8h/QU+wU5uOjfSGReSFWqMy
         VSBZ9Ecczyox3r88Si/HGCH96nlwsN2/7kREX5rHFrLqIfEICs2WqnnKXxMHFBcjTA
         YByJwxMeeQy08EwPtvKSZhIocbYJx1EeCn1a7QrifspH0K1HkhDFgm8dKDOwnz2qhM
         4Py4qq+UtZvlg==
Date:   Thu, 5 Oct 2023 16:17:18 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6] tools: iio: iio_generic_buffer ensure alignment
Message-ID: <20231005161718.612fab8c@jic23-huawei>
In-Reply-To: <ZRvlm4ktNLu+qmlf@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
References: <ZRvlm4ktNLu+qmlf@dc78bmyyyyyyyyyyyyydt-3.rev.dnainternet.fi>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Oct 2023 12:57:47 +0300
Matti Vaittinen <mazziesaccount@gmail.com> wrote:

> The iio_generic_buffer can return garbage values when the total size of
> scan data is not a multiple of the largest element in the scan. This can be
> demonstrated by reading a scan, consisting, for example of one 4-byte and
> one 2-byte element, where the 4-byte element is first in the buffer.
> 
> The IIO generic buffer code does not take into account the last two
> padding bytes that are needed to ensure that the 4-byte data for next
> scan is correctly aligned.
> 
> Add the padding bytes required to align the next sample with the scan size.
> 
> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
> Fixes: e58537ccce73 ("staging: iio: update example application.")

Applied to the togreg branch of iio.git and pushed out as testing for
all the normal reasons.

Thanks,

Jonathan
> 
> ---
> Revision history
> v5 => v6:
>  - fix typo pointed by Andy (wan't => want).
> v4 => v5:
>  - drop unnecessary comment.
>  - drop all other patches as those were already applied.
>  - add Fixes-tag.
> v3 => v4:
>  - drop extra print and TODO coment
>  - add comment clarifying alignment sizes
> ---
>  tools/iio/iio_generic_buffer.c | 13 ++++++++++++-
>  1 file changed, 12 insertions(+), 1 deletion(-)
> 
> diff --git a/tools/iio/iio_generic_buffer.c b/tools/iio/iio_generic_buffer.c
> index 44bbf80f0cfd..0d0a7a19d6f9 100644
> --- a/tools/iio/iio_generic_buffer.c
> +++ b/tools/iio/iio_generic_buffer.c
> @@ -54,9 +54,12 @@ enum autochan {
>  static unsigned int size_from_channelarray(struct iio_channel_info *channels, int num_channels)
>  {
>  	unsigned int bytes = 0;
> -	int i = 0;
> +	int i = 0, max = 0;
> +	unsigned int misalignment;
>  
>  	while (i < num_channels) {
> +		if (channels[i].bytes > max)
> +			max = channels[i].bytes;
>  		if (bytes % channels[i].bytes == 0)
>  			channels[i].location = bytes;
>  		else
> @@ -66,6 +69,14 @@ static unsigned int size_from_channelarray(struct iio_channel_info *channels, in
>  		bytes = channels[i].location + channels[i].bytes;
>  		i++;
>  	}
> +	/*
> +	 * We want the data in next sample to also be properly aligned so
> +	 * we'll add padding at the end if needed. Adding padding only
> +	 * works for channel data which size is 2^n bytes.
> +	 */
> +	misalignment = bytes % max;
> +	if (misalignment)
> +		bytes += max - misalignment;
>  
>  	return bytes;
>  }
> 
> base-commit: 0bb80ecc33a8fb5a682236443c1e740d5c917d1d

