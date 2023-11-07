Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1DD7E472D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 18:37:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjKGRhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 12:37:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbjKGRhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 12:37:09 -0500
Received: from 4.mo560.mail-out.ovh.net (4.mo560.mail-out.ovh.net [87.98.172.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2323B125
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 09:37:07 -0800 (PST)
Received: from director6.ghost.mail-out.ovh.net (unknown [10.109.156.242])
        by mo560.mail-out.ovh.net (Postfix) with ESMTP id BF22128BC8
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 17:20:10 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-ch27t (unknown [10.110.171.220])
        by director6.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 3002E1FD2F;
        Tue,  7 Nov 2023 17:20:10 +0000 (UTC)
Received: from RCM-web9.webmail.mail.ovh.net ([151.80.29.21])
        by ghost-submission-6684bf9d7b-ch27t with ESMTPSA
        id sbZmCcpxSmVvfwEAiK7Wbg
        (envelope-from <jose.pekkarinen@foxhound.fi>); Tue, 07 Nov 2023 17:20:10 +0000
MIME-Version: 1.0
Date:   Tue, 07 Nov 2023 19:20:09 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers core: lookup sysfs power group before removal
In-Reply-To: <2023110706-mustiness-arbitrary-fc9f@gregkh>
References: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
 <2023110139-dupe-snipping-5700@gregkh>
 <835b2930c710381b8da38eca821aa92d@foxhound.fi>
 <2023110353-bring-contented-c9f8@gregkh>
 <e13104c9e55b0bd8eee0a333b3ed7975@foxhound.fi>
 <2023110706-mustiness-arbitrary-fc9f@gregkh>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <e8dccfb0ec240014a98660493aa34fc2@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 45.141.215.21
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 8199366075018552835
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddujedgtdejucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggffhffvvefujghffgfkgihoihgtgfesthekjhdttderjeenucfhrhhomheplfhoshorucfrvghkkhgrrhhinhgvnhcuoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqeenucggtffrrghtthgvrhhnpeekhfeguddufeegvdelgedtvdffgeehvddtkeevkeejvedvgeeitdefleehtdeitdenucfkphepuddvjedrtddrtddruddpgeehrddugedurddvudehrddvuddpudehuddrkedtrddvledrvddunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehinhgvthepuddvjedrtddrtddruddpmhgrihhlfhhrohhmpeeojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehiedtpdhmohguvgepshhmthhpohhuth
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-07 11:53, Greg KH wrote:
> On Tue, Nov 07, 2023 at 10:56:20AM +0200, José Pekkarinen wrote:
>> On 2023-11-03 20:36, Greg KH wrote:
>> > On Fri, Nov 03, 2023 at 07:49:39PM +0200, José Pekkarinen wrote:
>> > > On 2023-11-01 19:54, Greg KH wrote:
>> > > > On Wed, Nov 01, 2023 at 07:36:27PM +0200, José Pekkarinen wrote:
>> > > > > Hinted by syzboot, there is a few cases where the sysfs power group
>> > > > > may
>> > > > > not be there, like the failure while adding it, or adding its runtime
>> > > > > group, or when the sysfs firmware loader fallback fail to populate. In
>> > > > > the last case, the device_del function will be called leading to
>> > > > > attempt
>> > > > > to remove the sysfs group. This patch will lookup for it in advance to
>> > > > > grant that it is effectively there before cleaning it up.
>> > > > >
>> > > > > Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
>> > > > >
>> > > > > Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> > > > > ---
>> > > > >  drivers/base/power/sysfs.c | 4 +++-
>> > > > >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > > > >
>> > > > > diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
>> > > > > index a1474fb67db9..6601729c4698 100644
>> > > > > --- a/drivers/base/power/sysfs.c
>> > > > > +++ b/drivers/base/power/sysfs.c
>> > > > > @@ -834,5 +834,7 @@ void dpm_sysfs_remove(struct device *dev)
>> > > > >  	dev_pm_qos_constraints_destroy(dev);
>> > > > >  	rpm_sysfs_remove(dev);
>> > > > >  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
>> > > > > -	sysfs_remove_group(&dev->kobj, &pm_attr_group);
>> > > > > +
>> > > > > +	if (kernfs_find_and_get((&dev->kobj)->sd, pm_attr_group.name))
>> > > > > +		sysfs_remove_group(&dev->kobj, &pm_attr_group);
>> > > >
>> > > > What's to keep it from going away right after finding it?
>> > > >
>> > > > In other words, what is wrong with removing a group that is not there?
>> > > > What error happens?  It should be fine, or are you seeing real code
>> > > > failures somewhere?
>> > >
>> > >     No, this is just hitting a warning that sysbot complains about by
>> > > setting panic on warning, no big deal, though it can be a wrong
>> > > behaviour
>> > > in ueagle-atm driver, since it defines to disconnect the device if the
>> > > firmware is not there, no matter the sysfs fallback.
>> >
>> > Then fix the driver please.
>> 
>>     I'm afraid I was wrong in the assumption that the probe return 
>> value
>> of the driver would influence the testing result, so this no longer 
>> seems
>> fixable from driver side.
> 
> Why is it not fixable from the driver side?  It is the code that is
> creating, and then removing, the files, not the driver core, or am I
> missing something here?

     I don't think this is much of a problem since the situation is 
unlikely to
happen. The reproducer is attempting to register a simulated ueagle 
modem and
checks if the device becomes ready. If it doesn't for any reason, in 
this case,
the lack of the firmware, it just disconnect it and try to populate it 
again.
After a few minutes banging the kernel this way it hits the situation 
where the
asynchronous firmware loader didn't yet populate the sysfs files before 
the
device is getting removed, and hit the warning of missing the power 
attributes
in sysfs, while removing the sysfs groups. If it is a problem, it is 
certainly
not a top priority problem to solve for sure.

     José.
