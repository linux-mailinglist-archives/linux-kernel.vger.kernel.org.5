Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD1B7B17E3
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 11:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjI1JyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjI1JyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 05:54:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53EA3122
        for <linux-kernel@vger.kernel.org>; Thu, 28 Sep 2023 02:54:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0609CC433C8;
        Thu, 28 Sep 2023 09:54:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695894848;
        bh=Kj0SxZL7f2frf3BzU+23hjNt9BY8ETQvEskGUsbV/hs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gULcXwiUDniTb2iIJ5XPcTY87uGCuTkYI8R0xtBdMAmb9/eB2zqPZPBqjKv+nP7Pq
         kFh84pLK03Orf/m3c3SJvElUXGm6LvWu2mnOCvBziCJuxw4X+UPAGgp3eYyNHsBOnl
         TwIqXLIrlUjTHR+efpZdzbUQnEzumPxaueXH+iTNBB8ywkIwvFWEcVYIS/iAI+fM2F
         1Hw2Jch+qBOYVopFva0kci1f1iFrWsRPsmrdgX3BTHNlp2UI182Ssy2o25nc5XcYyk
         PjsMJ3W66VQEVV3Kz9/+6lQY1/+1B84YFuCyvMzWc/xTpR+HYz8JecxkKnBCePo78a
         fdqlMDb138uKQ==
Date:   Thu, 28 Sep 2023 17:53:55 +0800
From:   Peter Chen <peter.chen@kernel.org>
To:     Tomer Maimon <tmaimon77@gmail.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, xu.yang_2@nxp.com,
        peng.fan@nxp.com, avifishman70@gmail.com, tali.perry1@gmail.com,
        joel@jms.id.au, venture@google.com, yuenn@google.com,
        benjaminfair@google.com, j.neuschaefer@gmx.net,
        openbmc@lists.ozlabs.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 1/3] usb: chipidea: add
 CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag
Message-ID: <20230928095355.GA2081690@nchen-desktop>
References: <20230927095509.267029-1-tmaimon77@gmail.com>
 <20230927095509.267029-2-tmaimon77@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927095509.267029-2-tmaimon77@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-09-27 12:55:07, Tomer Maimon wrote:
> Adding CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS flag to modify the vbus_active
> parameter to active in case the ChipIdea USB IP role is device-only and
> there is no otgsc register.
> 
> Signed-off-by: Tomer Maimon <tmaimon77@gmail.com>

Acked-by: Peter Chen <peter.chen@kernel.org>

Peter
> ---
>  drivers/usb/chipidea/otg.c   | 5 ++++-
>  include/linux/usb/chipidea.h | 1 +
>  2 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/chipidea/otg.c b/drivers/usb/chipidea/otg.c
> index f5490f2a5b6b..647e98f4e351 100644
> --- a/drivers/usb/chipidea/otg.c
> +++ b/drivers/usb/chipidea/otg.c
> @@ -130,8 +130,11 @@ enum ci_role ci_otg_role(struct ci_hdrc *ci)
>  
>  void ci_handle_vbus_change(struct ci_hdrc *ci)
>  {
> -	if (!ci->is_otg)
> +	if (!ci->is_otg) {
> +		if (ci->platdata->flags & CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS)
> +			usb_gadget_vbus_connect(&ci->gadget);
>  		return;
> +	}
>  
>  	if (hw_read_otgsc(ci, OTGSC_BSV) && !ci->vbus_active)
>  		usb_gadget_vbus_connect(&ci->gadget);
> diff --git a/include/linux/usb/chipidea.h b/include/linux/usb/chipidea.h
> index 0b4f2d5faa08..5a7f96684ea2 100644
> --- a/include/linux/usb/chipidea.h
> +++ b/include/linux/usb/chipidea.h
> @@ -64,6 +64,7 @@ struct ci_hdrc_platform_data {
>  #define CI_HDRC_PMQOS			BIT(15)
>  #define CI_HDRC_PHY_VBUS_CONTROL	BIT(16)
>  #define CI_HDRC_HAS_PORTSC_PEC_MISSED	BIT(17)
> +#define CI_HDRC_FORCE_VBUS_ACTIVE_ALWAYS	BIT(18)
>  	enum usb_dr_mode	dr_mode;
>  #define CI_HDRC_CONTROLLER_RESET_EVENT		0
>  #define CI_HDRC_CONTROLLER_STOPPED_EVENT	1
> -- 
> 2.33.0
> 

-- 

Thanks,
Peter Chen
