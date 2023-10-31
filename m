Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E7F47DCD99
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 14:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344468AbjJaNND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 09:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344451AbjJaNNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 09:13:00 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6EF7DF;
        Tue, 31 Oct 2023 06:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
        t=1698757969; x=1699362769; i=rwahl@gmx.de;
        bh=DybnFajxEuPHd+61nGW7rQ4Cxy8DUD5XRFxh+JCVPts=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=o5gy8DVFaOmRSRh9u3hh2GhAhwvxlwIcvEMXFlUh9c799hPZK+OlvpsRNsnHKAEN
         e6lqgPQjWKARgKnc4VwdjW+oiTbRxrfEVnuTuvhhuNAxwXPpIGgQMm2u6RDoU3irD
         9pS3ITiMyTbksmKX3GwTstOJn+iUznWB+VnSriiHjABwjq0mSLopAe3BsPAFo2/Ji
         bBAOOvLiLtEco8aM6uufMm3h04E5oYk1cZVFL9NNwxDgIk/smeO/AkCP70IYT3EG2
         2hUEXkF3RAINsxEpAuQwxnH/+t8yUY/IJCf2Ey1P58Ebeux/O7BC1a+5oSVxe12bF
         IrD+hK+oYJylzzZ6VA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from rohan.localdomain ([84.156.147.134]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MNKhs-1qnGwc3VWs-00OmwH; Tue, 31
 Oct 2023 14:12:48 +0100
From:   Ronald Wahl <rwahl@gmx.de>
To:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Ronald Wahl <ronald.wahl@raritan.com>
Subject: [PATCH] serial: 8250_omap: Add earlycon support for the AM654 UART controller
Date:   Tue, 31 Oct 2023 14:12:42 +0100
Message-ID: <20231031131242.15516-1-rwahl@gmx.de>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:vVTJPTIGWlLkGSIShGQsFU14QTakS3wfHkFaWTQbogkd6trPrp3
 tsehEKEYuRmreqnYzIXfTYQsf21SiCymBSdOSJhiX0rNzttbjOtgGd5gYO6VDhNR30iqhjc
 32FGncr6B7PgtVl19BYHXcxsIkIUwVqW3+v7fkR+EpzOsRAxIZcDhj9k0eqnmW88a6Y5BJ7
 qOfziCM9kYD5eyVH0pKWw==
UI-OutboundReport: notjunk:1;M01:P0:xaL67cqQmNw=;LAwWpnZuak42V3kq/86EPZYcwV+
 xLzsydFX2kxA3hdeUJO25mJL3cM22juWhiyrOpUZ9OwWjIft0eS/ZEDqqcR+oS46W4gWUxWmp
 zQOuKGSRnBsDgSL/ey+FKgZkdYU+PlRxGf1pbCOU/WxMXNSBBeMBzvr5NCBmk0FwufSwwh4A3
 yjEFD3HWi7agToLyKNyC3EcKZDz1JzFbu+NUswzyXJGMnajJ9NY7YU2JwRp/TcP9e43QfnMzv
 6EBpkTdZew1T4RNAfx6mhRXDyV4b/hhdqxuqmYf9b33VtNBJft6sEmhQ6oue3s38uyutaoZya
 aj5krRAIFRxRKufDOshGI5jhxMKLXbxfmn4ARpYge5rgNxfEqN1+LK5mp2vMZin73jme+qufM
 XkeSmw5/9IRh8Bf/h0k0l6qNEREg3ApvRHvbu9c2IbGGaOz2XCzMwrqVGkK/fK3Dzzgzmz5pI
 Af+uJJ8Todrxlc1MFktFW2jm8sIxpbgolCC8qVS0ZPokoBAaxmSaRAbKsrjJICXEeMIq/zcYb
 Ht9F+NC+YnOx+1HKfhJX1CBEK6yi/MSCXfz8jCsVtQ27hJ4pH+sbTxduT1QYSM69v9gAJQQwy
 tI8qT5OWP0k8YXlQPmjv66BQOqL/DNT8bw+xtIwwQBt6OcCH26MugBO16E+IwnmfXfkpG4ZSb
 vwfC6ZBoh0AKNtlgW+iKrbc9SyjATEksisg1BCMNT1zyAPUV8CPctXqcCVACvb4t8EGR7PpE7
 B3AnmnoPeMuZKd9u+yrs5w9x+4qcuFK276Iity13u/cxA1ODwg/ECA8OypfhrApiUZzq81Knv
 dw
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ronald Wahl <ronald.wahl@raritan.com>

Currently there is no support for earlycon on the AM654 UART
controller. This commit adds it.

Signed-off-by: Ronald Wahl <ronald.wahl@raritan.com>
=2D--
 drivers/tty/serial/8250/8250_early.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/8250/8250_early.c b/drivers/tty/serial/825=
0/8250_early.c
index 9837a27739fd..e3f482fd3de4 100644
=2D-- a/drivers/tty/serial/8250/8250_early.c
+++ b/drivers/tty/serial/8250/8250_early.c
@@ -189,5 +189,6 @@ static int __init early_omap8250_setup(struct earlycon=
_device *device,
 OF_EARLYCON_DECLARE(omap8250, "ti,omap2-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap3-uart", early_omap8250_setup);
 OF_EARLYCON_DECLARE(omap8250, "ti,omap4-uart", early_omap8250_setup);
+OF_EARLYCON_DECLARE(omap8250, "ti,am654-uart", early_omap8250_setup);

 #endif
=2D-
2.41.0

