Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427B67D960F
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345739AbjJ0LMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345727AbjJ0LMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:12:14 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 268C2194
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 04:12:12 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46FE4C433C8;
        Fri, 27 Oct 2023 11:12:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698405131;
        bh=5SfLpsNjYKsmFGqhrTveGezl3NSTwchqI/ptUgfCG6Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1r+k+tzUq4hL0SGIGwLFtCbwT6E2Q8/lK7YWA+N4NypNE+hblQqnGmsdc2ICMfTym
         aYWQaAGyY7OEEWykxxxBmEZtCMsN/iw786HzKRwTgDcTIsWA0cdYL86JN9hTpIdULs
         TQo4FBreXYwEPZUFogzuhyHTmIZtfyu20SVjWJXQ=
Date:   Fri, 27 Oct 2023 13:12:08 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Wang <quic_yyuwang@quicinc.com>
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Message-ID: <2023102757-spree-unruly-dcd6@gregkh>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 10:55:21PM -0700, Yu Wang wrote:
> With sample code as below, it may hit use-after-free issue when
> releasing devcd device.
> 
>     struct my_coredump_state {
>         struct completion dump_done;
>         ...
>     };
> 
>     static void my_coredump_free(void *data)
>     {
>         struct my_coredump_state *dump_state = data;
>         ...
>         complete(&dump_state->dump_done);
>     }
> 
>     static void my_dev_release(struct device *dev)
>     {
>         kfree(dev);
>     }
> 
>     static void my_coredump()
>     {
>         struct my_coredump_state dump_state;
>         struct device *new_device =
>             kzalloc(sizeof(*new_device), GFP_KERNEL);
> 
>         ...
>         new_device->release = my_dev_release;
>         device_initialize(new_device);
>         ...
>         device_add(new_device);
>         ...
>         init_completion(&dump_state.dump_done);
>         dev_coredumpm(new_device, NULL, &dump_state, datalen, GFP_KERNEL,
>                       my_coredump_read, my_coredump_free);
>         wait_for_completion(&dump_state.dump_done);
>         device_del(new_device);
>         put_device(new_device);
>     }
> 
> In devcoredump framework, devcd_dev_release() will be called when
> releasing the devcd device, it will call the free() callback first
> and try to delete the symlink in sysfs directory of the failing device.
> Eventhough it has checked 'devcd->failing_dev->kobj.sd' before that,
> there is no mechanism to ensure it's still available when accessing
> it in kernfs_find_ns(), refer to the diagram as below:
> 
>     Thread A was waiting for 'dump_state.dump_done' at #A-1-2 after
>     calling dev_coredumpm().
>     When thread B calling devcd->free() at #B-2-1, it wakes up
>     thread A from point #A-1-2, which will call device_del() to
>     delete the device.
>     If #B-2-2 comes before #A-3-1, but #B-4 comes after #A-4, it
>     will hit use-after-free issue when trying to access
>     'devcd->failing_dev->kobj.sd'.
> 
>     #A-1-1: dev_coredumpm()
>       #A-1-2: wait_for_completion(&dump_state.dump_done)
>       #A-1-3: device_del()
>         #A-2: kobject_del()
>           #A-3-1: sysfs_remove_dir() --> set kobj->sd=NULL
>           #A-3-2: kernfs_put()
>             #A-4: kmem_cache_free() --> free kobj->sd
> 
>     #B-1: devcd_dev_release()
>       #B-2-1: devcd->free(devcd->data)
>       #B-2-2: check devcd->failing_dev->kobj.sd
>       #B-2-3: sysfs_delete_link()
>         #B-3: kernfs_remove_by_name_ns()
>           #B-4: kernfs_find_ns() --> access devcd->failing_dev->kobj.sd
> 
> To fix this issue, put operations on devcd->failing_dev before
> calling the free() callback in devcd_dev_release().
> 
> Signed-off-by: Yu Wang <quic_yyuwang@quicinc.com>
> ---
>  drivers/base/devcoredump.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)

Also, what commit id does this fix?

thanks,

greg k-h
