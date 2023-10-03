Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FDC7B69AB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 15:01:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjJCNBO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 09:01:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbjJCNBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 09:01:12 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 64DCA93
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 06:01:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ABB561FB;
        Tue,  3 Oct 2023 06:01:47 -0700 (PDT)
Received: from bogus (e103737-lin.cambridge.arm.com [10.1.197.49])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B6FE73F59C;
        Tue,  3 Oct 2023 06:01:08 -0700 (PDT)
Date:   Tue, 3 Oct 2023 14:01:06 +0100
From:   Sudeep Holla <sudeep.holla@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] firmware: arm_ffa: Assign the missing IDR allocation ID
 to the FFA device
Message-ID: <20231003130106.ahzajd46kqyevyex@bogus>
References: <20231003085932.3553985-1-sudeep.holla@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003085932.3553985-1-sudeep.holla@arm.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 09:59:32AM +0100, Sudeep Holla wrote:
> Commit 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical
> partitions") added an ID to the FFA device using ida_alloc() and append
> the same to "arm-ffa" to make up a unique device name. However it missed
> to stash the id value in ffa_dev to help freeing the ID later when the
> device is destroyed.
> 
> Due to the missing/unassigned ID in FFA device, we get the following
> warning when the FF-A device is unregistered. Fix the same by actually
> assigning the ID in the FFA device this time for real.
>

Missed the below warning:

  |   ida_free called for id=0 which is not allocated.
  |   WARNING: CPU: 7 PID: 1 at lib/idr.c:525 ida_free+0x114/0x164
  |   CPU: 7 PID: 1 Comm: swapper/0 Not tainted 6.6.0-rc4 #209
  |   pstate: 61400009 (nZCv daif +PAN -UAO -TCO +DIT -SSBS BTYPE=--)
  |   pc : ida_free+0x114/0x164
  |   lr : ida_free+0x114/0x164
  |   Call trace:
  |    ida_free+0x114/0x164
  |    ffa_release_device+0x24/0x3c
  |    device_release+0x34/0x8c
  |    kobject_put+0x94/0xf8
  |    put_device+0x18/0x24
  |    klist_devices_put+0x14/0x20
  |    klist_next+0xc8/0x114
  |    bus_for_each_dev+0xd8/0x144
  |    arm_ffa_bus_exit+0x30/0x54
  |    ffa_init+0x68/0x330
  |    do_one_initcall+0xdc/0x250
  |    do_initcall_level+0x8c/0xac
  |    do_initcalls+0x54/0x94
  |    do_basic_setup+0x1c/0x28
  |    kernel_init_freeable+0x104/0x170
  |    kernel_init+0x20/0x1a0
  |    ret_from_fork+0x10/0x20

> Fixes: 19b8766459c4 ("firmware: arm_ffa: Fix FFA device names for logical partitions")
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/bus.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/firmware/arm_ffa/bus.c b/drivers/firmware/arm_ffa/bus.c
> index 2b8bfcd010f5..7865438b3696 100644
> --- a/drivers/firmware/arm_ffa/bus.c
> +++ b/drivers/firmware/arm_ffa/bus.c
> @@ -193,6 +193,7 @@ struct ffa_device *ffa_device_register(const uuid_t *uuid, int vm_id,
>  	dev->release = ffa_release_device;
>  	dev_set_name(&ffa_dev->dev, "arm-ffa-%d", id);
>  
> +	ffa_dev->id = id;
>  	ffa_dev->vm_id = vm_id;
>  	ffa_dev->ops = ops;
>  	uuid_copy(&ffa_dev->uuid, uuid);
> -- 
> 2.42.0
> 

-- 
Regards,
Sudeep
