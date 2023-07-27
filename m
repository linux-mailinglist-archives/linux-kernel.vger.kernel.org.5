Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68AEF76574E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 17:20:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbjG0PUX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 11:20:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjG0PUT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 11:20:19 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37041FCF
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 08:20:17 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id EA7F1E0006;
        Thu, 27 Jul 2023 15:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1690471216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+tYkLqI/WHrzy+gF3ZWvjwYtLENNnrtaJxq1JAle3Y=;
        b=HLUlE8oW95FKHARC7HKx6eY3PtnWvzRFtTOmg8SgLOq64ABxby+KSfWbA+NhcJUVlyiHSZ
        Vl+FJqjQvGqeRNKNMeZk16JYDW0TF3y4mAzrZvA7fRXDW8BOCJdV0b4H2/al9pS5NnAtPX
        cvWHou+1dyV3AR8zbnoiTIBrZBTrYW74jqJD8XIGJiPaINvohZ5yQaRvaLwLEKYESWgOmL
        j19gfF1nWf5alNn/8r135+OE9Jpfol33imFbIengD0pojeZRVN5H0ROnePihUCD+BLNb/w
        Myz32U2fUNjWBDqn5lJnbp38lR07GbEjrjXunsw7UgawWPFXcRhj9GPbQc8Pcg==
Date:   Thu, 27 Jul 2023 17:20:13 +0200
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
Message-ID: <20230727172013.7c85c05d@xps-13>
In-Reply-To: <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>
References: <20230727145758.3880967-1-alexander.usyskin@intel.com>
        <ZMKJRNDoQV8p0DH4@smile.fi.intel.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

andriy.shevchenko@linux.intel.com wrote on Thu, 27 Jul 2023 18:12:04
+0300:

> On Thu, Jul 27, 2023 at 05:57:58PM +0300, Alexander Usyskin wrote:
> > I case of partition device_unregister in mtd_device_release =20
>=20
> In
>=20
> device_unregister()
> mtd_device_release()
>=20
> > calls mtd_release which frees mtd_info structure for partition. =20
>=20
> mtd_release()
>=20
> > All code after device_unregister in mtd_device_release thus =20
>=20
> device_unregister()
> mtd_device_release()
>=20
> > works already freed memory. =20
>=20
> uses?
>=20
> > Move part of code to mtd_release and restict mtd->dev cleanup =20
>=20
> mtd_release()

Yup, thanks for all these suggestions, I agree with them.

> > to non-partion object.
> > For partition object such cleanup have no sense as partition
> > mtd_info is removed.
> >=20
> > Cc: Miquel Raynal <miquel.raynal@bootlin.com>
> > Cc: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
> > Fixes: 19bfa9ebebb5 ("mtd: use refcount to prevent corruption") =20
>=20
> Closes: ?

Did I miss a recent update on the use of Fixes? I thought Closes was
supposed to point at a bug report while Fixes would point to the faulty
commit. Right now I feel like Fixes is the right tag, but if you have a
source explaining why we should not longer do it like I am used to,
I would appreciate a link.

Thanks,
Miqu=C3=A8l
