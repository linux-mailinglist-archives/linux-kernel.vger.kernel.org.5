Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38FA67838A2
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 05:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232484AbjHVD4g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 23:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjHVD4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 23:56:34 -0400
X-Greylist: delayed 305 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 21 Aug 2023 20:56:32 PDT
Received: from out-5.mta0.migadu.com (out-5.mta0.migadu.com [IPv6:2001:41d0:1004:224b::5])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40DBE189
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 20:56:32 -0700 (PDT)
Message-ID: <b0488ff7-10c8-4b4e-28b8-01809133c297@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692676283;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d1XtgmVHmWphOhUDrhErIxCJnRoxFdHJ1QNgkVg6SUE=;
        b=VgtV+jOen3G/PQf/JwsUEqgwyen6vBQSsoJOD2YoaJwxNCpYr0szLZyWwl8o0ozWMTU2QC
        NXdu2CdBuizN0K9Jl4pOzYwoOgSa2j9qzzcKQcuA1yy94ntc3Xdcct0t/h7cQ7eUgHzDGu
        61kMb8eQs4A3ItbvHkyJcrlGqGXPKdY=
Date:   Tue, 22 Aug 2023 11:51:13 +0800
MIME-Version: 1.0
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Guoqing Jiang <guoqing.jiang@linux.dev>
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com>
Content-Language: en-US
In-Reply-To: <20230818101630.000027f4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/18/23 16:16, Mariusz Tkaczyk wrote:
> On Wed, 16 Aug 2023 16:37:26 +0700
> Bagas Sanjaya<bagasdotme@gmail.com>  wrote:
>
>> Hi,
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
>>
>>> It needs to build at least 2 different RAIDs(eg. RAID0 and RAID10, RAID5
>>> and RAID10) and then you will see below error repeatly(need to use serial
>>> console to see it)
>>>
>>> [ 205.360738] systemd-shutdown[1]: Stopping MD devices.
>>> [ 205.366384] systemd-shutdown[1]: sd-device-enumerator: Scan all dirs
>>> [ 205.373327] systemd-shutdown[1]: sd-device-enumerator: Scanning /sys/bus
>>> [ 205.380427] systemd-shutdown[1]: sd-device-enumerator: Scanning /sys/class
>>> [ 205.388257] systemd-shutdown[1]: Stopping MD /dev/md127 (9:127).
>>> [ 205.394880] systemd-shutdown[1]: Failed to sync MD block device
>>> /dev/md127, ignoring: Input/output error [ 205.404975] md: md127 stopped.
>>> [ 205.470491] systemd-shutdown[1]: Stopping MD /dev/md126 (9:126).
>>> [ 205.770179] md: md126: resync interrupted.
>>> [ 205.776258] md126: detected capacity change from 1900396544 to 0
>>> [ 205.783349] md: md126 stopped.
>>> [ 205.862258] systemd-shutdown[1]: Stopping MD /dev/md125 (9:125).
>>> [ 205.862435] md: md126 stopped.
>>> [ 205.868376] systemd-shutdown[1]: Failed to sync MD block device
>>> /dev/md125, ignoring: Input/output error [ 205.872845] block device
>>> autoloading is deprecated and will be removed. [ 205.880955] md: md125
>>> stopped. [ 205.934349] systemd-shutdown[1]: Stopping MD /dev/md124p2
>>> (259:7). [ 205.947707] systemd-shutdown[1]: Could not stop MD /dev/md124p2:
>>> Device or resource busy [ 205.957004] systemd-shutdown[1]: Stopping MD
>>> /dev/md124p1 (259:6). [ 205.964177] systemd-shutdown[1]: Could not stop MD
>>> /dev/md124p1: Device or resource busy [ 205.973155] systemd-shutdown[1]:
>>> Stopping MD /dev/md124 (9:124). [ 205.979789] systemd-shutdown[1]: Could
>>> not stop MD /dev/md124: Device or resource busy [ 205.988475]
>>> systemd-shutdown[1]: Not all MD devices stopped, 4 left.
>> See Bugzilla for the full thread and attached full journalctl log.
>>
>> Anyway, I'm adding this regression to be tracked by regzbot:
>>
>> #regzbot introduced: 12a6caf273240a
>> https://bugzilla.kernel.org/show_bug.cgi?id=217798  #regzbot title: systemd
>> shutdown hang on machine with different RAID levels
>>
>> Thanks.
>>
>> [1]:https://bugzilla.kernel.org/show_bug.cgi?id=217798
>>
> Hello,
> The issue is reproducible with IMSM metadata too, around 20% of reboot hangs. I
> will try to raise the priority in the bug because it is valid high- the
> base functionality of the system is affected.

Since it it reproducible from your side, is it possible to turn the 
reproduce steps into a test case
given the importance?

I guess If all arrays are set with MD_DELETED flag, then reboot might 
hang, not sure whether
below (maybe need to flush wq as well  before list_del) helps or not, 
just FYI.

@@ -9566,8 +9566,10 @@ static int md_notify_reboot(struct notifier_block 
*this,

         spin_lock(&all_mddevs_lock);
         list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
-               if (!mddev_get(mddev))
+               if (!mddev_get(mddev)) {
+                       list_del(&mddev->all_mddevs);
                         continue;
+               }

Thanks,
Guoqing
