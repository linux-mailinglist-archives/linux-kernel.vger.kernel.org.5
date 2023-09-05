Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C06B1792ABC
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239656AbjIEQli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353712AbjIEH2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:28:18 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 346E212A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:28:14 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 6288C75A;
        Tue,  5 Sep 2023 09:26:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693898804;
        bh=VvDgO6WZIfHOJ92ePZGwc+GLxQLF0SWCV70ytox5Eek=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=LHED6sbchNDoIDVWxX4KRrgFHIp1urqvbNZIoKYb/1StTpG6Ryw0FVAtRsxqtdGzb
         X9OSwF/0Ke0eeYCJ8m7ciw3nbOejloDsAmnteuUDgDItVjjMBo+P0+vatR7xB/+I3k
         rwwBIItumpmC+NtV+XCpdL55dW991IT74BIzPgjI=
Message-ID: <9c04a6f0-d7ec-6efd-7b33-774ce4d5548d@ideasonboard.com>
Date:   Tue, 5 Sep 2023 10:28:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/4] drm/bridge: lt8912b: Manually disable HPD only if it
 was enabled
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        Stefan Eichenberger <stefan.eichenberger@toradex.com>,
        "adrien.grassein@gmail.com" <adrien.grassein@gmail.com>,
        "rfoss@kernel.org" <rfoss@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>
References: <20230804-lt8912b-v1-0-c542692c6a2f@ideasonboard.com>
 <20230804-lt8912b-v1-3-c542692c6a2f@ideasonboard.com>
 <cb069b10a38b018868f370fada3e97da7257264b.camel@toradex.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <cb069b10a38b018868f370fada3e97da7257264b.camel@toradex.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 21:08, Marcel Ziswiler wrote:
> Hi Tomi
> 
> Looks good. Thanks! Tested both on Verdin AM62 as well as on Verdin iMX8M Mini.
> 
> Just a minor nit-pick in your commit message.
> 
> On Fri, 2023-08-04 at 13:48 +0300, Tomi Valkeinen wrote:
>> lt8912b only calls drm_bridge_hpd_enable() if it creates a connector and
>> the next bridge has DRM_BRIDGE_OP_HPD set. However, when calling
>> drm_bridge_hpd_disable() it misses checking if a connector was created,
>> calling drm_bridge_hpd_disable() even if HPD was nenver enabled. I don't
> 
> was never enabled
> 
>> see any issues causing by this wrong call, though.
> 
> any issues caused by this wrong call
> 
>> Add the check to avoid wrongly calling drm_bridge_hpd_disable().
>>
>> Fixes: 3b0a01a6a522 ("drm/bridge: lt8912b: Add hot plug detection")
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> For the whole series:
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Thanks! I have fixed the typos in the desc.

  Tomi

