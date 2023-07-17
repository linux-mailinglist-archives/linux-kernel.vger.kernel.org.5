Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B4E756109
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 13:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbjGQLDP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 17 Jul 2023 07:03:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjGQLDN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 07:03:13 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7DF6E48
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 04:03:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 26144634203B;
        Mon, 17 Jul 2023 13:03:10 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id fG7YnavCyVgh; Mon, 17 Jul 2023 13:03:09 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id AB868634203A;
        Mon, 17 Jul 2023 13:03:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id B_LkhE8nHIJf; Mon, 17 Jul 2023 13:03:09 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 829A66342026;
        Mon, 17 Jul 2023 13:03:09 +0200 (CEST)
Date:   Mon, 17 Jul 2023 13:03:09 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Stephan Wurm <stephan.wurm@a-eberle.de>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Johannes Eigner <johannes.eigner@a-eberle.de>
Message-ID: <260741266.3681.1689591789332.JavaMail.zimbra@nod.at>
In-Reply-To: <ZLUXruUkYMrPK+GQ@PC-LX-Wurm>
References: <ZLT2qEYjaWgSpRD6@PC-LX-Wurm> <736980270.3262.1689586950735.JavaMail.zimbra@nod.at> <ZLUXruUkYMrPK+GQ@PC-LX-Wurm>
Subject: Re: ubiblock: null pointer dereference using scatterlist in
 work_queue
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: ubiblock: null pointer dereference using scatterlist in work_queue
Thread-Index: ss6EAmPjKXAVOTJ0bHjviSj8oPd3/Q==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephan,

----- Ursprüngliche Mail -----
> Von: "Stephan Wurm" <stephan.wurm@a-eberle.de>
>> So reading from ubiblock works as long you don't access it via dm-verity?
>> How about other stacked devices such as dmcrypt?
> 
> We did not check other stacked devices, but we'll give this a try.

Please apply this patch too:

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 75eaecc8639f0..795e2d0f61086 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -304,7 +304,7 @@ static void ubiblock_do_work(struct work_struct *work)
         * the number of sg entries is limited to UBI_MAX_SG_COUNT
         * and ubi_read_sg() will check that limit.
         */
-       blk_rq_map_sg(req->q, req, pdu->usgl.sg);
+       ubi_assert(blk_rq_map_sg(req->q, req, pdu->usgl.sg) > 0);
 
        ret = ubiblock_read(pdu);
 

I fear the assert will fail. But let's see. :-D
At least it would explain the NULL deref.
 
>> Did you print the LEB number, read length and offset in ubiblock_read()?
>> Maybe there is a bug related to setting up the correct device geometry
>> and the read request is off.
> Here is some excerpt from another try with KASAN enabled and full debug output:

Hm, we are within bounds. And looks like other reads worked.

>  ==================================================================
>  [  293.343675] BUG: KASAN: null-ptr-deref in ubi_io_read+0x1d4/0x46c
>  [  293.349822] Read of size 1 at addr 00000000 by task kworker/0:3/18
>  [  293.356037]
>  [  293.357551] CPU: 0 PID: 18 Comm: kworker/0:3 Not tainted 6.1.36 #1
>  [  293.363774] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
>  [  293.370331] Workqueue: ubiblock0_2 ubiblock_do_work
>  [  293.375269]  unwind_backtrace from show_stack+0x10/0x14
>  [  293.380557]  show_stack from dump_stack_lvl+0x34/0x48
>  [  293.385668]  dump_stack_lvl from kasan_report+0xb8/0xe8
>  [  293.390956]  kasan_report from ubi_io_read+0x1d4/0x46c
>  [  293.396146]  ubi_io_read from ubi_eba_read_leb+0x3c4/0x5cc
>  [  293.401686]  ubi_eba_read_leb from ubi_eba_read_leb_sg+0x84/0x1f8
>  [  293.407831]  ubi_eba_read_leb_sg from ubi_leb_read_sg+0xb4/0x110

Can you please double check whether the very first call to ubi_eba_read_leb_sg()
fails or a later one?

Thanks,
//richard
