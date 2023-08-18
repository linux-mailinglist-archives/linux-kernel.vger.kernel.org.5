Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98D2C780831
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 11:22:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359039AbjHRJVz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 05:21:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359067AbjHRJV3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 05:21:29 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18AF43C25;
        Fri, 18 Aug 2023 02:21:27 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id A3A0621884;
        Fri, 18 Aug 2023 09:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1692350486; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmLxSY+YWIyBjqJPJ6QEFdRadSrzKGUHrz3qvFcr4F4=;
        b=uulEYH5HLtomuCi2zoy9XTs3I/7mEQzLrAZE7pP6ul2zOQKJ7/d0L50BsYgJ1ptPdcgQ1m
        cbMa4e155AQIyYUsySFvtmI0J5ZfJiyfesKaQSg1KECRxnLeqTcbGJuZ3wVM09jfCyCvGi
        twdSNOkIM3tYKaJODmDZ9Fbq3DF2yBo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1692350486;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VmLxSY+YWIyBjqJPJ6QEFdRadSrzKGUHrz3qvFcr4F4=;
        b=gORR+RoS1h7nZoOs/J7X0vNnvZvsdrpxJv8miKoqqRWC4LQogDZqKBSozC0nZQcSAdEESF
        NR2O825FE1BfeuCw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 850EA13441;
        Fri, 18 Aug 2023 09:21:26 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id ZTqjHRY432SCJQAAMHmgww
        (envelope-from <hare@suse.de>); Fri, 18 Aug 2023 09:21:26 +0000
Message-ID: <1b2166ab-e788-475e-a8e2-a6cef26f2524@suse.de>
Date:   Fri, 18 Aug 2023 11:21:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Infiniate systemd loop when power off the machine with multiple
 MD RAIDs
Content-Language: en-US
To:     Mariusz Tkaczyk <mariusz.tkaczyk@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, Song Liu <song@kernel.org>,
        AceLan Kao <acelan@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux RAID <linux-raid@vger.kernel.org>
References: <028a21df-4397-80aa-c2a5-7c754560f595@gmail.com>
 <20230818101630.000027f4@linux.intel.com>
From:   Hannes Reinecke <hare@suse.de>
In-Reply-To: <20230818101630.000027f4@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/18/23 10:16, Mariusz Tkaczyk wrote:
> On Wed, 16 Aug 2023 16:37:26 +0700
> Bagas Sanjaya <bagasdotme@gmail.com> wrote:
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
>>
>> See Bugzilla for the full thread and attached full journalctl log.
>>
>> Anyway, I'm adding this regression to be tracked by regzbot:
>>
>> #regzbot introduced: 12a6caf273240a
>> https://bugzilla.kernel.org/show_bug.cgi?id=217798 #regzbot title: systemd
>> shutdown hang on machine with different RAID levels
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217798
>>
> 
> Hello,
> The issue is reproducible with IMSM metadata too, around 20% of reboot hangs. I
> will try to raise the priority in the bug because it is valid high- the
> base functionality of the system is affected.
> 
> Christoph, could you take a look in short term?
> 
Does this help?


diff --git a/drivers/md/md.c b/drivers/md/md.c
index 78be7811a89f..b3661c8def8c 100644
--- a/drivers/md/md.c
+++ b/drivers/md/md.c
@@ -9575,6 +9575,7 @@ static int md_notify_reboot(struct notifier_block 
*this,
         struct mddev *mddev, *n;
         int need_delay = 0;

+       flush_workqueue(md_misc_wq);
         spin_lock(&all_mddevs_lock);
         list_for_each_entry_safe(mddev, n, &all_mddevs, all_mddevs) {
                 if (!mddev_get(mddev))

Cheers,

Hannes

