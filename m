Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7895978713D
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:15:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240038AbjHXOPM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:15:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241565AbjHXOPK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:15:10 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A776311F;
        Thu, 24 Aug 2023 07:15:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692886508; x=1724422508;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wcQ+gVUGq5WOqn3ov/A4s0pSgDZI8yKLZUkxLLEUoZ4=;
  b=Jyi4sok9ko9uFvllrCSPmS1N7wNa0ZnqVwKxM8HWGi8xnXf/vcEuuti2
   pd2Wg1jVSJqsyX9AP6R9TwZ9WM85mKVhHoTyAvqPAGbGkdiaVdw2Q7EHB
   asK9G8dwwOVGt8fCGI806pGrEzFLtcqZJwOVZrjTXO2kQlbhH1k1t072C
   9eZbyJJlhLbxOV91YbSOkIeKp/jrm4QWEJ1ogYSZOOBeRkyro53C2cE5k
   DzIJc73PjyhTaJsDN7gx+Vx6tYFM6cIr5l0KFSOl7CwrSHo+9ZeRSm7wk
   Wrshfm9zCoqRlfQizXXDw3RJv1058i5RQW2TdCsjI1NUzMknDBgcHecIL
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="440808204"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="440808204"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 07:12:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880827229"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2023 07:12:15 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 24 Aug 2023 17:12:09 +0300
Date:   Thu, 24 Aug 2023 17:12:09 +0300
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
Subject: Re: [PATCH v2] usb: typec: qcom: check regulator enable status
 before disabling it
Message-ID: <ZOdlOQ+N2J7jyIEZ@kuha.fi.intel.com>
References: <20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 10:32:03AM +0800, Hui Liu via B4 Relay wrote:
> From: Hui Liu <quic_huliu@quicinc.com>
> 
> Check regulator enable status before disabling it to avoid
> unbalanced regulator disable warnings.
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> ---
> Changes in v2:
> - Add Fixes tag
> - Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
> ---
>  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> index bb0b8479d80f..ca616b17b5b6 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> @@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
>  	ret = regmap_write(pmic_typec_pdphy->regmap,
>  			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
>  
> -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> +	if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
> +		regulator_disable(pmic_typec_pdphy->vdd_pdphy);

Would it be an option to just enable the regulator in
qcom_pmic_typec_pdphy_start() and disable it in
qcom_pmic_typec_pdphy_stop()?

Now the whole thing looks weird. That regulator is in practice
only disabled and then enabled in one and the same place -
pmic_typec_pdphy_reset(). It's not touched anywhere else. That makes
the above condition confusing to me. I may be missing something.

At least more explanation is needed.

thanks,

-- 
heikki
