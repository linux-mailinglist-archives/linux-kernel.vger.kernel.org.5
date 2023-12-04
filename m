Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF1880356F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:51:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344726AbjLDNux (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:50:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344854AbjLDNup (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:50:45 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC0FD135
        for <linux-kernel@vger.kernel.org>; Mon,  4 Dec 2023 05:50:50 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74557C433C8;
        Mon,  4 Dec 2023 13:50:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1701697850;
        bh=fsFu1k8Z5gwLxuCeGp27lPUgeerquZ+RKi0ABLqEljs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Q2tHwSN+wWn8UHYIA69m57D3iBC71gI5x8Pv1eEK43/eRjSFxlbPoyD96+QOH3oGd
         x0LHblC+pDkyrDJ06GPEDjlIzjTw8HTzxBPea4TaBkEJ1upSxdo2wAv84q/rhRsPF8
         RRivfL7Ve0W169YUbouf4mIY5DrAzJWybYfAcxcdwijnICYE/rgVBKrsrF6GAsnDHI
         Yvvw+hrRMEvvuaQqmxv0KRC8srVVRKcH5b8J21JPPoO5PuQrS7ZQIaZTnS7Y6hm0SD
         BQz75iDt5+3JDe9ltkNe8mM4LB7mbQhhOtoaMktj5RGBnR4ysL2fyixFtsz3C1SLVQ
         7lD++6S6e3Tbg==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1rA9MB-0003Ud-0P;
        Mon, 04 Dec 2023 14:51:31 +0100
Date:   Mon, 4 Dec 2023 14:51:31 +0100
From:   Johan Hovold <johan@kernel.org>
To:     srinivas.kandagatla@linaro.org
Cc:     broonie@kernel.org, alsa-devel@alsa-project.org, perex@perex.cz,
        tiwai@suse.com, linux-sound@vger.kernel.org,
        linux-kernel@vger.kernel.org, johan+linaro@kernel.org
Subject: Re: [PATCH 1/2] ASoC: ops: add correct range check for limiting
 volume
Message-ID: <ZW3ZY_2_G64dNAeS@hovoldconsulting.com>
References: <20231204124736.132185-1-srinivas.kandagatla@linaro.org>
 <20231204124736.132185-2-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204124736.132185-2-srinivas.kandagatla@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 12:47:35PM +0000, srinivas.kandagatla@linaro.org wrote:
> From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> 
> Volume can have ranges that start with negative values, ex: -84dB to
> +40dB. Apply correct range check in snd_soc_limit_volume before setting
> the platform_max. Without this patch, for example setting a 0dB limit on
> a volume range of -84dB to +40dB would fail.
> 
> Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Seems to work as intended with the following patch on the X13s:

Tested-by: Johan Hovold <johan+linaro@kernel.org>
Reviewed-by: Johan Hovold <johan+linaro@kernel.org>

Should you add a Fixes and CC-stable tag so we can get this backported
(at least to 6.5 for the X13s)?

Johan
