Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67406754ED8
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jul 2023 15:39:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbjGPNji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jul 2023 09:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjGPNjf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jul 2023 09:39:35 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF32BE6E;
        Sun, 16 Jul 2023 06:39:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 73B13FF803;
        Sun, 16 Jul 2023 13:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689514772;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z+Ra7hhWn4EfJmcCYNqGxmHIKNgocGUiVSclQOBGyr0=;
        b=TATS50ECcuWRq/ij6HzuVA/IsJPYGVabBk7H0NVhcWXwNNnLguKQ66Bg/HVUm9eIZ8g+tH
        nG0LZxgyKB5XqR4zyeZoeg2LVxmpgXh0MO7D7qNa8Viq3Ymb2/P5m6myw5cv4dBsJM4mxz
        rlNS5KUA0aSs/E5gsEzlZz5b1oTo4zfuwMNTRGUWsgcKg5WjjfJZ7ngLp8dzbhNriPaUHj
        RQ2zDxGDDqSf7euqtKLz5JOhbVX1M5sS7qpYV7rEfNwzKroGi3cYoofNiMVX0MqFdrvIzF
        QDNZh0YhkJ3sQLwTsUo77wdwq2sd5vbt6nNQeAJEgCrQDeSl/5TRpZJf6ktb6w==
Date:   Sun, 16 Jul 2023 15:39:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Usyskin, Alexander" <alexander.usyskin@intel.com>
Cc:     Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Winkler, Tomas" <tomas.winkler@intel.com>,
        "Lubart, Vitaly" <vitaly.lubart@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Chris Paterson <Chris.Paterson2@renesas.com>
Subject: Re: [PATCH 1/2] mtd: use refcount to prevent corruption
Message-ID: <20230716153926.5e975231@xps-13>
In-Reply-To: <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
References: <20230620131905.648089-1-alexander.usyskin@intel.com>
        <20230620131905.648089-2-alexander.usyskin@intel.com>
        <TYWPR01MB87756794A30EB389AB017EB1C234A@TYWPR01MB8775.jpnprd01.prod.outlook.com>
        <20230715174112.3909e43f@xps-13>
        <CY5PR11MB63666C8DA33C93E1DC3BCB21ED3AA@CY5PR11MB6366.namprd11.prod.outlook.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Alexander,

alexander.usyskin@intel.com wrote on Sun, 16 Jul 2023 06:29:02 +0000:

> > > With this patch applied, when I load up the module, I get the same 3
> > > devices:
> > > /dev/mtd0
> > > /dev/mtd0ro
> > > /dev/mtdblock0
> > >
> > > Upon removal, the below 2 devices still hang around:
> > > /dev/mtd0
> > > /dev/mtd0ro =20
> >  =20
> Our use-case do not produce mtdblock, maybe there are some imbalances of =
get/put?
> I have somewhere version with pr_debug after every kref_get/put. That may=
 help to catch where
> it missed, I hope.

I believe mtdblock is the good citizen here. Just disable
CONFIG_MTD_BLOCK from your configuration and you will likely observe
the same issue, just a bit narrowed, perhaps. Indeed, if you manage to
follow all the get/put calls it can help to find an imbalance.

Thanks,
Miqu=C3=A8l
