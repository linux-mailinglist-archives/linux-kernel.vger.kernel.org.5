Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04040790C20
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Sep 2023 15:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237929AbjICNbU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Sep 2023 09:31:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233650AbjICNbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Sep 2023 09:31:19 -0400
Received: from len.romanrm.net (len.romanrm.net [IPv6:2001:41d0:1:8b3b::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 468ABFA
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 06:31:16 -0700 (PDT)
Received: from nvm (nvm2.home.romanrm.net [IPv6:fd39::4a:3cff:fe57:d6b5])
        by len.romanrm.net (Postfix) with SMTP id 908714006E;
        Sun,  3 Sep 2023 13:31:08 +0000 (UTC)
Date:   Sun, 3 Sep 2023 18:30:58 +0500
From:   Roman Mamedov <rm@romanrm.net>
To:     Kuan-Wei Chiu <visitorckw@gmail.com>
Cc:     song@kernel.org, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] md/raid5: eliminate if-statements in cmp_stripe()
Message-ID: <20230903183058.1301b149@nvm>
In-Reply-To: <20230903095059.2683850-1-visitorckw@gmail.com>
References: <20230903095059.2683850-1-visitorckw@gmail.com>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun,  3 Sep 2023 17:50:59 +0800
Kuan-Wei Chiu <visitorckw@gmail.com> wrote:

> Replace the conditional statements in the cmp_stripe() function with a
> branchless version to improve code readability and potentially enhance
> performance.

The new code will always do two comparisons and a subtraction (3
instructions in total), whereas the old version could return after just 1
comparison, or after 2 comparisons. So depending on the data values it is 3x
to 1.5x as much operations performed than before, there unlikely to be any
enhancement of performance.

Also IMO the previous version is more easily readable.

> The new code calculates the result using a subtraction of
> comparison results, making it more concise and avoiding conditional
> branches. This change does not alter the functionality of the code.
> 
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>  drivers/md/raid5.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
> index 4cb9c608ee19..b14d7ba38f0f 100644
> --- a/drivers/md/raid5.c
> +++ b/drivers/md/raid5.c
> @@ -1035,11 +1035,7 @@ static int cmp_stripe(void *priv, const struct list_head *a,
>  				struct r5pending_data, sibling);
>  	const struct r5pending_data *db = list_entry(b,
>  				struct r5pending_data, sibling);
> -	if (da->sector > db->sector)
> -		return 1;
> -	if (da->sector < db->sector)
> -		return -1;
> -	return 0;
> +	return (da->sector > db->sector) - (da->sector < db->sector);
>  }
>  
>  static void dispatch_defer_bios(struct r5conf *conf, int target,


-- 
With respect,
Roman
