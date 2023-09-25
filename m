Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDC447AD3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 10:49:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233071AbjIYItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 04:49:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232979AbjIYItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 04:49:51 -0400
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E14C1D3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 01:49:43 -0700 (PDT)
Received: by mail.gandi.net (Postfix) with ESMTPSA id 19B2CFF803;
        Mon, 25 Sep 2023 08:49:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1695631782;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=INBNCslwxKAO9zA0oLb6M4ySYAmug40tgKE1H/MmE0A=;
        b=TYej/Qhs2tQt0X2X/1RpcZsO4PzpvkrHD6BxUtce/kqEyax4ZxRj1S/sEYcWjqB0CO7TOK
        HwaElyLLqzCZdL56EkdOOuZy6SXYGOEK7VBY9yirkxT/jTHZdITbC7qWW9+K1T9RHH3PMY
        JsKw3fQpnhmU+Xi8dCW88Y/WNNrhqDjfBoyZiz9uJtT04NQiy3CvxGZo3g9QC9utv3rz26
        grC+poafNhzfdTSS1R2PAgHR3MPF/KLR++jSqhXpz+P9tjBLbQLmhAJZtg7fznHcedhviv
        yQzPzPnn6QubeEZoxgSR9rRNwUqgUaHQ5DkaCsZHYycaOk1f1VBRO/ouHIH81Q==
Date:   Mon, 25 Sep 2023 10:49:38 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <chengzhihao1@huawei.com>, <yi.zhang@huawei.com>,
        <yangerkun@huawei.com>
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
Message-ID: <20230925104938.3f7b4284@xps-13>
In-Reply-To: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
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

Hello,

Richard, your advice is welcome here.

wangzhaolong1@huawei.com wrote on Sat, 23 Sep 2023 08:58:56 +0800:

> In the first while loop, if the mtd_read() function returns -EBADMSG

			      s/the//	     s/function//
			      ,

> and 'retlen' returns 0, the loop break and the function returns value

s/and//		remains to 0. The loop breaks and the function
returns 'total_retlen' which is 0 instead of the error code.

> 'total_retlen' is 0, not the error code.

Actually after looking at the code, I have no strong opinion
regarding whether we should return 0 or an error code in this case.=20

There is this comment right above, and I'm not sure it is still up to
date because I believe many drivers just don't provide the data upon
ECC error:

                /* Nand returns -EBADMSG on ECC errors, but it returns
                 * the data. For our userspace tools it is important
                 * to dump areas with ECC errors!
                 * For kernel internal usage it also might return -EUCLEAN
                 * to signal the caller that a bitflip has occurred and has
                 * been corrected by the ECC algorithm.
                 * Userspace software which accesses NAND this way
                 * must be aware of the fact that it deals with NAND
                 */

> This problem causes the user-space program to encounter EOF when it has
> not finished reading the mtd partion, and this also violates the read
> system call standard in POSIX.
>=20
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=3D217939
> Signed-off-by: ZhaoLong Wang <wangzhaolong1@huawei.com>
> ---
>  drivers/mtd/mtdchar.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
> index 8dc4f5c493fc..ba60dc6bef98 100644
> --- a/drivers/mtd/mtdchar.c
> +++ b/drivers/mtd/mtdchar.c
> @@ -211,7 +211,7 @@ static ssize_t mtdchar_read(struct file *file, char _=
_user *buf, size_t count,
>  	}
> =20
>  	kfree(kbuf);
> -	return total_retlen;
> +	return total_retlen ? total_retlen : ret;

This is kind of wrong, if ret is 0 then you return ret while you should
return total_retlen. In practice it does not really matter, the result
is the same, but it makes it harder to understand the code IMHO.

>  } /* mtdchar_read */
> =20
>  static ssize_t mtdchar_write(struct file *file, const char __user *buf, =
size_t count,


Thanks,
Miqu=C3=A8l
