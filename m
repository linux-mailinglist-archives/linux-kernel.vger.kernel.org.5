Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE6076CC49
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 14:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234008AbjHBMH1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 08:07:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbjHBMHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 08:07:25 -0400
Received: from phobos.denx.de (phobos.denx.de [IPv6:2a01:238:438b:c500:173d:9f52:ddab:ee01])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86181723
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 05:07:23 -0700 (PDT)
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: marex@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 5F7C38682A;
        Wed,  2 Aug 2023 14:07:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1690978041;
        bh=tidepDQNJKFb2bEzyOuLWMu6+CRRWW+nkmimxvon6nE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FOWJ5IH71vIVeen4MBi8HuQkhLbNnbkUJ88o0315ZDyST8jdKlivq5/LKIOnsVTiQ
         1lmK4/G0NDlnmvonpr/lpdzPpB3OSionRUJ0JRN+fiOLJtX1pHiop1r/1HHcakRHYw
         wD7ofyyn/+t4irldaCszLvf0eD0ZK82w/uR6NC5pr1qlgn3NacTmJaY0wkjydV+rvl
         bozEZhQar6NVsdxtWZPH2OJc5rYf+iKJtVf3Tlv97GBxiqbsK/ckHvyb1dPwgqLN0a
         Fz87jzH8G0y7hTPye9P5jUxaS9TcNqwBzdZu2mk9D+xulW0mYmv1Lelh7VPAB28a8I
         g/hHbq93t1Rew==
Message-ID: <6cd079a4-2f5b-0169-cbaf-b59a72f1b32b@denx.de>
Date:   Wed, 2 Aug 2023 14:07:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.1
Subject: Re: [PATCH] Revert "drm/bridge: lt9611: Do not generate HFP/HBP/HSA
 and EOT packet"
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Jagan Teki <jagan@amarulasolutions.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Amit Pundir <amit.pundir@linaro.org>
References: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
Content-Language: en-US
From:   Marek Vasut <marex@denx.de>
In-Reply-To: <20230802-revert-do-not-generate-hfp-hbp-hsa-eot-packet-v1-1-f8a20084e15a@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 8/2/23 10:52, Neil Armstrong wrote:
> This reverts commit [1] to fix display regression on the Dragonboard 845c
> (SDM845) devboard.
> 
> There's a mismatch on the real action of the following flags:
> - MIPI_DSI_MODE_VIDEO_NO_HSA
> - MIPI_DSI_MODE_VIDEO_NO_HFP
> - MIPI_DSI_MODE_VIDEO_NO_HBP
> which leads to a non-working display on qcom platforms.
> 
> [1] 8ddce13ae696 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Robert Foss <rfoss@kernel.org>
> Cc: Jagan Teki <jagan@amarulasolutions.com>
> Cc: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Cc: Abhinav Kumar <quic_abhinavk@quicinc.com>
> Fixes: 8ddce13ae69 ("drm/bridge: lt9611: Do not generate HFP/HBP/HSA and EOT packet")
> Reported-by: Amit Pundir <amit.pundir@linaro.org>
> Link: https://lore.kernel.org/r/CAMi1Hd0TD=2z_=bcDrht3H_wiLvAFcv8Z-U_r_KUOoeMc6UMjw@mail.gmail.com/
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>

This breaks LT9611 operation on i.MX8M Mini/Nano/Plus, so, NAK.

I am currently using this LT9611 with Linux 6.1.y in production and this 
is not acceptable. I also believe the correct fix is on the MSM side, 
not on the LT9611 driver side, since MSM incorrectly implements these flags.
