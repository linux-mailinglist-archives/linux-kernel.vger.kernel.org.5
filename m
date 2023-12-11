Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A216680D33C
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 18:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344262AbjLKREx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 12:04:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjLKREv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 12:04:51 -0500
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66AB68E;
        Mon, 11 Dec 2023 09:04:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702314295;
        bh=ql7mK0NO5lV8Eo4S5IGxxve3zvILVNJcv/sz+C+oCKQ=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YTQiDMPN/cXiD4oPlBzvOVlb047A4bLmZSA4Beb9u0DBldFbh5tmIUYjJcU6W+9fD
         fPgFrYcpYbA4mP3XTuGxFZzzY6l0RGxbXPdHF5bSGIDK5u6xlF0WJ78BnZD+Qbs2lW
         CaFRe6wNqjQB8lv6FXwsgJhhE5jwEudiqwL7ExIViJNRMZLqAYNEwgK5oWoadQWcfp
         Hmqno/NU4eYb8foJJbeN3NbGThZtF3sWrKOh8hxyTlmHA3JtyZstnvOBAiSEO5fV1y
         frzqjcaLZDO/AUQ6NK4yYRra2Uoo9sxL4he0cBCZkZeW0I3zFZ9R0iftavby7UG7Su
         NtDCclQRkFxbw==
Received: from [100.115.223.179] (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: cristicc)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id 7C081378131A;
        Mon, 11 Dec 2023 17:04:54 +0000 (UTC)
Message-ID: <23ddcf66-7656-466f-9244-f82ffa66e504@collabora.com>
Date:   Mon, 11 Dec 2023 19:04:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Improve AMD ACP Vangogh audio support for Steam Deck
 OLED
Content-Language: en-US
To:     Emil Velikov <emil.velikov@collabora.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        Marian Postevca <posteuca@mutex.one>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Alper Nebi Yasak <alpernebiyasak@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Rander Wang <rander.wang@intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Ajit Kumar Pandey <AjitKumar.Pandey@amd.com>,
        Bard Liao <bard.liao@intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
 <ZXcm9v0vgnc7gGfc@arch-x395>
From:   Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
In-Reply-To: <ZXcm9v0vgnc7gGfc@arch-x395>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/23 17:12, Emil Velikov wrote:
> On 2023/12/09, Cristian Ciocaltea wrote:
>> This patch series provides several fixes and improvements to AMD ACP drivers
>> targeting the Vangogh platform, as found on the Valve's new Steam Deck OLED.
>>
>> Although in theory the board should have been supported by both SOF and legacy
>> ACP drivers, as of next-20231208 the audio seems to be completely broken.
>>
>> Please note this only restores the legacy support, while SOF will be handled in
>> a separate series.
>>
>> Cristian Ciocaltea (5):
>>   ASoC: amd: vangogh: Drop conflicting ACPI-based probing
>>   ASoC: amd: vangogh: Allow probing ACP PCI when SOF is disabled
>>   ASoC: amd: vangogh: Switch to {RUNTIME,SYSTEM_SLEEP}_PM_OPS
>>   ASoC: amd: acp-config: Add missing MODULE_DESCRIPTION
>>   ASoC: amd: acp: Add missing MODULE_DESCRIPTION in mach-common
>>
> 
> If it were me, I'd drop the Fixes tag in the latter two patches since
> the warning is harmless and as-is it'll get into the -stable
> maintainers' list, who are already pretty swamped with patches.

Sure, I can drop them if there is a need for v2.

> Regardless, for the series:
> Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

Thanks for the review,
Cristian

> HTH
> Emil
