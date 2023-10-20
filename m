Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC8F77D10B9
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 15:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377456AbjJTNpk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 09:45:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377222AbjJTNpi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 09:45:38 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEF0A3
        for <linux-kernel@vger.kernel.org>; Fri, 20 Oct 2023 06:45:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id C67564000F;
        Fri, 20 Oct 2023 13:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1697809531;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lr/z7uihQprUld3MCX8m2TxbGzxLF1jBcFQtsJ1q8Lc=;
        b=biU7ESoHpgUw+DDQz7V86GfiGC9KtHEliOGtPOBH2lqU8v9/dKa7TpQRy/qtWhw8nFH2iv
        SPRudRRN8PXjnJSt1sep9Vyoc2uvua23p4NRnADvgbOFKXF9mYrqgSa2XYkuvqGRMkXqih
        2Djs7z08wehMsdbDIskMWYzd2tv3SX+rYNAMX16zDcP03I1XMldDNv98b8aUIcFRx3QMyx
        L58Kusya/Twsickg6kRU0wnTpc5bksBZaWwlRxkmITvRWxHFGXzc/hIhcgXO5l8bd5FHp4
        9vTzCJC9Nr0T8VqOiewC15HTEuoOlfOBaNkbhdeIfHIBRzw7WnBR4SGJnvgOnQ==
Date:   Fri, 20 Oct 2023 15:45:28 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     "Zbigniew, Lukwinski" <zbigniew.lukwinski@linux.intel.com>
Cc:     Frank Li <Frank.Li@nxp.com>, alexandre.belloni@bootlin.com,
        conor.culhane@silvaco.com, imx@lists.linux.dev, joe@perches.com,
        linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] i3c: master: add enable(disable) hot join in sys
 entry
Message-ID: <20231020154528.2f5f68f5@xps-13>
In-Reply-To: <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
References: <20231018205929.3435110-1-Frank.Li@nxp.com>
        <20231018205929.3435110-2-Frank.Li@nxp.com>
        <57efe6de-cf65-32ed-fd1e-a388e1676c70@linux.intel.com>
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

Hi Lukwinski,

zbigniew.lukwinski@linux.intel.com wrote on Fri, 20 Oct 2023 10:55:27
+0200:

> On 10/18/2023 10:59 PM, Frank Li wrote:
> > Add hotjoin entry in sys file system allow user enable/disable hotjoin
> > feature.
> >
> > Add (*enable(disable)_hotjoin)() to i3c_master_controller_ops.
> > Add api i3c_master_enable(disable)_hotjoin(); =20
>=20
> What is the use case for having HJ enable knob in sysfs available for use=
r space other than for debug stuff? In other words, does user space really =
need to enable/disable HJ in runtime for other reason but debug? If it is o=
nly for debug maybe it=C2=A0 could be move to debugFS?

I don't think hotjoin should be considered as a debug feature. The
problem here is the power consumption which is higher if you enable
this feature (you need to keep everything clocked and ready to handle
an IBI) whereas if your design is "fixed" (more like an I2C bus) you
may save power by disabling this feature.

A module parameter does not fit here because it's a per-bus
configuration.

Thanks,
Miqu=C3=A8l
