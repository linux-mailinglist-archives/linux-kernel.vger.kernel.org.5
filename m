Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEAF0763801
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 15:47:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234309AbjGZNrl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 09:47:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233947AbjGZNrd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 09:47:33 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9161D2698;
        Wed, 26 Jul 2023 06:47:31 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qOerP-00056F-UN; Wed, 26 Jul 2023 15:47:27 +0200
Message-ID: <6b66dd9a-8bd5-2882-9168-8e6e0848c454@leemhuis.info>
Date:   Wed, 26 Jul 2023 15:47:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Scsi_bus_resume+0x0/0x90 returns -5 when resuming from s3 sleep
Content-Language: en-US, de-DE
To:     TW <dalzot@gmail.com>
Cc:     regressions@lists.linux.dev,
        Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bart Van Assche <bvanassche@acm.org>,
        LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
References: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <0e272abe-292d-d58f-cf80-55868e793abc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1690379251;0ba84a27;
X-HE-SMSGID: 1qOerP-00056F-UN
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Thorsten here, the Linux kernel's regression tracker.

On 26.07.23 13:54, TW wrote:
> I have been having issues with the 6.x series of kernels resuming from
> suspend with one of my drives. Far as I can tell it has trouble with the
> cache on the drive when coming out of s3 sleep. Tried a few different
> distros (Manjaro, OpenMandriva Rome, EndeavourOS) all that give the same
> error message. It appears to work fine on the 5.15 kernel just fine
> however.
> 
> This is the error or errors that I have been getting and assume has been
> holding up the system from resuming from suspend.
>
> Jul 20 04:13:41 rageworks kernel: ata10.00: device reported invalid CHS sector 0
> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Start/Stop Unit failed: Result: hostbyte=DID_OK driverbyte=DRIVER_OK
> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Sense Key : Illegal Request [current]
> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: [sdc] Add. Sense: Unaligned write command
> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: dpm_run_callback(): scsi_bus_resume+0x0/0x90 returns -5
> Jul 20 04:13:41 rageworks kernel: sd 9:0:0:0: PM: failed to resume async: error -5 

Thx for your report. I CCed a few people, with a bit of luck they have
an idea. But I doubt it. If no one replies you likely will need a
bisection to find the root of the problem. But before going down that
route you want to check if latest mainline kernel (vanilla!) works better.

FWIW, this is not my area of expertise, so the following might be a
misleading comment, but the problem looks somewhat similar to this one
that iirc was never solved:
https://bugzilla.kernel.org/show_bug.cgi?id=216087

> Jul 20 04:12:51 rageworks systemd[1]: nvidia-suspend.service: Deactivated successfully.
> Jul 20 04:12:51 rageworks systemd[1]: Finished NVIDIA system suspend actions.
> Jul 20 04:12:51 rageworks systemd[1]: Starting System Suspend... 

That sounds like you are using out-of tree drivers which can cause all
sorts of issues. Please recheck if the problem happens without those as
well and do not use them in all further tests to debug the issue.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
