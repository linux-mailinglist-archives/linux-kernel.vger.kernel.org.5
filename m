Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D177792B79
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 19:08:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240926AbjIEQx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:53:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353713AbjIEH3C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:29:02 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A182912A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:28:58 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 010F875A;
        Tue,  5 Sep 2023 09:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1693898850;
        bh=YDBn83stNaIyB8qi40ouh5bQCgQ5cePLUssJVTBscBA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=glrpcfk66Xeaj4rD/X7cGTI3QLZznxGWzhXfktYs9PRo/v+M01AoA47sOKTUEhnhX
         F2CO4ObFlFKymwUcsBMwBxiUiV4wUUoUdE+gEOQPd0egI7dxDl2RMEGw9W6Pwu07hO
         DEX/9xJui3eNbpfl2JFusUv/lMhlyJilKj6t0LWw=
Message-ID: <139ce49f-43b4-928d-b11d-460917bf08bb@ideasonboard.com>
Date:   Tue, 5 Sep 2023 10:28:53 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 12/12] drm/bridge: tc358768: Attempt to fix DSI
 horizontal timings
Content-Language: en-US
To:     Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc:     "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "a-bhatia1@ti.com" <a-bhatia1@ti.com>,
        "Laurent.pinchart@ideasonboard.com" 
        <Laurent.pinchart@ideasonboard.com>,
        "andrzej.hajda@intel.com" <andrzej.hajda@intel.com>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "peter.ujfalusi@gmail.com" <peter.ujfalusi@gmail.com>,
        "rfoss@kernel.org" <rfoss@kernel.org>,
        "airlied@gmail.com" <airlied@gmail.com>,
        "francesco@dolcini.it" <francesco@dolcini.it>,
        "jonas@kwiboo.se" <jonas@kwiboo.se>,
        "jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>,
        "daniel@ffwll.ch" <daniel@ffwll.ch>,
        "maxim.schwalm@gmail.com" <maxim.schwalm@gmail.com>
References: <20230822-tc358768-v3-0-c82405dac0c1@ideasonboard.com>
 <20230822-tc358768-v3-12-c82405dac0c1@ideasonboard.com>
 <303db6b68b5cb4bc73cd0b8c190e3e92498caab3.camel@toradex.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <303db6b68b5cb4bc73cd0b8c190e3e92498caab3.camel@toradex.com>
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

On 04/09/2023 21:46, Marcel Ziswiler wrote:
> Hi Tomi
> 
> Looks good. Thanks! Tested both on Verdin AM62 as well as on Verdin iMX8M Mini.
> 
> Just a minor nit-pick in your code comment further below.
> 
> On Tue, 2023-08-22 at 19:19 +0300, Tomi Valkeinen wrote:
>> The DSI horizontal timing calculations done by the driver seem to often
>> lead to underflows or overflows, depending on the videomode.
>>
>> There are two main things the current driver doesn't seem to get right:
>> DSI HSW and HFP, and VSDly. However, even following Toshiba's
>> documentation it seems we don't always get a working display.
>>
>> This patch attempts to fix the horizontal timings for DSI event mode, and
>> on a system with a DSI->HDMI encoder, a lot of standard HDMI modes now
>> seem to work. The work relies on Toshiba's documentation, but also quite
>> a bit on empirical testing.
>>
>> This also adds timing related debug prints to make it easier to improve
>> on this later.
>>
>> The DSI pulse mode has only been tested with a fixed-resolution panel,
>> which limits the testing of different modes on DSI pulse mode. However,
>> as the VSDly calculation also affects pulse mode, so this might cause a
>> regression.
>>
>> Reviewed-by: Peter Ujfalusi <peter.ujfalusi@gmail.com>
>> Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
> 
> For the whole series:
> 
> Tested-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Thanks! I have fixed the typo in the comment.

  Tomi

