Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2B88774AC2
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 22:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjHHUew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 16:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233444AbjHHUeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 16:34:37 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 08 Aug 2023 13:01:33 PDT
Received: from 16.mo584.mail-out.ovh.net (16.mo584.mail-out.ovh.net [188.165.55.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 303CC1E4E8
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 13:01:31 -0700 (PDT)
Received: from director11.ghost.mail-out.ovh.net (unknown [10.109.143.18])
        by mo584.mail-out.ovh.net (Postfix) with ESMTP id C46AA26303
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 14:05:51 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-r24nl (unknown [10.110.208.139])
        by director11.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 0D0131FEDA;
        Tue,  8 Aug 2023 14:05:50 +0000 (UTC)
Received: from etezian.org ([37.59.142.98])
        by ghost-submission-6684bf9d7b-r24nl with ESMTPSA
        id p6TOOr5L0mRSfwAABv3+PA
        (envelope-from <andi@etezian.org>); Tue, 08 Aug 2023 14:05:50 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-98R002ea6cfa5e-e7a3-4ddd-a662-71fb8ba569fb,
                    BF609BDBD26D07B0CC1BA23A42D268122251ED8C) smtp.auth=andi@etezian.org
X-OVh-ClientIp: 130.25.194.249
From:   Andi Shyti <andi.shyti@kernel.org>
To:     Laxman Dewangan <ldewangan@nvidia.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-i2c@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Parker Newman <pnewman@connecttech.com>
Cc:     Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH] i2c: tegra: Fix i2c-tegra DMA config option processing
Date:   Tue,  8 Aug 2023 16:05:31 +0200
Message-Id: <169150348680.2625585.8234375076796870663.b4-ty@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <fcfcf9b3-c8c4-9b34-2ff8-cd60a3d490bd@connecttech.com>
References: <fcfcf9b3-c8c4-9b34-2ff8-cd60a3d490bd@connecttech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Ovh-Tracer-Id: 5458081274953468487
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrledvgdejudcutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjughrpefhvfevufffkffojghfgggtgfesthekredtredtjeenucfhrhhomheptehnughiucfuhhihthhiuceorghnughirdhshhihthhisehkvghrnhgvlhdrohhrgheqnecuggftrfgrthhtvghrnhepveevieffieefgfefuddvteelffeuhfelffejteejuddvveekveehvdejgeefteevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucfkphepuddvjedrtddrtddruddpudeftddrvdehrdduleegrddvgeelpdefjedrheelrddugedvrdelkeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoegrnhguihesvghtvgiiihgrnhdrohhrgheqpdhnsggprhgtphhtthhopedupdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdfovfetjfhoshhtpehmohehkeegpdhmohguvgepshhmthhpohhuth
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On Thu, 03 Aug 2023 17:10:02 +0000, Parker Newman wrote:
> This patch fixes the Tegra DMA config option processing in the
> i2c-tegra driver.
> 
> Tegra processors prior to Tegra186 used APB DMA for I2C requiring
> CONFIG_TEGRA20_APB_DMA=y while Tegra186 and later use GPC DMA requiring
> CONFIG_TEGRA186_GPC_DMA=y.
> 
> [...]

With the Fixes tag added, applied to i2c/andi-for-current on

https://git.kernel.org/pub/scm/linux/kernel/git/andi.shyti/linux.git

Please note that this patch may still undergo further evaluation
and the final decision will be made in collaboration with
Wolfram.

Thank you,
Andi

Patches applied
===============
[1/1] i2c: tegra: Fix i2c-tegra DMA config option processing
      commit: fc9a464f3d9a2a361e8bcb960345270a9dc46054
