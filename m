Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE09E7BAB9C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Oct 2023 22:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231714AbjJEUqw convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Thu, 5 Oct 2023 16:46:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjJEUqr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Oct 2023 16:46:47 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8302B93;
        Thu,  5 Oct 2023 13:46:44 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3C9B06340DEC;
        Thu,  5 Oct 2023 22:46:42 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id pxjMnQh4blOb; Thu,  5 Oct 2023 22:46:41 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BEEE46340DF3;
        Thu,  5 Oct 2023 22:46:41 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 4Jkbwh50XZ7F; Thu,  5 Oct 2023 22:46:41 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 895696340DEC;
        Thu,  5 Oct 2023 22:46:41 +0200 (CEST)
Date:   Thu, 5 Oct 2023 22:46:41 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <1863543078.49676.1696538801349.JavaMail.zimbra@nod.at>
In-Reply-To: <226381209.31782.1696362327615.JavaMail.zimbra@nod.at>
References: <cover.1691717480.git.daniel@makrotopia.org> <df8cfc16a0047c1041a8f8d0069c6312bb83da0d.1691717480.git.daniel@makrotopia.org> <226381209.31782.1696362327615.JavaMail.zimbra@nod.at>
Subject: Re: [PATCH v4 5/8] mtd: ubi: attach MTD partition from device-tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: attach MTD partition from device-tree
Thread-Index: kqr0xqm+jR+lBv0FwDpbk9UYfLM3MSkaKwBk
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "richard" <richard@nod.at>
> ----- Ursprüngliche Mail -----
>> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
>> index e0618bbde3613..99b5f502c9dbc 100644
>> --- a/drivers/mtd/ubi/block.c
>> +++ b/drivers/mtd/ubi/block.c
>> @@ -470,7 +470,7 @@ int ubiblock_remove(struct ubi_volume_info *vi, bool force)
>> 	}
>> 
>> 	/* Found a device, let's lock it so we can check if it's busy */
>> -	mutex_lock(&dev->dev_mutex);
>> +	mutex_lock_nested(&dev->dev_mutex, SINGLE_DEPTH_NESTING);
> 
> The usage of mutex_lock_nested() in this patch looks fishy.
> Can you please elaborate a bit more why all these mutexes can be taken twice?
> (Any why not more often).

I think I figured myself.
ubiblock_ops->open() and ->release() are both called with disk->open_mutex held.
ubiblock_open() and ubiblock_release() take dev->dev_mutex.
So, the locking order is open_mutex, followed by dev_mutex.

On the other hand, ubiblock_remove() is called via UBI notify.
It takes first dev_mutex and then calls del_gendisk() which will trigger ubiblock_ops->release()
under disk->open_mutex but takes dev_mutex again.
So, we this not only takes a lock twice but also in reverse order.
mutex_lock_nested() might silence lockdep but I'm not sure whether this is safe at all.

Thanks,
//richard
