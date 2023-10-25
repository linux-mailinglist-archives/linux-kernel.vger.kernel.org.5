Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FAF17D6B46
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 14:22:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbjJYMWp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 08:22:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343767AbjJYMWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 08:22:42 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 363469C;
        Wed, 25 Oct 2023 05:22:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD994C433C8;
        Wed, 25 Oct 2023 12:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1698236560;
        bh=FHGd6NpfB/B13XEZMLkAe39ErfCw2QU5DJd1J3NruBM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=C2yz81KLl+r9bAd6j0nYVV1FUAIOb7j/ADcabXK/5pQfccoWCGy0SfDP8Qxnkj8bU
         buzLByBay9Rt7Bh9VLsCrkU3ZIlS3YXnrgh+k/HkZjyElFzkmOVRu7CT8olxi3HzJ0
         VvfmH8oGBTs8RpPemIcUfzQOOsuqB/1zvhem0MjRRWoKmgGHdnPVynmN0owXtc61yd
         031HfnKxICkOMCHvWKk0IpYo43FvoU9pspwipKOhng8OBtpC3JZaMygNc4Id97lTer
         WKFfLvdd1yQeWAMk3q2YVQSfUse1B7eAPpj9ii3CPuAdfdez4GDpyN+l9zQ+pNiFEI
         kroFwE2kU4RbA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qvcua-0006E3-2o;
        Wed, 25 Oct 2023 14:23:00 +0200
Date:   Wed, 25 Oct 2023 14:23:00 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
        Simon Ser <contact@emersion.fr>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink: fix connector type to be
 DisplayPort
Message-ID: <ZTkIpMWpxKzSE7gQ@hovoldconsulting.com>
References: <20231010225229.77027-1-dmitry.baryshkov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010225229.77027-1-dmitry.baryshkov@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 01:52:29AM +0300, Dmitry Baryshkov wrote:
> As it was pointed out by Simon Ser, the DRM_MODE_CONNECTOR_USB connector
> is reserved for the GUD devices. Other drivers (i915, amdgpu) use
> DRM_MODE_CONNECTOR_DisplayPort even if the DP stream is handled by the
> USB-C altmode. While we are still working on implementing the proper way
> to let userspace know that the DP is wrapped into USB-C, change
> connector type to be DRM_MODE_CONNECTOR_DisplayPort.
> 
> Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
> Cc: Simon Ser <contact@emersion.fr>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 9569d999391d..6f8b2f7ae3cc 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -467,7 +467,7 @@ static int pmic_glink_altmode_probe(struct auxiliary_device *adev,
>  		alt_port->bridge.funcs = &pmic_glink_altmode_bridge_funcs;
>  		alt_port->bridge.of_node = to_of_node(fwnode);
>  		alt_port->bridge.ops = DRM_BRIDGE_OP_HPD;
> -		alt_port->bridge.type = DRM_MODE_CONNECTOR_USB;
> +		alt_port->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
>  
>  		ret = devm_drm_bridge_add(dev, &alt_port->bridge);
>  		if (ret) {

I was just going to post a patch fixing this after finally investigating
why the DisplayPort outputs on the X13s were annoyingly identified as
"Unknown20-1" and "Unknown20-2" instead of the expected "DP-1" and
"DP-2".

A lore search just before posting led me to this fix from two weeks ago.

I think the commit message should have mentioned something about the how
this change affects user space. My patch also had a CC stable, but I
guess we can ping the stable team once it hits mainline:

commit e5f55bf5ad4effdd59d4d06c839a0ac553a73c7d (HEAD -> work)
Author: Johan Hovold <johan+linaro@kernel.org>
Date:   Wed Oct 25 11:54:09 2023 +0200

    soc: qcom: pmic_glink_altmode: fix DP alt mode connector type
    
    The PMIC glink altmode bridge connector type should be "DisplayPort"
    rather than "USB", which is intended for custom USB display protocols
    (e.g. see 40e1a70b4aed ("drm: Add GUD USB Display driver")).
    
    This specifically makes the DisplayPort outputs on the Lenovo ThinkPad
    X13s show up as "DP-1" and "DP-2" rather than "Unknown20-1" and
    "Unknown20-2" with xrandr as expected (by users and tools):
    
      Screen 0: minimum 320 x 200, current 1920 x 1200, maximum 5120 x 4096
      eDP-1 connected primary 1920x1200+0+0 (normal left inverted right x axis y axis) 286mm x 178mm
         1920x1200     60.03*+
         1600x1200     60.00
      DP-1 disconnected (normal left inverted right x axis y axis)
      DP-2 connected (normal left inverted right x axis y axis)
         1920x1200     59.95 +
      ...
    
    Fixes: 080b4e24852b ("soc: qcom: pmic_glink: Introduce altmode support")
    Cc: stable@vger.kernel.org      # 6.3
    Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Johan
