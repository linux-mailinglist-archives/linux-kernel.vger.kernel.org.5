Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D796B7B1048
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 03:13:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjI1BNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 21:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjI1BNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 21:13:14 -0400
Received: from mp-relay-02.fibernetics.ca (mp-relay-02.fibernetics.ca [208.85.217.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107DEBF
        for <linux-kernel@vger.kernel.org>; Wed, 27 Sep 2023 18:13:13 -0700 (PDT)
Received: from mailpool-fe-01.fibernetics.ca (mailpool-fe-01.fibernetics.ca [208.85.217.144])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mp-relay-02.fibernetics.ca (Postfix) with ESMTPS id BF92876AA1;
        Thu, 28 Sep 2023 01:13:09 +0000 (UTC)
Received: from localhost (mailpool-mx-01.fibernetics.ca [208.85.217.140])
        by mailpool-fe-01.fibernetics.ca (Postfix) with ESMTP id B269A457E4;
        Thu, 28 Sep 2023 01:13:09 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at 
X-Spam-Score: -0.199
X-Spam-Level: 
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
Received: from mailpool-fe-01.fibernetics.ca ([208.85.217.144])
        by localhost (mail-mx-01.fibernetics.ca [208.85.217.140]) (amavisd-new, port 10024)
        with ESMTP id kEFzXDrP3_UU; Thu, 28 Sep 2023 01:13:08 +0000 (UTC)
Received: from [192.168.48.17] (host-104-157-209-188.dyn.295.ca [104.157.209.188])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dgilbert@interlog.com)
        by mail.ca.inter.net (Postfix) with ESMTPSA id A4F4F457E2;
        Thu, 28 Sep 2023 01:13:06 +0000 (UTC)
Message-ID: <8c7cfe09-d145-4387-91cf-da9d4e2398e1@interlog.com>
Date:   Wed, 27 Sep 2023 21:13:05 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: dgilbert@interlog.com
Subject: Re: [PATCH v5 01/10] scsi: scsi_debug: create scsi_debug directory in
 the debugfs filesystem
Content-Language: en-CA
To:     Wenchao Hao <haowenchao2@huawei.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, louhongxiang@huawei.com
References: <20230922092906.2645265-1-haowenchao2@huawei.com>
 <20230922092906.2645265-2-haowenchao2@huawei.com>
From:   Douglas Gilbert <dgilbert@interlog.com>
In-Reply-To: <20230922092906.2645265-2-haowenchao2@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-09-22 05:28, Wenchao Hao wrote:
> Create directory scsi_debug in the root of the debugfs filesystem.
> Prepare to add interface for manage error injection.
> 
> Acked-by: Douglas Gilbert <dgilbert@interlog.com>
> Signed-off-by: Wenchao Hao <haowenchao2@huawei.com>
> ---
>   drivers/scsi/scsi_debug.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/scsi/scsi_debug.c b/drivers/scsi/scsi_debug.c
> index 9c0af50501f9..35c336271b13 100644
> --- a/drivers/scsi/scsi_debug.c
> +++ b/drivers/scsi/scsi_debug.c
> @@ -41,6 +41,7 @@
>   #include <linux/random.h>
>   #include <linux/xarray.h>
>   #include <linux/prefetch.h>
> +#include <linux/debugfs.h>
>   
>   #include <net/checksum.h>
>   
> @@ -862,6 +863,8 @@ static const int device_qfull_result =
>   
>   static const int condition_met_result = SAM_STAT_CONDITION_MET;
>   
> +static struct dentry *sdebug_debugfs_root;
> +
>   
>   /* Only do the extra work involved in logical block provisioning if one or
>    * more of the lbpu, lbpws or lbpws10 parameters are given and we are doing
> @@ -7011,6 +7014,8 @@ static int __init scsi_debug_init(void)
>   		goto driver_unreg;
>   	}
>   
> +	sdebug_debugfs_root = debugfs_create_dir("scsi_debug", NULL);

debugfs_create_dir() can fail and return NULL. Looking at other drivers, most
seem to assume it will work. Since the scsi_debug driver is often used to test
abnormal situations, perhaps adding something like:
     if (!sdebug_debugfs_root)
         pr_info("%s: failed to create initial debugfs directory\n", __func__);

might save someone a bit of time if a NULL dereference on sdebug_debugfs_root
follows later. That is what the mpt3sas driver does.

Doug Gilbert

> +
>   	for (k = 0; k < hosts_to_add; k++) {
>   		if (want_store && k == 0) {
>   			ret = sdebug_add_host_helper(idx);
> @@ -7057,6 +7062,7 @@ static void __exit scsi_debug_exit(void)
>   
>   	sdebug_erase_all_stores(false);
>   	xa_destroy(per_store_ap);
> +	debugfs_remove(sdebug_debugfs_root);
>   }
>   
>   device_initcall(scsi_debug_init);

