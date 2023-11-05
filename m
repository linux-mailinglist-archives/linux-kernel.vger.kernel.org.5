Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 57D5B7E1769
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Nov 2023 23:46:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbjKEWqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Nov 2023 17:46:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjKEWp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Nov 2023 17:45:59 -0500
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEDF810B;
        Sun,  5 Nov 2023 14:45:55 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 21EA1480A29;
        Sun,  5 Nov 2023 17:45:55 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1699224355;
 h=message-id : date : mime-version : subject : from : to : references
 : in-reply-to : content-type : content-transfer-encoding : from;
 bh=5f9IVU0iQFOUi7B5c/rYv8o9c2hnsOJAQqtuHXKCsKI=;
 b=5qpOpQAzgIwi6DjsdMrKbhfe6fZVZ7N9WW8VWNQm40xLe1nCf3Krjq6UkJrT2uhnfOqh4
 WSK+FVOx7v9LJIcBA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1699224355;
        cv=none; b=adkHv2B+W+gCcM+LUmT9xeCZNWgMEQr9S8cKQlDsvsrB3vpaoruastZxTgzvoprBfrECJLfIMgBjde2r40yIzKPMhZRmM66t/ZPXcbYXSyNbI2OHIkZHjlac7jN6Czxcuy7vHXnzloA3FHt4o5jK1F1O0geqDOr6ZpQBpljGGKjJ+NHihOivSwH1qPqBdhIAkrLlE80H0qLWdWQiu2cKMg4pl7UKp3y27kCkGRQwXm+MAqmTvnWzrpsTLJtLcCyMeDpXKXjJMobCAvwq5WNDl9kkiizf7k24GjhUl7A2fxVYQqIIuB+FXfTTBaqZAJoRjx+HOqJTfNa7uHshaNNdbw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1699224355; c=relaxed/simple;
        bh=bOCDA6Mt95d3IbyNTKeIFPj/IhJ/HLkkTXsdCMbIR4c=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:From:To:References:In-Reply-To:
         Content-Type:Content-Transfer-Encoding; b=gBZ6aNexEPM5VscNugANygb5ZXbkB2CD++LhvtzBfwFJ+qPYDmwuCA8SvktDilzq//1ys5Yig/zjyJ9Ufsl1oXADU19s8biriugkuW28AIZLWMoZ4lxNF+JmdDKqFFe582ytXvjqqW/DH26WvbFL/EVTzFbz2Vqv7//J1hXpyVI+2w6FR5y4MvT//o42DrkqnNtAyRp63JoWuOoGOWyqM/l4A8zS0m+EYlCAXHgOjqdz1EnsFQRCC9LyQbFIPX2jYY5pHpygOdMKLc/61WO4dRuO+asROs22fGMyhaU+UK4wDTyT2yYtQ9Rm84bU28YuZojbBQbf7oGEC8BdC4Q4Xw==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1699224355;
 h=message-id : date : mime-version : subject : from : to : references
 : in-reply-to : content-type : content-transfer-encoding : from;
 bh=5f9IVU0iQFOUi7B5c/rYv8o9c2hnsOJAQqtuHXKCsKI=;
 b=CM073DtkpL2mMWIKbhDrpl6mzH7bXYHRfxVNWxrfEz5+v/ixqnyRz4+6aPC6g6QGBlij/
 1JnA6EAAt0B80zjvo0V5UJkVA6BSkyHi+Ov7Bc6u84rSchCh/1qgvGWgh+VWsPYdtcOcvdW
 +jnI5wwn2OWYY8KmhhDup8oxInPgIMyPVAIjzsFUYhryWzHvPCK38Od9RB6q7XBpm3l9Yk4
 Z/CEZt6BPVBTN26FD7u3kf+S0aD45CcGJZCPHmFV+b07EprHXheghY3/dScHXMYWpazaV2w
 iRsda7mXkyk1mgQWbMXSUVqKuSmr/v0kQvkq0IuPfPlnDTMwg3jjxwTf2nYg==
Message-ID: <e76b6853-95e9-46b4-bc8a-ac10a1be2246@sapience.com>
Date:   Sun, 5 Nov 2023 17:45:53 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Hash sha3-512 vs scripts/sign-file vs openssl
Content-Language: en-US
From:   Genes Lists <lists@sapience.com>
To:     linux-kernel@vger.kernel.org, dhowells@redhat.com,
        dwmw2@infradead.org, keyrings@vger.kernel.org
References: <be576842-6ad5-43f8-abcf-bd7fa84e235d@sapience.com>
In-Reply-To: <be576842-6ad5-43f8-abcf-bd7fa84e235d@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/5/23 16:49, Genes Lists wrote:
> Mainline modules signing supports sha3-xxx.
> 
..
>   At main.c:321:
> - SSL error:2EFFF06F:CMS routines:CRYPTO_internal:ctrl failure: 
> cms/cms_sd.c:269
> 
> openssl version here on arch is 3.1.4 and this may quite possibly be 
..

I confirm that linking sign-file against openssl git head works fine.

So it should be fixed in openssl 3.2

regards,

gene

