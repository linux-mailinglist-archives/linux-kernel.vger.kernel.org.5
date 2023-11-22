Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE957F45AA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:18:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344081AbjKVMSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344021AbjKVMSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:18:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E478D4A
        for <linux-kernel@vger.kernel.org>; Wed, 22 Nov 2023 04:18:19 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24FB6C433C8;
        Wed, 22 Nov 2023 12:18:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1700655499;
        bh=3PecfwOd2IAznuwvH/QmZLOkNifAzul2CXHZqkNhl/o=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OYCefLpTk3Bjc88e7qGYwpRSdOgQ5hWAldH/c73Mc44vPlbj9Q76O79itu6+8dddK
         Z5yMd/3FJ1jtmmv8w3L4ZUNVlAyHFj7MFpkxKrWMEiqGODusLKhlyNcJDRNtW7LJkB
         jPGf/e/kq2/hCGAq03ihYr96u9NY2JPUYc2wffxeMmue+N5bZPEoRYfQ8aYqKbSoHS
         7JBZEIZJlE+rqVCTtMLIJdUyHeVxF/MPFaaQPRatBh5v2NEkZWIThvvRE2kdc2HTms
         J+4M4Y0hi0v4Ca7x3AwpuQr9G5FGTEizbVtIXtYoAlhS0X+Jwg/I5FsIYG39w32s0O
         YNtys2WtFep2g==
Received: from johan by xi.lan with local (Exim 4.96.2)
        (envelope-from <johan@kernel.org>)
        id 1r5mBd-0000A8-2v;
        Wed, 22 Nov 2023 13:18:33 +0100
Date:   Wed, 22 Nov 2023 13:18:33 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Felipe Balbi <balbi@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krishna Kurapati PSSNV <quic_kriskura@quicinc.com>
Subject: Re: [PATCH 06/12] usb: dwc3: qcom: Add dwc3 core reference in driver
 state
Message-ID: <ZV3xmW0fDWY5-6qZ@hovoldconsulting.com>
References: <20231016-dwc3-refactor-v1-0-ab4a84165470@quicinc.com>
 <20231016-dwc3-refactor-v1-6-ab4a84165470@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231016-dwc3-refactor-v1-6-ab4a84165470@quicinc.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2023 at 08:11:14PM -0700, Bjorn Andersson wrote:
> In the coming changes the Qualcomm DWC3 glue will be able to either
> manage the DWC3 core as a child platform_device, or directly instantiate
> it within its own context.
> 
> Introduce a reference to the dwc3 core state and make the driver
> reference the dwc3 core either the child device or this new reference.
> 
> As the new member isn't assigned, and qcom->dwc_dev is assigned in all
> current cases, the change should have no functional impact.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
>  drivers/usb/dwc3/dwc3-qcom.c | 100 +++++++++++++++++++++++++++++++++++--------
>  1 file changed, 83 insertions(+), 17 deletions(-)
> 
> diff --git a/drivers/usb/dwc3/dwc3-qcom.c b/drivers/usb/dwc3/dwc3-qcom.c
> index 7c810712d246..901e5050363b 100644
> --- a/drivers/usb/dwc3/dwc3-qcom.c
> +++ b/drivers/usb/dwc3/dwc3-qcom.c
> @@ -67,7 +67,8 @@ struct dwc3_acpi_pdata {
>  struct dwc3_qcom {
>  	struct device		*dev;
>  	void __iomem		*qscratch_base;
> -	struct platform_device	*dwc_dev;
> +	struct platform_device	*dwc_dev; /* only used when core is separate device */
> +	struct dwc3		*dwc; /* not used when core is separate device */

Hmm. This quickly become really messy and hard to maintain. It may be
fine as an intermediate step as part of this series, but why can't you
do the conversion fully so that the Qualcomm glue driver never registers
a core platform device? Is it just about where the core driver looks for
DT properties?

Johan
