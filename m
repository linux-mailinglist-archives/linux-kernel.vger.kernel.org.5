Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7714D7B4F15
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Oct 2023 11:33:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236130AbjJBJdD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Oct 2023 05:33:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236124AbjJBJc6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Oct 2023 05:32:58 -0400
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A640C83;
        Mon,  2 Oct 2023 02:32:55 -0700 (PDT)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1qnFIJ-0007Xi-6c; Mon, 02 Oct 2023 11:32:51 +0200
Message-ID: <46560887-0b6e-42ac-96c3-b4dbc1d7cb61@leemhuis.info>
Date:   Mon, 2 Oct 2023 11:32:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4] ASoC: amd: yc: Fix non-functional mic on Lenovo 82YM
Content-Language: en-US, de-DE
To:     Sven Frotscher <sven.frotscher@gmail.com>, broonie@kernel.org,
        mario.limonciello@amd.com
Cc:     git@augustwikerfors.se, alsa-devel@alsa-project.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        regressions@lists.linux.dev, stable@vger.kernel.org,
        Takashi Iwai <tiwai@suse.com>
References: <20230927223758.18870-1-sven.frotscher@gmail.com>
From:   "Linux regression tracking (Thorsten Leemhuis)" 
        <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <20230927223758.18870-1-sven.frotscher@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1696239175;6b305401;
X-HE-SMSGID: 1qnFIJ-0007Xi-6c
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[adding Takashi to this, in case he wants to chime in]

Sven, first off, thx for taking care of this.

On 28.09.23 00:36, Sven Frotscher wrote:
> Like the Lenovo 82TL, 82V2, 82QF and 82UG, the 82YM (Yoga 7 14ARP8)
> requires an entry in the quirk list to enable the internal microphone.
>
> The latter two received similar fixes in commit 1263cc0f414d
> ("ASoC: amd: yc: Fix non-functional mic on Lenovo 82QF and 82UG").
>> Fixes: c008323fe361 ("ASoC: amd: yc: Fix a non-functional mic on
Lenovo 82SJ")

FWIW, apparently the Leonovo Yoga Slim 7 Pro 82UU needs an quirk entry
as well: https://bugzilla.kernel.org/show_bug.cgi?id=217063#c23

Makes me wonder: How many more such quirk entries will be needed? Will
we have all machines listed soon, or do we expect that future Lenovo
hardware will need entries as well? If it's the latter: are quirks
really the right solution here, or do they just hide some bug or then
need for code that automatically handles things?

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.


> Cc: stable@vger.kernel.org
> Signed-off-by: Sven Frotscher <sven.frotscher@gmail.com>
>
> [...]
>
> diff --git a/sound/soc/amd/yc/acp6x-mach.c b/sound/soc/amd/yc/acp6x-mach.c
> index 94e9eb8e73f2..15a864dcd7bd 100644
> --- a/sound/soc/amd/yc/acp6x-mach.c
> +++ b/sound/soc/amd/yc/acp6x-mach.c
> @@ -241,6 +241,13 @@ static const struct dmi_system_id yc_acp_quirk_table[] = {
>  			DMI_MATCH(DMI_PRODUCT_NAME, "82V2"),
>  		}
>  	},
> +	{
> +		.driver_data = &acp6x_card,
> +		.matches = {
> +			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
> +			DMI_MATCH(DMI_PRODUCT_NAME, "82YM"),
> +		}
> +	},
>  	{
>  		.driver_data = &acp6x_card,
>  		.matches = {
