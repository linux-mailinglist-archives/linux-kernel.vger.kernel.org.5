Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46E917E57E5
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344688AbjKHNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:20:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbjKHNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:20:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D8761BE3
        for <linux-kernel@vger.kernel.org>; Wed,  8 Nov 2023 05:20:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 658121477;
        Wed,  8 Nov 2023 05:20:49 -0800 (PST)
Received: from [10.1.36.36] (e122027.cambridge.arm.com [10.1.36.36])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 587E83F703;
        Wed,  8 Nov 2023 05:20:02 -0800 (PST)
Message-ID: <7928524a-b581-483b-b1a1-6ffd719ce650@arm.com>
Date:   Wed, 8 Nov 2023 13:20:00 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] drm/panfrost: Really power off GPU cores in
 panfrost_gpu_power_off()
Content-Language: en-GB
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        boris.brezillon@collabora.com
Cc:     robh@kernel.org, maarten.lankhorst@linux.intel.com,
        mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, wenst@chromium.org,
        kernel@collabora.com
References: <20231102141507.73481-1-angelogioacchino.delregno@collabora.com>
From:   Steven Price <steven.price@arm.com>
In-Reply-To: <20231102141507.73481-1-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/11/2023 14:15, AngeloGioacchino Del Regno wrote:
> The layout of the registers {TILER,SHADER,L2}_PWROFF_LO, used to request
> powering off cores, is the same as the {TILER,SHADER,L2}_PWRON_LO ones:
> this means that in order to request poweroff of cores, we are supposed
> to write a bitmask of cores that should be powered off!
> This means that the panfrost_gpu_power_off() function has always been
> doing nothing.
> 
> Fix powering off the GPU by writing a bitmask of the cores to poweroff
> to the relevant PWROFF_LO registers and then check that the transition
> (from ON to OFF) has finished by polling the relevant PWRTRANS_LO
> registers.
> 
> While at it, in order to avoid code duplication, move the core mask
> logic from panfrost_gpu_power_on() to a new panfrost_get_core_mask()
> function, used in both poweron and poweroff.
> 
> Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Thanks,

Steve

