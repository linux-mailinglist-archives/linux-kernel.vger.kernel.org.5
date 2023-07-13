Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAFE6751853
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 07:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjGMFsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 01:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233654AbjGMFr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 01:47:58 -0400
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C3C1BD5;
        Wed, 12 Jul 2023 22:47:57 -0700 (PDT)
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-3fbc1218262so2206705e9.3;
        Wed, 12 Jul 2023 22:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689227275; x=1691819275;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g/23YouR6ifHDZ8U/xHyTwj4qWiz/nazDA45VtndnBg=;
        b=P/H1yik60KnfTDst5gL+4AmCxOvNKGwrwqn2wvHIxnPJAGBjzhZi/OdJV/1DfCTNcT
         hBUgIymq9fpjCRGrOSnmfWPnno2xYlbMGlg0S1zqfnd11LgJWx3FPJ2QC6Fy1tgyGD3W
         vRBZvWAr+PomsoOOsQeFr2GDvUWYsvsH0QoBOiaKOKc76nErUmL/GXIqsvS4gSB0SllR
         FlLDoqEDq6bVLSbia044oV5z4pG0q0qa+qCSSnjbLzZeHmISi22reS613w6fKhfgC0RX
         pD3A2kngHvlC4Nw9y3FWHFPy7xra4af5bZcgid0z3bb88aLa+R6e887iR3JgrkAVeEpz
         IWPg==
X-Gm-Message-State: ABy/qLagW5vAgJ3zBok1BnLfbYlNJ15K4+u9ytznvSO1yU1lntt/FIA6
        clUTgnsTUEGR0nC0iyfRens=
X-Google-Smtp-Source: APBJJlFANUI6X4TyBnut+ulAcfN4Oe7AF2hbXKvVPpVzvQ/r1juJj6KodJuZscorIn/o6ImILHX6XQ==
X-Received: by 2002:a7b:c38b:0:b0:3fb:b3aa:1c8a with SMTP id s11-20020a7bc38b000000b003fbb3aa1c8amr410378wmj.16.1689227275300;
        Wed, 12 Jul 2023 22:47:55 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::aaaa:59? ([2a0b:e7c0:0:107::aaaa:59])
        by smtp.gmail.com with ESMTPSA id u9-20020a7bc049000000b003fbc681c8d1sm17300945wmc.36.2023.07.12.22.47.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 22:47:54 -0700 (PDT)
Message-ID: <986bc150-1ab3-4ec1-dd76-d3be69bfcef9@kernel.org>
Date:   Thu, 13 Jul 2023 07:47:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] drivers: wireless: ath5k: fix parameter check in
 ath5k_debug_init_device
Content-Language: en-US
To:     Markus Elfring <Markus.Elfring@web.de>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Minjie Du <duminjie@vivo.com>, linux-wireless@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Cc:     opensource.kernel@vivo.com, LKML <linux-kernel@vger.kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Nick Kossifidis <mickflemm@gmail.com>
References: <ZK7wqH86hEswxGo6@bombadil.infradead.org>
 <3e831a9c-b469-f1d3-1eaf-c9e275a74da5@web.de>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <3e831a9c-b469-f1d3-1eaf-c9e275a74da5@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12. 07. 23, 21:07, Markus Elfring wrote:
>>> +++ b/drivers/net/wireless/ath/ath5k/debug.c
>>> @@ -982,7 +982,7 @@ ath5k_debug_init_device(struct ath5k_hw *ah)
>>>   	ah->debug.level = ath5k_debug;
>>>
>>>   	phydir = debugfs_create_dir("ath5k", ah->hw->wiphy->debugfsdir);
>> -	if (!phydir)
>>> +	if (IS_ERR(phydir))
>>
>> Please use IS_ERR_OR_NULL() instead.
> 
> I find your support for consistent error detection interesting here.
> Contributors for other Linux software components provide different
> development views.

IS_ERR_OR_NULL() is almost never correct. It is used exceptionally in 
cases where one needs to distinct three states. It's not the case for 
sysfs/debugfs interfaces.

> Would a subject like “[PATCH v2] ath5k: Fix an error check in ath5k_debug_init_device()”
> be more appropriate?

Yes (pointing out specifically "()" at the end). And add the "why" part 
to the message log too, please.

thanks,
-- 
js
suse labs

