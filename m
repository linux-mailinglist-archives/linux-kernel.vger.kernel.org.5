Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49217F88C1
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Nov 2023 08:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbjKYHKg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Nov 2023 02:10:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjKYHKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Nov 2023 02:10:34 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03111D60;
        Fri, 24 Nov 2023 23:10:40 -0800 (PST)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1r6moG-000216-3U; Sat, 25 Nov 2023 08:10:36 +0100
Message-ID: <34c5b291-b69e-4592-bc9f-fc1b2ef5c5d7@leemhuis.info>
Date:   Sat, 25 Nov 2023 08:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: scsi regression that after months is still not addressed and now
 bothering 6.1.y users, too
Content-Language: en-US, de-DE
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Sagar Biradar <sagar.biradar@microchip.com>,
        James Bottomley <James.Bottomley@hansenpartnership.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Adaptec OEM Raid Solutions <aacraid@microsemi.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Hannes Reinecke <hare@suse.de>,
        scsi <linux-scsi@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Gilbert Wu <gilbert.wu@microchip.com>,
        John Garry <john.g.garry@oracle.com>
References: <c6ff53dc-a001-48ee-8559-b69be8e4db81@leemhuis.info>
 <2023112456-disinfect-undoing-b5ef@gregkh>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <2023112456-disinfect-undoing-b5ef@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1700896240;f15d9d50;
X-HE-SMSGID: 1r6moG-000216-3U
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24.11.23 17:25, Greg KH wrote:
> On Tue, Nov 21, 2023 at 10:50:57AM +0100, Thorsten Leemhuis wrote:
>> * @SCSI maintainers: could you please look into below please?
>>
>> * @Stable team: you might want to take a look as well and consider a
>> revert in 6.1.y (yes, I know, those are normally avoided, but here it
>> might make sense).
>>
>> Hi everyone!
>>
>> TLDR: I noticed a regression (Adaptec 71605z with aacraid sometimes
>> hangs for a while) that was reported months ago already but is still not
>> fixed. Not only that, it apparently more and more users run into this
>> recently, as the culprit was recently integrated into 6.1.y; I wonder if
>> it would be best to revert it there, unless a fix for mainline comes
>> into reach soon.
>>
>> Details:
>>
>> Quite a few machines with Adaptec controllers seems to hang for a few
>> tens of seconds to a few minutes before things start to work normally
>> again for a while:
>> https://bugzilla.kernel.org/show_bug.cgi?id=217599
>>
>> That problem is apparently caused by 9dc704dcc09eae ("scsi: aacraid:
>> Reply queue mapping to CPUs based on IRQ affinity") [v6.4-rc7]. That
>> commit despite a warning of mine to Sasha recently made it into 6.1.53
>> -- and that way apparently recently reached more users recently, as
>> quite a few joined that ticket.
>[...]
> I am loath to revert a stable patch that has been there for so long as
> any upgrade will just cause the same bug to show back up. Why can't we
> just revert it in Linus's tree now and I'll take that revert in the
> stable trees as well?

FWIW, I know and in general agree with that strategy, that's why I
normally wouldn't have brought a stable-only revert up for
consideration. But this issue to me looked somewhat special and urgent
for two and a half reasons: (1) that backport apparently made a lot more
people suddenly hit the issue (2) there was also this data corruption
aspect one of the reporters mentioned (not sure if that is real and/or
if this might be just a 6.1.y thing). Furthermore for 6.1.y it was
recently confirmed that reverting the change fixes things, while we iirc
had no such confirmation for recent mainline kernels at that point. So
it looked like it would take a while to get this sorted out in mainline.
But it seems we finally might get closer to that now, so yeah, maybe
it's not worth a stable revert.

Ciao, Thorsten
