Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E538B7DC9B7
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343931AbjJaJgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:36:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343942AbjJaJgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:36:01 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8EC13B7;
        Tue, 31 Oct 2023 02:35:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 13A1FC15;
        Tue, 31 Oct 2023 02:36:40 -0700 (PDT)
Received: from [10.1.34.45] (unknown [10.1.34.45])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB5323F67D;
        Tue, 31 Oct 2023 02:35:56 -0700 (PDT)
Message-ID: <b50c2963-8eae-452f-98c6-03293bcca1a2@arm.com>
Date:   Tue, 31 Oct 2023 09:35:54 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH next] dm delay: Fix missing error code in delay_ctr()
Content-Language: en-US
To:     Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, dm-devel@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     dan.carpenter@linaro.org, kernel-janitors@vger.kernel.org,
        error27@gmail.com
References: <20231031071000.374939-1-harshit.m.mogalapalli@oracle.com>
From:   Christian Loehle <christian.loehle@arm.com>
In-Reply-To: <20231031071000.374939-1-harshit.m.mogalapalli@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/10/2023 07:10, Harshit Mogalapalli wrote:
> When worker thread allocation fails, return error instead of
> zero(success).
> 
> Also when kthread_create fails it returns ERR pointers and not NULL, so
> fix that as well.
> 
> Fixes: c1fce71d29b2 ("dm delay: for short delays, use kthread instead of timers and wq")
> Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
> ---
> Smatch complained about the missing error code.
> This patch is only compile tested.
> ---
>  drivers/md/dm-delay.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-delay.c b/drivers/md/dm-delay.c
> index 3d91804923eb..efd510984e25 100644
> --- a/drivers/md/dm-delay.c
> +++ b/drivers/md/dm-delay.c
> @@ -280,8 +280,10 @@ static int delay_ctr(struct dm_target *ti, unsigned int argc, char **argv)
>  		 */
>  		dc->worker = kthread_create(&flush_worker_fn, dc,
>  					    "dm-delay-flush-worker");
> -		if (!dc->worker)
> +		if (IS_ERR(dc->worker)) {
> +			ret = PTR_ERR(dc->worker);
>  			goto bad;
> +		}
>  	} else {
>  		timer_setup(&dc->delay_timer, handle_delayed_timer, 0);
>  		INIT_WORK(&dc->flush_expired_bios, flush_expired_bios);
Reviewed-by: Christian Loehle <christian.loehle@arm.com>

Thanks!
