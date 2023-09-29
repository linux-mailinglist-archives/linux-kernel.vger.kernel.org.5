Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C41A07B325A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:21:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbjI2MVy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:21:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232490AbjI2MVx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:21:53 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74247DB;
        Fri, 29 Sep 2023 05:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695990078; x=1696594878; i=linosanfilippo@gmx.de;
 bh=6tA43t+0McW2N+YumW2QFVQxDcUMGT+JFpeDldo/TWU=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=Sz/VIzyGecB4r1WZcdaaq3iWtCgH05hqHwAKbs1Y0PvJS4G4M8BkjK2GLAhhsT5iyzCM+tCPhw+
 nIZ1NQIjj0hPsB3KrrSEzb53lIweH1j9QGkECiFTEQnF4MbM9hVPklSRfHKJVLHQ9ITu/mUV3LNEG
 vxlk9RZgwXlPs7FxcksCAjtm2z0bpAwOpifX2Em4/PQz/509hXvPht2GD21+hFKrhqXSVsn6IBrap
 uzyxX+uoSoRpAOrXAw0YxG6ZH3zC208Eq7YL/Is7wkwLiY7DddEHcsSqLezlmmZFg/xDgdshdgNSP
 r3w02wYF+w83GirMRyASzLs6LmcOD9QPCocg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MRCOE-1qyFj80fe0-00NDWK; Fri, 29
 Sep 2023 14:21:18 +0200
Message-ID: <a3ff9fad-4939-bf94-4f92-c2072bc3955b@gmx.de>
Date:   Fri, 29 Sep 2023 14:21:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 1/6] serial: Do not hold the port lock when setting
 rx-during-tx GPIO
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     jirislaby@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, l.sanfilippo@kunbus.com,
        lukas@wunner.de, p.rosenberger@kunbus.com, stable@vger.kernel.org
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-2-LinoSanfilippo@gmx.de>
 <2023092906-untainted-entangled-4d17@gregkh>
Content-Language: en-US
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <2023092906-untainted-entangled-4d17@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:6NnLCV4rQAXsipSpGiNlG5Iy3kiV5k1mK5GvR/Lt8U4qzsviCmC
 wciUdaP979o62SspPQThVJe0sNDG1bLHMEXDRTe7A9MVGYYZAMsd7AZhqoN1eNY/tyNIHer
 AkmgOFzkD/sDcnCD5Djvx10cmnxarHtY3kTjzWOK2P/liLlfKl6lNtV3KudQhQO64r8sw/0
 DrgnaJg8oad2CUpDVly2w==
UI-OutboundReport: notjunk:1;M01:P0:7qz8JAbq7I4=;ZTl02IzFRSn26NlMNPUe2SD2M8l
 D3CLrHge81T0pi08lBI2JIijTrR9mIt1LRwpwnNTx2ySfzuRyB5vWPV1PFjdKOoDb5VSXAo99
 +pqm7cMdRQeSnAJR6v4M7FHc3gVaxnI3bIzBCrXFe+d5gHcYFoLmcZluZrvCA75Xts57ry71q
 na5kh9luUqOlDBm6LzB0c1+dvSVkWyS/njlBtZ30tPJA9lPv6RFF4+LSuSzEcRRgGGR28Sd+y
 GpRkwDakJJIsQ4eDsMXX0vLdhtW5BVOSY1xHXb4dxuZkKCBbWJ5ZM+GZrBpZQcbjtHwJs/b+c
 9sfbx352OczoNp5zo9DaRgcV8zFCfvCCtbmXBisO4HFskGO+BYrljFc9czUt0iZIpJCdvTxUd
 XlN9qxxknMzmLMr0ENyOmThQk8Qu+snb7CSCLAE8uQbmRlyuvjijPRe7Naruc6/RxGY/VH4fb
 CPCQfL7x7WxBGt7FlIQxsDFklJ1ONw96s5mmirBArySusMPDfQMSNKKyCZ9rp/hvpr/OfNZZw
 BlK2Vke6gQX0NHbvsNmI7Nc/hvQRwxqbiEIYsTGa6dExwPNzS284Y27Xha2+L9/Ae9jeRcDS/
 scxnkdUoOzDNylsXyd7KMh8tYSjRYb/L2gcUq7QDOKKIxsEA+VZxy2m+F2D+TIJaVnaqCFvcj
 9NxJbfHb/cgDxMjzQ8ZZtMev772sZSkpO6zbSxv9S1X3aFC452LPo0wvVmDoNLwRSeIgde2Fn
 rcnYGyIvCxO+k7d/v1hR7F1Je1xBBZl/7zsGAsSt6ALmm0j2fcXquECATOlqaEX2qrNcPr7+M
 8K7h/J+m5AaUiEsdV4BvDq3A3zIBWDflvWJ/LR+wUYd4gxyYp71WZtiv9SsRV+rf9kY7+b0Ou
 t0DpX/0roRV6sNSyrecEFwlnlbS1AThRtl/A4XBycHfLkQEdfsDGyJcyG+WQUQzVKYGPFM7vc
 LNZpy+Cbh5tT1+X38Z+mWCE3dQo=
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29.09.23 07:50, Greg KH wrote:
> On Fri, Sep 29, 2023 at 12:12:41AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> Both the imx and stm32 driver set the rx-during-tx GPIO in the
>> rs485_config() function by means of gpiod_set_value(). Since rs485_conf=
ig()
>> is called with the port lock held, this can be an problem in case that
>> setting the GPIO line can sleep (e.g. if a GPIO expander is used which =
is
>> connected via SPI or I2C).
>>
>> Avoid this issue by setting the GPIO outside of the port lock in the se=
rial
>> core and by using gpiod_set_value_cansleep() instead of gpiod_set_value=
().
>>
>> Since now both the term and the rx-during-tx GPIO are set within the se=
rial
>> core use a common function uart_set_rs485_gpios() to set both.
>>
>> With moving it into the serial core setting the rx-during-tx GPIO is no=
w
>> automatically done for all drivers that support such a GPIO.
>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> You cc: stable on many of these, but do not provide a "Fixes:" tag
> showing just how far back they should go.  Can you do that so that we
> have a hint as to what to do here?
>

Yes, will do so in the next version.

BR,
Lino

> thanks,
>
> greg k-h
