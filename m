Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7537BC90B
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Oct 2023 18:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344048AbjJGQTi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Oct 2023 12:19:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343992AbjJGQTh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Oct 2023 12:19:37 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.17.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB28FB9
        for <linux-kernel@vger.kernel.org>; Sat,  7 Oct 2023 09:19:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1696695560; x=1697300360; i=rwahl@gmx.de;
 bh=93DYVf1yCwkIdRXZcNcaH5+Q8KqaWlmybM4iXunz/4Y=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
 b=nuIB6IORyAu84HV+OShUnMutEfV7y8TeZ00qpt6i0UTFG6m397fgksgmLpPD0GI+wA3NB9PaLOP
 IfJ/kZJggPzzsfWRF9LCWlf1bxYXcksb3k8SVCM20IRwqCRqbfIoOEQ54+1y2HxEoukv4iP+9TRqJ
 h7rkaK0MtIyh8Wn22RrXxyDTrDZa8PFhkOSqnb16mPpzX4pSJE8RiZfE+Q4cg3acfAzNemkRldx8O
 SWIvW29t8ru9lMkNAL1MojnuoMTxZzdryOD1/ccJ24W5zcmrUyb9oX1QyfsrOokmEjpVEKn5LsQgO
 MpaoOHlGiRm0daTZIZJGws+aEyQWsQBLB6Ng==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M42jQ-1qpA1Q2BrE-0007R5; Sat, 07
 Oct 2023 18:19:20 +0200
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Claudiu Beznea <claudiu.beznea@tuxon.dev>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [RESEND][PATCH] clocksource/drivers/timer-atmel-tcb: Fix initialization on SAM9 hardware
Date:   Sat,  7 Oct 2023 18:17:13 +0200
Message-ID: <20231007161803.31342-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:Pf71VKP20VvfnfjcJDyxmiK8f8FTuxb1UKYl78xlYINdgzMJii2
 9le9mN0x86NDzVlwLBPz/dtr7jA7DU3WnRq2JqXKhPlTgsQiJSFDSI7/3FrCajc5mevd/DB
 ZcWPTZk92m8/aGQUhGNEX1LI+D+4cyw1RCmbuSGF7ctF/+H6XPTLAlZSl0Dsmo37UmYGdwu
 2eW9hh4gK7yYGZqyW7XyA==
UI-OutboundReport: notjunk:1;M01:P0:L5gKoZKqLtk=;rc6G9NMwQG9MeNo1Y2Sax1l0i/Y
 Dk0hU/0jrWlGHSayQZK1qXHc8wF0kmMD42ORp3/skM6nkbJLk6nngnu/UquXZV9C+qE7+6PKZ
 mXy1G5L1vFwd57Qx/RhuBL3E+f6HSH1auG0o93tew14GV19SeZV5+8LnT3uFQbKHgKK71dngW
 ws6RbXQtULauHt/QY3gywpIy1JTMvAjkPtnhuDz0Xgy3GTLusKP6OO7QTclrdm4YbOZXjvevJ
 N+XxXTJ6KVoiqi/Bec5J/42uLifLupBThtclzoUmmQghIwmopTisLtDPcQ/1rTYG3yfcFi7js
 ppzzvP5QX2BOZw57qEyOUNTBSXcI+lGy1lqzoRpSGIOk1vZfGTVbvvpWgs3jboCyzbNHb2VgT
 e/y1TvmvVigqMxAINEvmq+8TbdgAv9p3hcnhSSPrjpC4jlUhGOLYXfaA2AINWu0WCtXmQxE6U
 ska8Xrx18/d9A2z7sIL0eZEPmISWKeBie0lO+s6vuZexm76I0eAadusmv7eTjT45bjX2MjPw+
 18Ey8BIQWF+T+CK5JUaDezB/yUEoXyDKFong5VxhDBwUSdg3nggt1PqPZrf78hqQlxKPCg2IN
 2Mh0OdHQm0TH1pdOen95G5p+zvLcvn5ZT/DscGMvdeeOhTR7JuoABFWOaHxfZfBeurRoj8UAe
 qnp6aWKIt6hNP8FPvG9Atq+BMLOUltYq5gwihD/Vn4A/TK80QrXbsAMfme53D/aM1hU803f+b
 M4ZYj+t1sX0aMMPzdDYncyj016mZtELC2JwhwgYYTlVdS6N2sZdnVk6mpxGS7kzXujvuyFJ6D
 wJE3gqlGfWxdUe9HP3HUC28ib6Z/1DzOZVnk3ZPQszdhxParWI4eJ6Bi2zeRfAGy87aXfX+3C
 MFMePwtDyKunl+SiKTWFvgmp/9lF6mHPnTQDCj238oe7QvxWPcOaCLRiAVQiEb4wZrOVKrrOV
 xll+4g==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Wahl <ronald.wahl@raritan.com>

On SAM9 hardware two cascaded 16 bit timers are used to form a 32 bit
high resolution timer that is used as scheduler clock when the kernel
has been configured that way (CONFIG_ATMEL_CLOCKSOURCE_TCB).

The driver initially triggers a reset-to-zero of the two timers but this
reset is only performed on the next rising clock. For the first timer
this is ok - it will be in the next 60ns (16MHz clock). For the chained
second timer this will only happen after the first timer overflows, i.e.
after 2^16 clocks (~4ms with a 16MHz clock). So with other words the
scheduler clock resets to 0 after the first 2^16 clock cycles.

It looks like that the scheduler does not like this and behaves wrongly
over its lifetime, e.g. some tasks are scheduled with a long delay. Why
that is and if there are additional requirements for this behaviour has
not been further analysed.

There is a simple fix for resetting the second timer as well when the
first timer is reset and this is to set the ATMEL_TC_ASWTRG_SET bit in
the Channel Mode register (CMR) of the first timer. This will also rise
the TIOA line (clock input of the second timer) when a software trigger
respective SYNC is issued.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/clocksource/timer-atmel-tcb.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-atmel-tcb.c b/drivers/clocksource/t=
imer-atmel-tcb.c
index 27af17c99590..2a90c92a9182 100644
=2D-- a/drivers/clocksource/timer-atmel-tcb.c
+++ b/drivers/clocksource/timer-atmel-tcb.c
@@ -315,6 +315,7 @@ static void __init tcb_setup_dual_chan(struct atmel_tc=
 *tc, int mck_divisor_idx)
 	writel(mck_divisor_idx			/* likely divide-by-8 */
 			| ATMEL_TC_WAVE
 			| ATMEL_TC_WAVESEL_UP		/* free-run */
+			| ATMEL_TC_ASWTRG_SET		/* TIOA0 rises at software trigger */
 			| ATMEL_TC_ACPA_SET		/* TIOA0 rises at 0 */
 			| ATMEL_TC_ACPC_CLEAR,		/* (duty cycle 50%) */
 			tcaddr + ATMEL_TC_REG(0, CMR));
=2D-
2.41.0

