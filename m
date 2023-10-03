Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CE97B6862
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 13:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240624AbjJCL4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 07:56:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231960AbjJCL4M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 07:56:12 -0400
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::228])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1E3A3;
        Tue,  3 Oct 2023 04:56:06 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id A0C411BF20C;
        Tue,  3 Oct 2023 11:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1696334165;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AjFIqqJD4tF1YqoMJRAP1nIBhemfG2Wgo5vBuPOAe/I=;
        b=UD+euMUZG1tvk6eZMPI2f1Ws9UgfMUmdMiaHYM5OkB//v1FCXct1X716hk8Kthq5AClhK6
        qunJNbgDCHCr6zQDfXTwJu4nlLHoX04xDYy6jolq3AX2Il7mUZSnC54lqk5rZpn84Zg8IM
        VQpZxfq2pG4hKx7k3+oj59jgk/0i4VWLNmeLFWeC8j1J5HtBYrmvjLDwOnLmTRuJVat1t+
        6+fc4itbULghecLV6qmVm6DqR+t5hu53mkxxLH3FHlX8e6U9f6jTasyZ+QkApnkyr4itDA
        dirhEZbvkBGeVFc03i+8YZIRkDM8gXwpxkjfWr2KJAKziqkU7802GA4O+JC4vg==
Date:   Tue, 3 Oct 2023 13:56:01 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Domenico Punzo <dpunzo@micron.com>
Cc:     Martin =?UTF-8?B?SHVuZGViw7hsbA==?= <martin@geanix.com>,
        Rouven Czerwinski <r.czerwinski@pengutronix.de>,
        =?UTF-8?B?TcOlbnMgUnVsbGfDpXJk?= <mans@mansr.com>,
        Alexander Shiyan <eagle.alexander923@gmail.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Sean =?UTF-8?B?Tnlla2rDpnI=?= <sean@geanix.com>,
        Bean Huo <beanhuo@micron.com>
Subject: Re: [EXT] Re: [PATCH v2] mtd: rawnand: Ensure the nand chip
 supports cached reads
Message-ID: <20231003135601.6cf0d522@xps-13>
In-Reply-To: <BYAPR08MB4437B83D7D50F4135D0D40A9BBC4A@BYAPR08MB4437.namprd08.prod.outlook.com>
References: <20230922141717.35977-1-r.czerwinski@pengutronix.de>
        <e911f5d9c7def8c80904a17ad3924ecba6625998.camel@geanix.com>
        <20230926132725.5d570e1b@xps-13>
        <20230927170516.2604e8f2@xps-13>
        <b8de26e243afa3e5920455a4d8e5a3451a06d074.camel@geanix.com>
        <BYAPR08MB4437B83D7D50F4135D0D40A9BBC4A@BYAPR08MB4437.namprd08.prod.outlook.com>
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

Hi Domenico,

dpunzo@micron.com wrote on Tue, 3 Oct 2023 11:29:33 +0000:

> Micron Confidential
>=20
> Hello Miquel,
>=20
> Here is a short list of devices having cache read with ECC enabled.
>=20
> MT29F2G08ABAGAH4, MT29F2G08ABBGAH4, MT29F2G16ABBGAH4
> MT29F1G08ABAFAH4, MT29F1G08ABBFAH4, MT29F1G16ABBFAH4

Great! Thanks a lot.

It appears that even without internal ECC enabled we get failures on
Micron parts, so I believe there is something else that we need to
investigate. But thanks for the list, I will propose a patch preventing
the use of on-die ECC together with sequential cache reads on all parts
but the ones in this list (can be extended later).

Thanks,
Miqu=C3=A8l
