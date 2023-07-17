Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF1CB755C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 09:07:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230242AbjGQHH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 03:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjGQHHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 03:07:18 -0400
Received: from imap4.hz.codethink.co.uk (imap4.hz.codethink.co.uk [188.40.203.114])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02DC9E7D;
        Mon, 17 Jul 2023 00:07:16 -0700 (PDT)
Received: from [93.159.155.93] (helo=[172.20.8.34])
        by imap4.hz.codethink.co.uk with esmtpsa  (Exim 4.94.2 #2 (Debian))
        id 1qLIK8-00F7EA-5M; Mon, 17 Jul 2023 08:07:12 +0100
Message-ID: <faa870b6-112e-46fa-2b98-f5700dd76263@codethink.co.uk>
Date:   Mon, 17 Jul 2023 08:07:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/5] pwm: dwc: split pci out of core driver
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Ben Dooks <ben.dooks@sifive.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greentime Hu <greentime.hu@sifive.com>,
        jarkko.nikula@linux.intel.com,
        William Salmon <william.salmon@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>
References: <20230614171457.69191-1-ben.dooks@sifive.com>
 <20230614171457.69191-2-ben.dooks@sifive.com>
 <20230715192832.hczmcchn4svzilnd@pengutronix.de>
Content-Language: en-GB
From:   Ben Dooks <ben.dooks@codethink.co.uk>
Organization: Codethink Limited.
In-Reply-To: <20230715192832.hczmcchn4svzilnd@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/07/2023 20:28, Uwe Kleine-König wrote:
> On Wed, Jun 14, 2023 at 06:14:53PM +0100, Ben Dooks wrote:
>> Moving towards adding non-pci support for the driver, move the pci
>> parts out of the core into their own module. This is partly due to
>> the module_driver() code only being allowed once in a module and also
>> to avoid a number of #ifdef if we build a single file in a system
>> without pci support.
>>
>> Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
>> ---
>> v8:
>>   - add module namespace
>>   - remove compile-test for pci case, doesn't make sense
>>   - fix makefile, missed config symbol changes
>> v7:
>>   - re-order kconfig to make dwc core be selected by PCI driver
>> v6:
>>   - put DWC_PERIOD_NS back to avoid bisect issues
>> v4:
>>   - removed DWC_PERIOD_NS as not needed
>> ---
>>   drivers/pwm/Kconfig        |  14 ++-
>>   drivers/pwm/Makefile       |   1 +
>>   drivers/pwm/pwm-dwc-core.c | 176 +++++++++++++++++++++++++++++++++
>>   drivers/pwm/pwm-dwc.c      | 197 +------------------------------------
>>   drivers/pwm/pwm-dwc.h      |  60 +++++++++++
>>   5 files changed, 253 insertions(+), 195 deletions(-)
>>   create mode 100644 drivers/pwm/pwm-dwc-core.c
>>   create mode 100644 drivers/pwm/pwm-dwc.h
>>
>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>> index 8df861b1f4a3..7c54cdcb97a0 100644
>> --- a/drivers/pwm/Kconfig
>> +++ b/drivers/pwm/Kconfig
>> @@ -186,9 +186,19 @@ config PWM_CROS_EC
>>   	  PWM driver for exposing a PWM attached to the ChromeOS Embedded
>>   	  Controller.
>>   
>> +config PWM_DWC_CORE
>> +	tristate
>> +	depends on HAS_IOMEM
>> +	help
>> +	  PWM driver for Synopsys DWC PWM Controller.
>> +
>> +	  To compile this driver as a module, build the dependecies as
>> +	  modules, this will be called pwm-dwc-core.
>> +
>>   config PWM_DWC
>> -	tristate "DesignWare PWM Controller"
>> -	depends on PCI
>> +	tristate "DesignWare PWM Controller (PCI bus)"
>> +	depends on HAS_IOMEM && PCI
>> +	select PWM_DWC_CORE
>>   	help
>>   	  PWM driver for Synopsys DWC PWM Controller attached to a PCI bus.
>>   
>> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
>> index 19899b912e00..de3ed77e8d7c 100644
>> --- a/drivers/pwm/Makefile
>> +++ b/drivers/pwm/Makefile
>> @@ -15,6 +15,7 @@ obj-$(CONFIG_PWM_CLK)		+= pwm-clk.o
>>   obj-$(CONFIG_PWM_CLPS711X)	+= pwm-clps711x.o
>>   obj-$(CONFIG_PWM_CRC)		+= pwm-crc.o
>>   obj-$(CONFIG_PWM_CROS_EC)	+= pwm-cros-ec.o
>> +obj-$(CONFIG_PWM_DWC_CORE)	+= pwm-dwc-core.o
>>   obj-$(CONFIG_PWM_DWC)		+= pwm-dwc.o
> 
> Would it make sense to call this pwm-dwc-pci.o? And the symbol
> CONFIG_PWM_DWC_PCI? (The latter would break make oldconfig. Hmm, I'm
> unsure myself.)

i left the pci as the pwm-dwc so that anyone moving up and using
this as a module won't have to change config or their module loading
if they're not autoloading modules.

> I didn't check all the details, but assuming that this is a split
> without further changes it looks ok to me.
> 
> Best regards
> Uwe
> 

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius

https://www.codethink.co.uk/privacy.html

