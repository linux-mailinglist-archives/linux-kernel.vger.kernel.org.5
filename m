Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A0217E5BB9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 17:50:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231890AbjKHQut (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 11:50:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230021AbjKHQus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 11:50:48 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62E1A1FD7;
        Wed,  8 Nov 2023 08:50:46 -0800 (PST)
Received: from [100.116.125.19] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: andrzej.p)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1F2776607699;
        Wed,  8 Nov 2023 16:50:44 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1699462245;
        bh=+sODeHjd8Zjj0on3iV7YDUdkXMjj8v7Lrv4oakBoV4Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ShKdGXxBZN2kZvFJvNnXk0eN2yafgrTLmYJpjq8w9ja9BC8pum//fy+OgQGWuZjaN
         xxVgdeqTEYotKiIBOh/WSNOJayEVu+qVjAEBApU7NBis4Ypl3SDmK0ZqVnt3VW/cWO
         4GBozKOo+ZAMCcBx59rq4zf+tyNqvOHhxbEgCIPRq8pVLYhzIDKEuB11bnAUaBziU7
         DU3MpzzZDjyAeQu7DiOzTpps2ljRfZVoiV/Tict0SWLJoyIKRwg9QlerX6zZYzD81f
         xBGSB9PKjo7m2UVELovGwQhaxuF5Fl6ybUrtONi1HQPpSupprlJXa1GeX8Zutd7vKH
         RPybPbfDCvjmg==
Message-ID: <7128cc07-5c16-4e6d-b7d0-aa90ec493fd2@collabora.com>
Date:   Wed, 8 Nov 2023 17:50:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v14 07/56] media: videobuf2: Add helper to get queue
 number of buffers
Content-Language: en-US
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        mchehab@kernel.org, tfiga@chromium.org, m.szyprowski@samsung.com,
        ming.qian@nxp.com, ezequiel@vanguardiasur.com.ar,
        p.zabel@pengutronix.de, gregkh@linuxfoundation.org,
        hverkuil-cisco@xs4all.nl, nicolas.dufresne@collabora.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-8-benjamin.gaignard@collabora.com>
From:   Andrzej Pietrasiewicz <andrzej.p@collabora.com>
In-Reply-To: <20231031163104.112469-8-benjamin.gaignard@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

W dniu 31.10.2023 o 17:30, Benjamin Gaignard pisze:
> In the future a side effect of introducing DELETE_BUFS ioctl is
> the create of 'holes' (i.e. unused buffers) in bufs arrays.
> To know which entries of the bufs arrays are used a bitmap will
> be added in struct vb2_queue. That will also mean that the number
> of buffers will be computed given the number of bit set in this bitmap.
> To smoothly allow this evolution all drives must stop using
> directly num_buffers field from struct vb2_queue.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>

Reviewed-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

> ---
>   include/media/videobuf2-core.h | 11 ++++++++++-
>   1 file changed, 10 insertions(+), 1 deletion(-)
> 
> diff --git a/include/media/videobuf2-core.h b/include/media/videobuf2-core.h
> index cd3ff1cd759d..8f9d9e4af5b1 100644
> --- a/include/media/videobuf2-core.h
> +++ b/include/media/videobuf2-core.h
> @@ -1139,6 +1139,15 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>   	return q->fileio;
>   }
>   
> +/**
> + * vb2_get_num_buffers() - get the number of buffer in a queue
> + * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> + */
> +static inline unsigned int vb2_get_num_buffers(struct vb2_queue *q)
> +{
> +	return q->num_buffers;
> +}
> +
>   /**
>    * vb2_is_busy() - return busy status of the queue.
>    * @q:		pointer to &struct vb2_queue with videobuf2 queue.
> @@ -1147,7 +1156,7 @@ static inline bool vb2_fileio_is_active(struct vb2_queue *q)
>    */
>   static inline bool vb2_is_busy(struct vb2_queue *q)
>   {
> -	return (q->num_buffers > 0);
> +	return vb2_get_num_buffers(q) > 0;
>   }
>   
>   /**

