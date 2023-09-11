Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9401A79C0EC
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354543AbjIKVy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236442AbjIKKkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:40:13 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88106E5F;
        Mon, 11 Sep 2023 03:40:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2526FC433C8;
        Mon, 11 Sep 2023 10:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1694428807;
        bh=RP45snWACyqgDN5ENZuvi66iNSF1V/wDO4v24hihHZE=;
        h=Date:Subject:From:To:Cc:References:In-Reply-To:From;
        b=lhDQoGRi69jPZZL7AuWVTS8zWlclsXaP73Wu2uz8ZXmysuVGZw02SADwAUV4KCAWR
         36rS7S0TpOez7u+QCNm3ES4rU9w9/sysv+n5J0rt+f8UqJrv6GH7qXWli/W9gWQB56
         DowAsUZ58S7bbEAS92MGeo7N4gefx5t42zidoenUpIazcHZCBj2hrFD70uMqenQ+e6
         xLmRGwt0fwvEgVM+CnBkjQACXN3TGzFwqG5dJVZuhDcmcydfGUATVExwyll/2yw4VH
         XmpGOdGPkFPYl/qQPZG7MKebkySJFAxDlJb91Dve7LOBXZyF9bbrHPrts1OsHUSnAP
         ldJHc4Tui3s4w==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 11 Sep 2023 13:40:02 +0300
Message-Id: <CVG0VPRMC759.2LT3BCT7Q6M9H@suppilovahvero>
Subject: Re: [PATCH v3] tpm: Enable hwrng only for Pluton on AMD CPUs
From:   "Jarkko Sakkinen" <jarkko@kernel.org>
To:     "Thorsten Leemhuis" <regressions@leemhuis.info>,
        "Mario Limonciello" <mario.limonciello@amd.com>
Cc:     <linux-integrity@vger.kernel.org>,
        "Jerry Snitselaar" <jsnitsel@redhat.com>, <stable@vger.kernel.org>,
        "Todd Brandt" <todd.e.brandt@intel.com>,
        "Peter Huewe" <peterhuewe@gmx.de>,
        "Jason Gunthorpe" <jgg@ziepe.ca>, <linux-kernel@vger.kernel.org>,
        "Patrick Steinhardt" <ps@pks.im>, "Ronan Pigott" <ronan@rjp.ie>,
        "Raymond Jay Golo" <rjgolo@gmail.com>,
        "Linux kernel regressions list" <regressions@lists.linux.dev>,
        "Dusty Mabe" <dusty@dustymabe.com>,
        "Linus Torvalds" <torvalds@linux-foundation.org>,
        "Paul Menzel" <pmenzel@molgen.mpg.de>
X-Mailer: aerc 0.14.0
References: <20230822231510.2263255-1-jarkko@kernel.org>
 <705b9769-4132-450b-bd47-2423c419db2a@molgen.mpg.de>
 <CV03X3OEI7RE.3NI1QJ6MBJSHA@suppilovahvero>
 <1eeddbdc-c1f0-4499-b3d1-24c96f42a50b@amd.com>
 <CV3J3TCMB74C.1WA96NQ9J593U@suppilovahvero>
 <f6d75cac-2556-484e-8a2c-3531b24b1ca5@amd.com>
 <fcf2f600-d1f0-de14-956b-4d4f3f0cb3fa@leemhuis.info>
 <116dd56f-695f-4ecd-dace-805db83f5c3e@leemhuis.info>
 <CVAHNI7PWVDL.W8194GZA0SMK@suppilovahvero>
 <8dc067e5-d81f-4c5b-be76-bf0c1227b71e@leemhuis.info>
In-Reply-To: <8dc067e5-d81f-4c5b-be76-bf0c1227b71e@leemhuis.info>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue Sep 5, 2023 at 3:01 PM EEST, Thorsten Leemhuis wrote:
> On 05.09.23 00:32, Jarkko Sakkinen wrote:
> > On Fri Sep 1, 2023 at 11:49 AM EEST, Thorsten Leemhuis wrote:
> >> On 29.08.23 10:38, Linux regression tracking (Thorsten Leemhuis) wrote=
:
> >>> On 28.08.23 02:35, Mario Limonciello wrote:
> >>>> On 8/27/2023 13:12, Jarkko Sakkinen wrote:
> >>>>> On Wed Aug 23, 2023 at 9:58 PM EEST, Mario Limonciello wrote:
> >>>>>> On 8/23/2023 12:40, Jarkko Sakkinen wrote:
> >>>>>>> On Wed Aug 23, 2023 at 11:23 AM EEST, Paul Menzel wrote:
> >>>>>>>> Am 23.08.23 um 01:15 schrieb Jarkko Sakkinen:
> >>>>>>>>> The vendor check introduced by commit 554b841d4703 ("tpm: Disab=
le
> >>>>>>>>> RNG for
> >>>>>>>>> all AMD fTPMs") doesn't work properly on a number of Intel fTPM=
s.=C2=A0
> >>>>>>>>> On the
> >>>>>>>>> reported systems the TPM doesn't reply at bootup and returns ba=
ck the
> >>>>>>>>> command code. This makes the TPM fail probe.
> > [...]
> >> Hmmm. Quite a bit progress to fix the issue was made in the first week
> >> after Todd's report; Jarkko apparently even applied the earlier patch
> >> from Mario to his master branch:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/jarkko/linux-tpmdd.git=
/commit/?id=3Db1a62d41bdc1d15b0641759717e8c3651f0a810c
> >> But since then (aka in the past week) there was not much progress.
>
> Jarkko, many thx for picking this up and submitting it to Linus, much
> appreciated. Sorry again for prodding things, but I felt I had to. Hope
> you didn't mind too much.
>
> > Could it be possible to extend the actual kernel documentation
> > to give at least some guidelines how a maintainer should deal
> > with the bugzilla?
>
> I guess it's best if that is done by somebody that cares about bugzilla
> (I don't fall into that group[1]) and knows the official status.
>
> But FWIW, I wonder what you actually want to see documented. From
> https://lore.kernel.org/all/CVAC8VQPD3PK.1CBS5QTWDSS2C@suppilovahvero/
> it sounds like you had trouble with Link:/Closes: tag and Reported-by.
> From what I can see I don't think bugzilla.kernel.org needs special
> documentation in that area:
>
>  * just use Link:/Closes: to reports to public reports that might be
> helpful later in case somebody wants to look at the backstory of a
> commit, wherever those reports may be (lore, bugzilla.kernel.org,
> https://gitlab.freedesktop.org/drm/intel/-/issues,
> https://github.com/thesofproject/linux/issues, ...)
>
>  * use Reported-by: to give credit to anyone that deserves it, as it is
> a nice way to say thx while motivate people to help again in the future.
> That usually will include the initial reporter, but might also include
> people that replied to a report from somebody else and helped
> perceptible with debugging or fixing.

I *kind of* agree with this but checkpatch.pl disagrees with this :-/

And it is an actual issue that bugzilla is hosted in kernel.org domain,
and at the same time it is undocumented process.

AFAIK anything that is not part of the process can be ignored in the
process so *theoretically* anything put to kernel bugzilla ca be
ignored. This is how it is with e.g. patchwork - some people use it,
some people don't.

Personally I think bugzilla, being user approachable system, should
be better defined but *theoretically*, at least by the process, it
can be fully ignored.

This is where the main source of confusion inherits from, when you
put your maintainer hat on.

> Ciao, Thorsten
>
> [1] I only sometimes help people that report regressions to
> bugzilla.kernel.org that otherwise would likely would fall through the
> cracks (among others because many reports are never forwarded to the
> proper developers otherwise).

BR, Jarkko
