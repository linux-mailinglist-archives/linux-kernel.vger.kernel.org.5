Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1119078C075
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 10:40:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233974AbjH2IjQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 04:39:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234418AbjH2Iiz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 04:38:55 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD48FFC;
        Tue, 29 Aug 2023 01:38:48 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qauFE-0007Gv-KK; Tue, 29 Aug 2023 10:38:40 +0200
Message-ID: <fcf2f600-d1f0-de14-956b-4d4f3f0cb3fa@leemhuis.info>
Date:   Tue, 29 Aug 2023 10:38:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Content-Language: en-US, de-DE
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Dusty Mabe <dusty@dustymabe.com>
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
 <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
 <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
In-Reply-To: <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693298328;afbcb769;
X-HE-SMSGID: 1qauFE-0007Gv-KK
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[CCing the regression list, as it should be in the loop for regressions:
https://docs.kernel.org/admin-guide/reporting-regressions.html]

On 28.08.23 02:35, Mario Limonciello wrote:
> On 8/27/2023 13:12, Jarkko Sakkinen wrote:
>> On Wed Aug 23, 2023 at 9:58 PM EEST, Mario Limonciello wrote:
>>> On 8/23/2023 12:40, Jarkko Sakkinen wrote:
>>>> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
>>>>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
>>>>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable
>>>>>> RNG for
>>>>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs. 
>>>>>> On the
>>>>>> reported systems the TPM doesn't reply at bootup and returns back the
>>>>>> command code. This makes the TPM fail probe.
>>>>>>
>>>>>> Since only Microsoft Pluton is the only known combination of AMD
>>>>>> CPU and
>>>>>> fTPM from other vendor, disable hwrng otherwise. In order to make
>>>>>> sysadmin
>>>>>> aware of this, print also info message to the klog.
>>>>>>
>>>>>> Cc: stable@vger.kernel.org
>>>>>> Fixes: 554b841d4703 ("tpm: Disable RNG for all AMD fTPMs")
>>>>>> Reported-by: Todd Brandt <todd.e.brandt@intel.com>
>>>>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217804
>>>>>> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
>>>>>
>>>>> Mario’s patch also had the three reporters below listed:
>>>>>
>>>>> Reported-by: Patrick Steinhardt <ps@pks.im>
>>>>> Reported-by: Ronan Pigott <ronan@rjp.ie>
>>>>> Reported-by: Raymond Jay Golo <rjgolo@gmail.com>
>>>>
>>>> The problem here is that checkpatch throws three warnings:
>>>>
>>>> WARNING: Reported-by: should be immediately followed by Closes: with
>>>> a URL to the report

Note, those are warnings (and not an errors) on purpose and the text
says "should" (and not "must"), so this is IMHO something in this case
can be ignored, as Mario indicated in his reply.

But I write for a different reason: this seems to become a regression
that is annoying quite a few people (in 6.5 and 6.4.y afaics), so it
would be good to get the fix merged to mainline rather sooner than
later. Are these warnings and the mentioning of affected machines in the
patch descriptions the only remaining problems, or is there anything
else that needs to be addressed?

Ciao, Thorsten (just back from vacation and catching up)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke
