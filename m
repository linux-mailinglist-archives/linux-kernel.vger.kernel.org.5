Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19A8790309
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 22:59:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350762AbjIAU7a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 16:59:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229866AbjIAU73 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 16:59:29 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77CB3CC;
        Fri,  1 Sep 2023 13:59:25 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id E8E4A8657B;
        Fri,  1 Sep 2023 22:59:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1693601962;
        bh=9odOAZuqxqO3GhfS6yAgN5dZud26TQQRpQz8qJzUt3Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=I+ivvHeYkjFe1Kpu8pWMoIthhgR77ENC6LgA+fvAI2PslskRiSX6QdzjBygV0uXBG
         nkKapZ7ZfetcqKv46aQ7mKPhn7Oo3BwlI0v7b/RGn0L7ez6qcFnsq0O2qsLh4XmL/Z
         9QBwM3CnnPj86KskMIa64mgyMSNnYpbCWd97NVeYzEXejm37bBzo0SqRCALPHpdIM+
         Q2pR2shH6Xnl73f//upYtJqfRSIiCIW/wjHJynIuCe3tj3ZuBhDDVwEhgQO0XfxA3s
         CsIDA2CT5CZHouZU/WapAkdjuJ1pDC7uklVaulX3ZeHvCpBYXvXU4i3QhG1pBMzKvb
         YtQgA2q/rvDrw==
Message-ID: <2cbf879d-8052-29e4-5f2a-40a6562dc4b4@denx.de>
Date:   Fri, 1 Sep 2023 22:59:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] watchdog: stm32_iwdg: Add pretimeout support
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     linux-arm-kernel@lists.infradead.org,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Antonio Borneo <antonio.borneo@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-watchdog@vger.kernel.org
References: <20230517194349.105745-1-marex@denx.de>
 <20230517194349.105745-2-marex@denx.de>
 <ba596dd5-e9b9-4972-a768-e42e69897fea@roeck-us.net>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <ba596dd5-e9b9-4972-a768-e42e69897fea@roeck-us.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/6/23 16:19, Guenter Roeck wrote:
> On Wed, May 17, 2023 at 09:43:48PM +0200, Marek Vasut wrote:
>> The STM32MP15xx IWDG adds registers which permit this IP to generate
>> pretimeout interrupt. This interrupt can also be used to wake the CPU
>> from suspend. Implement support for generating this interrupt and let
>> userspace configure the pretimeout. In case the pretimeout is not
>> configured by user, set pretimeout to half of the WDT timeout cycle.

[...]

>>   static int stm32_iwdg_probe(struct platform_device *pdev)
>>   {
>>   	struct device *dev = &pdev->dev;
>> @@ -253,6 +340,11 @@ static int stm32_iwdg_probe(struct platform_device *pdev)
>>   	wdd->max_hw_heartbeat_ms = ((RLR_MAX + 1) * wdt->data->max_prescaler *
>>   				    1000) / wdt->rate;
>>   
>> +	/* Initialize IRQ, this might override wdd->info, hence it is here. */
>> +	ret = stm32_iwdg_irq_init(pdev, wdt);
>> +	if (ret)
>> +		return ret;
>> +
> 
> What if the interrupt fires for whatever reason and the watchdog
> isn't registered yet and the driver data is not set and the
> watchdog core doesn't know about the watchdog ?

That cannot happen since the pretimeout IRQ was not configured yet.
That can only happen once the core is aware of the WDT and calls 
set_pretimeout .
