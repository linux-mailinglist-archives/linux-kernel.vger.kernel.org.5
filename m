Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCC747C9497
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Oct 2023 14:23:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233200AbjJNMXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 Oct 2023 08:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjJNMXn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Oct 2023 08:23:43 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 385E6A2;
        Sat, 14 Oct 2023 05:23:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1697286197; x=1697890997; i=linosanfilippo@gmx.de;
 bh=kgDuOk3z1Ea4qWhQuI9kBo9177OQ8y0oXsIYIljyoes=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=baYtoi4D36rhBH1R75lao0TrIMwT7MSTlReTcTd2/u6L8ytG2F+iablgvpbkCkb2tr4ZMG3i4Ae
 zoRFLLXRReS87RU4+d+oOyfyfmBqXNzIjc6ZBkMY5up3TdND2RB1nI0HD4NiVRKzm50Imt8Y+6V5O
 t7/sBEG99IW/vUDYmDGRn7itTTCgjpm9j3PUID1vNyE9u/bc+4t7pKePjj4cF6IG9uiN7uKdu69ci
 Xoz6E/t/DRGuwNc6rREYMumcKbZN2JzoqStUQ2Io97u7WrX9Qr/NOE4yMug9iL50DbT7ip28y0emn
 Uv35oY/mHqsjdc1rLYQiWHZDrYHPcgn6m0Ew==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNt0C-1rBW0K3zlQ-00OFiE; Sat, 14
 Oct 2023 14:23:17 +0200
Message-ID: <b06c2fcd-02c0-464b-a7e8-4dfbf9e2befc@gmx.de>
Date:   Sat, 14 Oct 2023 14:23:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/6] serial: core: fix sanitizing check for RTS
 settings
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, cniedermaier@dh-electronics.com,
        LKML <linux-kernel@vger.kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        stable@vger.kernel.org
References: <20231011181544.7893-1-l.sanfilippo@kunbus.com>
 <20231011181544.7893-4-l.sanfilippo@kunbus.com>
 <40e4c6b1-e217-2926-a351-bf685a5b775f@linux.intel.com>
 <da9a9d10-2568-4960-b9f8-9d43cbc1b295@kunbus.com>
 <63b62f6c-d97d-8d45-1612-968ef74b6365@linux.intel.com>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <63b62f6c-d97d-8d45-1612-968ef74b6365@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:CHN2pNHaAkw0ZESaLnuGgSm6m6EKCzvkaP3fYPHWXDJPm8blbaR
 1SvWzi/huJIP50I3EY9CvPuSJF5a/GqlaIgxjbqZENub4y/aumnjrINqe0hIuWCyVXJY7oZ
 yOY1HGek1NFehYlgQGEwF2lwzPtjeTaDp7m7tQNyO09UvstSh7VuHqR3jh6GqDbH2ck3QB2
 zzuOqMfk8QVZxIY59kaFw==
UI-OutboundReport: notjunk:1;M01:P0:smEzDPWVI2Y=;uVqFcyRNYsaSTA4KRKzG75nbiRu
 nd1nafhYNxCBNLPACMbRf+9R/FLLTAZQ5F4MoZdZd1HRhhqRj7Vt273DeMpVMI9ki3nOrTYMG
 MrxUpjxN18lZXMG6sVvn80fPyaGlXNnYQbSEcUG++tPCK/apPzRYdHGuI7UB5Q4VstgMwFDUJ
 VAnt/LjiGbclPxP2LBKPH646RpovSaoQf6iOq9eWDrVTRlT529qA9NwfrrMZxhxB39r4WcI5E
 Bzoni88qhfA19p60Eg/XGbHoxRZ00yp0oILbUI7umFVQ9tuyhOaPEcc7paQN4j/bo0T//pdhO
 mGCT2gYkT6cJvY0ZCUyX97fH9zO8O8e4P9t4CxhMNzi3QZPw8fzZwiBhZhME/i0Ld2/r/lHCK
 T2bhAJ7cqzTyY2Gau3x+9znO1Pw9nlBMCCuR9bbJRv48PzAzm51k+z2WjbYd+HuThyc1G6u9s
 9ekFjOdoDvBwVj9c5G4HUb9u2SWxz6mImws3r0gBiQnXJkKYF+6c+1pQmHzKXtmFBa4mQ7pCi
 LKASlxHgHvOW0c/I3jaqRZQcsbCP41/psTBENAOYD3wLZbRf3bY4v2biXjhqfxu7i3w6Yr8Ls
 9DffQeuauvy2rYhqQ4yhxa/BI2NY1WBSJhIdYbKy5sp4Y250dLcHj//Q1q7fGotTk5STOTVGM
 HxUM5fzncxHDtjSPZ3MGkOSjBySFS7wrqlW+5XjqfojOFWBlQA0E6LAicC5DjQ4naqPd9SnoF
 fguYsJmCAapR19oz7Hay1PanBq7US/gr55zeYkBtbgaErRpKaogSWUBOj+0nQdD8Ck93+xIEN
 PGQzuSWiUeRVfceo7e4V2s1kMeDC+G8m+y/ewJ8LivnpTayJcu6WZuxI03+oXik07ld7KeSSo
 BvQPY8E2ztyv7N2pUdeMrsfM+co9C74UYeGsJq5cpD/3YtM3JRaUNhVB2ao3stoGbiadWRXK/
 C4upYg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ilpo,

On 13.10.23 12:24, Ilpo J=C3=A4rvinen wrote:
> On Thu, 12 Oct 2023, Lino Sanfilippo wrote:
>> On 12.10.23 15:10, Ilpo J=C3=A4rvinen wrote:
>>> On Wed, 11 Oct 2023, Lino Sanfilippo wrote:
>>>
>>>> Among other things uart_sanitize_serial_rs485() tests the sanity of t=
he RTS
>>>> settings in a RS485 configuration that has been passed by userspace.
>>>> If RTS-on-send and RTS-after-send are both set or unset the configura=
tion
>>>> is adjusted and RTS-after-send is disabled and RTS-on-send enabled.
>>>>
>>>> This however makes only sense if both RTS modes are actually supporte=
d by
>>>> the driver.
>>>>
>>>> With commit be2e2cb1d281 ("serial: Sanitize rs485_struct") the code d=
oes
>>>> take the driver support into account but only checks if one of both R=
TS
>>>> modes are supported. This may lead to the errorneous result of RTS-on=
-send
>>>> being set even if only RTS-after-send is supported.
>>>>
>>>> Fix this by changing the implemented logic: First clear all unsupport=
ed
>>>> flags in the RS485 configuration, then adjust an invalid RTS setting =
by
>>>> taking into account which RTS mode is supported.
>>>>
>>>> Cc: stable@vger.kernel.org
>>>> Fixes: be2e2cb1d281 ("serial: Sanitize rs485_struct")
>>>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>>> ---
>>>>  drivers/tty/serial/serial_core.c | 28 ++++++++++++++++++----------
>>>>  1 file changed, 18 insertions(+), 10 deletions(-)
>>>>
>>>> diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/se=
rial_core.c
>>>> index 697c36dc7ec8..f4feebf8200f 100644
>>>> --- a/drivers/tty/serial/serial_core.c
>>>> +++ b/drivers/tty/serial/serial_core.c
>>>> @@ -1370,19 +1370,27 @@ static void uart_sanitize_serial_rs485(struct=
 uart_port *port, struct serial_rs4
>>>>               return;
>>>>       }
>>>>
>>>> +     rs485->flags &=3D supported_flags;
>>>> +
>>>>       /* Pick sane settings if the user hasn't */
>>>> -     if ((supported_flags & (SER_RS485_RTS_ON_SEND|SER_RS485_RTS_AFT=
ER_SEND)) &&
>>>> -         !(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
>>>> +     if (!(rs485->flags & SER_RS485_RTS_ON_SEND) =3D=3D
>>>>           !(rs485->flags & SER_RS485_RTS_AFTER_SEND)) {
>>>> -             dev_warn_ratelimited(port->dev,
>>>> -                     "%s (%d): invalid RTS setting, using RTS_ON_SEN=
D instead\n",
>>>> -                     port->name, port->line);
>>>> -             rs485->flags |=3D SER_RS485_RTS_ON_SEND;
>>>> -             rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>>>> -             supported_flags |=3D SER_RS485_RTS_ON_SEND|SER_RS485_RT=
S_AFTER_SEND;
>>>> -     }
>>>> +             if (supported_flags & SER_RS485_RTS_ON_SEND) {
>>>> +                     rs485->flags |=3D SER_RS485_RTS_ON_SEND;
>>>> +                     rs485->flags &=3D ~SER_RS485_RTS_AFTER_SEND;
>>>>
>>>> -     rs485->flags &=3D supported_flags;
>>>> +                     dev_warn_ratelimited(port->dev,
>>>> +                             "%s (%d): invalid RTS setting, using RT=
S_ON_SEND instead\n",
>>>> +                             port->name, port->line);
>>>> +             } else {
>>>> +                     rs485->flags |=3D SER_RS485_RTS_AFTER_SEND;
>>>> +                     rs485->flags &=3D ~SER_RS485_RTS_ON_SEND;
>>>
>>> So if neither of the flags is supported, what will happen? You might w=
ant
>>> add if after that else?
>>>
>>
>> I would consider this a bug in the driver, as at least one of both mode=
s
>> has to be supported. If the driver does not have at least one of both f=
lags
>> set in rs485_supported.flags we could print a warning though. Would you=
 prefer that?
>
> 8250_exar.c needs to fixed then?
I was taking these as things one can
> "configure" even if when there's support only for a one of them there's
> not that much to configure. As there was neither in 8250_exar's code, I
> didn't add either flag.

> But I suppose your interpretation of those flag makes more sense.
>

IMHO this is consistent with what we have in uart_get_rs485_mode(). This f=
unction
ensures that we have at least one RTS mode set (with default to RTS_ON_SEN=
D). So
concerning 8250_exar.c, I think it should be fixed (havent noticed the mis=
sing
RTS mode though until you mentioned it). Would you like to provide a fix f=
or this
or shall I include one into the next version of this series?


BR,
Lino
