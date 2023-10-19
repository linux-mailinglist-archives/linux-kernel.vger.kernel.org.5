Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 989AB7D0327
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Oct 2023 22:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346547AbjJSU1h convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 19 Oct 2023 16:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346466AbjJSU1f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Oct 2023 16:27:35 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E0E212D
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 13:27:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 24C7F63DCAAA;
        Thu, 19 Oct 2023 22:27:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id PZCW94g8D12l; Thu, 19 Oct 2023 22:27:29 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EA22063DCABE;
        Thu, 19 Oct 2023 22:27:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id PUJHuXQVN78Y; Thu, 19 Oct 2023 22:27:28 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C1E3063DCAAA;
        Thu, 19 Oct 2023 22:27:28 +0200 (CEST)
Date:   Thu, 19 Oct 2023 22:27:28 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dpervushin@embeddedalley.com,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at>
In-Reply-To: <20231018121618.778385-1-wangzhaolong1@huawei.com>
References: <20231018121618.778385-1-wangzhaolong1@huawei.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: RXBccCZfZ5BmLv0YkPinrieu1FJ81Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "ZhaoLong Wang" <wangzhaolong1@huawei.com>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> dpervushin@embeddedalley.com, "Artem Bityutskiy" <Artem.Bityutskiy@nokia.com>
> CC: "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel" <linux-kernel@vger.kernel.org>, "chengzhihao1"
> <chengzhihao1@huawei.com>, "ZhaoLong Wang" <wangzhaolong1@huawei.com>, "yi zhang" <yi.zhang@huawei.com>, "yangerkun"
> <yangerkun@huawei.com>
> Gesendet: Mittwoch, 18. Oktober 2023 14:16:18
> Betreff: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by ftl notifier

> If both flt.ko and gluebi.ko are loaded, the notiier of ftl
> triggers NULL pointer dereference when trying to access
> ‘gluebi->desc’ in gluebi_read().
> 
> ubi_gluebi_init
>  ubi_register_volume_notifier
>    ubi_enumerate_volumes
>      ubi_notify_all
>        gluebi_notify    nb->notifier_call()
>          gluebi_create
>            mtd_device_register
>              mtd_device_parse_register
>                add_mtd_device
>                  blktrans_notify_add   not->add()
>                    ftl_add_mtd         tr->add_mtd()
>                      scan_header
>                        mtd_read
>                          mtd_read
>                            mtd_read_oob
>                              gluebi_read   mtd->read()
>                                gluebi->desc - NULL
> 
> Detailed reproduction information available at the link[1],
> 
> In the normal case, obtain gluebi->desc in the gluebi_get_device(),
> and accesses gluebi->desc in the gluebi_read(). However,
> gluebi_get_device() is not executed in advance in the
> ftl_add_mtd() process, which leads to NULL pointer dereference.
> 
> The value of gluebi->desc may also be a negative error code, which
> triggers the page fault error.
> 
> This patch has the following modifications:
> 
> 1. Do not assign gluebi->desc to the error code. Use the NULL instead.
> 
> 2. Always check the validity of gluebi->desc in gluebi_read() If the
>   gluebi->desc is NULL, try to get MTD device.
> 
> Such a modification currently works because the mutex "mtd_table_mutex"
> is held on all necessary paths, including the ftl_add_mtd() call path,
> open and close paths. Therefore, many race condition can be avoided.

I see the problem, but I'm not really satisfied by the solution.
Adding this hack to gluebi_read() is not nice at all.

Is there a strong reason why have to defer ubi_open_volume() to
gluebi_get_device()?

Miquel, what do you think?

Thanks,
//richard
