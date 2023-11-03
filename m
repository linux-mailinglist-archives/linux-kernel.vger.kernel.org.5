Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0B437E07BE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 18:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjKCRtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 13:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbjKCRtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 13:49:46 -0400
Received: from 3.mo576.mail-out.ovh.net (3.mo576.mail-out.ovh.net [188.165.52.203])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA976136
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 10:49:42 -0700 (PDT)
Received: from director7.ghost.mail-out.ovh.net (unknown [10.109.143.216])
        by mo576.mail-out.ovh.net (Postfix) with ESMTP id A7B6D2A249
        for <linux-kernel@vger.kernel.org>; Fri,  3 Nov 2023 17:49:40 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-82dz8 (unknown [10.110.103.73])
        by director7.ghost.mail-out.ovh.net (Postfix) with ESMTPS id DB2F21FD72;
        Fri,  3 Nov 2023 17:49:39 +0000 (UTC)
Received: from RCM-web8.webmail.mail.ovh.net ([151.80.29.22])
        by ghost-submission-6684bf9d7b-82dz8 with ESMTPSA
        id PTtTNLMyRWW9RwYAl2N2dw
        (envelope-from <jose.pekkarinen@foxhound.fi>); Fri, 03 Nov 2023 17:49:39 +0000
MIME-Version: 1.0
Date:   Fri, 03 Nov 2023 19:49:39 +0200
From:   =?UTF-8?Q?Jos=C3=A9_Pekkarinen?= <jose.pekkarinen@foxhound.fi>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     rafael@kernel.org, len.brown@intel.com, pavel@ucw.cz,
        skhan@linuxfoundation.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org,
        syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
Subject: Re: [PATCH] drivers core: lookup sysfs power group before removal
In-Reply-To: <2023110139-dupe-snipping-5700@gregkh>
References: <20231101173627.2658-1-jose.pekkarinen@foxhound.fi>
 <2023110139-dupe-snipping-5700@gregkh>
User-Agent: Roundcube Webmail/1.4.15
Message-ID: <835b2930c710381b8da38eca821aa92d@foxhound.fi>
X-Sender: jose.pekkarinen@foxhound.fi
Organization: Foxhound Ltd.
X-Originating-IP: 163.172.213.212
X-Webmail-UserID: jose.pekkarinen@foxhound.fi
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 3653545197961848323
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedvkedruddtkedguddtfecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpeggfffhvfevufgjfhgfkfigohhitgfgsehtkehjtddtreejnecuhfhrohhmpeflohhsrocurfgvkhhkrghrihhnvghnuceojhhoshgvrdhpvghkkhgrrhhinhgvnhesfhhogihhohhunhgurdhfiheqnecuggftrfgrthhtvghrnhepkefhgeduudefgedvleegtddvffeghedvtdekveekjeevvdegiedtfeelhedtiedtnecukfhppeduvdejrddtrddtrddupdduieefrddujedvrddvudefrddvuddvpdduhedurdektddrvdelrddvvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehjohhsvgdrphgvkhhkrghrihhnvghnsehfohighhhouhhnugdrfhhiqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheejiedpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-11-01 19:54, Greg KH wrote:
> On Wed, Nov 01, 2023 at 07:36:27PM +0200, José Pekkarinen wrote:
>> Hinted by syzboot, there is a few cases where the sysfs power group 
>> may
>> not be there, like the failure while adding it, or adding its runtime
>> group, or when the sysfs firmware loader fallback fail to populate. In
>> the last case, the device_del function will be called leading to 
>> attempt
>> to remove the sysfs group. This patch will lookup for it in advance to
>> grant that it is effectively there before cleaning it up.
>> 
>> Reported-by: syzbot+95f2e2439b97575ec3c0@syzkaller.appspotmail.com
>> 
>> Signed-off-by: José Pekkarinen <jose.pekkarinen@foxhound.fi>
>> ---
>>  drivers/base/power/sysfs.c | 4 +++-
>>  1 file changed, 3 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/base/power/sysfs.c b/drivers/base/power/sysfs.c
>> index a1474fb67db9..6601729c4698 100644
>> --- a/drivers/base/power/sysfs.c
>> +++ b/drivers/base/power/sysfs.c
>> @@ -834,5 +834,7 @@ void dpm_sysfs_remove(struct device *dev)
>>  	dev_pm_qos_constraints_destroy(dev);
>>  	rpm_sysfs_remove(dev);
>>  	sysfs_unmerge_group(&dev->kobj, &pm_wakeup_attr_group);
>> -	sysfs_remove_group(&dev->kobj, &pm_attr_group);
>> +
>> +	if (kernfs_find_and_get((&dev->kobj)->sd, pm_attr_group.name))
>> +		sysfs_remove_group(&dev->kobj, &pm_attr_group);
> 
> What's to keep it from going away right after finding it?
> 
> In other words, what is wrong with removing a group that is not there?
> What error happens?  It should be fine, or are you seeing real code
> failures somewhere?

     No, this is just hitting a warning that sysbot complains about by
setting panic on warning, no big deal, though it can be a wrong 
behaviour
in ueagle-atm driver, since it defines to disconnect the device if the
firmware is not there, no matter the sysfs fallback.

> Also, I think you just leaked a reference count here, how was this
> tested?

     Both by setting up a local vm following syzkaller instructions and
using the syzkaller itself to test it. You can take a look in the link
if you feel like it.

     José.
