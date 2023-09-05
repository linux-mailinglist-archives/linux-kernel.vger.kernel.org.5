Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98E897929F0
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:58:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355003AbjIEQaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354499AbjIEMBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 08:01:36 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40A0D1AB;
        Tue,  5 Sep 2023 05:01:33 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qdUkM-0004Lb-5r; Tue, 05 Sep 2023 14:01:30 +0200
Message-ID: <8dc067e5-d81f-4c5b-be76-bf0c1227b71e@leemhuis.info>
Date:   Tue, 5 Sep 2023 14:01:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
Content-Language: en-US, de-DE
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>
Cc:     linux-integrity@vger.kernel.org,
        Jerry Snitselaar <jsnitsel@redhat.com>, stable@vger.kernel.org,
        Todd Brandt <todd.e.brandt@intel.com>,
        Peter Huewe <peterhuewe@gmx.de>,
        Jason Gunthorpe <jgg@ziepe.ca>, linux-kernel@vger.kernel.org,
        Patrick Steinhardt <ps@pks.im>, Ronan Pigott <ronan@rjp.ie>,
        Raymond Jay Golo <rjgolo@gmail.com>,
        Linux kernel regressions list <regressions@lists.linux.dev>,
        Dusty Mabe <dusty@dustymabe.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Paul Menzel <pmenzel@molgen.mpg.de>
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
 <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
 <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
 <fcf2f600-d1f0-de14-956b-4d4f3f0cb3fa@leemhuis.info>
 <116dd56f-695f-4ecd-dace-805db83f5c3e@leemhuis.info>
 <CVAHNI7PWVDL.W8194GZA0SMK@suppilovahvero>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <CVAHNI7PWVDL.W8194GZA0SMK@suppilovahvero>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693915293;db139137;
X-HE-SMSGID: 1qdUkM-0004Lb-5r
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.23 00:32, Jarkko Sakkinen wrote:
> On Fri Sep 1, 2023 at 11:49 AM EEST, Thorsten Leemhuis wrote:
>> On 29.08.23 10:38, Linux regression tracking (Thorsten Leemhuis) wrote:
>>> On 28.08.23 02:35, Mario Limonciello wrote:
>>>> On 8/27/2023 13:12, Jarkko Sakkinen wrote:
>>>>> On Wed Aug 23, 2023 at 9:58 PM EEST, Mario Limonciello wrote:
>>>>>> On 8/23/2023 12:40, Jarkko Sakkinen wrote:
>>>>>>> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
>>>>>>>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
>>>>>>>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disable
>>>>>>>>> RNG for
>>>>>>>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPMs. 
>>>>>>>>> On the
>>>>>>>>> reported systems the TPM doesn't reply at bootup and returns back the
>>>>>>>>> command code. This makes the TPM fail probe.
> [...]
>> Hmmm. Quite a bit progress to fix the issue was made in the first week
>> after Todd's report; Jarkko apparently even applied the earlier patch
>> from Mario to his master branch:
>> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git/commit/?id=b1a62d41bdc1d15b0641759717e8c3651f0a810c
>> But since then (aka in the past week) there was not much progress.

Jarkko, many thx for picking this up and submitting it to Linus, much
appreciated. Sorry again for prodding things, but I felt I had to. Hope
you didn't mind too much.

> Could it be possible to extend the actual kernel documentation
> to give at least some guidelines how a maintainer should deal
> with the bugzilla?

I guess it's best if that is done by somebody that cares about bugzilla
(I don't fall into that group[1]) and knows the official status.

But FWIW, I wonder what you actually want to see documented. From
https://lore.kernel.org/all/CVAC8VQPD3PK.1CBS5QTWDSS2C@suppilovahvero/
it sounds like you had trouble with Link:/Closes: tag and Reported-by.
From what I can see I don't think bugzilla.kernel.org needs special
documentation in that area:

 * just use Link:/Closes: to reports to public reports that might be
helpful later in case somebody wants to look at the backstory of a
commit, wherever those reports may be (lore, bugzilla.kernel.org,
https://gitlab.freedesktop.org/drm/intel/-/issues,
https://github.com/thesofproject/linux/issues, ...)

 * use Reported-by: to give credit to anyone that deserves it, as it is
a nice way to say thx while motivate people to help again in the future.
That usually will include the initial reporter, but might also include
people that replied to a report from somebody else and helped
perceptible with debugging or fixing.

Ciao, Thorsten

[1] I only sometimes help people that report regressions to
bugzilla.kernel.org that otherwise would likely would fall through the
cracks (among others because many reports are never forwarded to the
proper developers otherwise).
