Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87672781001
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 18:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378501AbjHRQMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 12:12:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378517AbjHRQMM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 12:12:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D03C4213;
        Fri, 18 Aug 2023 09:12:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DF2DA63283;
        Fri, 18 Aug 2023 16:12:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45906C433C8;
        Fri, 18 Aug 2023 16:12:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1692375127;
        bh=nhXaS1ILNMTtOOyTp0Qc/n36yZYia81Kcw5EtjMJ4PU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=vRZSc8c0N5HHbodOqhOc1b10LJdMdUMqCK1yb4IEPu4RES6OMr5KZOu1uxQoucf7/
         E8A4q9BpYY7kEIHJydRvQPP7EMx++kV1yq0GX/cfyS/uSD5rykdCTSrHpE27HxSL9d
         58ZjD0VQoWiYSI29GfdA6lnY+TBe7zsXldvtnQUrSIjO3KNmKfQd1R/n4W93cVbKjR
         Sw56cgOlmGgy2HRO1/JQMh7QCMxQX0pTXzoerlj4kqlxXIt3lfE3s944XoTd0EcaMs
         fRWCBcm0Z4fY3AuaUIrENcHm7p69w24p4OlOhhDmU4717EAuvuT1oSq15WUEy4LjTT
         YsyyyUeTQRrOA==
Date:   Fri, 18 Aug 2023 17:12:01 +0100
From:   Lee Jones <lee@kernel.org>
To:     Benjamin Bara <bbara93@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        peng.fan@oss.nxp.com, rafael.j.wysocki@intel.com,
        Jerome Neanne <jneanne@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Thierry Reding <treding@nvidia.com>
Subject: Re: [PATCH v2 0/6] regulator: pca9450: register restart handlers
Message-ID: <20230818161201.GC986605@google.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Aug 2023, Benjamin Bara wrote:

> Hi!
> 
> This series implements two restart handler registrations for the pca9450
> (6/6). As the pca9450 supports both, cold and warm resets, and there
> exist at least one other PMIC implementation which also implements a
> warm and a cold reset (tps65219), 1-5/6 should simplify/clarify the
> distinction process between warm/soft and cold/hard resets/restarts.
> Instead of deciding in the handler, this should be done during
> registration. The series is a follow-up to Dmitry's feedback, regarding
> checking the reboot_mode in the handler [1].
> 
> As the cold handler queue is executed before the warm handler queue
> (when the reboot_mode is not changed/specified), cold handlers are
> implicitly executed with a higher prio and therefore the default
> registration can be used.
> 
> This series is based on linux-next and 6/6 depends on [2].
> 
> Thanks & best regards,
> Benjamin
> 
> [1] https://lore.kernel.org/all/7eddaf8c-ab04-7670-fc45-15f0fce5eff2@collabora.com/
> [2] https://lore.kernel.org/all/20230327-tegra-pmic-reboot-v7-3-18699d5dcd76@skidata.com/
> 
> ---
> Changes in v2:
> - rebase to next-20230809
> - improve commit messages
> - use helper (with implicit priority) instead of explicit priority
> - fallback to warm handler if hard/cold requested but failed
> - Link to v1: https://lore.kernel.org/r/20230727-pca9450-reboot-v1-0-c8edb27bf404@skidata.com
> 
> ---
> Benjamin Bara (6):
>       kernel/reboot: distinguish between cold and warm
>       mfd: rk8xx: Specify restart mode
>       soc/tegra: pmc: Specify restart mode
>       mfd: tps65219: Specify restart mode
>       kernel/reboot: remove generic restart mode
>       regulator: pca9450: register restart handlers

What are they interdependencies between them all?

Should they all be applied at once?

>  drivers/mfd/rk8xx-core.c              |  6 +--
>  drivers/mfd/tps65219.c                | 17 +++++--
>  drivers/regulator/pca9450-regulator.c | 59 ++++++++++++++++++++++++
>  drivers/soc/tegra/pmc.c               |  2 +-
>  include/linux/reboot.h                | 23 +++++++---
>  include/linux/regulator/pca9450.h     |  7 +++
>  kernel/reboot.c                       | 84 +++++++++++++++++++++++++++++------
>  7 files changed, 170 insertions(+), 28 deletions(-)
> ---
> base-commit: 21ef7b1e17d039053edaeaf41142423810572741
> change-id: 20230724-pca9450-reboot-0b32218fc7a2
> 
> Best regards,
> -- 
> Benjamin Bara <benjamin.bara@skidata.com>
> 

-- 
Lee Jones [李琼斯]
