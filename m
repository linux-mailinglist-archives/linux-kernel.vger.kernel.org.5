Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2F17AD454
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 11:14:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232764AbjIYJPA convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 25 Sep 2023 05:15:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232574AbjIYJO6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 05:14:58 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B87DAB
        for <linux-kernel@vger.kernel.org>; Mon, 25 Sep 2023 02:14:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id D28EB635DB51;
        Mon, 25 Sep 2023 11:14:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id cwlQYeZ-qSy9; Mon, 25 Sep 2023 11:14:40 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 80AE3622F591;
        Mon, 25 Sep 2023 11:14:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wy4TAeGHhR-E; Mon, 25 Sep 2023 11:14:40 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5D5FD635DB51;
        Mon, 25 Sep 2023 11:14:40 +0200 (CEST)
Date:   Mon, 25 Sep 2023 11:14:40 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     ZhaoLong Wang <wangzhaolong1@huawei.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        chengzhihao1 <chengzhihao1@huawei.com>,
        yi zhang <yi.zhang@huawei.com>, yangerkun@huawei.com,
        Miquel Raynal <miquel.raynal@bootlin.com>
Message-ID: <495954216.80155.1695633280285.JavaMail.zimbra@nod.at>
In-Reply-To: <20230925104938.3f7b4284@xps-13>
References: <20230923005856.2538223-1-wangzhaolong1@huawei.com> <20230925104938.3f7b4284@xps-13>
Subject: Re: [RFC] mtd: Fix error code loss in mtdchar_read() function.
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Fix error code loss in mtdchar_read() function.
Thread-Index: TtuXiU41OYpt7ia3mZdS86/izvLuwg==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
>> 'total_retlen' is 0, not the error code.
> 
> Actually after looking at the code, I have no strong opinion
> regarding whether we should return 0 or an error code in this case.
> 
> There is this comment right above, and I'm not sure it is still up to
> date because I believe many drivers just don't provide the data upon
> ECC error:
> 
>                /* Nand returns -EBADMSG on ECC errors, but it returns
>                 * the data. For our userspace tools it is important
>                 * to dump areas with ECC errors!
>                 * For kernel internal usage it also might return -EUCLEAN
>                 * to signal the caller that a bitflip has occurred and has
>                 * been corrected by the ECC algorithm.
>                 * Userspace software which accesses NAND this way
>                 * must be aware of the fact that it deals with NAND
>                 */
> 
>> This problem causes the user-space program to encounter EOF when it has
>> not finished reading the mtd partion, and this also violates the read
>> system call standard in POSIX.

This is a special purpose device file and not a regular file.
Please explain in detail why this violates POSIX and which program breaks.

As pointed out by Miquel, the comment makes it clean that this behavior is
on purpose. If we return now all of a sudden -EBADMSG for the described
scenario we might even break existing MTD userspace.

Thanks,
//richard
