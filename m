Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A9067BCEDC
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 16:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344882AbjJHOIu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 10:08:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344849AbjJHOIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 10:08:49 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB984A4;
        Sun,  8 Oct 2023 07:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=wmFHnrq2vm7ZZb21NIE4ZIne9K2JfxgkcpFShgCSvo8=; b=WycHbR/PvR1N4lh9e1WrGNTVGZ
        LVDkRSsUe+dkZW6HlP4gFQy8kP4iI/TwDkj09DG+Iv/LgOvb4hc22pqpU+PP8peNW44pxLvBynIfA
        WaEYY7iQGVn12vgNGKAVn+wvMRnd5gFkNE/l2CCzm0Bpwq5ciN8cLI5SJAGIsiP7jhFjmuM0+lek4
        ayfD5K82/4VgQkbemkvCeeei5Wbby039dkaqUAnjJi93HNOxh72kgsFSTJxRnLZ7JYEZd9dEurOWI
        1SaIXJ25mvP6kt3k4hMYsZaGxvIrHObcr14xmi6cHNwv1WZWPjoJO4MfYefRAsCtIQMdtTu1lpHAT
        C7nxWzQQ==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpUSd-008vvc-2S;
        Sun, 08 Oct 2023 14:08:47 +0000
Message-ID: <22bc05d3-86e9-4cf6-aec6-10d11df1acc3@infradead.org>
Date:   Sun, 8 Oct 2023 07:08:47 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Content-Language: en-US
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20231007182443.32300-1-rdunlap@infradead.org>
 <20231008093520.42ead15f@barney>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20231008093520.42ead15f@barney>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/23 00:35, Michael Büsch wrote:
> Hi Randy,
> 
> thanks for the patch.
> 
> On Sat,  7 Oct 2023 11:24:43 -0700
> Randy Dunlap <rdunlap@infradead.org> wrote:
> 
>> This is a kconfig warning in a randconfig when CONFIG_PCI is not set:
>>
>> WARNING: unmet direct dependencies detected for SSB_EMBEDDED
>>   Depends on [n]: SSB [=y] && SSB_DRIVER_MIPS [=y] &&
>> SSB_PCICORE_HOSTMODE [=n] Selected by [y]:
>>   - BCM47XX_SSB [=y] && BCM47XX [=y]
>>
>> This is caused by arch/mips/bcm47xx/Kconfig's symbol BCM47XX_SSB
>> selecting SSB_EMBEDDED when CONFIG_PCI is not set.
>>
>> This warning can be prevented by having SSB_EMBEDDED not depend on
>> SSB_PCICORE_HOSTMODE, although some parts of SSB use PCI.
> 
>> diff -- a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
>> --- a/drivers/ssb/Kconfig
>> +++ b/drivers/ssb/Kconfig
>> @@ -134,7 +134,7 @@ config SSB_SFLASH
>>  # Assumption: We are on embedded, if we compile the MIPS core.
>>  config SSB_EMBEDDED
>>  	bool
>> -	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
>> +	depends on SSB_DRIVER_MIPS
>>  	default y
>>  
>>  config SSB_DRIVER_EXTIF
> 
> Could we instead make SSB_EMBEDDED depend on SSB_PCICORE_HOSTMODE if
> PCI!=n. Wouldn't that also solve the problem?
> 
> I don't fully remember how all this ssb config stuff works, but to
> me adding a PCICORE->PCI dependency sounds safer against build
> regressions in some other configurations.
> 
> What do you think?

I'll test it some and see how it works out.
Thanks.

-- 
~Randy
