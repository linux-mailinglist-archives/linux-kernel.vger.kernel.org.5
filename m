Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9957A771657
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Aug 2023 19:52:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjHFRv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Aug 2023 13:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjHFRv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Aug 2023 13:51:56 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06A21716
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 10:51:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7E07A61219
        for <linux-kernel@vger.kernel.org>; Sun,  6 Aug 2023 17:51:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D885C433C7;
        Sun,  6 Aug 2023 17:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691344314;
        bh=4rdC/0XPtMhN2Rc3UGtRnjsYqUgeJ+3qi4+YUkmR/8c=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pH17gJbHuiDo2Hdaj8aXlj8RkX9wjF1rqD2ZuoxG+43y53tXIBB6rEL/KENqW/5zQ
         ERV7LJeoeOXr5VSL3J7kqJzxmqz80gcwo2aApkyGqjHzMevZuBG2uHS6BZwNezYPBy
         eYDoVOR4a+RjLAoB5wQUEX9aKz4gMA9t87F/kWjfn///XD6JK0Z1ilfks+Y/Kt1aAI
         3479fIk677cmCCONTQk2MjdZuTWkYA8Qzzyl9i1nkS8RztPT4mzFAM6BqXfNZCqCUT
         kPJGqy3Vu5iX637Q+29v1AWtIvagivrToZesykAqt90L6AeEhQY/hcZpcScBIp/1yC
         lBa3BETVHA3WQ==
Message-ID: <711f42de-34d8-c27a-e058-5fa460012a69@kernel.org>
Date:   Sun, 6 Aug 2023 12:51:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drivers: firmware: stratix10-rsu: Fix max_retry counter
 value
Content-Language: en-US
To:     kah.jing.lee@intel.com
Cc:     linux-kernel@vger.kernel.org, tien.sung.ang@intel.com
References: <88b79f4cfe1c28e31b902d2f12b81e431b09e125.1691112823.git.kah.jing.lee@intel.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <88b79f4cfe1c28e31b902d2f12b81e431b09e125.1691112823.git.kah.jing.lee@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-11.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/3/23 20:35, kah.jing.lee@intel.com wrote:
> From: Kah Jing Lee <kah.jing.lee@intel.com>
> 
> Fix the max_retry value because the value is truncated at scnprintf format
> specifier, with added hex symbol and newline.
> 
> Signed-off-by: Kah Jing Lee <kah.jing.lee@intel.com>
> ---
>   drivers/firmware/stratix10-rsu.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/firmware/stratix10-rsu.c b/drivers/firmware/stratix10-rsu.c
> index e51c95f8d445..98ec39f6dae8 100644
> --- a/drivers/firmware/stratix10-rsu.c
> +++ b/drivers/firmware/stratix10-rsu.c
> @@ -405,8 +405,7 @@ static ssize_t max_retry_show(struct device *dev,
>   	if (!priv)
>   		return -ENODEV;
>   
> -	return scnprintf(buf, sizeof(priv->max_retry),
> -			 "0x%08x\n", priv->max_retry);
> +	return scnprintf(buf, PAGE_SIZE, "0x%08x\n", priv->max_retry);
>   }
>   

This would be a good time to switch over to use sysfs_emit()

Dinh
