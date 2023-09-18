Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56BCE7A4A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Sep 2023 15:00:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242061AbjIRNAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Sep 2023 09:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242040AbjIRM7r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Sep 2023 08:59:47 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCCD1CD0
        for <linux-kernel@vger.kernel.org>; Mon, 18 Sep 2023 05:58:56 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 4B5066000A;
        Mon, 18 Sep 2023 12:58:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695041935;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oBXbmgI35Ay6iC6gwJK7LAKP2TjFS8/WQ3+OgmLbkxg=;
        b=eASqEhaQOxhMM0xv2JXtw7MYTf+HDpkUT/wk/+Zw2osl+qMPMkyzZBuIU/fQz2sxzOFFSB
        vw4pHo8+omK/W7OCuTiynmHRBXCLA2eMtZfsYVqWBApHNzFR2eRmnwhvaX37om4kZn18zp
        do4bZYwXanFr193bP8khG3YKXG/pTESP37eRX1wXmvHal4iM3Ykk1o4j/N9Mo0bi2Ipm7q
        0VjUEYkxTRTCcSSfqyB6/oLkoRiTTsQsIOTdNp6cPG+2/bla76DLjprJUCfuQTFUHWovy3
        shQNTgXsLQz2Z5H5lLacO45iqlp4Zs3Se/sMmIeDLp9NuM+6Ydv/h8zDyiaQmQ==
Date:   Mon, 18 Sep 2023 14:58:52 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Cc:     <nikita.shubin@maquefel.me>, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        Jean Delvare <jdelvare@suse.de>,
        Johan Jonker <jbx6244@gmail.com>, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>
Subject: Re: [PATCH v4 26/42] mtd: nand: add support for ts72xx
Message-ID: <20230918145852.46a15c77@xps-13>
In-Reply-To: <20230915-ep93xx-v4-26-a1d779dcec10@maquefel.me>
References: <20230915-ep93xx-v4-0-a1d779dcec10@maquefel.me>
        <20230915-ep93xx-v4-26-a1d779dcec10@maquefel.me>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Nikita,

devnull+nikita.shubin.maquefel.me@kernel.org wrote on Fri, 15 Sep 2023
11:11:08 +0300:

> From: Nikita Shubin <nikita.shubin@maquefel.me>
>=20
> Technologic Systems has it's own nand controller implementation in CPLD.

I initially agreed to accept a first version of this controller driver
with a legacy API because people were apparently under time pressure to
get this in. I see it's been a couple of months, so this is not that
urgent after all. As the driver is only 166 lines long, I would
strongly prefer a very straight ->exec_op() conversion in order to get
rid of these ugly direct I/O accesses.

Thanks,
Miqu=C3=A8l

> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
>  drivers/mtd/nand/raw/Kconfig                       |   7 +
>  drivers/mtd/nand/raw/Makefile                      |   1 +
>  drivers/mtd/nand/raw/technologic-nand-controller.c | 166 +++++++++++++++=
++++++
>  3 files changed, 174 insertions(+)
>=20

