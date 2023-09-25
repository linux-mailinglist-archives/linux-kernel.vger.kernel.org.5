Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257337AD9AE
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 16:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232036AbjIYODS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 10:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjIYODQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 10:03:16 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF9A9109
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 07:03:06 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 84C78635DB5B;
        Mon, 25 Sep 2023 16:03:04 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id IuqLOyVDcGkJ; Mon, 25 Sep 2023 16:03:03 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 932CE622F591;
        Mon, 25 Sep 2023 16:03:03 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id slzN9QCr4ZQj; Mon, 25 Sep 2023 16:03:03 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 71238635DB5B;
        Mon, 25 Sep 2023 16:03:03 +0200 (CEST)
Date:   Mon, 25 Sep 2023 16:03:03 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <1131184426.81026.1695650583370.JavaMail.zimbra@nod.at>
In-Reply-To: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com>
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix error code loss in mtdchar_read() function.
Thread-Index: K2deZwmqse54Lnhyky63J7p7EYeVMQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
> An: "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>, "Vignesh Raghavendra" <vigneshr@ti.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "chengzhihao1"
> <chengzhihao1@huawei.com>, "ZhaoLong Wang" <wangzhaolong1@huawei.com>, "yi zhang" <yi.zhang@huawei.com>, "yangerkun"
> <yangerkun@huawei.com>
> Gesendet: Samstag, 23. September 2023 02:58:56
> Betreff: [RFC] mtd: Fix error code loss in mtdchar_read() function.

> In the first while loop, if the mtd_read() function returns -EBADMSG
> and 'retlen' returns 0, the loop break and the function returns value
> 'total_retlen' is 0, not the error code.

Given this a second thought. I don't think a NAND driver is allowed to return
less than requests bytes and setting EBADMSG.
UBI's IO path has a comment on that:

                /*
                 * The driver should never return -EBADMSG if it failed to read
                 * all the requested data. But some buggy drivers might do
                 * this, so we change it to -EIO.
                 */
                if (read != len && mtd_is_eccerr(err)) {
                        ubi_assert(0);
                        err = -EIO;
                }

Thanks,
//richard
