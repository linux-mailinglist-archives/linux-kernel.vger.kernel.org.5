Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCB6B785970
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Aug 2023 15:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjHWNfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Aug 2023 09:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjHWNfR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Aug 2023 09:35:17 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EDAC8CDF;
        Wed, 23 Aug 2023 06:35:00 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B3361042;
        Wed, 23 Aug 2023 06:35:41 -0700 (PDT)
Received: from pluto (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A3CF73F740;
        Wed, 23 Aug 2023 06:34:58 -0700 (PDT)
Date:   Wed, 23 Aug 2023 14:34:55 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     AKASHI Takahiro <takahiro.akashi@linaro.org>,
        Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>,
        "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v4 3/4] pinctrl: Implementation of the generic
 scmi-pinctrl driver
Message-ID: <ZOYK_x6yc59pDwzA@pluto>
References: <cover.1691518313.git.oleksii_moisieiev@epam.com>
 <a6cefa60500cd46313ad6cda4f13f4985c0f5237.1691518314.git.oleksii_moisieiev@epam.com>
 <ZOWHWLVtKXwRug+Z@octopus>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZOWHWLVtKXwRug+Z@octopus>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 23, 2023 at 01:13:12PM +0900, AKASHI Takahiro wrote:
> Hi Oleksii,
> 

Hi AKASHI, Oleksii,

> On Tue, Aug 08, 2023 at 06:25:35PM +0000, Oleksii Moisieiev wrote:
> > scmi-pinctrl driver implements pinctrl driver interface and using
> > SCMI protocol to redirect messages from pinctrl subsystem SDK to
> > SCMI platform firmware, which does the changes in HW.
> > 
> > Signed-off-by: Oleksii Moisieiev <oleksii_moisieiev@epam.com>

[snip]

> > +static int pinctrl_scmi_pinconf_get(struct pinctrl_dev *pctldev, unsigned int _pin,
> > +				    unsigned long *config)
> > +{
> > +	int ret;
> > +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> > +	enum pin_config_param config_type;
> > +	unsigned long config_value;
> > +
> > +	if (!config)
> > +		return -EINVAL;
> > +
> > +	config_type = pinconf_to_config_param(*config);
> > +
> > +	ret = pinctrl_ops->config_get(pmx->ph, _pin, PIN_TYPE, config_type, &config_value);
> > +	if (ret)
> > +		return ret;
> > +
> > +	*config = pinconf_to_config_packed(config_type, config_value);
> > +
> > +	return 0;
> > +}
> > +
> > +static int pinctrl_scmi_pinconf_set(struct pinctrl_dev *pctldev,
> > +				    unsigned int _pin,
> > +				    unsigned long *configs,
> > +				    unsigned int num_configs)
> > +{
> > +	int i, ret;
> > +	struct scmi_pinctrl *pmx = pinctrl_dev_get_drvdata(pctldev);
> > +	enum pin_config_param config_type;
> > +	unsigned long config_value;
> > +
> > +	if (!configs || num_configs == 0)
> > +		return -EINVAL;
> > +
> > +	for (i = 0; i < num_configs; i++) {
> > +		config_type = pinconf_to_config_param(configs[i]);
> > +		config_value = pinconf_to_config_argument(configs[i]);
> 
> The generic pinconf parameters defined as "enum pin_config_param"
> do not exactly match with a set of SCMI's configuration types defined
> in Table 23 in the section 4.11.2.6 "PINCTRL_CONFIG_GET".
> pinconf_to_config_param() simply masks the lowest 8 bits of the input
> value, but doesn't convert anything.

Indeed the SCMI Types table and the Linux Pinctrl subsystem types are
similar but not really the same; some kind of conversion/mapping will be
needed.

Some trivial conversion layer will be needed also in order to address
here any of the possible future changes in the Linux pinctrl subsystem
definitions without having to change the SCMI server side
(that typically is fw...and that anyway is bound to the SCMI spec)

Thanks,
Cristian

