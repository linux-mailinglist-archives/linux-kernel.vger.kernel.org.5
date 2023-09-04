Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F17915EC
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 12:55:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232892AbjIDKzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 06:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233259AbjIDKzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 06:55:47 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1320099;
        Mon,  4 Sep 2023 03:55:43 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qd7F6-0006Xs-JL; Mon, 04 Sep 2023 12:55:40 +0200
Message-ID: <fec02836-b3d4-6ec3-d0a5-cc5172095837@leemhuis.info>
Date:   Mon, 4 Sep 2023 12:55:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [V2] ata: libata: add workaround to flip LPM during
 suspend/resume
Content-Language: en-US, de-DE
To:     Niklas Cassel <Niklas.Cassel@wdc.com>,
        Koba Ko <koba.ko@canonical.com>
Cc:     Damien Le Moal <dlemoal@kernel.org>,
        "linux-ide@vger.kernel.org" <linux-ide@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230901023457.8655-1-koba.ko@canonical.com>
 <ZPJGGlAQYSXguJEk@x1-carbon>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <ZPJGGlAQYSXguJEk@x1-carbon>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1693824943;54886c2f;
X-HE-SMSGID: 1qd7F6-0006Xs-JL
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01.09.23 22:14, Niklas Cassel wrote:
> On Fri, Sep 01, 2023 at 10:34:57AM +0800, Koba Ko wrote:
>> Due to TigerLake/Adler Lake AHCI controller's LPM regression,
>> can't apply LPM on TigerLake/AdlerLake AHCI controller.
>>
>> Add a workaround to flip LPM during suspend/resume.
>> When suspneding,

Side note: s/suspneding/suspending/

>> apply LPM on TigerLake/AdlerLake AHCI.
>> Restore it to target_lpm_policy after resuming.
>>
>> Link: https://bugzilla.kernel.org/show_bug.cgi?id=217775
>> Signed-off-by: Koba Ko <koba.ko@canonical.com>
>> ---
> 
> I understand that it is very frustrating to not be able to go to the
> deepest C-state.
> 
> If you want LPM, we should add the PCI device and vendor id as a
> board_ahci_low_power entry.
> 
> I am awake that a lot of people reported regressions when that entry was
> added, and that is was thus reverted.
> [...]
> If you do own one of those systems, isn't it better if we instead:
> 1) re-introduce the TigerLake AHCI board_ahci_low_power entry
> 2) debug and fix the root cause of the regressions on TigerLake laptops

Three stupid questions from the cheap seats, as I'm not involved in this
at all (the questions thus might not help at all or even confuse things;
so feel free to ignore or tell me). But it's one of those tricky
situations I more than once encountered as regression tracker, so maybe
sharing a few thoughts from my point might help to lessen the problem
for some users:

- Was something done so to free ourselves from this tricky situation in
the future? E.g. something like "for any future Intel controllers,
enable LPM by default (as then it's not a regression if things don't
work, which might be a better base to get down to the root of the problem)"

- is the LPM working fine on the Laptops affected by
https://bugzilla.kernel.org/show_bug.cgi?id=217114 with the
pre-installed OS (e.g. Windows)

- is switching to LPM maybe safe when there is nothing connected to that
controller (which I guess might be the case on some of those Laptops?)
In that case we might be able to improve the sitaution for some users.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.
