Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C4A47E6650
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Nov 2023 10:10:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234139AbjKIJK2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Nov 2023 04:10:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234071AbjKIJKZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Nov 2023 04:10:25 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A579211B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Nov 2023 01:10:23 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id d2e1a72fcca58-6b89ab5ddb7so662220b3a.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Nov 2023 01:10:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1699521023; x=1700125823; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=trb4MuQ6XLLHp9cbrU7Qhxh5OD3/4hryMzvH31htzlg=;
        b=BfE5xHs8SaXQXG0b9xYL59BZex2/UqiE11tZAi0CgLK7Ydexx4iCva8h+xgM0e9krJ
         ueCIcl+A8AUONksNUSdbecpH2Imox49H8q2vc/lz8fuOabf9zfvmLsERsMN3NSlYmD9u
         xufmGgtvftJXrnScHK2RugsszirDt7DCcdb8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699521023; x=1700125823;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trb4MuQ6XLLHp9cbrU7Qhxh5OD3/4hryMzvH31htzlg=;
        b=Q7ktDbDuOJLP8yCESpcJHd+csC3tiFy0g1DbXnUmqLd7bqtz1XO8eR3G7HrEtXJmA4
         69Ov961VvGhrAKmouXXvU898YxTtAd3Re8UGbIsQIeWael/UWLw9+azpGxrUA2PCTp47
         7GD5Ci/+7lvCBO5tVHQ6GcV9eaJeSQrMN7UwBLzI6RV8S+5pFGgPlYrnv1NO7zxtVOik
         IKtutU0ioqyx/30uXft7wKoInSx+p1O5xjfpFNQFnVfEM8FipoTMURrJxmZEDduep3tQ
         y/iTlQjsFgXflpm3adJWcXwksBOBD+/eETyOesIo/1m3674hH0RTglxZJsOUjm/ip9Ml
         bSZw==
X-Gm-Message-State: AOJu0YzGGd0dWGvocGGMu+bIa4OeU8QXJcMZLS1VkPkPgDWblaAKfpKI
        sgwxFMp2DDODnv3nvxkeSKKBnQ==
X-Google-Smtp-Source: AGHT+IHeH9bwSDaqUzS/5j97Pi2uukXE85TheRG3ama6+WbfBb0l8z3y1v7unvrgCAzIC5YVZM0pcw==
X-Received: by 2002:a05:6a20:7493:b0:15d:e68d:a850 with SMTP id p19-20020a056a20749300b0015de68da850mr4661238pzd.29.1699521022894;
        Thu, 09 Nov 2023 01:10:22 -0800 (PST)
Received: from chromium.org (0.223.81.34.bc.googleusercontent.com. [34.81.223.0])
        by smtp.gmail.com with ESMTPSA id i4-20020a17090332c400b001c9d968563csm3041205plr.79.2023.11.09.01.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Nov 2023 01:10:22 -0800 (PST)
Date:   Thu, 9 Nov 2023 09:10:18 +0000
From:   Tomasz Figa <tfiga@chromium.org>
To:     Benjamin Gaignard <benjamin.gaignard@collabora.com>
Cc:     mchehab@kernel.org, m.szyprowski@samsung.com, ming.qian@nxp.com,
        ezequiel@vanguardiasur.com.ar, p.zabel@pengutronix.de,
        gregkh@linuxfoundation.org, hverkuil-cisco@xs4all.nl,
        nicolas.dufresne@collabora.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        linux-rockchip@lists.infradead.org, linux-staging@lists.linux.dev,
        kernel@collabora.com
Subject: Re: [PATCH v14 53/56] media: core: Free range of buffers
Message-ID: <20231109091018.tzodchqp44tmwq3k@chromium.org>
References: <20231031163104.112469-1-benjamin.gaignard@collabora.com>
 <20231031163104.112469-54-benjamin.gaignard@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231031163104.112469-54-benjamin.gaignard@collabora.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:31:01PM +0100, Benjamin Gaignard wrote:
> Improve __vb2_queue_free() and __vb2_free_mem() to free
> range of buffers and not only the last few buffers.
> Intoduce starting index to be flexible on range and change the loops
> according to this parameters.
> 
> Signed-off-by: Benjamin Gaignard <benjamin.gaignard@collabora.com>
> ---
>  .../media/common/videobuf2/videobuf2-core.c   | 59 +++++++++----------
>  1 file changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/media/common/videobuf2/videobuf2-core.c b/drivers/media/common/videobuf2/videobuf2-core.c
> index 6e88406fcae9..010a8bca0240 100644
> --- a/drivers/media/common/videobuf2/videobuf2-core.c
> +++ b/drivers/media/common/videobuf2/videobuf2-core.c
> @@ -519,15 +519,13 @@ static int __vb2_queue_alloc(struct vb2_queue *q, enum vb2_memory memory,
>  /*
>   * __vb2_free_mem() - release all video buffer memory for a given queue

This comment is kind of outdated. Maybe we should replace it with

	release video buffer memory for a given range of buffers in a given
	queue

?

>   */
> -static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_free_mem(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> +	unsigned int i;
>  	struct vb2_buffer *vb;
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
>  
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < q->max_num_buffers && i < start + count; i++) {

We could make this (and all those numerous simialr iterations) more
efficient by using bitmap helpers (probably wrapped in some vb2 helpers),
e.g. for_each_set_bit_from() (vb2_for_each_buffer_from()?). It can be done
in a follow up patch separately from this series though.

> +		vb = vb2_get_buffer(q, i);
>  		if (!vb)
>  			continue;
>  
> @@ -542,35 +540,35 @@ static void __vb2_free_mem(struct vb2_queue *q, unsigned int buffers)
>  }
>  
>  /*
> - * __vb2_queue_free() - free buffers at the end of the queue - video memory and
> + * __vb2_queue_free() - free count buffers from start index of the queue - video memory and

nit: How about using the @count and @start notation to refer the argument
names? (Can be done with a follow up patch outside of this series later.)

>   * related information, if no buffers are left return the queue to an
>   * uninitialized state. Might be called even if the queue has already been freed.
>   */
> -static void __vb2_queue_free(struct vb2_queue *q, unsigned int buffers)
> +static void __vb2_queue_free(struct vb2_queue *q, unsigned int start, unsigned int count)
>  {
> -	unsigned int buffer;
> -	unsigned int q_num_buffers = vb2_get_num_buffers(q);
> +	unsigned int i;
>  
>  	lockdep_assert_held(&q->mmap_lock);
>  
>  	/* Call driver-provided cleanup function for each buffer, if provided */
> -	for (buffer = q_num_buffers - buffers; buffer < q_num_buffers;
> -	     ++buffer) {
> -		struct vb2_buffer *vb = vb2_get_buffer(q, buffer);
> +	for (i = start; i < q->max_num_buffers && i < start + count; i++) {
> +		struct vb2_buffer *vb = vb2_get_buffer(q, i);
>  
> -		if (vb && vb->planes[0].mem_priv)
> +		if (!vb)
> +			continue;
> +		if (vb->planes[0].mem_priv)

nit: Not sure if we really had to change this, but I'm fine with either.

Best regards,
Tomasz
