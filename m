Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD8E97B55CB
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 17:01:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237847AbjJBOgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 10:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237841AbjJBOgo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 10:36:44 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D72B0;
        Mon,  2 Oct 2023 07:36:40 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qnK2D-0007cK-38; Mon, 02 Oct 2023 16:36:33 +0200
Message-ID: <5ef915d0-82af-4b85-88e4-d4078228c38d@leemhuis.info>
Date:   Mon, 2 Oct 2023 16:36:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Content-Language: en-US, de-DE
To:     Mario Limonciello <mario.limonciello@amd.com>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Mark Brown <broonie@kernel.org>
Cc:     Sven Frotscher <sven.frotscher@gmail.com>, git@augustwikerfors.se,
        alsa-devel@alsa-project.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
 <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
 <4fa7d39d-dc34-4550-97fa-2b089f364cca@sirena.org.uk>
 <0a3feafc-b843-420a-9b04-c835f8210c1a@amd.com>
 <048d9715-9cb2-4bc0-b8b0-5e30a0db54c7@leemhuis.info>
 <28e38593-4861-4d61-b27d-994328ea4e82@amd.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <28e38593-4861-4d61-b27d-994328ea4e82@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696257401;54b82d18;
X-HE-SMSGID: 1qnK2D-0007cK-38
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.23 16:20, Mario Limonciello wrote:
> On 10/2/2023 09:13, Linux regression tracking (Thorsten Leemhuis) wrote:
>> On 02.10.23 15:47, Mario Limonciello wrote:
>>> On 10/2/2023 06:52, Mark Brown wrote:
>>>> On Mon, Oct 02, 2023 at 11:32:48AM +0200, Linux regression tracking
>>>> (Thorsten Leemhuis) wrote:
>>>>
>>>>> Makes me wonder: How many more such quirk entries will be needed? Will
>>>>> we have all machines listed soon, or do we expect that future Lenovo
>>>>> hardware will need entries as well? If it's the latter: are quirks
>>>>> really the right solution here, or do they just hide some bug or then
>>>>> need for code that automatically handles things?
>>>>
>>>> x86 firmware descriptions are terrible, it's just an endless procession
>>>> of quirks.  The model for ACPI is not to describe key information in
>>>> the
>>>> kernel and instead on Windows load device specific information from
>>>> separately supplied tables.  On Linux that translates into these
>>>> endless
>>>> quirks, on Windows it's platform specific drivers for otherwise generic
>>>> audio hardware.
>>>
>>> I knew there was a TON of "82" prefix systems from Lenovo so it was an
>>> educated guess that all of them needed DMIC support.  This was incorrect
>>> because one of them didn't have DMIC and that caused a no mic support
>>> problem on that system.
>>>
>>> So in the case of this seemingly endless list of systems being added to
>>> enable DMIC support Mark is right, Windows does it differently.
>>
>> Now I understand things better, many thx. But please allow me one more
>> question from the cheap seats:
>>
>> Seems before c008323fe361 things worked for a lot of systems for about
>> one year thx to 2232b2dd8cd4 (which added the wide "82" prefix quirk).
>> We then made that one machine work with c008323fe361, but broke a lot of
>> others with it that now need to be fixed with additional quirks; that
>> "TON of 82 prefix systems" sounds like we might not be close to the end
>> of that journey.
>>
>> So can't we just do it the other way around and assume DMIC support on
>> Lenovo 82* machines, except on those where we know it to cause trouble?
>>
>> Again: you are the experts here. If you are positive that we soon got
>> all machines covered where c008323fe361 causes a regression, then I
>> guess it's best to continue the patch we're on.
> 
> I don't like lists

And I don't like if we let people run into regressions knowingly. ;)

> that enable something for a ton of systems and then
> lists that disable something for a subset of them.  This becomes
> difficult to maintain.

Well, I had more thought along the lines of "do enable DMIC on Lenovo
82*, unless the following dmi (the one from c008323fe361) matches". But
I assume that's not easy to realize with the quirks table, so I guess
that is out. Whatever.

Well, I rest my case. But I guess I might come back to this if multiple
additional regressions reports come it due to c008323fe361.

Ciao, Thorsten
