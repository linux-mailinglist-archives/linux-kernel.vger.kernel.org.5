Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33E647C854E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Oct 2023 14:06:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjJMMFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Oct 2023 08:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231452AbjJMMFk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Oct 2023 08:05:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7C27CE;
        Fri, 13 Oct 2023 05:05:38 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67647C433C7;
        Fri, 13 Oct 2023 12:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697198738;
        bh=nzkUtLBqmirZ6m/6sa9MukyVECkrLso7I7MyMjnA/gA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=b35zLxn+F38/TILhl6VO9FmvMCSuPNzIzpLpZP/jSMd2JDh4SEwthFaIjP0ODkdO3
         HNLOXWKvywrH9gZ/vLIXaTGucPlEoeG/eUyM0U6zc0ZhQkKuxp+78PJyK0P0ePXx9z
         K3F3pnukV15Ld7Z+WWjcxRHnMXAJ9MQJoag8ODDaAyba7gAoRYV8FvipC5yvInrEDZ
         Foo1vxyJJ7zM8BqsXdVvr+wCHfCdIJIBjVEmyb8u4GYvuTLEy8IcB9NiL5Glk9O4XX
         b86ICOUpCa3IezU9mi3Oxv3HWhYpStHNMSMWnT8podKi7Aa4G3FmOdEV5UkHBL0i+5
         8vNXJdsdg4m0Q==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qrGvh-0000sd-1v;
        Fri, 13 Oct 2023 14:06:09 +0200
Date:   Fri, 13 Oct 2023 14:06:09 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, swboyd@chromium.org,
        dianders@chromium.org, vkoul@kernel.org, daniel@ffwll.ch,
        airlied@gmail.com, agross@kernel.org, dmitry.baryshkov@linaro.org,
        andersson@kernel.org, marijn.suijten@somainline.org,
        quic_abhinavk@quicinc.com, quic_jesszhan@quicinc.com,
        quic_sbillaka@quicinc.com, freedreno@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] drm/msm/dp: do not reinitialize phy unless retry
 during link training
Message-ID: <ZSkysaMcOQO89zpd@hovoldconsulting.com>
References: <1691533190-19335-1-git-send-email-quic_khsieh@quicinc.com>
 <ZRvaoz7CbNncM3t6@hovoldconsulting.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZRvaoz7CbNncM3t6@hovoldconsulting.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 11:10:59AM +0200, Johan Hovold wrote:
> On Tue, Aug 08, 2023 at 03:19:50PM -0700, Kuogee Hsieh wrote:
> > DP PHY re-initialization done using dp_ctrl_reinitialize_mainlink() will
> > cause PLL unlocked initially and then PLL gets locked at the end of
> > initialization. PLL_UNLOCKED interrupt will fire during this time if the
> > interrupt mask is enabled.
> > However currently DP driver link training implementation incorrectly
> > re-initializes PHY unconditionally during link training as the PHY was
> > already configured in dp_ctrl_enable_mainlink_clocks().
> > 
> > Fix this by re-initializing the PHY only if the previous link training
> > failed.
> > 
> > [drm:dp_aux_isr] *ERROR* Unexpected DP AUX IRQ 0x01000000 when not busy
> > 
> > Fixes: c943b4948b58 ("drm/msm/dp: add displayPort driver support")
> > Closes: https://gitlab.freedesktop.org/drm/msm/-/issues/30
> > Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> 
> This fixes the above warning and avoids the unnecessary PHY power-off
> and power-on during boot of the ThinkPad X13s:
> 
> Reviewed-by: Johan Hovold <johan+linaro@kernel.org>
> Tested-by: Johan Hovold <johan+linaro@kernel.org>
> 
> I guess this one should go to stable as well:
> 
> Cc: stable@vger.kernel.org	# 5.10
> 
> Is anyone planning on getting this fixed in 6.6-rc? I noticed that this
> one still hasn't shown up linux-next.

For the record, this one showed up in a PR from Rob and has now been
forwarded to Linus.

No stable tag included, but I guess we can ping the stable team unless
AUTOSEL picks this up.

Johan
