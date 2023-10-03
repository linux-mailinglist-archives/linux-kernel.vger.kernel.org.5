Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 638417B7098
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 20:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240449AbjJCSOp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 14:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230291AbjJCSOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 14:14:44 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1FB83;
        Tue,  3 Oct 2023 11:14:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 864C16340E0E;
        Tue,  3 Oct 2023 20:14:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id QeJ_hbG7TRXa; Tue,  3 Oct 2023 20:14:36 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 899A36340DF3;
        Tue,  3 Oct 2023 20:14:36 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id MM3kCFtSHPOQ; Tue,  3 Oct 2023 20:14:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5FCBC6340DE8;
        Tue,  3 Oct 2023 20:14:36 +0200 (CEST)
Date:   Tue, 3 Oct 2023 20:14:36 +0200 (CEST)
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
Message-ID: <1553084515.31405.1696356876189.JavaMail.zimbra@nod.at>
In-Reply-To: <bac56760e1abec46e1ca5582fc30cbca1f42af9d.1691717480.git.daniel@makrotopia.org>
References: <cover.1691717480.git.daniel@makrotopia.org> <bac56760e1abec46e1ca5582fc30cbca1f42af9d.1691717480.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 3/8] mtd: ubi: block: don't return on error when
 removing
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: block: don't return on error when removing
Thread-Index: mEjhakoF9gHQlvYZWxhJOUfsm127PA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> An: "Randy Dunlap" <rdunlap@infradead.org>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "richard" <richard@nod.at>,
> "Vignesh Raghavendra" <vigneshr@ti.com>, "Rob Herring" <robh+dt@kernel.org>, "Krzysztof Kozlowski"
> <krzysztof.kozlowski+dt@linaro.org>, "Conor Dooley" <conor+dt@kernel.org>, "Daniel Golle" <daniel@makrotopia.org>,
> "linux-mtd" <linux-mtd@lists.infradead.org>, "devicetree" <devicetree@vger.kernel.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> Gesendet: Freitag, 11. August 2023 03:37:12
> Betreff: [PATCH v4 3/8] mtd: ubi: block: don't return on error when removing

> There is no point on returning the error from ubiblock_remove in case
> it is being called due to a volume removal event -- the volume is gone,
> we should destroy and remove the ubiblock device no matter what.
> 
> Introduce new boolean parameter 'force' to tell ubiblock_remove to go
> on even in case the ubiblock device is still busy. Use that new option
> when calling ubiblock_remove due to a UBI_VOLUME_REMOVED event.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
> drivers/mtd/ubi/block.c | 6 +++---
> drivers/mtd/ubi/cdev.c  | 2 +-
> drivers/mtd/ubi/ubi.h   | 4 ++--
> 3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index 437c5b83ffe51..69fa6fecb8494 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -456,7 +456,7 @@ static void ubiblock_cleanup(struct ubiblock *dev)
> 	idr_remove(&ubiblock_minor_idr, dev->gd->first_minor);
> }
> 
> -int ubiblock_remove(struct ubi_volume_info *vi)
> +int ubiblock_remove(struct ubi_volume_info *vi, bool force)
> {
> 	struct ubiblock *dev;
> 	int ret;
> @@ -470,7 +470,7 @@ int ubiblock_remove(struct ubi_volume_info *vi)
> 
> 	/* Found a device, let's lock it so we can check if it's busy */
> 	mutex_lock(&dev->dev_mutex);
> -	if (dev->refcnt > 0) {
> +	if (dev->refcnt > 0 && !force) {
> 		ret = -EBUSY;
> 		goto out_unlock_dev;

Is it really safe to destroy the blk queue (via ubiblock_cleanup()) if refcnt is > 0?

Thanks,
//richard
