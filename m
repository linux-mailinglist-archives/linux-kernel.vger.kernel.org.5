Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7453F7824C2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233799AbjHUHoY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:44:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233054AbjHUHoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:44:23 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D9592;
        Mon, 21 Aug 2023 00:44:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1692603861; x=1724139861;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=bHaF/DVGn2+wBr6abyJEpnFTf2Pua+abRANrnRPvJWQ=;
  b=bagmNwNX8zTeptwr6EI4ghvjKKf9GfpJPFUOPOH3VSse6L1JQ6Rr2Pyw
   GQpd0JSTwp9gJ0RZj2Xb4pN4osSDaaByfDA5vkSPjBbpY3Y7WpTQsEsFe
   jqBn2Jp6ybrtwrgzadYOBBvyNtfSQbEwkV5+17ZlqqsVTRljfTmrlQmPy
   1Z+5FMTjcUG/lp+3q8WIjENuIX/5LEB3AsONPnmEP4IaLPC5drCnRhkPH
   zvQInh0ck10A18ZzF0aLTTvVI6FpFrXjE0Uoc4+SYbNMf7q1oVc95Buan
   nhyKU1EGR7pQORbkD/k9bHnu2ljiks7zKUKZeAfoPec/m+lROadvgUSo7
   w==;
X-IronPort-AV: E=Sophos;i="6.01,189,1684792800"; 
   d="scan'208";a="32533488"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 21 Aug 2023 09:44:18 +0200
Received: from steina-w.localnet (steina-w.tq-net.de [10.123.53.21])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by vtuxmail01.tq-net.de (Postfix) with ESMTPSA id 456BA280075;
        Mon, 21 Aug 2023 09:44:18 +0200 (CEST)
From:   Alexander Stein <alexander.stein@ew.tq-group.com>
To:     Bough Chen <haibo.chen@nxp.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "christophe.leroy@csgroup.eu" <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH 2/2] gpio: mxc: switch to dynamic allocat GPIO base
Date:   Mon, 21 Aug 2023 09:44:18 +0200
Message-ID: <12270129.O9o76ZdvQC@steina-w>
Organization: TQ-Systems GmbH
In-Reply-To: <CACRpkdZ-2Lyk_c8EJfS=YHK81wt2RAWnZAg+vxvZZijYFwmDDA@mail.gmail.com>
References: <20230506085928.933737-1-haibo.chen@nxp.com> <DB7PR04MB40102AA686099ED666C93EF5901EA@DB7PR04MB4010.eurprd04.prod.outlook.com> <CACRpkdZ-2Lyk_c8EJfS=YHK81wt2RAWnZAg+vxvZZijYFwmDDA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Am Montag, 21. August 2023, 09:25:54 CEST schrieb Linus Walleij:
> On Mon, Aug 21, 2023 at 4:47=E2=80=AFAM Bough Chen <haibo.chen@nxp.com> w=
rote:> > Hi=20
Linus and Bartosz,
> >=20
> > For this patch, still not in the main trunk (Linux 6.5-rc7) and
> > linux-next(next-20230818). Can you help apply or any comment?
>=20
> As pointed out by Bartosz you cannot just mechanically switch the base
> to -1.
>=20
> You also need to convince us that this doesn't break any systems, and if
> it does, fix them so they don't break before submitting this patch.

I think it's hard to tell if something breaks, this driver is used in a lot=
 of=20
boards. AFAIR some people are relying on the assumption of fixed order. Usi=
ng=20
dynamic allocation this not ensured. A possible fix is to use aliases [1].

Best regards,
Alexander

[1] https://lore.kernel.org/lkml/20230215092421.143199-1-alexander.stein@ew=
=2Etq-group.com/T/#u
=2D-=20
TQ-Systems GmbH | M=C3=BChlstra=C3=9Fe 2, Gut Delling | 82229 Seefeld, Germ=
any
Amtsgericht M=C3=BCnchen, HRB 105018
Gesch=C3=A4ftsf=C3=BChrer: Detlef Schneider, R=C3=BCdiger Stahl, Stefan Sch=
neider
http://www.tq-group.com/


