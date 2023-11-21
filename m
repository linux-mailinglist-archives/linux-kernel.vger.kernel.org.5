Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2337F37D8
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 22:08:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233840AbjKUVIa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 16:08:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjKUVI3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 16:08:29 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 42F3419E;
        Tue, 21 Nov 2023 13:08:25 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C09D8168F;
        Tue, 21 Nov 2023 13:09:11 -0800 (PST)
Received: from [10.57.3.233] (unknown [10.57.3.233])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5E7C03F7F4;
        Tue, 21 Nov 2023 13:08:22 -0800 (PST)
Message-ID: <4e3b7661-7233-4142-a785-406ec384d90a@arm.com>
Date:   Tue, 21 Nov 2023 21:09:21 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 9/9] thermal: exynos: use set_trips
Content-Language: en-US
To:     Mateusz Majewski <m.majewski2@samsung.com>
Cc:     Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
        linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20231120145049.310509-1-m.majewski2@samsung.com>
 <CGME20231120145109eucas1p16cb513a27831e7855cdd076c49b482c5@eucas1p1.samsung.com>
 <20231120145049.310509-10-m.majewski2@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
In-Reply-To: <20231120145049.310509-10-m.majewski2@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/20/23 14:50, Mateusz Majewski wrote:
> Currently, each trip point defined in the device tree corresponds to a
> single hardware interrupt. This commit instead switches to using two
> hardware interrupts, whose values are set dynamically using the
> set_trips callback. Additionally, the critical temperature threshold is
> handled specifically.
> 
> Setting interrupts in this way also fixes a long-standing lockdep
> warning, which was caused by calling thermal_zone_get_trips with our
> lock being held. Do note that this requires TMU initialization to be
> split into two parts, as done by the parent commit: parts of the
> initialization call into the thermal_zone_device structure and so must
> be done after its registration, but the initialization is also
> responsible for setting up calibration, which must be done before
> thermal_zone_device registration, which will call set_trips for the
> first time; if the calibration is not done in time, the interrupt values
> will be silently wrong!
> 
> Signed-off-by: Mateusz Majewski <m.majewski2@samsung.com>
> ---
> v4 -> v5: Simplified Exynos 7 code, used the correct register offsets
>    for Exynos 7 and refactored some common register-setting code.
> v2 -> v3: Fixed formatting of some comments.
> v1 -> v2: We take clocks into account; anything that sets temperature
>    thresholds needs clk.
> 
>   drivers/thermal/samsung/exynos_tmu.c | 393 ++++++++++++++-------------
>   1 file changed, 209 insertions(+), 184 deletions(-)

The code LGTM and I like the idea of dynamically configured IRQs for
trips.

Reviewed-by: Lukasz Luba <lukasz.luba@arm.com>

Regards,
Lukasz
