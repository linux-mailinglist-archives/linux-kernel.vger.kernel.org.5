Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A21417D0A8F
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 10:32:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376481AbjJTIcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 04:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376433AbjJTIcA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 04:32:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98943112;
        Fri, 20 Oct 2023 01:31:58 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26E84C433C8;
        Fri, 20 Oct 2023 08:31:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697790718;
        bh=l9qV989JwaBiiJEzdeKJlntVo1EREOKiVHaZsdwHnJo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=odWlbFAl7nFcaG6RVc59qHHDTE03y7C5RVLLzVqY7BcsH/eKUuqi5QJqQkX+DjdwI
         MGqJeRYmQdvcSRri1kX3RgvV1r55817E6yF41wrXWIqo5pIlNcXsjKeToLo6uY9ABW
         UxYMUZ96W4r3EENLUZY8CALyLETey9uFMBhkT5xxUmU4VFoRszx+PMFQHFLkBjMIvT
         FW2cLYwr0ufo2kK6ijcppybmTvgPGluMjf7tr71bBpwCaB+vm4m9Ze9BXwgg4vIYP3
         Zt1UoOfGnJt/jHxIp1PFWjQADpaEJhQVF6FOdx/cdngfKLYmWDl9DectfttbwX66k6
         cWDca6gXppdOA==
Received: from johan by xi.lan with local (Exim 4.96)
        (envelope-from <johan@kernel.org>)
        id 1qtkvK-0001jy-13;
        Fri, 20 Oct 2023 10:32:03 +0200
Date:   Fri, 20 Oct 2023 10:32:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Krishna Kurapati <quic_kriskura@quicinc.com>
Cc:     Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        quic_pkondeti@quicinc.com, quic_ppratap@quicinc.com,
        quic_jackp@quicinc.com, ahalaney@redhat.com,
        quic_shazhuss@quicinc.com
Subject: Re: [PATCH v13 01/10] usb: dwc3: core: Access XHCI address space
 temporarily to read port info
Message-ID: <ZTI7AtCJWgAnACSh@hovoldconsulting.com>
References: <20231007154806.605-1-quic_kriskura@quicinc.com>
 <20231007154806.605-2-quic_kriskura@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231007154806.605-2-quic_kriskura@quicinc.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 07, 2023 at 09:17:57PM +0530, Krishna Kurapati wrote:
> Currently host-only capable DWC3 controllers support Multiport.

You use the word "currently" in a few places like this (e.g. in comments
in the code). What exactly do you mean? That all current multiport
controllers are host-only, or that this is all that the driver supports
after your changes?

Please rephrase accordingly throughout so that this becomes clear.

In any case it looks like the above sentence is at least missing an
"only".
 
> +static int dwc3_read_port_info(struct dwc3 *dwc)
> +{
> +	void __iomem *base;
> +	u8 major_revision;
> +	u32 offset = 0;

I'd move the initialisation just before the loop.

> +	u32 val;
> +
> +	/*
> +	 * Remap xHCI address space to access XHCI ext cap regs,

Drop comma and merge with next line and break it closer to 80 chars
(instead of 65).

> +	 * since it is needed to get port info.

s/since it is needed to get/which hold the/?

> +	 */
> +	base = ioremap(dwc->xhci_resources[0].start,
> +				resource_size(&dwc->xhci_resources[0]));
> +	if (IS_ERR(base))
> +		return PTR_ERR(base);
> +
> +	do {
> +		offset = xhci_find_next_ext_cap(base, offset,
> +				XHCI_EXT_CAPS_PROTOCOL);
> +		if (!offset)
> +			break;
> +
> +		val = readl(base + offset);
> +		major_revision = XHCI_EXT_PORT_MAJOR(val);
> +
> +		val = readl(base + offset + 0x08);
> +		if (major_revision == 0x03) {
> +			dwc->num_usb3_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else if (major_revision <= 0x02) {
> +			dwc->num_usb2_ports += XHCI_EXT_PORT_COUNT(val);
> +		} else {
> +			dev_err(dwc->dev,

This should be dev_warn() (as in the xhci driver) now that you no longer
treat it as a fatal error.

> +				"Unrecognized port major revision %d\n",

Merge this with the previous line (even if it makes that line 83 chars).

Use a lower case 'U' for consistency with most of the error messages.

> +							major_revision);
> +		}
> +	} while (1);
> +
> +	dev_dbg(dwc->dev, "hs-ports: %u ss-ports: %u\n",
> +			dwc->num_usb2_ports, dwc->num_usb3_ports);
> +
> +	iounmap(base);
> +
> +	return 0;
> +}
> +
>  static int dwc3_probe(struct platform_device *pdev)
>  {
>  	struct device		*dev = &pdev->dev;
> @@ -1846,6 +1892,7 @@ static int dwc3_probe(struct platform_device *pdev)
>  	void __iomem		*regs;
>  	struct dwc3		*dwc;
>  	int			ret;
> +	unsigned int		hw_mode;

Nit: I'd place this one before ret.

>  
>  	dwc = devm_kzalloc(dev, sizeof(*dwc), GFP_KERNEL);
>  	if (!dwc)
> @@ -1926,6 +1973,20 @@ static int dwc3_probe(struct platform_device *pdev)
>  			goto err_disable_clks;
>  	}
>  
> +	/*
> +	 * Currently only DWC3 controllers that are host-only capable
> +	 * support Multiport.
> +	 */

So is this is a limitation of the hardware or implementation?

> +	hw_mode = DWC3_GHWPARAMS0_MODE(dwc->hwparams.hwparams0);
> +	if (hw_mode == DWC3_GHWPARAMS0_MODE_HOST) {
> +		ret = dwc3_read_port_info(dwc);
> +		if (ret)
> +			goto err_disable_clks;
> +	} else {
> +		dwc->num_usb2_ports = 1;
> +		dwc->num_usb3_ports = 1;
> +	}
> +
>  	spin_lock_init(&dwc->lock);
>  	mutex_init(&dwc->mutex);

Johan
