Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F3D37BB828
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 14:54:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjJFMyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 08:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232230AbjJFMye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 08:54:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81658EA
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 05:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1696596824;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XaTEH053q8cUtCye7N5f4d4bRSpHU+o411y77RvZJbg=;
        b=e/a9zZ1FnSprj4eWaHeZc5MsqO573uKP3kdXKHNdOPU8eW4ctGoTNehk57jxAyBmPH8Pon
        kJonGDcBx2v/i/+54DRmzkLWQugTY+VSOYaRvnGveLjXKki7pi+smu9yVhQxVg3I7nofWi
        MkXViG8TjOvBaLnAGUt36Rt/fVK/Cvk=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-svy7qvHINeazBpynCMroGA-1; Fri, 06 Oct 2023 08:53:43 -0400
X-MC-Unique: svy7qvHINeazBpynCMroGA-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-534543af820so1865701a12.2
        for <linux-kernel@vger.kernel.org>; Fri, 06 Oct 2023 05:53:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696596822; x=1697201622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XaTEH053q8cUtCye7N5f4d4bRSpHU+o411y77RvZJbg=;
        b=PS9G7SVDctsGowhzcH8HPq+Lnw18aSrzrfTl0qErtB3oidZb59s/dNL9t82CaoPiVh
         TjpEABng/gnciY5QDzJCu2XMBQJANsLr5Y3uCrAHjX7X+1oqTFpIgzV6trirpYTKoR8D
         4RAumquSU0cNOJ7KATVu5c2hCRo/LYdG22pxQ21rZgtdKY2UWFMqGTd7B8B2Q/xz4TGt
         8KYtnCenVDg1gjJ5TJmx3u2UC+xeJVLPQxABqTwbHuUpGT8WlCicJvFmoFOPtwKZywbT
         kMCTufXeTC4/YE2lYITodeb4TShaoB2rGGewSSrm42YqvBBW0QS0BXdw77W11R0LZHfX
         xoSg==
X-Gm-Message-State: AOJu0YzkFj+z3tpWuFV3LOpe/3TrCwh/yW3Dy2Cmxz3ngl0tRY0P/DRb
        ZPYmNEZoTSinK/eaMIYtZUNp8sadgklfjTmXnrsqAQ4kbtDzuWdTcFNnnZ1XNPDmkpvX3PKPpcE
        PbwRcvkIX4ZQAaKf/SYFWxHmd0C9ce4Md
X-Received: by 2002:a05:6402:43cf:b0:531:3c4e:98bc with SMTP id p15-20020a05640243cf00b005313c4e98bcmr7730851edc.8.1696596821814;
        Fri, 06 Oct 2023 05:53:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEPXIYKOlxJK58qDW09UXDiZQQeSzU+/6bfXRuDRXaUXGlzvo/Az6gCwlXoR0lUFLQLMfCryA==
X-Received: by 2002:a05:6402:43cf:b0:531:3c4e:98bc with SMTP id p15-20020a05640243cf00b005313c4e98bcmr7730838edc.8.1696596821460;
        Fri, 06 Oct 2023 05:53:41 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id w24-20020a50fa98000000b00532bec5f768sm2524786edr.95.2023.10.06.05.53.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Oct 2023 05:53:40 -0700 (PDT)
Message-ID: <35467b21-941f-c829-1ad8-b4e7319dbc04@redhat.com>
Date:   Fri, 6 Oct 2023 14:53:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/1] platform/mellanox: mlxbf-tmfifo: Fix a warning
 message
Content-Language: en-US, nl
To:     Liming Sun <limings@nvidia.com>,
        Vadim Pasternak <vadimp@nvidia.com>,
        David Thompson <davthompson@nvidia.com>,
        Mark Gross <markgross@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
References: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <bb8bc77e6ecc2287fc9110cfa08caa48eb2a0385.1696508228.git.limings@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Liming,

On 10/5/23 14:18, Liming Sun wrote:
> This commit fixes the smatch static checker warning in
> mlxbf_tmfifo_rxtx_word() which complains data not initialized at
> line 634 when IS_VRING_DROP() is TRUE. This is not a real bug since
> line 634 is for Tx while IS_VRING_DROP() is only set for Rx. So there
> is no case that line 634 is executed when IS_VRING_DROP() is TRUE.
> 
> This commit initializes the local data variable to avoid unnecessary
> confusion to those static analyzing tools.
> 
> Signed-off-by: Liming Sun <limings@nvidia.com>
> ---
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index f3696a54a2bd..ccc4b51d3379 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -595,8 +595,8 @@ static void mlxbf_tmfifo_rxtx_word(struct mlxbf_tmfifo_vring *vring,
>  {
>  	struct virtio_device *vdev = vring->vq->vdev;
>  	struct mlxbf_tmfifo *fifo = vring->fifo;
> +	u64 data = 0;
>  	void *addr;
> -	u64 data;
>  
>  	/* Get the buffer address of this desc. */
>  	addr = phys_to_virt(virtio64_to_cpu(vdev, desc->addr));


This will fix the warning but not the issue at hand. As Dan pointed
out in his original bug report, the issue is that after:

78034cbece79 ("platform/mellanox: mlxbf-tmfifo: Drop the Rx packet if no descriptors")

We now have this IS_VRING_DROP() check in the path, which despite
the subject writeq(data, fifo->tx.data);is currently being applied to both rx and tx vring-s
and when this returns true the memcpy from the ring to &data
will not happen, but the code will still do:

writeq(data, fifo->tx.data);

So you may have silenced the warning now, but you will still write
data not coming from the vring to transmit. The only difference
is you are now guaranteed to write all zeroes.

Note another older issue is that if you hit the not enough space
path:

       } else {
                /* Leftover bytes. */
                if (!IS_VRING_DROP(vring)) {
                        if (is_rx)
                                memcpy(addr + vring->cur_len, &data,
                                       len - vring->cur_len);
                        else
                                memcpy(&data, addr + vring->cur_len,
                                       len - vring->cur_len);
                }
                vring->cur_len = len;
        }

Then even if IS_VRING_DROP() returns true you are only initializing some bytes of the 8 bytes data variable and the other bytes will stay at whatever random value they had before and you end up writing this random bytes when doing:

writeq(data, fifo->tx.data);

Regards,

Hans




