Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E28C7658D6
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 18:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230285AbjG0QgY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 12:36:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbjG0QgW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 12:36:22 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED4F272C
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 09:36:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id B1F741C0008;
        Thu, 27 Jul 2023 16:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690475776;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kdGTSaZttWzXE70nDOUK2tohVaGSllQiBwLy7anvxFA=;
        b=gwbaqSDNeRzur4+HiLF4Q+AQOYWLgNup+cTf/E7YPQ0wFFV/oAHtQNdCkDkP9hZKhorxkD
        xZI2kw9GgScfprx+CUj/47lshiiGDujDREUPR3wLGCq0xpu9NjzgXy4xbQ/XZQqElnc17j
        eT+rGkvKqwJPjo2YO3LqPKXBKPIHuxphZuDxPvDaKbz5wzd/Tng4p9CqeWFqZs0wr8p0X0
        uy78U2ZWnXnYX2BqQ0t5J50JLJZ7APZ7mdkbJxb6L5z3QdCueQIiq/tSSHQ14NqWvuErUz
        tJkotP81jQRmfJlGM8O/ZP3ZG7CVnXiMxUwRnekoI7AjQuBYbCl31PKbuK6lSg==
Date:   Thu, 27 Jul 2023 18:36:11 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Alexander Usyskin <alexander.usyskin@intel.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tomas Winkler <tomas.winkler@intel.com>,
        Vitaly Lubart <vitaly.lubart@intel.com>,
        Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
Subject: Re: [PATCH] mtd: fix use-after-free in mtd release
Message-ID: <20230727183611.37d01f51@xps-13>
In-Reply-To: <ZMKUJbl7kFOfgKGg@smile.fi.intel.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
        <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>
        <20230727172013.7c85c05d@xps-13>
        <ZMKUJbl7kFOfgKGg@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Thu, 27 Jul 2023 18:58:29
+0300:

> On Thu, Jul 27, 2023 at 05:20:13PM +0200, Miquel Raynal wrote:
> > andriy.shevchenko@linux.intel.com wrote on Thu, 27 Jul 2023 18:12:04
> > +0300: =20
> > > On Thu, Jul 27, 2023 at 05:57:58PM +0300, Alexander Usyskin wrote: =20
>=20
> ...
>=20
> > > > Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption") =20
> > >=20
> > > Closes: ? =20
> >=20
> > Did I miss a recent update on the use of Fixes? =20
>=20
> They are orthogonal to each other. Actually Closes goes closer with
> Reported-by.
>=20
> I believe both of them needs to be added (by I might miss something).
>=20
> > I thought Closes was
> > supposed to point at a bug report while Fixes would point to the faulty
> > commit. =20
>=20
> Correct.
>=20
> > Right now I feel like Fixes is the right tag, =20
>=20
> Nobody objects that (see above).
>=20
> > but if you have a source explaining why we should not longer do it like
> > I am used to, I would appreciate a link. =20
>=20
> Since you know about Closes already, I think there is nothing to add.

Ah sorry I misunderstood your first e-mail. I thought you were
suggesting to replace Fixes by Closes. Sorry for the misunderstanding :)

Thanks,
Miqu=C3=A8l
