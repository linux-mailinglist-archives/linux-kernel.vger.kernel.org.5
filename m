Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 612257E9D7F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 14:44:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjKMNow (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 08:44:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230187AbjKMNou (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 08:44:50 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E395E18B
        for <linux-kernel@vger.kernel.org>; Mon, 13 Nov 2023 05:44:46 -0800 (PST)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 808C460003;
        Mon, 13 Nov 2023 13:44:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1699883085;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NkZZif+50w5P/OD5QUdP1KwY7V0XEjdY3TvKJRJlyIM=;
        b=VDqjUNvbbuVTYLH6UjMNpo6TVRXdyZNTlP+JE2TOFPvMF/tYKVFjW8dKUiqCNunoddOgqW
        EadJvyzcP1bOpOi9uagBeYZ6WYAvbjdfb9YqmwGiioIrnxKFGMBaJ3Jqb3pUUaA4tm33sd
        wjD9HLzTEId+Gqh18+RGsGlq1EY2jR+zzUUhrRAb4sC1j65u4SKgVbQW7IKSnXxiqCaT16
        /jMTZFOHBIkSwQrFCS9qPOiEE245EEa9VGkwEcAx1+Lh3z6LXAHqoxukkbJ6rzgEUkaYTh
        meBBnIT4GTZVUazP23ziMRJI19hojoajzWmoFu1i4XJrLvaLVbsu/RjjItjkMw==
Date:   Mon, 13 Nov 2023 14:44:41 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Ronald Monthero <debug.penguin32@gmail.com>
Cc:     richard@nod.at, vigneshr@ti.com, heiko@sntech.de,
        martin.blumenstingl@googlemail.com, paul@crapouillou.net,
        robh@kernel.org, u.kleine-koenig@pengutronix.de,
        AVKrasnov@sberdevices.ru, r.czerwinski@pengutronix.de,
        andriy.shevchenko@linux.intel.com, jaimeliao.tw@gmail.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Subject: Re: [PATCH] mtd:nand: Increment IFC_TIMEOUT_MSECS for nand
 controller response
Message-ID: <20231113144441.6e798d8b@xps-13>
In-Reply-To: <20231113131634.614467-1-debug.penguin32@gmail.com>
References: <20231113131634.614467-1-debug.penguin32@gmail.com>
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

Hi Ronald,

Thanks for the patch, here are a couple of comments I'd like you to
address before taking the fix.

debug.penguin32@gmail.com wrote on Mon, 13 Nov 2023 23:16:28 +1000:

The title prefix needs to be aligned with today's policy, you can check
it with git log --oneline -- <your file>.

> The nand controller not responding scenario occurs causing blocked tasks
> and rcu_prempt warnings of stall on cpus. Incrementing the
> IFC_TIMEOUT_MSECS appears to solve the nand controller not responding
> issue.

I would rephrase a bit this paragraph with more confidence. Under heavy
load it is likely that the controller is done with its own task but the
thread unlocking the wait look is never scheduled (or not in time)
resulting in such kind of error. Maybe there is something else wrong in
the code which stalls the CPU in this case, (hence the first message).

Enlarging the timeout to 1s in this case is fine, but maybe there is
still something wrong aside.

> ** ID_531 main/smrcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
> rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
>         (detected by 1, t=3D2102 jiffies, g=3D12653, q=3D518)
> task:irq/31-arm-irq1 state:D stack: 0 pid:  116 ppid: 2 flags:0x00000000
> [<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
> [<8064bb01>] (schedule) from [<8064fa65>] (schedule_timeout+0x6d/0xa0)
> [<8064fa65>] (schedule_timeout) from [<804ba353>] (fsl_ifc_run_command+0x=
6f/0x178)
> [<804ba353>] (fsl_ifc_run_command) from [<804ba72f>] (fsl_ifc_cmdfunc+0x2=
03/0x2b8)
> [<804ba72f>] (fsl_ifc_cmdfunc) from [<804b135f>] (nand_status_op+0xaf/0xe=
0)
> [<804b135f>] (nand_status_op) from [<804b13b3>] (nand_check_wp+0x23/0x48)
> [<804b13b3>] (nand_check_wp) from [<804b231d>] (nand_do_write_ops+0x99/0x=
2b8)
> [<804b231d>] (nand_do_write_ops) from [<804b5355>] (nand_write_oob+0x3b/0=
x4a)
> [<804b5355>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1=
d0)
> [<804c047b>] (ubi_eba_write_leb) from [<804bf62d>] (ubi_leb_write+0x75/0x=
90)
> [<804bf62d>] (ubi_leb_write) from [<803745b7>] (ubifs_leb_write+0x4b/0x8c)
> [<803745b7>] (ubifs_leb_write) from [<80374bbb>] (ubifs_wbuf_sync_nolock+=
0x10f/0x1a4)
> [<80374bbb>] (ubifs_wbuf_sync_nolock) from [<8036c6dd>] (ubifs_jnl_update=
+0x1e9/0x36c)
> [<8036c6dd>] (ubifs_jnl_update) from [<80370933>] (ubifs_create+0xb3/0x13=
0)
> [<80370933>] (ubifs_create) from [<802cf0c7>] (lookup_open+0x173/0x1c4)
> [<802cf0c7>] (lookup_open) from [<802cf8a3>] (open_last_lookups+0xd7/0x16=
c)
> [<802cf8a3>] (open_last_lookups) from [<802d08e5>] (path_openat+0x91/0x10=
4)
> [<802d08e5>] (path_openat) from [<802d0989>] (do_filp_open+0x31/0x74)
> [<802d0989>] (do_filp_open) from [<802c4fb3>] (file_open_name+0x33/0x48)
> [<802c4fb3>] (file_open_name) from [<802c4fe9>] (filp_open+0x21/0x2e)
> [<802c4fe9>] (filp_open) from [<80490bd3>] (irq1_handler+0x53/0xa4)
> [<80490bd3>] (irq1_handler) from [<80247dd7>] (irq_forced_thread_fn+0x1f/=
0x4c)
> [<80247dd7>] (irq_forced_thread_fn) from [<80247cd9>] (irq_thread+0x89/0x=
114)
> [<80247cd9>] (irq_thread) from [<8022ca67>] (kthread+0xcf/0xe4)
> [<8022ca67>] (kthread) from [<80200149>] (ret_from_fork+0x11/0x28)
> Exception stack(0x822bbfb0 to 0x822bbff8)
> bfa0:                                     00000000 00000000 00000000 0000=
0000
> bfc0: 00000000 00000000 00000000 00000000 00000000 00000000 00000000 0000=
0000
> bfe0: 00000000 00000000 00000000 00000000 00000013 00000000
>=20
> fsl,ifc-nand 7e800000.nand: Controller is not responding
> ID_531 main/smp_fsm.c:1884 <inrcu: rcu_preempt detected stalls on CPUs:
> rcu:    Tasks blocked on level-0 rcu_node (CPUs 0-1): P116/2:b..l
>         (detected by 1, t=3D2102 jiffies, g=3D7729, q=3D754)
> task:irq/31-arm-irq1 state:D stack: 0 pid:  116 ppid: 2 flags:0x00000000
> [<8064b97f>] (__schedule) from [<8064bb01>] (schedule+0x8d/0xc2)
> [<8064bb01>] (schedule) from [<8064dacd>] (rt_mutex_slowlock_block.con)
> [<8064dacd>] (rt_mutex_slowlock_block.constprop.0) from [<8064db57>]=20
> [<8064db57>] (__rt_mutex_slowlock.constprop.0) from [<8064dbf7>]=20
> [<8064dbf7>] (rt_mutex_slowlock.constprop.0) from [<804b2047>]=20
> [<804b2047>] (nand_get_device) from [<804b5335>] (nand_write_oob+0x1b/0x4=
a)
> [<804b5335>] (nand_write_oob) from [<804a3585>] (mtd_write+0x41/0x5c)
> [<804a3585>] (mtd_write) from [<804c1d47>] (ubi_io_write+0x17f/0x22c)
> [<804c1d47>] (ubi_io_write) from [<804c047b>] (ubi_eba_write_leb+0x5b/0x1=
d0)
> [<804c047b>] (ubi_eba_write_leb) from [<804bf62d>] (ubi_leb_write+0x75/0x=
90)
> [<804bf62d>] (ubi_leb_write) from [<803745b7>] (ubifs_leb_write+0x4b/0x8c)
> [<803745b7>] (ubifs_leb_write) from [<80374bbb>] (ubifs_wbuf_sync_nolock+=
0x10f/0x1a4)
> [<80374bbb>] (ubifs_wbuf_sync_nolock) from [<8036c6dd>] (ubifs_jnl_update=
+0x1e9/0x36c)

You can trim down the traces to only show the interesting part.

Here you need a Fixes: and Cc: stable tag.

> Signed-off-by: Ronald Monthero <debug.penguin32@gmail.com>
> ---
>  drivers/mtd/nand/raw/fsl_ifc_nand.c | 2 +-
>  drivers/mtd/nand/raw/nand_base.c    | 5 ++++-
>  2 files changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/mtd/nand/raw/fsl_ifc_nand.c b/drivers/mtd/nand/raw/f=
sl_ifc_nand.c
> index 20bb1e0cb5eb..42f8ea46b6a8 100644
> --- a/drivers/mtd/nand/raw/fsl_ifc_nand.c
> +++ b/drivers/mtd/nand/raw/fsl_ifc_nand.c
> @@ -21,7 +21,7 @@
> =20
>  #define ERR_BYTE		0xFF /* Value returned for read
>  					bytes when read failed	*/
> -#define IFC_TIMEOUT_MSECS	500  /* Maximum number of mSecs to wait
> +#define IFC_TIMEOUT_MSECS	1000  /* Maximum number of mSecs to wait
>  					for IFC NAND Machine	*/
> =20
>  struct fsl_ifc_ctrl;
> diff --git a/drivers/mtd/nand/raw/nand_base.c b/drivers/mtd/nand/raw/nand=
_base.c
> index 9e24bedffd89..05b52ed41f4c 100644
> --- a/drivers/mtd/nand/raw/nand_base.c
> +++ b/drivers/mtd/nand/raw/nand_base.c
> @@ -363,8 +363,11 @@ static int nand_check_wp(struct nand_chip *chip)
>  	int ret;
> =20
>  	/* Broken xD cards report WP despite being writable */
> -	if (chip->options & NAND_BROKEN_XD)
> +	if (chip->options & NAND_BROKEN_XD) {
> +		pr_info("nand_chip->options indicates NAND_BROKEN_XD %d\n",
> +			(chip->options & NAND_BROKEN_XD));
>  		return 0;
> +	}

This is an unrelated debug message and should be dropped.

> =20
>  	/* Check the WP bit */
>  	ret =3D nand_status_op(chip, &status);

Thanks,
Miqu=C3=A8l
