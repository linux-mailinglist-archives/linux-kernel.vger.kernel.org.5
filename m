Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B90480CF3E
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Dec 2023 16:13:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234977AbjLKPNY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Dec 2023 10:13:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344182AbjLKPM6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Dec 2023 10:12:58 -0500
X-Greylist: delayed 6064 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 11 Dec 2023 07:13:00 PST
Received: from madrid.collaboradmins.com (madrid.collaboradmins.com [IPv6:2a00:1098:ed:100::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BF89E8;
        Mon, 11 Dec 2023 07:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1702307578;
        bh=61MpOgh6apy3cL2Alemf5fYKv3kzcV8mTb03x/Z34AY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZJRufRZ7sHw1oCHB36MbThWcF5BgNlLirxb14CvjFKsVlqJqsQAy07GcVpG6ZtcOJ
         rlhXmkqHH6c+Q6TUIvxKYaVL+OGUDwMwHA41TI4eWD6Vm5bVvZQCAAPytT8+a47jB+
         1uDMffazEwPOK2KJeR7dVKyC04/q9Y0G5f+cEVgyiDup27tt+yldGd6RVfb6ytCD7I
         +lGed60AOs/KVbBS+B3i1+cd4U76mamaYeDOqeejAfsJoaOJ3yNK4QBOab7jA+F1TG
         zgE6uMLTveBOGsTag4NlhAf/OkpWzM3UDgVFpBIHN/8hmfZdVJcmwlnz4G9MGPNn9Z
         v0LzALeJMdRiw==
Received: from arch-x395 (cola.collaboradmins.com [195.201.22.229])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: evelikov)
        by madrid.collaboradmins.com (Postfix) with ESMTPSA id E4E9337813FD;
        Mon, 11 Dec 2023 15:12:56 +0000 (UTC)
Date:   Mon, 11 Dec 2023 15:12:54 +0000
From:   Emil Velikov <emil.velikov@collabora.com>
To:     Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
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
Subject: Re: [PATCH 0/5] Improve AMD ACP Vangogh audio support for Steam Deck
 OLED
Message-ID: <ZXcm9v0vgnc7gGfc@arch-x395>
References: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231209203229.878730-1-cristian.ciocaltea@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/12/09, Cristian Ciocaltea wrote:
> This patch series provides several fixes and improvements to AMD ACP drivers
> targeting the Vangogh platform, as found on the Valve's new Steam Deck OLED.
> 
> Although in theory the board should have been supported by both SOF and legacy
> ACP drivers, as of next-20231208 the audio seems to be completely broken.
> 
> Please note this only restores the legacy support, while SOF will be handled in
> a separate series.
> 
> Cristian Ciocaltea (5):
>   ASoC: amd: vangogh: Drop conflicting ACPI-based probing
>   ASoC: amd: vangogh: Allow probing ACP PCI when SOF is disabled
>   ASoC: amd: vangogh: Switch to {RUNTIME,SYSTEM_SLEEP}_PM_OPS
>   ASoC: amd: acp-config: Add missing MODULE_DESCRIPTION
>   ASoC: amd: acp: Add missing MODULE_DESCRIPTION in mach-common
> 

If it were me, I'd drop the Fixes tag in the latter two patches since
the warning is harmless and as-is it'll get into the -stable
maintainers' list, who are already pretty swamped with patches.

Regardless, for the series:
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>

HTH
Emil
