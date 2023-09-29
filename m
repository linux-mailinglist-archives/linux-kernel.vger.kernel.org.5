Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0207B33F9
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 15:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233425AbjI2NrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 09:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233379AbjI2NrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 09:47:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 040841AB;
        Fri, 29 Sep 2023 06:47:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1695995214; x=1696600014; i=linosanfilippo@gmx.de;
 bh=J9h1C7mMFFEVucuVuABa2VPJxriIZ+QMbDLSt604QAg=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
 b=LuVwkCVxShKxpuVmfK2vh1MpnI1xEN19lVRaYia7LPuKiQQGvQO95BSukEVdStfW6744og1rgIt
 B0X6pbqEDkT9XUop8DUy8a9UxUha+Cwgt0HhCne6ibLiDH37N9Pc3+9B1Q0AHSSOgr1yiJGGlq6pB
 +iFQvGPAIDdW9QNlCyNQpR2etxO0d3omIyFb6JF3JhrhIfnOr9GIT09UAdfhrVbJV1AR9mBlXTGkj
 xtNbME8tHXpdSV2B/iOGn/KeI2kBMK7F2WQD5iVLlvCfPBqVVwciROgGVN9nCd8/UPUUDQGXY6TIh
 tJi3i5auLGJGLBqK3dU6YN4TdopHFpKPYYhw==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.2.42] ([84.162.21.41]) by mail.gmx.net (mrgmx005
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1Mi2Jn-1rH8jn2bw1-00e3S7; Fri, 29
 Sep 2023 15:46:54 +0200
Message-ID: <8fac0a79-cf0b-f35b-4e5e-e8f502bb5367@gmx.de>
Date:   Fri, 29 Sep 2023 15:46:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: [PATCH 6/6] serial: imx: do not set RS485 enabled if it is not
 supported
Content-Language: en-US
To:     =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
Cc:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de,
        ilpo.jarvinen@linux.intel.com, mcoquelin.stm32@gmail.com,
        alexandre.torgue@foss.st.com, linux-kernel@vger.kernel.org,
        linux-serial@vger.kernel.org, lukas@wunner.de,
        p.rosenberger@kunbus.com
References: <20230928221246.13689-1-LinoSanfilippo@gmx.de>
 <20230928221246.13689-7-LinoSanfilippo@gmx.de>
 <20230929063942.qukemr4o7l5vdmud@pengutronix.de>
From:   Lino Sanfilippo <LinoSanfilippo@gmx.de>
In-Reply-To: <20230929063942.qukemr4o7l5vdmud@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:VwXiyU2/W3O+MjSrCdfcHxCMWlRBcReFiYSjXHVBs3fR1SpPLUA
 xgSQy2vr5a5a4wFI0AGsENjTxU7xo3lu5oMEH1X4mtWssGCL9d2LCJ/o3MB8ghZcZeJaSEs
 2qxxyfCuc+EIebFakAoRHr6bU1YiStSlagDhHh3VOHqeh+edoaSzXNIwyAUfDJWwzLs3wCx
 06Ajeu48JzN6aSrZwOjAw==
UI-OutboundReport: notjunk:1;M01:P0:HXJNl3SCBe8=;pARrZ1ytb8liKtVw9iNoI01cxPG
 I91ucI+TF92KhiXUVhQanCVdSVGK182fzBDki6OP5hJibVztMGuiSNITuig/ouJmp6K0L2B8R
 3GLUvAutC7TrcZRptEkRuAjTyjfJCX2814f4iMcVLO3beUnaHpTmdkWmk44dc16FxzyxFKCnM
 Bqvo6y6i41IEhTDajfaR6broL/g9Pp7fXIxiMJUGm7/SC8U87HKXMtO8I8HGpALRuEQpDO+I1
 cbj24ZI6HieWxoZr08CJIQlt6Cnun5E6oHRkBICUr/giLtW57BLzoT63su33CT6Hb1feBuZ+5
 wG74m2ocKdNcHHNuexC3zmtkeuQHaS2iu3XRxx1CxHUGK3HnChifBb2P2Pusk/0K0A2UUPUqf
 n/I2xKeX2jCizF3tEM8johM4cSFV10/oPLXG6kcglMNVkqEYBBCKY/RzMuRqfU88HdqkUUx5u
 I2dyJeegDk7tG5/P5EGuo/x7+Q/00e1N+LiKywwXe789fH0RippyZpS2gymGY7qxYtUVfL+LS
 gNX5AUOA96xozg155Px9ahwZIjsGt2VR4qUay0Q8BphlRtL1lQEj/GOwqtrIs4RSapOX9L5c7
 hfhzhEs2kxc3HsYachhxJDpfVbtcLfkqpeoS8iGObLzeT0VNlpDhdXzpKv6ZR3YDcJaGQXpcy
 X598g87P2KgXnA9j7m9lbMxt37VGbILtcS6ghGpCXG/SI9wXoDj0QryEnT2KwDNhi0wbCGXh0
 A1LT7Nr7rHCcb8gjC0M2sF4azwkEYFp7ds4ft925SRIEwZhI0vswLkFbGzwV7jFEn3+xj+woL
 m46qsy6vuHs8u5gyWeLCvoOaLX4SQWSvR08lrbC42zVlsSpK4rIH0fzoWqnohiAYCCZ5EK4cG
 ZkccQe7ey2s9omyGCLBHrPDWehb6/XuweUGsCa2rEsSGVo6+a0QST/HYUvxlV9maxaodmCrsU
 8YHg0A==
X-Spam-Status: No, score=-6.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29.09.23 08:39, Uwe Kleine-K=C3=B6nig wrote:
> On Fri, Sep 29, 2023 at 12:12:46AM +0200, Lino Sanfilippo wrote:
>> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>>
>> If the imx driver cannot support RS485 it sets the UARTS rs485_supporte=
d
>> structure to NULL. But it still calls uart_get_rs485_mode() which may s=
et
>> the RS485_ENABLED flag.
>> The flag however is evaluated by the serial core in uart_configure_port=
()
>
> I wonder if this is the code location where this problem should be
> addressed. Or alternatively don't let uart_get_rs485_mode() set
> RS485_ENABLED (and other flags) if rs485_supported doesn't suggest that
> this works?
>

This is indeed the better solution. Especially since the check is then in =
the serial
core and all RS485 supporting drivers benefit from it. I will change this =
for v2, thanks!


>> [...]
>>
>> Signed-off-by: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> I don't know how picky Greg is here, but formally you missed to add an
> S-o-b line for the sender of this patch (i.e. you with your gmx
> address).
>

Hm, until now there have never been complaints about this. Is this really =
an issue? Of
course I can also S-o-b with my gmx address but adding two S-o-b's for the=
 same person seems
a bit odd to me...

BR,
Lino

> Best regards
> Uwe
>



