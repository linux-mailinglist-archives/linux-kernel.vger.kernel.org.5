Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CD5F75FE9A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 19:57:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbjGXR5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 13:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjGXR4w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 13:56:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93FBC4C0C
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 10:54:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2E05CFEC;
        Mon, 24 Jul 2023 10:55:40 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2B7453F5A1;
        Mon, 24 Jul 2023 10:54:56 -0700 (PDT)
Message-ID: <1e675286-b4b8-5abd-dd4c-3f2ffdaf12c1@arm.com>
Date:   Mon, 24 Jul 2023 19:54:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH] sched/fair: Fix impossible migrate_util scenario in
 load balance
Content-Language: en-US
To:     Qais Yousef <qyousef@layalina.io>
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
References: <20230716014125.139577-1-qyousef@layalina.io>
 <ZLaKFFjY6NWaJdOq@vingu-book> <20230718161829.ws3vn3ufnod6kpxh@airbuntu>
 <CAKfTPtA55NemHq0tZPuiEN=c3DRZWD-7jf7ZrKdHE9y9b_szZg@mail.gmail.com>
 <20230718172522.s4gcfx3ppljwbks7@airbuntu>
 <CAKfTPtA6s82qXWOSdd6eNu__z_HZe9U_F0+RcBJj=PVKT7go7A@mail.gmail.com>
 <20230721105711.nzunqdtdaevmrgyg@airbuntu> <ZLqNmpQdiTC2fio5@vingu-book>
 <20230721220430.qv6eqo4dosfrsilo@airbuntu>
 <c31e5667-19b1-33a4-d1f1-a88907e239d3@arm.com>
 <20230724161038.nreywdwayiq2ypty@airbuntu>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20230724161038.nreywdwayiq2ypty@airbuntu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/07/2023 18:10, Qais Yousef wrote:
> On 07/24/23 14:58, Dietmar Eggemann wrote:
>> On 22/07/2023 00:04, Qais Yousef wrote:
>>> On 07/21/23 15:52, Vincent Guittot wrote:
>>>> Le vendredi 21 juil. 2023 à 11:57:11 (+0100), Qais Yousef a écrit :
>>>>> On 07/20/23 14:31, Vincent Guittot wrote:

[...]

> So I actually moved everything to a single cluster and this indeed solves the
> lb() issue. But then when I tried to look at DT mainline I saw that the DTs
> still define separate cluster for each uArch, and this got me confused whether
> I did the right thing or not. And made me wonder whether the fix is to change
> DT or port Sudeep's/Ionela's patch?

IMHO, you have to change DT.

> I did some digging and I think the DT, like the ones in mainline by the look of
> it, stayed the way it was historically defined.

This would be a "mistake" for Arm DynamIQ based systems. We use QC RB5
in our testing and this board schedules only within a MC sched domain (I
guess it's: arch/arm64/boot/dts/qcom/qrb5165-rb5.dts -> sm8250.dtsi)

> So IIUC the impacts are on system pre-simplified EM (should have been phased
> out AFAIK). And on different presentation on sysfs topology which can
> potentially break userspace deps, right? I think this is not a problem too, but
> can be famous last words as usual :-)

The only thing I remember was when we hinted at this issue to Android
folks a couple of years ago, they said they have to stay with the
phantom domain due to dependencies from vendor specific code other than
related to the EM.

IMHO, for Pixel6 the DT cpu-map information is in:

  private/gs-google/arch/arm64/boot/dts/google/gs101-cpu.dtsi

of the android-kernel.

[...]














