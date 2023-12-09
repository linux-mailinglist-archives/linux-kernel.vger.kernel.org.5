Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69480B50C
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Dec 2023 16:27:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231394AbjLIP06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Dec 2023 10:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjLIP04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Dec 2023 10:26:56 -0500
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8383FB
        for <linux-kernel@vger.kernel.org>; Sat,  9 Dec 2023 07:27:02 -0800 (PST)
Received: from [192.168.1.18] ([92.140.202.140])
        by smtp.orange.fr with ESMTPA
        id BzEFrOMQyNKQIBzEGrkMX9; Sat, 09 Dec 2023 16:27:01 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1702135621;
        bh=qbef5jn99LixpSHbxUw4//EMooebEcS8svrn6x7ih6g=;
        h=Date:Subject:To:References:From:In-Reply-To;
        b=oaKQ3/SeLivCKoqOioUutWGpW+pS8fECF4Tw7o2Ziqr9bI1sLNBvB3cjy114OyfHe
         2AoZ+gDNliF53OqWhSv1vv5JPGb1vcs0qDpMvOcZzRdcyOFtWLmPiKbqE5Frl9dC38
         zgW2S22RNRiy03PDm0yU5msI94QlhpmNv+fiSrft5UPJeSVcA5nN37RW+HOZ6VS2x5
         3QO4kmDUG5RQJujXxO6crZDAqPqV3ZTkPhxeKeteoXDAyjzzxiq2DBVGt9nByf3BOF
         6/qeb8D0Bx/Xm4L8zXpi1lGUPh740CUDSaime8nr1I/PmhFIEiqWI88ROLXSzmSBuW
         Ky9qmPoYtCcpw==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sat, 09 Dec 2023 16:27:01 +0100
X-ME-IP: 92.140.202.140
Message-ID: <7078bc2e-7029-4abe-b970-3a6b83e10c53@wanadoo.fr>
Date:   Sat, 9 Dec 2023 16:26:54 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] PM / sleep: Mechanism to find source aborting kernel
 suspend transition
Content-Language: fr
To:     Vimal Kumar <vimal.kumar32@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231209081056.1497-1-vimal.kumar32@gmail.com>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231209081056.1497-1-vimal.kumar32@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 09/12/2023 à 09:10, Vimal Kumar a écrit :
> Sometimes kernel suspend transitions can be aborted unconditionally by
> manipulating pm_abort_suspend value using "hard" wakeup triggers or
> through "pm_system_wakeup()".
> 
> There is no way to trace the source path of module or subsystem which
> aborted the suspend transitions. This change will create a list of
> wakeup sources aborting suspend in progress through "hard" events as
> well as subsytems aborting suspend using "pm_system_wakeup()".
> 
> Example: Existing suspend failure logs:
> [  349.708359] PM: Some devices failed to suspend, or early wake event detected
> [  350.327842] PM: suspend exit
> 
> Suspend failure logs with this change:
> [  518.761835] PM: Some devices failed to suspend, or early wake event detected
> [  519.486939] Abort: ws or subsystem uart_suspend_port aborted suspend
> [  519.500594] PM: suspend exit
> 
> Here we can clearly identify the module triggerring abort suspend.
> 
> Co-developed-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Signed-off-by: Chinmoy Ghosh <chinmoyghosh2001@gmail.com>
> Co-developed-by: Mintu Patel <mintupatel89@gmail.com>
> Signed-off-by: Mintu Patel <mintupatel89@gmail.com>
> Co-developed-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vishal Badole <badolevishal1116@gmail.com>
> Signed-off-by: Vimal Kumar <vimal.kumar32@gmail.com>
> ---

...

> +void pm_add_abort_suspend_source(const char *source_name)
> +{
> +	struct pm_abort_suspend_source *info = NULL;

No need to init.

> +
> +	info = kmalloc(sizeof(struct pm_abort_suspend_source), GFP_KERNEL);

Could be sizeof(*info).

> +	if (unlikely(!info)) {
> +		pr_err("Failed to alloc memory for pm_abort_suspend_source info\n");

No need to log a message if kmalloc() fails, a trace is already logged.

> +		return;
> +	}
> +
> +	/* Initialize the list within the struct if it's not already initialized */
> +	if (list_empty(&info->list))
> +		INIT_LIST_HEAD(&info->list);
> +
> +	info->source_triggering_abort_suspend = kstrdup(source_name, GFP_KERNEL);
> +	if (unlikely(!info->source_triggering_abort_suspend)) {
> +		pr_err("Failed to get abort_suspend source_name\n");

Same here.

> +		kfree(info);
> +		return;
> +	}
> +
> +	list_add_tail(&info->list, &pm_abort_suspend_list);

...

CJ

