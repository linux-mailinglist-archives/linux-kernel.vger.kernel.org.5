Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB2BC7E383D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 10:53:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233946AbjKGJxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 04:53:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233914AbjKGJx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 04:53:29 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6496011A;
        Tue,  7 Nov 2023 01:53:26 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A14F1C433C7;
        Tue,  7 Nov 2023 09:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699350806;
        bh=DA0JawH4OXqawayuIjowXm96ODaep8O9+ehWDI0jCxY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Lst+1i6gzIOSuXeN/XntOhQ3vjuv8Dnz1NyyPTZUOhU5nsa3mU+4Y6WgtxzwBqlz4
         zPEAC7GBtyUYuqen1cYQjr2KPWLoswcJbJ0sifnviJa3xAxKVrsoDMrexcJw4koj+6
         Kh4vQmvnbWlBHNLk376+R7VAPa4sNg5Pu2WtWaw4=
Date:   Tue, 7 Nov 2023 10:53:23 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     =?iso-8859-1?Q?Jos=E9?= Pekkarinen <jose.pekkarinen@foxhound.fi>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers core: lookup sysfs power group before removal
Message-ID: <2023110706-mustiness-arbitrary-fc9f@gregkh>
References: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
 <2023110139-dupe-snipping-5700@gregkh>
 <835b2930c710381b8da38eca821aa92d@foxhound.fi>
 <2023110353-bring-contented-c9f8@gregkh>
 <e13104c9e55b0bd8eee0a333b3ed7975@foxhound.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e13104c9e55b0bd8eee0a333b3ed7975@foxhound.fi>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 07, 2023 at 10:56:20AM +0200, José Pekkarinen wrote:
> On 2023-11-03 20:36, Greg KH wrote:
> > On Fri, Nov 03, 2023 at 07:49:39PM +0200, José Pekkarinen wrote:
> > > On 2023-11-01 19:54, Greg KH wrote:
> > > > On Wed, Nov 01, 2023 at 07:36:27PM +0200, José Pekkarinen wrote:
> > > > > Hinted by syzboot, there is a few cases where the sysfs power group
> > > > > may
> > > > > not be there, like the failure while adding it, or adding its runtime
> > > > > group, or when the sysfs firmware loader fallback fail to populate. In
> > > > > the last case, the device_del function will be called leading to
> > > > > attempt
> > > > > to remove the sysfs group. This patch will lookup for it in advance to
> > > > > grant that it is effectively there before cleaning it up.
> > > > >
> > > > > Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
> > > > >
> > > > > Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
> > > > > ---
> > > > >  drivers/base/power/sysfs.c | 4 +++-
> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
> > > > > index a1474fb67db9..6601729c4698 100644
> > > > > --- a/drivers/base/power/sysfs.c
> > > > > +++ b/drivers/base/power/sysfs.c
> > > > > @@ -834,5 +834,7 @@ void dpm_sysfs_remove(struct device *dev)
> > > > >  	dev_pm_qos_constraints_destroy(dev);
> > > > >  	rpm_sysfs_remove(dev);
> > > > >  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
> > > > > -	sysfs_remove_group(&dev->kobj, &pm_attr_group);
> > > > > +
> > > > > +	if (kernfs_find_and_get((&dev->kobj)->sd, pm_attr_group.name))
> > > > > +		sysfs_remove_group(&dev->kobj, &pm_attr_group);
> > > >
> > > > What's to keep it from going away right after finding it?
> > > >
> > > > In other words, what is wrong with removing a group that is not there?
> > > > What error happens?  It should be fine, or are you seeing real code
> > > > failures somewhere?
> > > 
> > >     No, this is just hitting a warning that sysbot complains about by
> > > setting panic on warning, no big deal, though it can be a wrong
> > > behaviour
> > > in ueagle-atm driver, since it defines to disconnect the device if the
> > > firmware is not there, no matter the sysfs fallback.
> > 
> > Then fix the driver please.
> 
>     I'm afraid I was wrong in the assumption that the probe return value
> of the driver would influence the testing result, so this no longer seems
> fixable from driver side.

Why is it not fixable from the driver side?  It is the code that is
creating, and then removing, the files, not the driver core, or am I
missing something here?

> It may be fixed here in the base, in the sysfs or not to fix it at all
> since this seem to be a very difficult to reach situation. I'm fine
> with any approach, and I can do the work, I'd just like to read what
> are your preferences on the topic.

Please prove that the driver is not the offending one here first please,
otherwise, why isn't this an issue for all drivers?

thanks,

greg k-h
