Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30C1B7B71F4
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 21:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240964AbjJCTpg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 3 Oct 2023 15:45:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjJCTpe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 15:45:34 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C37E9E;
        Tue,  3 Oct 2023 12:45:30 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 4C38C6340DF3;
        Tue,  3 Oct 2023 21:45:28 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 3ulYD1wGVKZI; Tue,  3 Oct 2023 21:45:28 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id EA3E26340E0F;
        Tue,  3 Oct 2023 21:45:27 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id mJfZ--EnOnn8; Tue,  3 Oct 2023 21:45:27 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id C40526340DF3;
        Tue,  3 Oct 2023 21:45:27 +0200 (CEST)
Date:   Tue, 3 Oct 2023 21:45:27 +0200 (CEST)
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
Message-ID: <226381209.31782.1696362327615.JavaMail.zimbra@nod.at>
In-Reply-To: <df8cfc16a0047c1041a8f8d0069c6312bb83da0d.1691717480.git.daniel@makrotopia.org>
References: <cover.1691717480.git.daniel@makrotopia.org> <df8cfc16a0047c1041a8f8d0069c6312bb83da0d.1691717480.git.daniel@makrotopia.org>
Subject: Re: [PATCH v4 5/8] mtd: ubi: attach MTD partition from device-tree
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: attach MTD partition from device-tree
Thread-Index: kqr0xqm+jR+lBv0FwDpbk9UYfLM3MQ==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
> index e0618bbde3613..99b5f502c9dbc 100644
> --- a/drivers/mtd/ubi/block.c
> +++ b/drivers/mtd/ubi/block.c
> @@ -470,7 +470,7 @@ int ubiblock_remove(struct ubi_volume_info *vi, bool force)
> 	}
> 
> 	/* Found a device, let's lock it so we can check if it's busy */
> -	mutex_lock(&dev->dev_mutex);
> +	mutex_lock_nested(&dev->dev_mutex, SINGLE_DEPTH_NESTING);

The usage of mutex_lock_nested() in this patch looks fishy.
Can you please elaborate a bit more why all these mutexes can be taken twice?
(Any why not more often).

Thanks,
//richard
