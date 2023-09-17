Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFBC37A36F6
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 19:59:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237840AbjIQR7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 13:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236836AbjIQR6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 13:58:49 -0400
Received: from smtp.smtpout.orange.fr (smtp-18.smtpout.orange.fr [80.12.242.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BEBB12C
        for <linux-kernel@vger.kernel.org>; Sun, 17 Sep 2023 10:58:40 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id hw2MqAKVBUbVihw2MqRYG1; Sun, 17 Sep 2023 19:58:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1694973512;
        bh=n5GOty1FZm3dW6STDTU4IzxaJuBtMC1qUI5dLmOz7Vg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=Co20ujl7wd3fI3AqepZdv+qa/OQOhrYcmkE48an/tSGeexYfljBIas7OjH3X+rAg/
         BnXA0DNr1dQ3qiFLAwcIZwUItWUBTxHwJdr96ajCHJk+i5lMbX1vm+XZf8+TZs1BDK
         xd7CmWBYFCloEHCwRNIC7LdVwn544+a3kbbxwP1E4rVveJXk2GxkiiV3OrMz+RqKb2
         HgDSLGs2Ygn0XDXEWh8S6+HozzZ2UVodzyEz4LejBiICDak3eqJDth1frJZ0IFEh5B
         qaftgOsL2kCkruvnCVU+ltasDkTxxFwSbHaQNFDutUmnHZu5LwAgubs011SyXxrI9M
         WpPt4H1FAOXTw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 17 Sep 2023 19:58:32 +0200
X-ME-IP: 86.243.2.178
Message-ID: <0e2e0e8f-91dd-b458-e39e-b00baf98b4e0@wanadoo.fr>
Date:   Sun, 17 Sep 2023 19:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 2/2] Input: add Himax HX852x(ES) touchscreen driver
Content-Language: fr, en-US
To:     stephan@gerhold.net, Jeff LaBundy <jeff@labundy.com>
Cc:     conor+dt@kernel.org, devicetree@vger.kernel.org,
        dmitry.torokhov@gmail.com, jonathan.albrieux@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org, robh+dt@kernel.org,
        rydberg@bitmath.org
References: <20230913-hx852x-v1-0-9c1ebff536eb@gerhold.net>
 <20230913-hx852x-v1-2-9c1ebff536eb@gerhold.net>
 <abf36591-3b3c-dc47-b1aa-e574325499f4@wanadoo.fr> <ZQcrQIfXYCv5aMK7@nixie71>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <ZQcrQIfXYCv5aMK7@nixie71>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 17/09/2023 à 18:37, Jeff LaBundy a écrit :

>>> +	error = input_register_device(hx->input_dev);
>>> +	if (error) {
>>
>> input_mt_destroy_slots() should be called here, or in an error handling path
>> below, or via a devm_add_action_or_reset().
> 
> This seems like a memory leak in every touchscreen driver; maybe it is more
> practical to have the input core handle this clean-up.
> 
> Other drivers can and do insert other return paths between input_mt_init_slots()
> and input_register_device(), so it seems that we cannot solve this by calling
> input_mt_destroy_slots() from the error path within input_register_device().
> 
> Maybe a better option is to update input_mt_init_slots() to use device-managed
> allocation instead?

I think that devm_ is the way to go:

    $ git grep input_mt_init_slots | wc -l
    82

    $ git grep input_mt_destroy_slots | wc -l
    6

I'll send a patch for it.

> 
>>
>> It should also be called in a .remove function (unless
>> devm_add_action_or_reset is prefered)
> 
> I think the remove path is OK, as input_dev_release() handles this for us. In
> case I have misunderstood, please let me know.

Agreed. I missed that.

CJ

