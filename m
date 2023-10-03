Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C50E7B6651
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 12:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjJCKZF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 06:25:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjJCKZE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 06:25:04 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F503A6
        for <linux-kernel@vger.kernel.org>; Tue,  3 Oct 2023 03:24:59 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qncaH-0002AJ-7T; Tue, 03 Oct 2023 12:24:57 +0200
Message-ID: <aa54a70c-e7fc-4ca2-9a4d-425675ed0be3@leemhuis.info>
Date:   Tue, 3 Oct 2023 12:24:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] ASoC: amd: yc: Fix non-functional mic on Lenovo Yoga Slim
 7 Pro 14ARH7 82UU
Content-Language: en-US, de-DE
To:     Markus Meier <kerneldev@epic-bytes.net>,
        alsa-devel@alsa-project.org
References: <10347605.nUPlyArG6x@kali>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Cc:     Linux kernel regressions list <regressions@lists.linux.dev>,
        LKML <linux-kernel@vger.kernel.org>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Brown <broonie@kernel.org>,
        Sven Frotscher <sven.frotscher@gmail.com>,
        August Wikerfors <git@augustwikerfors.se>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <10347605.nUPlyArG6x@kali>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696328699;cb484eac;
X-HE-SMSGID: 1qncaH-0002AJ-7T
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02.10.23 23:04, Markus Meier wrote:
> 
> I own a  Lenovo Yoga Slim 7 Pro 14ARH7 where the microphone is not showing up.
> I added the system to the quirk table and the mic is working correctly (but 
> with very low volume) now.
> 
> Here's an except from dmidecode:
> System Information
>         Manufacturer: LENOVO
>         Product Name: 82UU
>         Version: Yoga Slim 7 Pro 14ARH7
>         SKU Number: LENOVO_MT_82UU_BU_idea_FM_Yoga Slim 7 Pro 14ARH7
>         Family: Yoga Slim 7 Pro 14ARH7
>
> Please add this patch to the kernel and add it to the stable kernels too. I 
> guess the microphone should have worked before. Seems to be a regression 
> introduced by c008323fe361bd62a43d9fb29737dacd5c067fb7
>
> [-- Attachment #2: yoga-slim-7-pro-82UU-microphone.patch --]
> [-- Type: text/x-patch, Size: 451 bytes --]
> 
> --- a/sound/soc/amd/yc/acp6x-mach.c	2023-09-29 19:31:03.753786095 +0200
> +++ b/sound/soc/amd/yc/acp6x-mach.c	2023-09-29 19:32:06.414276453 +0200
> @@ -217,6 +217,13 @@
>  		.driver_data = &acp6x_card,
>  		.matches = {
>  			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82UU"),
> +		}
> +	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
>  			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
>  		}
>  	},

I CCed a bunch of lists and people to make sure everyone is aware of
that patch, as it otherwise might fall through the cracks.

Markus, quick question: do you have (a) an interest in contributing a
change to Linux or (b) did you just post this because Mario asked you to
do so in https://bugzilla.kernel.org/show_bug.cgi?id=217063#c25 ?

If it's (a) then you might want to take a closer look at
https://www.kernel.org/doc/html/latest/process/submitting-patches.html
, as your patch lacks a few important things before it can be applied
(most notably a Signed-off-by tag)

If it's (b) I wonder if it would be easier for everyone involved if some
kernel developer could create a patch own their own, as that likely is
way easier to review and thus likely gets the problem resolved a lot faster.

Ciao, Thorsten
