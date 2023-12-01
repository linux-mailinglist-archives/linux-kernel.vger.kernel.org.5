Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA31A800160
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 03:04:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjLACEI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 21:04:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229523AbjLACEH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 21:04:07 -0500
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22DC9F4
        for <linux-kernel@vger.kernel.org>; Thu, 30 Nov 2023 18:04:12 -0800 (PST)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.whiteo.stw.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1r8ssr-0002h2-N1; Fri, 01 Dec 2023 03:04:01 +0100
Message-ID: <5e8f42f8-2b03-4033-b6d2-9b3139f081d5@pengutronix.de>
Date:   Fri, 1 Dec 2023 03:03:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/2] arm64: boot: Support Flat Image Tree
Content-Language: en-US
To:     Simon Glass <sjg@chromium.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Tom Rini <trini@konsulko.com>,
        lkml <linux-kernel@vger.kernel.org>,
        U-Boot Mailing List <u-boot@lists.denx.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Terrell <terrelln@fb.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Will Deacon <will@kernel.org>, linux-kbuild@vger.kernel.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20231129172200.430674-1-sjg@chromium.org>
 <20231129172200.430674-3-sjg@chromium.org>
 <30f32467-51ea-47de-a272-38e074f4060b@pengutronix.de>
 <CAPnjgZ25xoXsi74XYY0E8ucQiowQqPdZgUHrfVNAYWKZEYODHg@mail.gmail.com>
 <875f0dbc-1d78-4901-91b2-6ad152bcea5a@pengutronix.de>
 <CAPnjgZ0UCkm5QCx+JXe1ggSshozPnOLB6cN=UoJyMn6S4wfFkg@mail.gmail.com>
 <06281f7c-e0f2-405c-95a9-0f7e9e84a7f6@pengutronix.de>
 <CAPnjgZ2TT+0BvbjwfnGLQ3EPEXnLW6f1epiFdaBHRYaSAn5xsA@mail.gmail.com>
 <8fbc81b1-31ab-46b0-87f4-b8bd8e8e2b47@pengutronix.de>
 <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <CAPnjgZ1iyxk0bb56QR10N5aSphRYhLsw7Ly=z2i6rQCxP_AYPw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Simon,

On 30.11.23 21:30, Simon Glass wrote:
> On Wed, 29 Nov 2023 at 12:54, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>> On 29.11.23 20:44, Simon Glass wrote:
>>> On Wed, 29 Nov 2023 at 12:33, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>
>>>> On 29.11.23 20:27, Simon Glass wrote:
>>>>> On Wed, 29 Nov 2023 at 12:15, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>>> On 29.11.23 20:02, Simon Glass wrote:
>>>>>>> On Wed, 29 Nov 2023 at 11:59, Ahmad Fatoum <a.fatoum@pengutronix.de> wrote:
>>>>>>>> The specification says that this is the root U-Boot compatible,
>>>>>>>> which I presume to mean the top-level compatible, which makes sense to me.
>>>>>>>>
>>>>>>>> The code here though adds all compatible strings from the device tree though,
>>>>>>>> is this intended?
>>>>>>>
>>>>>>> Yes, since it saves needing to read in each DT just to get the
>>>>>>> compatible stringlist.
>>>>>>
>>>>>> The spec reads as if only one string (root) is supposed to be in the list.
>>>>>> The script adds all compatibles though. This is not really useful as a bootloader
>>>>>> that's compatible with e.g. fsl,imx8mm would just take the first device tree
>>>>>> with that SoC, which is most likely to be wrong. It would be better to just
>>>>>> specify the top-level compatible, so the bootloader fails instead of taking
>>>>>> the first DT it finds.
>>>>>
>>>>> We do need to have a list, since we have to support different board revs, etc.
>>>>
>>>> Can you give me an example? The way I see it, a bootloader with
>>>> compatible "vendor,board" and a FIT with configuration with compatibles:
>>>>
>>>>   "vendor,board-rev-a", "vendor,board"
>>>>   "vendor,board-rev-b", "vendor,board"
>>>>
>>>> would just result in the bootloader booting the first configuration, even if
>>>> the device is actually rev-b.
>>>
>>> You need to find the best match, not just any match. This is
>>> documented in the function comment for fit_conf_find_compat().
>>
>> In my above example, both configuration are equally good.
>> Can you give me an example where it makes sense to have multiple
>> compatibles automatically extracted from the device tree compatible?
>>
>> The way I see it having more than one compatible here just has
>> downsides.
> 
> I don't have an example to hand, but this is the required mechanism of
> FIT. This feature has been in place for many years and is used by
> ChromeOS, at least.

I see the utility of a FIT configuration with

    compatible = "vendor,board-rev-a", "vendor,board-rev-b";

I fail to see a utility for a configuration with

    compatible = "vendor,board", "vendor,SoM", "vendor,SoC";

Any configuration that ends up being booted because "vendor,SoC" was matched is
most likely doomed to fail. Therefore, I would suggest that only the top level
configuration is written into the FIT configurations automatically.

Cheers,
Ahmad

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

