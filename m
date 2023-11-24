Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FF237F6BD7
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 06:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230205AbjKXFxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 00:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXFxt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 00:53:49 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23E5E189
        for <linux-kernel@vger.kernel.org>; Thu, 23 Nov 2023 21:53:56 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66C6BC433C8;
        Fri, 24 Nov 2023 05:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700805235;
        bh=ooIeM9zrPd8Y6XlkSVUl/UIr5uogzou+iMHiysRXOmI=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=pvjVf3eA1p3rHJkqINuxxR4IP8hMbx8P8QVIV4YR5N39wRw0FTq/1AIz+cwLh6EGB
         ANTyDwmH+VuKddT+AhnSljiU34hUSmDg6/GDU90UM9//u6Tef8D+mXOQAi9iIPlECd
         Twigc69OQSiyOCn0IJTl+eecOz2jhA7qTJvTw7VAlT0oIaSsDg/1PpzT9uTHQOHhRb
         5SAV8k/uq2OWe+WImgPiNt8NrzeUNJ+W4rTEDMxzq0M1bCLzAaNq7DzNaRS/Wurpr5
         jP1y1RbaTtVZlmxZ32TFV7dbXEC6X4mVInKw9S/43DQRztmPPEqALBZQQt4jdZ4pcD
         lnZcpVeSVRrzw==
Message-ID: <160ecdfc-cb58-47fe-b9ce-fd126acc10fe@kernel.org>
Date:   Fri, 24 Nov 2023 14:53:52 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] block: ioprio: Fix ioprio_check_cap() validation logic
To:     Wei Gao <wegao@suse.com>, axboe@kernel.dk, hare@suse.de,
        hch@lst.de, niklas.cassel@wdc.com, martin.petersen@oracle.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231124030525.31426-1-wegao@suse.com>
Content-Language: en-US
From:   Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231124030525.31426-1-wegao@suse.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/24/23 12:05, Wei Gao wrote:
> The current logic "if (level >= IOPRIO_NR_LEVELS)" can not be reached since
> level value get from IOPRIO_PRIO_LEVEL ONLY extract lower 3-bits of ioprio.
> (IOPRIO_NR_LEVELS=8)
> 
> So this trigger LTP test case ioprio_set03 failed, the test case expect
> error when set IOPRIO_CLASS_BE prio 8, in current implementation level
> value will be 0 and obviously can not return error.
> 
> Fixes: eca2040972b4 ("scsi: block: ioprio: Clean up interface definition")

No. Please see below.

> Signed-off-by: Wei Gao <wegao@suse.com>
> ---
>  block/ioprio.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/block/ioprio.c b/block/ioprio.c
> index b5a942519a79..f83029208f2a 100644
> --- a/block/ioprio.c
> +++ b/block/ioprio.c
> @@ -33,7 +33,7 @@
>  int ioprio_check_cap(int ioprio)
>  {
>  	int class = IOPRIO_PRIO_CLASS(ioprio);
> -	int level = IOPRIO_PRIO_LEVEL(ioprio);
> +	int data = IOPRIO_PRIO_DATA(ioprio);
>  
>  	switch (class) {
>  		case IOPRIO_CLASS_RT:
> @@ -49,13 +49,13 @@ int ioprio_check_cap(int ioprio)
>  			fallthrough;
>  			/* rt has prio field too */
>  		case IOPRIO_CLASS_BE:
> -			if (level >= IOPRIO_NR_LEVELS)
> +			if (data >= IOPRIO_NR_LEVELS || data < 0)

This is incorrect: data is the combination of level AND hints, so that value can
be larger than or equal to 8 with the level still being valid. Hard NACK on this.

The issue with LTP test case has been fixed in LTP and by changing the ioprio.h
header file. See commit 01584c1e2337 ("scsi: block: Improve ioprio value
validity checks") which introduces IOPRIO_BAD_VALUE() macro for that.

And for ltp, the commits are:
6b7f448fe392 ("ioprio: Use IOPRIO_PRIO_NUM to check prio range")
7c84fa710f75 ("ioprio: use ioprio.h kernel header if it exists")

So please update your setup, including your install of kernel user API header files.

>  				return -EINVAL;
>  			break;
>  		case IOPRIO_CLASS_IDLE:
>  			break;
>  		case IOPRIO_CLASS_NONE:
> -			if (level)
> +			if (data)
>  				return -EINVAL;
>  			break;
>  		case IOPRIO_CLASS_INVALID:

-- 
Damien Le Moal
Western Digital Research

