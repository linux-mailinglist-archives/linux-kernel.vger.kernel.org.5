Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46954787A20
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 23:20:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239981AbjHXVTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 17:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbjHXVTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 17:19:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8E2CF1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 14:19:38 -0700 (PDT)
Received: from [192.168.1.90] (unknown [81.18.92.207])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D8B6D6607273;
        Thu, 24 Aug 2023 22:19:36 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692911977;
        bh=qfO43KuY9H4FZIv5b2C4WjeQJ8C9kmFK9DgPZV/NQD8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=T72ehi/8b7imqbsQe/GvyYm6S0FEWEJuHY/frQC5n0Q3vL2qZ3w0Lvw7nJnvxh8aJ
         dFsTuWStzmmMDPGOsfVyk/ORGDsfgN0+Q3susU7avvBRP5kuj+W8lwsRCXXkMVh28r
         q8L5q2X35Xt1Dyt1fdzY7qQUFRiAi1QzwLiX/QanzM4WwQSGI5c5Bd1eU+b8IjoLgk
         1VA4KvsqUOLYF7ZTEs+JSqIxH41IDMJ2hTgaJn3XwHaIMcl9QMBmykKSkf5HMP+HzT
         2QbLQeKJ17ipR5urei0Ya69IvC0rep7YwfGktfWGi3CyT75s82lW0if9FiqwXswwU6
         4pMvpqehKLO7w==
Message-ID: <405e420d-ba17-4a20-9cec-11e821b73bbf@collabora.com>
Date:   Fri, 25 Aug 2023 00:19:34 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: soc-core.c: Do not error if a DAI link component is
 not found
Content-Language: en-US
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230824193837.369761-1-cristian.ciocaltea@collabora.com>
 <ZOe36EyxNQuz08qt@finisterre.sirena.org.uk>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZOe36EyxNQuz08qt@finisterre.sirena.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/24/23 23:04, Mark Brown wrote:
> On Thu, Aug 24, 2023 at 10:38:37PM +0300, Cristian Ciocaltea wrote:
>> A recent cleanup of soc_dai_link_sanity_check() is responsible for
>> generating lots of confusing errors before returning -EPROBE_DEFER:
>>
>>   acp5x_mach acp5x_mach.0: ASoC: Component acp5x_i2s_dma.0 not found for link acp5x-8821-play
>>   [...]
>>   acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:00 not found for link acp5x-CS35L41-Stereo
>>   [...]
>>   acp5x_mach acp5x_mach.0: ASoC: Component spi-VLV1776:01 not found for link acp5x-CS35L41-Stereo
>>
>> Switch back to the initial behaviour of logging those messages on
>> KERN_DEBUG level instead of KERN_ERR.
>>
>> While at it, use the correct form of the verb in 'component_not_find'
>> label.
> 
> Don't include random extra stuff in patches unless there is substantial
> overlap, send one change per patch.

I submitted v2 with the unrelated changes moved to a separate patch:

https://lore.kernel.org/all/20230824211241.388201-1-cristian.ciocaltea@collabora.com/

Thanks,
Cristian
