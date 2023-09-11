Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93BF79B3E6
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbjIKUwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 16:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236887AbjIKLiX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 07:38:23 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CA0F12E
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 04:38:18 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qffF8-0007PM-HL; Mon, 11 Sep 2023 13:38:14 +0200
Message-ID: <66bc5229-8131-4111-96fe-bd5ee90314b0@leemhuis.info>
Date:   Mon, 11 Sep 2023 13:38:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Possible nvme regression in 6.4.11
Content-Language: en-US, de-DE
From:   Thorsten Leemhuis <regressions@leemhuis.info>
To:     Genes Lists <lists@sapience.com>, Ricky WU <ricky_wu@realtek.com>,
        Keith Busch <kbusch@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>,
        "sagi@grimberg.me" <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "hch@lst.de" <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
References: <5f968b95-6b1c-4d6f-aac7-5d54f66834a8@sapience.com>
 <ZN050TFnKZ54LJ5v@kbusch-mbp.dhcp.thefacebook.com>
 <30b69186-5a6e-4f53-b24c-2221926fc3b4@sapience.com>
 <570d465a-7500-4b58-98f0-fd781c8740cc@sapience.com>
 <ZOZEwafA8+tknJNT@kbusch-mbp.dhcp.thefacebook.com>
 <7cf188d0-77b4-4e80-8da6-2045a7f29866@sapience.com>
 <180a2bbd2c314ede8f6c4c16cc4603bf@realtek.com>
 <903830f8-9f9a-4071-9ced-761a55018c5a@sapience.com>
 <97cee217-e438-4fff-836a-186f59d6d256@sapience.com>
 <fa82d9dcbe83403abc644c20922b47f9@realtek.com>
 <5d38cf11-114a-4997-a0fc-4627402468f8@sapience.com>
 <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
In-Reply-To: <d544fac1-ed2b-4417-8edd-1a81ed8a41d6@leemhuis.info>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1694432298;6b4c9ed6;
X-HE-SMSGID: 1qffF8-0007PM-HL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.09.23 10:02, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker.
> 
> On 30.08.23 23:09, Genes Lists wrote:
>> ...
>>> I think maybe it is a system power saving issue....
>>> In the past if the BIOS(config space) not set L1-substate, our driver
>>> will keep drive low CLKREQ# when HOST want to enter power saving state
>>> that make whole system not enter the power saving state.
>>> But this patch we release the CLKREQ# to HOST, make whole system can
>>> enter power saving state success when the HOST want to enter the power
>>> saving state, but I don't  know why your system can not wake out
>>> success from power saving stat on the platform
>>
>>    Thanks for continuing to look into this. Can you share your thoughts
>> on best way to proceed going forward - do you plan to revert or
>> something else?
> 
> Hmmm. This looks like it fell through the cracks. Or am I missing something?
> 
> Anyway, 6.4.y will likely be EOL in a week or two. Which bears the
> question: are 6.5.y and 6.6-rc1 working better for you? From the
> bugzilla ticket (https://bugzilla.kernel.org/show_bug.cgi?id=217802) and
> comments from others that are affected it sounds like that's not the
> case. If that's how it is I guess it overdue that the 101bd907b4244a
> ("misc: rtsx: judge ASPM Mode to set PETXCFG Reg") is reverted. Or am I
> missing something?

According to feedback in bugzilla.kernel.org 6.5.y is affected as well.
And openSUSE apparently reverted the culprit about a week ago due to the
problems it causes:
https://bugzilla.suse.com/show_bug.cgi?id=1214428

Guess that means we should do the same for mainline with a CC:
stable@... tag.

Ricky WU, or do you have a better idea? Yes, from earlier in the thread
the root of the problem might not be in the patch you contributed, but
it exposes the problem, hence it should be reverted unless a better
solution can be found quickly. And that hasn't happened in the past two
weeks, hence it's afaics time for a revert.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
