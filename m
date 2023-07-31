Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9AB7768B5D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jul 2023 07:50:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229921AbjGaFud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jul 2023 01:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjGaFuc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jul 2023 01:50:32 -0400
Received: from mx3.molgen.mpg.de (mx3.molgen.mpg.de [141.14.17.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D006E6A;
        Sun, 30 Jul 2023 22:50:30 -0700 (PDT)
Received: from [192.168.0.185] (ip5f5ae862.dynamic.kabel-deutschland.de [95.90.232.98])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id 8F4FE61E5FE01;
        Mon, 31 Jul 2023 07:49:52 +0200 (CEST)
Message-ID: <20327acc-e203-9a16-0ff4-f4e49e44c899@molgen.mpg.de>
Date:   Mon, 31 Jul 2023 07:49:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH -next] md/raid10: fix a 'conf->barrier' leakage in
 raid10_takeover()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     song@kernel.org, yukuai3@huawei.com, linux-raid@vger.kernel.org,
        linux-kernel@vger.kernel.org, yi.zhang@huawei.com,
        yangerkun@huawei.com
References: <20230731022800.1424902-1-yukuai1@huaweicloud.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20230731022800.1424902-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Yu,


Thank you for your patch. Some minor style comments for the commit 
message, you can also ignore.

Am 31.07.23 um 04:28 schrieb Yu Kuai:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> After commit 4d27e927344a ("md: don't quiesce in mddev_suspend()"),
> 'conf->barrier' will be leaked in the case that raid10 takeover raid0:
> 
> level_store
>   pers->takeover -> raid10_takeover
>    raid10_takeover_raid0
>     WRITE_ONCE(conf->barrier, 1)
> 
> mddev_suspend
> // still raid0
> mddev->pers = pers
> // switch to raid10
> mddev_resume
> // resume without suspend
> 
> After the above commit, mddev_resume() will not decrease 'conf->barrier'
> that is set in raid10_takeover_raid0().
> 
> Fix this problem by remove the setting of 'conf->barrier' from

removing

or

… by not setting `conf->barrier` in …

> raid10_takeover_raid0().
> 
> By the way, this problem is found while I'm trying to make
> mddev_suspend/resume() to be independent from raid personalities. rai10

rai*d*

> is the only personality to use reference count in the quiesce() callback
> and this problem is only related to raid10.
> 
> Fixes: 4d27e927344a ("md: don't quiesce in mddev_suspend()")
> Signed-off-by: Yu Kuai <yukuai3@huawei.com>
> ---
>   drivers/md/raid10.c | 1 -
>   1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/md/raid10.c b/drivers/md/raid10.c
> index 16aa9d735880..7704a4c7f469 100644
> --- a/drivers/md/raid10.c
> +++ b/drivers/md/raid10.c
> @@ -4417,7 +4417,6 @@ static void *raid10_takeover_raid0(struct mddev *mddev, sector_t size, int devs)
>   				rdev->new_raid_disk = rdev->raid_disk * 2;
>   				rdev->sectors = size;
>   			}
> -		WRITE_ONCE(conf->barrier, 1);
>   	}
>   
>   	return conf;

Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>


Kind regards,

Paul
