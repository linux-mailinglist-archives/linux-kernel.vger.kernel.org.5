Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D2A77F2BB
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349283AbjHQJGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349304AbjHQJG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:06:26 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB56E7C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:06:23 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id DF65D40002;
        Thu, 17 Aug 2023 09:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1692263181;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+0sVgZsDJdvO6ZNm9NpT15IQTSW7YnPyFxYPQgJVPH8=;
        b=FwIYdAL44GxU/4+G1yOoHEzd+g/QEteRnPeF468rd4duSOuaA74Awj7WFrNoS6D0TP72t1
        21U9j10sZm/Utd+Tk8w9zecWCA6UryPAKhugCpW8peLliCLUbLYJQKNe3GILs5LsYo9uLb
        PF1syT1AiQrPRndgvzVF/NqPl8roWEx5YDAm2Ic+E4nrfp48yRb6cfcW5R4TWGxEGlmZuh
        eMaxRgz5lWttgpuxiAfDhEj37MUjcqcxF1Bdq31Gek+eDnK5MyivgLXxtHefOJ3UzPioeN
        zVQqd1zBWFiVf0sODS5yyJw+KGIL8D69TcosOPUckFHsuQElCrKfSNxIMwHMrA==
Date:   Thu, 17 Aug 2023 11:06:18 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Michael Walle <michael@walle.cc>, linux-kernel@vger.kernel.org,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: (subset) [PATCH v9 0/7] NVMEM cells in sysfs
Message-ID: <20230817110618.623960a0@xps-13>
In-Reply-To: <169200728874.82396.6212330367970101447.b4-ty@linaro.org>
References: <20230808062932.150588-1-miquel.raynal@bootlin.com>
        <169200728874.82396.6212330367970101447.b4-ty@linaro.org>
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

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Mon, 14 Aug 2023 11:01:28 +0100:

> On Tue, 08 Aug 2023 08:29:25 +0200, Miquel Raynal wrote:
> > As part of a previous effort, support for dynamic NVMEM layouts was
> > brought into mainline, helping a lot in getting information from NVMEM
> > devices at non-static locations. One common example of NVMEM cell is the
> > MAC address that must be used. Sometimes the cell content is mainly (or
> > only) useful to the kernel, and sometimes it is not. Users might also
> > want to know the content of cells such as: the manufacturing place and
> > date, the hardware version, the unique ID, etc. Two possibilities in
> > this case: either the users re-implement their own parser to go through
> > the whole device and search for the information they want, or the kernel
> > can expose the content of the cells if deemed relevant. This second
> > approach sounds way more relevant than the first one to avoid useless
> > code duplication, so here is a series bringing NVMEM cells content to
> > the user through sysfs.
> >=20
> > [...] =20
>=20
> Applied, thanks!
>=20
> [1/7] nvmem: core: Create all cells before adding the nvmem device
>       commit: ad004687dafea0921c2551c7d3e7ad56837984fc
> [2/7] nvmem: core: Return NULL when no nvmem layout is found
>       commit: a29eacf7e6376a44f37cc80950c92a59ca285992
> [3/7] nvmem: core: Do not open-code existing functions
>       commit: 95735bc038a828d649fe7f66f9bb67099c18a47a
> [4/7] nvmem: core: Notify when a new layout is registered
>       commit: 0e4a8e9e49ea29af87f9f308dc3e01fab969102f

Thanks for taking these! I will soon send a v10 with a very minor
correction. I guess you prefer to merge the "major" changes right after
-rc1 so the series can spend more time in -next, or is there something
that bothers you which need additional discussion?

Thanks,
Miqu=C3=A8l
