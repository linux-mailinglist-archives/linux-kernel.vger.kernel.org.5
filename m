Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03852782ED3
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 18:54:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236824AbjHUQyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 12:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234544AbjHUQyP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 12:54:15 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11C5BEC
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1692636814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xkaZXG8S2KS31Ed6S9yvZesu6cBtPabbNcGsCRxf3U0=;
        b=Lk4P7XcHxNK5HdsXX1WmG5ipCHNjT/9lVz0421s9y48Ok0cNVWjG/1C6gUOhTPX+aDxg8t
        aN/P8TdA1tlxjTTPlNqNfMDwN83Ie8Kz3nZxZSbx9Ok0T9QWs/Gna3Noz9LTV3miUk/DqZ
        +VKG6nTroo+/XZowy48IunORbFkvGKM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-342-Tlzvq_O1NOW3nvCHDJHU2w-1; Mon, 21 Aug 2023 12:53:31 -0400
X-MC-Unique: Tlzvq_O1NOW3nvCHDJHU2w-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-529fc4373bbso1336431a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 09:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692636810; x=1693241610;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xkaZXG8S2KS31Ed6S9yvZesu6cBtPabbNcGsCRxf3U0=;
        b=Ywyh497usF1TOnvoQYjYrYfTUvvKC9k4lx/pSb7IVo7S3bzW47gL2orAXhkV3oavnE
         0NCaYVvx1PMWvOQ6fnYtn1w3romt/zZ1T4RSRxOQpCwE6moa+CTlj0Z0HJyTyvC/jkNy
         zyXH2LhhYuuFrR9SBKX7+Cj1jPxwbbqHCAT0R9i3UqiYuySyJi/weNDgtcmlmdn1Rz4w
         +vZrNVF2Vk5UCCPm7pPBKU+AbasC36wr9E+bvwbmZ99RI6+wGA1Nc/xbRSUJdA2E00VY
         RGKHBPSw6ymXUdc89/GVY0NbtLGXko66KgqqXNaDchPhg8yGFeUW4Q3MsEV4p+MLWdic
         BrLQ==
X-Gm-Message-State: AOJu0Yz+OAf1KI9RlZWwM7V2Sfii7HaBIKUHXnPE5BfiPhQr/cnaDAmr
        BnPC8JJDKeNbtv3FlOEDKbjqXzKi0dn9NvSOkprusciElLvn+3U+3IyixSMzUK8AfdoCMHGrFTw
        ZNhFE85NyvuxHEjIoDJBqNPbE
X-Received: by 2002:a50:ec8c:0:b0:525:4471:6b59 with SMTP id e12-20020a50ec8c000000b0052544716b59mr5682180edr.7.1692636809963;
        Mon, 21 Aug 2023 09:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyTFD8e4P4bXW4x+3w5anGhQd0zaiH3++gCKjrBnoKJKvvGUYzaWuhy4BtsmiJcCRY5IPszw==
X-Received: by 2002:a50:ec8c:0:b0:525:4471:6b59 with SMTP id e12-20020a50ec8c000000b0052544716b59mr5682168edr.7.1692636809712;
        Mon, 21 Aug 2023 09:53:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c32:7800:5bfa:a036:83f0:f9ec? (2001-1c00-0c32-7800-5bfa-a036-83f0-f9ec.cable.dynamic.v6.ziggo.nl. [2001:1c00:c32:7800:5bfa:a036:83f0:f9ec])
        by smtp.gmail.com with ESMTPSA id d19-20020a056402517300b005272523b162sm6151345ede.69.2023.08.21.09.53.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 09:53:29 -0700 (PDT)
Message-ID: <5180ac42-3d5c-a6dc-a6da-9ede451d6a14@redhat.com>
Date:   Mon, 21 Aug 2023 18:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] [v2] platform/mellanox: Fix mlxbf-tmfifo not handling all
 virtio CONSOLE notifictions updated to use set_bit()
Content-Language: en-US, nl
To:     Shih-Yi Chen <shihyic@nvidia.com>, linux-kernel@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        platform-driver-x86@vger.kernel.org
Cc:     Liming Sung <limings@nvidia.com>,
        David Thompson <davthompson@nvidia.com>
References: <20230821150627.26075-1-shihyic@nvidia.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <20230821150627.26075-1-shihyic@nvidia.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/23 17:06, Shih-Yi Chen wrote:
> From: shihyic <shihyic@nvidia.com>
> 
> rshim console does not show all entries of dmesg.
> 
> Fixed by setting MLXBF_TM_TX_LWM_IRQ for every CONSOLE notification.
> 
> Signed-off-by: Shih-Yi Chen <shihyic@nvidia.com>
> Reviewed-by: Liming Sung <limings@nvidia.com>, David Thompson <davthompson@nvidia.com>
> Reviewed-by: David Thompson <davthompson@nvidia.com>

Thank you for your patch, I've applied this patch to my fixes
branch:
https://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git/log/?h=fixes

Note it will show up in my fixes branch once I've pushed my
local branch there, which might take a while.

I will include this patch in my next fixes pull-req to Linus
for the current kernel development cycle.

Regards,

Hans



> ---
> v1->v2:
>  - Per review comment, replaced test_and_set_bit() with set_bit()
> 
>  drivers/platform/mellanox/mlxbf-tmfifo.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/platform/mellanox/mlxbf-tmfifo.c b/drivers/platform/mellanox/mlxbf-tmfifo.c
> index a79318e90a13..b600b77d91ef 100644
> --- a/drivers/platform/mellanox/mlxbf-tmfifo.c
> +++ b/drivers/platform/mellanox/mlxbf-tmfifo.c
> @@ -887,6 +887,7 @@ static bool mlxbf_tmfifo_virtio_notify(struct virtqueue *vq)
>  			tm_vdev = fifo->vdev[VIRTIO_ID_CONSOLE];
>  			mlxbf_tmfifo_console_output(tm_vdev, vring);
>  			spin_unlock_irqrestore(&fifo->spin_lock[0], flags);
> +			set_bit(MLXBF_TM_TX_LWM_IRQ, &fifo->pend_events);
>  		} else if (test_and_set_bit(MLXBF_TM_TX_LWM_IRQ,
>  					    &fifo->pend_events)) {
>  			return true;

