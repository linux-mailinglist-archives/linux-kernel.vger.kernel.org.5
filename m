Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8A197C9DA5
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Oct 2023 05:14:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231392AbjJPDOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 Oct 2023 23:14:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229600AbjJPDOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Oct 2023 23:14:44 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55250AD;
        Sun, 15 Oct 2023 20:14:41 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C4DC433C7;
        Mon, 16 Oct 2023 03:14:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697426080;
        bh=rFqMwKFq9Dz3kjMPQAQOfxtqaUao3uw6W64/+UghC1I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m4MEuOQjhC7iLWsfok9s6vLGcg++TR8Wq+Vn6ANNNZf44jRX0MTh1VQBmcihwyksi
         e4agpUgiU7UF8HJYlnscc3oBZOEDjAwAan5AX6AVn+xow6zxydDdMkQVctO0WQamBQ
         tNcClkoBRxeMdV9qVbNlqqOO3QljZ8wXP9CtmnJE8tNefMq7M/x8fDXFVDaX+7A/uh
         Od4YEL0RIzCvk27wsLFxV2SaURY2vcOuVWn4oNt2BsO9SAA05eO15fJL5djZU6dKzF
         cj832W3qjwqu2WGqxMfbwOvVn3hHvvyoQ1ZF5GxpOc860ixfYqQ5vXDbZMVoqdUO9v
         LQb2A4jun+bSg==
Date:   Sun, 15 Oct 2023 20:18:29 -0700
From:   Bjorn Andersson <andersson@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: qcom: pmic_glink_altmode: Print error when retimer
 setup fails
Message-ID: <6fw7eho6rapvlghujche4k3pm5mx7a7ojx6yyyreq6dhzjfwlt@ggqoxgirpcnr>
References: <20231013-glink-altmode-ret-v1-1-77941537a35b@fairphone.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231013-glink-altmode-ret-v1-1-77941537a35b@fairphone.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 13, 2023 at 03:56:40PM +0200, Luca Weiss wrote:
> It can be useful to know with which return value the retimer_set call
> failed, so include this info in the dev_err print.
> 

Is this useful during development, or during normal execution etc. How
about using kretprobe or similar tools?


If you insist, could you please make sure that the style matches across
the various typec_*_set() calls in the driver?

Regards,
Bjorn

> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  drivers/soc/qcom/pmic_glink_altmode.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/soc/qcom/pmic_glink_altmode.c b/drivers/soc/qcom/pmic_glink_altmode.c
> index 9569d999391d..136713e1155e 100644
> --- a/drivers/soc/qcom/pmic_glink_altmode.c
> +++ b/drivers/soc/qcom/pmic_glink_altmode.c
> @@ -168,7 +168,7 @@ static void pmic_glink_altmode_enable_dp(struct pmic_glink_altmode *altmode,
>  
>  	ret = typec_retimer_set(port->typec_retimer, &port->retimer_state);
>  	if (ret)
> -		dev_err(altmode->dev, "failed to setup retimer to DP\n");
> +		dev_err(altmode->dev, "failed to setup retimer to DP: %d\n", ret);
>  }
>  
>  static void pmic_glink_altmode_enable_usb(struct pmic_glink_altmode *altmode,
> 
> ---
> base-commit: e3b18f7200f45d66f7141136c25554ac1e82009b
> change-id: 20231013-glink-altmode-ret-3911e6c1eab5
> 
> Best regards,
> -- 
> Luca Weiss <luca.weiss@fairphone.com>
> 
