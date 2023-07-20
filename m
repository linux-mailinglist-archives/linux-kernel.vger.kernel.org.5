Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FBF75A5F8
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jul 2023 08:04:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbjGTGEY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jul 2023 02:04:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjGTGEW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jul 2023 02:04:22 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E081724;
        Wed, 19 Jul 2023 23:04:19 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id D74F2C0004;
        Thu, 20 Jul 2023 06:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1689833057;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nUFL7/Mm7BPR8kB+przAb0OhEflLuBBseviQ3BJv9XI=;
        b=KLwUNU/HXgYZnteyxoUn5AmohuBdHXzopujfXCbx8cF44Qz8QJTIJGrYik1WRX3aR27zOb
        JtlcjxSq75x4l/MjKwgsYNdnr4bEnhFGgj3l3Hiy3/r+1jNkURLVTCRjjpQkBwjFWUlnt1
        MBy3ltHjeUuOL1+oLq5NnJai9KKIYdArGGrJXMzWHePNpa03aFKj86L+Sw6I5fHi69NWBh
        NKa0Pn4Pasn1VUKcUZ7n29qCtN6jQ2lVhnD/JWLE0prgAvJWG1bTer0gkUa16TcrbQRHJ8
        TGB2/o8DFmVblY79u7kO1qX7XwCIzeJls0LFCpaxm4cca19aXESw87rZwzit4Q==
Date:   Thu, 20 Jul 2023 08:04:09 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Jens Axboe <axboe@kernel.dk>, Ulf Hansson <ulf.hansson@linaro.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Chinner <dchinner@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Thomas =?UTF-8?B?V2Vpw59zY2h1aA==?= <linux@weissschuh.net>,
        Jan Kara <jack@suse.cz>, Damien Le Moal <dlemoal@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, Min Li <min15.li@samsung.com>,
        Christian Loehle <CLoehle@hyperstone.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Jack Wang <jinpu.wang@ionos.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Yeqi Fu <asuk4.q@gmail.com>, Avri Altman <avri.altman@wdc.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Ye Bin <yebin10@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: [RFC PATCH 4/6] mtd: blkdevs: set GENHD_FL_NO_NVMEM
Message-ID: <20230720080409.734a312f@xps-13>
In-Reply-To: <65171d5da3daba24315ecdfef6727442baae5bbf.1689802933.git.daniel@makrotopia.org>
References: <cover.1689802933.git.daniel@makrotopia.org>
        <65171d5da3daba24315ecdfef6727442baae5bbf.1689802933.git.daniel@makrotopia.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Daniel,

daniel@makrotopia.org wrote on Wed, 19 Jul 2023 23:03:24 +0100:

> As the MTD subsystem already acts as an NVMEM provider, emulated mtdblock
> devices should not be considered NVMEM providers.
>=20
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  drivers/mtd/mtd_blkdevs.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index ff18636e08897..82d5afba6a25a 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -362,6 +362,7 @@ int add_mtd_blktrans_dev(struct mtd_blktrans_dev *new)
>  		gd->flags |=3D GENHD_FL_NO_PART;
>  	}
> =20
> +	gd->flags |=3D GENHD_FL_NO_NVMEM;
>  	set_capacity(gd, ((u64)new->size * tr->blksize) >> 9);
> =20
>  	/* Create the request queue */

Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>

Thanks,
Miqu=C3=A8l
