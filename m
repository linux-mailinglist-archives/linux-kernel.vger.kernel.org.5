Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 247E177C394
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 00:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233336AbjHNWjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 18:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232241AbjHNWio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 18:38:44 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 021AAAB;
        Mon, 14 Aug 2023 15:38:43 -0700 (PDT)
Received: from [192.168.2.208] (109-252-150-127.dynamic.spd-mgts.ru [109.252.150.127])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dmitry.osipenko)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 46CC566071A3;
        Mon, 14 Aug 2023 23:38:41 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1692052722;
        bh=BjUydujNsGl7AkwVT/LuTkmCIWTEV3NBa6yNtCfHTqY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NGhn5jq26xePnjedA4fZpXU4FmWC8u3WB0XMg7ALYUQByn1OqFbzCgP59pDqn4bDl
         E0y3aWHSOuVbRDt0X3y+eM8YS4GLczboXwBBaxjC9r3EQz9BFmmxjuHqBgidNjB2kD
         D5NbOC0rDMC2+AtJmH+anESIPB68Sr2B+S3COFadaMuMAQoR/W28CPONg8ZaxCefTF
         cJKfhUUjI45JrOQK64b2Yrp/Kyc8rmGM4ASnCICoulLnKxC7IgH5o37BU8N2c6mLDY
         Vw94b4o3ZujNzSSMOWPpV9L48ATdFbX0YQHeS8ScSBli3pLRDTFNKcdFTWp2hgo6CV
         i6gKrB/4vr7ZQ==
Message-ID: <76da3727-a4da-ac70-aa8e-b362b9114061@collabora.com>
Date:   Tue, 15 Aug 2023 01:38:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 3/6] soc/tegra: pmc: Specify restart mode
Content-Language: en-US
To:     Benjamin Bara <bbara93@gmail.com>, Lee Jones <lee@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Tony Lindgren <tony@atomide.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, peng.fan@oss.nxp.com,
        rafael.j.wysocki@intel.com, Jerome Neanne <jneanne@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Benjamin Bara <benjamin.bara@skidata.com>,
        Thierry Reding <treding@nvidia.com>
References: <20230809-pca9450-reboot-v2-0-b98b4f8139d5@skidata.com>
 <20230809-pca9450-reboot-v2-3-b98b4f8139d5@skidata.com>
From:   Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <20230809-pca9450-reboot-v2-3-b98b4f8139d5@skidata.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/23 22:24, Benjamin Bara wrote:
> From: Benjamin Bara <benjamin.bara@skidata.com>
> 
> The current restart handler registration does not specify whether the
> restart is a cold or a warm one. Now, as do_kernel_restart() knows about
> the type, the priorization is implicitly done (cold restarts are
> executed first) and the reboot_mode kernel parameter (which is currently
> mostly ignored) can be respected.
> 
> Acked-by: Thierry Reding <treding@nvidia.com>
> Signed-off-by: Benjamin Bara <benjamin.bara@skidata.com>
> ---
> v2:
> - improve commit message
> ---
>  drivers/soc/tegra/pmc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
> index 162f52456f65..4f42febb9b0f 100644
> --- a/drivers/soc/tegra/pmc.c
> +++ b/drivers/soc/tegra/pmc.c
> @@ -2962,7 +2962,7 @@ static int tegra_pmc_probe(struct platform_device *pdev)
>  	}
>  
>  	err = devm_register_sys_off_handler(&pdev->dev,
> -					    SYS_OFF_MODE_RESTART,
> +					    SYS_OFF_MODE_RESTART_WARM,
>  					    SYS_OFF_PRIO_LOW,
>  					    tegra_pmc_restart_handler, NULL);
>  	if (err) {
> 

You have tegra-pmc restart handler that uses low priority. And then
you're adding cold/warm handlers to tps65219 and pca9450 drivers with a
default priorities. Hence this cold/warm separation of handlers doesn't
do any practical difference in yours case because tegra-pmc will never
be used as it did before your changes?

Previously you wanted to make tps6586x driver to skip the warm reboot,
but you're not touching tps6586x in this patchset. There is no real
problem that is solved by these patches?

-- 
Best regards,
Dmitry

