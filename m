Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266F0752A6B
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 20:44:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232227AbjGMSor (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 14:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbjGMSoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 14:44:46 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC3426B2
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 11:44:45 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36DIiBgo087508;
        Thu, 13 Jul 2023 13:44:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689273851;
        bh=49KqOhoWraqa4xPJvs9k+Ho8uF5dhQ4RQNO+03mu9eI=;
        h=Date:Subject:To:CC:References:From:In-Reply-To;
        b=tOGkFM/2lpI2kKJUQ6x38SM1ZsoFWHZgM3OKWoBY6GHGu0bWkULxbcjZocVJItUMT
         Ylw1f/EbXdTHmaGe3a6GPwIRGB9jzjX3ssKEWyAJQZm9MenwYywibysDgz5mLtXXfN
         4PtuE/vMXXqndUEj8EKuoYfiGERcSgsMiH2JSYHc=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36DIiBnl025156
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 13 Jul 2023 13:44:11 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 13
 Jul 2023 13:44:11 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 13 Jul 2023 13:44:11 -0500
Received: from [10.250.32.50] (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36DIiAiE066405;
        Thu, 13 Jul 2023 13:44:10 -0500
Message-ID: <3611feaa-9c89-b580-6266-c12cf048f56a@ti.com>
Date:   Thu, 13 Jul 2023 13:44:10 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 06/10] ARM: mach-airoha: Rework support and directory
 structure
Content-Language: en-US
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
CC:     Baruch Siach <baruch@tkos.co.il>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230515160234.289631-1-afd@ti.com>
 <20230515160234.289631-6-afd@ti.com> <ZGJeRiqylcysFPqu@shell.armlinux.org.uk>
From:   Andrew Davis <afd@ti.com>
In-Reply-To: <ZGJeRiqylcysFPqu@shell.armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/15/23 11:31 AM, Russell King (Oracle) wrote:
> On Mon, May 15, 2023 at 11:02:30AM -0500, Andrew Davis wrote:
>> Having a platform need a mach-* directory should be seen as a negative,
>> it means the platform needs special non-standard handling. ARM64 support
>> does not allow mach-* directories at all. While we may not get to that
>> given all the non-standard architectures we support, we should still try
>> to get as close as we can and reduce the number of mach directories.
>>
>> The mach-airoha/ directory, and files within, provide just one "feature":
>> having the kernel print the machine name if the DTB does not also contain
>> a "model" string (which they always do). To reduce the number of mach-*
>> directories let's do without that feature and remove this directory.
> 
> I'm guessing this is copy-n-pasted description. However:
>> -static const char * const airoha_board_dt_compat[] = {
>> -	"airoha,en7523",
>> -	NULL,
>> -};
>> -
>> -DT_MACHINE_START(MEDIATEK_DT, "Airoha Cortex-A53 (Device Tree)")
>> -	.dt_compat	= airoha_board_dt_compat,
>> -MACHINE_END
> 
> If this is actually used, then it will have the effect of providing a
> "machine" that has both l2c_aux_mask and l2c_aux_val as zero, whereas
> the default one has l2c_aux_mask set to ~0.
> 

Given we set l2c_aux_mask to ~0 as a default for "Generic" DT system I
had assumed this was safe, but no I cannot prove it for this board as
I don't have one.

I wonder if we should have some way to set this in DT, that would
let us drop some more MACHINE defines that exist only to set
the l2c_aux_val/mask..

> This has the effect of _not_ calling l2x0_of_init() - but you don't
> mention this. You probably should, and you should probably state why
> that is safe (assuming you've even realised you've made this change!)
> 

Reverse question, did the folks adding this support know this had
the effect of changing l2c_aux_mask from the default?

For now I'll resend this series with only the first 5 patches which
should be trivially safe. The later ones I can send after double
checking on l2x0_of_init().

Andrew
