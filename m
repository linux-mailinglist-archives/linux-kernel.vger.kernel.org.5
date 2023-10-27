Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB7FF7D9EF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 19:40:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232531AbjJ0Rkj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 13:40:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230451AbjJ0Rkh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 13:40:37 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E41D1E3
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 10:40:33 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 833931C0005;
        Fri, 27 Oct 2023 17:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1698428432;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CTuavapv26+tfbGeh8by9aXs/f07vbaAG5mpZ2FPn4I=;
        b=P+DlIuwxEGSq1SSx3vWDzEZti3IUvGC/CU8TgerjHY1Y2eirh1UkX9UF/K0J8LYOPEJ2z0
        HZos0kc1VMGB5zGe4dJrWrzNMCmTCbMvT9tU+gJNltKHCe3aRjHSjA8i6vrHlPa76ornMn
        SNJgUwc7lerEA+SypDym9KKTS75/Q1+xYCCHg5Iyz+zzAyQz/9ThFFBmKZyZxdTJEr0jrz
        HkTXH2t5libRjcGv9Rd3E6zaW0iz0p/gF1JKtPxhXnnj7jPaqDUnkI3JnQeLkiRzE4dakJ
        eYE3/r2xaMji6zh7WwppLlCQs4nLPBy26aLoLAj9Yy8B1kBN198fVPzovI7PaQ==
Date:   Fri, 27 Oct 2023 19:40:26 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>, <Artem.Bityutskiy@nokia.com>,
        <dpervushin@embeddedalley.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chengzhihao1@huawei.com>,
        <yi.zhang@huawei.com>, <yangerkun@huawei.com>
Subject: Re: [PATCH v3] mtd: Fix gluebi NULL pointer dereference caused by
 ftl notifier
Message-ID: <20231027194026.1bc32dfe@xps-13>
In-Reply-To: <20231027012033.50280-1-wangzhaolong1@huawei.com>
References: <20231027012033.50280-1-wangzhaolong1@huawei.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-GND-Sasl: miquel.raynal@bootlin.com
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi ZhaoLong,

wangzhaolong1@huawei.com wrote on Fri, 27 Oct 2023 09:20:33 +0800:

> If both flt.ko and gluebi.ko are loaded, the notiier of ftl

flt ?					notifier

> triggers NULL pointer dereference when trying to access
> =E2=80=98gluebi->desc=E2=80=99 in gluebi_read().
>=20
> ubi_gluebi_init
>   ubi_register_volume_notifier
>     ubi_enumerate_volumes
>       ubi_notify_all
>         gluebi_notify    nb->notifier_call()
>           gluebi_create
>             mtd_device_register
>               mtd_device_parse_register
>                 add_mtd_device
>                   blktrans_notify_add   not->add()
>                     ftl_add_mtd         tr->add_mtd()

Glitches?

>                       scan_header
>                         mtd_read
>                           mtd_read_oob
>                             mtd_read_oob_std
>                               gluebi_read   mtd->read()
>                                 gluebi->desc - NULL
>=20
> Detailed reproduction information available at the link[1],
>=20
> The solution for the gluebi module is to run jffs2 on the UBI
> volume without considering working with ftl or mtdblock.[2].

I am sorry but ftl, gluebi, mtdblock, jffs2 and ubi in the same report
seem a little bit fuzzy. Are you sure about this sentence?

> Therefore, this problem can be avoided by preventing gluebi
> from creating mtdblock devices.

This sentence sounds wrong :)

> Fixes: 2ba3d76a1e29 ("UBI: make gluebi a separate module")
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217992 [1]
> Link: https://lore.kernel.org/lkml/441107100.23734.1697904580252.JavaMail=
.zimbra@nod.at/ [2]
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>  drivers/mtd/mtd_blkdevs.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
> index ff18636e0889..5bc32108ca03 100644
> --- a/drivers/mtd/mtd_blkdevs.c
> +++ b/drivers/mtd/mtd_blkdevs.c
> @@ -463,7 +463,7 @@ static void blktrans_notify_add(struct mtd_info *mtd)
>  {
>  	struct mtd_blktrans_ops *tr;
> =20
> -	if (mtd->type =3D=3D MTD_ABSENT)
> +	if (mtd->type =3D=3D MTD_ABSENT || mtd->type =3D=3D MTD_UBIVOLUME)
>  		return;
> =20
>  	list_for_each_entry(tr, &blktrans_majors, list)
> @@ -503,7 +503,7 @@ int register_mtd_blktrans(struct mtd_blktrans_ops *tr)
>  	mutex_lock(&mtd_table_mutex);
>  	list_add(&tr->list, &blktrans_majors);
>  	mtd_for_each_device(mtd)
> -		if (mtd->type !=3D MTD_ABSENT)
> +		if (mtd->type !=3D MTD_ABSENT && mtd->type !=3D MTD_UBIVOLUME)
>  			tr->add_mtd(tr, mtd);
>  	mutex_unlock(&mtd_table_mutex);
>  	return 0;


Thanks,
Miqu=C3=A8l
