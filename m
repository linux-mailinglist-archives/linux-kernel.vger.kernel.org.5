Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C33B7DC9E2
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 10:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233505AbjJaJu2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 05:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233376AbjJaJu0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 05:50:26 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB33D8
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 02:50:24 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 430EEC433AB;
        Tue, 31 Oct 2023 09:50:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698745823;
        bh=OlMrY7oZ/6Z2nIBcG5vF+ufFHpFb2aWAU2sHwBAa5P4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RlqwKnSAjyoT1pAZWgYrIK6K2QJT4kbhdfN0ds59/5EdyhH/Jjm3P6z4aYjZ0zhIt
         iheJ8L41sAa1OgyrsX1YmnQFguB38Al/wTs1z7ySHiv5w6y2FhK0ZnqDDlSL1NwNKi
         NF/VTNn0GcoY1lx3Fhl0eRjfY9ki1crIxFaP5NsU=
Date:   Tue, 31 Oct 2023 10:50:20 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Yu Wang <quic_yyuwang@quicinc.com>
Cc:     johannes@sipsolutions.net, rafael@kernel.org,
        linux-kernel@vger.kernel.org, kernel@quicinc.com
Subject: Re: [PATCH] Devcoredump: fix use-after-free issue when releasing
 devcd device
Message-ID: <2023103128-grumbly-yin-7d50@gregkh>
References: <20231027055521.2679-1-quic_yyuwang@quicinc.com>
 <2023102757-spree-unruly-dcd6@gregkh>
 <df7d1881-2e8f-43e5-a589-cacfb26138ab@quicinc.com>
 <2023103126-matchless-overview-3558@gregkh>
 <aaec829c-26a3-439a-a83c-96c3fa057752@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aaec829c-26a3-439a-a83c-96c3fa057752@quicinc.com>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 31, 2023 at 05:41:29PM +0800, Yu Wang wrote:
> 
> 
> On 10/31/2023 3:39 PM, Greg KH wrote:
> > On Tue, Oct 31, 2023 at 03:15:12PM +0800, Yu Wang wrote:
> >>
> >>
> >> On 10/27/2023 7:12 PM, Greg KH wrote:
> >>> On Thu, Oct 26, 2023 at 10:55:21PM -0700, Yu Wang wrote:
> >>>> With sample code as below, it may hit use-after-free issue when
> >>>> releasing devcd device.
> >>>>
> >>>>     struct my_coredump_state {
> >>>>         struct completion dump_done;
> >>>>         ...
> >>>>     };
> >>>>
> >>>>     static void my_coredump_free(void *data)
> >>>>     {
> >>>>         struct my_coredump_state *dump_state = data;
> >>>>         ...
> >>>>         complete(&dump_state->dump_done);
> >>>>     }
> >>>>
> >>>>     static void my_dev_release(struct device *dev)
> >>>>     {
> >>>>         kfree(dev);
> >>>>     }
> >>>>
> >>>>     static void my_coredump()
> >>>>     {
> >>>>         struct my_coredump_state dump_state;
> >>>>         struct device *new_device =
> >>>>             kzalloc(sizeof(*new_device), GFP_KERNEL);
> >>>>
> >>>>         ...
> >>>>         new_device->release = my_dev_release;
> >>>>         device_initialize(new_device);
> >>>>         ...
> >>>>         device_add(new_device);
> >>>>         ...
> >>>>         init_completion(&dump_state.dump_done);
> >>>>         dev_coredumpm(new_device, NULL, &dump_state, datalen, GFP_KERNEL,
> >>>>                       my_coredump_read, my_coredump_free);
> >>>>         wait_for_completion(&dump_state.dump_done);
> >>>>         device_del(new_device);
> >>>>         put_device(new_device);
> >>>>     }
> >>>>
> >>>> In devcoredump framework, devcd_dev_release() will be called when
> >>>> releasing the devcd device, it will call the free() callback first
> >>>> and try to delete the symlink in sysfs directory of the failing device.
> >>>> Eventhough it has checked 'devcd->failing_dev->kobj.sd' before that,
> >>>> there is no mechanism to ensure it's still available when accessing
> >>>> it in kernfs_find_ns(), refer to the diagram as below:
> >>>>
> >>>>     Thread A was waiting for 'dump_state.dump_done' at #A-1-2 after
> >>>>     calling dev_coredumpm().
> >>>>     When thread B calling devcd->free() at #B-2-1, it wakes up
> >>>>     thread A from point #A-1-2, which will call device_del() to
> >>>>     delete the device.
> >>>>     If #B-2-2 comes before #A-3-1, but #B-4 comes after #A-4, it
> >>>>     will hit use-after-free issue when trying to access
> >>>>     'devcd->failing_dev->kobj.sd'.
> >>>>
> >>>>     #A-1-1: dev_coredumpm()
> >>>>       #A-1-2: wait_for_completion(&dump_state.dump_done)
> >>>>       #A-1-3: device_del()
> >>>>         #A-2: kobject_del()
> >>>>           #A-3-1: sysfs_remove_dir() --> set kobj->sd=NULL
> >>>>           #A-3-2: kernfs_put()
> >>>>             #A-4: kmem_cache_free() --> free kobj->sd
> >>>>
> >>>>     #B-1: devcd_dev_release()
> >>>>       #B-2-1: devcd->free(devcd->data)
> >>>>       #B-2-2: check devcd->failing_dev->kobj.sd
> >>>>       #B-2-3: sysfs_delete_link()
> >>>>         #B-3: kernfs_remove_by_name_ns()
> >>>>           #B-4: kernfs_find_ns() --> access devcd->failing_dev->kobj.sd
> >>>>
> >>>> To fix this issue, put operations on devcd->failing_dev before
> >>>> calling the free() callback in devcd_dev_release().
> >>>>
> >>>> Signed-off-by: Yu Wang <quic_yyuwang@quicinc.com>
> >>>> ---
> >>>>  drivers/base/devcoredump.c | 5 ++---
> >>>>  1 file changed, 2 insertions(+), 3 deletions(-)
> >>>
> >>> Also, what commit id does this fix?
> >>
> >> Thanks for your comment :)
> >> Do you mean the commit which introduced this issue? It's from initial version of devcoredump.c.
> > 
> > Ok, but then what in-kernel code has the above pattern to cause this
> > "problem"?  Why not fix that up?
> > 
> We use this API as below:
> <Create a device> -> <submit dump on it and wait for completion> -> <Remove the device>.

What device are you creating?  What driver does this?

> The difference with the in-kernel code is that the time between <submit dump on it and wait for completion>
> and <remove the device> is very short and causes race between sysfs_delete_link() and device_del().
> I think devcoredump framework should also cover this case.

I think you shouldn't abuse the api as are you sure this is what it was
actually designed for? :)

Perhaps your "wait for completion really isn't waiting long enough?
Rememember, you never really know when a device is going to be removed,
that's out of your control due to reference counting.  You are doing the
reference counting correct, right?  Pointers to the code that uses this
would be appreciated.

thanks,

greg k-h
