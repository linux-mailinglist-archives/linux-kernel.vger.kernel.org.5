Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03895758395
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 19:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232218AbjGRRhB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 13:37:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjGRRhA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 13:37:00 -0400
Received: from smtp.smtpout.orange.fr (smtp-28.smtpout.orange.fr [80.12.242.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A66D4F7
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jul 2023 10:36:57 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id Lod3qCbotZWkDLod3qY9dM; Tue, 18 Jul 2023 19:36:55 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1689701815;
        bh=lsbpuBE8VHQOk+U0aT8eLugmaMO5aLTU5RhBZUcQCX8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=mEo2o3dOjfpSc7tohZnxrCKfQQXNP+wPQNnWeSxlxysT4XHzZDYOFaoNEDfD6EgF7
         ukEPqxO4BonkifqpWMW6vT9kpUGZjdYK9UrcvIRdpBMv7kwLnGaXbbD85MVoRfe2Lk
         CWCWiL7WFr5kuomFPXCZqtTp8fV3YsoCMxmBKvmsOtkYRz4gpK0ikmKjUnl8Ldggpr
         1D7ATER6Nuwouc0n+I6da0sj0UHZ+A0Xiw9vd3GtPXML/B4ZtsmbkL1+6w202PxEj5
         qY1cKEn4BfLlP8+zBAklk56kyYvJEPXT2ztE16dR6kFcjmvkaLP/0onbPNgir7iZJy
         TlXy+o4QsbEkg==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 18 Jul 2023 19:36:55 +0200
X-ME-IP: 86.243.2.178
Message-ID: <8d98b544-6191-53ce-fcb7-07d932c40f82@wanadoo.fr>
Date:   Tue, 18 Jul 2023 19:36:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] platform/x86: hp-bioscfg: Fix some memory leaks in
 hp_populate_enumeration_elements_from_package()
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Jorge Lopez <jorge.lopez2@hp.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
References: <9770122e4e079dfa87d860ed86ba1a1237bcf944.1689627201.git.christophe.jaillet@wanadoo.fr>
 <81fd0ef0-e254-4a24-a88a-459b1d773354@kadam.mountain>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <81fd0ef0-e254-4a24-a88a-459b1d773354@kadam.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 18/07/2023 à 09:55, Dan Carpenter a écrit :
> On Mon, Jul 17, 2023 at 10:53:37PM +0200, Christophe JAILLET wrote:
>> In the loop in the ENUM_POSSIBLE_VALUES case, we allocate some memory that
>> is never freed.
>>
>> While at it, add some "str_value = NULL" to avoid some potential double
>> free.
>>
>> Fixes: 6b2770bfd6f9 ("platform/x86: hp-bioscfg: enum-attributes")
>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>> ---
>> /!\ Speculative /!\
>>
>>     This patch is based on analysis of the surrounding code and should be
>>     reviewed with care !
>>
>> /!\ Speculative /!\
> 
> I reported these bugs yesterday.

Ok, seen now...
... but I don't read platform-driver-x86@vger.kernel.org :)

CJ

> I don't think this is the correct fix.
> I thought about making the str_value local to the for loop.  That's sort
> of like what your patch does.  But I wasn't sure that was necessarily
> correct either.
> 
> This code needs more testing as well.  It seems no one has called this
> function.
> 
> Smatch complained about uninitialized variables as well.  I didn't
> bother to report that yesterday but I may as well.
> 
> regards,
> dan carpenter
> 
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:188 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:191 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:194 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:197 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:200 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:239 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:242 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/string-attributes.c:245 hp_populate_string_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:192 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:195 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:198 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:201 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:204 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:238 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:242 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/order-list-attributes.c:262 hp_populate_ordered_list_elements_from_package() error: uninitialized symbol 'value_len'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:198 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:201 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:204 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:207 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:246 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:249 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:252 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/int-attributes.c:255 hp_populate_integer_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:180 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:183 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:186 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:189 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:192 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:231 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/enum-attributes.c:239 hp_populate_enumeration_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:279 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:282 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:285 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:288 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:291 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:324 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:327 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:330 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:333 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> drivers/platform/x86/hp/hp-bioscfg/passwdobj-attributes.c:362 hp_populate_password_elements_from_package() error: uninitialized symbol 'int_value'.
> 

