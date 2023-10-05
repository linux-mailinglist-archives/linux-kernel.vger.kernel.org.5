Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 357687BA240
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 17:23:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233344AbjJEPXy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Oct 2023 11:23:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233375AbjJEPXQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 11:23:16 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C8F3DD
        for <linux-kernel@vger.kernel.org>; Thu,  5 Oct 2023 07:33:37 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 01B862C80;
        Thu,  5 Oct 2023 09:23:56 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 01B862C80
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1696490636; bh=5tUjAAffC21PeqN5RCHFtO+dCZ7ZbDslD8JvlTNPOHk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=RMC/XdI+giZhjrbO60WuxY5G65Nvhs8t+MbQCl/unIEbm48UuP4o9PE3o+/LjD5ZY
         d7RwtIL/oz1qE8tFe9EeW9swhH4BRxUozQ45FjA9lZZrA5DIK878YGn9dSECse2xZo
         POvFdJkqYUojdZO8pOdxvrQmBLybjEfowmTkZWMc=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Thu,  5 Oct 2023 09:23:51 +0200 (CEST)
Message-ID: <b9b2ea05-9d10-d263-f08a-5e3cf1f33a9d@perex.cz>
Date:   Thu, 5 Oct 2023 09:23:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] ALSA: aloop: Add support for the non-interleaved
 access mode
Content-Language: en-US
To:     Ivan Orlov <ivan.orlov0322@gmail.com>, tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
References: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
From:   Jaroslav Kysela <perex@perex.cz>
In-Reply-To: <20230927113555.14877-1-ivan.orlov0322@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 09. 23 13:35, Ivan Orlov wrote:
> The current version of the loopback driver supports interleaved access
> mode only. This patch introduces support for the non-interleaved
> access mode.
> 
> When in the interleaved mode, the 'copy_play_buf' function copies data
> from the playback to the capture buffer using one memcpy call. This call
> copies samples for multiple, interleaved channels.
> 
> In the non-interleaved mode we have multiple channel buffers, so we have
> to perform multiple memcpy calls to copy samples channel after channel.
> 
> Add new function called 'copy_play_buf_part_n', which copies a part of
> each channel buffer from playback to capture. Modify the 'copy_play_buf'
> to use the corresponding memory copy function(just memcpy /
> copy_play_buf_part_n) depending on the access mode.
> 
> Signed-off-by: Ivan Orlov <ivan.orlov0322@gmail.com>

Nice extension. Thank you.

> +static void copy_play_buf_part_n(struct loopback_pcm *play, struct loopback_pcm *capt,
> +				 unsigned int size, unsigned int src_off, unsigned int dst_off)

I would probably prefer to have dst,src,size arguments to follow memcpy, but 
it's really nitpicking.

Reviewed-by: Jaroslav Kysela <perex@perex.cz>

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

