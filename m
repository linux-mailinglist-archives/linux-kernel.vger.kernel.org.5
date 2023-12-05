Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58B68057C4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 15:49:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345698AbjLEOqo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 09:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345682AbjLEOqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 09:46:42 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6559129
        for <linux-kernel@vger.kernel.org>; Tue,  5 Dec 2023 06:46:47 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8FEDF1C0010;
        Tue,  5 Dec 2023 14:46:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1701787606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3oW58aA+EmNdSZ3vq5hven3qPTQb+RFRYHU5Pcj6TJ0=;
        b=BWJyV0aww7ayIVS3QtH5a2VYjsG5piTWINPR8X1d8fTYfNee7xEXXp/4zP+poiblGvdBvD
        SWoka1XdwL8zZ6Pz//WWZ4GDlY6Tz+SPYTuuyJB4TokILP69EGHDuLRNUXolQqDMmwQtxA
        YUcd6PpXW1ND79/nr8h0SeN6iklwC42lan4G64O3BIxjgFheT1WBlRKyCzPkdjPgSufHMN
        LGbZvQYHadABIo1FsUeWAvebmRdKNkjRdZ3PV59vaSNlhtI4S16FnYiaPObLIBjBocLlUx
        bvHFxpDDtCikGMTptqOiw65qsMR88Bhmx8Iu80D6Q+Ir0DC/S2wtJn2XJxJGQg==
Date:   Tue, 5 Dec 2023 15:46:43 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        <linux-kernel@vger.kernel.org>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Michael Walle <michael@walle.cc>,
        =?UTF-8?Q?Ra?= =?UTF-8?Q?fa=C5=82_Mi=C5=82ecki?= 
        <rafal@milecki.pl>, Marco Felsch <m.felsch@pengutronix.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v14 0/8] NVMEM cells in sysfs
Message-ID: <20231205154643.76eb4a32@booty>
In-Reply-To: <20231129163737.698317-1-miquel.raynal@bootlin.com>
References: <20231129163737.698317-1-miquel.raynal@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: luca.ceresoli@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miqu=C3=A8l,

On Wed, 29 Nov 2023 17:37:29 +0100
Miquel Raynal <miquel.raynal@bootlin.com> wrote:

> Hello,
>=20
> As part of a previous effort, support for dynamic NVMEM layouts was
> brought into mainline, helping a lot in getting information from NVMEM
> devices at non-static locations. One common example of NVMEM cell is the
> MAC address that must be used. Sometimes the cell content is mainly (or
> only) useful to the kernel, and sometimes it is not. Users might also
> want to know the content of cells such as: the manufacturing place and
> date, the hardware version, the unique ID, etc. Two possibilities in
> this case: either the users re-implement their own parser to go through
> the whole device and search for the information they want, or the kernel
> can expose the content of the cells if deemed relevant. This second
> approach sounds way more relevant than the first one to avoid useless
> code duplication, so here is a series bringing NVMEM cells content to
> the user through sysfs.

I successfully tested the whole series, independently from Miqu=C3=A8l's
tests and on different hardware:

[tested on ARM64 + an I2C EEPROM with overlay loading/unloading]
Tested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

Luca

--=20
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
