Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE7B079E778
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Sep 2023 14:02:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240025AbjIMMCi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 08:02:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239632AbjIMMCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 08:02:36 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9CE19AC;
        Wed, 13 Sep 2023 05:02:32 -0700 (PDT)
Received: from [192.168.88.20] (91-154-35-171.elisa-laajakaista.fi [91.154.35.171])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D9911BEB;
        Wed, 13 Sep 2023 14:00:58 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1694606459;
        bh=cswXhRm1e1DcA5shIZXc+UdI9/fAUQAb3D1e4uW/sS4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=D0s47RcRZq5Dle5bWezeRXWqB2YlSXsj8GyHlBQcINOj2NEqKt+qy9MtXPPLdYfCU
         ai3SewP2FH7mo25fxHBCodpG24BOq+Qlx/i+JkWxHFr4eh5R7lym5JxOMuDTi+We1M
         XRu5RxyQGEQNR34PN/tV6PMMDW1ADtKFFGkC0PkQ=
Message-ID: <0cd10461-aff1-9302-3d36-dd2ba609195a@ideasonboard.com>
Date:   Wed, 13 Sep 2023 15:02:28 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH] drm/omap: dsi: Fix deferred probe warnings
Content-Language: en-US
To:     Tony Lindgren <tony@atomide.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Sebastian Reichel <sre@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230412073954.20601-1-tony@atomide.com>
 <20230412085044.GP11253@pendragon.ideasonboard.com>
 <2bf56c04-733b-24a5-a344-166a94cd51f7@ideasonboard.com>
 <20230412085926.GR11253@pendragon.ideasonboard.com>
 <20230913073755.GE5285@atomide.com>
From:   Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20230913073755.GE5285@atomide.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2023 10:37, Tony Lindgren wrote:
> * Laurent Pinchart <laurent.pinchart@ideasonboard.com> [230412 11:59]:
>> On Wed, Apr 12, 2023 at 11:55:34AM +0300, Tomi Valkeinen wrote:
>>> On 12/04/2023 11:50, Laurent Pinchart wrote:
>>>> Hi Tony,
>>>>
>>>> Thank you for the patch.
>>>>
>>>> On Wed, Apr 12, 2023 at 10:39:53AM +0300, Tony Lindgren wrote:
>>>>> We may not have dsi->dsidev initialized during probe, and that can
>>>>> lead into various dsi related warnings as omap_dsi_host_detach() gets
>>>>> called with dsi->dsidev set to NULL.
>>>>>
>>>>> The warnings can be "Fixed dependency cycle(s)" followed by a
>>>>> WARNING: CPU: 0 PID: 787 at drivers/gpu/drm/omapdrm/dss/dsi.c:4414.
>>>>
>>>> How can this happen ? I assume .detach() can't be called without a
>>>> priori successful call to .attach(), that that sets dsi->dsidev.
>>>
>>> I had a quick look, and the driver calls mipi_dsi_host_register() in
>>> probe, and mipi_dsi_host_unregister() in remove.
>>>
>>> mipi_dsi_host_unregister() always calls mipi_dsi_detach(), but I don't
>>> think mipi_dsi_host_register() always calls attach, which happens later
>>> when the peripheral probes.
>>
>> Is this something that should be addressed in the DRM MIPI DSI helpers,
>> to only detach after an attach ?
> 
> Tomi, any comments on detach after attach?

I sent a comment to the patch.

As Laurent said, I think this really should be fixed in the framework 
side. Calling detach in drivers without attach feels just plain wrong.

However, I don't see any harm in the patch (but perhaps some changes 
needed as per my comments), and it will fix the issue for omapdrm, until 
someone has the time and energy to look at a real fix.

  Tomi

