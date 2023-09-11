Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A64C479BD0A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346883AbjIKVYH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:24:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238721AbjIKODl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 10:03:41 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F3E2CF0;
        Mon, 11 Sep 2023 07:03:36 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qfhVk-0001JK-HG; Mon, 11 Sep 2023 16:03:32 +0200
Message-ID: <96bcfe54-fcee-4c14-9772-b8191ee10c03@leemhuis.info>
Date:   Mon, 11 Sep 2023 16:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Fwd: Unexplainable packet drop starting at v6.4
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Jesse Brandeburg <jesse.brandeburg@intel.com>,
        Tony Nguyen <anthony.l.nguyen@intel.com>,
        Tirthendu Sarkar <tirthendu.sarkar@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Regressions <regressions@lists.linux.dev>,
        Linux Networking <netdev@vger.kernel.org>,
        Linux Intel Ethernet Drivers 
        <intel-wired-lan@lists.osuosl.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <e79edb0f-de89-5041-186f-987d30e0187c@gmail.com>
 <e9644f38-57be-5d26-0c08-08a74eee7cb1@leemhuis.info>
In-Reply-To: <e9644f38-57be-5d26-0c08-08a74eee7cb1@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694441016;a1c8c64e;
X-HE-SMSGID: 1qfhVk-0001JK-HG
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30.08.23 12:07, Linux regression tracking (Thorsten Leemhuis) wrote:
> [replying with a heavily adjust set of recipients]
> 
> On 18.07.23 02:51, Bagas Sanjaya wrote:
>>
>> I notice a regression report on Bugzilla [1]. Quoting from it:
> 
> Tirthendu Sarkar, turned out this regressions reported in
> https://bugzilla.kernel.org/show_bug.cgi?id=217678 is caused by your
> change e9031f2da1a ("i40e: introduce next_to_process to i40e_ring")
> [v6.4-rc1] that Tony applied in March.
> 
> Could you (or someone else) please take a look? The bugzilla ticket has
> details and a comment from a second person that seems to be affected by
> the same problem. And 6.5 seems to still show the problem.

Hey i40e developers, did you see that message reg this regression in
your driver I sent one and a half week ago? It would be good to get at
least some progress here, as this report is around for quite some time
already, as it was misdirected first. :-/ Two people are apparently
affected by this, one re-confirmed today that this is still happening.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

>>> Hi,
>>>
>>> After I updated to 6.4 through Archlinux kernel update, suddenly I noticed random packet losses on my routers like nodes. I have these networking relevant config on my nodes
>>>
>>> 1. Using archlinux
>>> 2. Network config through systemd-networkd
>>> 3. Using bird2 for BGP routing, but not relevant to this bug.
>>> 4. Using nftables for traffic control, but seems not relevant to this bug. 
>>> 5. Not using fail2ban like dymanic filtering tools, at least at L3/L4 level
>>>
>>> After I ruled out systemd-networkd, nftables related issues. I tracked down issues to kernel.
>>>
>>> Here's the tcpdump I'm seeing on one side of my node ""
>>>
>>> ```
>>> sudo tcpdump -i fios_wan port 38851
>>> tcpdump: verbose output suppressed, use -v[v]... for full protocol decode
>>> listening on fios_wan, link-type EN10MB (Ethernet), snapshot length 262144 bytes
>>> 10:33:06.073236 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
>>> 10:33:11.406607 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
>>> 10:33:16.739969 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
>>> 10:33:21.859856 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
>>> 10:33:27.193176 IP [BOS1_NODE].38851 > [REDACTED_PUBLIC_IPv4_1].38851: UDP, length 148
>>> 5 packets captured
>>> 5 packets received by filter
>>> 0 packets dropped by kernel
>>> ```
>>>
>>> But on the other side "[REDACTED_PUBLIC_IPv4_1]", tcpdump is replying packets in this wireguard stream. So packet is lost somewhere in the link.
>>>
>>> From the otherside, I can do "mtr" to "[BOS1_NODE]"'s public IP and found the moment the link got lost is right at "[BOS1_NODE]", that means "[BOS1_NODE]"'s networking stack completely drop the inbound packets from specific ip addresses.
>>>
>>> Some more digging
>>>
>>> 1. This situation began after booting in different delays. Sometimes can trigger after 30 seconds after booting, and sometimes will be after 18 hours or more.
>>> 2. It can envolve into worse case that when I do "ip neigh show", the ipv4 ARP table and ipv6 neighbor discovery start to appear as "invalid", meaning the internet is completely loss.
>>> 3. When this happened to wan facing interface, it seems OK with lan facing interfaces. WAN interface was using Intel X710-T4L using i40e and lan side was using virtio
>>> 4. I tried to bisect in between 6.3 and 6.4, and the first bad commit it reports was "a3efabee5878b8d7b1863debb78cb7129d07a346". But this is not relevant to networking at all, maybe it's the wrong commit to look at. At the meantime, because I haven't found a reproducible way of 100% trigger the issue, it may be the case during bisect some "good" commits are actually bad. 
>>> 5. I also tried to look at "dmesg", nothing interesting pop up. But I'll make it available upon request.
>>>
>>> This is my first bug reports. Sorry for any confusion it may lead to and thanks for reading.
>>
>> See Bugzilla for the full thread.
>>
>> Thorsten: The reporter had a bad bisect (some bad commits were marked as good
>> instead), hence SoB chain for culprit (unrelated) ipvu commit is in To:
>> list. I also asked the reporter (also in To:) to provide dmesg and request
>> rerunning bisection, but he doesn't currently have a reliable reproducer.
>> Is it the best I can do?
>>
>> Anyway, I'm adding this regression to be tracked in regzbot:
>>
>> #regzbot introduced: a3efabee5878b8 https://bugzilla.kernel.org/show_bug.cgi?id=217678
>> #regzbot title: packet drop on Intel X710-T4L due to ipvu boot fix
>>
>> Thanks.
>>
>> [1]: https://bugzilla.kernel.org/show_bug.cgi?id=217678
>>
> 
> #regzbot introduced: e9031f2da1a
> #regzbot poke
