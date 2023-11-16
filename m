Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF6AA7EDB47
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Nov 2023 06:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230272AbjKPFkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Nov 2023 00:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbjKPFkP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Nov 2023 00:40:15 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D2618D;
        Wed, 15 Nov 2023 21:40:08 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id BC21C24E2D7;
        Thu, 16 Nov 2023 13:40:04 +0800 (CST)
Received: from EXMBX168.cuchost.com (172.16.6.78) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Nov
 2023 13:40:04 +0800
Received: from [192.168.155.200] (202.188.176.82) by EXMBX168.cuchost.com
 (172.16.6.78) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Thu, 16 Nov
 2023 13:40:02 +0800
Message-ID: <2905f518-95a9-88d4-031c-291ef0373391@starfivetech.com>
Date:   Thu, 16 Nov 2023 13:39:57 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH] crypto: starfive - Pad adata with zeroes
To:     Herbert Xu <herbert@gondor.apana.org.au>
CC:     "David S . Miller" <davem@davemloft.net>,
        <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20231116021752.420680-1-jiajie.ho@starfivetech.com>
 <ZVWcLJOoLdElVsDd@gondor.apana.org.au>
Content-Language: en-US
From:   Jia Jie Ho <jiajie.ho@starfivetech.com>
In-Reply-To: <ZVWcLJOoLdElVsDd@gondor.apana.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [202.188.176.82]
X-ClientProxiedBy: EXCAS062.cuchost.com (172.16.6.22) To EXMBX168.cuchost.com
 (172.16.6.78)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/11/2023 12:35 pm, Herbert Xu wrote:
> On Thu, Nov 16, 2023 at 10:17:52AM +0800, Jia Jie Ho wrote:
>>
>> diff --git a/drivers/crypto/starfive/jh7110-aes.c b/drivers/crypto/starfive/jh7110-aes.c
>> index 9378e6682f0e..e0fe599f8192 100644
>> --- a/drivers/crypto/starfive/jh7110-aes.c
>> +++ b/drivers/crypto/starfive/jh7110-aes.c
>> @@ -500,7 +500,7 @@ static int starfive_aes_prepare_req(struct skcipher_request *req,
>>  	scatterwalk_start(&cryp->out_walk, rctx->out_sg);
>>  
>>  	if (cryp->assoclen) {
>> -		rctx->adata = kzalloc(ALIGN(cryp->assoclen, AES_BLOCK_SIZE), GFP_KERNEL);
>> +		rctx->adata = kzalloc(cryp->assoclen + AES_BLOCK_SIZE, GFP_KERNEL);
> 
> Please explain why you're changing the allocation size here.
> 

Hi Herbert,

The hardware requires aad padded with zeroes up to 15 bytes in some cases.
This extra size and zeroing is meant for the padding and prevents driver 
accessing uninitialized memory region.

> This needs to go into the patch description.
> 

I'll update the v2 commit message if you're good with this implementation.
Thanks for reviewing this.

Jia Jie

