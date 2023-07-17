Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A9E6756966
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 18:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231987AbjGQQlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 12:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231951AbjGQQlW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 12:41:22 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A7E3E4F
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 09:41:21 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0969AC0005;
        Mon, 17 Jul 2023 16:41:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689612079;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2ntiN7SsvoF79NXtnrae3KdAeOHGP8txeV8hSDxhhoQ=;
        b=Su0Ppg32m1IFar8DkANJRXcN0lMBDk5Vu92hwIrd5TFPUv6ux+pyS0JgYjKugeek06zbZl
        A5G/YaMq9rFlTU//uYutfCyYn35/bhu3ssRF0s24Qb0+75bcXGFTVZeHhB3ZnegaGOSEVS
        cc26X12wy2nOfVeE64xRkxU9RM/JN2izt5a1M7ulUOeKGH4fEFZ/lO2enVl4MQpYnOp5nQ
        GoQxgqcyc2Dn59n7Bck2Bsvd7tecbakc6Xs0IB87x5W/5kNRRLtPemraeX9bfOxWjSW5uN
        2kmTEW3wjmKkAPAF4xg2QJJl6s2vwMgQvyYc2OS4QP3R6yjiv9ceDI5U/eKRAQ==
Date:   Mon, 17 Jul 2023 18:41:17 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Michael Walle <michael@walle.cc>
Cc:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>,
        Luka Perkov <luka.perkov@sartura.hr>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v6 3/3] nvmem: core: Expose cells through sysfs
Message-ID: <20230717184117.065e9585@xps-13>
In-Reply-To: <f85f117a59586dc2e5df33e11b39c69f@walle.cc>
References: <20230717075147.43326-1-miquel.raynal@bootlin.com>
        <20230717075147.43326-4-miquel.raynal@bootlin.com>
        <f85f117a59586dc2e5df33e11b39c69f@walle.cc>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Michael,

michael@walle.cc wrote on Mon, 17 Jul 2023 14:24:45 +0200:

> Hi,
>=20
> > There is one limitation though: if a layout is built as a module but is
> > not properly installed in the system and loaded manually with insmod
> > while the nvmem device driver was built-in, the cells won't appear in
> > sysfs. But if done like that, the cells won't be usable by the built-in
> > kernel drivers anyway. =20
>=20
> What is the difference between manual loading with insmod and automatic
> module loading? Or is the limitation, layout as M and device driver as Y
> doesn't work?

The nvmem core uses usermodehelper to load the relevant layout
module, but that only works if the module was installed correctly (make
modules_install).

The limitation is:
* Any storage device driver that registers an nvmem interface =3Dy (or =3Dm
  but loaded before the nvmem layout)
* The relevant nvmem layout =3Dm *and* not installed with make
  modules_install

If you see a way to workaround this, let me know, but there is no way
we can enforce Kconfig dependencies between storage drivers and nvmem
layouts IMHO.

Thanks,
Miqu=C3=A8l
