Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA1B07B0A05
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 18:26:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbjI0Q0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 12:26:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231256AbjI0Q0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 12:26:36 -0400
Received: from mail1.perex.cz (mail1.perex.cz [77.48.224.245])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1514E6
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 09:26:33 -0700 (PDT)
Received: from mail1.perex.cz (localhost [127.0.0.1])
        by smtp1.perex.cz (Perex's E-mail Delivery System) with ESMTP id 9E83F11ED;
        Wed, 27 Sep 2023 18:26:30 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.perex.cz 9E83F11ED
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=perex.cz; s=default;
        t=1695831990; bh=k+hr6qJrV6jG/uOr7Xk8xDT8VJ38SwhnTqbGz6zGZZQ=;
        h=Date:To:Cc:References:From:Subject:In-Reply-To:From;
        b=pSa7UE0hkyTGjKNfiFWYaATjzhEnv7iSBwktqO9+zpqw0+QP6oiATqOp4BFXb0XwS
         Qt9DXmoEJnlmSqxWShzbymMz6FWWjZEDDB/4XYyRn6rbN/8G+ffG/oSjludBsmJ2ej
         MX2TgQFEgt1pQ0NflxVbNn5HY30xt7uH3W5i1YQQ=
Received: from [192.168.100.98] (unknown [192.168.100.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: perex)
        by mail1.perex.cz (Perex's E-mail Delivery System) with ESMTPSA;
        Wed, 27 Sep 2023 18:26:20 +0200 (CEST)
Message-ID: <5cafee23-b1fe-4ee5-8f62-6080707403da@perex.cz>
Date:   Wed, 27 Sep 2023 18:26:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
To:     sboyce@blueyonder.co.uk, Randy Dunlap <rdunlap@infradead.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ALSA <alsa-devel@alsa-project.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, Takashi Iwai <tiwai@suse.com>
References: <213f93b5-bffe-479f-a111-f8a7e44cd293@blueyonder.co.uk>
 <61821f15-78e2-4594-8f39-545ecaa97000@infradead.org>
 <5903832d-7d27-4847-b161-48b9f7e92ee6@blueyonder.co.uk>
 <ZRLWIkyngsasQbQ7@debian.me>
 <6a6d7683-78f2-4511-976d-eb42d3b59c89@blueyonder.co.uk>
 <40672e60-3913-4794-b84a-742b7c16d361@infradead.org>
 <4b2c3b4e-9b21-4f80-95e1-58aa7f58131e@blueyonder.co.uk>
Content-Language: en-US
From:   Jaroslav Kysela <perex@perex.cz>
Subject: Re: Ryzen 9 7950x sound module does not not build
In-Reply-To: <4b2c3b4e-9b21-4f80-95e1-58aa7f58131e@blueyonder.co.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27. 09. 23 13:27, Sid Boyce wrote:
> On 26/09/2023 23:13, Randy Dunlap wrote:
>> lspci -vv

> 0b:00.6 Audiodevice: Advanced Micro Devices, Inc. [AMD] Family 17h/19h
> HD AudioController
>          DeviceName: Realtek ALC897 Audio
>          Subsystem: ASUSTeK Computer Inc. Device 87fb

It looks like a standard HDA hardware. The acp module may not be relevant. You 
should see some inputs/outputs for this card in pipewire - the snd-hda-intel 
module is loaded.

But this hardware may require a new quirk, when the generic code does not work 
for you. I suggest to look to the HDA driver documentation in 
Documentation/sound/hd-audio tree.

					Jaroslav

-- 
Jaroslav Kysela <perex@perex.cz>
Linux Sound Maintainer; ALSA Project; Red Hat, Inc.

