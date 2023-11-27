Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7A157FAB4F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 21:26:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjK0U0B convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 27 Nov 2023 15:26:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbjK0UZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 15:25:59 -0500
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2EBD59
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 12:26:02 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 016D96413F60;
        Mon, 27 Nov 2023 21:26:00 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id uLRVYHk-f5Lg; Mon, 27 Nov 2023 21:25:59 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3013E6340E00;
        Mon, 27 Nov 2023 21:25:59 +0100 (CET)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id K3yrBMph3TqV; Mon, 27 Nov 2023 21:25:59 +0100 (CET)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 0CF816413F60;
        Mon, 27 Nov 2023 21:25:59 +0100 (CET)
Date:   Mon, 27 Nov 2023 21:25:58 +0100 (CET)
From:   Richard Weinberger <richard@nod.at>
To:     Daniel Golle <daniel@makrotopia.org>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Artem Bityutskiy <Artem.Bityutskiy@nokia.com>,
        linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        John Crispin <john@phrozen.org>
Message-ID: <771902199.32600.1701116758852.JavaMail.zimbra@nod.at>
In-Reply-To: <9857609999c5b7196417474938a7a09892cd1612.1701104870.git.daniel@makrotopia.org>
References: <9857609999c5b7196417474938a7a09892cd1612.1701104870.git.daniel@makrotopia.org>
Subject: Re: [PATCH] ubi: don't decrease ubi->ref_count on detach error
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: don't decrease ubi->ref_count on detach error
Thread-Index: chpmDIpsyDGT4mmuCnlwjJ5qLzrYdQ==
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,PDS_BAD_THREAD_QP_64,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Daniel Golle" <daniel@makrotopia.org>
> An: "richard" <richard@nod.at>, "Miquel Raynal" <miquel.raynal@bootlin.com>, "Vignesh Raghavendra" <vigneshr@ti.com>,
> "Artem Bityutskiy" <Artem.Bityutskiy@nokia.com>, "linux-mtd" <linux-mtd@lists.infradead.org>, "linux-kernel"
> <linux-kernel@vger.kernel.org>
> CC: "John Crispin" <john@phrozen.org>
> Gesendet: Montag, 27. November 2023 18:09:14
> Betreff: [PATCH] ubi: don't decrease ubi->ref_count on detach error

> If attempting to detach a UBI device while it is still busy, detaching
> is refused. However, the reference counter is still being decreased
> despite the error. Rework detach function to only decrease the refcnt
> once all conditions for detachment are met.
> 
> Fixes: cdfa788acd13 ("UBI: prepare attach and detach functions")
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>

Good catch! Did you find this by review or while testing?

> ---
> drivers/mtd/ubi/build.c | 6 +++---
> 1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/mtd/ubi/build.c b/drivers/mtd/ubi/build.c
> index 7d4ff1193db6f..f47987ee9a31b 100644
> --- a/drivers/mtd/ubi/build.c
> +++ b/drivers/mtd/ubi/build.c
> @@ -1099,16 +1099,16 @@ int ubi_detach_mtd_dev(int ubi_num, int anyway)
> 
> 	spin_lock(&ubi_devices_lock);
> 	put_device(&ubi->dev);
> -	ubi->ref_count -= 1;
> -	if (ubi->ref_count) {
> +	if (ubi->ref_count > 1) {

Is there a specific reason why you have modified the check to test only
for ref_count being positive?
If rec_counts turns negative, due to a bug, we could still stop it here.

> 		if (!anyway) {
> 			spin_unlock(&ubi_devices_lock);
> 			return -EBUSY;
> 		}
> 		/* This may only happen if there is a bug */
> 		ubi_err(ubi, "%s reference count %d, destroy anyway",
> -			ubi->ubi_name, ubi->ref_count);
> +			ubi->ubi_name, ubi->ref_count - 1);
> 	}
> +	ubi->ref_count -= 1;

Please add there an ubi_asert() which tests whether ref_count is really zero.
...just to be more bullet proof.

Thanks,
//richard
