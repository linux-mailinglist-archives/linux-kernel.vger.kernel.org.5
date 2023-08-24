Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60809787238
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 16:50:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236664AbjHXOuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 10:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241871AbjHXOuD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 10:50:03 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C9251BD1;
        Thu, 24 Aug 2023 07:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692888582; x=1724424582;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3tTg481giqbc76ab24kf268IRG/D48d54DgtcclG/Nw=;
  b=VetZTP2IHBCUtTou9F6uVxmtsN8a9m7pdUUmGclc3FqjwdUVv1uHEAWA
   91UfQiN/xSmnd3V1COy/WhVQMhspO4J2J8kiIZANnUKfTIjq7JBhbv8hX
   EwEPwccvUuqd5Xxrut8sh23lrGO1NhroAoFP5grQ4S0EdAGC0ipqOLlhy
   VZoxBpolIw0XZXs6zMV+aq+8w0mR/yG9erGITDgS8x0WPLQkfsyLMsuTf
   +aUdPoDb/rQTxj0c8Z9DnDd0nFhGvqC5CaWnWgeCSuiTS1K9uDRgDZR1k
   V2bN1170E+Cbo1vDUo9TVnfA9mJLOqjSS9/4OPiRPjOZ5xhju6xROcEw1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="374424998"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="374424998"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Aug 2023 07:49:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="880835106"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 24 Aug 2023 07:49:35 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 24 Aug 2023 17:49:29 +0300
Date:   Thu, 24 Aug 2023 17:49:29 +0300
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
Message-ID: <ZOdt+dz7XXljFJcK@kuha.fi.intel.com>
References: <20230824-qcom-tcpc-v2-1-3dd8c3424564@quicinc.com>
 <ZOdlOQ+N2J7jyIEZ@kuha.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOdlOQ+N2J7jyIEZ@kuha.fi.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 24, 2023 at 05:12:14PM +0300, Heikki Krogerus wrote:
> On Thu, Aug 24, 2023 at 10:32:03AM +0800, Hui Liu via B4 Relay wrote:
> > From: Hui Liu <quic_huliu@quicinc.com>
> > 
> > Check regulator enable status before disabling it to avoid
> > unbalanced regulator disable warnings.
> > 
> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> > Fixes: a4422ff22142 ("usb: typec: qcom: Add Qualcomm PMIC Type-C driver")
> > Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> > Signed-off-by: Hui Liu <quic_huliu@quicinc.com>
> > ---
> > Changes in v2:
> > - Add Fixes tag
> > - Link to v1: https://lore.kernel.org/r/20230823-qcom-tcpc-v1-1-fa81a09ca056@quicinc.com
> > ---
> >  drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> > index bb0b8479d80f..ca616b17b5b6 100644
> > --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> > +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
> > @@ -422,7 +422,8 @@ static int qcom_pmic_typec_pdphy_disable(struct pmic_typec_pdphy *pmic_typec_pdp
> >  	ret = regmap_write(pmic_typec_pdphy->regmap,
> >  			   pmic_typec_pdphy->base + USB_PDPHY_EN_CONTROL_REG, 0);
> >  
> > -	regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> > +	if (regulator_is_enabled(pmic_typec_pdphy->vdd_pdphy))
> > +		regulator_disable(pmic_typec_pdphy->vdd_pdphy);
> 
> Would it be an option to just enable the regulator in
> qcom_pmic_typec_pdphy_start() and disable it in
> qcom_pmic_typec_pdphy_stop()?
> 
> Now the whole thing looks weird. That regulator is in practice
> only disabled and then enabled in one and the same place -
> pmic_typec_pdphy_reset(). It's not touched anywhere else. That makes
> the above condition confusing to me. I may be missing something.
> 
> At least more explanation is needed.

I took a closer look at these drivers, and I think I understand the
code path now. This driver is made with an assumption that the
regulator is "on" when the driver is probed, but in your case it's
actually "off".

So there is something wrong here, but I don't know where the root
cause is. If the regulator is really "on" when this driver is probed,
then there should be another user for it somewhere (no?). In that case
the driver can't just switch off the regulator like it does now - this
part I think really has to be fixed (or explained).

The problem with your fix is that it will leave the regulator always
on when the driver is removed, which it really can't do, not at least
if the regulator was off by default.

I would propose this:

diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
index bb0b8479d80f..bbe40634e821 100644
--- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
+++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec_pdphy.c
@@ -449,6 +449,10 @@ int qcom_pmic_typec_pdphy_start(struct pmic_typec_pdphy *pmic_typec_pdphy,
 
        pmic_typec_pdphy->tcpm_port = tcpm_port;
 
+       ret = regulator_enable(pmic_typec_pdphy->vdd_pdphy);
+       if (ret)
+               return ret;
+
        ret = pmic_typec_pdphy_reset(pmic_typec_pdphy);
        if (ret)
                return ret;
@@ -467,6 +471,7 @@ void qcom_pmic_typec_pdphy_stop(struct pmic_typec_pdphy *pmic_typec_pdphy)
                disable_irq(pmic_typec_pdphy->irq_data[i].irq);
 
        qcom_pmic_typec_pdphy_reset_on(pmic_typec_pdphy);
+       regulator_disable(pmic_typec_pdphy->vdd_pdphy);
 }
 
 struct pmic_typec_pdphy *qcom_pmic_typec_pdphy_alloc(struct device *dev)


The problem with it is that the regulator is not going to be disabled
if there really is another user for it when the component is expected
to be reset. But as said above, if there really is an other user, then
this driver simply can't just turn off the regulator.

thanks,

-- 
heikki
