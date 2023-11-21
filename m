Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1723E7F308D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 15:20:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234256AbjKUOUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 09:20:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbjKUOUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 09:20:11 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01A9D7E;
        Tue, 21 Nov 2023 06:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700576406; x=1732112406;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N0wFReOzgNDh2Uw8c3ueRDTaTSNzFrAmGUI7D1PGMVM=;
  b=kkQgLeMVL7RTSonUefRoFXrx9FUnD3NYCWnOfH3lEAWr7xeMpKt/X8oS
   L0NGI7Vo31zC7yhaF4dkS4AeWOMQzPn11BunuTRDAH7Ei9Iqbql6Fil9V
   y0k91fV38Sb/0WDUh6bQGc/TQ8UlWlaLAMvm7lEWNV06nX49UTBuLk8fU
   Ux4HdDP2RDtadtJgYOgCdM+P1vEVK9FezWeOLxp4RC/bGALUSU1KW5U21
   9vqkE8j7DscKjVXvWdM8Gcc3mqA9pSGhz+0YjVBT4KjdaP25gEcwuGhH9
   qckU/paRKcBu4E61axGT1GsS9Q3Hi79eU/irjZ5Ns9aWaG2/A8BTm2AeP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="372022143"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="372022143"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 06:20:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="760114797"
X-IronPort-AV: E=Sophos;i="6.04,215,1695711600"; 
   d="scan'208";a="760114797"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 21 Nov 2023 06:20:01 -0800
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 21 Nov 2023 16:20:00 +0200
Date:   Tue, 21 Nov 2023 16:20:00 +0200
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH 2/3] USB: dwc3: qcom: fix software node leak on probe
 errors
Message-ID: <ZVy7z5ZAm+IqzvM/@kuha.fi.intel.com>
References: <20231117173650.21161-1-johan+linaro@kernel.org>
 <20231117173650.21161-3-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231117173650.21161-3-johan+linaro@kernel.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 17, 2023 at 06:36:49PM +0100, Johan Hovold wrote:
> Make sure to remove the software node also on (ACPI) probe errors to
> avoid leaking the underlying resources.
> 
> Note that the software node is only used for ACPI probe so the driver
> unbind tear down is updated to match probe.
> 
> Fixes: 8dc6e6dd1bee ("usb: dwc3: qcom: Constify the software node")
> Cc: stable@vger.kernel.org      # 5.12
> Cc: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 00c3021b43ce..0703f9b85cda 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -932,10 +932,12 @@ static int dwc3_qcom_probe(struct platform_device *pdev)
>  interconnect_exit:
>  	dwc3_qcom_interconnect_exit(qcom);
>  depopulate:
> -	if (np)
> +	if (np) {
>  		of_platform_depopulate(&pdev->dev);
> -	else
> +	} else {
> +		device_remove_software_node(&qcom->dwc3->dev);
>  		platform_device_del(qcom->dwc3);
> +	}
>  	platform_device_put(qcom->dwc3);
>  clk_disable:
>  	for (i = qcom->num_clocks - 1; i >= 0; i--) {
> @@ -955,11 +957,12 @@ static void dwc3_qcom_remove(struct platform_device *pdev)
>  	struct device *dev = &pdev->dev;
>  	int i;
>  
> -	device_remove_software_node(&qcom->dwc3->dev);
> -	if (np)
> +	if (np) {
>  		of_platform_depopulate(&pdev->dev);
> -	else
> +	} else {
> +		device_remove_software_node(&qcom->dwc3->dev);
>  		platform_device_del(qcom->dwc3);
> +	}
>  	platform_device_put(qcom->dwc3);
>  
>  	for (i = qcom->num_clocks - 1; i >= 0; i--) {
> -- 
> 2.41.0

-- 
heikki
