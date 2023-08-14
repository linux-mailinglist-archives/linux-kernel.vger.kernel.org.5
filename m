Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 243A777B2FC
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 09:51:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231318AbjHNHvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 03:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234319AbjHNHuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 03:50:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6D3C9F;
        Mon, 14 Aug 2023 00:50:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AD75610F4;
        Mon, 14 Aug 2023 07:50:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B35C7C433C8;
        Mon, 14 Aug 2023 07:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691999452;
        bh=x3wF5vzE2q8dWA8gYzwJnJgKRnZUE1HvAzXLwGWh+nE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=W+HI9eWs+zOaoW2BnawxUEGwFa64bJC3asFINzJnN+VYd/mA74HaErxRaV43QbDj5
         dltDdiaughOKS/slTxeeW/fSsofsKDEn533vDPSivSQ+3buXgtVovFwD6ewv1bmPvK
         +9pCuUx9E3CaedT2Xu4QVLlDxsIv+eKKWG0YVVkPXWbLUcGxjo8uQdbjrRhBAeMxge
         Jf/I7+fgi8R75lQKuiU7NphLuCnkypZFot53Tq0USd6V3/hsEdB0tve618QWc4N04e
         eEjo5NpUFet6oRQPw4CaeUTZj+rVuSQUWKmGkpGdUfHZQHTaTS2R9dtndIeehuwFsu
         iq39b9sYx4PTg==
Message-ID: <eb135aff-dc33-d559-1826-9284a22c095a@kernel.org>
Date:   Mon, 14 Aug 2023 16:50:50 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] scsi: ata: Fix a race condition between scsi error
 handler and ahci interrupt
Content-Language: en-US
To:     Li Nan <linan666@huaweicloud.com>
Cc:     linux-ide@vger.kernel.org, linux-kernel@vger.kernel.org,
        linan122@huawei.com, yukuai3@huawei.com, yi.zhang@huawei.com,
        houtao1@huawei.com, yangerkun@huawei.com
References: <20230810014848.2148316-1-linan666@huaweicloud.com>
 <25c1aca7-d885-0fff-2639-bb68a7dff44f@kernel.org>
 <c2ae28b7-a105-9cd6-bf2e-63051a4000b0@huaweicloud.com>
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <c2ae28b7-a105-9cd6-bf2e-63051a4000b0@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/14/23 15:41, Li Nan wrote:
>> This is definitely not correct because EH may have been scheduled for a non
>> fatal action like a device revalidate or to get sense data for successful
>> commands. With this change, the port will NOT be frozen when a hard error IRQ
>> comes while EH is waiting to start, that is, while EH waits for all commands to
>> complete first.
>>
> 
> Yeah, we should find a better way to fix it. Do you have any suggesstions?
> 
>> Furthermore, if you get an IRQ that requires the port to be frozen, it means
>> that you had a failed command. In that case, the drive is in error state per
>> ATA specs and stops all communication until a read log 10h command is issued.
>> So you should never ever see 2 error IRQs one after the other. If you do, it
>> very likely means that you have buggy hardware.
>>
>> How do you get into this situation ? What adapter and disk are you using ?
>>
> 
>  > How do you get into this situation ?
> The first IRQ is io error, the second IRQ is disk link flash break.

What does "link flash break" mean ?

> 
>  > What adapter and disk are you using ?
> It is a disk developed by our company, but we think the same issue 
> exists when using other disks.

As I said, I find this situation highly suspect because if the first IRQ was to
signal an IO error that the drive reported, then per ATA specifications, the
drive should be in error mode and should NOT have transmitted any other FIS
after the SDB FIS that signaled the error. Nothing at all should come after that
error SDB FIS, until the host issues a read log 10h to get thee drive out of
error state.

If this is a prototype device, I would recommend that you take an ATA bus trace
and verify the FIS traffic. Something fishy is going on with the drive in my
opinion.

-- 
Damien Le Moal
Western Digital Research

