Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4788A7FDEE4
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 18:53:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231256AbjK2RxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 12:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbjK2RxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 12:53:24 -0500
Received: from s1.sapience.com (s1.sapience.com [72.84.236.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2579E8F;
        Wed, 29 Nov 2023 09:53:31 -0800 (PST)
Authentication-Results: dkim-srvy7; dkim=pass (Good ed25519-sha256 
   signature) header.d=sapience.com header.i=@sapience.com 
   header.a=ed25519-sha256; dkim=pass (Good 2048 bit rsa-sha256 signature) 
   header.d=sapience.com header.i=@sapience.com header.a=rsa-sha256
Received: from srv8.prv.sapience.com (srv8.prv.sapience.com [x.x.x.x])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (secp384r1) server-digest SHA384)
        (No client certificate requested)
        by s1.sapience.com (Postfix) with ESMTPS id 554F8480A86;
        Wed, 29 Nov 2023 12:53:29 -0500 (EST)
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-ed25519-220413; t=1701280409;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=6+Ojpcb+Wse384xeZGnnHJV8BbY5iiqktcSBQCCmkBQ=;
 b=QMINgx4YuStDwIUwKAGB1eNdY3BiPLPMrXnhCLkR3b3+/lAbNuD+ePoNdCGMShFySkYm/
 TbHHteD51Anw5SWDA==
ARC-Seal: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412; t=1701280409;
        cv=none; b=cvrKAL/1EzuglKy41A0UsjZ//eTlZ6EBgR944Cs3Ez2YKxhfTxDf3K/xJP0ODL/0RWOVo4XBqEUgR7+qqPTTzj5ds9P22ueigiB4H5R3fvj50JAOpp1zl544qfunr2vZNLmmRWSzSX10QfdYhN0SoIaE2SDSwL7HaIRBRLztS4+EDSEXS+2Zz/9amu/aN6fMeOjAtTM+BuLVUxxF+GqCd94NotWsOeOUBgLy3Crrz4Hv/3DM3/wcUgCdK+B07R6oKFFJ7M5Xwe/qfs70BeeLWfoKjxNeO9TJ9DrL3NZdU3BJwqkBmnqQGPYEpo0MKA7IUvrezUgyO1usTnqqMnoJaQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=sapience.com; s=arc6-rsa-220412;
        t=1701280409; c=relaxed/simple;
        bh=90HoYer8zpjhGw2nVpjHPxToGqj12SWVsujnAUANBKE=;
        h=DKIM-Signature:DKIM-Signature:Message-ID:Date:MIME-Version:
         User-Agent:Subject:Content-Language:From:To:Cc:References:
         In-Reply-To:Content-Type:Content-Transfer-Encoding; b=wL7fzyIdCzw1DElUOTdwON/1F7FwG96pBd3qIaMBdxSzZGxZyciQpUqllx6Bp3Tjuyt3S0bDoEqX7B1qz23XU/thKapzzy85qmucMXu/nCV1LYoE8dIxMT9RklGT5v8R43d8VDe+54fdvkf9aEaZxsFGKz5LNTqPLM/EqqyKpIwrLgS26XJ3VILS5GW8DugvGJyOaYjiODI/OFqbhof9I8OjBJow1RTDp3+eQsk9EI6iHb1IBjNev64rSkE5pH18+iPwatBQk7ooOyaoQVpisRO+S5gYAPMx+N9J1YZNK8SG06b33bGBMjr/NCuKCZ43n6Z+mfbvMCSK6H+oVK2oig==
ARC-Authentication-Results: i=1; arc-srv8.sapience.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sapience.com;
 i=@sapience.com; q=dns/txt; s=dk-rsa-220413; t=1701280409;
 h=message-id : date : mime-version : subject : from : to : cc :
 references : in-reply-to : content-type : content-transfer-encoding :
 from; bh=6+Ojpcb+Wse384xeZGnnHJV8BbY5iiqktcSBQCCmkBQ=;
 b=IQeYAn+O9BNhmRfBf+F6t5ROSgM76eKB7kUnG4XWuiVdEZAs30gpmRQ6peaAZaHtkDBhs
 bnBRnQ2OtPpjYq4qkqBakeI1F3jFY82JUFB+MYt/a9E/uQ9oN+tsFo3t9yZiwPTbL3rCRmW
 2fr3YbEYbGyRsvDqW5v+j4gKgoRKaHAHkBGwa3IUyPRoKE5gpiTgTHd95XsRToIEgii8lXP
 WUjJxb9UE3nTgfNcehI9EsB3wbMnmcnlU4PVFluHf8AcWHgbcy+om8YkdLp6/5ezaX1Cj3+
 3tv0ZuyJ8bom1v6wJ+8BZCzMJh/M9BPAYErqOapDtLISy7n2yFoG3bsNhzDA==
Message-ID: <2ce6a24f-fc9b-45d2-8a11-73a3e69ffa13@sapience.com>
Date:   Wed, 29 Nov 2023 12:53:28 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: crash with 6.7 rc2 and rc3
Content-Language: en-US
From:   Genes Lists <lists@sapience.com>
To:     Bagas Sanjaya <bagasdotme@gmail.com>, tglx@linutronix.de,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        gregory.greenman@intel.com, kvalo@kernel.org,
        Linux Wireless <linux-wireless@vger.kernel.org>
Cc:     Linux Regressions <regressions@lists.linux.dev>
References: <c46a6462-8263-455c-a6ea-1860020f5fab@sapience.com>
 <ZWV7JworMrjHJHsO@archie.me>
 <cf2dcc97-845d-4860-be4d-5822d2ebbfca@sapience.com>
 <022c67aa-b90a-4756-8725-5f7fba7dc780@sapience.com>
In-Reply-To: <022c67aa-b90a-4756-8725-5f7fba7dc780@sapience.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/28/23 14:56, Genes Lists wrote:
> On 11/28/23 05:39, Genes Lists wrote:
>> On 11/28/23 00:31, Bagas Sanjaya wrote:
>>> On Mon, Nov 27, 2023 at 03:55:37PM -0500, Genes Lists wrote:
>>>>
>>>> lenovo laptop boots fine under 6.7rc1 and older including 6.6.2 stable.
>>>> but not for 6.7 rc2 or rc3.
>>>>
>>>> ...
> 
> 

This appears to be build related. Starting from scratch with builds and 
they are now working fine.

My sincere apologies - please ignore/close this as (silly) user error.

thanks

gene

