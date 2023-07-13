Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C617751A1D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 09:43:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232178AbjGMHnG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 03:43:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbjGMHnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 03:43:05 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 951F52686
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 00:43:00 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 5138A4000E;
        Thu, 13 Jul 2023 07:42:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689234179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zgZIcDWqRIC5ulGEEfen5jjlJQT8N311IDXS8JfzMas=;
        b=nQWkgIiI9L2Y6tLwlydUPGJC/wNaA+Osi+jcbFg6QNJ51aVpJColAF9hJE9JgxM3pIRHPG
        s4LNdZ5BGfsUxmgB9PfQ1DtLRWvdzEbyqKP4MQRFEHE5ItZHFTpKCoPOVKqd+AbK5BvpkO
        sdYO/YT/qCdZ1F/aR2rgrJGz5FZt1fshWykKiQzH9ypiut2y/MV2dYFY9JBpBJp7lPKpms
        mSeNEHpxOBUeX+VYzu1Mlgh7t7c04PbHKQHbWFZOiK57I7hDOxoHCu0hc15u1fpkJFL4XZ
        KI9kEL85sEI7vHYODeqqHMv6RAB6mrfq+e9Nhcs7tE5Z0+B9Ue8C5FBb2Va12w==
Date:   Thu, 13 Jul 2023 09:42:57 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v4 4/4] nvmem: core: Expose cells through sysfs
Message-ID: <20230713094257.44c2d5cd@xps-13>
In-Reply-To: <838e1e9a-a679-5b2f-d190-cdd10016a7bf@linaro.org>
References: <20230614063018.2419043-1-miquel.raynal@bootlin.com>
        <20230614063018.2419043-5-miquel.raynal@bootlin.com>
        <838e1e9a-a679-5b2f-d190-cdd10016a7bf@linaro.org>
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

Hi Srinivas,

srinivas.kandagatla@linaro.org wrote on Wed, 12 Jul 2023 18:20:01 +0100:

> Hi Miquel,
>=20
> On 14/06/2023 07:30, Miquel Raynal wrote:
> > The binary content of nvmem devices is available to the user so in the
> > easiest cases, finding the content of a cell is rather easy as it is
> > just a matter of looking at a known and fixed offset. However, nvmem
> > layouts have been recently introduced to cope with more advanced
> > situations, where the offset and size of the cells is not known in
> > advance or is dynamic. When using layouts, more advanced parsers are
> > used by the kernel in order to give direct access to the content of each
> > cell, regardless of its position/size in the underlying
> > device. Unfortunately, these information are not accessible by users,
> > unless by fully re-implementing the parser logic in userland.
> >=20
> > Let's expose the cells and their content through sysfs to avoid these
> > situations. Of course the relevant NVMEM sysfs Kconfig option must be
> > enabled for this support to be available.
> >=20
> > Not all nvmem devices expose cells. Indeed, the .bin_attrs attribute
> > group member will be filled at runtime only when relevant and will
> > remain empty otherwise. In this case, as the cells attribute group will
> > be empty, it will not lead to any additional folder/file creation.
> >=20
> > Exposed cells are read-only. There is, in practice, everything in the
> > core to support a write path, but as I don't see any need for that, I
> > prefer to keep the interface simple (and probably safer). The interface
> > is documented as being in the "testing" state which means we can later
> > add a write attribute if though relevant.
> >=20
> > There is one limitation though: if a layout is built as a module but is
> > not properly installed in the system and loaded manually with insmod
> > while the nvmem device driver was built-in, the cells won't appear in
> > sysfs. But if done like that, the cells won't be usable by the built-in
> > kernel drivers anyway.
> >=20
> > Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com> =20
>=20
> Unable to apply this, Can you re-base this on rc1?

Yes of course, here it is. I figured out yesterday evening that this
would no longer apply, I did the rebase locally but did not finish
testing. v5 is now in your inbox.

I also split this patch so I now:
- gather all the cells creation together before adding the nvmem device
- then we create the sysfs cells

Cheers,
Miqu=C3=A8l
