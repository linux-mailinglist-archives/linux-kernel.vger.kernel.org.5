Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B606E811147
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 13:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378856AbjLMMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 07:45:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233416AbjLMMpz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 07:45:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94A4ADB
        for <linux-kernel@vger.kernel.org>; Wed, 13 Dec 2023 04:46:01 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F10FC433C7;
        Wed, 13 Dec 2023 12:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1702471561;
        bh=UqFTwJlv/HHhsk51P3RSZ4bmpRtBPRMXihdAMtpeCNY=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=SeA3xxHO7yrmmfB2KFZrqVJEWt2vt4NxSiFoXQXR6fpT/rmmTxIodcu3eA/bmmYkR
         upieDGK4Hq5XJ+BtmAbg2viqMRak5Ec9zsXAsryytWiR+p+srQKVfTcPlsbBQ++en/
         lQUenyeRjbmAWIrgpFp6a03gLgdeKCOg2Cifx9wtrdwX9VQBaDgXNmJcAObY5f5Ipw
         h/qJvDB97QydJfmyE7AeLgmTJNaeHmIbnhiixQaNANwe/1i5O0uFkb1ypomLhKaBgy
         BVOCu0lU8Ls+r1/fzpUJue9muW8t1xhhzZKbWOTXpgLFqf9JH3bkSySN9eTKTrSCL2
         fons/DqBkx3zA==
From:   Kalle Valo <kvalo@kernel.org>
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Sean Wang <sean.wang@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Deren Wu <deren.wu@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Ben Greear <greearb@candelatech.com>,
        "open list:MEDIATEK MT76 WIRELESS LAN DRIVER" 
        <linux-wireless@vger.kernel.org>,
        "open list:ARM/Mediatek SoC support" <linux-kernel@vger.kernel.org>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Sultan Alsawaf <sultan@kerneltoast.com>
Subject: Re: [PATCH 1/2] wifi: mt76: mt7921: Disable powersaving by default
References: <20231212090852.162787-1-mario.limonciello@amd.com>
Date:   Wed, 13 Dec 2023 14:45:55 +0200
In-Reply-To: <20231212090852.162787-1-mario.limonciello@amd.com> (Mario
        Limonciello's message of "Tue, 12 Dec 2023 03:08:51 -0600")
Message-ID: <874jgmnud8.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mario Limonciello <mario.limonciello@amd.com> writes:

> Several users have reported awful latency when powersaving is enabled
> with certain access point combinations.

What APs are these exactly? In the past 802.11 Power Save Mode was
challenging due to badly behaving APs. But nowadays with so many mobile
devices in the market I would assume that APs work a lot better. It
would be best to investigate the issues in detail and try to fix them in
mt76, assuming the bugs are in mt76 driver or firmware.

> It's also reported that the powersaving feature doesn't provide an
> ample enough savings to justify being enabled by default with these
> issues.

Any numbers or how was this concluded?

> Introduce a module parameter that would control the power saving
> behavior.  Set it to default as disabled. This mirrors what some other
> WLAN drivers like iwlwifi do.

We have already several ways to control 802.11 power save mode:

* NL80211_CMD_SET_POWER_SAVE (for example used by 'iw set power_save')

* CONFIG_CFG80211_DEFAULT_PS (for kernel level default)

* WIPHY_FLAG_PS_ON_BY_DEFAULT (for the driver to control the default setting)

Adding module parameters as a fourth method sounds confusing so not
really a fan of this. And the bar is quite high for adding new module
parameters anyway.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
