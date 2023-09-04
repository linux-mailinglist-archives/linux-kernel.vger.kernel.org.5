Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBC97911C0
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 09:05:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345916AbjIDHFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 03:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231300AbjIDHFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 03:05:00 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C76B11A;
        Mon,  4 Sep 2023 00:04:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693811097; x=1725347097;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4eDDWz5tkHMgCyvYqnj9aGELY6NXC+giySFujrhuh7w=;
  b=hL6saONAh1YAcrO+kVh2BAVmYxem35bYBKc0Slx0jjN7IAxF1g5zzIJl
   6PhMLr0tNcdyF0yhBLxWyC+c8dej3e7zS+8LzQT8xN7YDX2S5oKg1hH1/
   SaADx70ogY3Zx+kj0OP/JfEBOodCu+xTdxOJKBve/ixOB5Rzd+OHfPppt
   WTJD7eLysKoB4+Ermz6B2OfI22V6meqExYcvfbtO1XB1Q/lo28KcCfKYp
   /3NEu509fUzOh0W6LqQQNC6DEKlq3uvYVz+frN1T4w4KHUKhD8MfsIAsF
   o6FWi6yvcgAPPpXXSGSpkxMKU2eCPWG+XU1f4K49IHS472A08nls/5MA2
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="379247735"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="379247735"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 00:04:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="734222228"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="734222228"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 04 Sep 2023 00:04:52 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Sep 2023 10:04:51 +0300
Date:   Mon, 4 Sep 2023 10:04:51 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     quic_huliu@quicinc.com
Cc:     Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_fenglinw@quicinc.com,
        subbaram@quicinc.com
Subject: Re: [PATCH v5] usb: typec: qcom: Update the logic of regulator
 enable and disable
Message-ID: <ZPWBk0JRzJivItav@kuha.fi.intel.com>
References: <20230831-qcom-tcpc-v5-1-5e2661dc6c1d@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831-qcom-tcpc-v5-1-5e2661dc6c1d@quicinc.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 06:19:45PM +0800, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
> 
> Removed the call logic of disable and enable regulator
> in reset function. Enable the regulator in qcom_pmic_typec_start
> function and disable it in qcom_pmic_typec_stop function to
> avoid unbalanced regulator disable warnings.
> 
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Tested-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org> # rb5
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v5:
> - Removed Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> - Updated V4 history
> - Link to v4: https://lore.kernel.org/r/20230830-qcom-tcpc-v4-1-c19b0984879b@quicinc.com
> 
> Changes in v4:
> - Rephrased commit text
> - Link to v3: https://lore.kernel.org/r/20230828-qcom-tcpc-v3-1-e95b7afa34d9@quicinc.com
> 
> Changes in v3:
> - Take Bryan's proposal to remove enable/disable operation in pdphy
> enable and pdphy disable function, then enable regulator in pdphy start
> function and disable it in pdphy stop function.
> - Link to v2: https://lore.kernel.org/r/20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com
> 
> Changes in v2:
> - Add Fixes tag
> - Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index bb0b8479d80f..52c81378e36e 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -381,10 +381,6 @@ static int qcom_pmic_typec_pdphy_enable(struct pmic_typec_pdphy *pmic_typec_pdph
>  	struct device *dev = pmic_typec_pdphy->dev;
>  	int ret;
>  
> -	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
> -	if (ret)
> -		return ret;
> -
>  	/* PD 2.0, DR=TYPEC_DEVICE, PR=TYPEC_SINK */
>  	ret = regmap_update_bits(pmic_typec_pdphy->regmap,
>  				 pmic_typec_pdphy->base + USB_PDPHY_MSG_CONFIG_REG,
> @@ -422,8 +418,6 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
>  	ret = regmap_write(pmic_typec_pdphy->regmap,
>  			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>  
> -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> -
>  	return ret;
>  }
>  
> @@ -447,6 +441,10 @@ int qcom_pmic_typec_pdphy_start(struct pmic_typec_pdphy *pmic_typec_pdphy,
>  	int i;
>  	int ret;
>  
> +	ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
> +	if (ret)
> +		return ret;
> +
>  	pmic_typec_pdphy->tcpm_port = tcpm_port;
>  
>  	ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
> @@ -467,6 +465,8 @@ void qcom_pmic_typec_pdphy_stop(struct pmic_typec_pdphy *pmic_typec_pdphy)
>  		disable_irq(pmic_typec_pdphy->irq_data[i].irq);
>  
>  	qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
> +
> +	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
>  }
>  
>  struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device *dev)
> 
> ---
> base-commit: bbb9e06d2c6435af9c62074ad7048910eeb2e7bc
> change-id: 20230822-qcom-tcpc-d41954ac65fa
> 
> Best regards,
> -- 
> Hui Liu <quic_huliu@quicinc.com>

-- 
heikki
