Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 661CE78B263
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 15:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjH1N5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 09:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230506AbjH1N4n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 09:56:43 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0BC9C0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 06:56:40 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qacjM-0007Hz-Rt; Mon, 28 Aug 2023 15:56:36 +0200
Message-ID: <f891bb06-4fc6-7b4b-464d-50235c1cff48@pengutronix.de>
Date:   Mon, 28 Aug 2023 15:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
Subject: Re: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
To:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     Alexander Stein <alexander.stein@ew.tq-group.com>,
        Bough Chen <haibo.chen@nxp.com>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>
References: <20230506085928.933737-1-haibo.chen@nxp.com>
 <DB7PR04MB40102AA686099ED666C93EF5901EA@DB7PR04MB4010.eurprd04.prod.outlook.com>
 <CACRpkdZ-2Lyk_c8EJfS=YHK81wt2RAWnZAg+vxvZZijYFwmDDA@mail.gmail.com>
 <12270129.O9o76ZdvQC@steina-w>
 <CACRpkdZc8H=bnTfLjUzMS3zEWGTZdHbSuBz0yf_wdfp9MkNnkQ@mail.gmail.com>
 <CAMRc=MfBDBrd1C9tOUcu_+eocB-xXt26fBDLSUNFyos2d6E15w@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAMRc=MfBDBrd1C9tOUcu_+eocB-xXt26fBDLSUNFyos2d6E15w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Cc += i.MX maintainers as this file isn't matched by the MAINTAINERS entry.

On 21.08.23 14:17, Bartosz Golaszewski wrote:
> On Mon, Aug 21, 2023 at 12:21 PM Linus Walleij <linus.walleij@linaro.org> wrote:
>>
>> On Mon, Aug 21, 2023 at 9:44 AM Alexander Stein
>> <alexander.stein@ew.tq-group.com> wrote:
>>> Am Montag, 21. August 2023, 09:25:54 CEST schrieb Linus Walleij:
>>>> On Mon, Aug 21, 2023 at 4:47 AM Bough Chen <haibo.chen@nxp.com> wrote:> > Hi
>>> Linus and Bartosz,
>>>>>
>>>>> For this patch, still not in the main trunk (Linux 6.5-rc7) and
>>>>> linux-next(next-20230818). Can you help apply or any comment?
>>>>
>>>> As pointed out by Bartosz you cannot just mechanically switch the base
>>>> to -1.
>>>>
>>>> You also need to convince us that this doesn't break any systems, and if
>>>> it does, fix them so they don't break before submitting this patch.
>>>
>>> I think it's hard to tell if something breaks, this driver is used in a lot of
>>> boards. AFAIR some people are relying on the assumption of fixed order. Using
>>> dynamic allocation this not ensured. A possible fix is to use aliases [1].
>>
>> Hm I might have been to grumpy!
>>
>> It looks like any boardfiles using gpio-mxc have been eliminated
>> so this driver is now only used in device tree-boots? Right?
>>
>> Then I feel a lot better about it.
>>
>> Acked-by: Linus Walleij <linus.walleij@linaro.org>
>>
>> Yours,
>> Linus Walleij
> 
> I will not be queueing it for v6.6 as merge window opens in a week, I
> want to give it more time in next and see if anyone complains so it'll
> make it for v6.7.

IMO, this should not be merged. I would hate to do a kernel update and
see the kernel toggle some unrelated GPIO, because probe order changes.
This will eventually happen to somebody and if they're unlucky, it will
break something.

For systems, where the order was never fixed, I agree it's on them, but
for i.MX, it has been fixed since inception AFAIK and I fail to see
what strong reason there is to justify breaking their setups in such
a manner.

Yes, the sysfs interface will eventually go away and fixed numbering
with it but that has been announced long in advance and when that happens,
updated systems with legacy scripts will cease to do GPIO until fixed
and not essentially toggling GPIOs at random.

Thanks,
Ahmad

> 
> Bart

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |


