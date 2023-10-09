Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0937BD32A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Oct 2023 08:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345290AbjJIGNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Oct 2023 02:13:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345198AbjJIGNC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Oct 2023 02:13:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1468114;
        Sun,  8 Oct 2023 23:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=oDYkvH5wug9S80itmdHwIQJoxhzYG8li6W+6qaoHsJ4=; b=p1raZY77z3vwCgTpHU/G6ruyDn
        4hVq8+oTHjR71pBVyy9nhZ9/Q4G7HGHmrjx5IYVhAlUL1FIlbcacRtXCiWbrYUQAU9h9CSATDDaf3
        sNJ9m3Yeeq7vRIjr/HvUINnK8DUUqnuvOGyFKAFQaibrwakTTZxGUqAxlhiJDML02OU1TM3sYw/u4
        27ENZXhkZrLAt5cXuHPsSo48um0usr1MaobGVIDPeOlNkauiNUk4VkwMxedCBpy1RyGlpe4HPSBFC
        tBQhWXVmMblS6P5gBWW0LN2FXjCON5dMugTQV61m+ge6EZj7Wr0fDmBuuOlwFtze0c3gEbmu/cAtS
        UIxh93Fg==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qpjVa-009pD2-0T;
        Mon, 09 Oct 2023 06:12:50 +0000
Message-ID: <e551fb4c-1e3d-4e1a-a465-5b88842789c6@infradead.org>
Date:   Sun, 8 Oct 2023 23:12:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] ssb: relax SSB_EMBEDDED dependencies
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     =?UTF-8?Q?Michael_B=C3=BCsch?= <m@bues.ch>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
References: <20231007182443.32300-1-rdunlap@infradead.org>
 <20231008093520.42ead15f@barney>
 <22bc05d3-86e9-4cf6-aec6-10d11df1acc3@infradead.org>
In-Reply-To: <22bc05d3-86e9-4cf6-aec6-10d11df1acc3@infradead.org>
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

Hi Michael,

On 10/8/23 07:08, Randy Dunlap wrote:
> 
> 
> On 10/8/23 00:35, Michael Büsch wrote:
>> Hi Randy,
>>
>> thanks for the patch.
>>
>> On Sat,  7 Oct 2023 11:24:43 -0700
>> Randy Dunlap <rdunlap@infradead.org> wrote:
>>
>>> This is a kconfig warning in a randconfig when CONFIG_PCI is not set:
>>>
>>> WARNING: unmet direct dependencies detected for SSB_EMBEDDED
>>>   Depends on [n]: SSB [=y] && SSB_DRIVER_MIPS [=y] &&
>>> SSB_PCICORE_HOSTMODE [=n] Selected by [y]:
>>>   - BCM47XX_SSB [=y] && BCM47XX [=y]
>>>
>>> This is caused by arch/mips/bcm47xx/Kconfig's symbol BCM47XX_SSB
>>> selecting SSB_EMBEDDED when CONFIG_PCI is not set.
>>>
>>> This warning can be prevented by having SSB_EMBEDDED not depend on
>>> SSB_PCICORE_HOSTMODE, although some parts of SSB use PCI.
>>
>>> diff -- a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
>>> --- a/drivers/ssb/Kconfig
>>> +++ b/drivers/ssb/Kconfig
>>> @@ -134,7 +134,7 @@ config SSB_SFLASH
>>>  # Assumption: We are on embedded, if we compile the MIPS core.
>>>  config SSB_EMBEDDED
>>>  	bool
>>> -	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
>>> +	depends on SSB_DRIVER_MIPS
>>>  	default y
>>>  
>>>  config SSB_DRIVER_EXTIF
>>
>> Could we instead make SSB_EMBEDDED depend on SSB_PCICORE_HOSTMODE if
>> PCI!=n. Wouldn't that also solve the problem?
>>
>> I don't fully remember how all this ssb config stuff works, but to
>> me adding a PCICORE->PCI dependency sounds safer against build
>> regressions in some other configurations.
>>
>> What do you think?
> 
> I'll test it some and see how it works out.
> Thanks.

The following change seems to work and passes some testing.
Is this what you had in mind?
Thanks.

---
---
 drivers/ssb/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/ssb/Kconfig b/drivers/ssb/Kconfig
--- a/drivers/ssb/Kconfig
+++ b/drivers/ssb/Kconfig
@@ -134,7 +134,7 @@ config SSB_SFLASH
 # Assumption: We are on embedded, if we compile the MIPS core.
 config SSB_EMBEDDED
 	bool
-	depends on SSB_DRIVER_MIPS && SSB_PCICORE_HOSTMODE
+	depends on PCI=n || SSB_PCICORE_HOSTMODE
 	default y
 
 config SSB_DRIVER_EXTIF

