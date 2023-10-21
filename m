Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E33FB7D1E26
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 18:09:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231781AbjJUQJt convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 21 Oct 2023 12:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231372AbjJUQJr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 12:09:47 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A811F1A8
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 09:09:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id F355A6343CAC;
        Sat, 21 Oct 2023 18:09:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id Vsuiu3WwRoDH; Sat, 21 Oct 2023 18:09:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 8149C6343CBC;
        Sat, 21 Oct 2023 18:09:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id seXA32NShRV0; Sat, 21 Oct 2023 18:09:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 58A186343CAF;
        Sat, 21 Oct 2023 18:09:40 +0200 (CEST)
Date:   Sat, 21 Oct 2023 18:09:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     chengzhihao1 <chengzhihao1@huawei.com>
Cc:     ZhaoLong Wang <wangzhaolong1@huawei.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        dpervushin <dpervushin@embeddedalley.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        yi zhang <yi.zhang@huawei.com>,
        yangerkun <yangerkun@huawei.com>
Message-ID: <441107100.23734.1697904580252.JavaMail.zimbra@nod.at>
In-Reply-To: <891e554b-c133-6378-3a65-836fc9147e54@huawei.com>
References: <20231018121618.778385-1-wangzhaolong1@huawei.com> <1381458025.20897.1697747248632.JavaMail.zimbra@nod.at> <891e554b-c133-6378-3a65-836fc9147e54@huawei.com>
Subject: Re: [PATCH v2] ubi: gluebi: Fix NULL pointer dereference caused by
 ftl notifier
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: gluebi: Fix NULL pointer dereference caused by ftl notifier
Thread-Index: 2PTLgou/05+/uw7nwcEWecaps0pTog==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "chengzhihao1" <chengzhihao1@huawei.com>
>>> Such a modification currently works because the mutex "mtd_table_mutex"
>>> is held on all necessary paths, including the ftl_add_mtd() call path,
>>> open and close paths. Therefore, many race condition can be avoided.
>> 
>> I see the problem, but I'm not really satisfied by the solution.
>> Adding this hack to gluebi_read() is not nice at all.
> 
> Yes, it's jsut a workaround. At the begining, I prefer that increasing
> volume refcnt (by ubi_open_volume) in gluebi_create and releasing volume
> refcnt in gluebi_remove. It looks more reasonable that holding a refcnt
> of UBI volume when gluebi is alive. After looking through the code, the
> creation/destroying of gluebi is triggered by volume
> actions(UBI_VOLUME_ADDED/UBI_VOLUME_REMOVED), which means that:
> 1. gluebi_remove is depended on UBI_VOLUME_REMOVED(triggered by
> ubi_remove_volume)
> 2. ubi_remove_volume won't be executed until the refcnt of volume
> becomes 0(released by gluebi_remove)
> 
> If we add new ioctls to control creation/destroying of gluebi, then
> gluebi mtd won't be automatically created when UBI volume is added. I'm
> not certain whether this change will effect existing startup process
> that depends on gluebi.

Let's take a stack back. The sole purpose of gluebi is providing
a way to run JFFS2 on top of UBI.
IMHO there is no need to run an FTL on top of UBI or even mtdblock.
This kind of stacking does not make sense.

So, I'd go so far and propose the following:
diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index ff18636e08897..b362a64411ebd 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -463,7 +463,7 @@ static void blktrans_notify_add(struct mtd_info *mtd)
 {
        struct mtd_blktrans_ops *tr;
 
-       if (mtd->type == MTD_ABSENT)
+       if (mtd->type == MTD_ABSENT || mtd->type == MTD_UBIVOLUME)
                return;
 
        list_for_each_entry(tr, &blktrans_majors, list)

IOW, no mtdblock (hence, also no FTLs) on top of gluebi.

What do you guys think?

Thanks,
//richard
