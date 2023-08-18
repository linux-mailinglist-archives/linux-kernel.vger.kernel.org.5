Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 281FB7806A8
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 09:52:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358305AbjHRHwH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 03:52:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358280AbjHRHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 03:50:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF6C3AAB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Aug 2023 00:50:56 -0700 (PDT)
Received: from localhost (unknown [IPv6:2a0c:5a83:9102:5a00:2980:60a0:e717:d129])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: rcn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id C5C1A6607143;
        Fri, 18 Aug 2023 08:50:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692345054;
        bh=hY+hsh+mHzNdHs2QGRKGuV2G4Hjv9CP76nBsrSXjAjg=;
        h=From:To:Cc:Cc:Subject:References:In-reply-to:Date:From;
        b=krJ9SDFC592y9pLWdqiJ0CS5EQTcBaNjL/6CPs8Ig6HxgujAVuSpeN0iaxCFx0Pii
         QoCSksXsgqMgvaO61Xmi4AsAQReKlsn5yhqgbaQvWK9W0ECgMyj2W9W2Lt0HxgVSb0
         ujU1+PnRbYYI2dl+sglpzTdl8kcmNZxpYZhp3SI+A1/swEL4WxVwB7sTY3183hk0Pt
         UrTNLZiordTVP4vqWgjjHe3bqvH6IOknVnbJY1jEzunQ9zGrfHVNfimro5zImvPCV+
         HvlPbSLHTEdYpZCoutKgPaWLgOLuDvQ6yEW9evZyCxME7VCHo/9Q3VbxaGQQ63Av+Q
         eAwv2/i/v1Zsw==
From:   Ricardo =?utf-8?Q?Ca=C3=B1uelo?= <ricardo.canuelo@collabora.com>
To:     Guillaume Tucker <guillaume.tucker@collabora.com>,
        kernelci@lists.linux.dev, gregkh@linuxfoundation.org,
        thorsten@leemhuis.info, regressions@lists.linux.dev
Cc:     kernel@collabora.com, linux-kernel@vger.kernel.org,
        Gustavo Padovan <gustavo.padovan@collabora.com>,
        Shreeya Patel <shreeya.patel@collabora.com>
Subject: Re: Kernel regression tracking/reporting initiatives and KCIDB
References: <874jljhtmj.fsf@rcn-XPS-13-9305.i-did-not-set--mail-host-address--so-tickle-me> <c7120c90-e40b-0433-0175-f23f928daa50@collabora.com>
In-reply-to: <c7120c90-e40b-0433-0175-f23f928daa50@collabora.com>
Date:   Fri, 18 Aug 2023 09:50:51 +0200
Message-ID: <87o7j4hjqc.fsf@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On jue, ago 17 2023 at 15:32:21, Guillaume Tucker <guillaume.tucker@collabora.com> wrote:
> With the new API, data is owned by the users who submit it so we can
> effectively provide a solution for grouping data from multiple CI
> systems like KCIDB does.
>
> The key thing here is that KernelCI as a project will be
> providing a database with regression information collected from
> any public CI system.

Does this mean that KernelCI will replace KCIDB? or will they both keep
working separately?

> So the topic of tracking regressions for the whole kernel is already
> part of the roadmap for KernelCI, and if just waiting for CI systems
> to push data is not enough we can have services that actively go and
> look for regressions to feed them into the database under a particular
> category (or user).
> It would be good to align ideas you may have with KernelCI's
> plans

Our ideas start by studying the required features and needs for
regression analysis, reporting and tracking in a general and
system-agnostic way. First the concepts, then the implementation. I
think that analyzing the problem from the specific perspective of
KernelCI (or any other CI system in particular). If we start with a
general approach we can always specialize it later to a particular
implementation, but starting a design with a restricted design in mind,
tailored to a specific system, will probably tie it to that system
permanently.

IMO the work we want to do with regressions should be higher-level,
based on the data produced by a CI system (any of them) and not
dependent on any particular implementation.

> also please take into account the fact that the current
> Regression tracker you've created relies on the legacy system
> which is going to be retired in the coming months.

That's correct. The regression tracker started as a proof of concept to
explore ideas and we based it on KernelCI test data. We're aware that
the legacy system will be retired soon, that's why we want to look into
KCIDB as a data source.

>> - did this test also fail on other hardware targets or with other kernel
>>   configurations?
>> - is it possible that the test failed because of an infrastructure
>>   error?
>
> This should be treated as a false-positive failing test rather
> than a "regression".  But yes of course we need to deal with
> them, it's just slightly off-topic here I think.

Not regressions, that's right, but I don't think these should be simply
categorized as false-positives. If we treated these two particular cases
as false positives we would be hiding and missing important results:

- If the same test case on the same kernel version failed with different
  configurations or in other boards, highlighting that information could
  help narrow down the investigation or point it to the right
  direction. There's definitely a failure (probablyl not a regression)
  but the thing to fix might not be a kernel code commit but the
  configuration used for the test. This can be submitted to the test
  authors or the maintainers of the CI system running the test.

- If the test failed because of an infrastructure error, that's
  something that can be reported to the lab maintainers to fix. This can
  be done automatically.

>> - does the test fail consistently since that commit or does it show
>>   unstable results?
>> - does the test output show any traces of already known bugs?
>> - has this regression been bisected and reported anywhere?
>> - was the regression reported by anyone? If so, is there someone already
>>   working on it?
>
> These are all part of the post-regression checks we've been
> discussing to run as part of KernelCI.  Basically, extending from
> the current automated bisection jobs we have and also taking into
> account the notion of dynamic scheduling.  However, when
> collecting data from other CI systems I don't think there is much
> we can do if the data is not there.  But we might be able to
> create collaborations to run extra post-regression checks in
> other CI systems to tackle this.

This is why I think handling this at a higher level, once all the test
data from multiple CI systems has been collected, could be the right
strategy. Can't these post-regression checks be applied to a common DB
with results aggregated from different CI systems? As long as the
results are collected in a common and standard way, I mean.  We could
have those checks implemented only once, in a centralized and generic
way, instead of having a different implementation of the same process in
each of the data sources.

> Experimenting with KCIDB now may be interesting, but depending on
> the outcome of the discussions around having one central database
> for KernelCI it might not be the optimal way to do it.

Why not? Sorry, I might not have the full context, can you or Nikolai
give a bit more insight about the possible future status of KCIDB and
KernelCI and the relationship between them?

Thanks,
Ricardo
