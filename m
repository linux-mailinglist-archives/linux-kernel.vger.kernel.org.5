Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F339B76D588
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 19:36:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233613AbjHBRg2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 13:36:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232252AbjHBRgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 13:36:10 -0400
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73923C02
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 10:35:00 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5C82A86879;
        Wed,  2 Aug 2023 19:34:03 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690997644;
        bh=XwFK3L9YauS9V85jsvpUthDzNCzhrXp9TLJ01qFpdpU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=F1zPl7Yi2QzjoG/Sty7wipc8AbAV4wQ0mGJ8Lckm/jbAqpZyBnvVuVdecthVjtBVR
         EeJwHrwVa/6sEPRx9ScbS4XpPqYEkmAk1pHAVzibVsRtMRfvrZVoDESqyRgWNSq8n5
         vi0ZQ9myQ954PtewvN3YHZTQv+0LEbb1vCwfXegrXEcBN4oFx5CcG9eAlBKhBVddF7
         2OedU7DTsgBIyJXsc4rUKX5Mg5n/GU+o3/tJTYgNtTABF5sgypIXCKQv+EoL43EtDT
         MF9uU9Es0lAQ08tqUeUeW+TVRxeQEyXumyJCq+F/4HF1K6+ufQ27kIGz9/A7Ptgbl7
         XqhdtS74EaoqA==
Message-ID: <bf95af44-2510-1835-dec9-183144de8413@denx.de>
Date:   Wed, 2 Aug 2023 19:30:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
 <5cf0e3fa-f66d-06c4-cfda-c48efd8c6508@linaro.org>
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <5cf0e3fa-f66d-06c4-cfda-c48efd8c6508@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/2/23 15:38, Dmitry Baryshkov wrote:
> On 02/08/2023 11:52, Neil Armstrong wrote:
>> This reverts commit [1] to fix display regression on the Dragonboard 845c
>> (SDM845) devboard.
>>
>> There's a mismatch on the real action of the following flags:
>> - MIPI_DSI_MODE_VIDEO_NO_HSA
>> - MIPI_DSI_MODE_VIDEO_NO_HFP
>> - MIPI_DSI_MODE_VIDEO_NO_HBP
>> which leads to a non-working display on qcom platforms.
>>
>> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and 
>> EOT packet")
>>
>> Cc: Marek Vasut <marex@denx.de>
>> Cc: Robert Foss <rfoss@kernel.org>
>> Cc: Jagan Teki <jagan@amarulasolutions.com>
>> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
>> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA 
>> and EOT packet")
>> Reported-by: Amit Pundir <amit.pundir@linaro.org>
>> Link: 
>> https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
>>   drivers/gpu/drm/bridge/lontium-lt9611.c | 4 +---
>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>
> Acked-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org> #fix db845c
> 
> The boards broken by [1] are used in production by different parties 
> since 5.10, breaking them doesn't seem more acceptable than breaking the 
> new out-of-tree iMX8m hardware.

The MX8M is also in-tree, so this does not apply.
